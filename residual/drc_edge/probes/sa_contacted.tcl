# nfet 0.42/0.15. Left diffusion of length v with a 0.17 um contact centred in it. Right side fixed and legal.
set lo 0.150 ; set hi 0.400 ; set step 0.005
proc draw {v} {
  box [expr {-$v}]um 0um 0.65um 0.42um ; paint ndiff
  box 0um -0.13um 0.15um 0.55um ; paint poly
  set c [expr {-$v / 2.0}]
  box [expr {$c - 0.085}]um 0.06um [expr {$c + 0.085}]um 0.36um ; paint ndiffc
  box [expr {$c - 0.085}]um -0.02um [expr {$c + 0.085}]um 0.44um ; paint locali
  box 0.315um 0.06um 0.485um 0.36um ; paint ndiffc
  box 0.315um -0.02um 0.485um 0.44um ; paint locali
  # substrate tap, so the latch-up rule (LU.2) does not mask the rule under study
  box -0.2um -1.2um 0.5um -0.7um ; paint psubdiff
  box -0.05um -1.05um 0.35um -0.85um ; paint psubdiffcont
  box -0.13um -1.05um 0.43um -0.85um ; paint locali
}
