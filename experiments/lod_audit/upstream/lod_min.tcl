# SPDX-License-Identifier: Apache-2.0
# Minimal case: two nfet_01v8, same W/L (0.42/0.15 um), 0.30 um vs 3.0 um of diffusion on each side of the gate.
# Question: does the extracted netlist tell them apart in anything other than as/ad/ps/pd?
#   magic -dnull -noconsole -rcfile $PDK/libs.tech/magic/sky130A.magicrc lod_min.tcl
drc off
proc lod {name sa} {
  cellname create $name
  load $name
  set L 0.15 ; set W 0.42
  set xg $sa ; set xe [expr {2*$sa + $L}]
  box 0um 0um ${xe}um ${W}um ; paint ndiff
  box ${xg}um -0.13um [expr {$xg+$L}]um [expr {$W+0.13}]um ; paint poly
  # contacts 0.09 um from the gate on both sides, in both cells
  set c1a [expr {$xg-0.09-0.17}] ; set c1b [expr {$xg-0.09}]
  set c2a [expr {$xg+$L+0.09}]   ; set c2b [expr {$xg+$L+0.09+0.17}]
  box ${c1a}um 0.06um ${c1b}um 0.36um ; paint ndiffc
  box ${c2a}um 0.06um ${c2b}um 0.36um ; paint ndiffc
  box ${c1a}um -0.02um ${c1b}um 0.44um ; paint li1
  box ${c2a}um -0.02um ${c2b}um 0.44um ; paint li1
  box ${c1a}um 0.06um ${c1b}um 0.36um ; label S FreeSans 20 0 0 0 c li1 ; port make
  box ${c2a}um 0.06um ${c2b}um 0.36um ; label D FreeSans 20 0 0 0 c li1 ; port make
  box ${xg}um [expr {$W+0.05}]um [expr {$xg+$L}]um [expr {$W+0.13}]um ; label G FreeSans 20 0 0 0 c poly ; port make
  # substrate tap (LU.2)
  box 0um -1.2um 0.7um -0.7um ; paint psubdiff
  box 0.15um -1.05um 0.55um -0.85um ; paint psubdiffcont
  box 0.07um -1.05um 0.63um -0.85um ; paint locali
  box 0.07um -1.05um 0.63um -0.85um ; label B FreeSans 20 0 0 0 c li1 ; port make
  box -100um -100um 100um 100um
  drc style drc(full)
  drc on ; drc check ; drc catchup
  set rules {}
  foreach {msg boxes} [drc listall why] { lappend rules $msg }
  puts "== $name sa=sb=$sa um : full DRC, violations [llength $rules] [join $rules { | }]"
  drc off
  save $name
  extract all
  ext2spice lvs
  ext2spice -o $name.spice
}
lod lod_sa030 0.30
lod lod_sa300 3.0
quit -noprompt
