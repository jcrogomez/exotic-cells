* EFLD-00: corriente de formación con N ebufn_8 por lado (lado A entrada 1, lado B entrada 0), línea R entre A y B. DC, tt, 27 C.
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.include /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.temp 27
VDD vdd 0 1.8
VHI hi 0 1.8
.param n=1
XA1 hi 0 0 0 vdd vdd nA sky130_fd_sc_hd__ebufn_8
XB1 0 0 0 0 vdd vdd nB sky130_fd_sc_hd__ebufn_8
XA2 hi teb2 0 0 vdd vdd nA sky130_fd_sc_hd__ebufn_8
XB2 0 teb2 0 0 vdd vdd nB sky130_fd_sc_hd__ebufn_8
XA3 hi teb4 0 0 vdd vdd nA sky130_fd_sc_hd__ebufn_8
XB3 0 teb4 0 0 vdd vdd nB sky130_fd_sc_hd__ebufn_8
XA4 hi teb4 0 0 vdd vdd nA sky130_fd_sc_hd__ebufn_8
XB4 0 teb4 0 0 vdd vdd nB sky130_fd_sc_hd__ebufn_8
XA5 hi teb8 0 0 vdd vdd nA sky130_fd_sc_hd__ebufn_8
XB5 0 teb8 0 0 vdd vdd nB sky130_fd_sc_hd__ebufn_8
XA6 hi teb8 0 0 vdd vdd nA sky130_fd_sc_hd__ebufn_8
XB6 0 teb8 0 0 vdd vdd nB sky130_fd_sc_hd__ebufn_8
XA7 hi teb8 0 0 vdd vdd nA sky130_fd_sc_hd__ebufn_8
XB7 0 teb8 0 0 vdd vdd nB sky130_fd_sc_hd__ebufn_8
XA8 hi teb8 0 0 vdd vdd nA sky130_fd_sc_hd__ebufn_8
XB8 0 teb8 0 0 vdd vdd nB sky130_fd_sc_hd__ebufn_8
VT2 teb2 0 1.8
VT4 teb4 0 1.8
VT8 teb8 0 1.8
Rl nA nB 10.4
.control
foreach cfg 1 2 4 8
  if $cfg = 1
    alter VT2 1.8
    alter VT4 1.8
    alter VT8 1.8
  end
  if $cfg = 2
    alter VT2 0
  end
  if $cfg = 4
    alter VT4 0
  end
  if $cfg = 8
    alter VT8 0
  end
  foreach r 3.6 10.4 100 1000 10k
    alter Rl resistance = $r
    op
    let il = i(Rl)
    let idd = -i(VDD)
    echo N=$cfg R=$r I_linea_mA= $&il*1000 I_VDD_mA= $&idd*1000 VA= $&v(nA) VB= $&v(nB)
  end
end
quit
.endc
.end
