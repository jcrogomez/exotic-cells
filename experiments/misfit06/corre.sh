#!/bin/bash
# MISFIT-06: tres corridas del nucleo (ctl = met4, m3, m2), una tras otra. Tope del prerregistro: 20 min por corrida (timeout 1200).
LF=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow
export PATH="$LF/venv_tt/bin:$PATH"
T=$(command -v gtimeout || command -v timeout)
cd "$LF"
echo "inicio $(date '+%Y-%m-%d %H:%M:%S %Z')"
for v in ctl:met4 m3:met3 m2:met2; do
  n=${v%%:*}; lay=${v##*:}; d=misfit06_core_$n
  mkdir -p $d/runs/core && cp misfit04_core/{config.json,core_template.def,e7_decoder.v,misfit04_core.v,misfit_core.v} $d/
  python3 - "$d/config.json" "$lay" <<'P'
import json,sys
c=json.load(open(sys.argv[1])); assert c["RT_MAX_LAYER"]=="met4"; c["RT_MAX_LAYER"]=sys.argv[2]; json.dump(c,open(sys.argv[1],"w"),indent=2)
P
  echo "  empieza $n ($lay) $(date +%H:%M:%S)"
  (cd $d && $T 1200 librelane --pdk-root ../pdk_host --docker-no-tty --dockerized --run-tag core --force-run-dir runs/core config.json > ../${d}_harden.log 2>&1); rc=$?
  echo "  $n $(date +%H:%M:%S) rc=$rc"
done
echo "fin $(date '+%Y-%m-%d %H:%M:%S %Z')"
