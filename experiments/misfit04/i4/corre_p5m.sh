#!/bin/sh
# E2: fase 10 de l = 21,6 otra vez. p5k10_0 (fase 10 + control 12, 0,5 ns) fallo el control por 0,00107 frente a 0,001.
# Como en p5l: otra composicion, fase 10 con dos controles (8 y 12). Mismo paso (0,5 ns) e ITL4=200.
# Decision de repetirla: del agente, por encargo de Juan ("tu decide", 2026-11-25).
# Prediccion, escrita antes de correr (date: 2026-11-25 11:44:23 EST): termina sin abortar (apuesta) y los dos controles dan p3
#   dentro de 0,001 puntos de %; la fase 10 da -0,3505 dentro de 0,005 (valor visto 3 veces en decks con control fallado).
#   Si aborta o falla un control, lo digo y la fase 10 queda sin dato: no hay tercer intento.
cd "$(dirname "$0")"
echo "inicio $(date +%H:%M:%S)"
run(){ docker run --rm -v $PWD/corridas/$1:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /w && timeout 2400 sh /t/ngspice_pdk.sh i4.sp > i4.log 2>&1' >/dev/null 2>&1; echo "$1 $(date +%H:%M:%S) $(grep -c aborted corridas/$1/i4.log) abortos, $(grep '^RES' corridas/$1/i4.log | awk 'NF==4' | wc -l | tr -d ' ') RES"; }
run p5m10_0
echo "fin $(date +%H:%M:%S)"
