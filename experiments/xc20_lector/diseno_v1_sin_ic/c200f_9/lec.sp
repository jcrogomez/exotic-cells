* XC-20 lector, C = 200f
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.temp 27
.options gmin=1e-15 reltol=1e-4
Vd vdd 0 1.8
Co0 o0_x 0 200f
Io0 o0_x 0 3.1623e-06
Xo0_pre o0_x o0_pren vdd vdd sky130_fd_pr__pfet_01v8 w=4 l=0.15 m=4
Xo0_cmp o0_x 0 0 vdd vdd o0_c sky130_fd_sc_hd__inv_1
Xo0_d1 o0_c 0 0 vdd vdd o0_d1 sky130_fd_sc_hd__clkdlybuf4s25_1
Xo0_d2 o0_d1 0 0 vdd vdd o0_d2 sky130_fd_sc_hd__clkdlybuf4s25_1
Xo0_ip o0_d2 0 0 vdd vdd o0_pren sky130_fd_sc_hd__inv_4
Co0_l o0_c 0 2f
.control
set noaskquit
save v(o0_c)
tran 4.954e-11 9.9074e-07 0 4.954e-10
meas tran n0_r1 when v(o0_c)=0.9 rise=2
meas tran n0_r2 when v(o0_c)=0.9 rise=12
echo RES 9 3.1623e-06 $&n0_r1 $&n0_r2
quit
.endc
.end
