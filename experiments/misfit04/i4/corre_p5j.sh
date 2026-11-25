#!/bin/sh
# E2, diagnostico (no es veredicto): por que el control (fase 4) depende de con quien comparte deck.
# Observado en p5i: la fase 4 da +0,07368 / +0,07332 / +0,07297 / +0,06975 / +0,06653 % junto a las fases 1, 2, 3, 5, 6, y
# +0,06474 en p5c_0 (5 relojes). La instancia c tambien se mueve una unidad de la ultima cifra. Las instancias no comparten nodos
# con senal: lo unico comun son los puntos de tiempo. Hipotesis aburrida: error de integracion con paso maximo de 2 ns frente a
# flancos de 100 ps; cada reloj mas en el deck mete puntos de ruptura y cambia el error.
# Prediccion, escrita antes de correr (date: 2026-11-24 22:37:40 EST): con paso maximo 0,5 ns (mismos decks que p5i1 y p5i6),
#   la diferencia entre las dos fases 4 (hoy 0,00715 puntos) baja a menos de la mitad. Si no baja, la hipotesis es falsa.
#   A que valor convergen (0,065 o 0,073) no lo se.
cd "$(dirname "$0")"
echo "inicio $(date +%H:%M:%S)"
run(){ docker run --rm -v $PWD/corridas/$1:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /w && sh /t/ngspice_pdk.sh i4.sp > i4.log 2>&1' >/dev/null 2>&1; echo "$1 $(date +%H:%M:%S) $(grep -c aborted corridas/$1/i4.log) abortos, $(grep '^RES' corridas/$1/i4.log | awk 'NF==4' | wc -l | tr -d ' ') RES"; }
run p5j1_0 & run p5j6_0 & wait
echo "fin $(date +%H:%M:%S)"
