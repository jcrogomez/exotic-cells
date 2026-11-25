#!/bin/sh
# E2: barrido de fase de las tiras S7 (tt 27), 5 decks de dos en dos (memoria)
cd "$(dirname "$0")"
run(){ docker run --rm -v $PWD/corridas/$1:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /w && sh /t/ngspice_pdk.sh i4.sp > i4.log 2>&1' >/dev/null 2>&1; }
echo "inicio $(date +%H:%M:%S)"
run p5_0 & run p5_1 & wait
run p5_2 & run p5_3 & wait
run p5_4
echo "fin $(date +%H:%M:%S)"
cat corridas/p5_*/i4.log | grep "^RES" | awk 'NF==4' > p5.txt; wc -l < p5.txt
grep -h -i "too small\|killed\|abort" corridas/p5_*/i4.log | head
