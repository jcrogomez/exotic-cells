* XC-20 lector, C = 200f
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ff
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.temp 85
.options gmin=1e-15 reltol=1e-4
Vd vdd 0 1.8
Co0 o0_x 0 200f
Io0 o0_x 0 3.1623e-10
Xo0_pre o0_x o0_pren o0_st vdd sky130_fd_pr__pfet_01v8_hvt w=1.0 l=0.15 m=2
Xo0_pre2 o0_st o0_pren vdd vdd sky130_fd_pr__pfet_01v8_hvt w=1.0 l=0.15 m=2
Xo0_cmp o0_x 0 0 vdd vdd o0_c sky130_fd_sc_hd__inv_1
Xo0_s1 o0_c 0 0 vdd vdd o0_c2 sky130_fd_sc_hd__inv_1
Xo0_s2 o0_c2 0 0 vdd vdd o0_s sky130_fd_sc_hd__inv_1
Xo0_q o0_r o0_qb 0 0 vdd vdd o0_q sky130_fd_sc_hd__nor2_1
Xo0_qb o0_s o0_q 0 0 vdd vdd o0_qb sky130_fd_sc_hd__nor2_1
Xo0_p o0_q 0 0 vdd vdd o0_pren sky130_fd_sc_hd__inv_4
Xo0_d0 o0_q 0 0 vdd vdd o0_d0 sky130_fd_sc_hd__dlygate4sd3_1
Xo0_d1 o0_d0 0 0 vdd vdd o0_d1 sky130_fd_sc_hd__dlygate4sd3_1
Xo0_d2 o0_d1 0 0 vdd vdd o0_d2 sky130_fd_sc_hd__dlygate4sd3_1
Xo0_d3 o0_d2 0 0 vdd vdd o0_d3 sky130_fd_sc_hd__dlygate4sd3_1
Xo0_d4 o0_d3 0 0 vdd vdd o0_d4 sky130_fd_sc_hd__dlygate4sd3_1
Xo0_d5 o0_d4 0 0 vdd vdd o0_d5 sky130_fd_sc_hd__dlygate4sd3_1
Xo0_d6 o0_d5 0 0 vdd vdd o0_d6 sky130_fd_sc_hd__dlygate4sd3_1
Xo0_d7 o0_d6 0 0 vdd vdd o0_r sky130_fd_sc_hd__dlygate4sd3_1
.ic v(o0_x)=1.8
.control
set noaskquit
save v(o0_q) v(o0_x)
tran 1.000e-09 1.1511e-02 0 1.000e-06
meas tran n0_r1 when v(o0_q)=0.9 rise=2
meas tran n0_r2 when v(o0_q)=0.9 rise=12
echo RES 1 3.1623e-10 $&n0_r1 $&n0_r2
quit
.endc
.end
