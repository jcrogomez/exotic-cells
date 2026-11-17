#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Builds the control cell and its variants into cell/variants/<name>/ (GDS, extracted SPICE, LEF, DRC count).
# Usage: SKY130A=<path to sky130A> ./build.sh
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
: "${SKY130A:?set SKY130A to the sky130A folder of the PDK}"
docker run --rm -v "$HERE":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work
  for v in ok:0.5:ok len10:1.0:ok nopower:0.5:nopower empty:0.5:empty; do
    n=${v%%:*}; r=${v#*:}; l=${r%%:*}; m=${r#*:}
    mkdir -p variants/$n && cd variants/$n
    LEN=$l MODE=$m OUT=misfit_inv magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc ../../misfit_inv.tcl > magic.txt 2>&1
    python3 ../../lef.py $l misfit_inv.lef
    echo "$n: $(grep "^DRC misfit_inv" magic.txt) | $(grep -c "^X" misfit_inv.spice) devices"
    cd ../..
  done' 2>&1 | grep -v "^\[INFO\]" || true
