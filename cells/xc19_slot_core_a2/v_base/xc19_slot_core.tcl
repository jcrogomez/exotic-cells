# SPDX-License-Identifier: Apache-2.0
# MISFIT-03 etapa a: xc19_slot_core, the analog part of the XC-19 slot (pre-registration MISFIT-03_2026-11-23_slot_xc19.md
# + amendment 1). Everything of xc19_channel_caps (bias, device A and twin B, node capacitors, bias filter, CAL plates), plus:
#   - xc19_read_s: the readout cell with an nfet 0.84/0.15 switch in series with the source of the device under test, in its
#     own diffusion (the DUT diffusion and its LOD are unchanged). Gate: DUTA / DUTB.
#   - the bias chain's supply is a separate pin, VBIAS (it is not joined to VDD), so the slot can switch its bias off.
#   - per node, a block: three pfet 0.42/0.15 switches (S0 without plate, S1 and S2 with one metal-2-over-metal-1 plate each),
#     a reference discharge of 12 minimum nfets (2 in series x 6 in parallel, 0.30 um of diffusion each side) gated by VB,
#     with an nfet 0.84/0.15 switch (REFA / REFB), and an inverter (nfet 0.65/0.15, pfet 1.00/0.15) whose output is XA_OUT /
#     XB_OUT. Block B is to the right of the channel, block A to the left (mirror image). S2 of B is tied off to VDD.
# Run from this folder inside the tools image (reads ../xc19_bias): magic -dnull -noconsole -rcfile <magicrc> xc19_slot_core.tcl
proc r {layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; paint $layer }
proc pin {name layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; label $name FreeSans 20 0 0 0 c $layer ; port make }
proc e {args} { return [expr $args] }
drc off

# =====================================================================================================================
# 1. readout cell with source switch (same as xc19_read above y = -0.93; new below)
cellname create xc19_read_s ; load xc19_read_s
r ndiff 0 0 0.75 0.42
r poly 0.30 -0.29 0.45 0.55
r ndiffc 0.04 0.06 0.21 0.36
r ndiffc 0.54 0.06 0.71 0.36
r poly 0.30 -0.62 0.64 -0.29
r polycont 0.39 -0.54 0.56 -0.37
r locali 0.39 -0.62 0.56 -0.29
r psubdiff 1.19 0 1.61 0.42
r psubdiffcont 1.315 0.06 1.485 0.36
r nwell -0.30 1.10 2.00 2.60
r pdiff 0 1.40 1.10 1.82
r poly 0.30 1.27 0.80 1.95
r pfethvt 0.30 1.40 0.80 1.82
r pdiffc 0.04 1.46 0.21 1.76
r pdiffc 0.89 1.46 1.06 1.76
r poly 0.415 1.95 0.685 2.37
r polycont 0.465 2.07 0.635 2.24
r locali 0.465 1.99 0.635 2.32
r nsubdiff 1.39 1.40 1.81 1.82
r nsubdiffcont 1.515 1.46 1.685 1.76
r locali 0.54 -0.02 0.71 1.20
r locali 0.54 1.03 1.06 1.20
r locali 0.89 1.03 1.06 1.84
r locali 0.04 1.38 0.21 2.67
r locali 0.04 2.50 1.685 2.67
r locali 1.515 1.38 1.685 2.67
# DUT source strap: down to the drain of the switch (no longer to the tap)
r locali 0.04 -1.98 0.21 0.44
# source switch, nfet 0.84/0.15, own diffusion
r ndiff 0 -1.96 0.75 -1.12
r poly 0.30 -2.09 0.45 -0.99
r ndiffc 0.04 -1.90 0.21 -1.18
r ndiffc 0.54 -1.90 0.71 -1.18
r poly 0.30 -2.62 0.64 -2.09
r polycont 0.39 -2.54 0.56 -2.37
r locali 0.39 -2.62 0.56 -2.29
# switch source up, across to the tap strap: GND
r locali 0.54 -1.98 0.71 -0.93
r locali 0.54 -1.10 1.485 -0.93
r locali 1.315 -1.10 1.485 0.44
save xc19_read_s

# =====================================================================================================================
# 2. channel: bias + two xc19_read_s, wiring as xc19_channel.tcl except VDD of the bias chain (VBIAS)
addpath ../xc19_bias
cellname create xc19_slot_core_h ; load xc19_slot_core_h
box -1.01um -0.66um -1.01um -0.66um ; getcell xc19_bias
set xr(A) 19.5 ; set xr(B) 22.5
foreach t {A B} { box [e $xr($t) - 0.30]um -2.62um [e $xr($t) - 0.30]um -2.62um ; getcell xc19_read_s }
flatten xc19_slot_core
load xc19_slot_core
box -200um -200um 200um 200um ; erase labels
r nwell [e $xr(A) + 2.00] 1.10 [e $xr(B) - 0.30] 2.60
r metal1 17.40 -0.66 [e $xr(B) + 0.70] -0.37
foreach t {A B} { r viali [e $xr($t) + 0.39] -0.60 [e $xr($t) + 0.56] -0.43 }
r metal1 18.20 0.66 [e $xr(B) + 1.70] 0.95
foreach t {A B} {
  r locali [e $xr($t) + 1.315] 0.44 [e $xr($t) + 1.485] 0.95
  r viali [e $xr($t) + 1.315] 0.72 [e $xr($t) + 1.485] 0.89
}
# VDD rail (not joined to the bias chain: its top is VBIAS)
r metal1 5.50 3.81 [e $xr(B) + 0.50] 4.10
r locali 5.65 3.47 5.82 3.70
foreach t {A B} {
  r locali [e $xr($t) + 0.04] 2.67 [e $xr($t) + 0.21] 4.10
  r viali [e $xr($t) + 0.04] 3.87 [e $xr($t) + 0.21] 4.04
}

# =====================================================================================================================
# 3. capacitors, as xc19_channel_caps.tcl, everything below the readout cells moved down by D
set D 1.60
set WC 4.30 ; set LC 4.00 ; set NROW 11 ; set NFING 3 ; set WF 5.50 ; set LF 10.0 ; set PW 2.30 ; set PH 0.90
set gby0 [e -1.98 - $D] ; set gby1 [e -1.08 - $D]
r metal1 -1.65 $gby0 28.60 $gby1
# GND of each readout cell (tap strap) down to the bus
foreach t {A B} {
  r locali [e $xr($t) + 1.315] [e $gby1 - 0.32] [e $xr($t) + 1.485] -0.93
  r viali [e $xr($t) + 1.315] [e $gby1 - 0.30] [e $xr($t) + 1.485] [e $gby1 - 0.13]
}
foreach t {A B} {
  set x $xr($t)
  r viali  [e $x + 0.54] 0.05 [e $x + 0.71] 0.22
  r metal1 [e $x + 0.00] -0.06 [e $x + 0.77] 0.34
  r via1   [e $x + 0.12] 0.01 [e $x + 0.38] 0.27
  r metal2 [e $x + 0.07] -0.05 [e $x + 0.43] 0.33
}
proc nodecap {x0 yb W L xv} {
  set xt [e $x0 + $L + 0.60] ; set yt [e $yb + $W]
  r ndiff $x0 $yb $xt $yt
  r poly [e $x0 + 0.30] [e $yb - 0.13] [e $x0 + 0.30 + $L] [e $yt + 0.13]
  r ndiffc [e $x0 + 0.04] [e $yb + 0.06] [e $x0 + 0.21] [e $yt - 0.06]
  r ndiffc [e $xt - 0.21] [e $yb + 0.06] [e $xt - 0.04] [e $yt - 0.06]
  r locali [e $x0 + 0.04] [e $yb - 0.05] [e $x0 + 0.21] [e $yt + 0.70]
  r locali [e $xt - 0.21] [e $yb - 0.05] [e $xt - 0.04] [e $yt + 0.70]
  r psubdiff $x0 [e $yt + 0.32] $xt [e $yt + 0.74]
  r psubdiffcont [e $x0 + 0.10] [e $yt + 0.445] [e $xt - 0.10] [e $yt + 0.615]
  r locali $x0 [e $yt + 0.36] $xt [e $yt + 0.70]
  r viali [e $x0 + 0.60] [e $yt + 0.445] [e $x0 + 0.77] [e $yt + 0.615]
  r viali [e $xt - 0.77] [e $yt + 0.445] [e $xt - 0.60] [e $yt + 0.615]
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
set yb_c [e $gby0 - 0.32 - $WC]
nodecap 15.00 $yb_c $WC $LC [e $xr(A) + 0.10]
nodecap 22.90 $yb_c $WC $LC [e $xr(B) + 0.10]
foreach t {A B} { r metal2 [e $xr($t) + 0.10] [e $yb_c - 0.70] [e $xr($t) + 0.40] 0.10 }
r metal2 21.05 [e $yb_c - 0.70] 21.45 0.60
r via1 21.12 [e $gby0 + 0.32] 21.38 [e $gby0 + 0.58]
set py1 [e $gby0 - 1.50] ; set py0 [e $py1 - $PH]
set ax1 [e $xr(A) + 0.40] ; set ax0 [e $ax1 - $PW]
set bx0 [e $xr(B) + 0.10] ; set bx1 [e $bx0 + $PW]
r metal2 $ax0 $py0 $ax1 $py1
r metal2 $bx0 $py0 $bx1 $py1
r metal1 [e $ax0 + 0.20] [e $py0 + 0.20] [e $ax1 - 0.20] [e $py1 - 0.20]
r metal1 [e $bx0 + 0.20] [e $py0 + 0.20] [e $bx1 - 0.20] [e $py1 - 0.20]
set cy [e ($py0 + $py1) / 2.0]
r metal1 14.40 [e $cy - 0.15] [e $ax0 + 0.25] [e $cy + 0.15]
r metal1 [e $bx1 - 0.25] [e $cy - 0.15] 28.10 [e $cy + 0.15]
set fx0 -0.50
set rw [e 0.60 + $NFING * $LF + ($NFING - 1) * 0.60]
set fx1 [e $fx0 + $rw]
set ftop [e $yb_c - 1.20]
set pitch [e $WF + 2.00]
for {set i 0} {$i < $NROW} {incr i} {
  set yb [e $ftop - 0.74 - $WF - $i * $pitch]
  set yt [e $yb + $WF]
  r ndiff $fx0 $yb $fx1 $yt
  for {set f 0} {$f < $NFING} {incr f} {
    set g0 [e $fx0 + 0.30 + $f * ($LF + 0.60)]
    r poly $g0 [e $yb - 0.60] [e $g0 + $LF] [e $yt + 0.13]
  }
  set cols [list [e $fx0 + 0.04] [e $fx1 - 0.21]]
  for {set f 1} {$f < $NFING} {incr f} { lappend cols [e $fx0 + 0.30 + $f * ($LF + 0.60) - 0.385] }
  foreach c $cols {
    r ndiffc $c [e $yb + 0.06] [e $c + 0.17] [e $yt - 0.06]
    r locali $c [e $yb - 0.05] [e $c + 0.17] [e $yt + 0.70]
  }
  r psubdiff $fx0 [e $yt + 0.32] $fx1 [e $yt + 0.74]
  r psubdiffcont [e $fx0 + 0.10] [e $yt + 0.445] [e $fx1 - 0.10] [e $yt + 0.615]
  r locali -1.55 [e $yt + 0.36] $fx1 [e $yt + 0.70]
  r viali -1.50 [e $yt + 0.445] -1.33 [e $yt + 0.615]
  r poly $fx0 [e $yb - 0.90] [e $fx1 + 1.15] [e $yb - 0.50]
  r polycont [e $fx1 + 0.90] [e $yb - 0.785] [e $fx1 + 1.07] [e $yb - 0.615]
  r locali [e $fx1 + 0.82] [e $yb - 0.785] [e $fx1 + 1.50] [e $yb - 0.615]
  r viali [e $fx1 + 1.25] [e $yb - 0.785] [e $fx1 + 1.42] [e $yb - 0.615]
  set ylast [e $yb - 0.90]
}
r metal1 -1.65 [e $ftop - 0.45 - ($NROW - 1) * $pitch] -1.25 $gby0
set vx0 [e $fx1 + 1.15] ; set vx1 [e $fx1 + 1.55]
r metal1 $vx0 [e $ylast + 0.0] $vx1 -0.37
r metal1 [e $xr(B) + 0.60] -0.66 $vx1 -0.37

# =====================================================================================================================
# 4. one block per node. Local x (lx) grows away from the channel: global x = BX + S * lx. Global y is used as is.
set XH0 -1.62 ; set XH1 -1.32
set PWU 0.95 ; set PHU 0.90 ;# unit plate (metal 2), sized with the extraction (medir_u_barrido.txt): u(S2) = 0.53 fF
if {[info exists ::env(PWU)]} { set PWU $::env(PWU) }
if {[info exists ::env(PHU)]} { set PHU $::env(PHU) }         ;# horizontal X line on metal 2, channel to block
proc R {layer lx0 y0 lx1 y1} {
  global BX S
  set a [e $BX + $S * $lx0] ; set b [e $BX + $S * $lx1]
  r $layer [expr {min($a,$b)}] $y0 [expr {max($a,$b)}] $y1
}
proc RP {name layer lx0 y0 lx1 y1} {
  global BX S
  set a [e $BX + $S * $lx0] ; set b [e $BX + $S * $lx1]
  pin $name $layer [expr {min($a,$b)}] $y0 [expr {max($a,$b)}] $y1
}
# horizontal nfet/pfet of length L, width W: diffusion lx..lx+L+0.60 by y..y+W. Gate poly from y-0.13 to y+W+0.13.
proc fet {dtype ctype lx y W L} {
  R $dtype $lx $y [e $lx + $L + 0.60] [e $y + $W]
  R poly [e $lx + 0.30] [e $y - 0.13] [e $lx + 0.30 + $L] [e $y + $W + 0.13]
  R $ctype [e $lx + 0.04] [e $y + 0.06] [e $lx + 0.21] [e $y + $W - 0.06]
  R $ctype [e $lx + $L + 0.39] [e $y + 0.06] [e $lx + $L + 0.56] [e $y + $W - 0.06]
  R locali [e $lx + 0.04] [e $y - 0.02] [e $lx + 0.21] [e $y + $W + 0.02]
  R locali [e $lx + $L + 0.39] [e $y - 0.02] [e $lx + $L + 0.56] [e $y + $W + 0.02]
}
# metal1 pad with a via1 and the metal2 above it, centred on (lx, y)
proc v1 {lx y} {
  R metal1 [e $lx - 0.20] [e $y - 0.20] [e $lx + 0.20] [e $y + 0.20]
  R via1 [e $lx - 0.13] [e $y - 0.13] [e $lx + 0.13] [e $y + 0.13]
  R metal2 [e $lx - 0.18] [e $y - 0.18] [e $lx + 0.18] [e $y + 0.18]
}
proc block {t} {
  global BX S XH0 XH1 gby0 gby1
  # ---- X bus (metal 2, vertical) and its connection to the channel's X line
  R metal2 0.30 -5.90 0.66 1.80
  # ---- rails extended over the block: VDD, GND, VB (metal 1) and the bottom GND bus
  R metal1 -0.40 3.81 9.70 4.10
  R metal1 -0.40 0.66 10.60 0.95
  R metal1 -0.40 -0.66 9.70 -0.37
  R metal1 -0.40 $gby0 10.60 $gby1
  # ---- region P: inverter and its taps (the plate switches are in region Q, next to their plates)
  R nwell 5.20 2.02 7.70 3.40
  # X line on metal 1 from the bus to the inverter gate
  R metal1 0.25 1.40 5.30 1.70
  R metal1 0.25 1.30 0.75 1.80
  R via1 0.35 1.42 0.61 1.68
  # inverter at lx 5.60: nfet 0.65/0.15 at y 1.03..1.68, pfet 1.00/0.15 at y 2.20..3.20, common gate
  set li 5.60
  fet ndiff ndiffc $li 1.03 0.65 0.15
  fet pdiff pdiffc $li 2.20 1.00 0.15
  # MISFIT-03 amendment 2 (env INVHVT=1): the inverter pfet becomes hvt (P2: off-state leakage with en = 0)
  if {[info exists ::env(INVHVT)] && $::env(INVHVT)} { R pfethvt [e $li + 0.30] 2.20 [e $li + 0.45] 3.20 }
  R poly [e $li + 0.30] 0.90 [e $li + 0.45] 3.33
  R poly [e $li - 0.60] 1.80 [e $li + 0.45] 2.10
  R polycont [e $li - 0.50] 1.865 [e $li - 0.33] 2.035
  R locali [e $li - 0.58] 1.40 [e $li - 0.25] 2.10
  R viali [e $li - 0.50] 1.465 [e $li - 0.33] 1.635
  # output: both drains (far contacts)
  R locali [e $li + 0.54] 1.03 [e $li + 0.71] 3.20
  RP X${t}_OUT locali [e $li + 0.54] 1.80 [e $li + 0.71] 2.10
  # nfet source to GND rail, pfet source to VDD rail
  R locali [e $li + 0.04] 0.66 [e $li + 0.21] 1.68
  R viali [e $li + 0.04] 0.72 [e $li + 0.21] 0.89
  R locali [e $li + 0.04] 2.20 [e $li + 0.21] 4.10
  R viali [e $li + 0.04] 3.87 [e $li + 0.21] 4.04
  # substrate tap next to the inverter nfet, n-well tap
  R psubdiff 6.70 1.03 7.12 1.45
  R psubdiffcont 6.825 1.09 6.995 1.39
  R locali 6.825 0.66 6.995 1.47
  R viali 6.825 0.72 6.995 0.89
  R nsubdiff 7.00 2.20 7.42 2.62
  R nsubdiffcont 7.125 2.26 7.295 2.56
  R locali 7.125 2.18 7.295 4.10
  R viali 7.125 3.87 7.295 4.04
  # ---- region Q (below the bus): three pfet switches next to their plates, n-well tap fed by a VDD riser (metal 2)
  set yq -4.62
  R nwell 0.80 [e $yq - 0.20] 7.10 [e $yq + 0.70]
  set sw {1.00 2.40 3.80}
  set k 0
  foreach lx $sw {
    fet pdiff pdiffc $lx $yq 0.42 0.15
    R poly [e $lx + 0.215] [e $yq + 0.55] [e $lx + 0.535] [e $yq + 1.10]
    R polycont [e $lx + 0.29] [e $yq + 0.77] [e $lx + 0.46] [e $yq + 0.94]
    R locali [e $lx + 0.29] [e $yq + 0.69] [e $lx + 0.46] [e $yq + 1.04]
    # drain (near contact) down to the X strap (li)
    R locali [e $lx + 0.04] [e $yq - 0.43] [e $lx + 0.21] [e $yq + 0.44]
    # source (far contact) through a via straight down to its plate (S1, S2); S0 is left open
    if {$k > 0} {
      R viali [e $lx + 0.54] [e $yq + 0.125] [e $lx + 0.71] [e $yq + 0.295]
      v1 [e $lx + 0.625] [e $yq + 0.21]
      R metal2 [e $lx + 0.445] -5.20 [e $lx + 0.805] [e $yq + 0.21]
    }
    if {$t eq "B" && $k == 2} {
      # S2 of B: gate tied to VDD (the n-well tap), it exists only to match the junctions of A
      R locali [e $lx + 0.29] [e $yq + 0.69] 6.775 [e $yq + 0.86]
    } else {
      RP S${t}${k}B locali [e $lx + 0.29] [e $yq + 0.69] [e $lx + 0.46] [e $yq + 1.04]
    }
    incr k
  }
  # X strap (li) under the switches, to the X bus
  R locali 0.30 [e $yq - 0.43] 4.85 [e $yq - 0.26]   ;# past the S2 riser too: S1 and S2 see the same coupling to X
  R viali 0.40 [e $yq - 0.43] 0.57 [e $yq - 0.26]
  R metal1 0.25 [e $yq - 0.58] 0.75 [e $yq - 0.11]
  R via1 0.35 [e $yq - 0.475] 0.61 [e $yq - 0.215]
  # n-well tap and the VDD riser from the VDD rail
  R nsubdiff 6.40 $yq 6.82 [e $yq + 0.42]
  R nsubdiffcont 6.525 [e $yq + 0.06] 6.695 [e $yq + 0.36]
  R locali 6.525 [e $yq - 0.02] 6.775 [e $yq + 0.86]
  R viali 6.525 [e $yq + 0.125] 6.695 [e $yq + 0.295]
  v1 6.61 [e $yq + 0.21]
  v1 6.61 3.955
  R metal2 6.43 [e $yq + 0.21] 6.79 3.955
  # ---- plates for S1 and S2: metal 2 on the switch source over metal 1 on GND (joined to the bus)
  # identical plates of PWU x PHU centred on each riser; bottom plates joined to a GND riser (metal 1) beside them
  global PWU PHU
  foreach c {3.025 4.425} {
    R metal2 [e $c - $PWU / 2.0] [e -5.20 - $PHU] [e $c + $PWU / 2.0] -5.20
    R metal1 [e $c - $PWU / 2.0 + 0.20] [e -5.40 - $PHU + 0.40] [e $c + $PWU / 2.0 - 0.20] -5.40
  }
  R metal1 [e 3.025 - $PWU / 2.0 + 0.20] [e -5.40 - $PHU + 0.40] 5.70 [e -5.40 - $PHU + 0.60]
  R metal1 5.40 [e -5.40 - $PHU + 0.40] 5.70 $gby0
  # MISFIT-03 amendment 2 (env SANDW=1): a metal-3 lid on GND over both plates (m1 / m2 / m3 sandwich), fed from the GND riser
  # through a via1 + via2 stack at lx 5.55 beside plate S2
  if {[info exists ::env(SANDW)] && $::env(SANDW)} {
    set ys [e -5.20 - $PHU / 2.0]
    v1 5.55 $ys
    R via2 [e 5.55 - 0.10] [e $ys - 0.10] [e 5.55 + 0.10] [e $ys + 0.10]
    R metal3 [e 3.025 - $PWU / 2.0 - 0.20] [e -5.20 - $PHU - 0.20] 5.85 -5.00
  }
  # ---- reference: 6 columns, top row T (drain -> X) and bottom row Bt (source -> SR), one poly per column
  set yT -6.50 ; set yB [e $yT - 1.66]
  for {set i 0} {$i < 6} {incr i} {
    set o [e 1.20 + 1.1 * $i]
    foreach y [list $yT $yB] {
      R ndiff $o $y [e $o + 0.75] [e $y + 0.42]
      R ndiffc [e $o + 0.04] [e $y + 0.06] [e $o + 0.21] [e $y + 0.36]
      R ndiffc [e $o + 0.54] [e $y + 0.06] [e $o + 0.71] [e $y + 0.36]
      R locali [e $o + 0.04] [e $y - 0.02] [e $o + 0.21] [e $y + 0.44]
      R locali [e $o + 0.54] [e $y - 0.02] [e $o + 0.71] [e $y + 0.44]
    }
    R poly [e $o + 0.30] [e $yB - 0.13] [e $o + 0.45] [e $yT + 0.55]
    R poly [e $o + 0.30] [e $yB + 0.71] [e $o + 0.64] [e $yT - 0.29]
    R polycont [e $o + 0.39] [e $yT - 0.54] [e $o + 0.56] [e $yT - 0.37]
    R locali [e $o + 0.39] [e $yB + 0.71] [e $o + 0.56] [e $yT - 0.29]
    # T: drain up to the X strap; source to the M strap (metal 1)
    R locali [e $o + 0.04] [e $yT + 0.42] [e $o + 0.21] [e $yT + 0.92]
    R viali [e $o + 0.54] [e $yT + 0.125] [e $o + 0.71] [e $yT + 0.295]
    # Bt: drain (far contact) to the M strap; source (near contact) down to the SR strap
    R viali [e $o + 0.54] [e $yB + 0.125] [e $o + 0.71] [e $yB + 0.295]
    R locali [e $o + 0.04] [e $yB - 0.60] [e $o + 0.21] [e $yB + 0.00]
  }
  # X strap (li) over the top row, to the X bus
  R locali 0.30 [e $yT + 0.75] 7.00 [e $yT + 0.92]
  R viali 0.40 [e $yT + 0.75] 0.57 [e $yT + 0.92]
  R metal1 0.25 [e $yT + 0.60] 0.75 [e $yT + 1.05]
  R via1 0.35 [e $yT + 0.70] 0.61 [e $yT + 0.96]
  # M straps (metal 1) and the riser joining them at the far end
  R metal1 1.68 [e $yT + 0.06] 8.20 [e $yT + 0.36]
  R metal1 1.68 [e $yB + 0.06] 8.20 [e $yB + 0.36]
  R metal1 7.90 [e $yB + 0.06] 8.20 [e $yT + 0.36]
  # VB strap (li) through the gate pads, out to the VB riser (metal 2 from the VB rail)
  R locali 1.59 [e $yT - 0.54] 9.30 [e $yT - 0.37]
  R viali 9.00 [e $yT - 0.54] 9.17 [e $yT - 0.37]
  v1 9.08 [e $yT - 0.455]
  v1 9.08 -0.515
  R metal2 8.90 [e $yT - 0.455] 9.26 -0.515
  # SR strap (li) under the bottom row, to the reference switch
  R locali 1.24 [e $yB - 0.60] 7.80 [e $yB - 0.43]
  set ys [e $yB - 1.86]
  fet ndiff ndiffc 1.20 $ys 0.84 0.15
  R locali 1.24 [e $ys + 0.84] 1.41 [e $yB - 0.43]
  R poly 1.50 [e $ys - 0.68] 1.84 [e $ys - 0.13]
  R polycont 1.59 [e $ys - 0.56] 1.76 [e $ys - 0.39]
  R locali 1.59 [e $ys - 0.65] 1.76 [e $ys - 0.30]
  RP REF$t locali 1.59 [e $ys - 0.65] 1.76 [e $ys - 0.30]
  # switch source to a tap and to the GND riser (metal 1 up to the bus)
  R psubdiff 2.60 $ys 3.02 [e $ys + 0.42]
  R psubdiffcont 2.725 [e $ys + 0.06] 2.895 [e $ys + 0.36]
  R locali 1.74 [e $ys + 0.00] 2.895 [e $ys + 0.17]
  R locali 2.725 [e $ys - 0.02] 2.895 [e $ys + 0.44]
  R viali 2.725 [e $ys + 0.125] 2.895 [e $ys + 0.295]
  R metal1 2.60 [e $ys + 0.05] 10.60 [e $ys + 0.37]
  R metal1 10.30 [e $ys + 0.05] 10.60 $gby0
  v1 10.08 [e $gby1 - 0.45]
  v1 10.08 0.805
  R metal2 9.90 [e $gby1 - 0.45] 10.26 0.805
}
# block B to the right, block A to the left (mirror)
set BX 34.0 ; set S 1 ; block B
r metal2 [e $xr(B) + 0.10] $XH0 34.66 $XH1
# dummy XB stub (metal 2): the XA line is 11.5 um longer than XB's (block A sits farther from its reader); the stub
# matches the extracted X-to-ground capacitance of the two nodes. Length XBS sized with the extraction (medir_u.py)
set XBS 11.40 ; if {[info exists ::env(XBS)]} { set XBS $::env(XBS) }
set XBH 0.80 ; if {[info exists ::env(XBH)]} { set XBH $::env(XBH) }
if {$XBS > 0} { r metal2 [e $xr(B) + 0.40] [e -2.00 - $XBH] [e $xr(B) + 0.40 + $XBS] -2.00 }
r metal1 [e $xr(B) + 0.50] 3.81 34.0 4.10
r metal1 [e $xr(B) + 1.70] 0.66 34.0 0.95
r metal1 $vx1 -0.66 34.0 -0.37
set BX -3.0 ; set S -1 ; block A
r metal2 -3.66 $XH0 [e $xr(A) + 0.40] $XH1
r metal1 -3.0 3.81 5.50 4.10
r metal1 -3.0 0.66 -1.00 0.95
r metal1 -3.0 -0.66 -0.56 -0.37
r metal1 -3.0 $gby0 -1.65 $gby1

# =====================================================================================================================
# 5. ports
pin VDD metal1 10.0 3.81 11.0 4.10
pin GND metal1 8.0 0.66 9.0 0.95
pin VBIAS locali 5.65 3.20 5.82 3.47
pin C1 locali 3.25 2.4 3.42 3.0
foreach t {A B} {
  pin PRE$t locali [e $xr($t) + 0.465] 1.99 [e $xr($t) + 0.635] 2.32
  pin X$t locali [e $xr($t) + 0.54] 0.60 [e $xr($t) + 0.71] 0.90
  pin DUT$t locali [e $xr($t) + 0.39] -2.62 [e $xr($t) + 0.56] -2.29
}
pin VB metal1 $vx0 -10.0 $vx1 -9.0
pin CALA metal1 14.40 [e $cy - 0.15] 14.90 [e $cy + 0.15]
pin CALB metal1 27.60 [e $cy - 0.15] 28.10 [e $cy + 0.15]

box -200um -200um 200um 200um
drc style drc(full)
drc on ; drc check ; drc catchup
set rules {}
foreach {msg boxes} [drc listall why] { lappend rules "$msg  @ [lrange $boxes 0 3]" }
puts "DRC xc19_slot_core violations=[llength $rules]"
foreach x $rules { puts "   $x" }
drc off
save xc19_slot_core
gds write xc19_slot_core.gds
extract all
ext2spice lvs
ext2spice -o xc19_slot_core.lvs.spice
ext2spice cthresh 0
ext2spice rthresh infinite
ext2spice -o xc19_slot_core.pex.spice
select top cell ; puts "BBOX [box values]"
set fb [feedback count] ; puts "FEEDBACK $fb"
for {set i 1} {$i <= [expr {min($fb, 40)}]} {incr i} { feedback find $i ; puts "FB [box values] [feedback why]" }
quit -noprompt
