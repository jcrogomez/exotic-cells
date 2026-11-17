# SPDX-License-Identifier: Apache-2.0
# MISFIT-01 control cell: an inverter drawn by hand, in the shape of a sky130_fd_sc_hd row cell (3.68 x 2.72 um, 8 sites), with its own well and substrate taps.
# nfet_01v8 1.0/0.5 and pfet_01v8 2.0/0.5 would not fit the row height; the widths that fit are 0.65 (n) and 1.00 (p),
# L = LEN (default 0.5): a geometry the library does not have.   Units: um.
#   magic -dnull -noconsole -rcfile <sky130A.magicrc> misfit_inv.tcl
# Variants for the negative controls, from the environment:
#   LEN=1.0        channel length (N2)        MODE=nopower  pfet source not tied to the rail (N1)
#   MODE=empty     no devices at all (N3)     OUT=<name>    output file stem (the cell is always called misfit_inv)
#   MODE=ponly     the pfet alone, as a precharge device (MISFIT-02); NAME=<cell name>
set NAME [expr {[info exists env(NAME)] ? $env(NAME) : "misfit_inv"}]
set LEN  [expr {[info exists env(LEN)]  ? $env(LEN)  : 0.5}]
set MODE [expr {[info exists env(MODE)] ? $env(MODE) : "ok"}]
set OUT  [expr {[info exists env(OUT)]  ? $env(OUT)  : "misfit_inv"}]
proc r {layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; paint $layer }
proc pin {name layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; label $name FreeSans 20 0 0 0 c $layer ; port make }
drc off
cellname create $NAME ; load $NAME
set W 3.68
set gx0 1.13 ; set gx1 [expr {$gx0 + $LEN}]

# wells and rails, as in the library: nwell over the top half, met1 rails 0.48 wide centred on the cell edges
r nwell -0.19 1.305 [expr {$W+0.19}] 2.91
r metal1 0 -0.24 $W 0.24
r metal1 0 2.48 $W 2.96
r locali 0 -0.085 $W 0.085
r locali 0 2.635 $W 2.805
foreach x {0.145 0.605 1.065 1.525 1.985 2.445 2.905 3.365} {
  r viali $x -0.085 [expr {$x+0.17}] 0.085
  r viali $x 2.635 [expr {$x+0.17}] 2.805
}

if {$MODE ne "empty"} {
if {$MODE ne "ponly"} {
# nfet: W = 0.65
r ndiff 0.55 0.235 [expr {$gx1+0.58}] 0.885
r ndiffc 0.68 0.39 0.85 0.73
r ndiffc [expr {$gx1+0.28}] 0.39 [expr {$gx1+0.45}] 0.73
}
# pfet: W = 1.00
r pdiff 0.55 1.485 [expr {$gx1+0.58}] 2.485
r pdiffc 0.68 1.60 0.85 2.37
r pdiffc [expr {$gx1+0.28}] 1.60 [expr {$gx1+0.45}] 2.37
# gate
r poly $gx0 0.105 $gx1 2.615
# gate pad and contact, kept 0.11 um clear of the p+ implant of the pfet (licon.SP.6 of the KLayout manufacturing deck;
# Magic's full DRC does not flag the closer position first drawn)
r poly 0.14 0.98 $gx1 1.35
r polycont 0.225 1.06 0.395 1.23
r locali 0.145 1.035 0.475 1.275

# sources to the rails
if {$MODE ne "ponly"} { r locali 0.68 0.085 0.85 0.81 }
if {$MODE eq "nopower"} { r locali 0.68 1.52 0.85 2.40 } else { r locali 0.68 1.52 0.85 2.635 }
# output: nfet drain to pfet drain
r locali [expr {$gx1+0.28}] 0.31 [expr {$gx1+0.45}] 2.45

# taps: the cell does not rely on the flow's tap cells
set tx [expr {$gx1+0.58+0.39}]
r nsubdiff $tx 1.60 [expr {$tx+0.42}] 2.40
r nsubdiffcont [expr {$tx+0.125}] 1.70 [expr {$tx+0.295}] 2.30
r locali [expr {$tx+0.125}] 1.62 [expr {$tx+0.295}] 2.635
r psubdiff $tx 0.30 [expr {$tx+0.42}] 0.80
r psubdiffcont [expr {$tx+0.125}] 0.38 [expr {$tx+0.295}] 0.72
r locali [expr {$tx+0.125}] 0.085 [expr {$tx+0.295}] 0.80
}

pin A locali 0.145 1.035 0.475 1.275
pin Y locali [expr {$gx1+0.28}] 1.075 [expr {$gx1+0.45}] 1.315
pin VGND metal1 0 -0.24 $W 0.24
pin VPWR metal1 0 2.48 $W 2.96
box 0um 0um ${W}um 2.72um
property FIXED_BBOX [box values]

box -100um -100um 100um 100um
drc style drc(full)
drc on ; drc check ; drc catchup
set rules {}
foreach {msg boxes} [drc listall why] { lappend rules "$msg  @ $boxes" }
puts "DRC $NAME violations=[llength $rules]"
foreach x $rules { puts "   $x" }
drc off
save $NAME
gds write $OUT.gds
extract all
ext2spice lvs
ext2spice -o $OUT.spice
quit -noprompt
