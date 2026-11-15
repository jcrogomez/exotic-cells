#!/bin/bash
# runtwo.sh MODE deck: A2 = entorno por defecto; B2r = sin SPICE_USERINIT_DIR + spinit; Bnk = idem con spinit sin 'option klu'
MODE=$1; deck=$2; d=$(dirname $deck); b=$(basename $deck .sp)
cd /hsa/$MODE/repo/$d || exit 1
t0=$(date +%s)
case $MODE in
  A2) timeout 3000 ngspice -b $b.sp > $b.hsa_A.log 2>&1; rc=$? ;;
  B2r) cp /hsa/sky130A_spinit .spiceinit; env -u SPICE_USERINIT_DIR timeout 3000 ngspice -b $b.sp > $b.hsa_B.log 2>&1; rc=$? ;;
  Bnk) cp /hsa/sky130A_spinit_sin_klu .spiceinit; env -u SPICE_USERINIT_DIR timeout 3000 ngspice -b $b.sp > $b.hsa_Bnk.log 2>&1; rc=$? ;;
esac
echo "$MODE $deck rc=$rc secs=$(( $(date +%s)-t0 ))" >> /hsa/times_rerun.txt
