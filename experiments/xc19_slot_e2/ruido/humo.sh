#!/bin/sh
# humo del ruido: tt 27, src=11, M=4 instancias, L=2 repeticiones, k = 0 (control), 1 (medida), 3 (testigo)
cd "$(dirname "$0")"
export XC19_INC=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/cells/xc19_slot_core_a2/v_hm/xc19_slot_core_lod.inc
S=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC
echo "inicio $(date +%H:%M:%S)"
for k in 0 1 3; do
  d=humo_k$k; /usr/bin/python3 gen_ruido.py tt 27 11 31.64 31.64 4 2 $k 11 $d
  docker run --rm -v $PWD/$d:/w -v $S/06_exotic_cells/tools:/t:ro -v $S/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /w && sh /t/ngspice_pdk.sh ruido.sp > rn.log 2>&1' >/dev/null 2>&1 &
done
wait
echo "fin $(date +%H:%M:%S)"
grep -h "^RN" humo_k*/rn.log | head -40
