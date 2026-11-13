* PHOTON: lectura digital "precarga y descarga a tiempo". ebufn_1 (A=1) precarga el catodo K a 1,8 V durante 1 us y pasa a Z;
* el nodo se descarga por fuga del driver + inv_1 + corriente inversa del fotodiodo (modelo ps2dn, area=9 um^2, pj=12 um) + Iph.
* Se mide el tiempo hasta que la salida del primer inv_1 cruza 0,9 V y el tiempo entre 1,6 V y 1,2 V en K (capacidad efectiva).
* gmin = 1e-18 para que el piso sea el de los modelos y no el del simulador. Iph barrida; 27 y 85 C; tt.
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.include /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.option gmin=1e-18
VDD vdd 0 1.8
VTE te 0 pwl(0 0 1u 0 1.001u 1.8)
Xeb vdd te 0 0 vdd vdd k sky130_fd_sc_hd__ebufn_1
Xi1 k 0 0 vdd vdd y1 sky130_fd_sc_hd__inv_1
Xi2 y1 0 0 vdd vdd y2 sky130_fd_sc_hd__inv_1
Dpd 0 k sky130_fd_pr__model__parasitic__diode_ps2dn area=9 pj=12
Iph k 0 dc 0
Btemp tn 0 V=temper
.control
set filetype=ascii
set temp = 27
alter Iph dc = 0
tran 0.5 2000 uic
meas tran t_cruce when v(y1)=0.9 rise=1
meas tran t16 when v(k)=1.6 fall=1
meas tran t12 when v(k)=1.2 fall=1
let vkfin = v(k)[length(v(k))-1]
echo "T= 27 Iph= 0 tstop= 2000  t_cruce(s)= $&t_cruce  t(1.6V)= $&t16  t(1.2V)= $&t12  v(k)final= $&vkfin"
alter Iph dc = 1e-13
tran 0.25 1000 uic
meas tran t_cruce when v(y1)=0.9 rise=1
meas tran t16 when v(k)=1.6 fall=1
meas tran t12 when v(k)=1.2 fall=1
let vkfin = v(k)[length(v(k))-1]
echo "T= 27 Iph= 1e-13 tstop= 1000  t_cruce(s)= $&t_cruce  t(1.6V)= $&t16  t(1.2V)= $&t12  v(k)final= $&vkfin"
alter Iph dc = 1e-12
tran 0.05 200 uic
meas tran t_cruce when v(y1)=0.9 rise=1
meas tran t16 when v(k)=1.6 fall=1
meas tran t12 when v(k)=1.2 fall=1
let vkfin = v(k)[length(v(k))-1]
echo "T= 27 Iph= 1e-12 tstop= 200  t_cruce(s)= $&t_cruce  t(1.6V)= $&t16  t(1.2V)= $&t12  v(k)final= $&vkfin"
alter Iph dc = 1e-11
tran 0.005 20 uic
meas tran t_cruce when v(y1)=0.9 rise=1
meas tran t16 when v(k)=1.6 fall=1
meas tran t12 when v(k)=1.2 fall=1
let vkfin = v(k)[length(v(k))-1]
echo "T= 27 Iph= 1e-11 tstop= 20  t_cruce(s)= $&t_cruce  t(1.6V)= $&t16  t(1.2V)= $&t12  v(k)final= $&vkfin"
alter Iph dc = 1e-10
tran 0.0005 2 uic
meas tran t_cruce when v(y1)=0.9 rise=1
meas tran t16 when v(k)=1.6 fall=1
meas tran t12 when v(k)=1.2 fall=1
let vkfin = v(k)[length(v(k))-1]
echo "T= 27 Iph= 1e-10 tstop= 2  t_cruce(s)= $&t_cruce  t(1.6V)= $&t16  t(1.2V)= $&t12  v(k)final= $&vkfin"
alter Iph dc = 1e-9
tran 5e-05 0.2 uic
meas tran t_cruce when v(y1)=0.9 rise=1
meas tran t16 when v(k)=1.6 fall=1
meas tran t12 when v(k)=1.2 fall=1
let vkfin = v(k)[length(v(k))-1]
echo "T= 27 Iph= 1e-9 tstop= 0.2  t_cruce(s)= $&t_cruce  t(1.6V)= $&t16  t(1.2V)= $&t12  v(k)final= $&vkfin"
set temp = 85
alter Iph dc = 0
tran 0.5 2000 uic
meas tran t_cruce when v(y1)=0.9 rise=1
meas tran t16 when v(k)=1.6 fall=1
meas tran t12 when v(k)=1.2 fall=1
let vkfin = v(k)[length(v(k))-1]
echo "T= 85 Iph= 0 tstop= 2000  t_cruce(s)= $&t_cruce  t(1.6V)= $&t16  t(1.2V)= $&t12  v(k)final= $&vkfin"
alter Iph dc = 1e-13
tran 0.25 1000 uic
meas tran t_cruce when v(y1)=0.9 rise=1
meas tran t16 when v(k)=1.6 fall=1
meas tran t12 when v(k)=1.2 fall=1
let vkfin = v(k)[length(v(k))-1]
echo "T= 85 Iph= 1e-13 tstop= 1000  t_cruce(s)= $&t_cruce  t(1.6V)= $&t16  t(1.2V)= $&t12  v(k)final= $&vkfin"
alter Iph dc = 1e-12
tran 0.05 200 uic
meas tran t_cruce when v(y1)=0.9 rise=1
meas tran t16 when v(k)=1.6 fall=1
meas tran t12 when v(k)=1.2 fall=1
let vkfin = v(k)[length(v(k))-1]
echo "T= 85 Iph= 1e-12 tstop= 200  t_cruce(s)= $&t_cruce  t(1.6V)= $&t16  t(1.2V)= $&t12  v(k)final= $&vkfin"
alter Iph dc = 1e-11
tran 0.005 20 uic
meas tran t_cruce when v(y1)=0.9 rise=1
meas tran t16 when v(k)=1.6 fall=1
meas tran t12 when v(k)=1.2 fall=1
let vkfin = v(k)[length(v(k))-1]
echo "T= 85 Iph= 1e-11 tstop= 20  t_cruce(s)= $&t_cruce  t(1.6V)= $&t16  t(1.2V)= $&t12  v(k)final= $&vkfin"
alter Iph dc = 1e-10
tran 0.0005 2 uic
meas tran t_cruce when v(y1)=0.9 rise=1
meas tran t16 when v(k)=1.6 fall=1
meas tran t12 when v(k)=1.2 fall=1
let vkfin = v(k)[length(v(k))-1]
echo "T= 85 Iph= 1e-10 tstop= 2  t_cruce(s)= $&t_cruce  t(1.6V)= $&t16  t(1.2V)= $&t12  v(k)final= $&vkfin"
alter Iph dc = 1e-9
tran 5e-05 0.2 uic
meas tran t_cruce when v(y1)=0.9 rise=1
meas tran t16 when v(k)=1.6 fall=1
meas tran t12 when v(k)=1.2 fall=1
let vkfin = v(k)[length(v(k))-1]
echo "T= 85 Iph= 1e-9 tstop= 0.2  t_cruce(s)= $&t_cruce  t(1.6V)= $&t16  t(1.2V)= $&t12  v(k)final= $&vkfin"
quit
.endc
.end
