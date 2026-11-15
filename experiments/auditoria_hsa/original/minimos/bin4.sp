* ventana de la diferencia de bin
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
Vg g 0 0.9
Vd d 0 0.05
x0 d g 0 0 sky130_fd_pr__nfet_01v8 w=1 l=1.0 sa=0.3 sb=0.3
x1 d g 0 0 sky130_fd_pr__nfet_01v8 w=1 l=1.001 sa=0.3 sb=0.3
x2 d g 0 0 sky130_fd_pr__nfet_01v8 w=1 l=1.01 sa=0.3 sb=0.3
x3 d g 0 0 sky130_fd_pr__nfet_01v8 w=1 l=1.05 sa=0.3 sb=0.3
x4 d g 0 0 sky130_fd_pr__nfet_01v8 w=1 l=0.999 sa=0.3 sb=0.3
x5 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3 sb=0.3
x6 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.4999 sa=0.3 sb=0.3
x7 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.4201 l=0.4999 sa=0.3 sb=0.3
x8 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.4199 l=0.4999 sa=0.3 sb=0.3
x9 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.7 sa=0.3 sb=0.3
x10 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.15 sa=0.3 sb=0.3
x11 d g 0 0 sky130_fd_pr__nfet_01v8 w=1 l=0.15 sa=0.3 sb=0.3
.control
op
echo BIN nfet_01v8 1 1.0 $&@m.x0.msky130_fd_pr__nfet_01v8[vth]
showmod m.x0.msky130_fd_pr__nfet_01v8 : lmin lmax wmin wmax saref
echo BIN nfet_01v8 1 1.001 $&@m.x1.msky130_fd_pr__nfet_01v8[vth]
showmod m.x1.msky130_fd_pr__nfet_01v8 : lmin lmax wmin wmax saref
echo BIN nfet_01v8 1 1.01 $&@m.x2.msky130_fd_pr__nfet_01v8[vth]
showmod m.x2.msky130_fd_pr__nfet_01v8 : lmin lmax wmin wmax saref
echo BIN nfet_01v8 1 1.05 $&@m.x3.msky130_fd_pr__nfet_01v8[vth]
showmod m.x3.msky130_fd_pr__nfet_01v8 : lmin lmax wmin wmax saref
echo BIN nfet_01v8 1 0.999 $&@m.x4.msky130_fd_pr__nfet_01v8[vth]
showmod m.x4.msky130_fd_pr__nfet_01v8 : lmin lmax wmin wmax saref
echo BIN nfet_01v8 0.42 0.15 $&@m.x5.msky130_fd_pr__nfet_01v8[vth]
showmod m.x5.msky130_fd_pr__nfet_01v8 : lmin lmax wmin wmax saref
echo BIN nfet_01v8 0.42 0.4999 $&@m.x6.msky130_fd_pr__nfet_01v8[vth]
showmod m.x6.msky130_fd_pr__nfet_01v8 : lmin lmax wmin wmax saref
echo BIN nfet_01v8 0.4201 0.4999 $&@m.x7.msky130_fd_pr__nfet_01v8[vth]
showmod m.x7.msky130_fd_pr__nfet_01v8 : lmin lmax wmin wmax saref
echo BIN nfet_01v8 0.4199 0.4999 $&@m.x8.msky130_fd_pr__nfet_01v8[vth]
showmod m.x8.msky130_fd_pr__nfet_01v8 : lmin lmax wmin wmax saref
echo BIN nfet_01v8 0.42 0.7 $&@m.x9.msky130_fd_pr__nfet_01v8[vth]
showmod m.x9.msky130_fd_pr__nfet_01v8 : lmin lmax wmin wmax saref
echo BIN nfet_01v8 0.65 0.15 $&@m.x10.msky130_fd_pr__nfet_01v8[vth]
showmod m.x10.msky130_fd_pr__nfet_01v8 : lmin lmax wmin wmax saref
echo BIN nfet_01v8 1 0.15 $&@m.x11.msky130_fd_pr__nfet_01v8[vth]
showmod m.x11.msky130_fd_pr__nfet_01v8 : lmin lmax wmin wmax saref
quit
.endc
.end
