#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Stage 2: assembles the tile, reads its GDS back in a fresh Magic session for DRC and extraction, and compares the
# extraction against core netlist + standard cells + time-cell reference with netgen.
# Usage: SKY130A=<path> TTDEF=<tt_block_1x1_pg.def> ./lvs.sh <build dir> [variant]
set -e
HERE=$(cd "$(dirname "$0")" && pwd); B=$(cd "$1" && pwd); V=${2:-ok}
: "${SKY130A:?}" "${TTDEF:?}"
python3 "$HERE/gen_assemble.py" "$TTDEF" "$B/misfit02_core.lef" "$B/assemble.tcl" "$V" > "$B/assemble.txt"
cp "$HERE/top_ref.v" "$HERE/../cell/ref.spice" "$B/"
docker run --rm -v "$B":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work; T=tt_um_misfit02; RC=/pdk/libs.tech/magic/sky130A.magicrc
  magic -dnull -noconsole -rcfile $RC assemble.tcl > magic.txt 2>&1
  cat > extract.tcl <<TCL
drc off
gds read $T.gds
load $T
select top cell
drc style drc(full)
drc on ; drc check ; drc catchup
set n 0
foreach {msg boxes} [drc listall why] { incr n ; puts "   \$msg" }
puts "DRC-GDS $T violations=\$n"
drc off
extract all
ext2spice lvs
ext2spice -o $T.lvs.spice
quit -noprompt
TCL
  mkdir -p ext && cd ext && cp ../$T.gds ../extract.tcl . && magic -dnull -noconsole -rcfile $RC extract.tcl > ../extract.txt 2>&1 && cp $T.lvs.spice ..; cd ..
  cat > lvs.tcl <<TCL
set c1 [readnet spice $T.lvs.spice]
set c2 [readnet verilog /dev/null]
foreach f [glob /pdk/libs.ref/sky130_fd_sc_hd/spice/*.spice] { readnet spice \$f \$c2 }
readnet spice ref.spice \$c2
readnet verilog misfit02_core.pnl.v \$c2
readnet verilog top_ref.v \$c2
lvs "\$c1 $T" "\$c2 $T" /pdk/libs.tech/netgen/sky130A_setup.tcl lvs.rpt -blackbox
TCL
  netgen -batch source lvs.tcl > netgen.txt 2>&1' 2>&1 | grep -v "^\[INFO\]" || true
echo "$V: $(grep "^DRC-GDS" "$B/extract.txt") | $(grep -h "Final result" "$B/lvs.rpt" | tail -1) | property errors: $(grep -c "property errors" "$B/lvs.rpt")"
