#!/bin/sh
cd "$(dirname "$0")"
run(){ mkdir -p corridas/$1/$2; cp corridas/$1/$2.sp corridas/$1/$2/i.sp; docker run --rm -v $PWD/corridas/$1/$2:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /w && sh /t/ngspice_pdk.sh i.sp > i.log 2>&1' >/dev/null 2>&1; }
echo "inicio $(date +%H:%M:%S)"
for c in tt_27 ff_-40 ss_85 ff_85; do run $c op; done
run tt_27 tr & run ff_-40 tr & wait
run ss_85 tr & run ff_85 tr & wait
echo "fin $(date +%H:%M:%S)"
cat corridas/*/*/i.log | grep "^RES" | awk 'NF==4 || NF==5' > calc.txt; wc -l < calc.txt
