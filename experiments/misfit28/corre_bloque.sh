#!/bin/bash
# MISFIT-28, parte fisica: bloque con el lazo v2 (LibreLane, tope 20 min), unidad + 3 mutantes (Magic, netgen), extraccion plana.
# Uso: corre_bloque.sh   (carpeta local_flow/misfit28_r2_a; no pisa una que exista)
LF=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow; R=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells
PDK=$LF/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A; E=$R/experiments/misfit28; U=$R/instrument/reader2/unit
export PATH="$LF/venv_tt/bin:$PATH"; T=$(command -v gtimeout || command -v timeout); d=misfit28_r2_a
cd "$LF"; [ -e $d ] && { echo "ya existe $d: no se pisa"; exit 1; }
mkdir -p $d/runs/core && cp "$R/instrument/reader2/"{reader2_slot.v,reader2_loop.v} "$U/"{config.json,template.def} $d/
echo "inicio $(date '+%Y-%m-%d %H:%M:%S %Z')"
(cd $d && $T 1200 librelane --pdk-root ../pdk_host --docker-no-tty --dockerized --run-tag core --force-run-dir runs/core config.json > ../${d}_harden.log 2>&1); rc=$?
if [ $rc = 124 ]; then for id in $(docker ps -q --filter ancestor=ghcr.io/librelane/librelane:3.0.14); do docker inspect -f '{{.Mounts}}' $id | grep -q "$d" && docker stop $id >/dev/null 2>&1; done; fi
echo "bloque rc=$rc $(date +%H:%M:%S)"; cp "$LF/${d}_harden.log" "$E/harden_a.log" 2>/dev/null; [ $rc = 0 ] || exit 1
F=$LF/$d/runs/core/final
SKY130A=$PDK "$U/lvs.sh" $F "$E/unidad_p1" ok | tail -1 > "$E/unidad.txt"; cat "$E/unidad.txt"
for v in noX noPRENL noVDD; do SKY130A=$PDK "$U/lvs.sh" $F "$E/mut_$v" $v | tail -1; done > "$E/mutantes.txt"; cat "$E/mutantes.txt"
mkdir -p "$E/ext" && cd "$E/ext" && cp ../unidad_p1/reader2_unit.gds . && cp ../ext_v1_unidad27/extrae.tcl . && docker run --rm -v $PWD:/w -v $PDK:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /w && magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc extrae.tcl > extrae.log 2>&1' 2>&1 | grep -v "^\[INFO\]"
echo "extraccion: $(grep -c '^X' r2uflat.pex.spice) dispositivos, $(grep -c '^C' r2uflat.pex.spice) condensadores"; echo "fin $(date '+%Y-%m-%d %H:%M:%S %Z')"
