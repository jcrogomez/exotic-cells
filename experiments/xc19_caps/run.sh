#!/bin/sh
# Corre decks de ngspice de esta carpeta en el contenedor. Uso: SKY130A=<ruta a sky130A> ./run.sh a.sp b.sp ...
# Monta la raíz del repo en /work (los decks incluyen ../../cells/...) y el PDK en /pdk.
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
REPO=$(cd "$HERE/../.." && pwd)
: "${SKY130A:?defina SKY130A}"
for d in "$@"; do
  b=${d%.sp}
  docker run --rm -v "$REPO":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c \
    "cd /work/experiments/xc19_caps && ngspice -b $d > $b.log 2>&1" 2>&1 | grep -v '^\[INFO\]' || true
  grep -h "^RES" "$HERE/$b.log" > "$HERE/$b.txt" || true
  echo "== $d"; cat "$HERE/$b.txt"
done
