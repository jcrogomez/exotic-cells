#!/bin/sh
# E2: las 13 fases de l = 21,6 que estaban en p5_0 y p5_1 (abortaron), en decks de 5 (+ c + q), gear. Espera a corre_p5.sh.
cd "$(dirname "$0")"
while pgrep -f corre_p5.sh >/dev/null; do sleep 30; done
echo "inicio $(date +%H:%M:%S)"
run(){ docker run --rm -v $PWD/corridas/$1:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /w && sh /t/ngspice_pdk.sh i4.sp > i4.log 2>&1' >/dev/null 2>&1; echo "$1 $(date +%H:%M:%S) $(grep -c aborted corridas/$1/i4.log) abortos"; }
run p5d_0 & run p5d_1 & run p5d_2 & wait
echo "fin $(date +%H:%M:%S)"
