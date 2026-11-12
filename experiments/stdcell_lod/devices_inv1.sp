* The two transistors of inv_1 at the geometry measured in its layout (sa = sb = 0.26 um) against the default. tt, 27 C.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
Vn n 0 1.8
Vp p 0 -1.8
Vnn0 dn0 0 1.8
Vnn1 dn1 0 1.8
Vpp0 dp0 0 -1.8
Vpp1 dp1 0 -1.8
Xn0 dn0 n 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.15
Xn1 dn1 n 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.15 sa=0.26 sb=0.26
Xp0 dp0 p 0 0 sky130_fd_pr__pfet_01v8_hvt w=1 l=0.15
Xp1 dp1 p 0 0 sky130_fd_pr__pfet_01v8_hvt w=1 l=0.15 sa=0.26 sb=0.26
.control
op
let vn0 = @m.xn0.msky130_fd_pr__nfet_01v8[vth]
let vn1 = @m.xn1.msky130_fd_pr__nfet_01v8[vth]
let vp0 = @m.xp0.msky130_fd_pr__pfet_01v8_hvt[vth]
let vp1 = @m.xp1.msky130_fd_pr__pfet_01v8_hvt[vth]
let in0 = -i(Vnn0)
let in1 = -i(Vnn1)
let ip0 = i(Vpp0)
let ip1 = i(Vpp1)
echo DEV nfet vth $&vn0 $&vn1 idsat $&in0 $&in1
echo DEV pfet vth $&vp0 $&vp1 idsat $&ip0 $&ip1
quit
.endc
.end
