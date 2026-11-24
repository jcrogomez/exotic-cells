* xc52 dciv fondo ss 27
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ss
.temp 27
.options gmin=1e-18 abstol=1e-16
Vsd sd 0 1.8
Vg g 0 0
Vw_a100 w_a100 0 1.4
Xa100 sd g sd w_a100 sky130_fd_pr__pfet_01v8 w=10 l=10 as=2.900 ad=2.900 ps=20.58 pd=20.58
Vw_a1000 w_a1000 0 1.4
Xa1000 sd g sd w_a1000 sky130_fd_pr__pfet_01v8 w=30 l=33.3 as=8.700 ad=8.700 ps=60.58 pd=60.58
.control
set noaskquit
alter Vw_a100 dc = 1.5
alter Vw_a1000 dc = 1.5
dc Vg 0 1.8 0.05
wrdata fondo_ss_27_vf30.txt -i(Vw_a100) -i(Vw_a1000)
alter Vw_a100 dc = 1.4
alter Vw_a1000 dc = 1.4
dc Vg 0 1.8 0.05
wrdata fondo_ss_27_vf40.txt -i(Vw_a100) -i(Vw_a1000)
alter Vw_a100 dc = 1.3
alter Vw_a1000 dc = 1.3
dc Vg 0 1.8 0.05
wrdata fondo_ss_27_vf50.txt -i(Vw_a100) -i(Vw_a1000)
quit
.endc
.end
