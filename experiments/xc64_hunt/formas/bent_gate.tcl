# L-shaped gate on a 2 x 2 um diffusion: vertical leg at x 0.80..0.95 up to y = v + 0.15, then right along y = v..v+0.15.
# v >= 2.08: the horizontal leg is on field above the diffusion (ordinary straight gate with a jog outside).
source formas/tap.tcl
set lo 0.600 ; set hi 2.300 ; set step 0.020
proc draw {v} {
  box 0um 0um 2.0um 2.0um ; paint ndiff
  box 0.80um -0.13um 0.95um [expr {$v + 0.15}]um ; paint poly
  box 0.80um ${v}um 2.13um [expr {$v + 0.15}]um ; paint poly
  cont 0.20 0.10 0.30
  cont 1.40 0.10 0.30
  tap 0.2 -1.3
}
