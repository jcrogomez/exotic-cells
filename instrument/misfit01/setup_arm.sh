#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Builds a run folder for one arm inside the local bench and hardens it with the Tiny Tapeout flow (LibreLane 3.0.14).
#   ./setup_arm.sh <run name> <bench> <arm> [layout variant] [netlist variant]
#   e.g.  ./setup_arm.sh a2 ../../../local_flow a2            (cell and reference netlist: variants/ok)
#         ./setup_arm.sh a2n2 ../../../local_flow a2 len10 ok (layout with L = 1.0, reference netlist of L = 0.5)
# The bench must hold harden_host.sh, tt-support-tools and the pinned PDK (see local_flow/LEEME.md; not in this repository).
set -e
HERE=$(cd "$(dirname "$0")" && pwd); NAME=$1; LF=$(cd "$2" && pwd); ARM=$3; LAY=${4:-ok}; NET=${5:-ok}; RUN="$LF/misfit01_$NAME"
[ ! -e "$RUN" ] || { echo "$RUN exists; not overwriting it" >&2; exit 2; }
mkdir -p "$RUN/src/cells" "$RUN/docs"
cp "$HERE/$ARM/info.yaml" "$RUN/"; cp -R "$HERE/$ARM/src/." "$RUN/src/"
cp "$HERE/cell/variants/$LAY/misfit_inv.gds" "$HERE/cell/variants/$LAY/misfit_inv.lef" "$RUN/src/cells/"
cp "$HERE/cell/variants/$NET/misfit_inv.spice" "$HERE/cell/misfit_inv_bb.v" "$RUN/src/cells/"
printf '## How it works\n\nIntegration trial.\n\n## How to test\n\nSee the repository.\n' > "$RUN/docs/info.md"
ln -s ../tt-support-tools "$RUN/tt"
(cd "$RUN" && git init -q && git add -A && git -c user.name=misfit -c user.email=misfit@localhost commit -qm "run $NAME" )
cd "$LF" && { ./harden_host.sh "misfit01_$NAME" > "misfit01_${NAME}_harden.log" 2>&1; echo "rc=$?" >> "misfit01_${NAME}_harden.log"; }
echo "$NAME: $(tail -1 "misfit01_${NAME}_harden.log")"
