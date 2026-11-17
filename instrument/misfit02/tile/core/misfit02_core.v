// SPDX-License-Identifier: Apache-2.0
// MISFIT-02, stage 2: the instrument's digital core as it is (rtl/misfit_core.v), with every Tiny Tapeout pin, and slot 0
// brought out on three pins to the hand-drawn time cell. Slots 1 to 3 are tied off. The time cell has no enable and no
// source select, so those lines of slot 0 are left unconnected here.
`default_nettype none
module misfit02_core (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n,
    output wire       s0_pre,
    input  wire       s0_xa,
    input  wire       s0_xb
);
    wire [3:0] slot_en, slot_pre;
    wire [7:0] slot_src;
    wire busy, done;
    misfit_core #(.N(4)) u_core (
        .clk(clk), .rst_n(rst_n),
        .addr(uio_in[3:0]), .wr(uio_in[4]), .wdata(ui_in), .rdata(uo_out), .busy(busy), .done(done),
        .slot_en(slot_en), .slot_pre(slot_pre), .slot_src(slot_src),
        .slot_xa({3'b000, s0_xa}), .slot_xb({3'b000, s0_xb}));
    assign s0_pre  = slot_pre[0];
    assign uio_out = {busy, done, 6'b0};
    assign uio_oe  = 8'b1100_0000;
    wire _unused = &{ena, uio_in[7:5], slot_en, slot_pre[3:1], slot_src, 1'b0};
endmodule
`default_nettype wire
