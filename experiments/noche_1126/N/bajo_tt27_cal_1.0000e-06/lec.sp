* MISFIT-24 (lazo con seleccion y habilitacion, puertas _4) lector 2 rango bajo (L = 1.00), caso cal, I = 1.0000e-06 A, tt 27 C · 63 puestos (9 matrices)
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.temp 27
.options gmin=1e-15 reltol=1e-4
Vd vdd 0 1.8
Dm0_k1 n1_a_700_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm1_k1 0 0 n1_a_4632_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm2_k1 0 0 n1_a_2154_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm3_k1 n1_a_3716_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm4_k1 n1_a_2908_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm5_k1 0 0 n1_a_1400_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm6_k1 0 0 n1_a_0_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm7_k1 0 0 n1_a_3716_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm8_k1 n1_a_2154_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm9_k1 n1_a_4632_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm10_k1 0 0 n1_a_2908_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm11_k1 n1_a_0_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm12_k1 0 0 n1_a_700_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm13_k1 n1_a_1400_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Cm0_k1 n1_a_1400_n392 n1_a_2154_n392 0.00395f
Cm1_k1 o_x 0 0.0036f
Cm2_k1 n1_a_4632_n392 n1_a_3716_n392 0.00325f
Cm3_k1 o_x 0 0.0036f
Cm4_k1 n1_a_1400_n392 0 0.00602f
Cm5_k1 n1_a_1400_n392 o_x 0.0806f
Cm6_k1 n1_a_2908_n392 n1_a_2154_n392 0.00395f
Cm7_k1 o_x 0 0.0036f
Cm8_k1 n1_a_1400_n392 n1_a_700_n392 0.00426f
Cm9_k1 0 n1_a_2154_n392 0.00602f
Cm10_k1 0 0 0.02517f
Cm11_k1 o_x n1_a_3716_n392 0.07358f
Cm12_k1 0 0 0.0217f
Cm13_k1 o_x n1_a_2908_n392 0.07755f
Cm14_k1 0 0 0.02517f
Cm15_k1 o_x 0 0.0036f
Cm16_k1 0 0 0.02331f
Cm17_k1 o_x 0 0.0036f
Cm18_k1 0 n1_a_700_n392 0.00602f
Cm19_k1 0 0 0.01906f
Cm20_k1 0 n1_a_3716_n392 0
Cm21_k1 n1_a_2908_n392 0 0.00602f
Cm22_k1 0 0 0.02331f
Cm23_k1 0 n1_a_3716_n392 0.00602f
Cm24_k1 n1_a_1400_n392 0 0
Cm25_k1 o_x n1_a_4632_n392 0.06771f
Cm26_k1 0 n1_a_0_n392 0.00602f
Cm27_k1 n1_a_2908_n392 n1_a_3716_n392 0.00369f
Cm28_k1 0 n1_a_2154_n392 0
Cm29_k1 o_x n1_a_2154_n392 0.08071f
Cm30_k1 o_x 0 0.0036f
Cm31_k1 n1_a_2908_n392 0 0
Cm32_k1 o_x n1_a_0_n392 0.06002f
Cm33_k1 0 n1_a_700_n392 0
Cm34_k1 n1_a_0_n392 n1_a_700_n392 0.00426f
Cm35_k1 o_x 0 0.0036f
Cm36_k1 o_x n1_a_700_n392 0.08513f
Cm37_k1 0 n1_a_4632_n392 0
Cm38_k1 n1_a_4632_n392 0 0.00602f
Cm39_k1 0 0 0.35288f
Cm40_k1 0 0 0.3262f
Cm41_k1 0 0 0.3217f
Cm42_k1 0 0 0.32004f
Cm43_k1 0 0 0.31819f
Cm44_k1 0 0 0.31633f
Cm45_k1 0 0 0.34648f
Cm46_k1 o_x 0 9.0034f
Cm47_k1 n1_a_4632_n392 0 0.31637f
Cm48_k1 n1_a_3716_n392 0 0.3035f
Cm49_k1 n1_a_2908_n392 0 0.2983f
Cm50_k1 n1_a_2154_n392 0 0.2953f
Cm51_k1 n1_a_1400_n392 0 0.29462f
Cm52_k1 n1_a_700_n392 0 0.29098f
Cm53_k1 n1_a_0_n392 0 0.32187f
Dwell_k1 0 o_x sky130_fd_pr__model__parasitic__diode_ps2nw area=50.195 pj=60.56
Dm0_k2 n2_a_700_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm1_k2 0 0 n2_a_4632_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm2_k2 0 0 n2_a_2154_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm3_k2 n2_a_3716_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm4_k2 n2_a_2908_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm5_k2 0 0 n2_a_1400_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm6_k2 0 0 n2_a_0_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm7_k2 0 0 n2_a_3716_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm8_k2 n2_a_2154_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm9_k2 n2_a_4632_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm10_k2 0 0 n2_a_2908_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm11_k2 n2_a_0_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm12_k2 0 0 n2_a_700_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm13_k2 n2_a_1400_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Cm0_k2 n2_a_1400_n392 n2_a_2154_n392 0.00395f
Cm1_k2 o_x 0 0.0036f
Cm2_k2 n2_a_4632_n392 n2_a_3716_n392 0.00325f
Cm3_k2 o_x 0 0.0036f
Cm4_k2 n2_a_1400_n392 0 0.00602f
Cm5_k2 n2_a_1400_n392 o_x 0.0806f
Cm6_k2 n2_a_2908_n392 n2_a_2154_n392 0.00395f
Cm7_k2 o_x 0 0.0036f
Cm8_k2 n2_a_1400_n392 n2_a_700_n392 0.00426f
Cm9_k2 0 n2_a_2154_n392 0.00602f
Cm10_k2 0 0 0.02517f
Cm11_k2 o_x n2_a_3716_n392 0.07358f
Cm12_k2 0 0 0.0217f
Cm13_k2 o_x n2_a_2908_n392 0.07755f
Cm14_k2 0 0 0.02517f
Cm15_k2 o_x 0 0.0036f
Cm16_k2 0 0 0.02331f
Cm17_k2 o_x 0 0.0036f
Cm18_k2 0 n2_a_700_n392 0.00602f
Cm19_k2 0 0 0.01906f
Cm20_k2 0 n2_a_3716_n392 0
Cm21_k2 n2_a_2908_n392 0 0.00602f
Cm22_k2 0 0 0.02331f
Cm23_k2 0 n2_a_3716_n392 0.00602f
Cm24_k2 n2_a_1400_n392 0 0
Cm25_k2 o_x n2_a_4632_n392 0.06771f
Cm26_k2 0 n2_a_0_n392 0.00602f
Cm27_k2 n2_a_2908_n392 n2_a_3716_n392 0.00369f
Cm28_k2 0 n2_a_2154_n392 0
Cm29_k2 o_x n2_a_2154_n392 0.08071f
Cm30_k2 o_x 0 0.0036f
Cm31_k2 n2_a_2908_n392 0 0
Cm32_k2 o_x n2_a_0_n392 0.06002f
Cm33_k2 0 n2_a_700_n392 0
Cm34_k2 n2_a_0_n392 n2_a_700_n392 0.00426f
Cm35_k2 o_x 0 0.0036f
Cm36_k2 o_x n2_a_700_n392 0.08513f
Cm37_k2 0 n2_a_4632_n392 0
Cm38_k2 n2_a_4632_n392 0 0.00602f
Cm39_k2 0 0 0.35288f
Cm40_k2 0 0 0.3262f
Cm41_k2 0 0 0.3217f
Cm42_k2 0 0 0.32004f
Cm43_k2 0 0 0.31819f
Cm44_k2 0 0 0.31633f
Cm45_k2 0 0 0.34648f
Cm46_k2 o_x 0 9.0034f
Cm47_k2 n2_a_4632_n392 0 0.31637f
Cm48_k2 n2_a_3716_n392 0 0.3035f
Cm49_k2 n2_a_2908_n392 0 0.2983f
Cm50_k2 n2_a_2154_n392 0 0.2953f
Cm51_k2 n2_a_1400_n392 0 0.29462f
Cm52_k2 n2_a_700_n392 0 0.29098f
Cm53_k2 n2_a_0_n392 0 0.32187f
Dwell_k2 0 o_x sky130_fd_pr__model__parasitic__diode_ps2nw area=50.195 pj=60.56
Dm0_k3 n3_a_700_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm1_k3 0 0 n3_a_4632_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm2_k3 0 0 n3_a_2154_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm3_k3 n3_a_3716_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm4_k3 n3_a_2908_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm5_k3 0 0 n3_a_1400_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm6_k3 0 0 n3_a_0_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm7_k3 0 0 n3_a_3716_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm8_k3 n3_a_2154_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm9_k3 n3_a_4632_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm10_k3 0 0 n3_a_2908_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm11_k3 n3_a_0_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm12_k3 0 0 n3_a_700_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm13_k3 n3_a_1400_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Cm0_k3 n3_a_1400_n392 n3_a_2154_n392 0.00395f
Cm1_k3 o_x 0 0.0036f
Cm2_k3 n3_a_4632_n392 n3_a_3716_n392 0.00325f
Cm3_k3 o_x 0 0.0036f
Cm4_k3 n3_a_1400_n392 0 0.00602f
Cm5_k3 n3_a_1400_n392 o_x 0.0806f
Cm6_k3 n3_a_2908_n392 n3_a_2154_n392 0.00395f
Cm7_k3 o_x 0 0.0036f
Cm8_k3 n3_a_1400_n392 n3_a_700_n392 0.00426f
Cm9_k3 0 n3_a_2154_n392 0.00602f
Cm10_k3 0 0 0.02517f
Cm11_k3 o_x n3_a_3716_n392 0.07358f
Cm12_k3 0 0 0.0217f
Cm13_k3 o_x n3_a_2908_n392 0.07755f
Cm14_k3 0 0 0.02517f
Cm15_k3 o_x 0 0.0036f
Cm16_k3 0 0 0.02331f
Cm17_k3 o_x 0 0.0036f
Cm18_k3 0 n3_a_700_n392 0.00602f
Cm19_k3 0 0 0.01906f
Cm20_k3 0 n3_a_3716_n392 0
Cm21_k3 n3_a_2908_n392 0 0.00602f
Cm22_k3 0 0 0.02331f
Cm23_k3 0 n3_a_3716_n392 0.00602f
Cm24_k3 n3_a_1400_n392 0 0
Cm25_k3 o_x n3_a_4632_n392 0.06771f
Cm26_k3 0 n3_a_0_n392 0.00602f
Cm27_k3 n3_a_2908_n392 n3_a_3716_n392 0.00369f
Cm28_k3 0 n3_a_2154_n392 0
Cm29_k3 o_x n3_a_2154_n392 0.08071f
Cm30_k3 o_x 0 0.0036f
Cm31_k3 n3_a_2908_n392 0 0
Cm32_k3 o_x n3_a_0_n392 0.06002f
Cm33_k3 0 n3_a_700_n392 0
Cm34_k3 n3_a_0_n392 n3_a_700_n392 0.00426f
Cm35_k3 o_x 0 0.0036f
Cm36_k3 o_x n3_a_700_n392 0.08513f
Cm37_k3 0 n3_a_4632_n392 0
Cm38_k3 n3_a_4632_n392 0 0.00602f
Cm39_k3 0 0 0.35288f
Cm40_k3 0 0 0.3262f
Cm41_k3 0 0 0.3217f
Cm42_k3 0 0 0.32004f
Cm43_k3 0 0 0.31819f
Cm44_k3 0 0 0.31633f
Cm45_k3 0 0 0.34648f
Cm46_k3 o_x 0 9.0034f
Cm47_k3 n3_a_4632_n392 0 0.31637f
Cm48_k3 n3_a_3716_n392 0 0.3035f
Cm49_k3 n3_a_2908_n392 0 0.2983f
Cm50_k3 n3_a_2154_n392 0 0.2953f
Cm51_k3 n3_a_1400_n392 0 0.29462f
Cm52_k3 n3_a_700_n392 0 0.29098f
Cm53_k3 n3_a_0_n392 0 0.32187f
Dwell_k3 0 o_x sky130_fd_pr__model__parasitic__diode_ps2nw area=50.195 pj=60.56
Dm0_k4 n4_a_700_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm1_k4 0 0 n4_a_4632_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm2_k4 0 0 n4_a_2154_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm3_k4 n4_a_3716_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm4_k4 n4_a_2908_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm5_k4 0 0 n4_a_1400_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm6_k4 0 0 n4_a_0_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm7_k4 0 0 n4_a_3716_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm8_k4 n4_a_2154_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm9_k4 n4_a_4632_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm10_k4 0 0 n4_a_2908_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm11_k4 n4_a_0_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm12_k4 0 0 n4_a_700_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm13_k4 n4_a_1400_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Cm0_k4 n4_a_1400_n392 n4_a_2154_n392 0.00395f
Cm1_k4 o_x 0 0.0036f
Cm2_k4 n4_a_4632_n392 n4_a_3716_n392 0.00325f
Cm3_k4 o_x 0 0.0036f
Cm4_k4 n4_a_1400_n392 0 0.00602f
Cm5_k4 n4_a_1400_n392 o_x 0.0806f
Cm6_k4 n4_a_2908_n392 n4_a_2154_n392 0.00395f
Cm7_k4 o_x 0 0.0036f
Cm8_k4 n4_a_1400_n392 n4_a_700_n392 0.00426f
Cm9_k4 0 n4_a_2154_n392 0.00602f
Cm10_k4 0 0 0.02517f
Cm11_k4 o_x n4_a_3716_n392 0.07358f
Cm12_k4 0 0 0.0217f
Cm13_k4 o_x n4_a_2908_n392 0.07755f
Cm14_k4 0 0 0.02517f
Cm15_k4 o_x 0 0.0036f
Cm16_k4 0 0 0.02331f
Cm17_k4 o_x 0 0.0036f
Cm18_k4 0 n4_a_700_n392 0.00602f
Cm19_k4 0 0 0.01906f
Cm20_k4 0 n4_a_3716_n392 0
Cm21_k4 n4_a_2908_n392 0 0.00602f
Cm22_k4 0 0 0.02331f
Cm23_k4 0 n4_a_3716_n392 0.00602f
Cm24_k4 n4_a_1400_n392 0 0
Cm25_k4 o_x n4_a_4632_n392 0.06771f
Cm26_k4 0 n4_a_0_n392 0.00602f
Cm27_k4 n4_a_2908_n392 n4_a_3716_n392 0.00369f
Cm28_k4 0 n4_a_2154_n392 0
Cm29_k4 o_x n4_a_2154_n392 0.08071f
Cm30_k4 o_x 0 0.0036f
Cm31_k4 n4_a_2908_n392 0 0
Cm32_k4 o_x n4_a_0_n392 0.06002f
Cm33_k4 0 n4_a_700_n392 0
Cm34_k4 n4_a_0_n392 n4_a_700_n392 0.00426f
Cm35_k4 o_x 0 0.0036f
Cm36_k4 o_x n4_a_700_n392 0.08513f
Cm37_k4 0 n4_a_4632_n392 0
Cm38_k4 n4_a_4632_n392 0 0.00602f
Cm39_k4 0 0 0.35288f
Cm40_k4 0 0 0.3262f
Cm41_k4 0 0 0.3217f
Cm42_k4 0 0 0.32004f
Cm43_k4 0 0 0.31819f
Cm44_k4 0 0 0.31633f
Cm45_k4 0 0 0.34648f
Cm46_k4 o_x 0 9.0034f
Cm47_k4 n4_a_4632_n392 0 0.31637f
Cm48_k4 n4_a_3716_n392 0 0.3035f
Cm49_k4 n4_a_2908_n392 0 0.2983f
Cm50_k4 n4_a_2154_n392 0 0.2953f
Cm51_k4 n4_a_1400_n392 0 0.29462f
Cm52_k4 n4_a_700_n392 0 0.29098f
Cm53_k4 n4_a_0_n392 0 0.32187f
Dwell_k4 0 o_x sky130_fd_pr__model__parasitic__diode_ps2nw area=50.195 pj=60.56
Dm0_k5 n5_a_700_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm1_k5 0 0 n5_a_4632_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm2_k5 0 0 n5_a_2154_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm3_k5 n5_a_3716_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm4_k5 n5_a_2908_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm5_k5 0 0 n5_a_1400_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm6_k5 0 0 n5_a_0_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm7_k5 0 0 n5_a_3716_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm8_k5 n5_a_2154_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm9_k5 n5_a_4632_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm10_k5 0 0 n5_a_2908_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm11_k5 n5_a_0_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm12_k5 0 0 n5_a_700_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm13_k5 n5_a_1400_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Cm0_k5 n5_a_1400_n392 n5_a_2154_n392 0.00395f
Cm1_k5 o_x 0 0.0036f
Cm2_k5 n5_a_4632_n392 n5_a_3716_n392 0.00325f
Cm3_k5 o_x 0 0.0036f
Cm4_k5 n5_a_1400_n392 0 0.00602f
Cm5_k5 n5_a_1400_n392 o_x 0.0806f
Cm6_k5 n5_a_2908_n392 n5_a_2154_n392 0.00395f
Cm7_k5 o_x 0 0.0036f
Cm8_k5 n5_a_1400_n392 n5_a_700_n392 0.00426f
Cm9_k5 0 n5_a_2154_n392 0.00602f
Cm10_k5 0 0 0.02517f
Cm11_k5 o_x n5_a_3716_n392 0.07358f
Cm12_k5 0 0 0.0217f
Cm13_k5 o_x n5_a_2908_n392 0.07755f
Cm14_k5 0 0 0.02517f
Cm15_k5 o_x 0 0.0036f
Cm16_k5 0 0 0.02331f
Cm17_k5 o_x 0 0.0036f
Cm18_k5 0 n5_a_700_n392 0.00602f
Cm19_k5 0 0 0.01906f
Cm20_k5 0 n5_a_3716_n392 0
Cm21_k5 n5_a_2908_n392 0 0.00602f
Cm22_k5 0 0 0.02331f
Cm23_k5 0 n5_a_3716_n392 0.00602f
Cm24_k5 n5_a_1400_n392 0 0
Cm25_k5 o_x n5_a_4632_n392 0.06771f
Cm26_k5 0 n5_a_0_n392 0.00602f
Cm27_k5 n5_a_2908_n392 n5_a_3716_n392 0.00369f
Cm28_k5 0 n5_a_2154_n392 0
Cm29_k5 o_x n5_a_2154_n392 0.08071f
Cm30_k5 o_x 0 0.0036f
Cm31_k5 n5_a_2908_n392 0 0
Cm32_k5 o_x n5_a_0_n392 0.06002f
Cm33_k5 0 n5_a_700_n392 0
Cm34_k5 n5_a_0_n392 n5_a_700_n392 0.00426f
Cm35_k5 o_x 0 0.0036f
Cm36_k5 o_x n5_a_700_n392 0.08513f
Cm37_k5 0 n5_a_4632_n392 0
Cm38_k5 n5_a_4632_n392 0 0.00602f
Cm39_k5 0 0 0.35288f
Cm40_k5 0 0 0.3262f
Cm41_k5 0 0 0.3217f
Cm42_k5 0 0 0.32004f
Cm43_k5 0 0 0.31819f
Cm44_k5 0 0 0.31633f
Cm45_k5 0 0 0.34648f
Cm46_k5 o_x 0 9.0034f
Cm47_k5 n5_a_4632_n392 0 0.31637f
Cm48_k5 n5_a_3716_n392 0 0.3035f
Cm49_k5 n5_a_2908_n392 0 0.2983f
Cm50_k5 n5_a_2154_n392 0 0.2953f
Cm51_k5 n5_a_1400_n392 0 0.29462f
Cm52_k5 n5_a_700_n392 0 0.29098f
Cm53_k5 n5_a_0_n392 0 0.32187f
Dwell_k5 0 o_x sky130_fd_pr__model__parasitic__diode_ps2nw area=50.195 pj=60.56
Dm0_k6 n6_a_700_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm1_k6 0 0 n6_a_4632_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm2_k6 0 0 n6_a_2154_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm3_k6 n6_a_3716_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm4_k6 n6_a_2908_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm5_k6 0 0 n6_a_1400_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm6_k6 0 0 n6_a_0_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm7_k6 0 0 n6_a_3716_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm8_k6 n6_a_2154_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm9_k6 n6_a_4632_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm10_k6 0 0 n6_a_2908_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm11_k6 n6_a_0_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm12_k6 0 0 n6_a_700_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm13_k6 n6_a_1400_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Cm0_k6 n6_a_1400_n392 n6_a_2154_n392 0.00395f
Cm1_k6 o_x 0 0.0036f
Cm2_k6 n6_a_4632_n392 n6_a_3716_n392 0.00325f
Cm3_k6 o_x 0 0.0036f
Cm4_k6 n6_a_1400_n392 0 0.00602f
Cm5_k6 n6_a_1400_n392 o_x 0.0806f
Cm6_k6 n6_a_2908_n392 n6_a_2154_n392 0.00395f
Cm7_k6 o_x 0 0.0036f
Cm8_k6 n6_a_1400_n392 n6_a_700_n392 0.00426f
Cm9_k6 0 n6_a_2154_n392 0.00602f
Cm10_k6 0 0 0.02517f
Cm11_k6 o_x n6_a_3716_n392 0.07358f
Cm12_k6 0 0 0.0217f
Cm13_k6 o_x n6_a_2908_n392 0.07755f
Cm14_k6 0 0 0.02517f
Cm15_k6 o_x 0 0.0036f
Cm16_k6 0 0 0.02331f
Cm17_k6 o_x 0 0.0036f
Cm18_k6 0 n6_a_700_n392 0.00602f
Cm19_k6 0 0 0.01906f
Cm20_k6 0 n6_a_3716_n392 0
Cm21_k6 n6_a_2908_n392 0 0.00602f
Cm22_k6 0 0 0.02331f
Cm23_k6 0 n6_a_3716_n392 0.00602f
Cm24_k6 n6_a_1400_n392 0 0
Cm25_k6 o_x n6_a_4632_n392 0.06771f
Cm26_k6 0 n6_a_0_n392 0.00602f
Cm27_k6 n6_a_2908_n392 n6_a_3716_n392 0.00369f
Cm28_k6 0 n6_a_2154_n392 0
Cm29_k6 o_x n6_a_2154_n392 0.08071f
Cm30_k6 o_x 0 0.0036f
Cm31_k6 n6_a_2908_n392 0 0
Cm32_k6 o_x n6_a_0_n392 0.06002f
Cm33_k6 0 n6_a_700_n392 0
Cm34_k6 n6_a_0_n392 n6_a_700_n392 0.00426f
Cm35_k6 o_x 0 0.0036f
Cm36_k6 o_x n6_a_700_n392 0.08513f
Cm37_k6 0 n6_a_4632_n392 0
Cm38_k6 n6_a_4632_n392 0 0.00602f
Cm39_k6 0 0 0.35288f
Cm40_k6 0 0 0.3262f
Cm41_k6 0 0 0.3217f
Cm42_k6 0 0 0.32004f
Cm43_k6 0 0 0.31819f
Cm44_k6 0 0 0.31633f
Cm45_k6 0 0 0.34648f
Cm46_k6 o_x 0 9.0034f
Cm47_k6 n6_a_4632_n392 0 0.31637f
Cm48_k6 n6_a_3716_n392 0 0.3035f
Cm49_k6 n6_a_2908_n392 0 0.2983f
Cm50_k6 n6_a_2154_n392 0 0.2953f
Cm51_k6 n6_a_1400_n392 0 0.29462f
Cm52_k6 n6_a_700_n392 0 0.29098f
Cm53_k6 n6_a_0_n392 0 0.32187f
Dwell_k6 0 o_x sky130_fd_pr__model__parasitic__diode_ps2nw area=50.195 pj=60.56
Dm0_k7 n7_a_700_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm1_k7 0 0 n7_a_4632_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm2_k7 0 0 n7_a_2154_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm3_k7 n7_a_3716_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm4_k7 n7_a_2908_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm5_k7 0 0 n7_a_1400_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm6_k7 0 0 n7_a_0_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm7_k7 0 0 n7_a_3716_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm8_k7 n7_a_2154_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm9_k7 n7_a_4632_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm10_k7 0 0 n7_a_2908_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm11_k7 n7_a_0_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm12_k7 0 0 n7_a_700_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm13_k7 n7_a_1400_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Cm0_k7 n7_a_1400_n392 n7_a_2154_n392 0.00395f
Cm1_k7 o_x 0 0.0036f
Cm2_k7 n7_a_4632_n392 n7_a_3716_n392 0.00325f
Cm3_k7 o_x 0 0.0036f
Cm4_k7 n7_a_1400_n392 0 0.00602f
Cm5_k7 n7_a_1400_n392 o_x 0.0806f
Cm6_k7 n7_a_2908_n392 n7_a_2154_n392 0.00395f
Cm7_k7 o_x 0 0.0036f
Cm8_k7 n7_a_1400_n392 n7_a_700_n392 0.00426f
Cm9_k7 0 n7_a_2154_n392 0.00602f
Cm10_k7 0 0 0.02517f
Cm11_k7 o_x n7_a_3716_n392 0.07358f
Cm12_k7 0 0 0.0217f
Cm13_k7 o_x n7_a_2908_n392 0.07755f
Cm14_k7 0 0 0.02517f
Cm15_k7 o_x 0 0.0036f
Cm16_k7 0 0 0.02331f
Cm17_k7 o_x 0 0.0036f
Cm18_k7 0 n7_a_700_n392 0.00602f
Cm19_k7 0 0 0.01906f
Cm20_k7 0 n7_a_3716_n392 0
Cm21_k7 n7_a_2908_n392 0 0.00602f
Cm22_k7 0 0 0.02331f
Cm23_k7 0 n7_a_3716_n392 0.00602f
Cm24_k7 n7_a_1400_n392 0 0
Cm25_k7 o_x n7_a_4632_n392 0.06771f
Cm26_k7 0 n7_a_0_n392 0.00602f
Cm27_k7 n7_a_2908_n392 n7_a_3716_n392 0.00369f
Cm28_k7 0 n7_a_2154_n392 0
Cm29_k7 o_x n7_a_2154_n392 0.08071f
Cm30_k7 o_x 0 0.0036f
Cm31_k7 n7_a_2908_n392 0 0
Cm32_k7 o_x n7_a_0_n392 0.06002f
Cm33_k7 0 n7_a_700_n392 0
Cm34_k7 n7_a_0_n392 n7_a_700_n392 0.00426f
Cm35_k7 o_x 0 0.0036f
Cm36_k7 o_x n7_a_700_n392 0.08513f
Cm37_k7 0 n7_a_4632_n392 0
Cm38_k7 n7_a_4632_n392 0 0.00602f
Cm39_k7 0 0 0.35288f
Cm40_k7 0 0 0.3262f
Cm41_k7 0 0 0.3217f
Cm42_k7 0 0 0.32004f
Cm43_k7 0 0 0.31819f
Cm44_k7 0 0 0.31633f
Cm45_k7 0 0 0.34648f
Cm46_k7 o_x 0 9.0034f
Cm47_k7 n7_a_4632_n392 0 0.31637f
Cm48_k7 n7_a_3716_n392 0 0.3035f
Cm49_k7 n7_a_2908_n392 0 0.2983f
Cm50_k7 n7_a_2154_n392 0 0.2953f
Cm51_k7 n7_a_1400_n392 0 0.29462f
Cm52_k7 n7_a_700_n392 0 0.29098f
Cm53_k7 n7_a_0_n392 0 0.32187f
Dwell_k7 0 o_x sky130_fd_pr__model__parasitic__diode_ps2nw area=50.195 pj=60.56
Dm0_k8 n8_a_700_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm1_k8 0 0 n8_a_4632_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm2_k8 0 0 n8_a_2154_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm3_k8 n8_a_3716_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm4_k8 n8_a_2908_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm5_k8 0 0 n8_a_1400_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm6_k8 0 0 n8_a_0_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xm7_k8 0 0 n8_a_3716_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm8_k8 n8_a_2154_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Dm9_k8 n8_a_4632_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm10_k8 0 0 n8_a_2908_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm11_k8 n8_a_0_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Xm12_k8 0 0 n8_a_700_n392 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dm13_k8 n8_a_1400_n392 o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Cm0_k8 n8_a_1400_n392 n8_a_2154_n392 0.00395f
Cm1_k8 o_x 0 0.0036f
Cm2_k8 n8_a_4632_n392 n8_a_3716_n392 0.00325f
Cm3_k8 o_x 0 0.0036f
Cm4_k8 n8_a_1400_n392 0 0.00602f
Cm5_k8 n8_a_1400_n392 o_x 0.0806f
Cm6_k8 n8_a_2908_n392 n8_a_2154_n392 0.00395f
Cm7_k8 o_x 0 0.0036f
Cm8_k8 n8_a_1400_n392 n8_a_700_n392 0.00426f
Cm9_k8 0 n8_a_2154_n392 0.00602f
Cm10_k8 0 0 0.02517f
Cm11_k8 o_x n8_a_3716_n392 0.07358f
Cm12_k8 0 0 0.0217f
Cm13_k8 o_x n8_a_2908_n392 0.07755f
Cm14_k8 0 0 0.02517f
Cm15_k8 o_x 0 0.0036f
Cm16_k8 0 0 0.02331f
Cm17_k8 o_x 0 0.0036f
Cm18_k8 0 n8_a_700_n392 0.00602f
Cm19_k8 0 0 0.01906f
Cm20_k8 0 n8_a_3716_n392 0
Cm21_k8 n8_a_2908_n392 0 0.00602f
Cm22_k8 0 0 0.02331f
Cm23_k8 0 n8_a_3716_n392 0.00602f
Cm24_k8 n8_a_1400_n392 0 0
Cm25_k8 o_x n8_a_4632_n392 0.06771f
Cm26_k8 0 n8_a_0_n392 0.00602f
Cm27_k8 n8_a_2908_n392 n8_a_3716_n392 0.00369f
Cm28_k8 0 n8_a_2154_n392 0
Cm29_k8 o_x n8_a_2154_n392 0.08071f
Cm30_k8 o_x 0 0.0036f
Cm31_k8 n8_a_2908_n392 0 0
Cm32_k8 o_x n8_a_0_n392 0.06002f
Cm33_k8 0 n8_a_700_n392 0
Cm34_k8 n8_a_0_n392 n8_a_700_n392 0.00426f
Cm35_k8 o_x 0 0.0036f
Cm36_k8 o_x n8_a_700_n392 0.08513f
Cm37_k8 0 n8_a_4632_n392 0
Cm38_k8 n8_a_4632_n392 0 0.00602f
Cm39_k8 0 0 0.35288f
Cm40_k8 0 0 0.3262f
Cm41_k8 0 0 0.3217f
Cm42_k8 0 0 0.32004f
Cm43_k8 0 0 0.31819f
Cm44_k8 0 0 0.31633f
Cm45_k8 0 0 0.34648f
Cm46_k8 o_x 0 9.0034f
Cm47_k8 n8_a_4632_n392 0 0.31637f
Cm48_k8 n8_a_3716_n392 0 0.3035f
Cm49_k8 n8_a_2908_n392 0 0.2983f
Cm50_k8 n8_a_2154_n392 0 0.2953f
Cm51_k8 n8_a_1400_n392 0 0.29462f
Cm52_k8 n8_a_700_n392 0 0.29098f
Cm53_k8 n8_a_0_n392 0 0.32187f
Dwell_k8 0 o_x sky130_fd_pr__model__parasitic__diode_ps2nw area=50.195 pj=60.56
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
Ven en 0 1.8
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
Io o_x 0 1.0000e-06
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
.ic v(o_x)=1.8
.control
set noaskquit
save v(o_q) v(o_x) @dm9[cd] i(vd)
tran 3.720e-10 7.4400e-06 0 3.720e-09
meas tran r2 when v(o_q)=0.9 rise=2
meas tran r12 when v(o_q)=0.9 rise=12
meas tran r1 when v(o_q)=0.9 rise=1
echo R17 tt 27 bajo cal 1.0000e-06 $&r2 $&r12
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
