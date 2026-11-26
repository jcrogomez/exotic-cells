// SPDX-License-Identifier: Apache-2.0
// Functional test of reader2_slot against the behavioural loop. Prints PASS/FAIL lines; MUT=1 plants a wrong tap check.
`timescale 1ns/1ps
module tb;
    reg en = 0, pre = 0; reg [1:0] src = 0; wire xa, xb, x;
    reader2_slot dut (.en(en), .pre(pre), .src(src), .xa(xa), .xb(xb), .x(x));
    real ta, tb_, t0; integer fails = 0;
    always @(posedge xa) ta = $realtime;
    always @(posedge xb) tb_ = $realtime;
    task chk(input cond, input [255:0] name); begin
        if (cond) $display("PASS %0s", name); else begin $display("FAIL %0s", name); fails = fails + 1; end end endtask
    task acq(input [1:0] s, input real T, input real T1, input integer na, input integer nb, input [255:0] name);
        real ea, eb; begin
        src = s; pre = 1; #100; chk(xa === 0 && xb === 0, {name, " low in precharge"});
        ta = 0; tb_ = 0; pre = 0; t0 = $realtime;
        #(T1 + nb * T + 10 * T);
        ea = t0 + T1 + (na - 1) * T; eb = t0 + T1 + (nb - 1) * T;
        chk(ta > ea - 1 && ta < ea + 1, {name, " xa after NA edges"});
        chk(tb_ > eb - 1 && tb_ < eb + 1, {name, " xb after NB edges"});
        chk(((tb_ - ta) / (nb - na) - T) < 0.001 && ((tb_ - ta) / (nb - na) - T) > -0.001, {name, " period from difference"});
        chk(xa === 1 && xb === 1, {name, " outputs stay high"});
        pre = 1; #50; chk(xa === 0 && xb === 0, {name, " cleared by precharge"}); pre = 0; src = 0; #50;
    end endtask
    initial begin
        // Icarus leaves the flops at x until the asynchronous clear sees an edge; silicon clears on the level
        en = 1; src = 1; #1; en = 0; src = 0;
        #200; chk(xa === 0 && xb === 0, "idle after start");
        src = 1; pre = 0; #50000; chk(xa === 0 && xb === 0, "en low: nothing");
        src = 0; en = 1; #50000; chk(xa === 0 && xb === 0, "src 0: nothing");
        acq(2'd1, 1000.0, 4000.0, 4, 16, "src1");
        acq(2'd2, 22.0, 180.0, 256, 4096, "src2");
`ifdef MUT
        acq(2'd3, 1000.0, 4000.0, 64, 512, "src3");
`else
        acq(2'd3, 1000.0, 4000.0, 64, 1024, "src3");
`endif
        $display("FAILS %0d", fails); $finish;
    end
endmodule
