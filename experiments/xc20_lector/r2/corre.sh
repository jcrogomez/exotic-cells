#!/bin/sh
# XC-20 lector 2, R2: 50 decks, tres a la vez. Tope del prerregistro: 30 min por deck (timeout 1800 dentro del contenedor).
cd "$(dirname "$0")"
echo "inicio $(date '+%Y-%m-%d %H:%M:%S %Z')"
ls -d */ | sed 's|/||' | xargs -P 3 -I{} sh -c 'docker run --rm -v $PWD/$1:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c "cd /w && timeout 1800 sh /t/ngspice_pdk.sh lec.sp > lec.log 2>&1; echo salida \$? >> lec.log" >/dev/null 2>&1; echo "$1 $(date +%H:%M:%S) $(grep "^R2 " $1/lec.log | head -1)"' _ {}
echo "fin $(date '+%Y-%m-%d %H:%M:%S %Z')"
