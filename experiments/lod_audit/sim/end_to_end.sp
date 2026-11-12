* End to end: the two extracted netlists, as Magic wrote them and after lod_annotate.py. tt, 27 C, Vgs = 0.9 V, Vds = 0.05 V.
* Expected from lod_paso1: as extracted, both 0.774446 V; annotated, 0.797944 V and 0.766855 V (31.1 mV apart).
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
Vg g 0 0.9
Vd d 0 0.05
.include ../lod_sa030.spice
.include ../lod_sa300.spice
.include lod_annotated.inc
Xp030 0 d g 0 lod_sa030
Xp300 0 d g 0 lod_sa300
Xa030 0 d g 0 lod_sa030_lod
Xa300 0 d g 0 lod_sa300_lod
.control
op
let p030 = @m.xp030.x0.msky130_fd_pr__nfet_01v8[vth]
let p300 = @m.xp300.x0.msky130_fd_pr__nfet_01v8[vth]
let a030 = @m.xa030.x0.msky130_fd_pr__nfet_01v8[vth]
let a300 = @m.xa300.x0.msky130_fd_pr__nfet_01v8[vth]
let dp = (p030-p300)*1e3
let da = (a030-a300)*1e3
echo E2E extracted vth $&p030 $&p300 diff_mV $&dp
echo E2E annotated vth $&a030 $&a300 diff_mV $&da
quit
.endc
.end
