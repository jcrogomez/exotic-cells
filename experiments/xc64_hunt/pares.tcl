# XC-64 caza sistematica. Uso (en la imagen de herramientas): magic -dnull -noconsole -rcfile <sky130A.magicrc> pares.tcl
# Escribe pares.csv: ctx;a;b;v_um;n;reglas
set T {nwell ndiff pdiff psubdiff nsubdiff mvndiff mvpdiff mvpsubdiff mvnsubdiff poly locali metal1}
set f [open pares.csv w]
puts $f "ctx;a;b;v_um;n;reglas"
set vals {3.000}
for {set i 80} {$i >= 0} {incr i -1} { lappend vals [format %.3f [expr {$i * 0.005}]] }
set id 0
foreach ctx {sub well} {
  for {set ia 0} {$ia < [llength $T]} {incr ia} {
    for {set ib $ia} {$ib < [llength $T]} {incr ib} {
      set a [lindex $T $ia] ; set b [lindex $T $ib]
      foreach v $vals {
        incr id
        set cell c$id
        cellname create $cell ; load $cell ; drc off
        if {$ctx eq "well"} { box -1um -1um [expr {3.0 + $v}]um 2.5um ; paint nwell }
        box 0um 0um 1um 1.5um ; paint $a
        box [expr {1.0 + $v}]um 0um [expr {2.0 + $v}]um 1.5um ; paint $b
        box -100um -100um 100um 100um
        drc style drc(full) ; drc on ; drc check ; drc catchup
        set rules {}
        foreach {msg boxes} [drc listall why] { lappend rules $msg }
        puts $f "$ctx;$a;$b;$v;[llength $rules];[join [lsort $rules] { | }]"
        drc off
        cellname delete $cell
      }
    }
  }
  flush $f
}
close $f
quit -noprompt
