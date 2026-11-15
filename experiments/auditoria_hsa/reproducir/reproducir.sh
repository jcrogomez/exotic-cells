#!/bin/sh
# Reproduce el cambio de bin de la auditoría HSA: corre minimo.sp sin modo (A) y con el spinit del PDK, ngbehavior=hsa (B),
# y comprueba los dos resultados contra esperado.txt y contra las cifras de la auditoría (comprobar.py).
# Necesita ngspice 44.2 en el PATH y sky130A open_pdks 8afc8346 en $PDK_ROOT_SKY130A (por defecto /pdk), como la CI científica.
# Uso, desde la raíz de un clon:
#   docker run --rm -v $PWD:/work -v <sky130A>:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip \
#     sh /work/experiments/auditoria_hsa/reproducir/reproducir.sh
# o directamente en una máquina con ngspice y el PDK:  sh experiments/auditoria_hsa/reproducir/reproducir.sh
set -e
here=$(cd "$(dirname "$0")" && pwd)
root=$(cd "$here/../../.." && pwd)
out=${1:-$here/corrida}
mkdir -p "$out/A" "$out/B"
cp "$here/minimo.sp" "$out/A/"; cp "$here/minimo.sp" "$out/B/"
rm -f "$out/A/.spiceinit"
# A: ningún archivo de inicio (SPICE_USERINIT_DIR y HOME a una carpeta vacía; sin .spiceinit local) -> ngspice sin modo de
# compatibilidad, como las corridas guardadas antes del 2026-11-14. Quitar solo SPICE_USERINIT_DIR no basta: ngspice lee entonces
# ~/.spiceinit, y el de la imagen (/headless/.spiceinit) activa hsa (comprobado 2026-11-15).
mkdir -p "$out/vacio"
(cd "$out/A" && env SPICE_USERINIT_DIR="$out/vacio" HOME="$out/vacio" ngspice -b minimo.sp > minimo.log 2>&1) || { echo "A: ngspice falló"; cat "$out/A/minimo.log"; exit 1; }
# B: el wrapper del repo (spinit de sky130A como .spiceinit, ngbehavior=hsa)
(cd "$out/B" && "$root/tools/ngspice_pdk.sh" minimo.sp > minimo.log 2>&1) || { echo "B: ngspice falló"; cat "$out/B/minimo.log"; exit 1; }
python3 "$here/comprobar.py" "$out/A/minimo.log" "$out/B/minimo.log" "$here/esperado.txt"
