# nfet, gate at x 0..0.15. Diffusion 0.42 wide left of x = v and 1.00 wide right of it. v walks across the gate.
source formas/tap.tcl
set lo -0.350 ; set hi 0.500 ; set step 0.005
proc draw {v} {
  box -0.65um 0um ${v}um 0.42um ; paint ndiff
  box ${v}um 0um 0.80um 1.00um ; paint ndiff
  box 0um -0.13um 0.15um 1.13um ; paint poly
  cont -0.485 0.06 0.30
  cont 0.465 0.06 0.30
  tap -0.2 -1.3
}
