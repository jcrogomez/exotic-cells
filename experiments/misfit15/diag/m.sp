* MISFIT-15 diagnostico: que area usa ngspice para el diodo del PDK
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.options gmin=1e-18 abstol=1e-18
.temp 30
V1 a 0 1.8
V2 b 0 1.8
V3 c 0 1.8
Xd1 0 a sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
D2 0 b sky130_fd_pr__diode_pw2nd_05v5 area=1.4e12 pj=4.8e6
D3 0 c sky130_fd_pr__diode_pw2nd_05v5 area=1.4 pj=4.8
.control
set noaskquit
op
print -i(V1) -i(V2) -i(V3)
print @d.xd1.d0[area] @d2[area] @d3[area] @d.xd1.d0[pj] @d3[pj]
print @d.xd1.d0[cd] @d2[cd] @d3[cd]
show d2
show d3
option
quit
.endc
.end
