# SPDX-License-Identifier: Apache-2.0
# Test layouts for lod_annotate.py. Geometry only: no contacts, not meant to be DRC clean or fabricated.
# Each cell has diffusion lengths known by construction (see expected values in run.py).
drc off
proc fin {} { upvar name name ; save $name ; extract all ; ext2spice lvs ; ext2spice -o $name.spice }
# audit pair: symmetric 0.30 and 3.0
foreach {name sa} {sym030 0.30 sym300 3.0} {
  cellname create $name ; load $name
  box 0um 0um [expr {2*$sa+0.15}]um 0.42um ; paint ndiff
  box ${sa}um -0.13um [expr {$sa+0.15}]um 0.55um ; paint poly
  fin
}
# asymmetric: 0.30 left, 1.00 right
set name asym ; cellname create $name ; load $name
box 0um 0um 1.45um 0.42um ; paint ndiff
box 0.30um -0.13um 0.45um 0.55um ; paint poly
fin
# vertical channel: 0.50 below, 2.00 above
set name vert ; cellname create $name ; load $name
box 0um 0um 0.42um 2.65um ; paint ndiff
box -0.13um 0.50um 0.55um 0.65um ; paint poly
fin
# two fingers sharing the middle diffusion
set name twofinger ; cellname create $name ; load $name
box 0um 0um 1.50um 0.42um ; paint ndiff
box 0.40um -0.13um 0.55um 0.55um ; paint poly
box 0.95um -0.13um 1.10um 0.55um ; paint poly
fin
# L-shaped diffusion: W = 1.0; left side is 0.30 long on the lower half and 2.00 on the upper half; right side 0.50
set name lshape ; cellname create $name ; load $name
box 1.70um 0um 2.65um 1.0um ; paint ndiff
box 0um 0.5um 2.65um 1.0um ; paint ndiff
box 2.00um -0.13um 2.15um 1.13um ; paint poly
fin
# pfet in an nwell: 0.30 left, 0.60 right
set name pfet ; cellname create $name ; load $name
box -0.5um -0.5um 1.55um 0.92um ; paint nwell
box 0um 0um 1.05um 0.42um ; paint pdiff
box 0.30um -0.13um 0.45um 0.55um ; paint poly
fin
# twins: one gate line over two diffusion islands wired in parallel, 0.30 and 1.00 long on both sides.
# Same gate, same source and drain nodes, same W/L: only the recorded areas tell them apart.
set name twins ; cellname create $name ; load $name
box 0um 0um 0.75um 0.42um ; paint ndiff
box -0.70um 1.0um 1.45um 1.42um ; paint ndiff
box 0.30um -0.13um 0.45um 1.55um ; paint poly
foreach x {0.04 0.54} {
  box ${x}um 0.06um [expr {$x+0.17}]um 0.36um ; paint ndiffc
  box ${x}um 1.06um [expr {$x+0.17}]um 1.36um ; paint ndiffc
  box ${x}um 0.06um [expr {$x+0.17}]um 1.36um ; paint li1
}
fin
quit -noprompt
