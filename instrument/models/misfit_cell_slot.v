// SPDX-License-Identifier: Apache-2.0
// BEHAVIOURAL STAND-IN for a cell slot. Simulation only. It emulates the contract of ../INTERFACES.md and nothing else:
// no supply, no leakage, no coupling between slots, no temperature. A fault set here is a fault of the protocol's
// input, not a physical short. Times are in ns and are set by the testbench; 0 means "never discharges".
`timescale 1ns/1ps
`default_nettype none
module misfit_cell_slot (
  input  wire       en,
  input  wire       pre,
  input  wire [1:0] src,
  output wire       xa,
  output wire       xb
);
  reg [31:0] t_cell_a_ns = 0, t_cell_b_ns = 0;   // src = 1: the cell and its twin
  reg [31:0] t_cal_ns    = 0;                    // src = 2: calibration current, both sides
  reg [31:0] t_ref_ns    = 0;                    // src = 3: reference capacitor, both sides
  reg [1:0]  fault_a = 0, fault_b = 0;           // 0 none, 1 stuck high, 2 stuck low, 3 unknown (X)
  reg        ignore_en = 0;                      // 1: the slot misbehaves even when disabled

  reg        ra = 0, rb = 0;
  reg [31:0] tok = 0, sa = 0, sb = 0;
  reg [31:0] da, db;
  always @(negedge pre) if (en) begin
    tok = tok + 1;
    case (src)
      2'd1: begin da = t_cell_a_ns; db = t_cell_b_ns; end
      2'd2: begin da = t_cal_ns;    db = t_cal_ns;    end
      2'd3: begin da = t_ref_ns;    db = t_ref_ns;    end
      default: begin da = 0; db = 0; end
    endcase
    if (da != 0) sa <= #(da) tok;
    if (db != 0) sb <= #(db) tok;
  end
  always @(sa) if (sa == tok && !pre && en) ra = 1'b1;   // a stale schedule (aborted run) carries an old token
  always @(sb) if (sb == tok && !pre && en) rb = 1'b1;
  always @(posedge pre or negedge en) begin ra = 1'b0; rb = 1'b0; tok = tok + 1; end

  wire live = en | ignore_en;
  assign xa = !live ? 1'b0 : (fault_a == 2'd1) ? 1'b1 : (fault_a == 2'd2) ? 1'b0 : (fault_a == 2'd3) ? 1'bx : ra;
  assign xb = !live ? 1'b0 : (fault_b == 2'd1) ? 1'b1 : (fault_b == 2'd2) ? 1'b0 : (fault_b == 2'd3) ? 1'bx : rb;
endmodule
`default_nettype wire
