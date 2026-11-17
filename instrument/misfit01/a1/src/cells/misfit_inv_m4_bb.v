// SPDX-License-Identifier: Apache-2.0
// Port list of the macro of arm A1 (cell/misfit_inv_m4.tcl), for synthesis.
(* blackbox *)
module misfit_inv_m4 (
`ifdef USE_POWER_PINS
    inout wire VPWR,
    inout wire VGND,
`endif
    input  wire A,
    output wire Y
);
endmodule
