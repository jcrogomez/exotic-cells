* MISFIT-23 cuenta previa: fuga de las dos precargas apagadas sobre X, tt 27
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
.options gmin=1e-15
Vd VDD 0 1.8
Vh PRENH 0 1.8
Vl PRENL 0 1.8
Vx X 0 0.9
X0 VDD PRENL a_1300_1056# VDD sky130_fd_pr__pfet_01v8_hvt ad=0.3 pd=2.6 as=0.105 ps=1.21 w=1 l=1
X1 X PRENL a_788_1056# VDD sky130_fd_pr__pfet_01v8_hvt ad=0.175 pd=1.35 as=0.105 ps=1.21 w=1 l=1
X2 GND X GND GND sky130_fd_pr__nfet_01v8 ad=1.29 pd=9.2 as=2.58 ps=18.4 w=4.3 l=4
X3 a_1300_1056# PRENL X VDD sky130_fd_pr__pfet_01v8_hvt ad=0.105 pd=1.21 as=0.175 ps=1.35 w=1 l=1
X4 a_788_1056# PRENL VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.105 pd=1.21 as=0.3 ps=2.6 w=1 l=1
X5 a_342_1056# PRENH X VDD sky130_fd_pr__pfet_01v8_hvt ad=0.105 pd=1.21 as=0.175 ps=1.35 w=1 l=0.15
X6 a_170_1056# PRENH VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.105 pd=1.21 as=0.3 ps=2.6 w=1 l=0.15
X7 X PRENH a_170_1056# VDD sky130_fd_pr__pfet_01v8_hvt ad=0.175 pd=1.35 as=0.105 ps=1.21 w=1 l=0.15
X8 VDD PRENH a_342_1056# VDD sky130_fd_pr__pfet_01v8_hvt ad=0.3 pd=2.6 as=0.105 ps=1.21 w=1 l=0.15
C0 PRENL VDD 0.47456f
C1 X VDD 0.29103f
C2 a_1300_1056# VDD 0.00279f
C3 PRENH VDD 0.21912f
C4 X a_788_1056# 0.00181f
C5 X a_342_1056# 0.00234f
C6 VDD a_788_1056# 0.00279f
C7 a_342_1056# VDD 0.00319f
C8 a_170_1056# X 0.00179f
C9 a_170_1056# VDD 0.00319f
C10 PRENL X 0.19097f
C11 a_1300_1056# X 0.00319f
C12 PRENL PRENH 0.02069f
C13 PRENH X 0.08745f
C14 X GND 1.83606f
C15 PRENL GND 1.11022f
C16 PRENH GND 0.27503f
C17 VDD GND 2.09998f
C18 a_342_1056# GND 0
.control
dc Vx 0.7 1.8 0.1
let ix = -i(vx)
print ix
echo PREVIA tt 27
quit
.endc
.end
