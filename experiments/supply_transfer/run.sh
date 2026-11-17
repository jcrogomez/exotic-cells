#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Usage: SKY130A=<path to sky130A> ./run.sh    Runs every deck with the PDK's ngspice settings and collects the STRANS lines.
set -e
HERE=$(cd "$(dirname "$0")" && pwd); ROOT=$(cd "$HERE/../.." && pwd)
: "${SKY130A:?set SKY130A to the sky130A folder of the PDK}"
cd "$HERE" && python3 gen.py
docker run --rm -v "$ROOT":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work/experiments/supply_transfer
  for d in st_*.sp; do ../../tools/ngspice_pdk.sh $d > ${d%.sp}.log 2>&1 || echo "FAILED $d"; done' 2>&1 | grep -v "^\[INFO\]" || true
grep -h "^STRANS" st_*.log > strans.txt; cat strans.txt
