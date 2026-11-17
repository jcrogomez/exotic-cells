#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Does a tech-file change alone make Magic write sa/sb? Appends "l1=sa l2=sb" to the nfet_01v8 device line of a COPY of the
# SKY130 tech file and extracts the two reproducers again. The PDK itself is mounted read-only and is not modified.
# Usage: SKY130A=<path to sky130A> ./run_techmod.sh      (Docker, hpretl/iic-osic-tools:2025.07, Magic 8.3.530)
set -e
HERE=$(cd "$(dirname "$0")" && pwd)
: "${SKY130A:?set SKY130A to the sky130A folder of the PDK}"
mkdir -p "$HERE/techmod"
python3 - "$SKY130A/libs.tech/magic/sky130A.tech" "$HERE/techmod/sky130A_mod.tech" <<'PY'
import sys
L = open(sys.argv[1]).read().split("\n")
hits = [i for i, x in enumerate(L) if x.startswith(" device msubcircuit sky130_fd_pr__nfet_01v8 nfet,scnfet")]
assert len(hits) == 1, hits
i = hits[0] + 2
assert L[i].strip() == "w>=0.42 l=l w=w a1=as p1=ps a2=ad p2=pd", L[i]
L[i] += " l1=sa l2=sb"
open(sys.argv[2], "w").write("\n".join(L))
PY
docker run --rm -v "$HERE":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work/techmod
  sed "s#^tech load .*#tech load /work/techmod/sky130A_mod.tech -noprompt#" /pdk/libs.tech/magic/sky130A.magicrc > mod.magicrc
  PDK_ROOT=/nonexistent magic -dnull -noconsole -rcfile mod.magicrc ../lod_min.tcl > magic_lod.txt 2>&1
  PDK_ROOT=/nonexistent magic -dnull -noconsole -rcfile mod.magicrc ../two_finger.tcl > magic_twof.txt 2>&1' 2>&1 | grep -v "^\[INFO\]" || true
{ echo "# modified tech file (l1=sa l2=sb on nfet_01v8), Magic 8.3.530"; grep -h "^X" "$HERE"/techmod/lod_sa030.spice "$HERE"/techmod/lod_sa300.spice "$HERE"/techmod/twof.spice; } | tee "$HERE/result_techmod.txt"
