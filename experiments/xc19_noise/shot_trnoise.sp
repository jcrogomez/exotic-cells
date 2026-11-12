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
tran 10n 1.92m
meas tran t1 when v(ya)=0.9 rise=1
echo SHOT 1 $&t1
meas tran t2 when v(ya)=0.9 rise=2
echo SHOT 2 $&t2
meas tran t3 when v(ya)=0.9 rise=3
echo SHOT 3 $&t3
meas tran t4 when v(ya)=0.9 rise=4
echo SHOT 4 $&t4
meas tran t5 when v(ya)=0.9 rise=5
echo SHOT 5 $&t5
meas tran t6 when v(ya)=0.9 rise=6
echo SHOT 6 $&t6
meas tran t7 when v(ya)=0.9 rise=7
echo SHOT 7 $&t7
meas tran t8 when v(ya)=0.9 rise=8
echo SHOT 8 $&t8
meas tran t9 when v(ya)=0.9 rise=9
echo SHOT 9 $&t9
meas tran t10 when v(ya)=0.9 rise=10
echo SHOT 10 $&t10
meas tran t11 when v(ya)=0.9 rise=11
echo SHOT 11 $&t11
meas tran t12 when v(ya)=0.9 rise=12
echo SHOT 12 $&t12
meas tran t13 when v(ya)=0.9 rise=13
echo SHOT 13 $&t13
meas tran t14 when v(ya)=0.9 rise=14
echo SHOT 14 $&t14
meas tran t15 when v(ya)=0.9 rise=15
echo SHOT 15 $&t15
meas tran t16 when v(ya)=0.9 rise=16
echo SHOT 16 $&t16
meas tran t17 when v(ya)=0.9 rise=17
echo SHOT 17 $&t17
meas tran t18 when v(ya)=0.9 rise=18
echo SHOT 18 $&t18
meas tran t19 when v(ya)=0.9 rise=19
echo SHOT 19 $&t19
meas tran t20 when v(ya)=0.9 rise=20
echo SHOT 20 $&t20
meas tran t21 when v(ya)=0.9 rise=21
echo SHOT 21 $&t21
meas tran t22 when v(ya)=0.9 rise=22
echo SHOT 22 $&t22
meas tran t23 when v(ya)=0.9 rise=23
echo SHOT 23 $&t23
meas tran t24 when v(ya)=0.9 rise=24
echo SHOT 24 $&t24
meas tran t25 when v(ya)=0.9 rise=25
echo SHOT 25 $&t25
meas tran t26 when v(ya)=0.9 rise=26
echo SHOT 26 $&t26
meas tran t27 when v(ya)=0.9 rise=27
echo SHOT 27 $&t27
meas tran t28 when v(ya)=0.9 rise=28
echo SHOT 28 $&t28
meas tran t29 when v(ya)=0.9 rise=29
echo SHOT 29 $&t29
meas tran t30 when v(ya)=0.9 rise=30
echo SHOT 30 $&t30
meas tran t31 when v(ya)=0.9 rise=31
echo SHOT 31 $&t31
meas tran t32 when v(ya)=0.9 rise=32
echo SHOT 32 $&t32
meas tran t33 when v(ya)=0.9 rise=33
echo SHOT 33 $&t33
meas tran t34 when v(ya)=0.9 rise=34
echo SHOT 34 $&t34
meas tran t35 when v(ya)=0.9 rise=35
echo SHOT 35 $&t35
meas tran t36 when v(ya)=0.9 rise=36
echo SHOT 36 $&t36
meas tran t37 when v(ya)=0.9 rise=37
echo SHOT 37 $&t37
meas tran t38 when v(ya)=0.9 rise=38
echo SHOT 38 $&t38
meas tran t39 when v(ya)=0.9 rise=39
echo SHOT 39 $&t39
meas tran t40 when v(ya)=0.9 rise=40
echo SHOT 40 $&t40
meas tran t41 when v(ya)=0.9 rise=41
echo SHOT 41 $&t41
meas tran t42 when v(ya)=0.9 rise=42
echo SHOT 42 $&t42
meas tran t43 when v(ya)=0.9 rise=43
echo SHOT 43 $&t43
meas tran t44 when v(ya)=0.9 rise=44
echo SHOT 44 $&t44
meas tran t45 when v(ya)=0.9 rise=45
echo SHOT 45 $&t45
meas tran t46 when v(ya)=0.9 rise=46
echo SHOT 46 $&t46
meas tran t47 when v(ya)=0.9 rise=47
echo SHOT 47 $&t47
meas tran t48 when v(ya)=0.9 rise=48
echo SHOT 48 $&t48
quit
.endc
.end
