* XC-20 lector 2, R2: I = 1.0000e-10 A, nodo MOS 4,3/4,0, ff -40 C
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ff
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.temp -40
.options gmin=1e-15 reltol=1e-4
Vd vdd 0 1.8
Xo_c 0 o_x 0 0 sky130_fd_pr__nfet_01v8 w=4.3 l=4
Io o_x 0 1.0000e-10
Xo_pre o_x o_pren o_st vdd sky130_fd_pr__pfet_01v8_hvt w=1 l=2.00 m=2
Xo_pre2 o_st o_pren vdd vdd sky130_fd_pr__pfet_01v8_hvt w=1 l=2.00 m=2
Xo_cmp o_x 0 0 vdd vdd o_c sky130_fd_sc_hd__inv_1
Xo_s1 o_c 0 0 vdd vdd o_c2 sky130_fd_sc_hd__inv_1
Xo_s2 o_c2 0 0 vdd vdd o_s sky130_fd_sc_hd__inv_1
Xo_q o_r o_qb 0 0 vdd vdd o_q sky130_fd_sc_hd__nor2_1
Xo_qb o_s o_q 0 0 vdd vdd o_qb sky130_fd_sc_hd__nor2_1
Xo_p o_q 0 0 vdd vdd o_pren sky130_fd_sc_hd__inv_4
Xo_d0 o_q 0 0 vdd vdd o_d0 sky130_fd_sc_hd__dlygate4sd3_1
Xo_d1 o_d0 0 0 vdd vdd o_d1 sky130_fd_sc_hd__dlygate4sd3_1
Xo_d2 o_d1 0 0 vdd vdd o_d2 sky130_fd_sc_hd__dlygate4sd3_1
Xo_d3 o_d2 0 0 vdd vdd o_d3 sky130_fd_sc_hd__dlygate4sd3_1
Xo_d4 o_d3 0 0 vdd vdd o_d4 sky130_fd_sc_hd__dlygate4sd3_1
Xo_d5 o_d4 0 0 vdd vdd o_d5 sky130_fd_sc_hd__dlygate4sd3_1
Xo_d6 o_d5 0 0 vdd vdd o_d6 sky130_fd_sc_hd__dlygate4sd3_1
Xo_d7 o_d6 0 0 vdd vdd o_r sky130_fd_sc_hd__dlygate4sd3_1
.ic v(o_x)=1.8
.control
set noaskquit
save v(o_q) v(o_x)
tran 1.000e-09 5.6000e-02 0 1.000e-06
meas tran r2 when v(o_q)=0.9 rise=2
meas tran r12 when v(o_q)=0.9 rise=12
meas tran r1 when v(o_q)=0.9 rise=1
meas tran xmin min v(o_x) from=0 to=5.6000e-02
echo R2 ff -40 mos 1.0000e-10 $&r2 $&r12
echo R2X ff -40 1.0000e-10 xmin $&xmin
quit
.endc
.end
