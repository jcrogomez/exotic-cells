* frontera 0.18 y 1.0; dependencia con sa fuera de frontera
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
Vgn gn 0 -0.9
Vdn dn 0 -0.05
Vg g 0 0.9
Vd d 0 0.05
x0 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.1799 
x1 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.1799 sa=0.3 sb=0.3
x2 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.18 
x3 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.18 sa=0.3 sb=0.3
x4 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.1801 
x5 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.1801 sa=0.3 sb=0.3
x6 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.9999 
x7 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.9999 sa=0.3 sb=0.3
x8 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=1.0 
x9 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=1.0 sa=0.3 sb=0.3
x10 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=1.0001 
x11 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=1.0001 sa=0.3 sb=0.3
x12 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.7 
x13 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.7 sa=0.3 sb=0.3
x14 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=2.0 
x15 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=2.0 sa=0.3 sb=0.3
x16 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.1799 
x17 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.1799 sa=0.3 sb=0.3
x18 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.18 
x19 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.18 sa=0.3 sb=0.3
x20 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.1801 
x21 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.1801 sa=0.3 sb=0.3
x22 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.9999 
x23 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.9999 sa=0.3 sb=0.3
x24 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=1.0 
x25 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=1.0 sa=0.3 sb=0.3
x26 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=1.0001 
x27 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=1.0001 sa=0.3 sb=0.3
x28 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.7 
x29 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.7 sa=0.3 sb=0.3
x30 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=2.0 
x31 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=2.0 sa=0.3 sb=0.3
x32 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=0.1799 
x33 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=0.1799 sa=0.3 sb=0.3
x34 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=0.18 
x35 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=0.18 sa=0.3 sb=0.3
x36 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=0.1801 
x37 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=0.1801 sa=0.3 sb=0.3
x38 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=0.9999 
x39 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=0.9999 sa=0.3 sb=0.3
x40 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=1.0 
x41 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=1.0 sa=0.3 sb=0.3
x42 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=1.0001 
x43 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=1.0001 sa=0.3 sb=0.3
x44 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=0.7 
x45 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=0.7 sa=0.3 sb=0.3
x46 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=2.0 
x47 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=2.0 sa=0.3 sb=0.3
x48 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.7 sa=0.3 sb=0.3
x49 d g 0 0 sky130_fd_pr__nfet_01v8 w=1 l=1.0001 sa=0.3 sb=0.3
x50 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.7 sa=1.0 sb=1.0
x51 d g 0 0 sky130_fd_pr__nfet_01v8 w=1 l=1.0001 sa=1.0 sb=1.0
x52 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.7 sa=3.0 sb=3.0
x53 d g 0 0 sky130_fd_pr__nfet_01v8 w=1 l=1.0001 sa=3.0 sb=3.0
x54 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.7 sa=10.0 sb=10.0
x55 d g 0 0 sky130_fd_pr__nfet_01v8 w=1 l=1.0001 sa=10.0 sb=10.0
.control
op
echo VT pfet_01v8_hvt 0.42 0.1799 sch $&@m.x0.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x0.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 0.1799 sa03 $&@m.x1.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x1.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 0.18 sch $&@m.x2.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x2.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 0.18 sa03 $&@m.x3.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x3.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 0.1801 sch $&@m.x4.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x4.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 0.1801 sa03 $&@m.x5.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x5.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 0.9999 sch $&@m.x6.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x6.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 0.9999 sa03 $&@m.x7.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x7.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 1.0 sch $&@m.x8.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x8.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 1.0 sa03 $&@m.x9.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x9.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 1.0001 sch $&@m.x10.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x10.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 1.0001 sa03 $&@m.x11.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x11.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 0.7 sch $&@m.x12.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x12.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 0.7 sa03 $&@m.x13.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x13.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 2.0 sch $&@m.x14.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x14.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.42 2.0 sa03 $&@m.x15.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.x15.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT nfet_01v8 0.42 0.1799 sch $&@m.x16.msky130_fd_pr__nfet_01v8[vth] $&@m.x16.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 0.1799 sa03 $&@m.x17.msky130_fd_pr__nfet_01v8[vth] $&@m.x17.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 0.18 sch $&@m.x18.msky130_fd_pr__nfet_01v8[vth] $&@m.x18.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 0.18 sa03 $&@m.x19.msky130_fd_pr__nfet_01v8[vth] $&@m.x19.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 0.1801 sch $&@m.x20.msky130_fd_pr__nfet_01v8[vth] $&@m.x20.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 0.1801 sa03 $&@m.x21.msky130_fd_pr__nfet_01v8[vth] $&@m.x21.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 0.9999 sch $&@m.x22.msky130_fd_pr__nfet_01v8[vth] $&@m.x22.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 0.9999 sa03 $&@m.x23.msky130_fd_pr__nfet_01v8[vth] $&@m.x23.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 1.0 sch $&@m.x24.msky130_fd_pr__nfet_01v8[vth] $&@m.x24.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 1.0 sa03 $&@m.x25.msky130_fd_pr__nfet_01v8[vth] $&@m.x25.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 1.0001 sch $&@m.x26.msky130_fd_pr__nfet_01v8[vth] $&@m.x26.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 1.0001 sa03 $&@m.x27.msky130_fd_pr__nfet_01v8[vth] $&@m.x27.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 0.7 sch $&@m.x28.msky130_fd_pr__nfet_01v8[vth] $&@m.x28.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 0.7 sa03 $&@m.x29.msky130_fd_pr__nfet_01v8[vth] $&@m.x29.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 2.0 sch $&@m.x30.msky130_fd_pr__nfet_01v8[vth] $&@m.x30.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 2.0 sa03 $&@m.x31.msky130_fd_pr__nfet_01v8[vth] $&@m.x31.msky130_fd_pr__nfet_01v8[id]
echo VT pfet_01v8 0.42 0.1799 sch $&@m.x32.msky130_fd_pr__pfet_01v8[vth] $&@m.x32.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 0.1799 sa03 $&@m.x33.msky130_fd_pr__pfet_01v8[vth] $&@m.x33.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 0.18 sch $&@m.x34.msky130_fd_pr__pfet_01v8[vth] $&@m.x34.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 0.18 sa03 $&@m.x35.msky130_fd_pr__pfet_01v8[vth] $&@m.x35.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 0.1801 sch $&@m.x36.msky130_fd_pr__pfet_01v8[vth] $&@m.x36.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 0.1801 sa03 $&@m.x37.msky130_fd_pr__pfet_01v8[vth] $&@m.x37.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 0.9999 sch $&@m.x38.msky130_fd_pr__pfet_01v8[vth] $&@m.x38.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 0.9999 sa03 $&@m.x39.msky130_fd_pr__pfet_01v8[vth] $&@m.x39.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 1.0 sch $&@m.x40.msky130_fd_pr__pfet_01v8[vth] $&@m.x40.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 1.0 sa03 $&@m.x41.msky130_fd_pr__pfet_01v8[vth] $&@m.x41.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 1.0001 sch $&@m.x42.msky130_fd_pr__pfet_01v8[vth] $&@m.x42.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 1.0001 sa03 $&@m.x43.msky130_fd_pr__pfet_01v8[vth] $&@m.x43.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 0.7 sch $&@m.x44.msky130_fd_pr__pfet_01v8[vth] $&@m.x44.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 0.7 sa03 $&@m.x45.msky130_fd_pr__pfet_01v8[vth] $&@m.x45.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 2.0 sch $&@m.x46.msky130_fd_pr__pfet_01v8[vth] $&@m.x46.msky130_fd_pr__pfet_01v8[id]
echo VT pfet_01v8 0.42 2.0 sa03 $&@m.x47.msky130_fd_pr__pfet_01v8[vth] $&@m.x47.msky130_fd_pr__pfet_01v8[id]
echo VT nfet_01v8 0.42 0.7 sa0.3 $&@m.x48.msky130_fd_pr__nfet_01v8[vth] $&@m.x48.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 1 1.0001 sa0.3 $&@m.x49.msky130_fd_pr__nfet_01v8[vth] $&@m.x49.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 0.7 sa1.0 $&@m.x50.msky130_fd_pr__nfet_01v8[vth] $&@m.x50.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 1 1.0001 sa1.0 $&@m.x51.msky130_fd_pr__nfet_01v8[vth] $&@m.x51.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 0.7 sa3.0 $&@m.x52.msky130_fd_pr__nfet_01v8[vth] $&@m.x52.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 1 1.0001 sa3.0 $&@m.x53.msky130_fd_pr__nfet_01v8[vth] $&@m.x53.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.42 0.7 sa10.0 $&@m.x54.msky130_fd_pr__nfet_01v8[vth] $&@m.x54.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 1 1.0001 sa10.0 $&@m.x55.msky130_fd_pr__nfet_01v8[vth] $&@m.x55.msky130_fd_pr__nfet_01v8[id]
quit
.endc
.end
