* MISFIT-15 puesto de XC-20, esquina ff 85 C. Generado por gen.py
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ff
.options gmin=1e-18 abstol=1e-18 reltol=1e-6
.temp 85
Vg g 0 1.8
Vc ctl 0 0
Vs s 0 0
Vxa1 xa1 0 1.8
Xsa1 xa1 g ja1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dda1 0 ja1 sky130_fd_pr__diode_pw2nd_05v5 area=1.4 pj=4.8
Ba1 ja1 0 I = v(ctl)*(max(v(ja1),0)/1.8)
Eja1 ja1 0 s 0 1
Vxb1 xb1 0 1.8
Xsb1 jb1 g 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Ddb1 jb1 xb1 sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Bb1 xb1 jb1 I = v(ctl)*(max(v(xb1,jb1),0)/1.8)
Ejb1 jb1 0 s 0 1
Vxa3 xa3 0 1.8
Xsa3 xa3 g ja3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Dda3 0 ja3 sky130_fd_pr__diode_pw2nd_05v5 area=1.4 pj=4.8
Ba3 ja3 0 I = v(ctl)*(max(v(ja3),0)/1.8)*(max(v(ja3),0)/1.8)*(max(v(ja3),0)/1.8)
Eja3 ja3 0 s 0 1
Vxb3 xb3 0 1.8
Xsb3 jb3 g 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Ddb3 jb3 xb3 sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Bb3 xb3 jb3 I = v(ctl)*(max(v(xb3,jb3),0)/1.8)*(max(v(xb3,jb3),0)/1.8)*(max(v(xb3,jb3),0)/1.8)
Ejb3 jb3 0 s 0 1
Vr1 r1 0 1.8
Ddl1 0 r1 sky130_fd_pr__diode_pw2nd_05v5 area=1.4 pj=4.8
Vr2 r2 0 1.8
Ddl2 0 r2 sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8
Vr3 r3 0 1.8
Dw 0 r3 sky130_fd_pr__model__parasitic__diode_ps2nw area=112 pj=64
.control
set noaskquit
set numdgt=12
set wr_singlescale
op
let cdl = @ddl1[cd]
echo CD $&cdl
alter Vxa1 dc = 1.8
alter Vxa3 dc = 1.8
alter Vxb1 dc = 1.8
alter Vxb3 dc = 1.8
alter Vg dc = 1.8
alter Vc dc = 0
dc Vs 0 1.8 0.002
wrdata f_18_s_0.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 1.8 1 0
alter Vc dc = 1e-12
dc Vs 0 1.8 0.002
wrdata f_18_s_1.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 1.8 1 1e-12
alter Vc dc = 1e-10
dc Vs 0 1.8 0.002
wrdata f_18_s_2.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 1.8 1 1e-10
alter Vc dc = 1e-8
dc Vs 0 1.8 0.002
wrdata f_18_s_3.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 1.8 1 1e-8
alter Vc dc = 1e-6
dc Vs 0 1.8 0.002
wrdata f_18_s_4.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 1.8 1 1e-6
alter Vc dc = 1e-5
dc Vs 0 1.8 0.002
wrdata f_18_s_5.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 1.8 1 1e-5
alter Vc dc = 1e-7
dc Vs 0 1.8 0.002
wrdata f_18_s_6.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 1.8 1 1e-7
alter Vxa1 dc = 1.8
alter Vxa3 dc = 1.8
alter Vxb1 dc = 1.8
alter Vxb3 dc = 1.8
alter Vg dc = 0
alter Vc dc = 0
dc Vs 0 1.8 0.002
wrdata f_18_u_0.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 1.8 0 0
alter Vc dc = 1e-12
dc Vs 0 1.8 0.002
wrdata f_18_u_1.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 1.8 0 1e-12
alter Vc dc = 1e-10
dc Vs 0 1.8 0.002
wrdata f_18_u_2.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 1.8 0 1e-10
alter Vc dc = 1e-8
dc Vs 0 1.8 0.002
wrdata f_18_u_3.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 1.8 0 1e-8
alter Vc dc = 1e-6
dc Vs 0 1.8 0.002
wrdata f_18_u_4.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 1.8 0 1e-6
alter Vc dc = 1e-5
dc Vs 0 1.8 0.002
wrdata f_18_u_5.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 1.8 0 1e-5
alter Vxa1 dc = 0.9
alter Vxa3 dc = 0.9
alter Vxb1 dc = 0.9
alter Vxb3 dc = 0.9
alter Vg dc = 1.8
alter Vc dc = 0
dc Vs 0 1.8 0.002
wrdata f_09_s_0.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 0.9 1 0
alter Vc dc = 1e-12
dc Vs 0 1.8 0.002
wrdata f_09_s_1.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 0.9 1 1e-12
alter Vc dc = 1e-10
dc Vs 0 1.8 0.002
wrdata f_09_s_2.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 0.9 1 1e-10
alter Vc dc = 1e-8
dc Vs 0 1.8 0.002
wrdata f_09_s_3.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 0.9 1 1e-8
alter Vc dc = 1e-6
dc Vs 0 1.8 0.002
wrdata f_09_s_4.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 0.9 1 1e-6
alter Vc dc = 1e-5
dc Vs 0 1.8 0.002
wrdata f_09_s_5.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 0.9 1 1e-5
alter Vxa1 dc = 0.9
alter Vxa3 dc = 0.9
alter Vxb1 dc = 0.9
alter Vxb3 dc = 0.9
alter Vg dc = 0
alter Vc dc = 0
dc Vs 0 1.8 0.002
wrdata f_09_u_0.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 0.9 0 0
alter Vc dc = 1e-12
dc Vs 0 1.8 0.002
wrdata f_09_u_1.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 0.9 0 1e-12
alter Vc dc = 1e-10
dc Vs 0 1.8 0.002
wrdata f_09_u_2.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 0.9 0 1e-10
alter Vc dc = 1e-8
dc Vs 0 1.8 0.002
wrdata f_09_u_3.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 0.9 0 1e-8
alter Vc dc = 1e-6
dc Vs 0 1.8 0.002
wrdata f_09_u_4.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 0.9 0 1e-6
alter Vc dc = 1e-5
dc Vs 0 1.8 0.002
wrdata f_09_u_5.txt i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)
echo HECHO 0.9 0 1e-5
quit
.endc
.end
