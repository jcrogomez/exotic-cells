* Capacidad efectiva del filtro dibujado en VB y resistencia de salida de la cadena: corriente AC de 1 A en VB sobre la
* celda extraida (canal en precarga, XA y XB altos). C = 1/(2 pi f |Z|) donde 1/(wC) << R. tt, 27 C.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include ../../cells/xc19_channel_caps/xc19_channel_caps_lod.inc
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
X1 vdd 0 vdd 0 xa 0 xb vb 0 0 xc19_channel_caps_lod
Iac 0 vb dc 0 ac 1
.control
op
let vbdc = v(vb)
echo RES VBDC $&vbdc
ac dec 10 1 100meg
let zm = mag(v(vb))
meas ac z10 find zm at=10
meas ac z1m find zm at=1e6
meas ac z10m find zm at=1e7
let c1m = 1/(2*3.14159265*1e6*z1m)
let c10m = 1/(2*3.14159265*1e7*z10m)
echo RES VBAC R_lowf=$&z10 C_at_1MHz=$&c1m C_at_10MHz=$&c10m
quit
.endc
.end
