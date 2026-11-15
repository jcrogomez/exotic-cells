#!/bin/bash
# Lanza las corridas del estimador B (cota de Barber-Agakov), 3 en paralelo, 2 hilos cada una.
export P=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/.venv/bin/python3
export OMP_NUM_THREADS=2 VECLIB_MAXIMUM_THREADS=2
cd "$(dirname "$0")"
printf '%s\n' \
 "V0Kinf C0_0.05 ancho" "V0Kinf C0_0.5 ancho" "V0 C0_0.05 ancho" "V0 C0_0.5 ancho" \
 "V4 C0_0.5 ancho" "V4 C2 ancho" \
 "V4 C0_0.05 XC26" "V4 C0_0.5 XC26" "V4 C1 XC26" "V4 C2 XC26" |
xargs -P 3 -L 1 bash -c 'echo "inicio $0 $1 $2 $(date)"; $P ver2_clasif.py $0 $1 $2 300000 100000 128 8 1 > ver2_B_$0_$1_$2_H128.txt 2>&1; echo "fin $0 $1 $2 $(date)"' 
