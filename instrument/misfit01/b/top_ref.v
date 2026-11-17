// SPDX-License-Identifier: Apache-2.0
// Reference netlist of the tile of arm B: the hardened core and the hand-drawn macro, and nothing else.
module tt_um_misfit01b (
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
    wire inv_a, inv_y;
    misfit01_core u_core (.ui_in(ui_in), .uo_out(uo_out), .uio_in(uio_in), .uio_out(uio_out), .uio_oe(uio_oe),
                          .ena(ena), .clk(clk), .rst_n(rst_n), .inv_a(inv_a), .inv_y(inv_y), .VPWR(VPWR), .VGND(VGND));
    misfit_inv_m4 u_inv (.A(inv_a), .Y(inv_y), .VPWR(VPWR), .VGND(VGND));
endmodule
