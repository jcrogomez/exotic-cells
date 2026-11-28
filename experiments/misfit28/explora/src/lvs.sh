#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# Assembles reader2_unit, reads its GDS back in a fresh Magic session for DRC and extraction, and compares the extraction with
# netgen against: the block's final powered netlist + standard cells + reader2fe's reference + top_ref.v.
# Usage: SKY130A=<path> ./lvs.sh <LibreLane final dir of the block> <build dir> [variant]
set -e
HERE=$(cd "$(dirname "$0")" && pwd); F=$(cd "$1" && pwd); mkdir -p "$2"; B=$(cd "$2" && pwd); V=${3:-ok}
: "${SKY130A:?}"
cp "$F/gds/reader2_slot.gds" "$F/lef/reader2_slot.lef" "$F/pnl/reader2_slot.pnl.v" "$B/"
cp "$HERE/../../../experiments/misfit22/reader2fe/reader2fe.gds" "$HERE/../../../experiments/misfit22/reader2fe/reader2fe_ref.spice" "$HERE/top_ref.v" "$B/"
(cd "$HERE" && python3 gen_assemble.py "$B/reader2_slot.lef" "$B/assemble.tcl" "$V") > "$B/assemble.txt"
docker run --rm -v "$B":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work; T=reader2_unit; RC=/pdk/libs.tech/magic/sky130A.magicrc
  magic -dnull -noconsole -rcfile $RC assemble.tcl > magic.txt 2>&1
  cat > extract.tcl <<TCL
drc off
gds read $T.gds
load $T
select top cell
drc style drc(full)
drc on ; drc check ; drc catchup
set n 0
foreach {msg boxes} [drc listall why] { incr n ; puts "   \$msg  @ [lrange \$boxes 0 1]" }
puts "DRC-GDS $T violations=\$n"
drc off
extract all
ext2spice lvs
ext2spice -o $T.lvs.spice
quit -noprompt
TCL
  rm -rf ext; mkdir -p ext && cd ext && cp ../$T.gds ../extract.tcl . && magic -dnull -noconsole -rcfile $RC extract.tcl > ../extract.txt 2>&1 && cp $T.lvs.spice ..; cd ..
  cat > lvs.tcl <<TCL
set c1 [readnet spice $T.lvs.spice]
set c2 [readnet verilog /dev/null]
foreach f [glob /pdk/libs.ref/sky130_fd_sc_hd/spice/*.spice] { readnet spice \$f \$c2 }
readnet spice reader2fe_ref.spice \$c2
readnet verilog reader2_slot.pnl.v \$c2
readnet verilog top_ref.v \$c2
lvs "\$c1 $T" "\$c2 $T" /pdk/libs.tech/netgen/sky130A_setup.tcl lvs.rpt -blackbox
TCL
  netgen -batch source lvs.tcl > netgen.txt 2>&1' 2>&1 | grep -v "^\[INFO\]" || true
echo "$V: $(grep "^DRC-GDS" "$B/extract.txt") | $(grep -h "Final result" "$B/lvs.rpt" | tail -1) | property errors: $(grep -c "property errors" "$B/lvs.rpt")"
