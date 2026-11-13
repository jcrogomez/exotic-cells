* Corriente por pareja alto/bajo de ebufn_2 y ebufn_4 (una celda por lado), línea R entre A y B. DC, tt, 27 C.
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.include /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.temp 27
VDD vdd 0 1.8
VHI hi 0 1.8
XA2 hi 0 0 0 vdd vdd a2 sky130_fd_sc_hd__ebufn_2
XB2 0 0 0 0 vdd vdd b2 sky130_fd_sc_hd__ebufn_2
R2 a2 b2 10.4
XA4 hi 0 0 0 vdd vdd a4 sky130_fd_sc_hd__ebufn_4
XB4 0 0 0 0 vdd vdd b4 sky130_fd_sc_hd__ebufn_4
R4 a4 b4 10.4
.control
foreach r 10.4 1000
  alter R2 resistance = $r
  alter R4 resistance = $r
  op
  let i2 = (v(a2)-v(b2))/$r
  let i4 = (v(a4)-v(b4))/$r
  echo R=$r ebufn_2_mA= $&i2*1000 ebufn_4_mA= $&i4*1000
end
quit
.endc
.end
