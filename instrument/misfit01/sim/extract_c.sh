#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Extracts each final GDS in ../results/pex with Magic at two levels:
#   <top>.dev.spice   devices only (ext2spice lvs)
#   <top>.c.spice     devices + every extracted capacitance (ext2spice cthresh 0), no resistances
# Usage: SKY130A=<path to sky130A> ./extract_c.sh
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
: "${SKY130A:?}"
docker run --rm -v "$HERE/../results/pex":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work
  for g in *.gds; do t=${g%.gds}; mkdir -p x_$t; cd x_$t
    cat > e.tcl <<TCL
drc off
gds read ../$g
load $t
select top cell
extract all
ext2spice lvs
ext2spice -o ../$t.dev.spice
ext2spice cthresh 0
ext2spice -o ../$t.c.spice
quit -noprompt
TCL
    magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc e.tcl > ../$t.extract.txt 2>&1; cd ..
    echo "$t: devices $(grep -c "sky130_fd_pr__" $t.dev.spice) | capacitors in the C netlist $(grep -c "^C" $t.c.spice)"
  done' 2>&1 | grep -v "^\[INFO\]" || true
