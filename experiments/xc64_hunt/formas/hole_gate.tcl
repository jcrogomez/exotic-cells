# nfet L = 1.0, W = 1.5, with a square field-oxide hole of side v in the middle of the channel, entirely under the gate.
source formas/tap.tcl
set lo 0.000 ; set hi 0.600 ; set step 0.010
proc draw {v} {
  set a [expr {0.5 - $v / 2.0}] ; set b [expr {0.5 + $v / 2.0}]
  set c [expr {0.75 - $v / 2.0}] ; set d [expr {0.75 + $v / 2.0}]
  box -0.65um 0um ${a}um 1.5um ; paint ndiff
  box ${b}um 0um 1.65um 1.5um ; paint ndiff
  box ${a}um 0um ${b}um ${c}um ; paint ndiff
  box ${a}um ${d}um ${b}um 1.5um ; paint ndiff
  box 0um -0.13um 1.0um 1.63um ; paint poly
  cont -0.485 0.06 1.38
  cont 1.315 0.06 1.38
  tap -0.2 -1.3
}
