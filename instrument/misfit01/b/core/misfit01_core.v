// SPDX-License-Identifier: Apache-2.0
// MISFIT-01, arm B: the digital part alone. Every Tiny Tapeout pin, plus two pins to the hand-drawn inverter.
`default_nettype none
module misfit01_core (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n,
    output wire       inv_a,
    input  wire       inv_y
);
    reg q_in, q_out;
    always @(posedge clk or negedge rst_n)
        if (!rst_n) begin q_in <= 1'b0; q_out <= 1'b0; end
        else begin q_in <= ui_in[0]; q_out <= inv_y; end
    assign inv_a   = q_in;
    assign uo_out  = {6'b0, inv_y, q_out};
    assign uio_out = 8'h00;
    assign uio_oe  = 8'h00;
    wire _unused = &{ena, ui_in[7:1], uio_in, 1'b0};
endmodule
`default_nettype wire
