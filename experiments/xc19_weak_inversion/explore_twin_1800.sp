* exploratory twins, K = 4, VDD = 1.8
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
Vpre pre 0 pulse(0 1.8 100n 1n 1n 1 2)
Vmis vbm vb -17m
Xc0 vdd vdd c1 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc1 c1 c1 c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc2 c2 c2 vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc3 vb vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=16
Cf vb 0 1p
Xpa xa pre vdd vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Xda xa vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xia xa 0 0 vdd vdd ya sky130_fd_sc_hd__inv_1
Xpe xe pre vdd vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Xde xe vbm 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xie xe 0 0 vdd vdd ye sky130_fd_sc_hd__inv_1
Xpm xm pre vdd vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Xdm xm vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=16
Xim xm 0 0 vdd vdd ym sky130_fd_sc_hd__inv_1
.control
tran 10n 200u
meas tran ta when v(ya)=0.9 rise=1
meas tran te when v(ye)=0.9 rise=1
meas tran tm when v(ym)=0.9 rise=1
meas tran vbmin min v(vb)
meas tran vbmax max v(vb)
let vb0 = v(vb)[0]
echo EXPLORE 1.8 $&ta $&te $&tm $&vb0 $&vbmin $&vbmax
quit
.endc
.end
