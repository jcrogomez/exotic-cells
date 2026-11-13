* 1 buf_16 explícitos en paralelo contra una línea R a tierra. DC, tt, 1.8 V, 27 C.
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.include /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.temp 27
VDD vdd 0 1.8
VIN in 0 1.8
Xb1 in 0 0 vdd vdd out sky130_fd_sc_hd__buf_16
Rl out 0 10
.control
foreach r 1 3.6 10.4 30 100 410 1000
  alter Rl resistance = $r
  op
  let i = -i(VDD)
  echo N=1 R=$r I_mA= $&i*1000 Vout= $&v(out)
end
quit
.endc
.end
