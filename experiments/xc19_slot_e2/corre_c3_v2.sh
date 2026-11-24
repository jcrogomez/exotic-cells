#!/bin/sh
# MISFIT-03 enmienda 2, C3 rehecho: la v1 ignoro la semilla (set rndseed) y dio 12 chips distintos, no 48. Mismo diseno con
# setseed. Espera a que termine corre_c4_rehecho.sh (memoria) y corre de dos en dos.
cd "$(dirname "$0")"
# v3: la v2 genero los decks sin XC19_INC (macro viejo); estos ya llevan el v_hm (diff contra v1 solo en la semilla)

echo "inicio $(date +%H:%M:%S)"
printf "%s\n" mc/M2101 mc/M2102 mc/M2103 mc/M2104 | \
xargs -P 2 -I{} sh -c 'd=$1; docker run --rm -v $PWD/$d:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c "cd /w && sh /t/ngspice_pdk.sh mc.sp > mc.log 2>&1" >/dev/null 2>&1; echo "$d $(date +%H:%M:%S) $(grep -c ^MC $d/mc.log)"' _ {}
echo "fin $(date +%H:%M:%S)"
