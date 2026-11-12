# SPDX-License-Identifier: Apache-2.0
# XC-19 readout cell: one minimum nfet (the device under test) that discharges node X, and a long high-threshold
# pfet that precharges it. Ports: X (to a library inverter), VB (gate bias), PRE (precharge, active low), VDD, GND.
# Units: um. Run inside the tools image:
#   magic -dnull -noconsole -rcfile <sky130A.magicrc> xc19_read.tcl
proc r {layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; paint $layer }
proc pin {name layer x0 y0 x1 y1} { box ${x0}um ${y0}um ${x1}um ${y1}um ; label $name FreeSans 20 0 0 0 c $layer ; port make }
drc off
cellname create xc19_read ; load xc19_read

# ---- device under test: nfet 0.42/0.15, 0.30 um of diffusion on each side
r ndiff 0 0 0.75 0.42
r poly 0.30 -0.29 0.45 0.55
r ndiffc 0.04 0.06 0.21 0.36
r ndiffc 0.54 0.06 0.71 0.36
# gate pad, offset to the right so that its li clears the source strap
r poly 0.30 -0.62 0.64 -0.29
r polycont 0.39 -0.54 0.56 -0.37
r locali 0.39 -0.62 0.56 -0.29

# ---- substrate tap
r psubdiff 1.19 0 1.61 0.42
r psubdiffcont 1.315 0.06 1.485 0.36

# ---- precharge: pfet_01v8_hvt 0.42/0.50 in its own well
r nwell -0.30 1.10 2.00 2.60
r pdiff 0 1.40 1.10 1.82
r poly 0.30 1.27 0.80 1.95
r pfethvt 0.30 1.40 0.80 1.82
r pdiffc 0.04 1.46 0.21 1.76
r pdiffc 0.89 1.46 1.06 1.76
r poly 0.415 1.95 0.685 2.37
r polycont 0.465 2.07 0.635 2.24
r locali 0.465 1.99 0.635 2.32
# well tap
r nsubdiff 1.39 1.40 1.81 1.82
r nsubdiffcont 1.515 1.46 1.685 1.76

# ---- wiring on local interconnect
# GND: source strap down, across below the gate pad, up to the substrate tap
r locali 0.04 -1.00 0.21 0.44
r locali 0.04 -1.00 1.485 -0.83
r locali 1.315 -1.00 1.485 0.44
# X: nfet drain up to the pfet drain
r locali 0.54 -0.02 0.71 1.20
r locali 0.54 1.03 1.06 1.20
r locali 0.89 1.03 1.06 1.84
# VDD: pfet source up, across above the precharge pad, down to the well tap
r locali 0.04 1.38 0.21 2.67
r locali 0.04 2.50 1.685 2.67
r locali 1.515 1.38 1.685 2.67

pin VB locali 0.39 -0.62 0.56 -0.29
pin PRE locali 0.465 1.99 0.635 2.32
pin X locali 0.54 0.60 0.71 0.90
pin VDD locali 0.60 2.50 1.00 2.67
pin GND locali 0.60 -1.00 1.00 -0.83

box -100um -100um 100um 100um
drc style drc(full)
drc on ; drc check ; drc catchup
set rules {}
foreach {msg boxes} [drc listall why] { lappend rules "$msg  @ $boxes" }
puts "DRC xc19_read violations=[llength $rules]"
foreach x $rules { puts "   $x" }
drc off
save xc19_read
gds write xc19_read.gds
extract all
ext2spice lvs
ext2spice -o xc19_read.lvs.spice
ext2spice cthresh 0
ext2spice rthresh infinite
ext2spice -o xc19_read.pex.spice
quit -noprompt
