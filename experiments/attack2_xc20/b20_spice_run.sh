#!/bin/bash
# b20_spice_run.sh — corre en docker los netlists b20_spice_net/b20_spice_<patrón>*.spice
# Uso: ./b20_spice_run.sh "A_ B1_ C_ D_ E_ Cmm_"     (lista de prefijos de circuito)
HERE="$(cd "$(dirname "$0")" && pwd)"
PAT="${1:-A_ B1_ C_ D_ E_ Cmm_}"
docker run --rm -v "$HERE":/work hpretl/iic-osic-tools:2025.07 --skip bash -c '
cd /work/b20_spice_net
cp /foss/pdks/sky130A/libs.tech/ngspice/spinit .spiceinit 2>/dev/null
mkdir -p /work/b20_spice_raw /work/b20_spice_log
for p in '"$PAT"'; do ls b20_spice_${p}*.spice; done | \
  xargs -P 6 -I{} sh -c "ngspice -b {} > /work/b20_spice_log/\$(basename {} .spice).log 2>&1; echo hecho {}"
' 2>&1 | grep -v "^\[INFO\]"
date
