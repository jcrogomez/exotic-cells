// SPDX-License-Identifier: Apache-2.0
// Port list of the hand-drawn inverter, for synthesis. The cell is cell/misfit_inv.tcl.
(* blackbox *)
module misfit_inv (
`ifdef USE_POWER_PINS
    inout wire VPWR,
    inout wire VGND,
`endif
    input  wire A,
    output wire Y
);
endmodule
