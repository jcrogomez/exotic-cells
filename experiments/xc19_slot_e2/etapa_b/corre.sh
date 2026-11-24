#!/bin/sh
# etapa b, diseno: tA y trampa frente a la puerta del DUT, 4 esquinas, de dos en dos (memoria)
cd "$(dirname "$0")"
echo "inicio $(date +%H:%M:%S)"
ls -d vb_*/ | sed 's|/||' | xargs -P 2 -I{} sh -c 'docker run --rm -v $PWD/$1:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c "cd /w && sh /t/ngspice_pdk.sh vb.sp > vb.log 2>&1" >/dev/null 2>&1; echo "$1 $(date +%H:%M:%S) $(grep -c ^VB $1/vb.log)"' _ {}
echo "fin $(date +%H:%M:%S)"
