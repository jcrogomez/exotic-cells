#!/bin/sh
# E2: las 8 fases de l = 21,6 que abortaron en p5d_1 y p5d_2 (7, 9, 10, 11, 13, 14, 15, 17), con CARGA=1 (1 kOhm de cada
# fuente de agresor a 0,9 V; ver gen_i4.py). Cada deck lleva ademas una fase de control ya medida sin la carga (12 y 8).
# Prediccion, escrita antes de correr (date: 2026-11-24 17:09:48 EST):
#   a) los dos decks terminan sin "aborted";
#   b) la fase de control de cada deck (l216f12 en p5e_a0, l216f8 en p5e_b0) da el Delta con signo de p5c_0 y de p3 dentro de
#      0,001 puntos de % (el limite del control de deck de la enmienda 3), y c reproduce el contrato dentro de 0,01 %.
#   Si b) falla, la carga cambia la medida y estas fases no valen: se dice y se busca otro arreglo.
#   Si a) falla, la causa no era la corriente ~0 de las fuentes.
cd "$(dirname "$0")"
echo "inicio $(date +%H:%M:%S)"
run(){ docker run --rm -v $PWD/corridas/$1:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /w && sh /t/ngspice_pdk.sh i4.sp > i4.log 2>&1' >/dev/null 2>&1; echo "$1 $(date +%H:%M:%S) $(grep -c aborted corridas/$1/i4.log) abortos, $(grep '^RES' corridas/$1/i4.log | awk 'NF==4' | wc -l | tr -d ' ') RES"; }
run p5e_a0 & run p5e_b0 & wait
echo "fin $(date +%H:%M:%S)"
