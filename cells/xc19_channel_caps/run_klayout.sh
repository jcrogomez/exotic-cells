#!/bin/sh
# DRC en KLayout de la celda: deck sky130A_mr.drc (front-end, back-end y rejilla) y deck completo sky130A.lydrc con el
# front-end activado (el deck trae FEOL = false; se copia a /tmp del contenedor con FEOL = true, el PDK no se toca).
# Uso: SKY130A=<ruta a sky130A> ./run_klayout.sh
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
REPO=$(cd "$HERE/../.." && pwd)
: "${SKY130A:?defina SKY130A}"
docker run --rm -v "$REPO":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
cd /work/cells/xc19_channel_caps
klayout -b -rd input=xc19_channel_caps.gds -rd top_cell=xc19_channel_caps -rd report=xc19_channel_caps.lyrdb \
  -rd feol=true -rd beol=true -rd offgrid=true -r /pdk/libs.tech/klayout/drc/sky130A_mr.drc > klayout_mr.log 2>&1
sed "s/^FEOL    = false/FEOL    = true/" /pdk/libs.tech/klayout/drc/sky130A.lydrc > /tmp/sky130A_feol.lydrc
grep -n "^FEOL" /tmp/sky130A_feol.lydrc
klayout -b -rd input=xc19_channel_caps.gds -rd report=xc19_channel_caps_full.lyrdb -r /tmp/sky130A_feol.lydrc > klayout_full.log 2>&1
for f in xc19_channel_caps.lyrdb xc19_channel_caps_full.lyrdb; do echo "$f items=$(grep -c "<item>" $f)"; done
' 2>&1 | grep -v '^\[INFO\]'
