* XC-19 slot · CALCULO DE DISENO 3 (no experimento): dispositivo de descarga de referencia para src=10/11.
* Nodo esquematico que imita el macro: DUT 0,42/0,15 con interruptor de fuente, referencia (W/L variable) con interruptor,
* tres interruptores pfet de referencia, condensador de nodo nfet 4,30 x 4,00, precarga pfet_hvt 0,42/0,50, inversor inv_1.
* VB sale del canal extraido (polarizacion real con su filtro). Esquina y temperatura: ver .lib/.temp.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ff
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include ../xc19_caps/caps_ga.inc
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp -40
.param u=0.6f
Vdd vdd 0 1.8
Vpn pren 0 pulse(0 1.8 100n 1n 1n 1 2)
XCH vdd 0 vdd pren xa0 pren xb0 vb 0 0 vb xc19_channel_caps_ga
.subckt node vdd pren vb g dut ref s0b s1b s2b o wr=1.68 lr=0.6
Xp x pren vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5 sa=0.3 sb=0.3
Xd x g sd 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3 sb=0.3
Xds sd dut 0 0 sky130_fd_pr__nfet_01v8 w=0.84 l=0.15
Xr x vb sr 0 sky130_fd_pr__nfet_01v8 w={wr} l={lr} sa=0.3 sb=0.3
Xrs sr ref 0 0 sky130_fd_pr__nfet_01v8 w=0.84 l=0.15
Xc 0 x 0 0 sky130_fd_pr__nfet_01v8 w=4.3 l=4
Xs0 x s0b r0 vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Xs1 x s1b r1 vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Xs2 x s2b r2 vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
C1 r1 0 {u}
C2 r2 0 {u}
Xi x 0 0 vdd vdd o sky130_fd_sc_hd__inv_1
.ends
Bt gt 0 V=v(vb)+0.305e-3
* src=01: DUT (y con trampa inyectada)
XD1 vdd pren vb vb vdd 0 vdd vdd vdd od1 node
XT1 vdd pren vb gt vdd 0 vdd vdd vdd ot1 node
* src=11 (1 u) y src=10 lado A (2 u), tres tamanos de referencia
XR11a vdd pren vb vb 0 vdd 0 0 vdd o11a node wr=1.68 lr=0.6
XR10a vdd pren vb vb 0 vdd vdd 0 0 o10a node wr=1.68 lr=0.6
XR11b vdd pren vb vb 0 vdd 0 0 vdd o11b node wr=0.84 lr=0.3
XR10b vdd pren vb vb 0 vdd vdd 0 0 o10b node wr=0.84 lr=0.3
XR11c vdd pren vb vb 0 vdd 0 0 vdd o11c node wr=1.26 lr=0.45
XR10c vdd pren vb vb 0 vdd vdd 0 0 o10c node wr=1.26 lr=0.45
* referencia con trampa inyectada en el DUT apagado (debe no moverse): DUT con puerta gt, DUT apagado
XR11t vdd pren vb gt 0 vdd 0 0 vdd o11t node wr=1.68 lr=0.6
* src=00: nada
X00 vdd pren vb vb 0 0 vdd vdd vdd o00 node
.control
tran 10n 200u
meas tran td1 when v(od1)=0.9 rise=1
meas tran tt1 when v(ot1)=0.9 rise=1
meas tran a11 when v(o11a)=0.9 rise=1
meas tran a10 when v(o10a)=0.9 rise=1
meas tran b11 when v(o11b)=0.9 rise=1
meas tran b10 when v(o10b)=0.9 rise=1
meas tran c11 when v(o11c)=0.9 rise=1
meas tran c10 when v(o10c)=0.9 rise=1
meas tran a11t when v(o11t)=0.9 rise=1
meas tran x00 find v(X00.x) at=199u
echo RES ff -40 t01=$&td1 t01trap=$&tt1 r168_11=$&a11 r168_10=$&a10 r084_11=$&b11 r084_10=$&b10 r126_11=$&c11 r126_10=$&c10 r168_11trapoff=$&a11t vx00_199us=$&x00
quit
.endc
.end
