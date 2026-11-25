#!/bin/sh
# MISFIT-05: 4 DC + 4 transitorios + 2 largos, de dos en dos. Tope del prerregistro: 40 min por deck (timeout 2400 dentro del contenedor).
cd "$(dirname "$0")"
R=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC
echo "inicio $(date '+%Y-%m-%d %H:%M:%S %Z')"
ls -d dc_*/ tr_*/ lg_*/ | sed 's|/||' | xargs -P 2 -I{} sh -c 'echo "  empieza $1 $(date +%H:%M:%S)"; docker run --rm -v $PWD/$1:/w -v '$R'/06_exotic_cells/tools:/t:ro -v '$R'/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c "cd /w && timeout 2400 sh /t/ngspice_pdk.sh m5.sp > m5.log 2>&1; echo salida \$? >> m5.log" >/dev/null 2>&1; echo "  $1 $(date +%H:%M:%S) $(grep -c -E "^(M5|DC|LG) " $1/m5.log) lineas, $(tail -1 $1/m5.log)"' _ {}
echo "fin $(date '+%Y-%m-%d %H:%M:%S %Z')"
