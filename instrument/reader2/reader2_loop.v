// SPDX-License-Identifier: Apache-2.0
// Reader 2 loop, structural. Version 2 (MISFIT-28): the netlist simulated in MISFIT-24 (experiments/misfit24/gen24.py) plus
// hysteresis on the comparator's second stage. Comparator, two inverters and a keeper, NOR latch, eight delay cells, and the gates on the two precharge lines.
// The analog front end reader2fe (generator/tables/reader2fe.json, MISFIT-22) is placed outside this block, on x, prenh, prenl.
`default_nettype none
module reader2_loop (
    input  wire en,   // low: long precharge on, node held at the supply
    input  wire rs,   // 1: high range (short precharge)
    input  wire x,
    output wire q,
    output wire prenh,
    output wire prenl
);
    wire c, c2, s, r, qb, enb, rsb;
    wire [6:0] d;
    (* keep *) sky130_fd_sc_hd__inv_1 u_cmp (.A(x),  .Y(c));
    // Hysteresis (MISFIT-28): u_s1 is four times the keeper u_k, and both drive c2. Without it a slow ramp on x left the latch
    // at intermediate voltages (MISFIT-26). Seen from x the hysteresis is divided by the gain of u_cmp; x still sees one inv_1.
    (* keep *) sky130_fd_sc_hd__inv_4 u_s1  (.A(c),  .Y(c2));
    (* keep *) sky130_fd_sc_hd__inv_1 u_k   (.A(s),  .Y(c2));
    (* keep *) sky130_fd_sc_hd__inv_1 u_s2  (.A(c2), .Y(s));
    (* keep *) sky130_fd_sc_hd__nor2_1 u_q  (.A(r), .B(qb), .Y(q));
    (* keep *) sky130_fd_sc_hd__nor2_1 u_qb (.A(s), .B(q),  .Y(qb));
    (* keep *) sky130_fd_sc_hd__dlygate4sd3_1 u_d0 (.A(q),    .X(d[0]));
    (* keep *) sky130_fd_sc_hd__dlygate4sd3_1 u_d1 (.A(d[0]), .X(d[1]));
    (* keep *) sky130_fd_sc_hd__dlygate4sd3_1 u_d2 (.A(d[1]), .X(d[2]));
    (* keep *) sky130_fd_sc_hd__dlygate4sd3_1 u_d3 (.A(d[2]), .X(d[3]));
    (* keep *) sky130_fd_sc_hd__dlygate4sd3_1 u_d4 (.A(d[3]), .X(d[4]));
    (* keep *) sky130_fd_sc_hd__dlygate4sd3_1 u_d5 (.A(d[4]), .X(d[5]));
    (* keep *) sky130_fd_sc_hd__dlygate4sd3_1 u_d6 (.A(d[5]), .X(d[6]));
    (* keep *) sky130_fd_sc_hd__dlygate4sd3_1 u_d7 (.A(d[6]), .X(r));
    (* keep *) sky130_fd_sc_hd__inv_1   u_ie (.A(en), .Y(enb));
    (* keep *) sky130_fd_sc_hd__inv_1   u_ir (.A(rs), .Y(rsb));
    (* keep *) sky130_fd_sc_hd__a21oi_4 u_gl (.A1(q), .A2(rsb), .B1(enb), .Y(prenl));
    (* keep *) sky130_fd_sc_hd__nand3_4 u_gh (.A(q), .B(rs), .C(en), .Y(prenh));
endmodule
`default_nettype wire
