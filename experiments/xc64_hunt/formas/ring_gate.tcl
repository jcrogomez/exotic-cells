# Square ring gate 0.15 wide around an opening of side v; drain contact in the centre, source contact outside.
source formas/tap.tcl
set lo 0.300 ; set hi 1.200 ; set step 0.020
proc draw {v} {
  box -0.8um -0.8um [expr {$v + 0.8}]um [expr {$v + 0.8}]um ; paint ndiff
  box -0.15um -0.15um [expr {$v + 0.15}]um 0um ; paint poly
  box -0.15um ${v}um [expr {$v + 0.15}]um [expr {$v + 0.15}]um ; paint poly
  box -0.15um 0um 0um ${v}um ; paint poly
  box ${v}um 0um [expr {$v + 0.15}]um ${v}um ; paint poly
  set m [expr {$v / 2.0 - 0.085}]
  box ${m}um ${m}um [expr {$m + 0.17}]um [expr {$m + 0.17}]um ; paint ndiffc
  box ${m}um [expr {$m - 0.08}]um [expr {$m + 0.17}]um [expr {$m + 0.25}]um ; paint locali
  cont -0.60 0.0 [expr {max($v, 0.30)}]
  tap -0.2 -2.0
}
