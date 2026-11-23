* XC-19 slot · CALCULO DE DISENO 3c (no experimento): referencia compuesta de nfet minimos 0,42/0,15 (sa=sb=0,30),
* 2 en serie x 4 o 6 en paralelo (8 o 12 veces el area del DUT). Resto como diseno_ref_*.sp.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include ../xc19_caps/caps_ga.inc
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp 27
.param u=0.6f
Vdd vdd 0 1.8
Vpn pren 0 pulse(0 1.8 100n 1n 1n 1 2)
XCH vdd 0 vdd pren xa0 pren xb0 vb 0 0 vb xc19_channel_caps_ga
Bt gt 0 V=v(vb)+0.305e-3
.subckt n2x4 vdd pren vb g dut ref s0b s1b s2b o
Xp x pren vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5 sa=0.3 sb=0.3
Xd x g sd 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3 sb=0.3
Xds sd dut 0 0 sky130_fd_pr__nfet_01v8 w=0.84 l=0.15
Xr0 x vb m1 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3 sb=0.3 m=4
Xr1 m1 vb sr 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3 sb=0.3 m=4
Xrs sr ref 0 0 sky130_fd_pr__nfet_01v8 w=0.84 l=0.15
Xc 0 x 0 0 sky130_fd_pr__nfet_01v8 w=4.3 l=4
Xs0 x s0b r0 vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Xs1 x s1b r1 vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Xs2 x s2b r2 vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
C1 r1 0 {u}
C2 r2 0 {u}
Xi x 0 0 vdd vdd o sky130_fd_sc_hd__inv_1
.ends
.subckt n2x6 vdd pren vb g dut ref s0b s1b s2b o
Xp x pren vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5 sa=0.3 sb=0.3
Xd x g sd 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3 sb=0.3
Xds sd dut 0 0 sky130_fd_pr__nfet_01v8 w=0.84 l=0.15
Xr0 x vb m1 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3 sb=0.3 m=6
Xr1 m1 vb sr 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3 sb=0.3 m=6
Xrs sr ref 0 0 sky130_fd_pr__nfet_01v8 w=0.84 l=0.15
Xc 0 x 0 0 sky130_fd_pr__nfet_01v8 w=4.3 l=4
Xs0 x s0b r0 vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Xs1 x s1b r1 vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Xs2 x s2b r2 vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
C1 r1 0 {u}
C2 r2 0 {u}
Xi x 0 0 vdd vdd o sky130_fd_sc_hd__inv_1
.ends
XD1 vdd pren vb vb vdd 0 vdd vdd vdd od1 n2x4
XT1 vdd pren vb gt vdd 0 vdd vdd vdd ot1 n2x4
XA11 vdd pren vb vb 0 vdd 0 0 vdd oa11 n2x4
XA10 vdd pren vb vb 0 vdd vdd 0 0 oa10 n2x4
XB11 vdd pren vb vb 0 vdd 0 0 vdd ob11 n2x6
XB10 vdd pren vb vb 0 vdd vdd 0 0 ob10 n2x6
XA11t vdd pren vb gt 0 vdd 0 0 vdd oa11t n2x4
.control
tran 10n 400u
meas tran td1 when v(od1)=0.9 rise=1
meas tran tt1 when v(ot1)=0.9 rise=1
meas tran a11 when v(oa11)=0.9 rise=1
meas tran a10 when v(oa10)=0.9 rise=1
meas tran b11 when v(ob11)=0.9 rise=1
meas tran b10 when v(ob10)=0.9 rise=1
meas tran a11t when v(oa11t)=0.9 rise=1
echo RES tt 27 t01=$&td1 t01trap=$&tt1 r2x4_11=$&a11 r2x4_10=$&a10 r2x6_11=$&b11 r2x6_10=$&b10 r2x4_11_trapdutoff=$&a11t
quit
.endc
.end
