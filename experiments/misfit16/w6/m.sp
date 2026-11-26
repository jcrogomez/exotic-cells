* MISFIT-16 W6: capacidad del pozo n dibujado (28,520 x 1,760 um -> 50,195 um2, 60,56 um) contra el sustrato, modelo ps2nw. tt 27
* Area en um2 como numero (leccion de MISFIT-15). Control: diodo de isla pd2nw 1,4 um2 debe dar 0,5-3 fF.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
V1 a 0 1.8
V2 b 0 0.9
V3 c 0 1.8
Dw18 0 a sky130_fd_pr__model__parasitic__diode_ps2nw area=50.195 pj=60.56
Dw09 0 b sky130_fd_pr__model__parasitic__diode_ps2nw area=50.195 pj=60.56
Dc 0 c sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
.control
set noaskquit
op
let cw18 = @dw18[cd]
let cw09 = @dw09[cd]
let cc = @dc[cd]
let iw18 = -i(V1)
echo W6 pozo_1.8V $&cw18 pozo_0.9V $&cw09 control_isla $&cc fuga_pozo_1.8V $&iw18
quit
.endc
.end
