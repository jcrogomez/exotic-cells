* PHOTON: capacidad y corriente inversa del fotodiodo segun el modelo del PDK sky130_fd_pr__model__parasitic__diode_ps2dn
* (libs.tech/ngspice/parasitics/sky130_fd_pr__model__parasitic__diode_ps2dn.model.spice; multiplicadores tt en corners/tt/nonfet.spice l.26-28).
* Magic extrae solo area=9 (um^2) para photo 3x3; aqui se simula con y sin perimetro pj=12 um para ver el peso del sidewall.
* gmin = 1e-18 (con el 1e-12 por defecto la corriente inversa es solo el gmin: 1,8 pA a 1,8 V).
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.option gmin=1e-18
VK k 0 dc 1.8 ac 1
Da 0 k sky130_fd_pr__model__parasitic__diode_ps2dn area=9
Dp 0 kp sky130_fd_pr__model__parasitic__diode_ps2dn area=9 pj=12
VKP kp k 0
Btemp tn 0 V=temper
.control
set filetype=ascii
set temp = 27
alter VK dc = 1.8
op
let ida = -i(VK)+i(VKP)
let idp = -i(VKP)
let tC = v(tn)
let vk = v(k)
echo "T= $&tC Vrev= $&vk  I_inv area9= $&ida A   I_inv area9+pj12= $&idp A"
ac lin 1 1e6 1e6
let ca = abs(imag(i(VK)-i(VKP)))/(2*pi*1e6)
let cp = abs(imag(i(VKP)))/(2*pi*1e6)
echo "T= 27 Vrev= 1.8  C area9= $&ca F   C area9+pj12= $&cp F"
alter VK dc = 0.9
op
let ida = -i(VK)+i(VKP)
let idp = -i(VKP)
let tC = v(tn)
let vk = v(k)
echo "T= $&tC Vrev= $&vk  I_inv area9= $&ida A   I_inv area9+pj12= $&idp A"
ac lin 1 1e6 1e6
let ca = abs(imag(i(VK)-i(VKP)))/(2*pi*1e6)
let cp = abs(imag(i(VKP)))/(2*pi*1e6)
echo "T= 27 Vrev= 0.9  C area9= $&ca F   C area9+pj12= $&cp F"
set temp = 85
alter VK dc = 1.8
op
let ida = -i(VK)+i(VKP)
let idp = -i(VKP)
let tC = v(tn)
let vk = v(k)
echo "T= $&tC Vrev= $&vk  I_inv area9= $&ida A   I_inv area9+pj12= $&idp A"
ac lin 1 1e6 1e6
let ca = abs(imag(i(VK)-i(VKP)))/(2*pi*1e6)
let cp = abs(imag(i(VKP)))/(2*pi*1e6)
echo "T= 85 Vrev= 1.8  C area9= $&ca F   C area9+pj12= $&cp F"
alter VK dc = 0.9
op
let ida = -i(VK)+i(VKP)
let idp = -i(VKP)
let tC = v(tn)
let vk = v(k)
echo "T= $&tC Vrev= $&vk  I_inv area9= $&ida A   I_inv area9+pj12= $&idp A"
ac lin 1 1e6 1e6
let ca = abs(imag(i(VK)-i(VKP)))/(2*pi*1e6)
let cp = abs(imag(i(VKP)))/(2*pi*1e6)
echo "T= 85 Vrev= 0.9  C area9= $&ca F   C area9+pj12= $&cp F"
quit
.endc
.end
