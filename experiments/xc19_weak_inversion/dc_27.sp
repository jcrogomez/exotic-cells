* XC-19 budget, DC part. nfet_01v8 0.42/0.15, tt, 27 C. See cells/preregistros/XC-19_2026-11-11_etapa_inversion_debil.md
* A: reference. B: gate +0.305 mV (emulated single-charge step). C: gate -17 mV (one sigma of mismatch). D: drain +10 mV. W: 4.2/1.5 twin.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
Vg g 0 0
Vb gb g 0.305m
Vc gc g -17m
Vda da 0 0.9
Vdb db 0 0.9
Vdc dc 0 0.9
Vdd dd 0 0.91
Vdw dw 0 0.9
Xa da g  0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xb db gb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xc dc gc 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xd dd g  0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xw dw g  0 0 sky130_fd_pr__nfet_01v8 w=4.2 l=1.5
.options gmin=1e-18 abstol=1e-18 reltol=1e-6
.control
dc Vg 0 0.9 0.05
let ia = -i(Vda)
let ib = -i(Vdb)
let ic = -i(Vdc)
let id = -i(Vdd)
let iw = -i(Vdw)
wrdata dc_27.dat ia ib ic id iw
quit
.endc
.end
