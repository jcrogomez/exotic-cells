#!/bin/sh
# XC-20 lector v4, prueba de precarga en 200 fF (tt 27): v3 (pfet 64 um), a (pfet 2 um), b (hvt 2 um), c (hvt 2 um en pila)
cd "$(dirname "$0")"
echo "inicio $(date +%H:%M:%S)"
ls -d */ | sed 's|/||' | xargs -P 4 -I{} sh -c 'docker run --rm -v $PWD/$1:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c "cd /w && timeout 1500 sh /t/ngspice_pdk.sh lec.sp > lec.log 2>&1" >/dev/null 2>&1; echo "$1 $(date +%H:%M:%S) $(grep -h ^RES $1/lec.log)"' _ {}
echo "fin $(date +%H:%M:%S)"
