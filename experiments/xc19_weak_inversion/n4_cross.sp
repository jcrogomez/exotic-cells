* N4: the LOD audit transistors, annotated, read by the XC-19 stage
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
Cf vb 0 30p
.include ../lod_audit/sim/lod_annotated.inc
.include ../lod_audit/lod_sa030.spice
.include ../lod_audit/lod_sa300.spice
Xps xs pre vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Xds 0 xs vb 0 lod_sa030_lod
Xis xs 0 0 vdd vdd ys sky130_fd_sc_hd__inv_1
Xpl xl pre vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Xdl 0 xl vb 0 lod_sa300_lod
Xil xl 0 0 vdd vdd yl sky130_fd_sc_hd__inv_1
Xpp xp pre vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Xdp 0 xp vb 0 lod_sa030
Xip xp 0 0 vdd vdd yp sky130_fd_sc_hd__inv_1
Xpq xq pre vdd vdd sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
Xdq 0 xq vb 0 lod_sa300
Xiq xq 0 0 vdd vdd yq sky130_fd_sc_hd__inv_1
.control
tran 10n 400u
meas tran ts when v(ys)=0.9 rise=1
meas tran tl when v(yl)=0.9 rise=1
meas tran tp when v(yp)=0.9 rise=1
meas tran tq when v(yq)=0.9 rise=1
echo N4 $&ts $&tl $&tp $&tq
quit
.endc
.end
