* MISFIT-15 puesto de XC-20, esquina tt 27 C. Generado por gen.py
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.options gmin=1e-18 abstol=1e-18 reltol=1e-6
.temp 27
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

VxA_18_s_0 xA_18_s_0 0 1.8
VgA_18_s_0 gA_18_s_0 0 1.8
XsA_18_s_0 xA_18_s_0 gA_18_s_0 jA_18_s_0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_s_0 0 jA_18_s_0 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
VxA_18_s_1 xA_18_s_1 0 1.8
VgA_18_s_1 gA_18_s_1 0 1.8
XsA_18_s_1 xA_18_s_1 gA_18_s_1 jA_18_s_1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_s_1 0 jA_18_s_1 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_s_1 jA_18_s_1 0 I = 1p*(max(v(jA_18_s_1,0),0)/1.8)
VxA_18_s_2 xA_18_s_2 0 1.8
VgA_18_s_2 gA_18_s_2 0 1.8
XsA_18_s_2 xA_18_s_2 gA_18_s_2 jA_18_s_2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_s_2 0 jA_18_s_2 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_s_2 jA_18_s_2 0 I = 100p*(max(v(jA_18_s_2,0),0)/1.8)
VxA_18_s_3 xA_18_s_3 0 1.8
VgA_18_s_3 gA_18_s_3 0 1.8
XsA_18_s_3 xA_18_s_3 gA_18_s_3 jA_18_s_3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_s_3 0 jA_18_s_3 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_s_3 jA_18_s_3 0 I = 10n*(max(v(jA_18_s_3,0),0)/1.8)
VxA_18_s_4 xA_18_s_4 0 1.8
VgA_18_s_4 gA_18_s_4 0 1.8
XsA_18_s_4 xA_18_s_4 gA_18_s_4 jA_18_s_4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_s_4 0 jA_18_s_4 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_s_4 jA_18_s_4 0 I = 1u*(max(v(jA_18_s_4,0),0)/1.8)
VxA_18_s_5 xA_18_s_5 0 1.8
VgA_18_s_5 gA_18_s_5 0 1.8
XsA_18_s_5 xA_18_s_5 gA_18_s_5 jA_18_s_5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_s_5 0 jA_18_s_5 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_s_5 jA_18_s_5 0 I = 10u*(max(v(jA_18_s_5,0),0)/1.8)
VxA_18_s_6 xA_18_s_6 0 1.8
VgA_18_s_6 gA_18_s_6 0 1.8
XsA_18_s_6 xA_18_s_6 gA_18_s_6 jA_18_s_6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_s_6 0 jA_18_s_6 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_s_6 jA_18_s_6 0 I = 1p*(max(v(jA_18_s_6,0),0)/1.8)*(max(v(jA_18_s_6,0),0)/1.8)*(max(v(jA_18_s_6,0),0)/1.8)
VxA_18_s_7 xA_18_s_7 0 1.8
VgA_18_s_7 gA_18_s_7 0 1.8
XsA_18_s_7 xA_18_s_7 gA_18_s_7 jA_18_s_7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_s_7 0 jA_18_s_7 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_s_7 jA_18_s_7 0 I = 100p*(max(v(jA_18_s_7,0),0)/1.8)*(max(v(jA_18_s_7,0),0)/1.8)*(max(v(jA_18_s_7,0),0)/1.8)
VxA_18_s_8 xA_18_s_8 0 1.8
VgA_18_s_8 gA_18_s_8 0 1.8
XsA_18_s_8 xA_18_s_8 gA_18_s_8 jA_18_s_8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_s_8 0 jA_18_s_8 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_s_8 jA_18_s_8 0 I = 10n*(max(v(jA_18_s_8,0),0)/1.8)*(max(v(jA_18_s_8,0),0)/1.8)*(max(v(jA_18_s_8,0),0)/1.8)
VxA_18_s_9 xA_18_s_9 0 1.8
VgA_18_s_9 gA_18_s_9 0 1.8
XsA_18_s_9 xA_18_s_9 gA_18_s_9 jA_18_s_9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_s_9 0 jA_18_s_9 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_s_9 jA_18_s_9 0 I = 1u*(max(v(jA_18_s_9,0),0)/1.8)*(max(v(jA_18_s_9,0),0)/1.8)*(max(v(jA_18_s_9,0),0)/1.8)
VxA_18_s_10 xA_18_s_10 0 1.8
VgA_18_s_10 gA_18_s_10 0 1.8
XsA_18_s_10 xA_18_s_10 gA_18_s_10 jA_18_s_10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_s_10 0 jA_18_s_10 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_s_10 jA_18_s_10 0 I = 10u*(max(v(jA_18_s_10,0),0)/1.8)*(max(v(jA_18_s_10,0),0)/1.8)*(max(v(jA_18_s_10,0),0)/1.8)
VxA_18_u_0 xA_18_u_0 0 1.8
VgA_18_u_0 gA_18_u_0 0 0
XsA_18_u_0 xA_18_u_0 gA_18_u_0 jA_18_u_0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_u_0 0 jA_18_u_0 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
VxA_18_u_1 xA_18_u_1 0 1.8
VgA_18_u_1 gA_18_u_1 0 0
XsA_18_u_1 xA_18_u_1 gA_18_u_1 jA_18_u_1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_u_1 0 jA_18_u_1 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_u_1 jA_18_u_1 0 I = 1p*(max(v(jA_18_u_1,0),0)/1.8)
VxA_18_u_2 xA_18_u_2 0 1.8
VgA_18_u_2 gA_18_u_2 0 0
XsA_18_u_2 xA_18_u_2 gA_18_u_2 jA_18_u_2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_u_2 0 jA_18_u_2 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_u_2 jA_18_u_2 0 I = 100p*(max(v(jA_18_u_2,0),0)/1.8)
VxA_18_u_3 xA_18_u_3 0 1.8
VgA_18_u_3 gA_18_u_3 0 0
XsA_18_u_3 xA_18_u_3 gA_18_u_3 jA_18_u_3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_u_3 0 jA_18_u_3 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_u_3 jA_18_u_3 0 I = 10n*(max(v(jA_18_u_3,0),0)/1.8)
VxA_18_u_4 xA_18_u_4 0 1.8
VgA_18_u_4 gA_18_u_4 0 0
XsA_18_u_4 xA_18_u_4 gA_18_u_4 jA_18_u_4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_u_4 0 jA_18_u_4 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_u_4 jA_18_u_4 0 I = 1u*(max(v(jA_18_u_4,0),0)/1.8)
VxA_18_u_5 xA_18_u_5 0 1.8
VgA_18_u_5 gA_18_u_5 0 0
XsA_18_u_5 xA_18_u_5 gA_18_u_5 jA_18_u_5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_u_5 0 jA_18_u_5 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_u_5 jA_18_u_5 0 I = 10u*(max(v(jA_18_u_5,0),0)/1.8)
VxA_18_u_6 xA_18_u_6 0 1.8
VgA_18_u_6 gA_18_u_6 0 0
XsA_18_u_6 xA_18_u_6 gA_18_u_6 jA_18_u_6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_u_6 0 jA_18_u_6 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_u_6 jA_18_u_6 0 I = 1p*(max(v(jA_18_u_6,0),0)/1.8)*(max(v(jA_18_u_6,0),0)/1.8)*(max(v(jA_18_u_6,0),0)/1.8)
VxA_18_u_7 xA_18_u_7 0 1.8
VgA_18_u_7 gA_18_u_7 0 0
XsA_18_u_7 xA_18_u_7 gA_18_u_7 jA_18_u_7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_u_7 0 jA_18_u_7 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_u_7 jA_18_u_7 0 I = 100p*(max(v(jA_18_u_7,0),0)/1.8)*(max(v(jA_18_u_7,0),0)/1.8)*(max(v(jA_18_u_7,0),0)/1.8)
VxA_18_u_8 xA_18_u_8 0 1.8
VgA_18_u_8 gA_18_u_8 0 0
XsA_18_u_8 xA_18_u_8 gA_18_u_8 jA_18_u_8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_u_8 0 jA_18_u_8 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_u_8 jA_18_u_8 0 I = 10n*(max(v(jA_18_u_8,0),0)/1.8)*(max(v(jA_18_u_8,0),0)/1.8)*(max(v(jA_18_u_8,0),0)/1.8)
VxA_18_u_9 xA_18_u_9 0 1.8
VgA_18_u_9 gA_18_u_9 0 0
XsA_18_u_9 xA_18_u_9 gA_18_u_9 jA_18_u_9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_u_9 0 jA_18_u_9 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_u_9 jA_18_u_9 0 I = 1u*(max(v(jA_18_u_9,0),0)/1.8)*(max(v(jA_18_u_9,0),0)/1.8)*(max(v(jA_18_u_9,0),0)/1.8)
VxA_18_u_10 xA_18_u_10 0 1.8
VgA_18_u_10 gA_18_u_10 0 0
XsA_18_u_10 xA_18_u_10 gA_18_u_10 jA_18_u_10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_18_u_10 0 jA_18_u_10 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_18_u_10 jA_18_u_10 0 I = 10u*(max(v(jA_18_u_10,0),0)/1.8)*(max(v(jA_18_u_10,0),0)/1.8)*(max(v(jA_18_u_10,0),0)/1.8)
VxA_09_s_0 xA_09_s_0 0 0.9
VgA_09_s_0 gA_09_s_0 0 1.8
XsA_09_s_0 xA_09_s_0 gA_09_s_0 jA_09_s_0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_s_0 0 jA_09_s_0 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
VxA_09_s_1 xA_09_s_1 0 0.9
VgA_09_s_1 gA_09_s_1 0 1.8
XsA_09_s_1 xA_09_s_1 gA_09_s_1 jA_09_s_1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_s_1 0 jA_09_s_1 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_s_1 jA_09_s_1 0 I = 1p*(max(v(jA_09_s_1,0),0)/1.8)
VxA_09_s_2 xA_09_s_2 0 0.9
VgA_09_s_2 gA_09_s_2 0 1.8
XsA_09_s_2 xA_09_s_2 gA_09_s_2 jA_09_s_2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_s_2 0 jA_09_s_2 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_s_2 jA_09_s_2 0 I = 100p*(max(v(jA_09_s_2,0),0)/1.8)
VxA_09_s_3 xA_09_s_3 0 0.9
VgA_09_s_3 gA_09_s_3 0 1.8
XsA_09_s_3 xA_09_s_3 gA_09_s_3 jA_09_s_3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_s_3 0 jA_09_s_3 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_s_3 jA_09_s_3 0 I = 10n*(max(v(jA_09_s_3,0),0)/1.8)
VxA_09_s_4 xA_09_s_4 0 0.9
VgA_09_s_4 gA_09_s_4 0 1.8
XsA_09_s_4 xA_09_s_4 gA_09_s_4 jA_09_s_4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_s_4 0 jA_09_s_4 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_s_4 jA_09_s_4 0 I = 1u*(max(v(jA_09_s_4,0),0)/1.8)
VxA_09_s_5 xA_09_s_5 0 0.9
VgA_09_s_5 gA_09_s_5 0 1.8
XsA_09_s_5 xA_09_s_5 gA_09_s_5 jA_09_s_5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_s_5 0 jA_09_s_5 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_s_5 jA_09_s_5 0 I = 10u*(max(v(jA_09_s_5,0),0)/1.8)
VxA_09_s_6 xA_09_s_6 0 0.9
VgA_09_s_6 gA_09_s_6 0 1.8
XsA_09_s_6 xA_09_s_6 gA_09_s_6 jA_09_s_6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_s_6 0 jA_09_s_6 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_s_6 jA_09_s_6 0 I = 1p*(max(v(jA_09_s_6,0),0)/1.8)*(max(v(jA_09_s_6,0),0)/1.8)*(max(v(jA_09_s_6,0),0)/1.8)
VxA_09_s_7 xA_09_s_7 0 0.9
VgA_09_s_7 gA_09_s_7 0 1.8
XsA_09_s_7 xA_09_s_7 gA_09_s_7 jA_09_s_7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_s_7 0 jA_09_s_7 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_s_7 jA_09_s_7 0 I = 100p*(max(v(jA_09_s_7,0),0)/1.8)*(max(v(jA_09_s_7,0),0)/1.8)*(max(v(jA_09_s_7,0),0)/1.8)
VxA_09_s_8 xA_09_s_8 0 0.9
VgA_09_s_8 gA_09_s_8 0 1.8
XsA_09_s_8 xA_09_s_8 gA_09_s_8 jA_09_s_8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_s_8 0 jA_09_s_8 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_s_8 jA_09_s_8 0 I = 10n*(max(v(jA_09_s_8,0),0)/1.8)*(max(v(jA_09_s_8,0),0)/1.8)*(max(v(jA_09_s_8,0),0)/1.8)
VxA_09_s_9 xA_09_s_9 0 0.9
VgA_09_s_9 gA_09_s_9 0 1.8
XsA_09_s_9 xA_09_s_9 gA_09_s_9 jA_09_s_9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_s_9 0 jA_09_s_9 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_s_9 jA_09_s_9 0 I = 1u*(max(v(jA_09_s_9,0),0)/1.8)*(max(v(jA_09_s_9,0),0)/1.8)*(max(v(jA_09_s_9,0),0)/1.8)
VxA_09_s_10 xA_09_s_10 0 0.9
VgA_09_s_10 gA_09_s_10 0 1.8
XsA_09_s_10 xA_09_s_10 gA_09_s_10 jA_09_s_10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_s_10 0 jA_09_s_10 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_s_10 jA_09_s_10 0 I = 10u*(max(v(jA_09_s_10,0),0)/1.8)*(max(v(jA_09_s_10,0),0)/1.8)*(max(v(jA_09_s_10,0),0)/1.8)
VxA_09_u_0 xA_09_u_0 0 0.9
VgA_09_u_0 gA_09_u_0 0 0
XsA_09_u_0 xA_09_u_0 gA_09_u_0 jA_09_u_0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_u_0 0 jA_09_u_0 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
VxA_09_u_1 xA_09_u_1 0 0.9
VgA_09_u_1 gA_09_u_1 0 0
XsA_09_u_1 xA_09_u_1 gA_09_u_1 jA_09_u_1 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_u_1 0 jA_09_u_1 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_u_1 jA_09_u_1 0 I = 1p*(max(v(jA_09_u_1,0),0)/1.8)
VxA_09_u_2 xA_09_u_2 0 0.9
VgA_09_u_2 gA_09_u_2 0 0
XsA_09_u_2 xA_09_u_2 gA_09_u_2 jA_09_u_2 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_u_2 0 jA_09_u_2 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_u_2 jA_09_u_2 0 I = 100p*(max(v(jA_09_u_2,0),0)/1.8)
VxA_09_u_3 xA_09_u_3 0 0.9
VgA_09_u_3 gA_09_u_3 0 0
XsA_09_u_3 xA_09_u_3 gA_09_u_3 jA_09_u_3 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_u_3 0 jA_09_u_3 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_u_3 jA_09_u_3 0 I = 10n*(max(v(jA_09_u_3,0),0)/1.8)
VxA_09_u_4 xA_09_u_4 0 0.9
VgA_09_u_4 gA_09_u_4 0 0
XsA_09_u_4 xA_09_u_4 gA_09_u_4 jA_09_u_4 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_u_4 0 jA_09_u_4 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_u_4 jA_09_u_4 0 I = 1u*(max(v(jA_09_u_4,0),0)/1.8)
VxA_09_u_5 xA_09_u_5 0 0.9
VgA_09_u_5 gA_09_u_5 0 0
XsA_09_u_5 xA_09_u_5 gA_09_u_5 jA_09_u_5 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_u_5 0 jA_09_u_5 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_u_5 jA_09_u_5 0 I = 10u*(max(v(jA_09_u_5,0),0)/1.8)
VxA_09_u_6 xA_09_u_6 0 0.9
VgA_09_u_6 gA_09_u_6 0 0
XsA_09_u_6 xA_09_u_6 gA_09_u_6 jA_09_u_6 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_u_6 0 jA_09_u_6 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_u_6 jA_09_u_6 0 I = 1p*(max(v(jA_09_u_6,0),0)/1.8)*(max(v(jA_09_u_6,0),0)/1.8)*(max(v(jA_09_u_6,0),0)/1.8)
VxA_09_u_7 xA_09_u_7 0 0.9
VgA_09_u_7 gA_09_u_7 0 0
XsA_09_u_7 xA_09_u_7 gA_09_u_7 jA_09_u_7 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_u_7 0 jA_09_u_7 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_u_7 jA_09_u_7 0 I = 100p*(max(v(jA_09_u_7,0),0)/1.8)*(max(v(jA_09_u_7,0),0)/1.8)*(max(v(jA_09_u_7,0),0)/1.8)
VxA_09_u_8 xA_09_u_8 0 0.9
VgA_09_u_8 gA_09_u_8 0 0
XsA_09_u_8 xA_09_u_8 gA_09_u_8 jA_09_u_8 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_u_8 0 jA_09_u_8 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_u_8 jA_09_u_8 0 I = 10n*(max(v(jA_09_u_8,0),0)/1.8)*(max(v(jA_09_u_8,0),0)/1.8)*(max(v(jA_09_u_8,0),0)/1.8)
VxA_09_u_9 xA_09_u_9 0 0.9
VgA_09_u_9 gA_09_u_9 0 0
XsA_09_u_9 xA_09_u_9 gA_09_u_9 jA_09_u_9 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_u_9 0 jA_09_u_9 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_u_9 jA_09_u_9 0 I = 1u*(max(v(jA_09_u_9,0),0)/1.8)*(max(v(jA_09_u_9,0),0)/1.8)*(max(v(jA_09_u_9,0),0)/1.8)
VxA_09_u_10 xA_09_u_10 0 0.9
VgA_09_u_10 gA_09_u_10 0 0
XsA_09_u_10 xA_09_u_10 gA_09_u_10 jA_09_u_10 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdA_09_u_10 0 jA_09_u_10 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
BA_09_u_10 jA_09_u_10 0 I = 10u*(max(v(jA_09_u_10,0),0)/1.8)*(max(v(jA_09_u_10,0),0)/1.8)*(max(v(jA_09_u_10,0),0)/1.8)
VxB_18_s_0 xB_18_s_0 0 1.8
VgB_18_s_0 gB_18_s_0 0 1.8
XsB_18_s_0 jB_18_s_0 gB_18_s_0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_s_0 jB_18_s_0 xB_18_s_0 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
VxB_18_s_1 xB_18_s_1 0 1.8
VgB_18_s_1 gB_18_s_1 0 1.8
XsB_18_s_1 jB_18_s_1 gB_18_s_1 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_s_1 jB_18_s_1 xB_18_s_1 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_s_1 xB_18_s_1 jB_18_s_1 I = 1p*(max(v(xB_18_s_1,jB_18_s_1),0)/1.8)
VxB_18_s_2 xB_18_s_2 0 1.8
VgB_18_s_2 gB_18_s_2 0 1.8
XsB_18_s_2 jB_18_s_2 gB_18_s_2 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_s_2 jB_18_s_2 xB_18_s_2 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_s_2 xB_18_s_2 jB_18_s_2 I = 100p*(max(v(xB_18_s_2,jB_18_s_2),0)/1.8)
VxB_18_s_3 xB_18_s_3 0 1.8
VgB_18_s_3 gB_18_s_3 0 1.8
XsB_18_s_3 jB_18_s_3 gB_18_s_3 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_s_3 jB_18_s_3 xB_18_s_3 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_s_3 xB_18_s_3 jB_18_s_3 I = 10n*(max(v(xB_18_s_3,jB_18_s_3),0)/1.8)
VxB_18_s_4 xB_18_s_4 0 1.8
VgB_18_s_4 gB_18_s_4 0 1.8
XsB_18_s_4 jB_18_s_4 gB_18_s_4 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_s_4 jB_18_s_4 xB_18_s_4 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_s_4 xB_18_s_4 jB_18_s_4 I = 1u*(max(v(xB_18_s_4,jB_18_s_4),0)/1.8)
VxB_18_s_5 xB_18_s_5 0 1.8
VgB_18_s_5 gB_18_s_5 0 1.8
XsB_18_s_5 jB_18_s_5 gB_18_s_5 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_s_5 jB_18_s_5 xB_18_s_5 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_s_5 xB_18_s_5 jB_18_s_5 I = 10u*(max(v(xB_18_s_5,jB_18_s_5),0)/1.8)
VxB_18_s_6 xB_18_s_6 0 1.8
VgB_18_s_6 gB_18_s_6 0 1.8
XsB_18_s_6 jB_18_s_6 gB_18_s_6 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_s_6 jB_18_s_6 xB_18_s_6 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_s_6 xB_18_s_6 jB_18_s_6 I = 1p*(max(v(xB_18_s_6,jB_18_s_6),0)/1.8)*(max(v(xB_18_s_6,jB_18_s_6),0)/1.8)*(max(v(xB_18_s_6,jB_18_s_6),0)/1.8)
VxB_18_s_7 xB_18_s_7 0 1.8
VgB_18_s_7 gB_18_s_7 0 1.8
XsB_18_s_7 jB_18_s_7 gB_18_s_7 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_s_7 jB_18_s_7 xB_18_s_7 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_s_7 xB_18_s_7 jB_18_s_7 I = 100p*(max(v(xB_18_s_7,jB_18_s_7),0)/1.8)*(max(v(xB_18_s_7,jB_18_s_7),0)/1.8)*(max(v(xB_18_s_7,jB_18_s_7),0)/1.8)
VxB_18_s_8 xB_18_s_8 0 1.8
VgB_18_s_8 gB_18_s_8 0 1.8
XsB_18_s_8 jB_18_s_8 gB_18_s_8 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_s_8 jB_18_s_8 xB_18_s_8 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_s_8 xB_18_s_8 jB_18_s_8 I = 10n*(max(v(xB_18_s_8,jB_18_s_8),0)/1.8)*(max(v(xB_18_s_8,jB_18_s_8),0)/1.8)*(max(v(xB_18_s_8,jB_18_s_8),0)/1.8)
VxB_18_s_9 xB_18_s_9 0 1.8
VgB_18_s_9 gB_18_s_9 0 1.8
XsB_18_s_9 jB_18_s_9 gB_18_s_9 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_s_9 jB_18_s_9 xB_18_s_9 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_s_9 xB_18_s_9 jB_18_s_9 I = 1u*(max(v(xB_18_s_9,jB_18_s_9),0)/1.8)*(max(v(xB_18_s_9,jB_18_s_9),0)/1.8)*(max(v(xB_18_s_9,jB_18_s_9),0)/1.8)
VxB_18_s_10 xB_18_s_10 0 1.8
VgB_18_s_10 gB_18_s_10 0 1.8
XsB_18_s_10 jB_18_s_10 gB_18_s_10 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_s_10 jB_18_s_10 xB_18_s_10 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_s_10 xB_18_s_10 jB_18_s_10 I = 10u*(max(v(xB_18_s_10,jB_18_s_10),0)/1.8)*(max(v(xB_18_s_10,jB_18_s_10),0)/1.8)*(max(v(xB_18_s_10,jB_18_s_10),0)/1.8)
VxB_18_s_11 xB_18_s_11 0 1.8
VgB_18_s_11 gB_18_s_11 0 1.8
XsB_18_s_11 jB_18_s_11 gB_18_s_11 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_s_11 jB_18_s_11 xB_18_s_11 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_s_11 xB_18_s_11 jB_18_s_11 I = 100n*(max(v(xB_18_s_11,jB_18_s_11),0)/1.8)
VxB_18_u_0 xB_18_u_0 0 1.8
VgB_18_u_0 gB_18_u_0 0 0
XsB_18_u_0 jB_18_u_0 gB_18_u_0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_u_0 jB_18_u_0 xB_18_u_0 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
VxB_18_u_1 xB_18_u_1 0 1.8
VgB_18_u_1 gB_18_u_1 0 0
XsB_18_u_1 jB_18_u_1 gB_18_u_1 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_u_1 jB_18_u_1 xB_18_u_1 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_u_1 xB_18_u_1 jB_18_u_1 I = 1p*(max(v(xB_18_u_1,jB_18_u_1),0)/1.8)
VxB_18_u_2 xB_18_u_2 0 1.8
VgB_18_u_2 gB_18_u_2 0 0
XsB_18_u_2 jB_18_u_2 gB_18_u_2 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_u_2 jB_18_u_2 xB_18_u_2 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_u_2 xB_18_u_2 jB_18_u_2 I = 100p*(max(v(xB_18_u_2,jB_18_u_2),0)/1.8)
VxB_18_u_3 xB_18_u_3 0 1.8
VgB_18_u_3 gB_18_u_3 0 0
XsB_18_u_3 jB_18_u_3 gB_18_u_3 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_u_3 jB_18_u_3 xB_18_u_3 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_u_3 xB_18_u_3 jB_18_u_3 I = 10n*(max(v(xB_18_u_3,jB_18_u_3),0)/1.8)
VxB_18_u_4 xB_18_u_4 0 1.8
VgB_18_u_4 gB_18_u_4 0 0
XsB_18_u_4 jB_18_u_4 gB_18_u_4 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_u_4 jB_18_u_4 xB_18_u_4 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_u_4 xB_18_u_4 jB_18_u_4 I = 1u*(max(v(xB_18_u_4,jB_18_u_4),0)/1.8)
VxB_18_u_5 xB_18_u_5 0 1.8
VgB_18_u_5 gB_18_u_5 0 0
XsB_18_u_5 jB_18_u_5 gB_18_u_5 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_u_5 jB_18_u_5 xB_18_u_5 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_u_5 xB_18_u_5 jB_18_u_5 I = 10u*(max(v(xB_18_u_5,jB_18_u_5),0)/1.8)
VxB_18_u_6 xB_18_u_6 0 1.8
VgB_18_u_6 gB_18_u_6 0 0
XsB_18_u_6 jB_18_u_6 gB_18_u_6 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_u_6 jB_18_u_6 xB_18_u_6 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_u_6 xB_18_u_6 jB_18_u_6 I = 1p*(max(v(xB_18_u_6,jB_18_u_6),0)/1.8)*(max(v(xB_18_u_6,jB_18_u_6),0)/1.8)*(max(v(xB_18_u_6,jB_18_u_6),0)/1.8)
VxB_18_u_7 xB_18_u_7 0 1.8
VgB_18_u_7 gB_18_u_7 0 0
XsB_18_u_7 jB_18_u_7 gB_18_u_7 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_u_7 jB_18_u_7 xB_18_u_7 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_u_7 xB_18_u_7 jB_18_u_7 I = 100p*(max(v(xB_18_u_7,jB_18_u_7),0)/1.8)*(max(v(xB_18_u_7,jB_18_u_7),0)/1.8)*(max(v(xB_18_u_7,jB_18_u_7),0)/1.8)
VxB_18_u_8 xB_18_u_8 0 1.8
VgB_18_u_8 gB_18_u_8 0 0
XsB_18_u_8 jB_18_u_8 gB_18_u_8 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_u_8 jB_18_u_8 xB_18_u_8 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_u_8 xB_18_u_8 jB_18_u_8 I = 10n*(max(v(xB_18_u_8,jB_18_u_8),0)/1.8)*(max(v(xB_18_u_8,jB_18_u_8),0)/1.8)*(max(v(xB_18_u_8,jB_18_u_8),0)/1.8)
VxB_18_u_9 xB_18_u_9 0 1.8
VgB_18_u_9 gB_18_u_9 0 0
XsB_18_u_9 jB_18_u_9 gB_18_u_9 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_u_9 jB_18_u_9 xB_18_u_9 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_u_9 xB_18_u_9 jB_18_u_9 I = 1u*(max(v(xB_18_u_9,jB_18_u_9),0)/1.8)*(max(v(xB_18_u_9,jB_18_u_9),0)/1.8)*(max(v(xB_18_u_9,jB_18_u_9),0)/1.8)
VxB_18_u_10 xB_18_u_10 0 1.8
VgB_18_u_10 gB_18_u_10 0 0
XsB_18_u_10 jB_18_u_10 gB_18_u_10 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_18_u_10 jB_18_u_10 xB_18_u_10 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_18_u_10 xB_18_u_10 jB_18_u_10 I = 10u*(max(v(xB_18_u_10,jB_18_u_10),0)/1.8)*(max(v(xB_18_u_10,jB_18_u_10),0)/1.8)*(max(v(xB_18_u_10,jB_18_u_10),0)/1.8)
VxB_09_s_0 xB_09_s_0 0 0.9
VgB_09_s_0 gB_09_s_0 0 1.8
XsB_09_s_0 jB_09_s_0 gB_09_s_0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_s_0 jB_09_s_0 xB_09_s_0 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
VxB_09_s_1 xB_09_s_1 0 0.9
VgB_09_s_1 gB_09_s_1 0 1.8
XsB_09_s_1 jB_09_s_1 gB_09_s_1 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_s_1 jB_09_s_1 xB_09_s_1 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_s_1 xB_09_s_1 jB_09_s_1 I = 1p*(max(v(xB_09_s_1,jB_09_s_1),0)/1.8)
VxB_09_s_2 xB_09_s_2 0 0.9
VgB_09_s_2 gB_09_s_2 0 1.8
XsB_09_s_2 jB_09_s_2 gB_09_s_2 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_s_2 jB_09_s_2 xB_09_s_2 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_s_2 xB_09_s_2 jB_09_s_2 I = 100p*(max(v(xB_09_s_2,jB_09_s_2),0)/1.8)
VxB_09_s_3 xB_09_s_3 0 0.9
VgB_09_s_3 gB_09_s_3 0 1.8
XsB_09_s_3 jB_09_s_3 gB_09_s_3 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_s_3 jB_09_s_3 xB_09_s_3 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_s_3 xB_09_s_3 jB_09_s_3 I = 10n*(max(v(xB_09_s_3,jB_09_s_3),0)/1.8)
VxB_09_s_4 xB_09_s_4 0 0.9
VgB_09_s_4 gB_09_s_4 0 1.8
XsB_09_s_4 jB_09_s_4 gB_09_s_4 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_s_4 jB_09_s_4 xB_09_s_4 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_s_4 xB_09_s_4 jB_09_s_4 I = 1u*(max(v(xB_09_s_4,jB_09_s_4),0)/1.8)
VxB_09_s_5 xB_09_s_5 0 0.9
VgB_09_s_5 gB_09_s_5 0 1.8
XsB_09_s_5 jB_09_s_5 gB_09_s_5 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_s_5 jB_09_s_5 xB_09_s_5 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_s_5 xB_09_s_5 jB_09_s_5 I = 10u*(max(v(xB_09_s_5,jB_09_s_5),0)/1.8)
VxB_09_s_6 xB_09_s_6 0 0.9
VgB_09_s_6 gB_09_s_6 0 1.8
XsB_09_s_6 jB_09_s_6 gB_09_s_6 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_s_6 jB_09_s_6 xB_09_s_6 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_s_6 xB_09_s_6 jB_09_s_6 I = 1p*(max(v(xB_09_s_6,jB_09_s_6),0)/1.8)*(max(v(xB_09_s_6,jB_09_s_6),0)/1.8)*(max(v(xB_09_s_6,jB_09_s_6),0)/1.8)
VxB_09_s_7 xB_09_s_7 0 0.9
VgB_09_s_7 gB_09_s_7 0 1.8
XsB_09_s_7 jB_09_s_7 gB_09_s_7 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_s_7 jB_09_s_7 xB_09_s_7 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_s_7 xB_09_s_7 jB_09_s_7 I = 100p*(max(v(xB_09_s_7,jB_09_s_7),0)/1.8)*(max(v(xB_09_s_7,jB_09_s_7),0)/1.8)*(max(v(xB_09_s_7,jB_09_s_7),0)/1.8)
VxB_09_s_8 xB_09_s_8 0 0.9
VgB_09_s_8 gB_09_s_8 0 1.8
XsB_09_s_8 jB_09_s_8 gB_09_s_8 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_s_8 jB_09_s_8 xB_09_s_8 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_s_8 xB_09_s_8 jB_09_s_8 I = 10n*(max(v(xB_09_s_8,jB_09_s_8),0)/1.8)*(max(v(xB_09_s_8,jB_09_s_8),0)/1.8)*(max(v(xB_09_s_8,jB_09_s_8),0)/1.8)
VxB_09_s_9 xB_09_s_9 0 0.9
VgB_09_s_9 gB_09_s_9 0 1.8
XsB_09_s_9 jB_09_s_9 gB_09_s_9 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_s_9 jB_09_s_9 xB_09_s_9 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_s_9 xB_09_s_9 jB_09_s_9 I = 1u*(max(v(xB_09_s_9,jB_09_s_9),0)/1.8)*(max(v(xB_09_s_9,jB_09_s_9),0)/1.8)*(max(v(xB_09_s_9,jB_09_s_9),0)/1.8)
VxB_09_s_10 xB_09_s_10 0 0.9
VgB_09_s_10 gB_09_s_10 0 1.8
XsB_09_s_10 jB_09_s_10 gB_09_s_10 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_s_10 jB_09_s_10 xB_09_s_10 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_s_10 xB_09_s_10 jB_09_s_10 I = 10u*(max(v(xB_09_s_10,jB_09_s_10),0)/1.8)*(max(v(xB_09_s_10,jB_09_s_10),0)/1.8)*(max(v(xB_09_s_10,jB_09_s_10),0)/1.8)
VxB_09_u_0 xB_09_u_0 0 0.9
VgB_09_u_0 gB_09_u_0 0 0
XsB_09_u_0 jB_09_u_0 gB_09_u_0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_u_0 jB_09_u_0 xB_09_u_0 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
VxB_09_u_1 xB_09_u_1 0 0.9
VgB_09_u_1 gB_09_u_1 0 0
XsB_09_u_1 jB_09_u_1 gB_09_u_1 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_u_1 jB_09_u_1 xB_09_u_1 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_u_1 xB_09_u_1 jB_09_u_1 I = 1p*(max(v(xB_09_u_1,jB_09_u_1),0)/1.8)
VxB_09_u_2 xB_09_u_2 0 0.9
VgB_09_u_2 gB_09_u_2 0 0
XsB_09_u_2 jB_09_u_2 gB_09_u_2 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_u_2 jB_09_u_2 xB_09_u_2 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_u_2 xB_09_u_2 jB_09_u_2 I = 100p*(max(v(xB_09_u_2,jB_09_u_2),0)/1.8)
VxB_09_u_3 xB_09_u_3 0 0.9
VgB_09_u_3 gB_09_u_3 0 0
XsB_09_u_3 jB_09_u_3 gB_09_u_3 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_u_3 jB_09_u_3 xB_09_u_3 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_u_3 xB_09_u_3 jB_09_u_3 I = 10n*(max(v(xB_09_u_3,jB_09_u_3),0)/1.8)
VxB_09_u_4 xB_09_u_4 0 0.9
VgB_09_u_4 gB_09_u_4 0 0
XsB_09_u_4 jB_09_u_4 gB_09_u_4 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_u_4 jB_09_u_4 xB_09_u_4 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_u_4 xB_09_u_4 jB_09_u_4 I = 1u*(max(v(xB_09_u_4,jB_09_u_4),0)/1.8)
VxB_09_u_5 xB_09_u_5 0 0.9
VgB_09_u_5 gB_09_u_5 0 0
XsB_09_u_5 jB_09_u_5 gB_09_u_5 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_u_5 jB_09_u_5 xB_09_u_5 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_u_5 xB_09_u_5 jB_09_u_5 I = 10u*(max(v(xB_09_u_5,jB_09_u_5),0)/1.8)
VxB_09_u_6 xB_09_u_6 0 0.9
VgB_09_u_6 gB_09_u_6 0 0
XsB_09_u_6 jB_09_u_6 gB_09_u_6 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_u_6 jB_09_u_6 xB_09_u_6 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_u_6 xB_09_u_6 jB_09_u_6 I = 1p*(max(v(xB_09_u_6,jB_09_u_6),0)/1.8)*(max(v(xB_09_u_6,jB_09_u_6),0)/1.8)*(max(v(xB_09_u_6,jB_09_u_6),0)/1.8)
VxB_09_u_7 xB_09_u_7 0 0.9
VgB_09_u_7 gB_09_u_7 0 0
XsB_09_u_7 jB_09_u_7 gB_09_u_7 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_u_7 jB_09_u_7 xB_09_u_7 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_u_7 xB_09_u_7 jB_09_u_7 I = 100p*(max(v(xB_09_u_7,jB_09_u_7),0)/1.8)*(max(v(xB_09_u_7,jB_09_u_7),0)/1.8)*(max(v(xB_09_u_7,jB_09_u_7),0)/1.8)
VxB_09_u_8 xB_09_u_8 0 0.9
VgB_09_u_8 gB_09_u_8 0 0
XsB_09_u_8 jB_09_u_8 gB_09_u_8 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_u_8 jB_09_u_8 xB_09_u_8 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_u_8 xB_09_u_8 jB_09_u_8 I = 10n*(max(v(xB_09_u_8,jB_09_u_8),0)/1.8)*(max(v(xB_09_u_8,jB_09_u_8),0)/1.8)*(max(v(xB_09_u_8,jB_09_u_8),0)/1.8)
VxB_09_u_9 xB_09_u_9 0 0.9
VgB_09_u_9 gB_09_u_9 0 0
XsB_09_u_9 jB_09_u_9 gB_09_u_9 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_u_9 jB_09_u_9 xB_09_u_9 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_u_9 xB_09_u_9 jB_09_u_9 I = 1u*(max(v(xB_09_u_9,jB_09_u_9),0)/1.8)*(max(v(xB_09_u_9,jB_09_u_9),0)/1.8)*(max(v(xB_09_u_9,jB_09_u_9),0)/1.8)
VxB_09_u_10 xB_09_u_10 0 0.9
VgB_09_u_10 gB_09_u_10 0 0
XsB_09_u_10 jB_09_u_10 gB_09_u_10 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
XdB_09_u_10 jB_09_u_10 xB_09_u_10 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
BB_09_u_10 xB_09_u_10 jB_09_u_10 I = 10u*(max(v(xB_09_u_10,jB_09_u_10),0)/1.8)*(max(v(xB_09_u_10,jB_09_u_10),0)/1.8)*(max(v(xB_09_u_10,jB_09_u_10),0)/1.8)
Vr1 r1 0 1.8
Xdl1 0 r1 sky130_fd_pr__diode_pw2nd_05v5 perim=4.8e+06 area=1.4e+12
Vr2 r2 0 1.8
Xdl2 0 r2 sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Vxaoff xaoff 0 1.8
Xbusaoff 0 0 0 0 0 0 0 xaoff 0 xc20s
Vxboff xboff 0 1.8
Dwoff 0 xboff sky130_fd_pr__model__parasitic__diode_ps2nw area=112e12 pj=64e6
Xsboff0 jboff0 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdboff0 jboff0 xboff sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xsboff1 jboff1 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdboff1 jboff1 xboff sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xsboff2 jboff2 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdboff2 jboff2 xboff sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xsboff3 jboff3 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdboff3 jboff3 xboff sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xsboff4 jboff4 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdboff4 jboff4 xboff sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xsboff5 jboff5 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdboff5 jboff5 xboff sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xsboff6 jboff6 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdboff6 jboff6 xboff sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Vxaon xaon 0 1.8
Xbusaon vdd 0 0 0 0 0 0 xaon 0 xc20s
Vxbon xbon 0 1.8
Dwon 0 xbon sky130_fd_pr__model__parasitic__diode_ps2nw area=112e12 pj=64e6
Xsbon0 jbon0 vdd 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdbon0 jbon0 xbon sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xsbon1 jbon1 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdbon1 jbon1 xbon sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xsbon2 jbon2 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdbon2 jbon2 xbon sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xsbon3 jbon3 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdbon3 jbon3 xbon sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xsbon4 jbon4 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdbon4 jbon4 xbon sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xsbon5 jbon5 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdbon5 jbon5 xbon sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Xsbon6 jbon6 0 0 0 sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15
Xdbon6 jbon6 xbon sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12
Vd vdd 0 1.8
.control
set noaskquit
op
let a = v(jA_18_s_0)
let b = -i(VxA_18_s_0)
echo K tt 27 A_18_s_0 $&a $&b
let a = v(jA_18_s_1)
let b = -i(VxA_18_s_1)
echo K tt 27 A_18_s_1 $&a $&b
let a = v(jA_18_s_2)
let b = -i(VxA_18_s_2)
echo K tt 27 A_18_s_2 $&a $&b
let a = v(jA_18_s_3)
let b = -i(VxA_18_s_3)
echo K tt 27 A_18_s_3 $&a $&b
let a = v(jA_18_s_4)
let b = -i(VxA_18_s_4)
echo K tt 27 A_18_s_4 $&a $&b
let a = v(jA_18_s_5)
let b = -i(VxA_18_s_5)
echo K tt 27 A_18_s_5 $&a $&b
let a = v(jA_18_s_6)
let b = -i(VxA_18_s_6)
echo K tt 27 A_18_s_6 $&a $&b
let a = v(jA_18_s_7)
let b = -i(VxA_18_s_7)
echo K tt 27 A_18_s_7 $&a $&b
let a = v(jA_18_s_8)
let b = -i(VxA_18_s_8)
echo K tt 27 A_18_s_8 $&a $&b
let a = v(jA_18_s_9)
let b = -i(VxA_18_s_9)
echo K tt 27 A_18_s_9 $&a $&b
let a = v(jA_18_s_10)
let b = -i(VxA_18_s_10)
echo K tt 27 A_18_s_10 $&a $&b
let a = v(jA_18_u_0)
let b = -i(VxA_18_u_0)
echo K tt 27 A_18_u_0 $&a $&b
let a = v(jA_18_u_1)
let b = -i(VxA_18_u_1)
echo K tt 27 A_18_u_1 $&a $&b
let a = v(jA_18_u_2)
let b = -i(VxA_18_u_2)
echo K tt 27 A_18_u_2 $&a $&b
let a = v(jA_18_u_3)
let b = -i(VxA_18_u_3)
echo K tt 27 A_18_u_3 $&a $&b
let a = v(jA_18_u_4)
let b = -i(VxA_18_u_4)
echo K tt 27 A_18_u_4 $&a $&b
let a = v(jA_18_u_5)
let b = -i(VxA_18_u_5)
echo K tt 27 A_18_u_5 $&a $&b
let a = v(jA_18_u_6)
let b = -i(VxA_18_u_6)
echo K tt 27 A_18_u_6 $&a $&b
let a = v(jA_18_u_7)
let b = -i(VxA_18_u_7)
echo K tt 27 A_18_u_7 $&a $&b
let a = v(jA_18_u_8)
let b = -i(VxA_18_u_8)
echo K tt 27 A_18_u_8 $&a $&b
let a = v(jA_18_u_9)
let b = -i(VxA_18_u_9)
echo K tt 27 A_18_u_9 $&a $&b
let a = v(jA_18_u_10)
let b = -i(VxA_18_u_10)
echo K tt 27 A_18_u_10 $&a $&b
let a = v(jA_09_s_0)
let b = -i(VxA_09_s_0)
echo K tt 27 A_09_s_0 $&a $&b
let a = v(jA_09_s_1)
let b = -i(VxA_09_s_1)
echo K tt 27 A_09_s_1 $&a $&b
let a = v(jA_09_s_2)
let b = -i(VxA_09_s_2)
echo K tt 27 A_09_s_2 $&a $&b
let a = v(jA_09_s_3)
let b = -i(VxA_09_s_3)
echo K tt 27 A_09_s_3 $&a $&b
let a = v(jA_09_s_4)
let b = -i(VxA_09_s_4)
echo K tt 27 A_09_s_4 $&a $&b
let a = v(jA_09_s_5)
let b = -i(VxA_09_s_5)
echo K tt 27 A_09_s_5 $&a $&b
let a = v(jA_09_s_6)
let b = -i(VxA_09_s_6)
echo K tt 27 A_09_s_6 $&a $&b
let a = v(jA_09_s_7)
let b = -i(VxA_09_s_7)
echo K tt 27 A_09_s_7 $&a $&b
let a = v(jA_09_s_8)
let b = -i(VxA_09_s_8)
echo K tt 27 A_09_s_8 $&a $&b
let a = v(jA_09_s_9)
let b = -i(VxA_09_s_9)
echo K tt 27 A_09_s_9 $&a $&b
let a = v(jA_09_s_10)
let b = -i(VxA_09_s_10)
echo K tt 27 A_09_s_10 $&a $&b
let a = v(jA_09_u_0)
let b = -i(VxA_09_u_0)
echo K tt 27 A_09_u_0 $&a $&b
let a = v(jA_09_u_1)
let b = -i(VxA_09_u_1)
echo K tt 27 A_09_u_1 $&a $&b
let a = v(jA_09_u_2)
let b = -i(VxA_09_u_2)
echo K tt 27 A_09_u_2 $&a $&b
let a = v(jA_09_u_3)
let b = -i(VxA_09_u_3)
echo K tt 27 A_09_u_3 $&a $&b
let a = v(jA_09_u_4)
let b = -i(VxA_09_u_4)
echo K tt 27 A_09_u_4 $&a $&b
let a = v(jA_09_u_5)
let b = -i(VxA_09_u_5)
echo K tt 27 A_09_u_5 $&a $&b
let a = v(jA_09_u_6)
let b = -i(VxA_09_u_6)
echo K tt 27 A_09_u_6 $&a $&b
let a = v(jA_09_u_7)
let b = -i(VxA_09_u_7)
echo K tt 27 A_09_u_7 $&a $&b
let a = v(jA_09_u_8)
let b = -i(VxA_09_u_8)
echo K tt 27 A_09_u_8 $&a $&b
let a = v(jA_09_u_9)
let b = -i(VxA_09_u_9)
echo K tt 27 A_09_u_9 $&a $&b
let a = v(jA_09_u_10)
let b = -i(VxA_09_u_10)
echo K tt 27 A_09_u_10 $&a $&b
let a = v(xB_18_s_0)-v(jB_18_s_0)
let b = -i(VxB_18_s_0)
echo K tt 27 B_18_s_0 $&a $&b
let a = v(xB_18_s_1)-v(jB_18_s_1)
let b = -i(VxB_18_s_1)
echo K tt 27 B_18_s_1 $&a $&b
let a = v(xB_18_s_2)-v(jB_18_s_2)
let b = -i(VxB_18_s_2)
echo K tt 27 B_18_s_2 $&a $&b
let a = v(xB_18_s_3)-v(jB_18_s_3)
let b = -i(VxB_18_s_3)
echo K tt 27 B_18_s_3 $&a $&b
let a = v(xB_18_s_4)-v(jB_18_s_4)
let b = -i(VxB_18_s_4)
echo K tt 27 B_18_s_4 $&a $&b
let a = v(xB_18_s_5)-v(jB_18_s_5)
let b = -i(VxB_18_s_5)
echo K tt 27 B_18_s_5 $&a $&b
let a = v(xB_18_s_6)-v(jB_18_s_6)
let b = -i(VxB_18_s_6)
echo K tt 27 B_18_s_6 $&a $&b
let a = v(xB_18_s_7)-v(jB_18_s_7)
let b = -i(VxB_18_s_7)
echo K tt 27 B_18_s_7 $&a $&b
let a = v(xB_18_s_8)-v(jB_18_s_8)
let b = -i(VxB_18_s_8)
echo K tt 27 B_18_s_8 $&a $&b
let a = v(xB_18_s_9)-v(jB_18_s_9)
let b = -i(VxB_18_s_9)
echo K tt 27 B_18_s_9 $&a $&b
let a = v(xB_18_s_10)-v(jB_18_s_10)
let b = -i(VxB_18_s_10)
echo K tt 27 B_18_s_10 $&a $&b
let a = v(xB_18_s_11)-v(jB_18_s_11)
let b = -i(VxB_18_s_11)
echo K tt 27 B_18_s_11 $&a $&b
let a = v(xB_18_u_0)-v(jB_18_u_0)
let b = -i(VxB_18_u_0)
echo K tt 27 B_18_u_0 $&a $&b
let a = v(xB_18_u_1)-v(jB_18_u_1)
let b = -i(VxB_18_u_1)
echo K tt 27 B_18_u_1 $&a $&b
let a = v(xB_18_u_2)-v(jB_18_u_2)
let b = -i(VxB_18_u_2)
echo K tt 27 B_18_u_2 $&a $&b
let a = v(xB_18_u_3)-v(jB_18_u_3)
let b = -i(VxB_18_u_3)
echo K tt 27 B_18_u_3 $&a $&b
let a = v(xB_18_u_4)-v(jB_18_u_4)
let b = -i(VxB_18_u_4)
echo K tt 27 B_18_u_4 $&a $&b
let a = v(xB_18_u_5)-v(jB_18_u_5)
let b = -i(VxB_18_u_5)
echo K tt 27 B_18_u_5 $&a $&b
let a = v(xB_18_u_6)-v(jB_18_u_6)
let b = -i(VxB_18_u_6)
echo K tt 27 B_18_u_6 $&a $&b
let a = v(xB_18_u_7)-v(jB_18_u_7)
let b = -i(VxB_18_u_7)
echo K tt 27 B_18_u_7 $&a $&b
let a = v(xB_18_u_8)-v(jB_18_u_8)
let b = -i(VxB_18_u_8)
echo K tt 27 B_18_u_8 $&a $&b
let a = v(xB_18_u_9)-v(jB_18_u_9)
let b = -i(VxB_18_u_9)
echo K tt 27 B_18_u_9 $&a $&b
let a = v(xB_18_u_10)-v(jB_18_u_10)
let b = -i(VxB_18_u_10)
echo K tt 27 B_18_u_10 $&a $&b
let a = v(xB_09_s_0)-v(jB_09_s_0)
let b = -i(VxB_09_s_0)
echo K tt 27 B_09_s_0 $&a $&b
let a = v(xB_09_s_1)-v(jB_09_s_1)
let b = -i(VxB_09_s_1)
echo K tt 27 B_09_s_1 $&a $&b
let a = v(xB_09_s_2)-v(jB_09_s_2)
let b = -i(VxB_09_s_2)
echo K tt 27 B_09_s_2 $&a $&b
let a = v(xB_09_s_3)-v(jB_09_s_3)
let b = -i(VxB_09_s_3)
echo K tt 27 B_09_s_3 $&a $&b
let a = v(xB_09_s_4)-v(jB_09_s_4)
let b = -i(VxB_09_s_4)
echo K tt 27 B_09_s_4 $&a $&b
let a = v(xB_09_s_5)-v(jB_09_s_5)
let b = -i(VxB_09_s_5)
echo K tt 27 B_09_s_5 $&a $&b
let a = v(xB_09_s_6)-v(jB_09_s_6)
let b = -i(VxB_09_s_6)
echo K tt 27 B_09_s_6 $&a $&b
let a = v(xB_09_s_7)-v(jB_09_s_7)
let b = -i(VxB_09_s_7)
echo K tt 27 B_09_s_7 $&a $&b
let a = v(xB_09_s_8)-v(jB_09_s_8)
let b = -i(VxB_09_s_8)
echo K tt 27 B_09_s_8 $&a $&b
let a = v(xB_09_s_9)-v(jB_09_s_9)
let b = -i(VxB_09_s_9)
echo K tt 27 B_09_s_9 $&a $&b
let a = v(xB_09_s_10)-v(jB_09_s_10)
let b = -i(VxB_09_s_10)
echo K tt 27 B_09_s_10 $&a $&b
let a = v(xB_09_u_0)-v(jB_09_u_0)
let b = -i(VxB_09_u_0)
echo K tt 27 B_09_u_0 $&a $&b
let a = v(xB_09_u_1)-v(jB_09_u_1)
let b = -i(VxB_09_u_1)
echo K tt 27 B_09_u_1 $&a $&b
let a = v(xB_09_u_2)-v(jB_09_u_2)
let b = -i(VxB_09_u_2)
echo K tt 27 B_09_u_2 $&a $&b
let a = v(xB_09_u_3)-v(jB_09_u_3)
let b = -i(VxB_09_u_3)
echo K tt 27 B_09_u_3 $&a $&b
let a = v(xB_09_u_4)-v(jB_09_u_4)
let b = -i(VxB_09_u_4)
echo K tt 27 B_09_u_4 $&a $&b
let a = v(xB_09_u_5)-v(jB_09_u_5)
let b = -i(VxB_09_u_5)
echo K tt 27 B_09_u_5 $&a $&b
let a = v(xB_09_u_6)-v(jB_09_u_6)
let b = -i(VxB_09_u_6)
echo K tt 27 B_09_u_6 $&a $&b
let a = v(xB_09_u_7)-v(jB_09_u_7)
let b = -i(VxB_09_u_7)
echo K tt 27 B_09_u_7 $&a $&b
let a = v(xB_09_u_8)-v(jB_09_u_8)
let b = -i(VxB_09_u_8)
echo K tt 27 B_09_u_8 $&a $&b
let a = v(xB_09_u_9)-v(jB_09_u_9)
let b = -i(VxB_09_u_9)
echo K tt 27 B_09_u_9 $&a $&b
let a = v(xB_09_u_10)-v(jB_09_u_10)
let b = -i(VxB_09_u_10)
echo K tt 27 B_09_u_10 $&a $&b
let a = v(r1)
let b = -i(Vr1)
echo K tt 27 DPW $&a $&b
let a = v(r2)
let b = -i(Vr2)
echo K tt 27 DPD $&a $&b
let a = v(xaoff)
let b = -i(Vxaoff)
echo K tt 27 BUSA_off $&a $&b
let a = v(xboff)
let b = -i(Vxboff)
echo K tt 27 BUSB_off $&a $&b
let a = v(xaon)
let b = -i(Vxaon)
echo K tt 27 BUSA_on $&a $&b
let a = v(xbon)
let b = -i(Vxbon)
echo K tt 27 BUSB_on $&a $&b
quit
.endc
.end
