#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Runs ngspice with the SKY130 PDK's own settings (spinit: ngbehavior=hsa, skywaterpdk, klu...), in the current folder.
#   tools/ngspice_pdk.sh deck.sp > deck.log 2>&1        (PDK at $PDK_ROOT_SKY130A, default /pdk)
# One run per folder at a time: the .spiceinit it writes is shared by the folder.
# Why: iic-osic-tools sets SPICE_USERINIT_DIR to the IHP folder, so ngspice ignores a local .spiceinit and runs with no
# compatibility mode. That moves the BSIM4 bin chosen at an exact W/L bin edge (audit: experiments/AUDITORIA_HSA_2026-11-13.md).
# KLU aborts every .noise analysis in ngspice 44.2, so for decks with .noise the 'option klu' line is dropped.
set -e
deck=${1:?usage: ngspice_pdk.sh deck.sp}
spinit=${PDK_ROOT_SKY130A:-/pdk}/libs.tech/ngspice/spinit
[ -f "$spinit" ] || { echo "no spinit at $spinit" >&2; exit 2; }
[ ! -e .spiceinit ] || { echo ".spiceinit already here; not overwriting it" >&2; exit 2; }
if grep -qiE '^[[:space:]]*\.?noise[[:space:]]' "$deck"; then
  grep -vi '^[[:space:]]*option[[:space:]]*klu' "$spinit" > .spiceinit
else
  cp "$spinit" .spiceinit
fi
trap 'rm -f .spiceinit' EXIT
env -u SPICE_USERINIT_DIR ngspice -b "$deck"
