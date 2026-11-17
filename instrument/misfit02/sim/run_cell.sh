#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Extracts the built cell at two levels from its GDS and times it at every level, corner, temperature and supply of cell_sim.py.
# Usage: SKY130A=<path to sky130A> ./run_cell.sh [cell build dir] [output dir]
set -e
HERE=$(cd "$(dirname "$0")" && pwd); ROOT=$(cd "$HERE/../../.." && pwd)
B=$(cd "${1:-$HERE/../cell/build}" && pwd); O=${2:-$HERE/../results/cell}; mkdir -p "$O"; O=$(cd "$O" && pwd)
: "${SKY130A:?}"
cp "$B/misfit_tcell.gds" "$O/" && cp "$HERE/../cell/ref.spice" "$O/sch.spice" && python3 "$HERE/cell_sim.py" "$O"
REL=${O#$ROOT/}
docker run --rm -v "$ROOT":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c "
  cd /work/$REL && mkdir -p x && cd x
  cat > e.tcl <<TCL
drc off
gds read ../misfit_tcell.gds
load misfit_tcell
select top cell
extract all
ext2spice lvs
ext2spice -o ../dev.spice
ext2spice cthresh 0
ext2spice -o ../c.spice
quit -noprompt
TCL
  magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc e.tcl > ../extract.txt 2>&1; cd ..
  echo \"devices \$(grep -c '^X' dev.spice) | capacitors in c.spice \$(grep -c '^C' c.spice)\"
  for d in t_*.sp; do /work/tools/ngspice_pdk.sh \$d > \${d%.sp}.txt 2>&1 || echo FAILED \$d; done" 2>&1 | grep -v "^\[INFO\]" || true
grep -h "^CELL" "$O"/t_*.txt | tee "$O/cell_times.txt"
