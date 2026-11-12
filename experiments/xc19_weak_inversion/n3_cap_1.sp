* N3: kickback, filter capacitor 1 pF
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
Vctl ctl 0 pulse(0 1 100n 1n 1n 1 2)
Bpre pre 0 V = v(vdd)*v(ctl)
Xc0 vdd vdd c1 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc1 c1 c1 c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc2 c2 c2 vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc3 vb vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=16
Cf vb 0 1p
Xpa xa pre vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Xda xa vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xia xa 0 0 vdd vdd ya sky130_fd_sc_hd__inv_1
.control
tran 10n 200u
meas tran ta when v(ya)=0.9 rise=1
let vb0 = v(vb)[0]
meas tran vbmin min v(vb)
echo N3CAP 1 $&ta $&vb0 $&vbmin
quit
.endc
.end
