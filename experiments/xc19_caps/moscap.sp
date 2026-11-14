* Dimensionado del condensador de XA y efecto sobre el salto. Canal extraido y anotado, tres en serie, sin filtro en VB
* (como channel_sim.sp, el control). La puerta del DUT A va a VB a traves de una fuente de 0 o 0,305 mV (salto inyectado).
* Pares (sin salto, con salto): ideal 133 fF (control), nfet MOS cap de wc x lc (barrido), MiM m3_1 8 x 8 um.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include channel_ga.inc
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
.param wc=4 lc=4
Vdd vdd 0 1.8
Vctl ctl 0 pulse(0 1 100n 1n 1n 1 2)
Bpre pre 0 V = v(vdd)*v(ctl)
* ideal
XI0 vdd pre oi0 xa_i0 tbi dv=0
XI1 vdd pre oi1 xa_i1 tbi dv=0.305m
XM0 vdd pre om0 xa_m0 tbm dv=0
XM1 vdd pre om1 xa_m1 tbm dv=0.305m
XQ0 vdd pre oq0 xa_q0 tbq dv=0
XQ1 vdd pre oq1 xa_q1 tbq dv=0.305m
.subckt tbi vdd pre o xa dv=0
X1 vdd 0 vdd pre xa pre xb vb ga xc19_channel_lod_ga
Vs ga vb {dv}
Xi xa 0 0 vdd vdd o sky130_fd_sc_hd__inv_1
Cb xb 0 133f
Ca xa 0 133f
.ends
.subckt tbm vdd pre o xa dv=0
X1 vdd 0 vdd pre xa pre xb vb ga xc19_channel_lod_ga
Vs ga vb {dv}
Xi xa 0 0 vdd vdd o sky130_fd_sc_hd__inv_1
Cb xb 0 133f
Xc 0 xa 0 0 sky130_fd_pr__nfet_01v8 w={wc} l={lc}
.ends
.subckt tbq vdd pre o xa dv=0
X1 vdd 0 vdd pre xa pre xb vb ga xc19_channel_lod_ga
Vs ga vb {dv}
Xi xa 0 0 vdd vdd o sky130_fd_sc_hd__inv_1
Cb xb 0 133f
Xc xa 0 sky130_fd_pr__cap_mim_m3_1 w=8 l=8
.ends
.control
foreach w 4 4.3 4.5
  alterparam wc=$w
  reset
  tran 10n 40u
  meas tran ti0 when v(oi0)=0.9 rise=1
  meas tran ti1 when v(oi1)=0.9 rise=1
  meas tran tm0 when v(om0)=0.9 rise=1
  meas tran tm1 when v(om1)=0.9 rise=1
  meas tran tq0 when v(oq0)=0.9 rise=1
  meas tran tq1 when v(oq1)=0.9 rise=1
  let si = 100*(ti0-ti1)/ti0
  let sm = 100*(tm0-tm1)/tm0
  let sq = 100*(tq0-tq1)/tq0
  echo RES MOSCAP wc=$w lc=4 t_ideal=$&ti0 step_ideal_pct=$&si t_mos=$&tm0 step_mos_pct=$&sm t_mim8=$&tq0 step_mim_pct=$&sq
end
quit
.endc
.end
