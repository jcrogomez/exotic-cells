# SPDX-License-Identifier: Apache-2.0
# XC-19 bias cell: a chain of diode-connected nfets from VDD to GND. The bottom element is 16 transistors drawn exactly
# like the device under test of xc19_read (0.42/0.15 um, 0.30 um of diffusion on each side, one island each), so that
# they carry the same layout-dependent stress. Above them, three 1/1 um devices in series: VDD - C1 - C2 - VB.
# Tying C1 to VDD outside the cell gives the three-in-series bias; leaving it gives four in series.
# Ports: VB and GND on metal 1; VDD, C1, C2 on local interconnect.
proc r {layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; paint $layer }
proc pin {name layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; label $name FreeSans 20 0 0 0 c $layer ; port make }
proc e {args} { return [expr $args] }
drc off
cellname create xc19_bias ; load xc19_bias

# ---- 16 mirror devices, pitch 1.1 um
for {set i 0} {$i < 16} {incr i} {
  set o [e $i * 1.1]
  r ndiff [e $o] 0 [e $o + 0.75] 0.42
  r poly [e $o + 0.30] -0.29 [e $o + 0.45] 0.55
  r ndiffc [e $o + 0.04] 0.06 [e $o + 0.21] 0.36
  r ndiffc [e $o + 0.54] 0.06 [e $o + 0.71] 0.36
  r poly [e $o + 0.30] -0.62 [e $o + 0.64] -0.29
  r polycont [e $o + 0.39] -0.54 [e $o + 0.56] -0.37
  # source strap up to the GND rail
  r locali [e $o + 0.04] -0.02 [e $o + 0.21] 0.95
  r viali [e $o + 0.04] 0.72 [e $o + 0.21] 0.89
  # drain strap down, merged with the gate pad: diode connection, then down to the VB rail
  r locali [e $o + 0.54] -0.62 [e $o + 0.71] 0.44
  r locali [e $o + 0.39] -0.62 [e $o + 0.56] -0.29
  r viali [e $o + 0.54] -0.60 [e $o + 0.71] -0.43
}
# rails
r metal1 -1.00 0.66 18.20 0.95
r metal1 -0.56 -0.66 17.40 -0.37
# substrate taps at both ends
foreach x {-1.01 17.79} {
  r psubdiff $x 0 [e $x + 0.42] 0.42
  r psubdiffcont [e $x + 0.125] 0.06 [e $x + 0.295] 0.36
  r locali [e $x + 0.125] -0.02 [e $x + 0.295] 0.95
  r viali [e $x + 0.125] 0.72 [e $x + 0.295] 0.89
}

# ---- three 1/1 um devices in series, second row. Device j has its drain on the right.
set py 2.2
set px(2) -0.54 ; set px(1) 1.86 ; set px(0) 4.26
for {set j 0} {$j < 3} {incr j} {
  set o $px($j)
  r ndiff $o $py [e $o + 1.6] [e $py + 1.0]
  r poly [e $o + 0.30] [e $py - 0.29] [e $o + 1.30] [e $py + 1.13]
  r ndiffc [e $o + 0.04] [e $py + 0.06] [e $o + 0.21] [e $py + 0.94]
  r ndiffc [e $o + 1.39] [e $py + 0.06] [e $o + 1.56] [e $py + 0.94]
  r poly [e $o + 0.96] [e $py - 0.62] [e $o + 1.30] [e $py - 0.29]
  r polycont [e $o + 1.05] [e $py - 0.54] [e $o + 1.22] [e $py - 0.37]
  # drain strap, gate pad and the bridge between them: diode connection
  r locali [e $o + 1.39] [e $py - 0.62] [e $o + 1.56] [e $py + 1.27]
  r locali [e $o + 1.05] [e $py - 0.62] [e $o + 1.22] [e $py - 0.29]
  r locali [e $o + 1.05] [e $py - 0.62] [e $o + 1.56] [e $py - 0.45]
}
# source of device 0 to drain of device 1 (node C1), source of device 1 to drain of device 2 (node C2): bridges on top
foreach {a b} {0 1 1 2} {
  r locali [e $px($a) + 0.04] [e $py - 0.02] [e $px($a) + 0.21] [e $py + 1.27]
  r locali [e $px($b) + 1.39] [e $py + 1.10] [e $px($a) + 0.21] [e $py + 1.27]
}
# source of device 2 down to the VB rail
r locali -0.50 -0.62 -0.33 [e $py + 1.02]
r viali -0.50 -0.60 -0.33 -0.43

pin VB metal1 8.0 -0.66 9.0 -0.37
pin GND metal1 8.0 0.66 9.0 0.95
pin VDD locali [e $px(0) + 1.39] [e $py + 0.2] [e $px(0) + 1.56] [e $py + 0.8]
pin C1 locali [e $px(1) + 1.39] [e $py + 0.2] [e $px(1) + 1.56] [e $py + 0.8]
pin C2 locali [e $px(2) + 1.39] [e $py + 0.2] [e $px(2) + 1.56] [e $py + 0.8]

box -100um -100um 100um 100um
drc style drc(full)
drc on ; drc check ; drc catchup
set rules {}
foreach {msg boxes} [drc listall why] { lappend rules "$msg  @ [lrange $boxes 0 2]" }
puts "DRC xc19_bias violations=[llength $rules]"
foreach x $rules { puts "   $x" }
drc off
save xc19_bias
gds write xc19_bias.gds
extract all
ext2spice lvs
ext2spice -o xc19_bias.lvs.spice
ext2spice cthresh 0
ext2spice rthresh infinite
ext2spice -o xc19_bias.pex.spice
quit -noprompt
