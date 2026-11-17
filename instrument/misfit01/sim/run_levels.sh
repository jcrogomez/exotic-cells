#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Simulates every netlist of ../results/pex (two arms, two extraction levels) and collects the TILE lines.
# Usage: SKY130A=<path to sky130A> ./run_levels.sh
set -e
HERE=$(cd "$(dirname "$0")" && pwd); ROOT=$(cd "$HERE/../../.." && pwd)
: "${SKY130A:?}"
cd "$HERE/../results/pex"
for f in tt_um_*.dev.spice tt_um_*.c.spice; do python3 ../../sim/tile_sim.py "$f" "sim_$f.sp" "$f"; done
docker run --rm -v "$ROOT":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work/instrument/misfit01/results/pex
  for d in sim_*.sp; do ../../../../tools/ngspice_pdk.sh $d > ${d%.sp}.txt 2>&1 || echo "FAILED $d"; done' 2>&1 | grep -v "^\[INFO\]" || true
grep -h "^TILE" sim_*.txt | tee levels.txt
