// SPDX-License-Identifier: Apache-2.0
// Tiny Tapeout top level of MISFIT. Digital pins only.
//   ui_in[7:0]  write data          uo_out[7:0]  read data of the addressed register
//   uio[3:0]    address (in)        uio[4] write strobe (in)      uio[5] unused (in)
//   uio[6]      done (out)          uio[7] busy (out)
`default_nettype none
module tt_um_misfit (
  input  wire [7:0] ui_in,
  output wire [7:0] uo_out,
  input  wire [7:0] uio_in,
  output wire [7:0] uio_out,
  output wire [7:0] uio_oe,
  input  wire       ena,
  input  wire       clk,
  input  wire       rst_n
);
  localparam N = 4;
  wire [N-1:0]   slot_en, slot_pre, slot_xa, slot_xb;
  wire [2*N-1:0] slot_src;
  wire busy, done;

  misfit_core #(.N(N)) u_core (
    .clk(clk), .rst_n(rst_n),
    .addr(uio_in[3:0]), .wr(uio_in[4]), .wdata(ui_in), .rdata(uo_out), .busy(busy), .done(done),
    .slot_en(slot_en), .slot_pre(slot_pre), .slot_src(slot_src), .slot_xa(slot_xa), .slot_xb(slot_xb));

  assign uio_out = {busy, done, 6'b0};
  assign uio_oe  = 8'b1100_0000;

  // Cell slots. Each is a macro with this exact port list (../INTERFACES.md). Which cell sits in which slot is open.
  misfit_cell_slot u_slot0 (.en(slot_en[0]), .pre(slot_pre[0]), .src(slot_src[1:0]), .xa(slot_xa[0]), .xb(slot_xb[0]));
  misfit_cell_slot u_slot1 (.en(slot_en[1]), .pre(slot_pre[1]), .src(slot_src[3:2]), .xa(slot_xa[1]), .xb(slot_xb[1]));
  misfit_cell_slot u_slot2 (.en(slot_en[2]), .pre(slot_pre[2]), .src(slot_src[5:4]), .xa(slot_xa[2]), .xb(slot_xb[2]));
  misfit_cell_slot u_slot3 (.en(slot_en[3]), .pre(slot_pre[3]), .src(slot_src[7:6]), .xa(slot_xa[3]), .xb(slot_xb[3]));

  wire _unused = &{ena, uio_in[7:5], 1'b0};
endmodule
`default_nettype wire
