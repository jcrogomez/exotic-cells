#!/bin/sh
# E2: las 7 fases de l = 21,6 que faltan (2, 3, 5, 7, 9, 10, 11), una por deck junto a una fase de control (4, 8 o 12),
# con paso maximo 0,5 ns e ITL4=200. Desviacion declarada: la enmienda 3 no fija el paso; los decks anteriores usaban 2 ns.
# Por que: el diagnostico p5j (22:37-22:55) cumplio su prediccion. Con 0,5 ns la fase 4 da +0,06474 y +0,06438 % junto a las
# fases 1 y 6 (diferencia 0,00036; con 2 ns era 0,00715) y coincide con p5c_0 y p3. Con 2 ns los decks de 2 relojes no estaban
# convergidos; los de 5 o mas si, porque sus relojes meten puntos de ruptura cada ~1 ns.
# Prediccion, escrita antes de correr (date: 2026-11-24 22:56:12 EST):
#   a) ninguno aborta (apuesta: p5j no aborto, pero son 2 de 2);
#   b) en cada deck la fase de control da el Delta con signo de p5c_0 y de p3 dentro de 0,001 puntos de %. Si falla, esa fase no vale;
#   c) las fases 7, 9, 10 y 11 dan lo de p5h_0 dentro de 0,005 puntos (alli el control fallo por 0,003). Si no, lo digo.
cd "$(dirname "$0")"
echo "inicio $(date +%H:%M:%S)"
run(){ docker run --rm -v $PWD/corridas/$1:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /w && sh /t/ngspice_pdk.sh i4.sp > i4.log 2>&1' >/dev/null 2>&1; echo "$1 $(date +%H:%M:%S) $(grep -c aborted corridas/$1/i4.log) abortos, $(grep '^RES' corridas/$1/i4.log | awk 'NF==4' | wc -l | tr -d ' ') RES"; }
run p5k2_0 & run p5k3_0 & run p5k5_0 & run p5k7_0 & wait
run p5k9_0 & run p5k10_0 & run p5k11_0 & wait
echo "fin $(date +%H:%M:%S)"
