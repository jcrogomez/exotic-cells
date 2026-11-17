#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Builds the time cell (and the variant of the N2 control) into cell/build[_<variant>]/: GDS, extracted SPICE, DRC count.
# Usage: SKY130A=<path to sky130A> ./build.sh [variant]
set -e
HERE=$(cd "$(dirname "$0")" && pwd); V=${1:-ok}; B="$HERE/build$([ "$V" = ok ] || echo _$V)"
: "${SKY130A:?}"
mkdir -p "$B" && python3 "$HERE/gen_tcell.py" "$B/tcell.tcl" "$V" > "$B/pins.txt"
cp "$HERE/../../misfit01/cell/misfit_inv.tcl" "$B/"
docker run --rm -v "$B":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work; RC=/pdk/libs.tech/magic/sky130A.magicrc
  NAME=misfit_inv MODE=ok OUT=misfit_inv magic -dnull -noconsole -rcfile $RC misfit_inv.tcl > sub1.txt 2>&1
  NAME=misfit_pch MODE=ponly OUT=misfit_pch magic -dnull -noconsole -rcfile $RC misfit_inv.tcl > sub2.txt 2>&1
  magic -dnull -noconsole -rcfile $RC tcell.tcl > magic.txt 2>&1
  grep -A25 "^DRC misfit_tcell" magic.txt | cut -c1-170; grep -i "error pars\|invalid\|unknown" magic.txt | head -3
  grep -c "^X" misfit_tcell.spice' 2>&1 | grep -v "^\[INFO\]" || true
