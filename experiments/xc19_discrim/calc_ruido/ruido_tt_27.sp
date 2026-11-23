* XC-19 discriminacion · CALCULO PREVIO AL PRERREGISTRO (no experimento): ruido de drenaje del DUT (nfet 0,42/0,15,
* sa=sb=0,30) referido a la puerta (inoise), con VG = VB de la cadena esquematica (2 diodos 1/1 + espejo de 16: C1 a VDD, como el canal)
* y VDS = 1,35 V (mitad de la excursion 1,8 -> 0,9 V). Corriente de drenaje leida por una fuente controlada sin ruido.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.options gmin=1e-15 abstol=1e-15 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
* C1 a VDD: la cadena es VDD - d - d - VB - espejo, 3 elementos en serie (como el canal en la etapa a)
X2 vdd vdd c3 0 sky130_fd_pr__nfet_01v8 w=1 l=1
X3 c3 c3 vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xm vb vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3 sb=0.3 m=16
Eg g 0 vb 0 1
Vin gin g dc 0 ac 1
Vd d 0 1.35
Xd d gin 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3 sb=0.3
Hs dn 0 Vd 1
.control
op
print v(vb)
echo RES tt 27 vb=$&v(vb) id=$&i(vd)
noise v(dn) Vin dec 5 0.01 1e6
setplot noise1
let f = frequency
let s = inoise_spectrum
print f s > ruido_tt_27.dat
quit
.endc
.end
