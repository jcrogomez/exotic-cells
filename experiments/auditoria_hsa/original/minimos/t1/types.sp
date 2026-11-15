* barrido de tipos y geometrias, vth del modelo
* hs vs sin modo
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
Vg g 0 0.9
Vgn gn 0 -0.9
Vd d 0 0.05
Vdn dn 0 -0.05
xnfet01v80 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
xnfet01v81 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.5
xnfet01v82 d g 0 0 sky130_fd_pr__nfet_01v8 w=1 l=0.15
xnfet01v83 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.65 l=0.15
xnfet01v84 d g 0 0 sky130_fd_pr__nfet_01v8 w=1 l=1
xnfet01v85 d g 0 0 sky130_fd_pr__nfet_01v8 w=5 l=0.15
xnfet01v86 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.35
xnfet01v8lvt0 d g 0 0 sky130_fd_pr__nfet_01v8_lvt w=0.42 l=0.15
xnfet01v8lvt1 d g 0 0 sky130_fd_pr__nfet_01v8_lvt w=0.42 l=0.5
xnfet01v8lvt2 d g 0 0 sky130_fd_pr__nfet_01v8_lvt w=1 l=0.15
xnfet01v8lvt3 d g 0 0 sky130_fd_pr__nfet_01v8_lvt w=0.65 l=0.15
xnfet01v8lvt4 d g 0 0 sky130_fd_pr__nfet_01v8_lvt w=1 l=1
xnfet01v8lvt5 d g 0 0 sky130_fd_pr__nfet_01v8_lvt w=5 l=0.15
xnfet01v8lvt6 d g 0 0 sky130_fd_pr__nfet_01v8_lvt w=0.42 l=0.35
xpfet01v80 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
xpfet01v81 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=0.5
xpfet01v82 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=1 l=0.15
xpfet01v83 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.65 l=0.15
xpfet01v84 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=1 l=1
xpfet01v85 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=5 l=0.15
xpfet01v86 dn gn 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l=0.35
xpfet01v8hvt0 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.15
xpfet01v8hvt1 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5
xpfet01v8hvt2 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=1 l=0.15
xpfet01v8hvt3 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.65 l=0.15
xpfet01v8hvt4 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=1 l=1
xpfet01v8hvt5 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=5 l=0.15
xpfet01v8hvt6 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.35
xpfet01v8lvt1 dn gn 0 0 sky130_fd_pr__pfet_01v8_lvt w=0.42 l=0.5
xpfet01v8lvt4 dn gn 0 0 sky130_fd_pr__pfet_01v8_lvt w=1 l=1
xpfet01v8lvt6 dn gn 0 0 sky130_fd_pr__pfet_01v8_lvt w=0.42 l=0.35
.control
op
echo VT nfet_01v8 0.42 0.15 $&@m.xnfet01v80.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v80.msky130_fd_pr__nfet_01v8[id] $&@m.xnfet01v80.msky130_fd_pr__nfet_01v8[cgg]
echo VT nfet_01v8 0.42 0.5 $&@m.xnfet01v81.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v81.msky130_fd_pr__nfet_01v8[id] $&@m.xnfet01v81.msky130_fd_pr__nfet_01v8[cgg]
echo VT nfet_01v8 1 0.15 $&@m.xnfet01v82.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v82.msky130_fd_pr__nfet_01v8[id] $&@m.xnfet01v82.msky130_fd_pr__nfet_01v8[cgg]
echo VT nfet_01v8 0.65 0.15 $&@m.xnfet01v83.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v83.msky130_fd_pr__nfet_01v8[id] $&@m.xnfet01v83.msky130_fd_pr__nfet_01v8[cgg]
echo VT nfet_01v8 1 1 $&@m.xnfet01v84.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v84.msky130_fd_pr__nfet_01v8[id] $&@m.xnfet01v84.msky130_fd_pr__nfet_01v8[cgg]
echo VT nfet_01v8 5 0.15 $&@m.xnfet01v85.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v85.msky130_fd_pr__nfet_01v8[id] $&@m.xnfet01v85.msky130_fd_pr__nfet_01v8[cgg]
echo VT nfet_01v8 0.42 0.35 $&@m.xnfet01v86.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v86.msky130_fd_pr__nfet_01v8[id] $&@m.xnfet01v86.msky130_fd_pr__nfet_01v8[cgg]
echo VT nfet_01v8_lvt 0.42 0.15 $&@m.xnfet01v8lvt0.msky130_fd_pr__nfet_01v8_lvt[vth] $&@m.xnfet01v8lvt0.msky130_fd_pr__nfet_01v8_lvt[id] $&@m.xnfet01v8lvt0.msky130_fd_pr__nfet_01v8_lvt[cgg]
echo VT nfet_01v8_lvt 0.42 0.5 $&@m.xnfet01v8lvt1.msky130_fd_pr__nfet_01v8_lvt[vth] $&@m.xnfet01v8lvt1.msky130_fd_pr__nfet_01v8_lvt[id] $&@m.xnfet01v8lvt1.msky130_fd_pr__nfet_01v8_lvt[cgg]
echo VT nfet_01v8_lvt 1 0.15 $&@m.xnfet01v8lvt2.msky130_fd_pr__nfet_01v8_lvt[vth] $&@m.xnfet01v8lvt2.msky130_fd_pr__nfet_01v8_lvt[id] $&@m.xnfet01v8lvt2.msky130_fd_pr__nfet_01v8_lvt[cgg]
echo VT nfet_01v8_lvt 0.65 0.15 $&@m.xnfet01v8lvt3.msky130_fd_pr__nfet_01v8_lvt[vth] $&@m.xnfet01v8lvt3.msky130_fd_pr__nfet_01v8_lvt[id] $&@m.xnfet01v8lvt3.msky130_fd_pr__nfet_01v8_lvt[cgg]
echo VT nfet_01v8_lvt 1 1 $&@m.xnfet01v8lvt4.msky130_fd_pr__nfet_01v8_lvt[vth] $&@m.xnfet01v8lvt4.msky130_fd_pr__nfet_01v8_lvt[id] $&@m.xnfet01v8lvt4.msky130_fd_pr__nfet_01v8_lvt[cgg]
echo VT nfet_01v8_lvt 5 0.15 $&@m.xnfet01v8lvt5.msky130_fd_pr__nfet_01v8_lvt[vth] $&@m.xnfet01v8lvt5.msky130_fd_pr__nfet_01v8_lvt[id] $&@m.xnfet01v8lvt5.msky130_fd_pr__nfet_01v8_lvt[cgg]
echo VT nfet_01v8_lvt 0.42 0.35 $&@m.xnfet01v8lvt6.msky130_fd_pr__nfet_01v8_lvt[vth] $&@m.xnfet01v8lvt6.msky130_fd_pr__nfet_01v8_lvt[id] $&@m.xnfet01v8lvt6.msky130_fd_pr__nfet_01v8_lvt[cgg]
echo VT pfet_01v8 0.42 0.15 $&@m.xpfet01v80.msky130_fd_pr__pfet_01v8[vth] $&@m.xpfet01v80.msky130_fd_pr__pfet_01v8[id] $&@m.xpfet01v80.msky130_fd_pr__pfet_01v8[cgg]
echo VT pfet_01v8 0.42 0.5 $&@m.xpfet01v81.msky130_fd_pr__pfet_01v8[vth] $&@m.xpfet01v81.msky130_fd_pr__pfet_01v8[id] $&@m.xpfet01v81.msky130_fd_pr__pfet_01v8[cgg]
echo VT pfet_01v8 1 0.15 $&@m.xpfet01v82.msky130_fd_pr__pfet_01v8[vth] $&@m.xpfet01v82.msky130_fd_pr__pfet_01v8[id] $&@m.xpfet01v82.msky130_fd_pr__pfet_01v8[cgg]
echo VT pfet_01v8 0.65 0.15 $&@m.xpfet01v83.msky130_fd_pr__pfet_01v8[vth] $&@m.xpfet01v83.msky130_fd_pr__pfet_01v8[id] $&@m.xpfet01v83.msky130_fd_pr__pfet_01v8[cgg]
echo VT pfet_01v8 1 1 $&@m.xpfet01v84.msky130_fd_pr__pfet_01v8[vth] $&@m.xpfet01v84.msky130_fd_pr__pfet_01v8[id] $&@m.xpfet01v84.msky130_fd_pr__pfet_01v8[cgg]
echo VT pfet_01v8 5 0.15 $&@m.xpfet01v85.msky130_fd_pr__pfet_01v8[vth] $&@m.xpfet01v85.msky130_fd_pr__pfet_01v8[id] $&@m.xpfet01v85.msky130_fd_pr__pfet_01v8[cgg]
echo VT pfet_01v8 0.42 0.35 $&@m.xpfet01v86.msky130_fd_pr__pfet_01v8[vth] $&@m.xpfet01v86.msky130_fd_pr__pfet_01v8[id] $&@m.xpfet01v86.msky130_fd_pr__pfet_01v8[cgg]
echo VT pfet_01v8_hvt 0.42 0.15 $&@m.xpfet01v8hvt0.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt0.msky130_fd_pr__pfet_01v8_hvt[id] $&@m.xpfet01v8hvt0.msky130_fd_pr__pfet_01v8_hvt[cgg]
echo VT pfet_01v8_hvt 0.42 0.5 $&@m.xpfet01v8hvt1.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt1.msky130_fd_pr__pfet_01v8_hvt[id] $&@m.xpfet01v8hvt1.msky130_fd_pr__pfet_01v8_hvt[cgg]
echo VT pfet_01v8_hvt 1 0.15 $&@m.xpfet01v8hvt2.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt2.msky130_fd_pr__pfet_01v8_hvt[id] $&@m.xpfet01v8hvt2.msky130_fd_pr__pfet_01v8_hvt[cgg]
echo VT pfet_01v8_hvt 0.65 0.15 $&@m.xpfet01v8hvt3.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt3.msky130_fd_pr__pfet_01v8_hvt[id] $&@m.xpfet01v8hvt3.msky130_fd_pr__pfet_01v8_hvt[cgg]
echo VT pfet_01v8_hvt 1 1 $&@m.xpfet01v8hvt4.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt4.msky130_fd_pr__pfet_01v8_hvt[id] $&@m.xpfet01v8hvt4.msky130_fd_pr__pfet_01v8_hvt[cgg]
echo VT pfet_01v8_hvt 5 0.15 $&@m.xpfet01v8hvt5.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt5.msky130_fd_pr__pfet_01v8_hvt[id] $&@m.xpfet01v8hvt5.msky130_fd_pr__pfet_01v8_hvt[cgg]
echo VT pfet_01v8_hvt 0.42 0.35 $&@m.xpfet01v8hvt6.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt6.msky130_fd_pr__pfet_01v8_hvt[id] $&@m.xpfet01v8hvt6.msky130_fd_pr__pfet_01v8_hvt[cgg]
echo VT pfet_01v8_lvt 0.42 0.5 $&@m.xpfet01v8lvt1.msky130_fd_pr__pfet_01v8_lvt[vth] $&@m.xpfet01v8lvt1.msky130_fd_pr__pfet_01v8_lvt[id] $&@m.xpfet01v8lvt1.msky130_fd_pr__pfet_01v8_lvt[cgg]
echo VT pfet_01v8_lvt 1 1 $&@m.xpfet01v8lvt4.msky130_fd_pr__pfet_01v8_lvt[vth] $&@m.xpfet01v8lvt4.msky130_fd_pr__pfet_01v8_lvt[id] $&@m.xpfet01v8lvt4.msky130_fd_pr__pfet_01v8_lvt[cgg]
echo VT pfet_01v8_lvt 0.42 0.35 $&@m.xpfet01v8lvt6.msky130_fd_pr__pfet_01v8_lvt[vth] $&@m.xpfet01v8lvt6.msky130_fd_pr__pfet_01v8_lvt[id] $&@m.xpfet01v8lvt6.msky130_fd_pr__pfet_01v8_lvt[cgg]
quit
.endc
.end
