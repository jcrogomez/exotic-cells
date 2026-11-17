* time cell, schematic, weak nfet 0.42/4, MOS capacitor 6x6 (A) and 2 x 6x6 (B). tt, 27 C
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
Vdd vdd 0 1.8
Vpre pre 0 pulse(1.8 0 100n 0.2n 0.2n 1 2)
* pre inverter (the proven misfit_inv sizes)
Xn0 pre_n pre 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.5
Xp0 pre_n pre vdd vdd sky130_fd_pr__pfet_01v8 w=1 l=0.5
* side A
Xpa xa_node pre_n vdd vdd sky130_fd_pr__pfet_01v8 w=1 l=0.5
Xna xa_node pre_n 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=4
Xca 0 xa_node 0 0 sky130_fd_pr__nfet_01v8 w=6 l=6
Xn1 xa xa_node 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.5
Xp1 xa xa_node vdd vdd sky130_fd_pr__pfet_01v8 w=1 l=0.5
Ca xa 0 5f
* side B
Xpb xb_node pre_n vdd vdd sky130_fd_pr__pfet_01v8 w=1 l=0.5
Xnb xb_node pre_n 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=4
Xcb 0 xb_node 0 0 sky130_fd_pr__nfet_01v8 w=6 l=6 m=2
Xn2 xb xb_node 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.5
Xp2 xb xb_node vdd vdd sky130_fd_pr__pfet_01v8 w=1 l=0.5
Cb xb 0 5f
.control
tran 1n 20u
meas tran ta trig v(pre) val=0.9 fall=1 targ v(xa) val=0.9 rise=1
meas tran tb trig v(pre) val=0.9 fall=1 targ v(xb) val=0.9 rise=1
meas tran ra trig v(xa) val=0.18 rise=1 targ v(xa) val=1.62 rise=1
meas tran rb trig v(xb) val=0.18 rise=1 targ v(xb) val=1.62 rise=1
echo SCH L=4 ta= $&ta tb= $&tb ratio= "$&(tb/ta)" rise_a= $&ra rise_b= $&rb
quit
.endc
.end
