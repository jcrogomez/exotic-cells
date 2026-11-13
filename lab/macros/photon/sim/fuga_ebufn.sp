* PHOTON: fuga del driver de precarga sky130_fd_sc_hd__ebufn_1 en Z (TE_B = 1) con la salida mantenida a 0,9 V y 1,8 V,
* para A = 0 y A = 1, a 27 y 85 C, esquina tt. Tambien: umbral del inv_1 (Vin = Vout) y corriente de entrada del inv_1.
* Convenio: ifuga = -i(VZ) > 0 = corriente que el nodo entrega al driver (descarga el nodo).
* GMIN: ngspice pone por defecto gmin = 1e-12 S en cada union -> 1,8 pA ficticios a 1,8 V, del orden de lo que se mide.
* Por eso se corre con gmin = 1e-18 (fila "gmin18") y con el valor por defecto (fila "gmin12") para ver el artefacto.
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.include /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
VDD vdd 0 1.8
VA  a   0 1.8
VTE te  0 1.8
VZ  z   0 1.8
Xeb a te 0 0 vdd vdd z sky130_fd_sc_hd__ebufn_1
VIN vin 0 1.8
Xinv vin 0 0 vdd vdd y sky130_fd_sc_hd__inv_1
Btemp tn 0 V=temper
.control
set filetype=ascii
option gmin=1e-18
set temp = 27
alter VA dc = 0
alter VZ dc = 0.9
alter VIN dc = 0.9
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin18 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
alter VA dc = 0
alter VZ dc = 1.8
alter VIN dc = 1.8
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin18 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
alter VA dc = 1.8
alter VZ dc = 0.9
alter VIN dc = 0.9
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin18 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
alter VA dc = 1.8
alter VZ dc = 1.8
alter VIN dc = 1.8
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin18 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
dc VIN 0 1.8 0.001
meas dc vth_inv1 find v(vin) when v(y)=v(vin)
set temp = 85
alter VA dc = 0
alter VZ dc = 0.9
alter VIN dc = 0.9
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin18 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
alter VA dc = 0
alter VZ dc = 1.8
alter VIN dc = 1.8
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin18 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
alter VA dc = 1.8
alter VZ dc = 0.9
alter VIN dc = 0.9
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin18 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
alter VA dc = 1.8
alter VZ dc = 1.8
alter VIN dc = 1.8
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin18 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
dc VIN 0 1.8 0.001
meas dc vth_inv1 find v(vin) when v(y)=v(vin)
option gmin=1e-12
set temp = 27
alter VA dc = 0
alter VZ dc = 0.9
alter VIN dc = 0.9
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin12 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
alter VA dc = 0
alter VZ dc = 1.8
alter VIN dc = 1.8
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin12 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
alter VA dc = 1.8
alter VZ dc = 0.9
alter VIN dc = 0.9
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin12 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
alter VA dc = 1.8
alter VZ dc = 1.8
alter VIN dc = 1.8
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin12 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
dc VIN 0 1.8 0.001
meas dc vth_inv1 find v(vin) when v(y)=v(vin)
set temp = 85
alter VA dc = 0
alter VZ dc = 0.9
alter VIN dc = 0.9
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin12 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
alter VA dc = 0
alter VZ dc = 1.8
alter VIN dc = 1.8
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin12 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
alter VA dc = 1.8
alter VZ dc = 0.9
alter VIN dc = 0.9
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin12 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
alter VA dc = 1.8
alter VZ dc = 1.8
alter VIN dc = 1.8
op
let ifuga = -i(VZ)
let iinv = -i(VIN)
let tC = v(tn)
let va = v(a)
let vz = v(z)
echo "gmin12 T= $&tC A= $&va Vz= $&vz  I_fuga_ebufn_Z= $&ifuga A  I_entrada_inv1= $&iinv A"
dc VIN 0 1.8 0.001
meas dc vth_inv1 find v(vin) when v(y)=v(vin)
quit
.endc
.end
