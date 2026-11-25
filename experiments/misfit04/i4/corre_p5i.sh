#!/bin/sh
# E2: fases 1, 2, 3, 5 y 6 de l = 21,6, una por deck junto a la fase de control 4, con ITL4=200 y sin CARGA.
# p5g_0 (las cinco juntas, ITL4=200) aborto a 19,5 us: itl4 no basta. Como estaba escrito, se parte en decks de una fase.
# Prediccion, escrita antes de correr (date: 2026-11-24 21:51:46 EST):
#   a) con 2 relojes por deck en vez de 6 hay menos esquinas donde tropezar: espero que aborte como mucho 1 de los 5 (apuesta);
#   b) en cada deck que termine, la fase 4 da el Delta con signo de p5c_0 y de p3 dentro de 0,001 puntos de %.
#   Si b) falla en un deck, su fase no vale.
cd "$(dirname "$0")"
echo "inicio $(date +%H:%M:%S)"
run(){ docker run --rm -v $PWD/corridas/$1:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /w && sh /t/ngspice_pdk.sh i4.sp > i4.log 2>&1' >/dev/null 2>&1; echo "$1 $(date +%H:%M:%S) $(grep -c aborted corridas/$1/i4.log) abortos, $(grep '^RES' corridas/$1/i4.log | awk 'NF==4' | wc -l | tr -d ' ') RES"; }
run p5i1_0 & run p5i2_0 & run p5i3_0 & wait
run p5i5_0 & run p5i6_0 & wait
echo "fin $(date +%H:%M:%S)"
