* Calibracion por condensador de referencia conmutado en XA, estatico durante toda la conversion (escrito despues de ver
* que la inyeccion de carga depende del instante del flanco; exploratorio, no prerregistrado).
* Canal post-layout (xc19_channel_caps) + esquematico: interruptor y Cref ideal de 1,0 fF entre XA y el nodo r.
*   P: solo pfet_01v8 0,42/0,15 (pozo a VDD), puerta 0 = conectado, 1,8 V = desconectado.
*   T: puerta de transmision (nfet + pfet 0,42/0,15), CS = 1,8 V conectado.
* Prediccion escrita aqui antes de correr: T da dt/t = (1,0 fF + parasitas del interruptor ~0,2 fF) / ~137 fF = 0,8 a 0,95 %;
* P da menos si el pfet deja de conducir antes de que XA llegue a 0,9 V.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include caps_ga.inc
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
Vpre pre 0 pulse(0 1.8 100n 1n 1n 1 2)
Vhi hi 0 1.8
.subckt swp vdd pre g oa
X1 vdd 0 vdd pre xa pre xb vb 0 0 vb xc19_channel_caps_ga
Xs xa g r vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Cr r 0 1.0f
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
.ends
.subckt swt vdd pre cs csb oa
X1 vdd 0 vdd pre xa pre xb vb 0 0 vb xc19_channel_caps_ga
Xn xa cs r 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xp xa csb r vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Cr r 0 1.0f
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
.ends
.subckt none vdd pre oa
X1 vdd 0 vdd pre xa pre xb vb 0 0 vb xc19_channel_caps_ga
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
.ends
XN vdd pre on none
XP0 vdd pre hi op0 swp
XP1 vdd pre 0 op1 swp
XT0 vdd pre 0 hi ot0 swt
XT1 vdd pre hi 0 ot1 swt
.control
tran 10n 40u
meas tran tn when v(on)=0.9 rise=1
meas tran tp0 when v(op0)=0.9 rise=1
meas tran tp1 when v(op1)=0.9 rise=1
meas tran tt0 when v(ot0)=0.9 rise=1
meas tran tt1 when v(ot1)=0.9 rise=1
let dp = 100*(tp1-tp0)/tp0
let dt = 100*(tt1-tt0)/tt0
echo RES SW t_none=$&tn p_off=$&tp0 p_on=$&tp1 p_pct=$&dp tg_off=$&tt0 tg_on=$&tt1 tg_pct=$&dt
quit
.endc
.end
