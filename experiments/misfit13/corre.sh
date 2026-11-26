#!/bin/bash
# MISFIT-13: nucleo crecido, 4 variantes, 2 a la vez. Tope 20 min por corrida (gtimeout 1200); si corta, se para el contenedor.
LF=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow
R=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells
export PATH="$LF/venv_tt/bin:$PATH"; export LF R
uno(){
  v=$1; d=misfit13_core_$v$SUF; T=$(command -v gtimeout || command -v timeout)
  cd "$LF"; rm -rf $d; mkdir -p $d/runs/core && cp misfit06_core_obs/{config.json,e7_decoder.v,misfit04_core.v,misfit_core.v} $d/
  [ $v != v0 ] && cp "$R/instrument/misfit13/misfit_core.v" "$R/instrument/misfit13/misfit13_core.v" $d/ && rm $d/misfit04_core.v
  python3 - "$d" "$v" $DENS <<'P'
import json,sys
d,v=sys.argv[1:3]; c=json.load(open(d+"/config.json")); assert c["ROUTING_OBSTRUCTIONS"]==["met4 0 0 161 80"] and c["DIE_AREA"]=="0 0 161.00 87.04"
c.pop("FP_DEF_TEMPLATE")
if len(sys.argv) > 3: c.pop("PL_TARGET_DENSITY_PCT")   # enmienda 1
if v!="v0":
    c["DESIGN_NAME"]="misfit13_core"; c["VERILOG_FILES"]=["dir::misfit_core.v","dir::e7_decoder.v","dir::misfit13_core.v"]
    if v in ("v2","v3"): c["VERILOG_DEFINES"]=["SELMODE"+v[1]]
json.dump(c,open(d+"/config.json","w"),indent=2)
P
  echo "  empieza $v $(date +%H:%M:%S)"
  (cd $d && $T 1200 librelane --pdk-root ../pdk_host --docker-no-tty --dockerized --run-tag core --force-run-dir runs/core config.json > ../${d}_harden.log 2>&1); rc=$?
  if [ $rc = 124 ]; then for id in $(docker ps -q --filter ancestor=ghcr.io/librelane/librelane:3.0.14); do docker inspect -f '{{.Config.WorkingDir}} {{.Config.Cmd}} {{.Mounts}}' $id | grep -q "$d" && docker stop $id >/dev/null 2>&1; done; fi
  echo "  $v $(date +%H:%M:%S) rc=$rc"
}
export -f uno
echo "inicio $(date '+%Y-%m-%d %H:%M:%S %Z')"
printf '%s\n' ${VARS:-v0 v1 v3 v2} | xargs -P 2 -L 1 bash -c 'uno $0'
echo "fin $(date '+%Y-%m-%d %H:%M:%S %Z')"
