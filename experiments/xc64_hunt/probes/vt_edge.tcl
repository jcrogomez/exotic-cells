# nfet W = 1.0, L = 0.15, both sides contacted. The channel is lvt from y = 0 to v and standard from v to 1.0.
set lo 0.000 ; set hi 1.000 ; set step 0.010
proc draw {v} {
  box -0.65um 0um 0.80um 1.0um ; paint ndiff
  box 0um -0.13um 0.15um 1.13um ; paint poly
  if {$v > 0} { box 0um 0um 0.15um ${v}um ; paint nfetlvt }
  foreach x {-0.485 0.465} {
    box ${x}um 0.06um [expr {$x + 0.17}]um 0.94um ; paint ndiffc
    box ${x}um -0.02um [expr {$x + 0.17}]um 1.02um ; paint locali
  }
  box -0.2um -1.2um 0.5um -0.7um ; paint psubdiff
  box -0.05um -1.05um 0.35um -0.85um ; paint psubdiffcont
  box -0.13um -1.05um 0.43um -0.85um ; paint locali
}
