#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Usage: SKY130A=<path to sky130A> ./run.sh      (Docker, hpretl/iic-osic-tools:2025.07)
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
: "${SKY130A:?set SKY130A to the sky130A folder of the PDK}"
sed "s#PDKROOT#/pdk#" "$HERE/lod_min.sp" > "$HERE/lod_min_run.sp"
docker run --rm -v "$HERE":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work
  magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc lod_min.tcl > magic.txt 2>&1
  cp /pdk/libs.tech/ngspice/spinit .spiceinit
  env -u SPICE_USERINIT_DIR ngspice -b lod_min_run.sp > ngspice.txt 2>&1
  rm -f .spiceinit lod_min_run.sp' 2>&1 | grep -v "^\[INFO\]" || true
{ grep "^==" "$HERE/magic.txt"; grep -h "^X" "$HERE"/lod_sa030.spice "$HERE"/lod_sa300.spice
  grep -E "^(v0|v030|v300|dvth_mv|id_ratio) =" "$HERE/ngspice.txt"; } | tee "$HERE/result.txt"
