* Filtro de VB: barrido del condensador ideal. Canal extraido y anotado, tres en serie (C1 = VDD), 133 fF ideales en XA.
* Tres copias por valor de Cf:
*   X1: A y B sueltan a la vez (B con 133 fF): referencia sincrona.
*   X2: B quieto en precarga: A solo.
*   X3: B libre y desincronizado: 30 fF en XB, cruza antes que A, se reprecarga en 12 us y vuelve a soltar.
* Interaccion = t_A(X3) - t_A(X2). Retroceso = desviacion de VB de X3 respecto de X2.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include channel_vb.inc
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
.param cf=1p
Vdd vdd 0 1.8
Vctl ctl 0 pulse(0 1 100n 1n 1n 1 2)
Vct3 ct3 0 pwl(0 0 100n 0 101n 1 12u 1 12.001u 0 12.1u 0 12.101u 1)
Bpre pre 0 V = v(vdd)*v(ctl)
Bpr3 pr3 0 V = v(vdd)*v(ct3)
X1 vdd 0 vdd pre xa1 pre xb1 vb1 xc19_channel_lod_vb
X2 vdd 0 vdd pre xa2 0 xb2 vb2 xc19_channel_lod_vb
X3 vdd 0 vdd pre xa3 pr3 xb3 vb3 xc19_channel_lod_vb
Ca1 xa1 0 133f
Cb1 xb1 0 133f
Ca2 xa2 0 133f
Cb2 xb2 0 133f
Ca3 xa3 0 133f
Cb3 xb3 0 30f
Cf1 vb1 0 {cf}
Cf2 vb2 0 {cf}
Cf3 vb3 0 {cf}
Xi1 xa1 0 0 vdd vdd o1 sky130_fd_sc_hd__inv_1
Xi2 xa2 0 0 vdd vdd o2 sky130_fd_sc_hd__inv_1
Xi3 xa3 0 0 vdd vdd o3 sky130_fd_sc_hd__inv_1
Xj1 xb1 0 0 vdd vdd p1 sky130_fd_sc_hd__inv_1
Xj2 xb2 0 0 vdd vdd p2 sky130_fd_sc_hd__inv_1
Xj3 xb3 0 0 vdd vdd p3 sky130_fd_sc_hd__inv_1
.control
foreach c 1e-18 0.5e-12 1e-12 2e-12 3e-12 5e-12 10e-12
  alterparam cf=$c
  reset
  tran 5n 45u
  meas tran t1 when v(o1)=0.9 rise=1
  meas tran t2 when v(o2)=0.9 rise=1
  meas tran t3 when v(o3)=0.9 rise=1
  meas tran tb3 when v(p3)=0.9 rise=1
  let d32 = v(vb3)-v(vb2)
  let d12 = v(vb1)-v(vb2)
  meas tran dmin min d32 from=0.2u to=40u
  meas tran dmax max d32 from=0.2u to=40u
  meas tran smin min d12 from=0.2u to=40u
  meas tran v0 find v(vb2) at=90n
  echo RES FILT cf=$c tA_sync=$&t1 tA_alone=$&t2 tA_async=$&t3 tB_async=$&tb3 kick_async_min=$&dmin kick_async_max=$&dmax kick_sync_min=$&smin vb=$&v0
end
quit
.endc
.end
