* XC-19 slot · CALCULO DE DISENO (no experimento): que Cref ideal da dt/t = 0,80 % (un salto de una carga) con el interruptor
* pfet 0,42/0,15 de sw.sp. Mismo montaje que ../xc19_caps/sw.sp (canal post-layout xc19_channel_caps, inversores de libreria).
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include ../xc19_caps/caps_ga.inc
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
Vpre pre 0 pulse(0 1.8 100n 1n 1n 1 2)
Vhi hi 0 1.8
.subckt swp vdd pre g oa cr=1f
X1 vdd 0 vdd pre xa pre xb vb 0 0 vb xc19_channel_caps_ga
Xs xa g r vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Cr r 0 {cr}
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
.ends
XOFF vdd pre hi o_off swp cr=0.5f
XA vdd pre 0 o3 swp cr=0.3f
XB vdd pre 0 o4 swp cr=0.4f
XC vdd pre 0 o5 swp cr=0.5f
XD vdd pre 0 o6 swp cr=0.6f
XE vdd pre 0 o7 swp cr=0.7f
XZ vdd pre 0 o0 swp cr=1e-18
.control
tran 10n 40u
meas tran toff when v(o_off)=0.9 rise=1
meas tran t0 when v(o0)=0.9 rise=1
meas tran t3 when v(o3)=0.9 rise=1
meas tran t4 when v(o4)=0.9 rise=1
meas tran t5 when v(o5)=0.9 rise=1
meas tran t6 when v(o6)=0.9 rise=1
meas tran t7 when v(o7)=0.9 rise=1
let p3 = 100*(t3-toff)/toff
let p4 = 100*(t4-toff)/toff
let p5 = 100*(t5-toff)/toff
let p6 = 100*(t6-toff)/toff
let p7 = 100*(t7-toff)/toff
let p0 = 100*(t0-toff)/toff
echo RES CREF t_off=$&toff sw_only=$&p0 c03=$&p3 c04=$&p4 c05=$&p5 c06=$&p6 c07=$&p7
quit
.endc
.end
