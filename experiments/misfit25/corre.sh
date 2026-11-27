#!/bin/bash
# MISFIT-25: bloque digital del lector 2, variantes prot y libre, una tras otra. Tope 20 min (gtimeout 1200); si corta, se para el contenedor.
# Uso: corre.sh [sufijo]   (el sufijo nombra una enmienda: carpetas misfit25_r2_<v><sufijo>)
LF=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow
R=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells
export PATH="$LF/venv_tt/bin:$PATH"; SUF=$1; T=$(command -v gtimeout || command -v timeout)
echo "inicio $(date '+%Y-%m-%d %H:%M:%S %Z')"
for v in prot libre; do
  d=misfit25_r2_$v$SUF; cd "$LF"; [ -e $d ] && { echo "ya existe $d: no se pisa"; continue; }
  mkdir -p $d/runs/core && cp "$R/instrument/reader2/"{config.json,reader2_slot.v,reader2_loop.v} $d/
  [ $v = libre ] && python3 - $d <<'P'
import json, sys
p = sys.argv[1] + "/config.json"; c = json.load(open(p))
for k in ("DESIGN_REPAIR_BUFFER_INPUT_PORTS", "DESIGN_REPAIR_BUFFER_OUTPUT_PORTS", "RSZ_DONT_TOUCH_RX"): c.pop(k)
json.dump(c, open(p, "w"), indent=2)
P
  echo "  empieza $v $(date +%H:%M:%S)"
  (cd $d && $T 1200 librelane --pdk-root ../pdk_host --docker-no-tty --dockerized --run-tag core --force-run-dir runs/core config.json > ../${d}_harden.log 2>&1); rc=$?
  if [ $rc = 124 ]; then for id in $(docker ps -q --filter ancestor=ghcr.io/librelane/librelane:3.0.14); do docker inspect -f '{{.Mounts}}' $id | grep -q "$d" && docker stop $id >/dev/null 2>&1; done; fi
  echo "  $v $(date +%H:%M:%S) rc=$rc"; cp "$LF/${d}_harden.log" "$R/experiments/misfit25/harden_$v$SUF.log" 2>/dev/null
done
echo "fin $(date '+%Y-%m-%d %H:%M:%S %Z')"
