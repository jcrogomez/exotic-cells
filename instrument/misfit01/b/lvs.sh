#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Arm B: assembles the tile in Magic, then compares the netlist extracted from the tile's GDS against the reference
# (structural top level + gate-level netlist of the core + PDK standard-cell SPICE + the macro's SPICE) with netgen.
# Usage: SKY130A=<path> TTDEF=<tt_block_1x1_pg.def> ./lvs.sh <build dir> [variant]
set -e
HERE=$(cd "$(dirname "$0")" && pwd); B=$(cd "$1" && pwd); V=${2:-ok}
: "${SKY130A:?}" "${TTDEF:?}"
python3 "$HERE/gen_assemble.py" "$TTDEF" "$B/misfit01_core.lef" "$B/assemble.tcl" "$V" > "$B/assemble.txt"
cp "$HERE/top_ref.v" "$B/"
docker run --rm -v "$B":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work
  magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc assemble.tcl > magic.txt 2>&1
  # extraction and DRC from the GDS just written, in a fresh session: nothing of the assembly session is reused
  cat > extract.tcl <<TCL
drc off
gds read tt_um_misfit01b.gds
load tt_um_misfit01b
select top cell
drc style drc(full)
drc on ; drc check ; drc catchup
set n 0
foreach {msg boxes} [drc listall why] { incr n ; puts "   \$msg" }
puts "DRC-GDS tt_um_misfit01b violations=\$n"
drc off
extract all
ext2spice lvs
ext2spice -o tt_um_misfit01b.lvs.spice
quit -noprompt
TCL
  mkdir -p ext && cd ext && cp ../tt_um_misfit01b.gds ../extract.tcl . && magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc extract.tcl > ../extract.txt 2>&1 && cp tt_um_misfit01b.lvs.spice .. ; cd ..
  cat > lvs.tcl <<TCL
set c1 [readnet spice tt_um_misfit01b.lvs.spice]
set c2 [readnet verilog /dev/null]
foreach f [glob /pdk/libs.ref/sky130_fd_sc_hd/spice/*.spice] { readnet spice \$f \$c2 }
readnet spice macro_ref.spice \$c2
readnet verilog misfit01_core.pnl.v \$c2
readnet verilog top_ref.v \$c2
lvs "\$c1 tt_um_misfit01b" "\$c2 tt_um_misfit01b" /pdk/libs.tech/netgen/sky130A_setup.tcl lvs.rpt -blackbox
TCL
  netgen -batch source lvs.tcl > netgen.txt 2>&1' 2>&1 | grep -v "^\[INFO\]" || true
echo "$(grep "^DRC tt_um" "$B/magic.txt") | $(grep "^DRC-GDS" "$B/extract.txt") | $(grep -h "Final result" "$B/lvs.rpt" | tail -1) | property errors: $(grep -c "property errors" "$B/lvs.rpt")"
