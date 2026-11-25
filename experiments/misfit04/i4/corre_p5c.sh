#!/bin/sh
# E2, prueba de deck chico: solo las 5 fases de control de l = 21,6 (+ c + q = 7 instancias), gear
cd "$(dirname "$0")"
echo "inicio $(date +%H:%M:%S)"
docker run --rm -v $PWD/corridas/p5c_0:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /w && sh /t/ngspice_pdk.sh i4.sp > i4.log 2>&1' >/dev/null 2>&1
echo "fin $(date +%H:%M:%S) $(grep -c '^RES' corridas/p5c_0/i4.log) RES, $(grep -c aborted corridas/p5c_0/i4.log) abortos"
