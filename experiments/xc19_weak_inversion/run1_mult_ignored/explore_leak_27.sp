* precharge alternatives, 27 C
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
Vx x 0 0.9
Vpfet_L015 xpfet_L015 0 0.9
Xpfet_L015 xpfet_L015 vdd vdd vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Vpfet_L050 xpfet_L050 0 0.9
Xpfet_L050 xpfet_L050 vdd vdd vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.5
Vhvt_L015 xhvt_L015 0 0.9
Xhvt_L015 xhvt_L015 vdd vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.15
Vhvt_L050 xhvt_L050 0 0.9
Xhvt_L050 xhvt_L050 vdd vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
.control
op
let il = i(Vpfet_L015)
echo XLEAK 27 pfet_L015 $&il
let il = i(Vpfet_L050)
echo XLEAK 27 pfet_L050 $&il
let il = i(Vhvt_L015)
echo XLEAK 27 hvt_L015 $&il
let il = i(Vhvt_L050)
echo XLEAK 27 hvt_L050 $&il
quit
.endc
.end
