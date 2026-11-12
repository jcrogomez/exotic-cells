* One complete XC-19 channel from layout: extracted bias cell + extracted readout cell, both annotated by Residual,
* plus a library inverter and an ideal capacitor on X. tt, 27 C, 1.8 V.
* k4: four in series (C1 left alone), no added capacitor.  k3: three in series (C1 tied to VDD), 133 fF added.
* Each with a second readout cell whose gate is 0.305 mV higher (emulated single-charge step).
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include xc19_bias_lod.inc
.include ../xc19_read/xc19_read_lod.inc
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
Vctl ctl 0 pulse(0 1 100n 1n 1n 1 2)
Bpre pre 0 V = v(vdd)*v(ctl)
Xb4 vb4 0 vdd c14 c24 xc19_bias_lod
Xb3 vb3 0 vdd vdd c23 xc19_bias_lod
Cf4 vb4 0 10p
Cf3 vb3 0 10p
V4 vb4s vb4 0.305m
V3 vb3s vb3 0.305m
Xa vb4  pre xa vdd 0 xc19_read_lod
Xb vb4s pre xb vdd 0 xc19_read_lod
Xc vb3  pre xc vdd 0 xc19_read_lod
Xd vb3s pre xd vdd 0 xc19_read_lod
Cc xc 0 133f
Cd xd 0 133f
Xia xa 0 0 vdd vdd ya sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd yb sky130_fd_sc_hd__inv_1
Xic xc 0 0 vdd vdd yc sky130_fd_sc_hd__inv_1
Xid xd 0 0 vdd vdd yd sky130_fd_sc_hd__inv_1
.control
tran 10n 200u
meas tran ta when v(ya)=0.9 rise=1
meas tran tb when v(yb)=0.9 rise=1
meas tran tc when v(yc)=0.9 rise=1
meas tran td when v(yd)=0.9 rise=1
let v4 = v(vb4)[0]
let v3 = v(vb3)[0]
echo CHANNEL $&ta $&tb $&tc $&td $&v4 $&v3
quit
.endc
.end
