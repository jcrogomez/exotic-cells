# SPDX-License-Identifier: Apache-2.0
# Arm A1: the same inverter wrapped as a 12 x 9 um macro whose supply arrives on two vertical metal-4 stripes, tied down
# to the cell's metal-1 rails through via stacks. Signals on metal 1 at the left (A) and right (Y) edges. Units: um.
# Run in a folder that holds misfit_inv.mag (cell/variants/ok).
proc r {layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; paint $layer }
proc pin {name layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; label $name FreeSans 20 0 0 0 c $layer ; port make }
drc off
load misfit_inv
cellname create m4tmp ; load m4tmp
box 3um 3um 3um 3um
getcell misfit_inv
select top cell
flatten -nolabels misfit_inv_m4
load misfit_inv_m4
# A: up to metal 1 and out to the left edge
r viali 3.225 4.07 3.395 4.24
r metal1 0.30 4.00 3.48 4.31
# Y: up to metal 1 and out to the right edge
r viali 4.91 4.60 5.08 4.77
r metal1 4.83 4.52 11.70 4.85
# ground: rail extended, stack to the metal-4 stripe at x = 7.2..8.8
r metal1 6.68 2.76 8.00 3.24
r via1 7.45 2.80 7.85 3.20
r metal2 7.35 2.70 7.95 3.30
r via2 7.45 2.80 7.85 3.20
r metal3 7.30 2.65 8.00 3.35
r via3 7.45 2.80 7.85 3.20
r metal4 7.20 0 8.80 9
# supply: rail extended under the ground stripe, stack to the metal-4 stripe at x = 9.4..11.0
r metal1 6.68 5.48 10.60 5.96
r via1 10.00 5.52 10.40 5.92
r metal2 9.90 5.42 10.50 6.02
r via2 10.00 5.52 10.40 5.92
r metal3 9.85 5.37 10.55 6.07
r via3 10.00 5.52 10.40 5.92
r metal4 9.40 0 11.00 9
pin A metal1 0.30 4.00 0.80 4.31
pin Y metal1 11.20 4.52 11.70 4.85
pin VGND metal4 7.20 0 8.80 9
pin VPWR metal4 9.40 0 11.00 9
box 0um 0um 12um 9um
property FIXED_BBOX [box values]
box -100um -100um 100um 100um
drc style drc(full)
drc on ; drc check ; drc catchup
set rules {}
foreach {msg boxes} [drc listall why] { lappend rules "$msg  @ $boxes" }
puts "DRC misfit_inv_m4 violations=[llength $rules]"
foreach x $rules { puts "   $x" }
drc off
save misfit_inv_m4
gds write misfit_inv_m4.gds
extract all
ext2spice lvs
ext2spice -o misfit_inv_m4.spice
quit -noprompt
