// SPDX-License-Identifier: Apache-2.0
// MISFIT-08: cycle-by-cycle equivalence of rtl/misfit_core.v (ref) and the lean variant (dut) under the same random stimulus.
// Plusargs: +seed=N +cycles=N. Prints one line "EQ seed cycles mism meas tmo abort cntrd dual".
`timescale 1ns/1ps
module eq_tb;
  localparam N = 4;
  reg clk = 0, rst_n = 0; reg [3:0] addr = 0; reg wr = 0; reg [7:0] wdata = 0; reg [N-1:0] xa = 0, xb = 0;
  wire [7:0] r0, r1; wire b0, b1, d0, d1; wire [N-1:0] en0, en1, pre0, pre1; wire [2*N-1:0] src0, src1;
  misfit_core      #(.N(N)) gold (.clk(clk), .rst_n(rst_n), .addr(addr), .wr(wr), .wdata(wdata), .rdata(r0), .busy(b0), .done(d0),
                                 .slot_en(en0), .slot_pre(pre0), .slot_src(src0), .slot_xa(xa), .slot_xb(xb));
  misfit_core_lean #(.N(N)) dut (.clk(clk), .rst_n(rst_n), .addr(addr), .wr(wr), .wdata(wdata), .rdata(r1), .busy(b1), .done(d1),
                                 .slot_en(en1), .slot_pre(pre1), .slot_src(src1), .slot_xa(xa), .slot_xb(xb));
  always #10 clk = ~clk;
  integer seed, cycles, i, mism = 0, meas = 0, tmo = 0, ab = 0, cntrd = 0, dual = 0, r, hold = 0, da [0:N-1], db [0:N-1], k, seed0;
  reg bprev = 0, was_abort = 0;
  initial begin
    if (!$value$plusargs("seed=%d", seed)) seed = 1;
    if (!$value$plusargs("cycles=%d", cycles)) cycles = 100000;
    seed0 = seed; r = $random(seed);
    for (k = 0; k < N; k = k + 1) begin da[k] = 0; db[k] = 0; end
    repeat (5) @(negedge clk); rst_n = 1;
    for (i = 0; i < cycles; i = i + 1) begin
      @(negedge clk);
      // ---- compare everything visible
      if (r0 !== r1 || b0 !== b1 || d0 !== d1 || en0 !== en1 || pre0 !== pre1 || src0 !== src1) begin
        mism = mism + 1;
        if (mism <= 5) $display("MISMATCH cycle %0d addr %h r %h/%h busy %b/%b done %b/%b", i, addr, r0, r1, b0, b1, d0, d1);
      end
      // ---- coverage, from the reference only
      if (bprev && !b0) begin
        if (gold.f_tmo_a || gold.f_tmo_b) tmo = tmo + 1; else if (gold.f_done) meas = meas + 1; else ab = ab + 1;
        if (gold.f_done && gold.dual && !gold.is_ref) dual = dual + 1;
      end
      bprev = b0;
      if (addr >= 4'h8 && addr <= 4'hD) cntrd = cntrd + 1;
      // ---- slot behaviour: each selected slot answers a random time after its precharge ends; sometimes never, sometimes stuck
      for (k = 0; k < N; k = k + 1) begin
        if (pre0[k]) begin
          r = $random(seed); da[k] = (r[3:0] == 0) ? -1 : 1 + (r[15:4] % 300);
          r = $random(seed); db[k] = (r[3:0] == 0) ? -1 : 1 + (r[15:4] % 300);
          r = $random(seed); xa[k] = (r[5:0] == 0); xb[k] = (r[11:6] == 0);          // stuck high during precharge, rarely
        end else if (!en0[k] || !b0) begin xa[k] = 0; xb[k] = 0; end
        else begin
          if (da[k] > 0) begin da[k] = da[k] - 1; if (da[k] == 0) xa[k] = 1; end
          if (db[k] > 0) begin db[k] = db[k] - 1; if (db[k] == 0) xb[k] = 1; end
        end
      end
      // ---- host: hold each bus state a few cycles, then pick a new one
      if (hold > 0) hold = hold - 1;
      else begin
        r = $random(seed); hold = r[2:0];
        r = $random(seed); addr = r[3:0];
        r = $random(seed); wdata = r[7:0];
        r = $random(seed);
        case (addr)
          4'h1: wdata = (r[3:0] == 0) ? wdata : {5'b0, wdata[2:1], 1'b1};          // mostly keep arm = 1
          4'h2: wdata = (r[2:0] == 0) ? 8'd7 : {6'b0, wdata[1:0]};                 // slots 0..3, sometimes the internal reference
          4'h4: wdata = (r[2:0] == 0) ? wdata : 8'h0F;
          4'h5: wdata = 8'd6 + ({5'b0, wdata[2:0]} % 6);                         // windows of 64 to 2048 cycles: both ends happen
          4'h6: wdata = (r[4:0] == 0) ? 8'h02 : (r[1:0] == 0 ? 8'h04 : 8'h01);     // start, sometimes clear, rarely abort
          4'hE: wdata = {3'b0, wdata[4:0]};
          4'hF: wdata = {6'b0, wdata[1:0]};
          default: ;
        endcase
        r = $random(seed); wr = (r[1:0] != 0) ? ~wr : wr;
      end
      r = $random(seed); if (r[19:0] == 0) begin rst_n = 0; @(negedge clk); rst_n = 1; end   // a rare reset mid-run
    end
    $display("EQ %0d %0d %0d %0d %0d %0d %0d %0d", seed0, cycles, mism, meas, tmo, ab, cntrd, dual);
    $finish;
  end
endmodule
