#!/bin/sh
# E2: fases 1, 2, 3, 5 y 6 de l = 21,6 (p5d_0 aborto a 23,96 us, 21:05), con ITL4=200 y sin CARGA, mas la fase de control 4.
# Prediccion, escrita antes de correr (date: 2026-11-24 21:10:26 EST):
#   a) el deck termina sin "aborted" (solo demostrado hasta 400 ns en el diagnostico; mas alla es apuesta);
#   b) la fase 4 da el Delta con signo de p5c_0 y de p3 dentro de 0,001 puntos de %, y c reproduce el contrato dentro de 0,01 %.
#   Si b) falla, estas fases no valen. Si a) falla, se parte en decks de una fase.
cd "$(dirname "$0")"
echo "inicio $(date +%H:%M:%S)"
run(){ docker run --rm -v $PWD/corridas/$1:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /w && sh /t/ngspice_pdk.sh i4.sp > i4.log 2>&1' >/dev/null 2>&1; echo "$1 $(date +%H:%M:%S) $(grep -c aborted corridas/$1/i4.log) abortos, $(grep '^RES' corridas/$1/i4.log | awk 'NF==4' | wc -l | tr -d ' ') RES"; }
run p5g_0
echo "fin $(date +%H:%M:%S)"
