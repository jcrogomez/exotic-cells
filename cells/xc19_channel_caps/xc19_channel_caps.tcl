# SPDX-License-Identifier: Apache-2.0
# XC-19 channel with its capacitors drawn: xc19_channel (bias + device A + twin B), plus
#   - one nfet_01v8 used as capacitor on each discharge node (gate on X, source/drain/body on GND), WC x LC um;
#   - the bias filter: NROW x NFING nfet_01v8 fingers of WF x LF um, gate on VB, source/drain/body on GND;
#   - the calibration coupling capacitor on each node: a metal-2 plate of X over a metal-1 plate of CALA / CALB.
# Ports: VDD, GND, C1, PREA, PREB, XA, XB, VB, CALA, CALB.  Units: um.
# Run from this folder inside the tools image:
#   magic -dnull -noconsole -rcfile $SKY130A/libs.tech/magic/sky130A.magicrc xc19_channel_caps.tcl
# It reads ../xc19_channel/xc19_channel.mag.
proc r {layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; paint $layer }
proc pin {name layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; label $name FreeSans 20 0 0 0 c $layer ; port make }
proc e {args} { return [expr $args] }

# ---- parameters
set WC 4.30 ; set LC 4.00                  ;# node capacitor (W vertical, L horizontal)
set NROW 11 ; set NFING 3 ; set WF 5.50 ; set LF 10.0  ;# bias filter (WF < 5.7: licon.12 of the full KLayout deck)
set PW 2.30 ; set PH 0.90                  ;# X plate (metal 2) of the calibration capacitor; CAL plate is 0.2 smaller on each side
if {[info exists ::env(XC19_WC)]} { set WC $::env(XC19_WC) }
if {[info exists ::env(XC19_NROW)]} { set NROW $::env(XC19_NROW) }
if {[info exists ::env(XC19_PH)]} { set PH $::env(XC19_PH) }

addpath ../xc19_channel
drc off
cellname create xc19_channel_caps_h ; load xc19_channel_caps_h
box -1.01um -1.00um -1.01um -1.00um ; getcell xc19_channel
flatten xc19_channel_caps
load xc19_channel_caps
box -200um -200um 200um 200um ; erase labels

set xr(A) 19.5 ; set xr(B) 22.5

# ---- GND bus on metal 1 below the channel, joined to the GND strap of each readout cell by a local-interconnect stub
set gby0 -1.98 ; set gby1 -1.08
r metal1 -1.65 $gby0 28.60 $gby1
foreach t {A B} {
  set x [e $xr($t) + 1.20]
  r locali $x -1.40 [e $x + 0.17] -0.83
  r viali  $x -1.35 [e $x + 0.17] -1.18
}

# ---- X of each readout cell: contact up to a metal-1 pad, via to a metal-2 line running down
foreach t {A B} {
  set x $xr($t)
  r viali  [e $x + 0.54] 0.05 [e $x + 0.71] 0.22
  r metal1 [e $x + 0.00] -0.06 [e $x + 0.77] 0.34
  r via1   [e $x + 0.12] 0.01 [e $x + 0.38] 0.27
  r metal2 [e $x + 0.07] -0.05 [e $x + 0.43] 0.33
}

# ---- node capacitor: gate on a pad below the diffusion, tap and GND strap above it
# x0: left edge of the diffusion; yb: bottom of the diffusion; xv: x of the X metal-2 line
proc nodecap {x0 yb W L xv} {
  set xt [e $x0 + $L + 0.60] ; set yt [e $yb + $W]
  r ndiff $x0 $yb $xt $yt
  r poly [e $x0 + 0.30] [e $yb - 0.13] [e $x0 + 0.30 + $L] [e $yt + 0.13]
  r ndiffc [e $x0 + 0.04] [e $yb + 0.06] [e $x0 + 0.21] [e $yt - 0.06]
  r ndiffc [e $xt - 0.21] [e $yb + 0.06] [e $xt - 0.04] [e $yt - 0.06]
  r locali [e $x0 + 0.04] [e $yb - 0.05] [e $x0 + 0.21] [e $yt + 0.70]
  r locali [e $xt - 0.21] [e $yb - 0.05] [e $xt - 0.04] [e $yt + 0.70]
  # tap and strap
  r psubdiff $x0 [e $yt + 0.32] $xt [e $yt + 0.74]
  r psubdiffcont [e $x0 + 0.10] [e $yt + 0.445] [e $xt - 0.10] [e $yt + 0.615]
  r locali $x0 [e $yt + 0.36] $xt [e $yt + 0.70]
  r viali [e $x0 + 0.60] [e $yt + 0.445] [e $x0 + 0.77] [e $yt + 0.615]
  r viali [e $xt - 0.77] [e $yt + 0.445] [e $xt - 0.60] [e $yt + 0.615]
  # gate pad
  set xc [e $x0 + 0.30 + $L / 2.0]
  r poly [e $xc - 0.25] [e $yb - 0.75] [e $xc + 0.25] [e $yb - 0.13]
  r polycont [e $xc - 0.085] [e $yb - 0.62] [e $xc + 0.085] [e $yb - 0.45]
  r locali [e $xc - 0.085] [e $yb - 0.70] [e $xc + 0.60] [e $yb - 0.37]
  r viali [e $xc + 0.35] [e $yb - 0.62] [e $xc + 0.52] [e $yb - 0.45]
  set m0 [expr {min($xc + 0.20, $xv - 0.12)}] ; set m1 [expr {max($xc + 0.65, $xv + 0.38)}]
  r metal1 $m0 [e $yb - 0.77] $m1 [e $yb - 0.30]
  r via1 [e $xv + 0.02] [e $yb - 0.665] [e $xv + 0.28] [e $yb - 0.405]
  r metal2 [e $xv - 0.03] [e $yb - 0.705] [e $xv + 0.33] [e $yb - 0.365]
}
set yb_c [e $gby0 - 0.32 - $WC]           ;# the node capacitors' tap starts at the bottom of the GND bus
nodecap 15.00 $yb_c $WC $LC [e $xr(A) + 0.10]
nodecap 22.90 $yb_c $WC $LC [e $xr(B) + 0.10]   ;# mirror image of A about x = 21.25
# X metal-2 lines from the pad down to the capacitor gate
foreach t {A B} { r metal2 [e $xr($t) + 0.10] [e $yb_c - 0.70] [e $xr($t) + 0.40] 0.10 }

# GND shield on metal 2 between the two X lines (without it Magic extracts 0.21 fF between XA and XB), tied to the GND bus
r metal2 21.05 [e $yb_c - 0.70] 21.45 0.60
r via1 21.12 -1.66 21.38 -1.40

# ---- calibration capacitor: metal-2 plate on X over a metal-1 plate on CAL, above the node capacitor
set py1 [e $gby0 - 1.50] ; set py0 [e $py1 - $PH]
# A: plate extends to the left of the X line; B: to the right
set ax1 [e $xr(A) + 0.40] ; set ax0 [e $ax1 - $PW]
set bx0 [e $xr(B) + 0.10] ; set bx1 [e $bx0 + $PW]
r metal2 $ax0 $py0 $ax1 $py1
r metal2 $bx0 $py0 $bx1 $py1
r metal1 [e $ax0 + 0.20] [e $py0 + 0.20] [e $ax1 - 0.20] [e $py1 - 0.20]
r metal1 [e $bx0 + 0.20] [e $py0 + 0.20] [e $bx1 - 0.20] [e $py1 - 0.20]
set cy [e ($py0 + $py1) / 2.0]
r metal1 14.40 [e $cy - 0.15] [e $ax0 + 0.25] [e $cy + 0.15]
r metal1 [e $bx1 - 0.25] [e $cy - 0.15] 28.10 [e $cy + 0.15]

# ---- bias filter: NROW rows of NFING fingers, gates on a poly bus below each row, contacted at the right end
set fx0 -0.50
set rw [e 0.60 + $NFING * $LF + ($NFING - 1) * 0.60]
set fx1 [e $fx0 + $rw]
set ftop [e $yb_c - 1.20]                  ;# top of the first row's tap
set pitch [e $WF + 2.00]
for {set i 0} {$i < $NROW} {incr i} {
  set yb [e $ftop - 0.74 - $WF - $i * $pitch]
  set yt [e $yb + $WF]
  r ndiff $fx0 $yb $fx1 $yt
  for {set f 0} {$f < $NFING} {incr f} {
    set g0 [e $fx0 + 0.30 + $f * ($LF + 0.60)]
    r poly $g0 [e $yb - 0.60] [e $g0 + $LF] [e $yt + 0.13]
  }
  # contact columns: both ends and every gap
  set cols [list [e $fx0 + 0.04] [e $fx1 - 0.21]]
  for {set f 1} {$f < $NFING} {incr f} { lappend cols [e $fx0 + 0.30 + $f * ($LF + 0.60) - 0.385] }
  foreach c $cols {
    r ndiffc $c [e $yb + 0.06] [e $c + 0.17] [e $yt - 0.06]
    r locali $c [e $yb - 0.05] [e $c + 0.17] [e $yt + 0.70]
  }
  # tap and GND strap, out to the left to the GND spine
  r psubdiff $fx0 [e $yt + 0.32] $fx1 [e $yt + 0.74]
  r psubdiffcont [e $fx0 + 0.10] [e $yt + 0.445] [e $fx1 - 0.10] [e $yt + 0.615]
  r locali -1.55 [e $yt + 0.36] $fx1 [e $yt + 0.70]
  r viali -1.50 [e $yt + 0.445] -1.33 [e $yt + 0.615]
  # poly bus and its contact to the VB spine on the right
  r poly $fx0 [e $yb - 0.90] [e $fx1 + 1.15] [e $yb - 0.50]
  r polycont [e $fx1 + 0.90] [e $yb - 0.785] [e $fx1 + 1.07] [e $yb - 0.615]
  r locali [e $fx1 + 0.82] [e $yb - 0.785] [e $fx1 + 1.50] [e $yb - 0.615]
  r viali [e $fx1 + 1.25] [e $yb - 0.785] [e $fx1 + 1.42] [e $yb - 0.615]
  set ylast [e $yb - 0.90]
}
# GND spine (left) and VB spine (right) on metal 1
r metal1 -1.65 [e $ftop - 0.45 - ($NROW - 1) * $pitch] -1.25 $gby0
set vx0 [e $fx1 + 1.15] ; set vx1 [e $fx1 + 1.55]
r metal1 $vx0 [e $ylast + 0.0] $vx1 -0.37
# VB rail of the channel extended to the spine
r metal1 [e $xr(B) + 0.60] -0.66 $vx1 -0.37

pin VDD metal1 10.0 3.81 11.0 4.10
pin GND metal1 8.0 $gby0 9.0 $gby1
pin C1 locali 3.25 2.4 3.42 3.0
foreach t {A B} {
  pin PRE$t locali [e $xr($t) + 0.465] 1.99 [e $xr($t) + 0.635] 2.32
  pin X$t locali [e $xr($t) + 0.54] 0.60 [e $xr($t) + 0.71] 0.90
}
pin VB metal1 $vx0 -10.0 $vx1 -9.0
pin CALA metal1 14.40 [e $cy - 0.15] 14.90 [e $cy + 0.15]
pin CALB metal1 27.60 [e $cy - 0.15] 28.10 [e $cy + 0.15]

box -200um -200um 200um 200um
drc style drc(full)
drc on ; drc check ; drc catchup
set rules {}
foreach {msg boxes} [drc listall why] { lappend rules "$msg  @ [lrange $boxes 0 2]" }
puts "DRC xc19_channel_caps violations=[llength $rules]"
foreach x $rules { puts "   $x" }
drc off
save xc19_channel_caps
gds write xc19_channel_caps.gds
extract all
ext2spice lvs
ext2spice -o xc19_channel_caps.lvs.spice
ext2spice cthresh 0
ext2spice rthresh infinite
ext2spice -o xc19_channel_caps.pex.spice
select top cell ; puts "BBOX [box values]"
quit -noprompt
