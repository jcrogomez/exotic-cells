* MISFIT-19 puesto con puerta forzada, ff -40 C
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ff
.options gmin=1e-18 abstol=1e-16 reltol=1e-6
.temp -40
Vfg fg 0 0
Vsel sel 0 1.8
Vx1 x1 0 1.35
Xd1 x1 fg m1 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xs1 m1 sel 0 0 sky130_fd_pr__nfet_01v8 w=0.84 l=0.15
Vx2 x2 0 1.35
Xd2 x2 fg m2 0 sky130_fd_pr__nfet_01v8 w=1 l=0.5
Xs2 m2 sel 0 0 sky130_fd_pr__nfet_01v8 w=0.84 l=0.15
Vx3 x3 0 1.35
Xd3 x3 fg m3 0 sky130_fd_pr__nfet_g5v0d10v5 w=0.42 l=0.5
Xs3 m3 sel 0 0 sky130_fd_pr__nfet_01v8 w=0.84 l=0.15
.control
set noaskquit
set numdgt=10
set wr_singlescale
alter Vx1 dc = 1.35
alter Vx2 dc = 1.35
alter Vx3 dc = 1.35
dc Vfg 0 1.8 0.005
wrdata f_1.35.txt i(Vx1) i(Vx2) i(Vx3)
echo HECHO 1.35
alter Vx1 dc = 0.9
alter Vx2 dc = 0.9
alter Vx3 dc = 0.9
dc Vfg 0 1.8 0.005
wrdata f_0.9.txt i(Vx1) i(Vx2) i(Vx3)
echo HECHO 0.9
alter Vx1 dc = 1.8
alter Vx2 dc = 1.8
alter Vx3 dc = 1.8
dc Vfg 0 1.8 0.005
wrdata f_1.8.txt i(Vx1) i(Vx2) i(Vx3)
echo HECHO 1.8
quit
.endc
.end
