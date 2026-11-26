// SPDX-License-Identifier: Apache-2.0
// MISFIT-13: the core grown for seat matrices. Two readers (slots 0 and 1, an E7 decoder each) and the seat selection.
// SELMODE 1: 64 select lines shared by both readers. 2: 64 per reader (128). 3: two levels, 8 rows + 8 columns shared.
// Closure test only (cells/preregistros/MISFIT-13_2026-11-26_nucleo_crecido.md): not verified in simulation.
`default_nettype none
module misfit13_core (
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
    input  wire       s0_xa, s0_xb,
    output wire       s1_prea, s1_preb, s1_vbias, s1_c1, s1_duta, s1_dutb, s1_refa, s1_refb,
    output wire       s1_sa0b, s1_sa1b, s1_sa2b, s1_sb0b, s1_sb1b,
    input  wire       s1_xa, s1_xb,
`ifdef SELMODE3
    output wire [7:0] sel_row, sel_col
`elsif SELMODE2
    output wire [63:0] sel0, sel1
`else
    output wire [63:0] sel
`endif
);
    wire [3:0] slot_en, slot_pre;
    wire [7:0] slot_src;
    wire [6:0] seat;
    wire busy, done;
    misfit_core #(.N(4)) u_core (
        .clk(clk), .rst_n(rst_n),
        .addr(uio_in[4:0]), .wr(uio_in[5]), .wdata(ui_in), .rdata(uo_out), .busy(busy), .done(done), .seat(seat),
        .slot_en(slot_en), .slot_pre(slot_pre), .slot_src(slot_src),
        .slot_xa({2'b00, s1_xa, s0_xa}), .slot_xb({2'b00, s1_xb, s0_xb}));
    wire d0a, d0b, d1a, d1b;
    e7_decoder u_dec0 (
        .en(slot_en[0]), .pre(slot_pre[0]), .src(slot_src[1:0]),
        .prea(s0_prea), .preb(s0_preb), .vbias(s0_vbias), .c1(s0_c1), .duta(d0a), .dutb(d0b),
        .refa(s0_refa), .refb(s0_refb), .sa0b(s0_sa0b), .sa1b(s0_sa1b), .sa2b(s0_sa2b), .sb0b(s0_sb0b), .sb1b(s0_sb1b));
    e7_decoder u_dec1 (
        .en(slot_en[1]), .pre(slot_pre[1]), .src(slot_src[3:2]),
        .prea(s1_prea), .preb(s1_preb), .vbias(s1_vbias), .c1(s1_c1), .duta(d1a), .dutb(d1b),
        .refa(s1_refa), .refb(s1_refb), .sa0b(s1_sa0b), .sa1b(s1_sa1b), .sa2b(s1_sa2b), .sb0b(s1_sb0b), .sb1b(s1_sb1b));
    // the reader's own device is used when seat[6] = 0; a matrix seat when seat[6] = 1
    assign s0_duta = d0a & ~seat[6];  assign s0_dutb = d0b & ~seat[6];
    assign s1_duta = d1a & ~seat[6];  assign s1_dutb = d1b & ~seat[6];
    wire m0 = d0a & seat[6], m1 = d1a & seat[6];
    genvar g;
`ifdef SELMODE3
    generate for (g = 0; g < 8; g = g + 1) begin : rc
        assign sel_row[g] = (m0 | m1) & (seat[5:3] == g);
        assign sel_col[g] = (m0 | m1) & (seat[2:0] == g);
    end endgenerate
`elsif SELMODE2
    generate for (g = 0; g < 64; g = g + 1) begin : s
        assign sel0[g] = m0 & (seat[5:0] == g);
        assign sel1[g] = m1 & (seat[5:0] == g);
    end endgenerate
`else
    generate for (g = 0; g < 64; g = g + 1) begin : s
        assign sel[g] = (m0 | m1) & (seat[5:0] == g);
    end endgenerate
`endif
    assign uio_out = {busy, done, 6'b0};
    assign uio_oe  = 8'b1100_0000;
    wire _unused = &{ena, uio_in[7:6], slot_en[3:2], slot_pre[3:2], slot_src[7:4], d0b, d1b, 1'b0};
endmodule
`default_nettype wire
