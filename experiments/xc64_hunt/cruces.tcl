# XC-64 caza por cruce de bordes. Escribe cruces.csv: ctx;a;b;s_um;n;reglas;tipos   (s = lo que B sobresale de A; -9 = lejos)
set T {nwell ndiff pdiff psubdiff nsubdiff mvndiff mvpdiff mvpsubdiff mvnsubdiff poly locali metal1}
set f [open cruces.csv w]
puts $f "ctx;a;b;s_um;n;reglas;tipos"
set vals {-9}
for {set i 0} {$i <= 50} {incr i} { lappend vals [format %.2f [expr {$i * 0.01}]] }
set id 0
foreach ctx {sub well} {
  foreach a $T { foreach b $T {
    if {$a eq $b} continue
    foreach s $vals {
      incr id ; set cell c$id
      cellname create $cell ; load $cell ; drc off
      if {$ctx eq "well"} { box -1um -1um 7um 3um ; paint nwell }
      box 0um 0um 2um 2um ; paint $a
      if {$s == -9} { set x1 5.0 } else { set x1 [expr {2.0 + $s}] }
      box [expr {$x1 - 0.5}]um 0.75um ${x1}um 1.25um ; paint $b
      box -100um -100um 100um 100um
      drc style drc(full) ; drc on ; drc check ; drc catchup
      set rules {}
      foreach {msg boxes} [drc listall why] { lappend rules $msg }
      # que tipos quedaron en la franja de B (Magic compone al pintar)
      box [expr {$x1 - 0.5}]um 0.75um ${x1}um 1.25um
      set tipos [lsort -unique [what -list]]
      puts $f "$ctx;$a;$b;$s;[llength $rules];[join [lsort $rules] { | }];[join [lindex $tipos 0] ,]"
      drc off ; cellname delete $cell
    }
  } }
  flush $f
}
close $f
quit -noprompt
