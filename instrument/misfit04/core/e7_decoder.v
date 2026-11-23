// SPDX-License-Identifier: Apache-2.0
// MISFIT-04: decoder E7 of the XC-19 slot (cells/preregistros/MISFIT-03_2026-11-23_slot_xc19_enmienda1.md), from the core's
// slot lines (en, pre, src) to the 13 gate lines of the hand-drawn macro. Same logic as the hand netlist used in the
// MISFIT-03 contract; here it is synthesized, so the cells and drives differ.
//   src = 00 no source · 01 DUT (XC-19 and its twin) · 10 2 units on A, 1 on B · 11 1 unit on each side
`default_nettype none
module e7_decoder (
    input  wire       en,
    input  wire       pre,
    input  wire [1:0] src,
    output wire       prea, preb,     // precharge pfet gates: low = precharge (pre high, or slot disabled)
    output wire       vbias, c1,      // bias chain supply and its series knob: follow en
    output wire       duta, dutb,     // DUT switches (nfet): src = 01
    output wire       refa, refb,     // reference path (nfet): src = 1x
    output wire       sa0b, sa1b, sa2b, sb0b, sb1b   // plate switches (pfet, active low)
);
    wire s1 = src[1], s0 = src[0];
    assign prea  = en & ~pre;
    assign preb  = en & ~pre;
    assign vbias = en;
    assign c1    = en;
    assign duta  = en & ~s1 & s0;
    assign dutb  = en & ~s1 & s0;
    assign refa  = en & s1;
    assign refb  = en & s1;
    assign sa0b  = ~(en & s1 & s0);
    assign sa1b  = ~(en & s1);
    assign sa2b  = ~(en & s1 & ~s0);
    assign sb0b  = ~(en & s1);
    assign sb1b  = ~(en & s1);
endmodule
`default_nettype wire
