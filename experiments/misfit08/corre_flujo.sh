#!/bin/bash
# MISFIT-08, L5: flujo completo del nucleo lean, misma configuracion que misfit06_core_ctl. Tope 20 min; si gtimeout corta,
# se para tambien el contenedor (leccion de MISFIT-06).
LF=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow
SRC=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/instrument/misfit08/misfit_core.v
export PATH="$LF/venv_tt/bin:$PATH"; T=$(command -v gtimeout || command -v timeout)
cd "$LF"; d=misfit08_core_lean
mkdir -p $d/runs/core && cp misfit04_core/{config.json,core_template.def,e7_decoder.v,misfit04_core.v} $d/ && cp "$SRC" $d/misfit_core.v
echo "empieza lean $(date '+%Y-%m-%d %H:%M:%S %Z')"
(cd $d && $T 1200 librelane --pdk-root ../pdk_host --docker-no-tty --dockerized --run-tag core --force-run-dir runs/core config.json > ../${d}_harden.log 2>&1); rc=$?
[ $rc = 124 ] && docker ps -q --filter ancestor=ghcr.io/librelane/librelane:3.0.14 | xargs -r docker stop
echo "lean $(date +%H:%M:%S) rc=$rc"
