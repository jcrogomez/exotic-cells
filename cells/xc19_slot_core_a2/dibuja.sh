#!/bin/sh
# MISFIT-03 enmienda 2, exploracion: dibuja, DRC, extrae y anota xc19_slot_core con INVHVT / SANDW / PWU / PHU del entorno,
# en una subcarpeta propia por variante. Uso: dibuja.sh <nombre>   (variables de entorno ya puestas)
set -e
HERE=$(cd "$(dirname "$0")" && pwd); REPO=$(cd "$HERE/../.." && pwd); V=$1
LF=$(cd "$REPO/../local_flow" && pwd); SKY130A=$LF/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A
D=$HERE/v_$V; rm -rf "$D"; mkdir -p "$D"; cp "$HERE"/xc19_slot_core.tcl "$HERE"/annotate.py "$HERE"/medir_u.py "$HERE"/ref.spice "$D/"
# la variante vive en cells/xc19_slot_core_a2/v_<V>: ../xc19_bias del tcl debe resolver -> enlace
ln -s ../xc19_bias "$HERE/xc19_bias" 2>/dev/null || true
docker run --rm -e PWU -e PHU -e XBS -e XBH -e INVHVT -e SANDW -e MOSU -e MOSL -e NROW -v "$REPO":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c \
  "cd /work/cells/xc19_slot_core_a2/v_$V && magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc xc19_slot_core.tcl > xc19_slot_core.log 2>&1" >/dev/null 2>&1 || true
grep "^DRC xc19_slot_core" -A8 "$D/xc19_slot_core.log" | head -9
grep "^BBOX" "$D/xc19_slot_core.log"
