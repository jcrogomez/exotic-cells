#!/bin/sh
# MISFIT-03 enmienda 2, C4: R0, R1 y R3 murieron por memoria (Killed) al correr 4 a la vez (corre_c3c4.sh). Mismos decks, sin
# regenerar, de dos en dos (enmienda 2 §4). Los logs truncados quedan como ruido_killed_4par.log.
cd "$(dirname "$0")"
echo "inicio $(date +%H:%M:%S)"
printf "%s\n" ruido/R1 ruido/R3 ruido/R0 | \
xargs -P 2 -I{} sh -c 'd=$1; docker run --rm -v $PWD/$d:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c "cd /w && sh /t/ngspice_pdk.sh ruido.sp > ruido.log 2>&1" >/dev/null 2>&1; echo "$d $(date +%H:%M:%S) $(grep -c ^RN $d/ruido.log)"' _ {}
echo "fin $(date +%H:%M:%S)"
