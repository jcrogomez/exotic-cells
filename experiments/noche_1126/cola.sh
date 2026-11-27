#!/bin/sh
# Plan nocturno 2026-11-26 (cells/preregistros/PLAN_2026-11-26_noche.md). Bloques K, S, W, N, M en ese orden (el largo al final).
# Cada deck corre con timeout DENTRO del contenedor; una linea al empezar y otra al acabar. Uso: cola.sh [carpetas de humo...]
cd "$(dirname "$0")"
R=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC
IMG=hpretl/iic-osic-tools:2025.07
PDK=$R/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A
export R IMG PDK
uno(){   # uno <carpeta> <tope_s>
  d=$1; tope=$2
  echo "  empieza $d $(date +%H:%M:%S)"
  docker run --rm -v $PWD/$d:/w -v $R/06_exotic_cells/tools:/t:ro -v $PDK:/pdk:ro $IMG --skip bash -c "cd /w && timeout $tope sh /t/ngspice_pdk.sh lec.sp > lec.log 2>&1; echo salida \$? >> lec.log" >/dev/null 2>&1
  echo "  acaba   $d $(date +%H:%M:%S) $(tail -1 $d/lec.log) $(grep -c -E '^(ED|MC|KD) ' $d/lec.log) lineas"
}
export -f uno 2>/dev/null
bloque(){ # bloque <nombre> <tope_s> <carpetas...>
  n=$1; tope=$2; shift 2
  echo "== bloque $n: $# decks, 4 a la vez, tope ${tope} s  $(date '+%Y-%m-%d %H:%M:%S %Z')"
  printf '%s\n' "$@" | xargs -P 4 -I{} bash -c 'uno "$1" "$2"' _ {} $tope
  echo "== fin bloque $n $(date '+%Y-%m-%d %H:%M:%S %Z')"
}
echo "inicio cola $(date '+%Y-%m-%d %H:%M:%S %Z')"
if [ $# -gt 0 ]; then bloque humo 900 "$@"; else
  bloque K 3600 $(ls -d K/*/)
  bloque S 3600 $(ls -d S/*/)
  bloque W 3600 $(ls -d W/*/)
  bloque N 3600 $(ls -d N/*/)
  bloque M 5400 $(ls -d M/*/)
fi
echo "fin cola $(date '+%Y-%m-%d %H:%M:%S %Z')"
