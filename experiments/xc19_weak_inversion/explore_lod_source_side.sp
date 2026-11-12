* Exploratory check of an arithmetic claim in part 3 (N4): with the long diffusion only on the source side, the stress formula
* gives about half the threshold difference (15.5 mV instead of 31.1 mV), and the drain junction stays the same.
* Written before running: threshold difference 15.5 mV, weak-inversion current ratio about 1.53. tt, 27 C, Vg = 0.47 V, Vd = 0.9 V.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
.options gmin=1e-18 abstol=1e-18 reltol=1e-6
Vg g 0 0.47
Va da 0 0.9
Vb db 0 0.9
Vc dc 0 0.9
Xa da g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3 sb=0.3
Xb db g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=3.0 sb=0.3
Xc dc g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=3.0 sb=3.0
.control
op
let va = @m.xa.msky130_fd_pr__nfet_01v8[vth]
let vb = @m.xb.msky130_fd_pr__nfet_01v8[vth]
let vc = @m.xc.msky130_fd_pr__nfet_01v8[vth]
let ia = -i(Va)
let ib = -i(Vb)
let ic = -i(Vc)
echo SRC vth $&va $&vb $&vc id $&ia $&ib $&ic
quit
.endc
.end
