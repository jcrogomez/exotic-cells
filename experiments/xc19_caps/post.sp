* Post-layout: canal con condensadores dibujados (xc19_channel_caps, extraido y anotado), tres en serie, CALA = CALB = 0 fijos.
* Control: canal sin condensadores (xc19_channel_lod) con 133 fF ideales y sin filtro, como channel_sim.sp.
* Salto: 0,305 mV en la puerta del DUT A (fuente entre VB y GA). tt, 27 C, 1,80 y 1,81 V en el mismo deck.
* abstol = 1e-15 (no 1e-18 como channel_sim.sp): con 1e-18 la rama de la fuente del salto no converge en el primer paso. El control
* (canal viejo con 133 fF ideales) corre en este mismo deck con la misma tolerancia.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include ../../cells/xc19_channel/xc19_channel_lod.inc
.include caps_ga.inc
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
Vdh vdh 0 1.81
* precarga: mismo flanco que channel_sim.sp (0 hasta 100 ns, luego VDD en 1 ns), escrito como pulso para evitar las
* fuentes de comportamiento, que no convergian en el punto inicial con esta celda
Vpre pre 0 pulse(0 1.8 100n 1n 1n 1 2)
Vprh prh 0 pulse(0 1.81 100n 1n 1n 1 2)
.subckt newch vdd pre oa ob dv=0
X1 vdd 0 vdd pre xa pre xb vb 0 0 ga xc19_channel_caps_ga
Vs ga vb {dv}
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
.ends
.subckt oldch vdd pre oa ob
X1 vdd 0 vdd pre xa pre xb xc19_channel_lod
Ca xa 0 133f
Cb xb 0 133f
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
.ends
XN0 vdd pre na0 nb0 newch dv=0
XN1 vdd pre na1 nb1 newch dv=0.305m
XN2 vdh prh na2 nb2 newch dv=0
XO0 vdd pre oa0 ob0 oldch
XO2 vdh prh oa2 ob2 oldch
.control
tran 10n 40u
meas tran tna0 when v(na0)=0.9 rise=1
meas tran tnb0 when v(nb0)=0.9 rise=1
meas tran tna1 when v(na1)=0.9 rise=1
meas tran tna2 when v(na2)=0.905 rise=1
meas tran tnb2 when v(nb2)=0.905 rise=1
meas tran toa0 when v(oa0)=0.9 rise=1
meas tran tob0 when v(ob0)=0.9 rise=1
meas tran toa2 when v(oa2)=0.905 rise=1
meas tran tob2 when v(ob2)=0.905 rise=1
meas tran vb0 find v(xn0.vb) at=90n
echo RES POST new_tA=$&tna0 new_tB=$&tnb0 new_tA_step=$&tna1 new_tA_1v81=$&tna2 new_tB_1v81=$&tnb2 vb=$&vb0
echo RES POST old_ideal_tA=$&toa0 old_ideal_tB=$&tob0 old_tA_1v81=$&toa2 old_tB_1v81=$&tob2
quit
.endc
.end
