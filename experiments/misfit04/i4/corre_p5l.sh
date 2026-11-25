#!/bin/sh
# E2: fase 3 de l = 21,6 otra vez. p5k3_0 (fase 3 + control 4, 0,5 ns) aborto a los 4 min; el aborto es determinista, asi que se
# cambia la composicion: fase 3 con dos controles (0 y 4). Mismo paso (0,5 ns) e ITL4=200.
# Prediccion, escrita antes de correr (date: 2026-11-24 23:37:36 EST): termina (apuesta) y los dos controles dan p3 dentro de 0,001
#   puntos de %; la fase 3 da +0,1255 dentro de 0,005 (valor de p5i3_0, con control fallado). Si aborta, lo digo y queda sin dato.
cd "$(dirname "$0")"
echo "inicio $(date +%H:%M:%S)"
run(){ docker run --rm -v $PWD/corridas/$1:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /w && sh /t/ngspice_pdk.sh i4.sp > i4.log 2>&1' >/dev/null 2>&1; echo "$1 $(date +%H:%M:%S) $(grep -c aborted corridas/$1/i4.log) abortos, $(grep '^RES' corridas/$1/i4.log | awk 'NF==4' | wc -l | tr -d ' ') RES"; }
run p5l3_0
echo "fin $(date +%H:%M:%S)"
