#!/bin/sh
# E1: las 4 esquinas de la pasada 4, de dos en dos (memoria)
cd "$(dirname "$0")"
run(){ docker run --rm -v $PWD/corridas/$1:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /w && sh /t/ngspice_pdk.sh i4.sp > i4.log 2>&1' >/dev/null 2>&1; }
echo "inicio $(date +%H:%M:%S)"
run p4_tt_27 & run p4_ff_-40 & wait
run p4_ss_85 & run p4_ff_85 & wait
echo "fin $(date +%H:%M:%S)"
cat corridas/p4_*/i4.log | grep "^RES" | awk 'NF==4' > p4.txt; wc -l < p4.txt
grep -h -i "too small\|killed\|abort" corridas/p4_*/i4.log | head
