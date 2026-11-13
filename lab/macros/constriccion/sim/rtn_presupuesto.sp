* Presupuesto de lectura de RTN: anillo de 7 inv_1; una fuente dVth en serie con la entrada de la etapa 3 emula el desplazamiento
* de umbral de una trampa (q/(Cox W L) ~ 0,3 mV para 0,42x0,15 um). tt, 1,8 V, 27 C. Esquemático.
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.include /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.temp 27
VDD vdd 0 1.8
Xi1 n7 0 0 vdd vdd n1 sky130_fd_sc_hd__inv_1
Xi2 n1 0 0 vdd vdd n2 sky130_fd_sc_hd__inv_1
Vrtn n2 n2b dc 0
Xi3 n2b 0 0 vdd vdd n3 sky130_fd_sc_hd__inv_1
Xi4 n3 0 0 vdd vdd n4 sky130_fd_sc_hd__inv_1
Xi5 n4 0 0 vdd vdd n5 sky130_fd_sc_hd__inv_1
Xi6 n5 0 0 vdd vdd n6 sky130_fd_sc_hd__inv_1
Xi7 n6 0 0 vdd vdd n7 sky130_fd_sc_hd__inv_1
.ic v(n1)=0
.control
foreach dv 0 0.3m 3m 30m
  alter Vrtn dc = $dv
  tran 1p 120n uic
  meas tran t1 when v(n1)=0.9 rise=20
  meas tran t2 when v(n1)=0.9 rise=220
  let per = (t2-t1)/200
  let pps = per*1e12
  echo dVth=$dv periodo_ps= $&pps
end
quit
.endc
.end
