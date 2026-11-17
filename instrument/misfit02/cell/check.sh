#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Checks a built time cell: KLayout manufacturing deck (front end, back end, grid) on its GDS, and netgen LVS of the
# extraction against cell/ref.spice (or another reference). Usage: SKY130A=<path> ./check.sh [build dir] [reference]
set -e
HERE=$(cd "$(dirname "$0")" && pwd); B=$(cd "${1:-$HERE/build}" && pwd); REF=${2:-$HERE/ref.spice}
: "${SKY130A:?}"
cp "$REF" "$B/ref_used.spice"
docker run --rm -v "$B":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work
  klayout -b -rd input=misfit_tcell.gds -rd top_cell=misfit_tcell -rd report=klayout_mr.lyrdb -rd feol=true -rd beol=true \
    -rd offgrid=true -r /pdk/libs.tech/klayout/drc/sky130A_mr.drc > klayout_mr.log 2>&1
  cat > lvs.tcl <<TCL
lvs "misfit_tcell.spice misfit_tcell" "ref_used.spice misfit_tcell" /pdk/libs.tech/netgen/sky130A_setup.tcl lvs.rpt
TCL
  netgen -batch source lvs.tcl > netgen.txt 2>&1
  echo "KLayout manufacturing deck: $(grep -c "<item>" klayout_mr.lyrdb) violations | LVS: $(grep -h "Final result" -A1 netgen.txt | tr "\n" " ") | property errors: $(grep -c "property errors" lvs.rpt)"
  grep -o "<category>[^<]*</category>" klayout_mr.lyrdb | sort | uniq -c | head' 2>&1 | grep -v "^\[INFO\]" || true
