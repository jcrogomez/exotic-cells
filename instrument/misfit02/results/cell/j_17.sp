* junction, clock phase 17 ns
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include c.spice
.temp 27
Vdd vdd 0 1.8
Vpre pre 0 pulse(1.8 0 100n 0.2n 0.2n 1 2)
Vclk clk 0 pulse(0 1.8 17n 0.2n 0.2n 9.8n 20n)
Xc pre xa xb 0 vdd misfit_tcell
Cb xb 0 10f
Xbuf xa 0 0 vdd vdd xbuf sky130_fd_sc_hd__buf_2
Xf1 clk xbuf 0 0 vdd vdd q1 sky130_fd_sc_hd__dfxtp_1
Xf2 clk q1 0 0 vdd vdd q2 sky130_fd_sc_hd__dfxtp_1
.ic v(q1)=0 v(q2)=0
.control
tran 0.02n 760n 400n
meas tran txa when v(xa)=0.9 rise=1
meas tran tq1 when v(q1)=0.9 rise=1
meas tran tq2 when v(q2)=0.9 rise=1
meas tran d1 trig v(q1) val=0.3 rise=1 targ v(q1) val=1.5 rise=1
meas tran d2 trig v(q2) val=0.3 rise=1 targ v(q2) val=1.5 rise=1
meas tran q2max max v(q2) from=400n to=600n
echo JUNC 17 $&txa $&tq1 $&tq2 $&d1 $&d2 $&q2max
quit
.endc
.end
