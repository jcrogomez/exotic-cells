* Las dos calibraciones frente a la corriente del DUT: puerta del DUT A desplazada -20, 0 y +20 mV respecto de VB.
* (a) condensador conmutado (pfet 0,42/0,15 + Cref 1,0 fF), estatico: dt/t deberia no depender de la corriente.
* (b) inyeccion por CALA (Cc extraida 0,595 fF), flanco de subida a 10 us de soltar: dt deberia escalar como 1/I.
* (c) salto de 0,305 mV en la puerta: referencia de lo que se quiere emular.
* Exploratorio, escrito despues de sw.sp; prediccion: (a) igual dentro de 2 % relativo en los tres puntos; (b) dt*... ~ 1/I.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include caps_ga.inc
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp 27
.param off=0
Vdd vdd 0 1.8
Vpre pre 0 pulse(0 1.8 100n 1n 1n 1 2)
Vhi hi 0 1.8
Vr10 r10 0 pwl(0 1.8 10.1u 1.8 10.101u 0)
.subckt cell vdd pre g calin oa dv=0
X1 vdd 0 vdd pre xa pre xb vb cala 0 ga xc19_channel_caps_ga
Vs ga vb {dv}
Xs xa g r vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Cr r 0 1.0f
Xd calin 0 0 vdd vdd cala sky130_fd_sc_hd__inv_1
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
.ends
* reference: switch off, CALA static
XA0 vdd pre hi hi a0 cell dv={off}
* switch on
XA1 vdd pre 0 hi a1 cell dv={off}
* injection at 10 us, switch off
XA2 vdd pre hi r10 a2 cell dv={off}
* gate step
XA3 vdd pre hi hi a3 cell dv={off+0.305m}
.control
foreach o -20m 0 20m
  alterparam off=$o
  reset
  tran 10n 80u
  meas tran t0 when v(a0)=0.9 rise=1
  meas tran t1 when v(a1)=0.9 rise=1
  meas tran t2 when v(a2)=0.9 rise=1
  meas tran t3 when v(a3)=0.9 rise=1
  let sw = 100*(t1-t0)/t0
  let inj = 1e9*(t2-t0)
  let injp = 100*(t2-t0)/t0
  let stp = 100*(t0-t3)/t0
  echo RES SWI offset=$o t0=$&t0 sw_pct=$&sw inj_ns=$&inj inj_pct=$&injp step_pct=$&stp
end
quit
.endc
.end
