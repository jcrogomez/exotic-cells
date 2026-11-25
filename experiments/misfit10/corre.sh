#!/bin/bash
# MISFIT-10: bloque del nucleo a 28/26/24/22/20 filas (lean) y 26/24/22 (original), con la obstruccion de met4 de MISFIT-06.
# Dos a la vez. Tope del prerregistro: 20 min por corrida (gtimeout 1200); si corta, se para el contenedor de esa corrida.
LF=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow
R=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells
export PATH="$LF/venv_tt/bin:$PATH"; export LF R
uno(){
  v=$1; rows=$2; dens=$3; d=misfit10_core_${v}_r$rows; T=$(command -v gtimeout || command -v timeout)
  cd "$LF"; mkdir -p $d/runs/core && cp misfit04_core/{config.json,core_template.def,e7_decoder.v,misfit04_core.v,misfit_core.v} $d/
  [ $v = lean ] && cp "$R/instrument/misfit08/misfit_core.v" $d/misfit_core.v
  python3 - "$d" "$rows" "$dens" <<'P'
import json,sys
d,rows,dens=sys.argv[1],int(sys.argv[2]),int(sys.argv[3]); H=rows*2720
t=open(d+"/core_template.def").read(); assert t.count("( 161000 87040 )")==1 and t.count(" 86540 ) N ;")==43
open(d+"/core_template.def","w").write(t.replace("( 161000 87040 )",f"( 161000 {H} )").replace(" 86540 ) N ;",f" {H-500} ) N ;"))
c=json.load(open(d+"/config.json")); assert c["DIE_AREA"]=="0 0 161.00 87.04" and c["PL_TARGET_DENSITY_PCT"]==60
c["DIE_AREA"]=f"0 0 161.00 {H/1000:.2f}"; c["PL_TARGET_DENSITY_PCT"]=dens; c["ROUTING_OBSTRUCTIONS"]=[f"met4 0 0 161 {H/1000-7.04:.2f}"]
json.dump(c,open(d+"/config.json","w"),indent=2)
P
  echo "  empieza $v $rows filas $(date +%H:%M:%S)"
  (cd $d && $T 1200 librelane --pdk-root ../pdk_host --docker-no-tty --dockerized --run-tag core --force-run-dir runs/core config.json > ../${d}_harden.log 2>&1); rc=$?
  if [ $rc = 124 ]; then for id in $(docker ps -q --filter ancestor=ghcr.io/librelane/librelane:3.0.14); do docker inspect -f '{{.Config.WorkingDir}} {{.Config.Cmd}}' $id | grep -q "$d" && docker stop $id >/dev/null 2>&1; done; fi
  echo "  $v $rows filas $(date +%H:%M:%S) rc=$rc"
}
export -f uno
echo "inicio $(date '+%Y-%m-%d %H:%M:%S %Z')"
printf '%s\n' "lean 28 65" "lean 20 90" "lean 26 70" "orig 26 70" "lean 24 75" "orig 24 75" "lean 22 82" "orig 22 82" | xargs -P 2 -L 1 bash -c 'uno $0 $1 $2'
echo "fin $(date '+%Y-%m-%d %H:%M:%S %Z')"
