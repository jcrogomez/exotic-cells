#!/bin/bash
# runone.sh MODE deck   (dentro del contenedor; /work = copia del repo del modo)
MODE=$1; deck=$2; d=$(dirname $deck); b=$(basename $deck .sp)
cd /work/$d || exit 1
t0=$(date +%s)
if [ "$MODE" = B ]; then
  cp /hsa/sky130A_spinit .spiceinit
  env -u SPICE_USERINIT_DIR timeout 1500 ngspice -b $b.sp > $b.hsa_$MODE.log 2>&1; rc=$?
else
  timeout 1500 ngspice -b $b.sp > $b.hsa_$MODE.log 2>&1; rc=$?
fi
echo "$MODE $deck rc=$rc secs=$(( $(date +%s)-t0 ))" >> /hsa/times_$MODE.txt
