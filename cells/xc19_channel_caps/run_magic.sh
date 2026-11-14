#!/bin/sh
# Dibuja, comprueba (DRC de Magic) y extrae la celda. Uso: SKY130A=<ruta a sky130A> ./run_magic.sh
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
REPO=$(cd "$HERE/../.." && pwd)
: "${SKY130A:?defina SKY130A}"
docker run --rm -v "$REPO":/work -v "$SKY130A":/pdk:ro -e XC19_WC -e XC19_NROW -e XC19_PH hpretl/iic-osic-tools:2025.07 --skip bash -c \
  'cd /work/cells/xc19_channel_caps && magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc xc19_channel_caps.tcl > xc19_channel_caps.log 2>&1' 2>&1 | grep -v '^\[INFO\]' || true
grep -A40 "^DRC xc19_channel_caps" "$HERE/xc19_channel_caps.log" | head -40
grep "^BBOX" "$HERE/xc19_channel_caps.log"
