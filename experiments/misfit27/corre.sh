#!/bin/bash
# MISFIT-27: bloque digital del lector 2 recolocado (dado fijo, pines por plantilla). Tope 20 min; si corta, se para el contenedor.
# Uso: corre.sh <etiqueta>   (carpeta local_flow/misfit27_r2_<etiqueta>; no pisa una que exista)
LF=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow
R=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells
export PATH="$LF/venv_tt/bin:$PATH"; T=$(command -v gtimeout || command -v timeout); d=misfit27_r2_${1:?etiqueta}
cd "$LF"; [ -e $d ] && { echo "ya existe $d: no se pisa"; exit 1; }
mkdir -p $d/runs/core && cp "$R/instrument/reader2/"{reader2_slot.v,reader2_loop.v} "$R/instrument/reader2/unit/"{config.json,template.def} $d/
echo "inicio $(date '+%Y-%m-%d %H:%M:%S %Z')"
(cd $d && $T 1200 librelane --pdk-root ../pdk_host --docker-no-tty --dockerized --run-tag core --force-run-dir runs/core config.json > ../${d}_harden.log 2>&1); rc=$?
if [ $rc = 124 ]; then for id in $(docker ps -q --filter ancestor=ghcr.io/librelane/librelane:3.0.14); do docker inspect -f '{{.Mounts}}' $id | grep -q "$d" && docker stop $id >/dev/null 2>&1; done; fi
echo "fin $(date '+%Y-%m-%d %H:%M:%S %Z') rc=$rc"; cp "$LF/${d}_harden.log" "$R/experiments/misfit27/harden_$1.log" 2>/dev/null
