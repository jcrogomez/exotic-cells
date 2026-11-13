* Auditoria LOD paso 4: desajuste (tt_mm) de nfet_01v8 0,42/0,15 y 5/0,15, 300 sorteos. Vth en Vgs=0,9 Vds=0,05, 27 C.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt_mm
.temp 27
Vg g 0 0.9
Vd d 0 0.05
Xa d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xw d g 0 0 sky130_fd_pr__nfet_01v8 w=5 l=0.15
.control
let n = 300
let i = 0
while i < n
  reset
  op
  let va = @m.xa.msky130_fd_pr__nfet_01v8[vth]
  let vw = @m.xw.msky130_fd_pr__nfet_01v8[vth]
  echo MM $&va $&vw
  let i = i + 1
end
quit
.endc
.end
