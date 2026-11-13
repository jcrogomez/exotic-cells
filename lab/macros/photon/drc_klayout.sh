#!/bin/bash
# DRC KLayout + prBoundary + lista de capas para todas las celdas PHOTON. Correr desde macros/photon con la carpeta macros/ montada:
#   docker run --rm -v "$PWD/..":/work hpretl/iic-osic-tools:2025.07 --skip bash -c "cd /work/photon && ./drc_klayout.sh"
set -u
for c in photon_fd photon_fd_l10 photon_e05 photon_e10 photon_e20 photon_e05g; do
  klayout -b -r /foss/pdks/sky130A/libs.tech/klayout/drc/sky130A_mr.drc -rd input=$c.gds -rd report=$c.lyrdb -rd topcell=$c \
    -rd feol=true -rd beol=true -rd offgrid=true -rd seal=false -rd floating_met=false >/dev/null 2>&1
  klayout -b -r ../constriccion/add_prboundary.py -rd input=$c.gds -rd output=${c}_pr.gds 2>&1 | grep prBoundary
  klayout -b -r cuenta_lyrdb.py -rd input=$c.lyrdb
  klayout -b -r capas.py -rd input=${c}_pr.gds
done
