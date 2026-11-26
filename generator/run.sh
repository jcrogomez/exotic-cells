#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Generate a matrix from a table and check it: Magic drc(full), KLayout (manufacturing deck and full deck), netgen LVS.
# Usage: run.sh <table.json> <out_dir> [REF=<other reference>] [extra args for matrix.py]. Needs Docker and SKY130A=<path to the PDK>.
set -e
HERE=$(cd "$(dirname "$0")" && pwd); T=$1; OUT=$2; shift 2
: "${SKY130A:?set SKY130A to the sky130A folder of the PDK}"
python3 "$HERE/matrix.py" "$T" "$OUT" "$@" >/dev/null
N=$(python3 -c "import json,sys; print(json.load(open(sys.argv[1]))['name'])" "$T"); OUT=$(cd "$OUT" && pwd); REFF=${REF:-${N}_ref.spice}
docker run --rm -e N="$N" -e REFF="$REFF" -v "$OUT":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work
  magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc $N.tcl > $N.log 2>&1
  klayout -b -rd input=$N.gds -rd top_cell=$N -rd report=klayout_mr.lyrdb -rd feol=true -rd beol=true -rd offgrid=true \
    -r /pdk/libs.tech/klayout/drc/sky130A_mr.drc > klayout_mr.log 2>&1
  sed "s/^FEOL    = false/FEOL    = true/" /pdk/libs.tech/klayout/drc/sky130A.lydrc > /tmp/full.lydrc
  klayout -b -rd input=$N.gds -rd report=klayout_full.lyrdb -r /tmp/full.lydrc > klayout_full.log 2>&1 || true
  printf "lvs \"$N.lvs.spice $N\" \"$REFF $N\" /pdk/libs.tech/netgen/sky130A_setup.tcl lvs_${REFF%.spice}.rpt\n" > lvs.tcl
  netgen -batch source lvs.tcl > netgen_${REFF%.spice}.txt 2>&1
  echo "RESULT $N | $(grep "^DRC .*violations" $N.log) | KLayout mr $(grep -c "<item>" klayout_mr.lyrdb) full $(grep -c "<item>" klayout_full.lyrdb) | LVS(${REFF}): $(grep -h "Final result" -A1 netgen_${REFF%.spice}.txt | tr "\n" " ") property errors: $(grep -c "Property errors were found" netgen_${REFF%.spice}.txt) | $(grep "^BBOX" $N.log)"
  grep -A6 "^DRC" $N.log | tail -n +2 | head -6' 2>&1 | grep -v "^\[INFO\]" || true
