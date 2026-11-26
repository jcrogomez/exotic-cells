#!/bin/sh
# Plan nocturno 2026-11-25 (cells/preregistros/PLAN_2026-11-25_noche.md). Bloques D, B, A, C en ese orden (los cortos primero,
# el ruido al final). Cada deck corre con timeout DENTRO del contenedor. Una linea al empezar y otra al acabar cada deck.
cd "$(dirname "$0")"
R=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC
IMG=hpretl/iic-osic-tools:2025.07
PDK=$R/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A
export R IMG PDK
uno(){   # uno <carpeta> <deck> <tope_s>
  d=$1; f=$2; tope=$3; b=${f%.sp}
  echo "  empieza $d $(date +%H:%M:%S)"
  docker run --rm -v $PWD/$d:/w -v $R/06_exotic_cells/tools:/t:ro -v $PDK:/pdk:ro $IMG --skip bash -c "cd /w && timeout $tope sh /t/ngspice_pdk.sh $f > $b.log 2>&1; echo salida \$? >> $b.log" >/dev/null 2>&1
  echo "  acaba   $d $(date +%H:%M:%S) $(tail -1 $d/$b.log) $(grep -c -E '^(MD|LD|MC|RN|R2) ' $d/$b.log) lineas"
}
export -f uno 2>/dev/null
bloque(){ # bloque <nombre> <paralelo> <deck> <tope_s> <carpetas...>
  n=$1; par=$2; f=$3; tope=$4; shift 4
  echo "== bloque $n: $# decks, $par a la vez, tope ${tope} s  $(date '+%Y-%m-%d %H:%M:%S %Z')"
  printf '%s\n' "$@" | xargs -P $par -I{} bash -c 'uno "$1" "$2" "$3"' _ {} $f $tope
  echo "== fin bloque $n $(date '+%Y-%m-%d %H:%M:%S %Z')"
}
echo "inicio cola $(date '+%Y-%m-%d %H:%M:%S %Z')"


bloque humo 2 lec.sp 300 A/L0.50_tt27_m_1.0000e-05/ A/L0.50_tt27_m_3.1623e-06/

echo "fin cola $(date '+%Y-%m-%d %H:%M:%S %Z')"
