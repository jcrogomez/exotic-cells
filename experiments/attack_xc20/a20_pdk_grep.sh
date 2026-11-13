#!/bin/sh
# a20: evidencia del PDK local (solo lectura). Uso: sh a20_pdk_grep.sh > a20_pdk.txt
P="${SKY130A:?set SKY130A to the sky130A PDK directory}"
T=$P/libs.tech/magic/sky130A.tech
date
echo "== 1. hoja de difusion/poly/li (mohm/sq) y contactos (mohm) : $T"
grep -n "resist (\*ndiff\|resist (\*pdiff\|resist (allpolynonres\|resist (allli)\|contact ndc,nsc\|contact pdc,psc\|Resistances are in" $T
echo "== 2. 'silicid' en el tech de magic (solo estilo de dibujo de resistencias de poly?)"
grep -n -i "silicid\|salicid" $T
echo "== 3. conectividad: nsd conecta con nwell; pdiff no conecta con nsd"
sed -n 668,671p $T; sed -n 681,682p $T; sed -n 358p $T; sed -n 363p $T
echo "== 4. reglas de union pegada (butting)"
grep -n -i "butt\|cannot abut\|diff/tap.3\|diff/tap.5" $T
echo "== 5. klayout drc: difftap / licon.5b / siliciuro"
grep -n -i "difftap.[3-7]\|licon.5b\|silicid\|butt" $P/libs.tech/klayout/drc/sky130A_mr.drc | head -40
echo "== 6. seccion transversal klayout (ilustrativa): profundidades"
grep -n "impl_depth\|impl_radius\|nwell_depth\|sti_depth\|silic" $P/libs.tech/klayout/tech/xsect/sky130.xs
echo "== 7. celdas hd con toma (nsubdiff/psubdiff) y cuantas capas ndiff/pdiff tienen"
for f in $(grep -l "<< nsubdiff >>\|<< psubdiff >>" $P/libs.ref/sky130_fd_sc_hd/mag/*.mag); do echo "$(basename $f) diff_layers=$(grep -c '<< ndiff >>\|<< pdiff >>' $f)"; done
echo "   total celdas hd: $(ls $P/libs.ref/sky130_fd_sc_hd/mag/*.mag | wc -l)"
echo "== 8. modelos de diodo: cj mj pb cjsw js n bv"
for m in diode_pd2nw_05v5 diode_pd2nw_05v5_lvt diode_pd2nw_05v5_hvt diode_pd2nw_11v0 diode_pw2nd_05v5 diode_pw2nd_05v5_lvt diode_pw2nd_05v5_nvt diode_pw2nd_11v0; do
 f=$P/libs.ref/sky130_fd_pr/spice/sky130_fd_pr__$m.model.spice
 echo "-- $m"; grep -n "^+ cj \|^+ mj \|^+ pb \|^+ cjsw \|^+ mjsw \|^+ php \|^+ js \|^+ jsw \|^+ n = \|^+ bv \|^+ ibv \|^+ eg \|^+ xti \|level" $f
done
echo "== 9. otros diodos / zener en el PDK"
ls $P/libs.ref/sky130_fd_pr/spice | grep -i "diode\|zener"; grep -rli zener $P/libs.ref/sky130_fd_pr/spice $P/libs.tech/ngspice 2>/dev/null | head
echo "== 10. MOS 1v8 tt: xj, cj, pb, mj, ndep, nsd, gidl, bvs/xjbvs, jtss (tunel de union)"
for d in nfet_01v8 pfet_01v8; do f=$P/libs.ref/sky130_fd_pr/spice/sky130_fd_pr__${d}__tt.pm3.spice; echo "-- $f"
 awk '/^\.model/{n++} n==1' $f | grep -n -i -o "\b\(xj\|cjs\|cjd\|pbs\|mjs\|cjsws\|pbsws\|mjsws\|ndep\|nsd\|ngate\|agidl\|bgidl\|cgidl\|egidl\|bvs\|xjbvs\|ijthsrev\|jss\|jsws\|jtss\|jtssws\|njts\|vtss\|xtss\|njs\|rsh\|rdsw\|toxe\|version\|level\) *= *[^ ]*" | sort -u -t: -k2 | head -60
done
