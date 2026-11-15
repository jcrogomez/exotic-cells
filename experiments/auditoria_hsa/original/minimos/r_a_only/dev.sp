* minimo: nfet_01v8 0.42/0.15 en varias formas, tt 27 C
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
Vg g 0 0.3
Vd d 0 0.05
Vdd dd 0 1.8
* 1 esquematico sin nada
Xs d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
* 2 con ad/as/pd/ps
Xa d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 ad=0.126 pd=1.44 as=0.126 ps=1.44
* 3 con sa/sb
Xl d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3 sb=0.3
* 4 extraido completo
Xx d g 0 0 sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
* 5 m=2
Xm d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=2
* 6 pfet hvt extraido
Xp dd g dd dd sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
.control
foreach vg 0.2 0.3 0.5 0.9 1.8
 alter vg dc = $vg
 op
 echo DEVID vg=$vg $&@m.xs.msky130_fd_pr__nfet_01v8[id] $&@m.xa.msky130_fd_pr__nfet_01v8[id] $&@m.xl.msky130_fd_pr__nfet_01v8[id] $&@m.xx.msky130_fd_pr__nfet_01v8[id] $&@m.xm.msky130_fd_pr__nfet_01v8[id]
 echo DEVVTH vg=$vg $&@m.xs.msky130_fd_pr__nfet_01v8[vth] $&@m.xa.msky130_fd_pr__nfet_01v8[vth] $&@m.xl.msky130_fd_pr__nfet_01v8[vth] $&@m.xx.msky130_fd_pr__nfet_01v8[vth] $&@m.xm.msky130_fd_pr__nfet_01v8[vth]
 echo DEVCAP vg=$vg $&@m.xs.msky130_fd_pr__nfet_01v8[cgg] $&@m.xa.msky130_fd_pr__nfet_01v8[cgg] $&@m.xx.msky130_fd_pr__nfet_01v8[cgg] $&@m.xs.msky130_fd_pr__nfet_01v8[cbd] $&@m.xa.msky130_fd_pr__nfet_01v8[cbd]
 echo DEVP vg=$vg $&@m.xp.msky130_fd_pr__pfet_01v8_hvt[id] $&@m.xp.msky130_fd_pr__pfet_01v8_hvt[vth]
end
quit
.endc
.end
