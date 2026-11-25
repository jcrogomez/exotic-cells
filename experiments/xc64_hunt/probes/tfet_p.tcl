# pfet 0.42/0.15 in an n-well: p+ source (contacted) on the left; on the right, p+ of length v and then a contacted n+ well tap.
set lo 0.000 ; set hi 0.400 ; set step 0.005
proc draw {v} {
  box -1.2um -0.6um [expr {1.4 + $v}]um 1.0um ; paint nwell
  box -0.65um 0um [expr {0.15 + $v}]um 0.42um ; paint pdiff
  box 0um -0.13um 0.15um 0.55um ; paint poly
  box -0.485um 0.06um -0.315um 0.36um ; paint pdiffc
  box -0.485um -0.02um -0.315um 0.44um ; paint locali
  set x0 [expr {0.15 + $v}]
  box ${x0}um 0um [expr {$x0 + 0.65}]um 0.42um ; paint nsubdiff
  box [expr {$x0 + 0.24}]um 0.06um [expr {$x0 + 0.41}]um 0.36um ; paint nsubdiffcont
  box [expr {$x0 + 0.24}]um -0.02um [expr {$x0 + 0.41}]um 0.44um ; paint locali
  # substrate tap, so the latch-up rule does not mask the rule under study
  box -0.2um -2.0um 0.5um -1.5um ; paint psubdiff
  box -0.05um -1.85um 0.35um -1.65um ; paint psubdiffcont
  box -0.13um -1.85um 0.43um -1.65um ; paint locali
}
