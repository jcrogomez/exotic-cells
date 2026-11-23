#!/bin/sh
# Corre los 8 decks del contrato (MISFIT-03 etapa a) en paralelo, cada uno en su carpeta (ngspice_pdk.sh escribe un .spiceinit
# por carpeta). Uso: SKY130A=<ruta> ./run_contrato.sh
set -e
HERE=$(cd "$(dirname "$0")" && pwd); REPO=$(cd "$HERE/../.." && pwd)
: "${SKY130A:?}"
for d in contrato largo; do for ct in tt_27 ff_-40 ss_85 ff_85; do
  mkdir -p "$HERE/corridas/${d}_${ct}"; cp "$HERE/${d}_${ct}.sp" "$HERE/corridas/${d}_${ct}/"
  docker run --rm -v "$REPO":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c \
    "cd /work/experiments/xc19_slot/corridas/${d}_${ct} && /work/tools/ngspice_pdk.sh ${d}_${ct}.sp > ${d}_${ct}.log 2>&1" > /dev/null 2>&1 &
done; done
wait
date
grep -h "^RES" "$HERE"/corridas/*/*.log > "$HERE/contrato.txt"
wc -l < "$HERE/contrato.txt"
