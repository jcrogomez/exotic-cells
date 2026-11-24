#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# KLayout: deck de fabricación (sky130A_mr.drc, front end + back end + rejilla) y deck completo (sky130A.lydrc) sobre el GDS;
# netgen LVS de la extracción contra ref.spice. Uso: SKY130A=<ruta> ./check.sh
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
: "${SKY130A:?}"
docker run --rm -v "$HERE":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work
  klayout -b -rd input=xc19_slot_core.gds -rd top_cell=xc19_slot_core -rd report=klayout_mr.lyrdb -rd feol=true -rd beol=true \
    -rd offgrid=true -r /pdk/libs.tech/klayout/drc/sky130A_mr.drc > klayout_mr.log 2>&1
  sed "s/^FEOL    = false/FEOL    = true/" /pdk/libs.tech/klayout/drc/sky130A.lydrc > /tmp/sky130A_feol.lydrc
  grep -n "^FEOL" /tmp/sky130A_feol.lydrc
  klayout -b -rd input=xc19_slot_core.gds -rd report=klayout_full.lyrdb -r /tmp/sky130A_feol.lydrc > klayout_full.log 2>&1 || true
  printf "lvs \"xc19_slot_core.lvs.spice xc19_slot_core\" \"ref.spice xc19_slot_core\" /pdk/libs.tech/netgen/sky130A_setup.tcl lvs.rpt\n" > lvs.tcl
  netgen -batch source lvs.tcl > netgen.txt 2>&1
  echo "KLayout mr: $(grep -c "<item>" klayout_mr.lyrdb) | KLayout completo: $(grep -c "<item>" klayout_full.lyrdb 2>/dev/null) | LVS: $(grep -h "Final result" -A1 netgen.txt | tr "\n" " ")"
  grep -o "<category>[^<]*</category>" klayout_mr.lyrdb klayout_full.lyrdb 2>/dev/null | sort | uniq -c | head' 2>&1 | grep -v "^\[INFO\]" || true
