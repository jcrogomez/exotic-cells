#!/bin/sh
# Dibuja, comprueba (DRC de Magic) y extrae xc19_slot_core. Uso: SKY130A=<ruta a sky130A> ./run_magic.sh
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
REPO=$(cd "$HERE/../.." && pwd)
: "${SKY130A:?defina SKY130A}"
docker run --rm -e PWU -e PHU -e XBS -e XBH -v "$REPO":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c \
  'cd /work/cells/xc19_slot_core && magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc xc19_slot_core.tcl > xc19_slot_core.log 2>&1' 2>&1 | grep -v '^\[INFO\]' || true
grep -A60 "^DRC xc19_slot_core" "$HERE/xc19_slot_core.log" | head -60
grep "^BBOX" "$HERE/xc19_slot_core.log"
