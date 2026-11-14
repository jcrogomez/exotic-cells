* Interaccion en la celda dibujada (filtro de 10,17 pF y blindaje entre XA y XB, extraidos): B se reprecarga a mitad de
* la conversion de A (PREB baja 100 ns a los 12 us). Control: B quieto en precarga. tt, 27 C, tres en serie.
* Prediccion (de filt.sp, filtro ideal de 10 pF: 0,0034 %, mas el acoplo XA-XB de 0,023 fF extraido): menos de 0,01 %.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include caps_ga.inc
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
Vpre pre 0 pulse(0 1.8 100n 1n 1n 1 2)
Vpb pb 0 pwl(0 0 100n 0 101n 1.8 12u 1.8 12.001u 0 12.1u 0 12.101u 1.8)
X1 vdd 0 vdd pre xa1 0 xb1 vb1 0 0 vb1 xc19_channel_caps_ga
X2 vdd 0 vdd pre xa2 pb xb2 vb2 0 0 vb2 xc19_channel_caps_ga
Xi1 xa1 0 0 vdd vdd o1 sky130_fd_sc_hd__inv_1
Xi2 xa2 0 0 vdd vdd o2 sky130_fd_sc_hd__inv_1
Xj1 xb1 0 0 vdd vdd p1 sky130_fd_sc_hd__inv_1
Xj2 xb2 0 0 vdd vdd p2 sky130_fd_sc_hd__inv_1
.control
tran 10n 40u
meas tran t1 when v(o1)=0.9 rise=1
meas tran t2 when v(o2)=0.9 rise=1
let d = v(vb2)-v(vb1)
meas tran dmax max d from=11u to=40u
meas tran dmin min d from=11u to=40u
let pct = 100*(t2-t1)/t1
echo RES ASYNC tA_Bquiet=$&t1 tA_Bprecharged_at_12us=$&t2 change_pct=$&pct vb_kick_max=$&dmax vb_kick_min=$&dmin
quit
.endc
.end
