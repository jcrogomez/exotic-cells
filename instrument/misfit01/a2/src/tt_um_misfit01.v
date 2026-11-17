// SPDX-License-Identifier: Apache-2.0
// MISFIT-01: one hand-drawn inverter between two registers. ui_in[0] -> register -> misfit_inv -> register -> uo_out[0];
// uo_out[1] is the inverter's output, unregistered.
`default_nettype none
module tt_um_misfit01 (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);
    reg  q_in, q_out;
    wire y;
    always @(posedge clk or negedge rst_n)
        if (!rst_n) begin q_in <= 1'b0; q_out <= 1'b0; end
        else begin q_in <= ui_in[0]; q_out <= y; end

    (* keep *) misfit_inv u_inv (.A(q_in), .Y(y));

    assign uo_out  = {6'b0, y, q_out};
    assign uio_out = 8'h00;
    assign uio_oe  = 8'h00;
    wire _unused = &{ena, ui_in[7:1], uio_in, 1'b0};
endmodule
`default_nettype wire
