#!/bin/bash
# Segunda tanda de B (variantes intermedias V1-V3, fuera del mínimo), cuando termina la primera.
export P=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/.venv/bin/python3
export OMP_NUM_THREADS=2 VECLIB_MAXIMUM_THREADS=2
cd "$(dirname "$0")"
until [ $(grep -c '^fin' ver2_lanzar_B_salida2.txt) -ge 10 ]; do sleep 10; done
printf '%s\n' "V1 C0_0.05 ancho" "V1 C1 ancho" "V2 C0_0.05 ancho" "V2 C1 ancho" "V3 C0_0.05 ancho" "V3 C1 ancho" |
xargs -P 3 -L 1 bash -c 'echo "inicio $0 $1 $2 $(date)"; $P ver2_clasif.py $0 $1 $2 300000 100000 128 8 1 > ver2_B_$0_$1_$2_H128.txt 2>&1; echo "fin $0 $1 $2 $(date)"'
