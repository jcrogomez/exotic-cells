`timescale 1ns/1ps
module tb2;
  reg en, pre; reg [1:0] s; integer i, errs = 0;
  wire prea, preb, vbias, c1, duta, dutb, refa, refb, sa0b, sa1b, sa2b, sb0b, sb1b;
  e7_decoder d (.en(en), .pre(pre), .src(s), .prea(prea), .preb(preb), .vbias(vbias), .c1(c1), .duta(duta), .dutb(dutb), .refa(refa),
    .refb(refb), .sa0b(sa0b), .sa1b(sa1b), .sa2b(sa2b), .sb0b(sb0b), .sb1b(sb1b));
  function [12:0] hand(input en, input pre, input [1:0] s);
    reg cal, c11, c10;
    begin
      cal = (s == 2'b10) || (s == 2'b11); c11 = (s == 2'b11); c10 = (s == 2'b10);
      if (!en) hand = {1'b0,1'b0, 1'b0,1'b0, 1'b0,1'b0, 1'b0,1'b0, 1'b1,1'b1,1'b1, 1'b1,1'b1};
      else hand = {~pre, ~pre, 1'b1, 1'b1, (s == 2'b01), (s == 2'b01), cal, cal, ~c11, ~cal, ~c10, ~cal, ~cal};
    end
  endfunction
  initial begin
    for (i = 0; i < 16; i = i + 1) begin {en, pre, s} = i; #1;
      if ({prea, preb, vbias, c1, duta, dutb, refa, refb, sa0b, sa1b, sa2b, sb0b, sb1b} !== hand(en, pre, s)) begin errs = errs + 1; $display("DISCREPANCIA %b", i[3:0]); end end
    $display("I2B combinaciones=16 discrepancias=%0d", errs); $finish;
  end
endmodule
