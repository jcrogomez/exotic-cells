#!/bin/bash
# SPDX-License-Identifier: Apache-2.0
# Runs the KLayout sky130A DRC deck on the GDS written by scan.tcl for the values given.
#   ./klayout_points.sh out <probe> <v> [<v> ...]      (inside the tools image, PDK at /pdk)
out=$(cd "$1" && pwd); probe=$2; shift 2
for v in "$@"; do
  cell=${probe}_${v/./p}
  klayout -b -r /pdk/libs.tech/klayout/drc/sky130A_mr.drc -rd input=$out/$cell.gds -rd report=$out/$cell.lyrdb -rd topcell=$cell \
    -rd feol=true -rd beol=true -rd offgrid=true -rd seal=false -rd floating_met=false >/dev/null 2>&1
done
