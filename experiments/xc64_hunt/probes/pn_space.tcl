# p+ and n+ inside an n-well, both contacted, separated by v (0 = abutted).
set lo 0.000 ; set hi 0.400 ; set step 0.005
proc draw {v} {
  box -1um -1um [expr {3.2 + $v}]um 2.5um ; paint nwell
  box 0um 0um 1um 1.5um ; paint pdiff
  set x0 [expr {1.0 + $v}]
  box ${x0}um 0um [expr {$x0 + 1.0}]um 1.5um ; paint nsubdiff
  box 0.3um 0.3um 0.7um 1.2um ; paint pdiffc
  box 0.2um 0.2um 0.8um 1.3um ; paint locali
  box [expr {$x0 + 0.3}]um 0.3um [expr {$x0 + 0.7}]um 1.2um ; paint nsubdiffcont
  box [expr {$x0 + 0.2}]um 0.2um [expr {$x0 + 0.8}]um 1.3um ; paint locali
}
