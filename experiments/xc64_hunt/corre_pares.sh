#!/bin/sh
# XC-64 caza sistematica: 156 escaneos x 82 puntos en Magic. Tope del prerregistro: 40 min (timeout 2400 dentro del contenedor).
cd "$(dirname "$0")"
R=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC
echo "inicio $(date '+%Y-%m-%d %H:%M:%S %Z')"
docker run --rm -v $R/06_exotic_cells:/work -v $R/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /work/experiments/xc64_hunt && timeout 2400 magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc pares.tcl > pares.magic.log 2>&1; echo "salida $? lineas $(wc -l < pares.csv)"' 2>&1 | grep -v "^\[INFO\]"
echo "fin $(date '+%Y-%m-%d %H:%M:%S %Z')"
