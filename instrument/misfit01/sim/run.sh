#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Usage: SKY130A=<path to sky130A> ./run.sh    Simulates the extracted tiles in ../results and collects the TILE lines.
set -e
HERE=$(cd "$(dirname "$0")" && pwd); ROOT=$(cd "$HERE/../../.." && pwd)
: "${SKY130A:?set SKY130A to the sky130A folder of the PDK}"
cd "$HERE/../results"
for f in *_tile_extracted.spice; do python3 ../sim/tile_sim.py "$f" "sim_${f%_tile_extracted.spice}.sp" "${f%_tile_extracted.spice}"; done
docker run --rm -v "$ROOT":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work/instrument/misfit01/results
  for d in sim_*.sp; do ../../../tools/ngspice_pdk.sh $d > ${d%.sp}.txt 2>&1 || echo "FAILED $d"; done' 2>&1 | grep -v "^\[INFO\]" || true
grep -h "^TILE" sim_*.txt | tee tile_sim.txt
