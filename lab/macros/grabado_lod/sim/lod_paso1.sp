* Auditoria LOD paso 1 (docs/AUDITORIA_LOD_1111_BORRADOR.md): nfet_01v8, sa=sb barrido. tt, 27 C. Esquematico.
* Prediccion escrita antes (misma auditoria): W/L 0,42/0,15: sa=sb=0,30 -> +23,5 mV y -10 % movilidad; 3,0 -> -7,6 mV y +3,2 %,
* relativo a sa=sb=saref=1,04. Criterio: si sa=0 da lo mismo que sa=1,04, el modelo esta apagado por defecto.
* Las instancias *u prueban la unidad (sa en metros) porque .option scale=1u podria no aplicarse a sa/sb.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
Vg g 0 0.9
Vd d 0 0.05
Xa0   d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xa03  d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3  sb=0.3
Xa104 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=1.04 sb=1.04
Xa3   d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=3.0  sb=3.0
Xu03  d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3e-6  sb=0.3e-6
Xu104 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=1.04e-6 sb=1.04e-6
Xu3   d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=3.0e-6  sb=3.0e-6
Xw0   d g 0 0 sky130_fd_pr__nfet_01v8 w=5 l=0.15
Xw03  d g 0 0 sky130_fd_pr__nfet_01v8 w=5 l=0.15 sa=0.3  sb=0.3
Xw104 d g 0 0 sky130_fd_pr__nfet_01v8 w=5 l=0.15 sa=1.04 sb=1.04
Xw3   d g 0 0 sky130_fd_pr__nfet_01v8 w=5 l=0.15 sa=3.0  sb=3.0
.control
alter Vg dc = 0.9
alter Vd dc = 0.05
op
let vt = @m.xa0.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xa0.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xa0.msky130_fd_pr__nfet_01v8[ueff]
echo lin a0 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xa03.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xa03.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xa03.msky130_fd_pr__nfet_01v8[ueff]
echo lin a03 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xa104.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xa104.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xa104.msky130_fd_pr__nfet_01v8[ueff]
echo lin a104 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xa3.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xa3.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xa3.msky130_fd_pr__nfet_01v8[ueff]
echo lin a3 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xu03.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xu03.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xu03.msky130_fd_pr__nfet_01v8[ueff]
echo lin u03 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xu104.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xu104.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xu104.msky130_fd_pr__nfet_01v8[ueff]
echo lin u104 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xu3.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xu3.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xu3.msky130_fd_pr__nfet_01v8[ueff]
echo lin u3 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xw0.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xw0.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xw0.msky130_fd_pr__nfet_01v8[ueff]
echo lin w0 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xw03.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xw03.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xw03.msky130_fd_pr__nfet_01v8[ueff]
echo lin w03 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xw104.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xw104.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xw104.msky130_fd_pr__nfet_01v8[ueff]
echo lin w104 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xw3.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xw3.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xw3.msky130_fd_pr__nfet_01v8[ueff]
echo lin w3 vth= $&vt id= $&idd ueff= $&ue
alter Vg dc = 1.8
alter Vd dc = 1.8
op
let vt = @m.xa0.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xa0.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xa0.msky130_fd_pr__nfet_01v8[ueff]
echo sat a0 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xa03.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xa03.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xa03.msky130_fd_pr__nfet_01v8[ueff]
echo sat a03 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xa104.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xa104.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xa104.msky130_fd_pr__nfet_01v8[ueff]
echo sat a104 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xa3.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xa3.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xa3.msky130_fd_pr__nfet_01v8[ueff]
echo sat a3 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xu03.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xu03.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xu03.msky130_fd_pr__nfet_01v8[ueff]
echo sat u03 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xu104.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xu104.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xu104.msky130_fd_pr__nfet_01v8[ueff]
echo sat u104 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xu3.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xu3.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xu3.msky130_fd_pr__nfet_01v8[ueff]
echo sat u3 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xw0.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xw0.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xw0.msky130_fd_pr__nfet_01v8[ueff]
echo sat w0 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xw03.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xw03.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xw03.msky130_fd_pr__nfet_01v8[ueff]
echo sat w03 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xw104.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xw104.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xw104.msky130_fd_pr__nfet_01v8[ueff]
echo sat w104 vth= $&vt id= $&idd ueff= $&ue
let vt = @m.xw3.msky130_fd_pr__nfet_01v8[vth]
let idd = @m.xw3.msky130_fd_pr__nfet_01v8[id]
let ue = @m.xw3.msky130_fd_pr__nfet_01v8[ueff]
echo sat w3 vth= $&vt id= $&idd ueff= $&ue
quit
.endc
.end
