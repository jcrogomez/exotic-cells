// SPDX-License-Identifier: Apache-2.0
// Reference netlist of the MISFIT-04 stage-1 tile: the hardened core and the XC-19 slot wrapper, and nothing else.
// DUMMYB (mirror track of SA2B on side B) is tied to VPWR.
module tt_um_misfit04 (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n,
    inout  wire       VPWR,
    inout  wire       VGND
);
    wire prea, preb, vbias, c1, duta, dutb, refa, refb, sa0b, sa1b, sa2b, sb0b, sb1b, xa, xb;
    misfit04_core u_core (.ui_in(ui_in), .uo_out(uo_out), .uio_in(uio_in), .uio_out(uio_out), .uio_oe(uio_oe),
        .ena(ena), .clk(clk), .rst_n(rst_n), .s0_prea(prea), .s0_preb(preb), .s0_vbias(vbias), .s0_c1(c1), .s0_duta(duta),
        .s0_dutb(dutb), .s0_refa(refa), .s0_refb(refb), .s0_sa0b(sa0b), .s0_sa1b(sa1b), .s0_sa2b(sa2b), .s0_sb0b(sb0b),
        .s0_sb1b(sb1b), .s0_xa(xa), .s0_xb(xb), .VPWR(VPWR), .VGND(VGND));
    xc19_slot_w u_slot (.XA_OUT(xa), .SA2B(sa2b), .SA1B(sa1b), .REFA(refa), .SA0B(sa0b), .C1(c1), .VBIAS(vbias), .DUTA(duta),
        .PREA(prea), .DUTB(dutb), .PREB(preb), .SB0B(sb0b), .REFB(refb), .SB1B(sb1b), .XB_OUT(xb), .DUMMYB(VPWR),
        .VDD(VPWR), .GND(VGND));
endmodule
