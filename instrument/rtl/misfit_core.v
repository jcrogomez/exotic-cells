// SPDX-License-Identifier: Apache-2.0
// MISFIT shared instrument, digital core. No analog here: everything a cell does reaches this block as the edge of a
// digital-level signal (xa, xb), and is turned into a count of clock cycles.
// Register map, flags and the slot contract: ../INTERFACES.md
`default_nettype none
module misfit_core #(
  parameter N = 4                      // number of cell slots (1..7); channel 7 is the internal digital reference
) (
  input  wire         clk,
  input  wire         rst_n,
  // host side
  input  wire [3:0]   addr,
  input  wire         wr,              // level; a write happens on its rising edge
  input  wire [7:0]   wdata,
  output reg  [7:0]   rdata,
  output wire         busy,
  output wire         done,
  // slot side
  output wire [N-1:0]   slot_en,       // 0 = the slot must be electrically inert
  output wire [N-1:0]   slot_pre,      // 1 = precharge the measured node(s)
  output wire [2*N-1:0] slot_src,      // per slot: 0 none, 1 cell, 2 calibration current, 3 reference capacitor
  input  wire [N-1:0]   slot_xa,       // rises when node A has discharged (asynchronous)
  input  wire [N-1:0]   slot_xb        // same for the twin B
);
  localparam [7:0] ID = 8'h4D;
  localparam [1:0] S_IDLE = 2'd0, S_PRE = 2'd1, S_COUNT = 2'd2;

  // ---- protocol: synchronise wr, detect its rising edge ------------------------------------------------------------
  reg [2:0] wr_s;
  always @(posedge clk or negedge rst_n)
    if (!rst_n) wr_s <= 3'b000; else wr_s <= {wr_s[1:0], wr};
  wire wr_pulse = wr_s[1] & ~wr_s[2];

  // ---- registers ---------------------------------------------------------------------------------------------------
  reg        arm, dual, twin;
  reg [2:0]  chsel;
  reg [1:0]  src;
  reg [N-1:0] enmask;
  reg [4:0]  tmo;
  reg [7:0]  refdly, prew;
  reg        f_done, f_tmo_a, f_tmo_b, f_stuck_a, f_stuck_b, f_refused;
  reg [23:0] count_a, count_b;
  reg [1:0]  state;

  wire cmd_wr    = wr_pulse && (addr == 4'h6);
  wire cmd_start = cmd_wr && wdata[0];
  wire cmd_abort = cmd_wr && wdata[1];
  wire cmd_clear = cmd_wr && wdata[2];

  always @(posedge clk or negedge rst_n)
    if (!rst_n) begin
      arm <= 1'b0; dual <= 1'b0; twin <= 1'b0; chsel <= 3'd0; src <= 2'd0;
      enmask <= {N{1'b0}}; tmo <= 5'd16; refdly <= 8'd16; prew <= 8'd3;
    end else if (wr_pulse && state == S_IDLE) begin      // configuration is frozen while a measurement runs
      case (addr)
        4'h1: {twin, dual, arm} <= wdata[2:0];
        4'h2: chsel  <= wdata[2:0];
        4'h3: src    <= wdata[1:0];
        4'h4: enmask <= wdata[N-1:0];
        4'h5: tmo    <= (wdata[4:0] > 5'd24) ? 5'd24 : wdata[4:0];
        4'hE: refdly <= wdata;
        4'hF: prew   <= wdata;
        default: ;
      endcase
    end else if (wr_pulse && addr == 4'h1 && !wdata[0]) begin
      arm <= 1'b0;                                       // disarming is always accepted
    end

  wire [7:0] status = {arm, f_refused, f_stuck_b, f_stuck_a, f_tmo_b, f_tmo_a, f_done, (state != S_IDLE)};
  always @(posedge clk or negedge rst_n)
    if (!rst_n) rdata <= 8'h00;
    else case (addr)
      4'h0: rdata <= ID;
      4'h1: rdata <= {5'b0, twin, dual, arm};
      4'h2: rdata <= {5'b0, chsel};
      4'h3: rdata <= {6'b0, src};
      4'h4: rdata <= {{(8-N){1'b0}}, enmask};
      4'h5: rdata <= {3'b0, tmo};
      4'h7: rdata <= status;
      4'h8: rdata <= count_a[7:0];
      4'h9: rdata <= count_a[15:8];
      4'hA: rdata <= count_a[23:16];
      4'hB: rdata <= count_b[7:0];
      4'hC: rdata <= count_b[15:8];
      4'hD: rdata <= count_b[23:16];
      4'hE: rdata <= refdly;
      4'hF: rdata <= prew;
      default: rdata <= 8'h00;
    endcase

  // ---- channel selection and fault isolation -----------------------------------------------------------------------
  wire is_ref  = (chsel == 3'd7);
  reg  en_sel;
  integer k;
  always @* begin en_sel = 1'b0; for (k = 0; k < N; k = k + 1) if (chsel == k) en_sel = enmask[k]; end
  wire ch_ok   = is_ref || en_sel;
  wire use_a   = is_ref || dual || !twin;
  wire use_b   = !is_ref && (dual || twin);

  genvar g;
  generate for (g = 0; g < N; g = g + 1) begin : sl
    wire sel = (chsel == g) && (state != S_IDLE);
    assign slot_en[g]              = arm & enmask[g];
    assign slot_pre[g]             = slot_en[g] & sel & (state == S_PRE);
    assign slot_src[2*g+1:2*g]     = (slot_en[g] & sel) ? src : 2'd0;
  end endgenerate

  // A disabled or unselected slot cannot reach the engine, whatever its outputs do (stuck, floating, oscillating).
  reg xa_mux, xb_mux;
  integer i;
  always @* begin
    xa_mux = 1'b0; xb_mux = 1'b0;
    for (i = 0; i < N; i = i + 1)
      if (chsel == i && slot_en[i]) begin xa_mux = slot_xa[i]; xb_mux = slot_xb[i]; end
  end
  reg [1:0] xa_s, xb_s;
  always @(posedge clk or negedge rst_n)
    if (!rst_n) begin xa_s <= 2'b00; xb_s <= 2'b00; end
    else begin xa_s <= {xa_s[0], xa_mux}; xb_s <= {xb_s[0], xb_mux}; end

  // ---- measurement engine ------------------------------------------------------------------------------------------
  reg [23:0] t;
  reg [11:0] pcnt;
  reg        a_run, b_run;
  wire [24:0] limit   = 25'd1 << tmo;
  wire        ref_hit = (t >= {12'd0, refdly, 4'd0});
  wire        xa_eff  = is_ref ? ref_hit : xa_s[1];
  wire        xb_eff  = xb_s[1];
  wire        expired = ({1'b0, t} + 25'd1 >= limit);

  always @(posedge clk or negedge rst_n)
    if (!rst_n) begin
      state <= S_IDLE; t <= 24'd0; pcnt <= 12'd0; a_run <= 1'b0; b_run <= 1'b0;
      count_a <= 24'd0; count_b <= 24'd0;
      f_done <= 1'b0; f_tmo_a <= 1'b0; f_tmo_b <= 1'b0; f_stuck_a <= 1'b0; f_stuck_b <= 1'b0; f_refused <= 1'b0;
    end else begin
      if (cmd_clear && state == S_IDLE)
        {f_done, f_tmo_a, f_tmo_b, f_stuck_a, f_stuck_b, f_refused} <= 6'b0;
      case (state)
        S_IDLE: if (cmd_start) begin
          if (arm && ch_ok) begin
            state <= S_PRE; pcnt <= {prew, 4'hF}; t <= 24'd0;
            count_a <= 24'd0; count_b <= 24'd0;
            {f_done, f_tmo_a, f_tmo_b, f_stuck_a, f_stuck_b, f_refused} <= 6'b0;
          end else begin
            f_refused <= 1'b1; f_done <= 1'b0;
          end
        end
        S_PRE: begin
          if (cmd_abort || !arm) state <= S_IDLE;
          else if (pcnt == 12'd0) begin
            // A node that reads "discharged" while it is being precharged cannot be measured.
            f_stuck_a <= use_a & ~is_ref & xa_s[1];
            f_stuck_b <= use_b & xb_s[1];
            a_run <= use_a & (is_ref | ~xa_s[1]);
            b_run <= use_b & ~xb_s[1];
            state <= S_COUNT;
          end else pcnt <= pcnt - 12'd1;
        end
        S_COUNT: begin
          t <= t + 24'd1;
          if (a_run && xa_eff) begin count_a <= t; a_run <= 1'b0; end
          if (b_run && xb_eff) begin count_b <= t; b_run <= 1'b0; end
          if (cmd_abort || !arm) begin
            a_run <= 1'b0; b_run <= 1'b0; state <= S_IDLE;
          end else if (!(a_run && !xa_eff) && !(b_run && !xb_eff)) begin
            f_done <= 1'b1; state <= S_IDLE;
          end else if (expired) begin
            f_tmo_a <= a_run && !xa_eff; f_tmo_b <= b_run && !xb_eff;
            a_run <= 1'b0; b_run <= 1'b0;
            f_done <= 1'b1; state <= S_IDLE;
          end
        end
        default: state <= S_IDLE;
      endcase
    end

  assign busy = (state != S_IDLE);
  assign done = f_done;
endmodule
`default_nettype wire
