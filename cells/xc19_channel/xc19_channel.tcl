# SPDX-License-Identifier: Apache-2.0
# XC-19 channel: the bias cell and two identical readout cells (device A and its twin B) wired together.
# Ports: VDD, GND, C1 (tie to VDD for three in series), PREA, PREB, XA, XB.  No added capacitor yet.
# Run from this folder; it reads ../xc19_bias/xc19_bias.mag and ../xc19_read/xc19_read.mag.
proc r {layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; paint $layer }
proc pin {name layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; label $name FreeSans 20 0 0 0 c $layer ; port make }
proc e {args} { return [expr $args] }
addpath ../xc19_bias
addpath ../xc19_read
drc off
cellname create xc19_channel_h ; load xc19_channel_h
# children: getcell puts the child's lower-left corner on the box
box -1.01um -0.66um -1.01um -0.66um ; getcell xc19_bias
set xr(A) 19.5 ; set xr(B) 22.5
foreach t {A B} { box [e $xr($t) - 0.30]um -1.00um [e $xr($t) - 0.30]um -1.00um ; getcell xc19_read }
# flatten so that the wiring merges with the children and the extraction is flat
flatten xc19_channel
load xc19_channel
# remove the children's own port labels; the channel defines its own
select top cell
foreach l {VB GND VDD C1 C2 PRE X} { catch { box -100um -100um 100um 100um ; erase label } }
box -100um -100um 100um 100um ; erase labels

# ---- the two precharge wells are at the same potential: join them (they would violate the well spacing rule)
r nwell [e $xr(A) + 2.00] 1.10 [e $xr(B) - 0.30] 2.60
# ---- VB: extend the bias rail to the gate pads of both readout cells
r metal1 17.40 -0.66 [e $xr(B) + 0.70] -0.37
foreach t {A B} { r viali [e $xr($t) + 0.39] -0.60 [e $xr($t) + 0.56] -0.43 }
# ---- GND: extend the rail; each readout cell joins through its tap strap
r metal1 18.20 0.66 [e $xr(B) + 1.70] 0.95
foreach t {A B} {
  r locali [e $xr($t) + 1.315] 0.44 [e $xr($t) + 1.485] 0.95
  r viali [e $xr($t) + 1.315] 0.72 [e $xr($t) + 1.485] 0.89
}
# ---- VDD: rail on metal 1 above everything
r metal1 5.50 3.81 [e $xr(B) + 0.50] 4.10
r locali 5.65 3.47 5.82 4.10
r viali 5.65 3.87 5.82 4.04
foreach t {A B} {
  r locali [e $xr($t) + 0.04] 2.67 [e $xr($t) + 0.21] 4.10
  r viali [e $xr($t) + 0.04] 3.87 [e $xr($t) + 0.21] 4.04
}

pin VDD metal1 10.0 3.81 11.0 4.10
pin GND metal1 8.0 0.66 9.0 0.95
pin C1 locali 3.25 2.4 3.42 3.0
foreach t {A B} {
  pin PRE$t locali [e $xr($t) + 0.465] 1.99 [e $xr($t) + 0.635] 2.32
  pin X$t locali [e $xr($t) + 0.54] 0.60 [e $xr($t) + 0.71] 0.90
}

box -100um -100um 100um 100um
drc style drc(full)
drc on ; drc check ; drc catchup
set rules {}
foreach {msg boxes} [drc listall why] { lappend rules "$msg  @ [lrange $boxes 0 2]" }
puts "DRC xc19_channel violations=[llength $rules]"
foreach x $rules { puts "   $x" }
drc off
save xc19_channel
gds write xc19_channel.gds
extract all
ext2spice lvs
ext2spice -o xc19_channel.lvs.spice
ext2spice cthresh 0
ext2spice rthresh infinite
ext2spice -o xc19_channel.pex.spice
set bb [box values]
select top cell ; puts "BBOX [box values]"
quit -noprompt
