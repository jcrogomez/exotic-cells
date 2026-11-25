#!/bin/sh
# MISFIT-09: 1 deck AC + 4 de contrato, uno a la vez. Tope del prerregistro: 40 min por deck (timeout 2400 dentro del contenedor).
cd "$(dirname "$0")"
R=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC
echo "inicio $(date '+%Y-%m-%d %H:%M:%S %Z')"
for d in ac_tt_27 tr_tt_27 tr_ff_85 tr_ss_85 tr_ff_-40; do
  echo "  empieza $d $(date +%H:%M:%S)"
  docker run --rm -v $PWD/$d:/w -v $R/06_exotic_cells/tools:/t:ro -v $R/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c "cd /w && timeout 2400 sh /t/ngspice_pdk.sh m9.sp > m9.log 2>&1; echo salida \$? >> m9.log" >/dev/null 2>&1
  echo "  $d $(date +%H:%M:%S) $(grep -c -E '^(M9|AC) ' $d/m9.log) lineas, $(tail -1 $d/m9.log)"
done
echo "fin $(date '+%Y-%m-%d %H:%M:%S %Z')"
