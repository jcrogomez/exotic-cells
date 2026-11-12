* Exploratory: node A carries a 4x4 um nfet as capacitor (gate on X, source, drain and body grounded); node B keeps the ideal 133 fF.
* 133 fF ideal on each discharge node, library inverters. tt, 27 C. Run at 1.80 V and 1.81 V in the same deck.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include xc19_channel_lod.inc
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
Vdh vdh 0 1.81
Vctl ctl 0 pulse(0 1 100n 1n 1n 1 2)
Bpre pre 0 V = v(vdd)*v(ctl)
Bprh prh 0 V = v(vdh)*v(ctl)
X1 vdd 0 vdd pre xa pre xb xc19_channel_lod
X2 vdh 0 vdh prh ya prh yb xc19_channel_lod
Xca 0 xa 0 0 sky130_fd_pr__nfet_01v8 w=4 l=4
Cb xb 0 133f
Cc ya 0 133f
Cd yb 0 133f
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
Xic ya 0 0 vdh vdh pa sky130_fd_sc_hd__inv_1
Xid yb 0 0 vdh vdh pb sky130_fd_sc_hd__inv_1
.control
tran 10n 120u
meas tran ta when v(oa)=0.9 rise=1
meas tran tb when v(ob)=0.9 rise=1
meas tran ua when v(pa)=0.905 rise=1
meas tran ub when v(pb)=0.905 rise=1
echo MOSCAP $&ta $&tb $&ua $&ub
quit
.endc
.end
