# SPDX-License-Identifier: Apache-2.0
# Extracts every cell of sky130_fd_sc_hd from the layouts shipped with the PDK (flat .mag files), as Magic does for LVS.
foreach f [lsort [glob /pdk/libs.ref/sky130_fd_sc_hd/mag/*.mag]] {
  set c [file rootname [file tail $f]]
  file copy -force $f ./$c.mag
  load $c
  extract all
  ext2spice lvs
  ext2spice -o $c.spice
}
quit -noprompt
