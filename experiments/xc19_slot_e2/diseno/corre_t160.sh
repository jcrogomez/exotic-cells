#!/bin/sh
# ff -40 con tstop 160 us: con la unidad MOS src=11 cruza despues de los 80 us del deck (corrida del 2026-11-24, h11/h10/f1 sin cruce)
cd "$(dirname "$0")"
while pgrep -f "diseno/corre.sh" >/dev/null; do sleep 30; done
n=contrato_ff_-40_t160; mkdir -p corridas/$n; cp $n.sp corridas/$n/
echo "inicio $(date +%H:%M:%S)"
docker run --rm -v $PWD/corridas/$n:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c "cd /w && sh /t/ngspice_pdk.sh $n.sp > $n.log 2>&1" >/dev/null 2>&1
echo "fin $(date +%H:%M:%S)"
