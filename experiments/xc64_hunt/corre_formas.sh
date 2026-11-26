#!/bin/sh
# XC-64 caza de formas: Magic drc(full) en todos los puntos; KLayout de fabricacion en los legales y en 1 de cada 8 del resto.
# Tope: 40 min en total (timeouts dentro del contenedor).
cd "$(dirname "$0")"
R=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC
echo "inicio $(date '+%Y-%m-%d %H:%M:%S %Z')"
docker run --rm -v $R/06_exotic_cells:/work -v $R/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work/experiments/xc64_hunt && rm -rf out_formas && mkdir out_formas
  for p in step_gate hole_gate bent_gate ring_gate; do
    PROBE=formas/$p.tcl OUT=out_formas timeout 600 magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc /work/residual/drc_edge/scan.tcl > out_formas/$p.magic.log 2>&1
    pts=$(awk -F";" "NR>1 && (\$2==0 || (NR%8)==0) {print \$1}" out_formas/$p.magic.csv | tr "\n" " ")
    timeout 1500 bash /work/residual/drc_edge/klayout_points.sh out_formas $p $pts
    echo "$p: $(($(wc -l < out_formas/$p.magic.csv)-1)) puntos, $(echo $pts | wc -w) por KLayout"
  done' 2>&1 | grep -v "^\[INFO\]" | grep ': '
echo "fin $(date '+%Y-%m-%d %H:%M:%S %Z')"
