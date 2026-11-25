#!/bin/sh
# MISFIT-04 enmienda 3, E3: LVS del tile sin las tomas de sustrato (psd, psc) del macro, para ver si su tierra llega a VGND por metal.
# Usa el GDS y las referencias de i5/build_V (no los regenera). Uso: e3.sh V [V ...]. Salida: e3.tsv y V/ con lvs.rpt
set -e
E3=$(cd "$(dirname "$0")" && pwd); I5=$E3/../i5; EC=$(cd "$E3/../../.." && pwd); LF=$(cd "$EC/../local_flow" && pwd)
SKY130A=$LF/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A
for V in "$@"; do
  B=$E3/$V; rm -rf "$B"; mkdir -p "$B"
  cp $I5/build_$V/tt_um_misfit04.gds $I5/build_$V/ref.spice $I5/build_$V/top_ref.v $I5/build_$V/misfit04_core.pnl.v "$B/"
  docker run --rm -v "$B":/work -v "$SKY130A":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c '
  cd /work; T=tt_um_misfit04; RC=/pdk/libs.tech/magic/sky130A.magicrc
  cat > x.tcl <<TCL
drc off
gds read $T.gds
load $T
flatten tt_flat
load tt_flat
box 0um 0um 161um 128um
select area psc
puts "PSC-EN-CAJA [llength [what -list]]"
erase psc
erase psd
select clear
extract all
ext2spice lvs
ext2spice -o flat.lvs.spice
quit -noprompt
TCL
  magic -dnull -noconsole -rcfile $RC x.tcl > magic.txt 2>&1
  cat > lvs.tcl <<TCL
set c1 [readnet spice flat.lvs.spice]
set c2 [readnet verilog /dev/null]
foreach f [glob /pdk/libs.ref/sky130_fd_sc_hd/spice/*.spice] { readnet spice \$f \$c2 }
readnet spice ref.spice \$c2
readnet verilog misfit04_core.pnl.v \$c2
readnet verilog top_ref.v \$c2
lvs "\$c1 tt_flat" "\$c2 $T" /pdk/libs.tech/netgen/sky130A_setup.tcl lvs.rpt -blackbox
TCL
  netgen -batch source lvs.tcl > netgen.txt 2>&1' >/dev/null 2>&1 || true
  lvs=$(grep -q "Circuits match uniquely" "$B/lvs.rpt" 2>/dev/null && echo match || echo MISMATCH)
  printf "%s\t%s\t%s\n" "$V" "$lvs" "$(date +%H:%M:%S)" | tee -a "$E3/e3.tsv"
done
