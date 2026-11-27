// SPDX-License-Identifier: Apache-2.0
// Reader 2 as a slot: same signal ports as misfit_cell_slot (INTERFACES.md), so the core reads it unchanged.
// The loop oscillates while enabled; a ripple counter on q raises xa after NA periods and xb after NB periods.
// The core captures both; (count_b - count_a) / (NB - NA) is the period, free of the long first interval.
//   src 0: idle.  1: low range, NA = 4, NB = 16.  2: high range, NA = 256, NB = 4096.  3: low range, NA = 64, NB = 1024.
// With en low or pre high the loop idles with the long precharge on (node held at the supply) and xa = xb = 0.
// The range only changes while idle because src is stable during an acquisition (core guarantee).
`default_nettype none
module reader2_slot (
    input  wire       en,
    input  wire       pre,
    input  wire [1:0] src,
    output reg        xa,
    output reg        xb,
    input  wire       x,       // the measured node (analog): the front end reader2fe and the seats hang from it
    output wire       prenh,   // precharge lines of reader2fe (active low)
    output wire       prenl
);
    wire run = en & ~pre & (src != 2'd0);
    wire rs  = (src == 2'd2);
    wire q;
    reader2_loop u_loop (.en(run), .rs(rs), .x(x), .q(q), .prenh(prenh), .prenl(prenl));
    // 13-bit ripple counter of q rising edges; bit k first rises after 2^k edges
    reg [12:0] c;
    wire [12:0] ck = {~c[11:0], q};
    genvar g;
    generate for (g = 0; g < 13; g = g + 1) begin : r
        always @(posedge ck[g] or negedge run) if (!run) c[g] <= 1'b0; else c[g] <= ~c[g];
    end endgenerate
    wire ta = (src == 2'd1) ? c[2] : (src == 2'd2) ? c[8]  : c[6];
    wire tb = (src == 2'd1) ? c[4] : (src == 2'd2) ? c[12] : c[10];
    always @(posedge ta or negedge run) if (!run) xa <= 1'b0; else xa <= 1'b1;
    always @(posedge tb or negedge run) if (!run) xb <= 1'b0; else xb <= 1'b1;
endmodule
`default_nettype wire
