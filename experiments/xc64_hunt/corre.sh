#!/bin/sh
# XC-64 caza de islas: Magic drc(full) en todos los puntos; KLayout (deck de fabricacion) en los puntos que Magic da por legales
# y en uno de cada 8 de los demas. Tope: 30 min en total (timeout dentro del contenedor).
cd "$(dirname "$0")"
R=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC
echo "inicio $(date '+%Y-%m-%d %H:%M:%S %Z')"
docker run --rm -v $R/06_exotic_cells:/work -v $R/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work/experiments/xc64_hunt && rm -rf out && mkdir out
  for p in pn_space m1_width tfet_n tfet_p vt_edge well_edge; do
    PROBE=probes/$p.tcl OUT=out timeout 600 magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc /work/residual/drc_edge/scan.tcl > out/$p.magic.log 2>&1
    pts=$(awk -F";" "NR>1 && (\$2==0 || (NR%8)==0) {print \$1}" out/$p.magic.csv | tr "\n" " ")
    timeout 1500 bash /work/residual/drc_edge/klayout_points.sh out $p $pts
    echo "$p: $(($(wc -l < out/$p.magic.csv)-1)) puntos, $(echo $pts | wc -w) por KLayout"
  done' 2>&1 | grep -v "^\[INFO\]"
echo "fin $(date '+%Y-%m-%d %H:%M:%S %Z')"
