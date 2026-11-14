* Calibracion por inyeccion de carga: la linea CALA (placa de metal 1 bajo la placa de metal 2 de XA, Cc extraida 0,595 fF)
* conmuta 1,8 V durante la descarga. CALA la da un inv_1 de biblioteca. Canal post-layout, tres en serie, tt, 27 C.
* S0: CALA fija en 0. S1: fija en 1,8 V. R*: sube a los 2, 10 y 20 us de soltar. F*: baja en esos instantes.
* Control de diafonia: tB en cada caso.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include caps_ga.inc
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
Vctl ctl 0 pulse(0 1 100n 1n 1n 1 2)
Bpre pre 0 V = v(vdd)*v(ctl)
* inverter inputs: high = CALA low
Vhi hi 0 1.8
Vlo lo 0 0
Vr2 r2 0 pwl(0 1.8 2.1u 1.8 2.101u 0)
Vr10 r10 0 pwl(0 1.8 10.1u 1.8 10.101u 0)
Vr20 r20 0 pwl(0 1.8 20.1u 1.8 20.101u 0)
Vf2 f2 0 pwl(0 0 2.1u 0 2.101u 1.8)
Vf10 f10 0 pwl(0 0 10.1u 0 10.101u 1.8)
Vf20 f20 0 pwl(0 0 20.1u 0 20.101u 1.8)
.subckt calch vdd pre in oa ob
X1 vdd 0 vdd pre xa pre xb vb cala 0 vb xc19_channel_caps_ga
Xd in 0 0 vdd vdd cala sky130_fd_sc_hd__inv_1
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
.ends
XS0 vdd pre hi as0 bs0 calch
XS1 vdd pre lo as1 bs1 calch
XR2 vdd pre r2 ar2 br2 calch
XR10 vdd pre r10 ar10 br10 calch
XR20 vdd pre r20 ar20 br20 calch
XF2 vdd pre f2 af2 bf2 calch
XF10 vdd pre f10 af10 bf10 calch
XF20 vdd pre f20 af20 bf20 calch
.control
tran 10n 40u
foreach c s0 s1 r2 r10 r20 f2 f10 f20
  meas tran ta when v(a$c)=0.9 rise=1
  meas tran tb when v(b$c)=0.9 rise=1
  echo RES CAL case=$c tA=$&ta tB=$&tb
end
quit
.endc
.end
