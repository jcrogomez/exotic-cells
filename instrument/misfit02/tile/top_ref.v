// SPDX-License-Identifier: Apache-2.0
// Reference netlist of the stage-2 tile of MISFIT-02: the hardened instrument core and the time cell, and nothing else.
module tt_um_misfit02 (
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
    wire s0_pre, s0_xa, s0_xb;
    misfit02_core u_core (.ui_in(ui_in), .uo_out(uo_out), .uio_in(uio_in), .uio_out(uio_out), .uio_oe(uio_oe),
                          .ena(ena), .clk(clk), .rst_n(rst_n), .s0_pre(s0_pre), .s0_xa(s0_xa), .s0_xb(s0_xb),
                          .VPWR(VPWR), .VGND(VGND));
    misfit_tcell u_cell (.PRE(s0_pre), .XA(s0_xa), .XB(s0_xb), .VPWR(VPWR), .VGND(VGND));
endmodule
