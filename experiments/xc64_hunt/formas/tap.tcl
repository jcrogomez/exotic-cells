proc tap {x y} {
  box ${x}um ${y}um [expr {$x + 0.7}]um [expr {$y + 0.5}]um ; paint psubdiff
  box [expr {$x + 0.15}]um [expr {$y + 0.15}]um [expr {$x + 0.55}]um [expr {$y + 0.35}]um ; paint psubdiffcont
  box [expr {$x + 0.07}]um [expr {$y + 0.15}]um [expr {$x + 0.63}]um [expr {$y + 0.35}]um ; paint locali
}
proc cont {x y h} {
  box ${x}um ${y}um [expr {$x + 0.17}]um [expr {$y + $h}]um ; paint ndiffc
  box ${x}um [expr {$y - 0.08}]um [expr {$x + 0.17}]um [expr {$y + $h + 0.08}]um ; paint locali
}
