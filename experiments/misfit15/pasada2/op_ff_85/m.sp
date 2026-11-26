* MISFIT-15 puesto de XC-20, esquina ff 85 C. Generado por gen.py
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ff
.options gmin=1e-18 abstol=1e-18 reltol=1e-6
.temp 85
.subckt xc20s SEL0 SEL1 SEL2 SEL3 SEL4 SEL5 SEL6 X GND
X0 X SEL6 a_4632_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
X1 GND a_700_n392# sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
X2 X SEL3 a_2154_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
X3 GND a_3716_n392# sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
X4 GND a_2908_n392# sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
X5 X SEL2 a_1400_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
X6 X SEL0 a_0_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
X7 X SEL5 a_3716_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
X8 GND a_2154_n392# sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
X9 GND a_4632_n392# sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
X10 X SEL4 a_2908_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
X11 X SEL1 a_700_n392# GND sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
X12 GND a_0_n392# sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
X13 GND a_1400_n392# sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
.ends

Vd vdd 0 1.8
Vg g 0 1.8
Vc ctl 0 0
Vxa1 xa1 0 1.8
Xsa1 xa1 g ja1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xda1 0 ja1 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
Ba1 ja1 0 I = v(ctl)*(max(v(ja1),0)/1.8)
Vxb1 xb1 0 1.8
Xsb1 jb1 g 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdb1 jb1 xb1 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Bb1 xb1 jb1 I = v(ctl)*(max(v(xb1,jb1),0)/1.8)
Vxa3 xa3 0 1.8
Xsa3 xa3 g ja3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xda3 0 ja3 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
Ba3 ja3 0 I = v(ctl)*(max(v(ja3),0)/1.8)*(max(v(ja3),0)/1.8)*(max(v(ja3),0)/1.8)
Vxb3 xb3 0 1.8
Xsb3 jb3 g 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdb3 jb3 xb3 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Bb3 xb3 jb3 I = v(ctl)*(max(v(xb3,jb3),0)/1.8)*(max(v(xb3,jb3),0)/1.8)*(max(v(xb3,jb3),0)/1.8)
Vr1 r1 0 1.8
Xdl1 0 r1 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
Vr2 r2 0 1.8
Xdl2 0 r2 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Vuaoff uaoff 0 1.8
Xbusaoff 0 0 0 0 0 0 0 uaoff 0 xc20s
Vuboff uboff 0 1.8
Dwoff 0 uboff sky130_fd_pr__model__parasitic__diode_ps2nw area=112e12 pj=64e6
Xqsoff0 qboff0 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xqdoff0 qboff0 uboff sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xqsoff1 qboff1 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xqdoff1 qboff1 uboff sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xqsoff2 qboff2 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xqdoff2 qboff2 uboff sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xqsoff3 qboff3 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xqdoff3 qboff3 uboff sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xqsoff4 qboff4 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xqdoff4 qboff4 uboff sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xqsoff5 qboff5 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xqdoff5 qboff5 uboff sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xqsoff6 qboff6 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xqdoff6 qboff6 uboff sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Vuaon uaon 0 1.8
Xbusaon vdd 0 0 0 0 0 0 uaon 0 xc20s
Vubon ubon 0 1.8
Dwon 0 ubon sky130_fd_pr__model__parasitic__diode_ps2nw area=112e12 pj=64e6
Xqson0 qbon0 vdd 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xqdon0 qbon0 ubon sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xqson1 qbon1 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xqdon1 qbon1 ubon sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xqson2 qbon2 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xqdon2 qbon2 ubon sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xqson3 qbon3 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xqdon3 qbon3 ubon sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xqson4 qbon4 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xqdon4 qbon4 ubon sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xqson5 qbon5 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xqdon5 qbon5 ubon sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xqson6 qbon6 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xqdon6 qbon6 ubon sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
.control
set noaskquit
alter Vxa1 dc = 1.8
alter Vxa3 dc = 1.8
alter Vxb1 dc = 1.8
alter Vxb3 dc = 1.8
alter Vg dc = 1.8
alter Vc dc = 0
op
let a = v(r1)
let b = -i(Vr1)
echo K ff 85 DPW $&a $&b
let a = v(r2)
let b = -i(Vr2)
echo K ff 85 DPD $&a $&b
let a = v(uaoff)
let b = -i(Vuaoff)
echo K ff 85 BUSA_off $&a $&b
let a = v(uaon)
let b = -i(Vuaon)
echo K ff 85 BUSA_on $&a $&b
let a = v(uboff)
let b = -i(Vuboff)
echo K ff 85 BUSB_off $&a $&b
let a = v(ubon)
let b = -i(Vubon)
echo K ff 85 BUSB_on $&a $&b
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_18_s_0 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_18_s_0 $&a $&b
alter Vc dc = 1e-12
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_18_s_1 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_18_s_1 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_18_s_6 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_18_s_6 $&a $&b
alter Vc dc = 1e-10
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_18_s_2 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_18_s_2 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_18_s_7 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_18_s_7 $&a $&b
alter Vc dc = 1e-8
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_18_s_3 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_18_s_3 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_18_s_8 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_18_s_8 $&a $&b
alter Vc dc = 1e-6
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_18_s_4 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_18_s_4 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_18_s_9 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_18_s_9 $&a $&b
alter Vc dc = 1e-5
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_18_s_5 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_18_s_5 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_18_s_10 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_18_s_10 $&a $&b
alter Vc dc = 1e-7
op
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_18_s_11 $&a $&b
alter Vxa1 dc = 1.8
alter Vxa3 dc = 1.8
alter Vxb1 dc = 1.8
alter Vxb3 dc = 1.8
alter Vg dc = 0
alter Vc dc = 0
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_18_u_0 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_18_u_0 $&a $&b
alter Vc dc = 1e-12
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_18_u_1 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_18_u_1 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_18_u_6 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_18_u_6 $&a $&b
alter Vc dc = 1e-10
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_18_u_2 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_18_u_2 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_18_u_7 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_18_u_7 $&a $&b
alter Vc dc = 1e-8
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_18_u_3 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_18_u_3 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_18_u_8 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_18_u_8 $&a $&b
alter Vc dc = 1e-6
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_18_u_4 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_18_u_4 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_18_u_9 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_18_u_9 $&a $&b
alter Vc dc = 1e-5
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_18_u_5 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_18_u_5 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_18_u_10 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_18_u_10 $&a $&b
alter Vxa1 dc = 0.9
alter Vxa3 dc = 0.9
alter Vxb1 dc = 0.9
alter Vxb3 dc = 0.9
alter Vg dc = 1.8
alter Vc dc = 0
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_09_s_0 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_09_s_0 $&a $&b
alter Vc dc = 1e-12
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_09_s_1 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_09_s_1 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_09_s_6 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_09_s_6 $&a $&b
alter Vc dc = 1e-10
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_09_s_2 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_09_s_2 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_09_s_7 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_09_s_7 $&a $&b
alter Vc dc = 1e-8
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_09_s_3 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_09_s_3 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_09_s_8 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_09_s_8 $&a $&b
alter Vc dc = 1e-6
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_09_s_4 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_09_s_4 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_09_s_9 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_09_s_9 $&a $&b
alter Vc dc = 1e-5
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_09_s_5 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_09_s_5 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_09_s_10 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_09_s_10 $&a $&b
alter Vxa1 dc = 0.9
alter Vxa3 dc = 0.9
alter Vxb1 dc = 0.9
alter Vxb3 dc = 0.9
alter Vg dc = 0
alter Vc dc = 0
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_09_u_0 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_09_u_0 $&a $&b
alter Vc dc = 1e-12
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_09_u_1 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_09_u_1 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_09_u_6 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_09_u_6 $&a $&b
alter Vc dc = 1e-10
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_09_u_2 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_09_u_2 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_09_u_7 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_09_u_7 $&a $&b
alter Vc dc = 1e-8
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_09_u_3 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_09_u_3 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_09_u_8 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_09_u_8 $&a $&b
alter Vc dc = 1e-6
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_09_u_4 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_09_u_4 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_09_u_9 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_09_u_9 $&a $&b
alter Vc dc = 1e-5
op
let a = v(ja1)
let b = -i(Vxa1)
echo K ff 85 A_09_u_5 $&a $&b
let a = v(xb1)-v(jb1)
let b = -i(Vxb1)
echo K ff 85 B_09_u_5 $&a $&b
let a = v(ja3)
let b = -i(Vxa3)
echo K ff 85 A_09_u_10 $&a $&b
let a = v(xb3)-v(jb3)
let b = -i(Vxb3)
echo K ff 85 B_09_u_10 $&a $&b
quit
.endc
.end
