#!/bin/sh
# MISFIT-03 enmienda 2 (sellada 09:46:20): C4 (ruido, 4 decks) y C3 (Monte Carlo: control + 4 decks tt_mm), 4 a la vez
cd "$(dirname "$0")"
export XC19_INC=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/cells/xc19_slot_core_a2/v_hm/xc19_slot_core_lod.inc
P=/usr/bin/python3
$P ruido/gen_ruido.py tt 27 11 31.6407 31.6407 8 8 0 31 ruido/R0
$P ruido/gen_ruido.py tt 27 11 31.6407 31.6407 8 8 1 32 ruido/R1
$P ruido/gen_ruido.py tt 27 11 31.6407 31.6407 8 8 3 33 ruido/R3
$P ruido/gen_ruido.py tt 27 01 30.8732 30.8689 8 8 1 34 ruido/R1p
$P mc/gen_mc.py tt 27 1 2100 mc/C0 6 200
for s in 2101 2102 2103 2104; do $P mc/gen_mc.py tt_mm 27 2 $s mc/M$s 6 200; done
echo "inicio $(date +%H:%M:%S)"
printf "%s\n" ruido/R0:ruido ruido/R1:ruido ruido/R3:ruido ruido/R1p:ruido mc/C0:mc mc/M2101:mc mc/M2102:mc mc/M2103:mc mc/M2104:mc | \
xargs -P 4 -I{} sh -c 'd=${1%%:*}; f=${1##*:}; docker run --rm -v $PWD/$d:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c "cd /w && sh /t/ngspice_pdk.sh $f.sp > $f.log 2>&1" >/dev/null 2>&1; echo "$d $(date +%H:%M:%S)"' _ {}
echo "fin $(date +%H:%M:%S)"
