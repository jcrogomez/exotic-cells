* RECORTE de auditoria: 0.16 ms, 4 conversiones
* N8a: shot noise of the discharge as a white current source on node X (density 2 q I, I = 81.4 pA average).
* Extracted readout cell, K = 4 bias with 10 pF. 48 conversions of 40 us (3 us precharge); 200 were planned, cut because the run takes about 11 minutes per millisecond. tt, 27 C.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include ../../cells/xc19_read/xc19_read.pex.spice
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
Vctl ctl 0 pulse(0 1 3u 1n 1n 37u 40u)
Bpre pre 0 V = v(vdd)*v(ctl)
Xc0 vdd vdd c1 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc1 c1 c1 c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc2 c2 c2 vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc3 vb vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=16
Cf vb 0 10p
Xa vb pre xa vdd 0 xc19_read
Xia xa 0 0 vdd vdd ya sky130_fd_sc_hd__inv_1
* rms = sqrt(q I / NT) with NT = 10 ns
Inoise xa 0 dc 0 trnoise(36.1p 10n 0 0)
.control
set rndseed=20261111
tran 10n 0.16m
meas tran t1 when v(ya)=0.9 rise=1
echo SHOT 1 $&t1
meas tran t2 when v(ya)=0.9 rise=2
echo SHOT 2 $&t2
meas tran t3 when v(ya)=0.9 rise=3
echo SHOT 3 $&t3
meas tran t4 when v(ya)=0.9 rise=4
echo SHOT 4 $&t4
quit
.endc
.end
