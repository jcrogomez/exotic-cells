# n+ strip 0.42 wide, contacted outside the well, reaching x = v. The n-well (with its own contacted tap) starts at x = 0.
# v < 0: the strip stops short of the well; v > 0: it goes v into the well.
set lo -0.500 ; set hi 1.000 ; set step 0.010
proc draw {v} {
  box 0um -1.5um 3.0um 2.0um ; paint nwell
  box 1.8um 0um 2.5um 0.5um ; paint nsubdiff
  box 1.95um 0.15um 2.35um 0.35um ; paint nsubdiffcont
  box 1.87um 0.15um 2.43um 0.35um ; paint locali
  box -1.5um 0um ${v}um 0.42um ; paint ndiff
  box -1.335um 0.06um -1.165um 0.36um ; paint ndiffc
  box -1.335um -0.02um -1.165um 0.44um ; paint locali
  box -1.5um -1.2um -0.8um -0.7um ; paint psubdiff
  box -1.35um -1.05um -0.95um -0.85um ; paint psubdiffcont
  box -1.43um -1.05um -0.87um -0.85um ; paint locali
}
