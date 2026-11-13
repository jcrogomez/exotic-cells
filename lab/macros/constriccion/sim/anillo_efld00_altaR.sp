* EFLD-00: anillo de lectura tal como está en el RTL (nand2_1, inv_1, ebufn_1 -> A, R A-B, 32 cargas inv_1 en B, inv_1, 10 inv_1, buf_2)
* más 8 ebufn_8 por lado en alta impedancia (su capacidad de drenador cuenta). tt, 1.8 V, 27 C. R barrida hasta abierto.
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.include /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.temp 27
VDD vdd 0 1.8
VEN en 0 pwl(0 0 1n 0 1.1n 1.8)
Xn0 en fb 0 0 vdd vdd s1 sky130_fd_sc_hd__nand2_1
Xi1 s1 0 0 vdd vdd s2 sky130_fd_sc_hd__inv_1
Xeb s2 0 0 0 vdd vdd nA sky130_fd_sc_hd__ebufn_1
Rl nA nB 10
Xi3 nB 0 0 vdd vdd c0 sky130_fd_sc_hd__inv_1
Xc1 c0 0 0 vdd vdd c1 sky130_fd_sc_hd__inv_1
Xc2 c1 0 0 vdd vdd c2 sky130_fd_sc_hd__inv_1
Xc3 c2 0 0 vdd vdd c3 sky130_fd_sc_hd__inv_1
Xc4 c3 0 0 vdd vdd c4 sky130_fd_sc_hd__inv_1
Xc5 c4 0 0 vdd vdd c5 sky130_fd_sc_hd__inv_1
Xc6 c5 0 0 vdd vdd c6 sky130_fd_sc_hd__inv_1
Xc7 c6 0 0 vdd vdd c7 sky130_fd_sc_hd__inv_1
Xc8 c7 0 0 vdd vdd c8 sky130_fd_sc_hd__inv_1
Xc9 c8 0 0 vdd vdd c9 sky130_fd_sc_hd__inv_1
Xc10 c9 0 0 vdd vdd fb sky130_fd_sc_hd__inv_1
Xob c0 0 0 vdd vdd osc sky130_fd_sc_hd__buf_2
* 32 cargas en B
.subckt carga32 n vdd
.param k=0
Xl1 n 0 0 vdd vdd q1 sky130_fd_sc_hd__inv_1
Xl2 n 0 0 vdd vdd q2 sky130_fd_sc_hd__inv_1
Xl3 n 0 0 vdd vdd q3 sky130_fd_sc_hd__inv_1
Xl4 n 0 0 vdd vdd q4 sky130_fd_sc_hd__inv_1
Xl5 n 0 0 vdd vdd q5 sky130_fd_sc_hd__inv_1
Xl6 n 0 0 vdd vdd q6 sky130_fd_sc_hd__inv_1
Xl7 n 0 0 vdd vdd q7 sky130_fd_sc_hd__inv_1
Xl8 n 0 0 vdd vdd q8 sky130_fd_sc_hd__inv_1
.ends
Xg1 nB vdd carga32
Xg2 nB vdd carga32
Xg3 nB vdd carga32
Xg4 nB vdd carga32
* drivers de formación en Z (TE_B=1)
VHI hi 0 1.8
.subckt drv8z a te n vdd
Xd1 a te 0 0 vdd vdd n sky130_fd_sc_hd__ebufn_8
Xd2 a te 0 0 vdd vdd n sky130_fd_sc_hd__ebufn_8
Xd3 a te 0 0 vdd vdd n sky130_fd_sc_hd__ebufn_8
Xd4 a te 0 0 vdd vdd n sky130_fd_sc_hd__ebufn_8
Xd5 a te 0 0 vdd vdd n sky130_fd_sc_hd__ebufn_8
Xd6 a te 0 0 vdd vdd n sky130_fd_sc_hd__ebufn_8
Xd7 a te 0 0 vdd vdd n sky130_fd_sc_hd__ebufn_8
Xd8 a te 0 0 vdd vdd n sky130_fd_sc_hd__ebufn_8
.ends
XdA hi hi nA vdd drv8z
XdB 0  hi nB vdd drv8z
.ic v(nB)=0 v(fb)=0
.control
set filetype=ascii
foreach r 30k 100k 300k 1meg 10meg 1g
  alter Rl resistance = $r
  tran 50p 3u uic
  meas tran tcross1 when v(osc)=0.9 rise=5
  meas tran tcross2 when v(osc)=0.9 rise=15
  let per = (tcross2 - tcross1)/10
  let idd = -i(VDD)
  meas tran iavg avg idd from=1u to=3u
  let fmhz = 1e-6/per
  let pps = per*1e12
  let iavgma = iavg*1000
  echo R=$r periodo_ps= $&pps f_MHz= $&fmhz Iavg_mA= $&iavgma
end
quit
.endc
.end
