* frontera de bin: l en el borde lmin/lmax, con y sin sa/sb
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
Vgn gn 0 -0.9
Vdn dn 0 -0.05
Vg g 0 0.9
Vd d 0 0.05
xpfet01v8hvt0499sch dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.499 
xpfet01v8hvt0499sa03 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.499 sa=0.3 sb=0.3
xpfet01v8hvt04999sch dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.4999 
xpfet01v8hvt04999sa03 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.4999 sa=0.3 sb=0.3
xpfet01v8hvt05sch dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5 
xpfet01v8hvt05sa03 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5 sa=0.3 sb=0.3
xpfet01v8hvt05001sch dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5001 
xpfet01v8hvt05001sa03 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.5001 sa=0.3 sb=0.3
xpfet01v8hvt0501sch dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.501 
xpfet01v8hvt0501sa03 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.501 sa=0.3 sb=0.3
xpfet01v8hvt025sch dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.25 
xpfet01v8hvt025sa03 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.25 sa=0.3 sb=0.3
xpfet01v8hvt018sch dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.18 
xpfet01v8hvt018sa03 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=0.18 sa=0.3 sb=0.3
xpfet01v8hvt10sch dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=1.0 
xpfet01v8hvt10sa03 dn gn 0 0 sky130_fd_pr__pfet_01v8_hvt w=0.42 l=1.0 sa=0.3 sb=0.3
xnfet01v80499sch d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.499 
xnfet01v80499sa03 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.499 sa=0.3 sb=0.3
xnfet01v804999sch d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.4999 
xnfet01v804999sa03 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.4999 sa=0.3 sb=0.3
xnfet01v805sch d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.5 
xnfet01v805sa03 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.5 sa=0.3 sb=0.3
xnfet01v805001sch d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.5001 
xnfet01v805001sa03 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.5001 sa=0.3 sb=0.3
xnfet01v80501sch d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.501 
xnfet01v80501sa03 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.501 sa=0.3 sb=0.3
xnfet01v8025sch d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.25 
xnfet01v8025sa03 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.25 sa=0.3 sb=0.3
xnfet01v8018sch d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.18 
xnfet01v8018sa03 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.18 sa=0.3 sb=0.3
xnfet01v810sch d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=1.0 
xnfet01v810sa03 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=1.0 sa=0.3 sb=0.3
.control
op
echo VT pfet_01v8_hvt 0.499 sch $&@m.xpfet01v8hvt0499sch.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt0499sch.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.499 sa03 $&@m.xpfet01v8hvt0499sa03.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt0499sa03.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.4999 sch $&@m.xpfet01v8hvt04999sch.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt04999sch.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.4999 sa03 $&@m.xpfet01v8hvt04999sa03.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt04999sa03.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.5 sch $&@m.xpfet01v8hvt05sch.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt05sch.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.5 sa03 $&@m.xpfet01v8hvt05sa03.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt05sa03.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.5001 sch $&@m.xpfet01v8hvt05001sch.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt05001sch.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.5001 sa03 $&@m.xpfet01v8hvt05001sa03.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt05001sa03.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.501 sch $&@m.xpfet01v8hvt0501sch.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt0501sch.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.501 sa03 $&@m.xpfet01v8hvt0501sa03.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt0501sa03.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.25 sch $&@m.xpfet01v8hvt025sch.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt025sch.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.25 sa03 $&@m.xpfet01v8hvt025sa03.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt025sa03.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.18 sch $&@m.xpfet01v8hvt018sch.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt018sch.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 0.18 sa03 $&@m.xpfet01v8hvt018sa03.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt018sa03.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 1.0 sch $&@m.xpfet01v8hvt10sch.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt10sch.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT pfet_01v8_hvt 1.0 sa03 $&@m.xpfet01v8hvt10sa03.msky130_fd_pr__pfet_01v8_hvt[vth] $&@m.xpfet01v8hvt10sa03.msky130_fd_pr__pfet_01v8_hvt[id]
echo VT nfet_01v8 0.499 sch $&@m.xnfet01v80499sch.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v80499sch.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.499 sa03 $&@m.xnfet01v80499sa03.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v80499sa03.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.4999 sch $&@m.xnfet01v804999sch.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v804999sch.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.4999 sa03 $&@m.xnfet01v804999sa03.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v804999sa03.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.5 sch $&@m.xnfet01v805sch.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v805sch.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.5 sa03 $&@m.xnfet01v805sa03.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v805sa03.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.5001 sch $&@m.xnfet01v805001sch.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v805001sch.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.5001 sa03 $&@m.xnfet01v805001sa03.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v805001sa03.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.501 sch $&@m.xnfet01v80501sch.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v80501sch.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.501 sa03 $&@m.xnfet01v80501sa03.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v80501sa03.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.25 sch $&@m.xnfet01v8025sch.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v8025sch.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.25 sa03 $&@m.xnfet01v8025sa03.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v8025sa03.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.18 sch $&@m.xnfet01v8018sch.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v8018sch.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 0.18 sa03 $&@m.xnfet01v8018sa03.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v8018sa03.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 1.0 sch $&@m.xnfet01v810sch.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v810sch.msky130_fd_pr__nfet_01v8[id]
echo VT nfet_01v8 1.0 sa03 $&@m.xnfet01v810sa03.msky130_fd_pr__nfet_01v8[vth] $&@m.xnfet01v810sa03.msky130_fd_pr__nfet_01v8[id]
showmod m.xpfet01v8hvt05sa03.msky130_fd_pr__pfet_01v8_hvt : saref sbref lmin lmax
showmod m.xnfet01v805sa03.msky130_fd_pr__nfet_01v8 : saref sbref lmin lmax
quit
.endc
.end
