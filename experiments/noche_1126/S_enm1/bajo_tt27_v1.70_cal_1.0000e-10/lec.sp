* MISFIT-24 (lazo con seleccion y habilitacion, puertas _4) lector 2 rango bajo (L = 1.00), caso cal, I = 1.0000e-10 A, tt 27 C · VDD = 1.70 V · enmienda 1
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.temp 27
.options gmin=1e-15 reltol=1e-4
Vd vdd 0 1.70
Xf0 vdd o_prenl f_a_1300_1056 vdd sky130_fd_pr__pfet_01v8_hvt ad=0.3 pd=2.6 as=0.105 ps=1.21 w=1 l=1
Xf1 o_x o_prenl f_a_788_1056 vdd sky130_fd_pr__pfet_01v8_hvt ad=0.175 pd=1.35 as=0.105 ps=1.21 w=1 l=1
Xf2 0 o_x 0 0 sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=2.58 ps=18.4 w=4.3 l=4
Xf3 f_a_1300_1056 o_prenl o_x vdd sky130_fd_pr__pfet_01v8_hvt ad=0.105 pd=1.21 as=0.175 ps=1.35 w=1 l=1
Xf4 f_a_788_1056 o_prenl vdd vdd sky130_fd_pr__pfet_01v8_hvt ad=0.105 pd=1.21 as=0.3 ps=2.6 w=1 l=1
Xf5 f_a_342_1056 o_prenh o_x vdd sky130_fd_pr__pfet_01v8_hvt ad=0.105 pd=1.21 as=0.175 ps=1.35 w=1 l=0.15
Xf6 f_a_170_1056 o_prenh vdd vdd sky130_fd_pr__pfet_01v8_hvt ad=0.105 pd=1.21 as=0.3 ps=2.6 w=1 l=0.15
Xf7 o_x o_prenh f_a_170_1056 vdd sky130_fd_pr__pfet_01v8_hvt ad=0.175 pd=1.35 as=0.105 ps=1.21 w=1 l=0.15
Xf8 vdd o_prenh f_a_342_1056 vdd sky130_fd_pr__pfet_01v8_hvt ad=0.3 pd=2.6 as=0.105 ps=1.21 w=1 l=0.15
Cf0 o_prenl vdd 0.47456f
Cf1 o_x vdd 0.29103f
Cf2 f_a_1300_1056 vdd 0.00279f
Cf3 o_prenh vdd 0.21912f
Cf4 o_x f_a_788_1056 0.00181f
Cf5 o_x f_a_342_1056 0.00234f
Cf6 vdd f_a_788_1056 0.00279f
Cf7 f_a_342_1056 vdd 0.00319f
Cf8 f_a_170_1056 o_x 0.00179f
Cf9 f_a_170_1056 vdd 0.00319f
Cf10 o_prenl o_x 0.19097f
Cf11 f_a_1300_1056 o_x 0.00319f
Cf12 o_prenl o_prenh 0.02069f
Cf13 o_prenh o_x 0.08745f
Cf14 o_x 0 1.83606f
Cf15 o_prenl 0 1.11022f
Cf16 o_prenh 0 0.27503f
Cf17 vdd 0 2.09998f
Cf18 f_a_342_1056 0 0
Ven en 0 1.70
Vrs rs 0 0
Xo_ie en 0 0 vdd vdd o_enb sky130_fd_sc_hd__inv_1
Xo_ir rs 0 0 vdd vdd o_rsb sky130_fd_sc_hd__inv_1
Xo_gl o_q o_rsb o_enb 0 0 vdd vdd o_prenl sky130_fd_sc_hd__a21oi_4
Xo_gh o_q rs en 0 0 vdd vdd o_prenh sky130_fd_sc_hd__nand3_4
Dm0 m_a_700_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm1 0 sel6 m_a_4632_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm2 0 sel3 m_a_2154_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm3 m_a_3716_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm4 m_a_2908_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm5 0 sel2 m_a_1400_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm6 0 sel0 m_a_0_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm7 0 sel5 m_a_3716_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm8 m_a_2154_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm9 m_a_4632_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm10 0 sel4 m_a_2908_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm11 m_a_0_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm12 0 sel1 m_a_700_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm13 m_a_1400_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Cm0 m_a_1400_n392 m_a_2154_n392 0.00395f
Cm1 o_x sel4 0.0036f
Cm2 m_a_4632_n392 m_a_3716_n392 0.00325f
Cm3 o_x sel5 0.0036f
Cm4 m_a_1400_n392 sel2 0.00602f
Cm5 m_a_1400_n392 o_x 0.0806f
Cm6 m_a_2908_n392 m_a_2154_n392 0.00395f
Cm7 o_x sel6 0.0036f
Cm8 m_a_1400_n392 m_a_700_n392 0.00426f
Cm9 sel3 m_a_2154_n392 0.00602f
Cm10 sel1 sel0 0.02517f
Cm11 o_x m_a_3716_n392 0.07358f
Cm12 sel5 sel4 0.0217f
Cm13 o_x m_a_2908_n392 0.07755f
Cm14 sel2 sel1 0.02517f
Cm15 o_x sel1 0.0036f
Cm16 sel2 sel3 0.02331f
Cm17 o_x sel3 0.0036f
Cm18 sel1 m_a_700_n392 0.00602f
Cm19 sel5 sel6 0.01906f
Cm20 sel4 m_a_3716_n392 0
Cm21 m_a_2908_n392 sel4 0.00602f
Cm22 sel3 sel4 0.02331f
Cm23 sel5 m_a_3716_n392 0.00602f
Cm24 m_a_1400_n392 sel1 0
Cm25 o_x m_a_4632_n392 0.06771f
Cm26 sel0 m_a_0_n392 0.00602f
Cm27 m_a_2908_n392 m_a_3716_n392 0.00369f
Cm28 sel2 m_a_2154_n392 0
Cm29 o_x m_a_2154_n392 0.08071f
Cm30 o_x sel0 0.0036f
Cm31 m_a_2908_n392 sel3 0
Cm32 o_x m_a_0_n392 0.06002f
Cm33 sel0 m_a_700_n392 0
Cm34 m_a_0_n392 m_a_700_n392 0.00426f
Cm35 o_x sel2 0.0036f
Cm36 o_x m_a_700_n392 0.08513f
Cm37 sel5 m_a_4632_n392 0
Cm38 m_a_4632_n392 sel6 0.00602f
Cm39 sel6 0 0.35288f
Cm40 sel5 0 0.3262f
Cm41 sel4 0 0.3217f
Cm42 sel3 0 0.32004f
Cm43 sel2 0 0.31819f
Cm44 sel1 0 0.31633f
Cm45 sel0 0 0.34648f
Cm46 o_x 0 9.0034f
Cm47 m_a_4632_n392 0 0.31637f
Cm48 m_a_3716_n392 0 0.3035f
Cm49 m_a_2908_n392 0 0.2983f
Cm50 m_a_2154_n392 0 0.2953f
Cm51 m_a_1400_n392 0 0.29462f
Cm52 m_a_700_n392 0 0.29098f
Cm53 m_a_0_n392 0 0.32187f
Dwell 0 o_x sky130_fd_pr__model__parasitic__diode_ps2nw area=50.195 pj=60.56
Vsel0 sel0 0 0
Vsel1 sel1 0 0
Vsel2 sel2 0 0
Vsel3 sel3 0 0
Vsel4 sel4 0 0
Vsel5 sel5 0 0
Vsel6 sel6 0 0
Io o_x 0 1.0000e-10
Xo_cmp o_x 0 0 vdd vdd o_c sky130_fd_sc_hd__inv_1
Xo_s1 o_c 0 0 vdd vdd o_c2 sky130_fd_sc_hd__inv_1
Xo_s2 o_c2 0 0 vdd vdd o_s sky130_fd_sc_hd__inv_1
Xo_q o_r o_qb 0 0 vdd vdd o_q sky130_fd_sc_hd__nor2_1
Xo_qb o_s o_q 0 0 vdd vdd o_qb sky130_fd_sc_hd__nor2_1
Xo_d0 o_q 0 0 vdd vdd o_d0 sky130_fd_sc_hd__dlygate4sd3_1
Xo_d1 o_d0 0 0 vdd vdd o_d1 sky130_fd_sc_hd__dlygate4sd3_1
Xo_d2 o_d1 0 0 vdd vdd o_d2 sky130_fd_sc_hd__dlygate4sd3_1
Xo_d3 o_d2 0 0 vdd vdd o_d3 sky130_fd_sc_hd__dlygate4sd3_1
Xo_d4 o_d3 0 0 vdd vdd o_d4 sky130_fd_sc_hd__dlygate4sd3_1
Xo_d5 o_d4 0 0 vdd vdd o_d5 sky130_fd_sc_hd__dlygate4sd3_1
Xo_d6 o_d5 0 0 vdd vdd o_d6 sky130_fd_sc_hd__dlygate4sd3_1
Xo_d7 o_d6 0 0 vdd vdd o_r sky130_fd_sc_hd__dlygate4sd3_1
.ic v(o_x)=1.70 v(o_q)=0 v(o_qb)=1.70
.control
set noaskquit
save v(o_q) v(o_x) @dm9[cd] i(vd)
tran 1.000e-09 7.2800e-02 0 1.000e-06
meas tran r2 when v(o_q)=0.9 rise=2
meas tran r12 when v(o_q)=0.9 rise=12
meas tran r1 when v(o_q)=0.9 rise=1
echo R17 tt 27 bajo cal 1.0000e-10 $&r2 $&r12
let cdj = @dm9[cd]
let cd0 = cdj[length(cdj)-1]
echo CD $&cd0
meas tran e1 when v(o_q)=0.9 rise=1
echo ED 1 $&e1
meas tran e2 when v(o_q)=0.9 rise=2
echo ED 2 $&e2
meas tran e3 when v(o_q)=0.9 rise=3
echo ED 3 $&e3
meas tran e4 when v(o_q)=0.9 rise=4
echo ED 4 $&e4
meas tran e5 when v(o_q)=0.9 rise=5
echo ED 5 $&e5
meas tran e6 when v(o_q)=0.9 rise=6
echo ED 6 $&e6
meas tran e7 when v(o_q)=0.9 rise=7
echo ED 7 $&e7
meas tran e8 when v(o_q)=0.9 rise=8
echo ED 8 $&e8
meas tran e9 when v(o_q)=0.9 rise=9
echo ED 9 $&e9
meas tran e10 when v(o_q)=0.9 rise=10
echo ED 10 $&e10
meas tran e11 when v(o_q)=0.9 rise=11
echo ED 11 $&e11
meas tran e12 when v(o_q)=0.9 rise=12
echo ED 12 $&e12
quit
.endc
.end
