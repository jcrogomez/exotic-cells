* precharge pfet off-state current, 85 C
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 85
Vdd vdd 0 1.8
Vx x 0 0.9
Xp x vdd vdd vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
.control
op
let il = i(Vx)
echo LEAK 85 $&il
quit
.endc
.end
