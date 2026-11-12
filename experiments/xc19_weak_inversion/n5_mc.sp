* N5: mismatch Monte Carlo, DUT against an identical twin, VDD and VDD + 10 mV on the same draw
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt_mm
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
Cf vb 0 30p
Xpa xa pre vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Xda xa vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xia xa 0 0 vdd vdd ya sky130_fd_sc_hd__inv_1
Xpe xe pre vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Xde xe vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xie xe 0 0 vdd vdd ye sky130_fd_sc_hd__inv_1
.control
set rndseed=20261111
let i = 0
while i < 100
  reset
  alter Vdd dc = 1.8
  tran 20n 400u
  meas tran ta when v(ya)=0.9 rise=1
  meas tran te when v(ye)=0.9 rise=1
  alter Vdd dc = 1.81
  tran 20n 400u
  meas tran ua when v(ya)=0.905 rise=1
  meas tran ue when v(ye)=0.905 rise=1
  echo N5 $&i $&ta $&te $&ua $&ue
  let i = i + 1
end
quit
.endc
.end
