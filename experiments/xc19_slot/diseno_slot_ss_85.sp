* XC-19 slot · CALCULO DE DISENO (no experimento), esquina ss, 85 C.
* (1) escalera de referencias: tres interruptores pfet 0,42/0,15 identicos en XA con 0, 1 y 2 unidades (u = 0,54 fF ideal);
*     se lee con todos abiertos y con cada uno cerrado. (2) carga de multiplexado: N interruptores abiertos con 1 u cada uno.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ss
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include ../xc19_caps/caps_ga.inc
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp 85
.param u=0.54f
Vdd vdd 0 1.8
Vpre pre 0 pulse(0 1.8 100n 1n 1n 1 2)
Vhi hi 0 1.8
.subckt lad vdd pre g0 g1 g2 oa
X1 vdd 0 vdd pre xa pre xb vb 0 0 vb xc19_channel_caps_ga
Xs0 xa g0 r0 vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Xs1 xa g1 r1 vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Xs2 xa g2 r2 vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Cr1 r1 0 {u}
Cr2 r2 0 {2*u}
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
.ends
.subckt mux vdd pre oa n=1
X1 vdd 0 vdd pre xa pre xb vb 0 0 vb xc19_channel_caps_ga
Xs xa vdd r vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15 m={n}
Cr r 0 {n*u}
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
.ends
.subckt bare vdd pre oa
X1 vdd 0 vdd pre xa pre xb vb 0 0 vb xc19_channel_caps_ga
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
.ends
.subckt trap vdd pre oa
X1 vdd 0 vdd pre xa pre xb vb 0 0 ga xc19_channel_caps_ga
Bg ga 0 V=v(vb)+0.305e-3
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
.ends
XT vdd pre otr trap
XB vdd pre ob0 bare
XL vdd pre hi hi hi ol lad
XL0 vdd pre 0 hi hi ol0 lad
XL1 vdd pre hi 0 hi ol1 lad
XL2 vdd pre hi hi 0 ol2 lad
XM1 vdd pre om1 mux n=1
XM4 vdd pre om4 mux n=4
XM8 vdd pre om8 mux n=8
XM16 vdd pre om16 mux n=16
XM32 vdd pre om32 mux n=32
.control
tran 10n 120u
meas tran ttr when v(otr)=0.9 rise=1
meas tran tb when v(ob0)=0.9 rise=1
meas tran tl when v(ol)=0.9 rise=1
meas tran tl0 when v(ol0)=0.9 rise=1
meas tran tl1 when v(ol1)=0.9 rise=1
meas tran tl2 when v(ol2)=0.9 rise=1
meas tran tm1 when v(om1)=0.9 rise=1
meas tran tm4 when v(om4)=0.9 rise=1
meas tran tm8 when v(om8)=0.9 rise=1
meas tran tm16 when v(om16)=0.9 rise=1
meas tran tm32 when v(om32)=0.9 rise=1
echo RES ss 85 t_trap=$&ttr t_bare=$&tb lad_off=$&tl s0=$&tl0 s1=$&tl1 s2=$&tl2 m1=$&tm1 m4=$&tm4 m8=$&tm8 m16=$&tm16 m32=$&tm32
quit
.endc
.end
