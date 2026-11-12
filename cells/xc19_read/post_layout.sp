* XC-19 readout cell, extracted with parasitics, in the complete stage. tt, 27 C, 1.8 V. Bias: V2 chain, K = 4, 10 pF.
* a/b: extracted cell, b with +0.305 mV on the gate. s: schematic stage for comparison.
* c/d: extracted cell with the stress geometry annotated by Residual (bias chain bottom devices annotated alike), d with the step.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include xc19_read.pex.spice
.include xc19_read_lod.inc
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
Vctl ctl 0 pulse(0 1 100n 1n 1n 1 2)
Bpre pre 0 V = v(vdd)*v(ctl)
* bias chain, default geometry
Xc0 vdd vdd c1 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc1 c1 c1 c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc2 c2 c2 vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc3 vb vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=16
Cf vb 0 10p
Vstep vbs vb 0.305m
* bias chain whose bottom devices carry the DUT's own diffusion geometry
Xe0 vdd vdd e1 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xe1 e1 e1 e2 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xe2 e2 e2 wb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xe3 wb wb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=16 sa=0.3 sb=0.3
Cg wb 0 10p
Vstep2 wbs wb 0.305m
Xa vb  pre xa vdd 0 xc19_read
Xb vbs pre xb vdd 0 xc19_read
Xc wb  pre xc vdd 0 xc19_read_lod
Xd wbs pre xd vdd 0 xc19_read_lod
* annotated cell on the default-geometry bias: what happens if the chain is drawn differently from the DUT
Xm vb  pre xm vdd 0 xc19_read_lod
Xps xs pre vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Xds xs vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xia xa 0 0 vdd vdd ya sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd yb sky130_fd_sc_hd__inv_1
Xic xc 0 0 vdd vdd yc sky130_fd_sc_hd__inv_1
Xid xd 0 0 vdd vdd yd sky130_fd_sc_hd__inv_1
Xim xm 0 0 vdd vdd ym sky130_fd_sc_hd__inv_1
Xis xs 0 0 vdd vdd ys sky130_fd_sc_hd__inv_1
.control
tran 10n 200u
meas tran ta when v(ya)=0.9 rise=1
meas tran tb when v(yb)=0.9 rise=1
meas tran tc when v(yc)=0.9 rise=1
meas tran td when v(yd)=0.9 rise=1
meas tran tm when v(ym)=0.9 rise=1
meas tran ts when v(ys)=0.9 rise=1
let vb0 = v(vb)[0]
let wb0 = v(wb)[0]
echo POST $&ta $&tb $&tc $&td $&tm $&ts $&vb0 $&wb0
quit
.endc
.end
