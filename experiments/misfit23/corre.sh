#!/bin/sh
# MISFIT-23: 64 decks, 4 a la vez, tope 3600 s dentro del contenedor. Uso: corre.sh [patron de carpetas, por defecto d/*/]
cd "$(dirname "$0")"; R=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC; IMG=hpretl/iic-osic-tools:2025.07
PDK=$R/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A; export R IMG PDK
uno(){ d=$1; echo "  empieza $d $(date +%H:%M:%S)"
  docker run --rm -v $PWD/$d:/w -v $R/06_exotic_cells/tools:/t:ro -v $PDK:/pdk:ro $IMG --skip bash -c "cd /w && timeout 3600 sh /t/ngspice_pdk.sh lec.sp > lec.log 2>&1; echo salida \$? >> lec.log" >/dev/null 2>&1
  echo "  acaba   $d $(date +%H:%M:%S) $(tail -1 $d/lec.log) $(grep -c "^ED " $d/lec.log) lineas"; }
export -f uno
echo "inicio $(date '+%Y-%m-%d %H:%M:%S %Z')"; ls -d ${1:-d/*/} | xargs -P 4 -I{} bash -c 'uno "$1"' _ {}; echo "fin $(date '+%Y-%m-%d %H:%M:%S %Z')"
