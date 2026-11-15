* que bin elige cada modo
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
Vg g 0 0.9
Vd d 0 0.05
x0 d g 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.4999 sa=0.3 sb=0.3
x1 d g 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5 sa=0.3 sb=0.3
x2 d g 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5001 sa=0.3 sb=0.3
x3 d g 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.7 sa=0.3 sb=0.3
x4 d g 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.1801 sa=0.3 sb=0.3
x5 d g 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=1.0001 sa=0.3 sb=0.3
x6 d g 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.499 sa=0.3 sb=0.3
x7 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.4999 sa=0.3 sb=0.3
x8 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.5 sa=0.3 sb=0.3
x9 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.5001 sa=0.3 sb=0.3
x10 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.7 sa=0.3 sb=0.3
x11 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.1801 sa=0.3 sb=0.3
x12 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=1.0001 sa=0.3 sb=0.3
x13 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.499 sa=0.3 sb=0.3
.control
op
echo BIN pfet_01v8_hvt 0.4999
showmod m.x0.msky130_fd_pr__pfet_01v8_hvt : lmin lmax saref sbref kvth0 lkvth0 llodvth wlod ku0 lku0 llodku0 stk2 steta0 vth0
echo BIN pfet_01v8_hvt 0.5
showmod m.x1.msky130_fd_pr__pfet_01v8_hvt : lmin lmax saref sbref kvth0 lkvth0 llodvth wlod ku0 lku0 llodku0 stk2 steta0 vth0
echo BIN pfet_01v8_hvt 0.5001
showmod m.x2.msky130_fd_pr__pfet_01v8_hvt : lmin lmax saref sbref kvth0 lkvth0 llodvth wlod ku0 lku0 llodku0 stk2 steta0 vth0
echo BIN pfet_01v8_hvt 0.7
showmod m.x3.msky130_fd_pr__pfet_01v8_hvt : lmin lmax saref sbref kvth0 lkvth0 llodvth wlod ku0 lku0 llodku0 stk2 steta0 vth0
echo BIN pfet_01v8_hvt 0.1801
showmod m.x4.msky130_fd_pr__pfet_01v8_hvt : lmin lmax saref sbref kvth0 lkvth0 llodvth wlod ku0 lku0 llodku0 stk2 steta0 vth0
echo BIN pfet_01v8_hvt 1.0001
showmod m.x5.msky130_fd_pr__pfet_01v8_hvt : lmin lmax saref sbref kvth0 lkvth0 llodvth wlod ku0 lku0 llodku0 stk2 steta0 vth0
echo BIN pfet_01v8_hvt 0.499
showmod m.x6.msky130_fd_pr__pfet_01v8_hvt : lmin lmax saref sbref kvth0 lkvth0 llodvth wlod ku0 lku0 llodku0 stk2 steta0 vth0
echo BIN nfet_01v8 0.4999
showmod m.x7.msky130_fd_pr__nfet_01v8 : lmin lmax saref sbref kvth0 lkvth0 llodvth wlod ku0 lku0 llodku0 stk2 steta0 vth0
echo BIN nfet_01v8 0.5
showmod m.x8.msky130_fd_pr__nfet_01v8 : lmin lmax saref sbref kvth0 lkvth0 llodvth wlod ku0 lku0 llodku0 stk2 steta0 vth0
echo BIN nfet_01v8 0.5001
showmod m.x9.msky130_fd_pr__nfet_01v8 : lmin lmax saref sbref kvth0 lkvth0 llodvth wlod ku0 lku0 llodku0 stk2 steta0 vth0
echo BIN nfet_01v8 0.7
showmod m.x10.msky130_fd_pr__nfet_01v8 : lmin lmax saref sbref kvth0 lkvth0 llodvth wlod ku0 lku0 llodku0 stk2 steta0 vth0
echo BIN nfet_01v8 0.1801
showmod m.x11.msky130_fd_pr__nfet_01v8 : lmin lmax saref sbref kvth0 lkvth0 llodvth wlod ku0 lku0 llodku0 stk2 steta0 vth0
echo BIN nfet_01v8 1.0001
showmod m.x12.msky130_fd_pr__nfet_01v8 : lmin lmax saref sbref kvth0 lkvth0 llodvth wlod ku0 lku0 llodku0 stk2 steta0 vth0
echo BIN nfet_01v8 0.499
showmod m.x13.msky130_fd_pr__nfet_01v8 : lmin lmax saref sbref kvth0 lkvth0 llodvth wlod ku0 lku0 llodku0 stk2 steta0 vth0
quit
.endc
.end
