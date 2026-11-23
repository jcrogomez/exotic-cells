// SPDX-License-Identifier: Apache-2.0
// MISFIT-04, stage 1: the instrument's digital core as it is (rtl/misfit_core.v, N = 4), every Tiny Tapeout pin, and slot 0
// brought out through the E7 decoder to the hand-drawn XC-19 slot macro (13 gate lines out, XA_OUT and XB_OUT in).
// Slots 1 to 3 are tied off.
`default_nettype none
module misfit04_core (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n,
    output wire       s0_prea, s0_preb, s0_vbias, s0_c1, s0_duta, s0_dutb, s0_refa, s0_refb,
    output wire       s0_sa0b, s0_sa1b, s0_sa2b, s0_sb0b, s0_sb1b,
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
    e7_decoder u_dec (
        .en(slot_en[0]), .pre(slot_pre[0]), .src(slot_src[1:0]),
        .prea(s0_prea), .preb(s0_preb), .vbias(s0_vbias), .c1(s0_c1), .duta(s0_duta), .dutb(s0_dutb),
        .refa(s0_refa), .refb(s0_refb), .sa0b(s0_sa0b), .sa1b(s0_sa1b), .sa2b(s0_sa2b), .sb0b(s0_sb0b), .sb1b(s0_sb1b));
    assign uio_out = {busy, done, 6'b0};
    assign uio_oe  = 8'b1100_0000;
    wire _unused = &{ena, uio_in[7:5], slot_en[3:1], slot_pre[3:1], slot_src[7:2], 1'b0};
endmodule
`default_nettype wire
