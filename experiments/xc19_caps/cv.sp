* C(V) de los candidatos a condensador, tt 27 C. Rampa de 1 V/us en la placa "alta"; C = I / (dV/dt).
* Todos normalizados a 100 um2 de puerta/placa dibujada.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
Vg g 0 pwl(0 0 1.8u 1.8)
Vgn gn 0 pwl(0 1.8 1.8u 0)
* nfet 10x10: puerta en g, S/D/B a tierra
V1 g g1 0
X1 0 g1 0 0 sky130_fd_pr__nfet_01v8 w=10 l=10
* nfet lvt 10x10
V2 g g2 0
X2 0 g2 0 0 sky130_fd_pr__nfet_01v8_lvt w=10 l=10
* pfet 10x10 en pozo a 1.8 V, puerta en gn (gn = 1.8 - g): la tension puerta-pozo es -g
Vdd vdd 0 1.8
V3 gn g3 0
X3 vdd g3 vdd vdd sky130_fd_pr__pfet_01v8 w=10 l=10
* varactor lvt 10x10: c0 en g, c1 (pozo) a tierra
V4 g g4 0
X4 g4 0 0 sky130_fd_pr__cap_var_lvt w=10 l=10
* MiM m3_1 10x10
V5 g g5 0
X5 g5 0 sky130_fd_pr__cap_mim_m3_1 w=10 l=10
.control
tran 1n 1.8u
let c1 = abs(i(V1))/1e6*1e15
let c2 = abs(i(V2))/1e6*1e15
let c3 = abs(i(V3))/1e6*1e15
let c4 = abs(i(V4))/1e6*1e15
let c5 = abs(i(V5))/1e6*1e15
foreach t 0.2u 0.3u 0.4u 0.48u 0.6u 0.9u 1.2u 1.5u 1.75u
  meas tran n1 find c1 at=$t
  meas tran n2 find c2 at=$t
  meas tran n3 find c3 at=$t
  meas tran n4 find c4 at=$t
  meas tran n5 find c5 at=$t
  echo RES CV t=$t fF_per_100um2 nfet=$&n1 nfet_lvt=$&n2 pfet_to_vdd=$&n3 var_lvt=$&n4 mim=$&n5
end
meas tran a1 avg c1 from=0.9u to=1.8u
meas tran a4 avg c4 from=0.9u to=1.8u
echo RES CVAVG_0.9_1.8 nfet=$&a1 var_lvt=$&a4
quit
.endc
.end
