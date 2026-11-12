# SPDX-License-Identifier: Apache-2.0
# Scans one parametric geometry through Magic DRC. Usage (inside the tools image):
#   PROBE=probes/m1_width.tcl OUT=out magic -dnull -noconsole -rcfile <sky130A.magicrc> scan.tcl
# A probe defines: set lo, set hi, set step (um) and proc draw {v} that paints the geometry for the value v.
source $env(PROBE)
set probe [file rootname [file tail $env(PROBE)]]
set out $env(OUT)
file mkdir $out
set f [open $out/$probe.magic.csv w]
puts $f "v_um;violations;rules"
set n [expr {int(round(($hi - $lo) / $step))}]
for {set i 0} {$i <= $n} {incr i} {
  set v [format %.3f [expr {$lo + $i * $step}]]
  set cell ${probe}_[string map {. p} $v]
  cellname create $cell
  load $cell
  drc off
  draw $v
  # Check the whole cell with the full rule set. With the box left on the last painted shape, or with the default
  # drc(fast) style, Magic can report nothing for a real violation: the width control caught exactly that.
  box -100um -100um 100um 100um
  drc style drc(full)
  drc on ; drc check ; drc catchup
  set rules {}
  foreach {msg boxes} [drc listall why] { lappend rules $msg }
  puts $f "$v;[llength $rules];[join $rules { | }]"
  drc off
  gds write $out/$cell.gds
}
close $f
quit -noprompt
