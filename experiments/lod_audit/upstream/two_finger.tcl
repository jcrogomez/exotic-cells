# SPDX-License-Identifier: Apache-2.0
# Probe: two series nfets sharing a 0.50 um middle diffusion; outer diffusion 0.30 um each. Extraction only (no contacts).
# BSIM4 distance from each gate to the far diffusion edge on the shared side: 0.50 + 0.15 + 0.30 = 0.95 um.
drc off
cellname create twof
load twof
box 0um 0um 1.40um 0.42um ; paint ndiff
box 0.30um -0.13um 0.45um 0.55um ; paint poly
box 0.95um -0.13um 1.10um 0.55um ; paint poly
box 0um 0um 0.3um 0.42um ; label S FreeSans 20 0 0 0 c ndiff
box 0.45um 0um 0.95um 0.42um ; label M FreeSans 20 0 0 0 c ndiff
box 1.10um 0um 1.40um 0.42um ; label D FreeSans 20 0 0 0 c ndiff
box 0.30um 0.45um 0.45um 0.55um ; label G1 FreeSans 20 0 0 0 c poly
box 0.95um 0.45um 1.10um 0.55um ; label G2 FreeSans 20 0 0 0 c poly
save twof
extract all
ext2spice lvs
ext2spice -o twof.spice
quit -noprompt
