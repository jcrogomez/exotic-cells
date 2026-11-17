* Supply transfer, case q: Rs = 1.85 ohm, load dc 0, C(B) = 133 fF. Extracted XC-19 channel, tt, 27 C.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include ../../cells/xc19_channel/xc19_channel_lod.inc
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
Vs vs 0 1.8
Rs vs vdd 1.85
Iload vdd 0 dc 0
Vctl ctl 0 pulse(0 1 100n 1n 1n 1 2)
Bpre pre 0 V = v(vdd)*v(ctl)
X1 vdd 0 vdd pre xa pre xb xc19_channel_lod
Ca xa 0 133f
Cb xb 0 133f
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
.control
tran 10n 130u 0 10n
meas tran ta when v(oa)=0.9 rise=1
meas tran tb when v(ob)=0.9 rise=1
meas tran vmin min v(vdd) from=1u to=100u
echo STRANS q $&ta $&tb $&vmin
quit
.endc
.end
