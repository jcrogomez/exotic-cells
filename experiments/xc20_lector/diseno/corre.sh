#!/bin/sh
# XC-20 lector de rango ancho, calculo de diseno v3 (latch SR, esquematico, tt 27): todas las carpetas en un contenedor, una a una
cd "$(dirname "$0")"
echo "inicio $(date +%H:%M:%S)"
docker run --rm -v $PWD:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'for d in /w/c*/; do cd $d && timeout 900 sh /t/ngspice_pdk.sh lec.sp > lec.log 2>&1; done' >/dev/null 2>&1
echo "fin $(date +%H:%M:%S)"
grep -h "^RES" c*/lec.log | sort -k2n > /dev/null
for d in c*/; do printf "%s " "${d%/}"; grep -h "^RES" $d/lec.log || echo; done > diseno.txt
