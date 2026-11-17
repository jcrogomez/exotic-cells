* time cell, level c, corner tt, 27 C, 1.79 V
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include c.spice
.temp 27
Vdd vdd 0 1.79
Vpre pre 0 pulse(1.79 0 100n 0.2n 0.2n 1 2)
Xc pre xa xb 0 vdd misfit_tcell
Ca xa 0 10f
Cb xb 0 10f
.control
tran 0.5n 6u
meas tran ta trig v(pre) val=0.9 fall=1 targ v(xa) val=0.9 rise=1
meas tran tb trig v(pre) val=0.9 fall=1 targ v(xb) val=0.9 rise=1
meas tran ra trig v(xa) val=0.18 rise=1 targ v(xa) val=1.62 rise=1
meas tran rb trig v(xb) val=0.18 rise=1 targ v(xb) val=1.62 rise=1
let ratio = tb/ta
echo CELL c tt 27 1.79 $&ta $&tb $&ratio $&ra $&rb
quit
.endc
.end
