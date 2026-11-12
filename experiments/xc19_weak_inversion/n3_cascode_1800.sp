* N3: cascode, VDD = 1.8
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
Vstep vbs vb 0.305m
Vctl ctl 0 pulse(0 1 100n 1n 1n 1 2)
Bpre pre 0 V = v(vdd)*v(ctl)
Xc0 vdd vdd c1 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc1 c1 c1 c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc2 c2 c2 vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc3 vb vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=16
Cf vb 0 1p
Cc c2 0 1p
Xpa xa pre vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Xda ma vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xia xa 0 0 vdd vdd ya sky130_fd_sc_hd__inv_1
Xka xa c2 ma 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xpb xb pre vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Xdb mb vbs 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xib xb 0 0 vdd vdd yb sky130_fd_sc_hd__inv_1
Xkb xb c2 mb 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xpw xw pre vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Xdw mw vb 0 0 sky130_fd_pr__nfet_01v8 w=4.2 l=1.5
Xiw xw 0 0 vdd vdd yw sky130_fd_sc_hd__inv_1
Xkw xw c2 mw 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
.control
tran 10n 300u
meas tran ta when v(ya)=0.9 rise=1
meas tran tb when v(yb)=0.9 rise=1
meas tran tw when v(yw)=0.9 rise=1
let vb0 = v(vb)[0]
meas tran vbmin min v(vb)
meas tran vbmax max v(vb)
let c20 = v(c2)[0]
meas tran c2min min v(c2)
meas tran mamax max v(ma) from=1u to=20u
echo N3CAS 1.8 $&ta $&tb $&tw $&vb0 $&vbmin $&vbmax $&c20 $&c2min $&mamax
quit
.endc
.end
