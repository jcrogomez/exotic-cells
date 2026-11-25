#!/bin/bash
# MISFIT-06 enmienda 1: corrida obs (obstruccion de met4 en y 0-80). Espera a que termine corre.sh (m2). Tope 20 min (timeout 1200).
LF=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow
H="$(cd "$(dirname "$0")" && pwd)"
export PATH="$LF/venv_tt/bin:$PATH"; T=$(command -v gtimeout || command -v timeout)
until grep -q '^fin' "$H/corre.out"; do sleep 10; done
cd "$LF"; d=misfit06_core_obs
mkdir -p $d/runs/core && cp misfit04_core/{config.json,core_template.def,e7_decoder.v,misfit04_core.v,misfit_core.v} $d/
python3 - "$d/config.json" <<'P'
import json,sys
c=json.load(open(sys.argv[1])); assert c["RT_MAX_LAYER"]=="met4"; c["ROUTING_OBSTRUCTIONS"]=["met4 0 0 161 80"]; json.dump(c,open(sys.argv[1],"w"),indent=2)
P
echo "empieza obs $(date '+%Y-%m-%d %H:%M:%S %Z')"
(cd $d && $T 1200 librelane --pdk-root ../pdk_host --docker-no-tty --dockerized --run-tag core --force-run-dir runs/core config.json > ../${d}_harden.log 2>&1); echo "obs $(date +%H:%M:%S) rc=$?"
