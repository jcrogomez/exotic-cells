# nfet 0.42/0.15: n+ source (contacted) on the left; on the right, n+ of length v and then a contacted p+ substrate tap.
# v = 0: the gate sits between n+ and p+.
set lo 0.000 ; set hi 0.400 ; set step 0.005
proc draw {v} {
  box -0.65um 0um [expr {0.15 + $v}]um 0.42um ; paint ndiff
  box 0um -0.13um 0.15um 0.55um ; paint poly
  box -0.485um 0.06um -0.315um 0.36um ; paint ndiffc
  box -0.485um -0.02um -0.315um 0.44um ; paint locali
  set x0 [expr {0.15 + $v}]
  box ${x0}um 0um [expr {$x0 + 0.65}]um 0.42um ; paint psubdiff
  box [expr {$x0 + 0.24}]um 0.06um [expr {$x0 + 0.41}]um 0.36um ; paint psubdiffcont
  box [expr {$x0 + 0.24}]um -0.02um [expr {$x0 + 0.41}]um 0.44um ; paint locali
}
