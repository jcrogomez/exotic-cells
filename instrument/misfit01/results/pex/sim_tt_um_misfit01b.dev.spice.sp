* tt_um_misfit01b.dev.spice: tile extracted from the final GDS. clk 50 MHz; ui_in[0] toggles every 40 ns, away from the clock edge.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include tt_um_misfit01b.dev.spice
.temp 27
Vdd vdd 0 1.8
Vclk clk 0 pulse(0 1.8 10n 0.2n 0.2n 9.8n 20n)
Vrst rstn 0 pwl(0 0 25n 0 25.2n 1.8)
Vdin din 0 pulse(0 1.8 45n 0.2n 0.2n 39.8n 80n)
Xdut clk vdd rstn din 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 uio_oe[0] uio_oe[1] uio_oe[2] uio_oe[3] uio_oe[4] uio_oe[5] uio_oe[6] uio_oe[7] uio_out[0] uio_out[1] uio_out[2] uio_out[3] uio_out[4] uio_out[5] uio_out[6] uio_out[7] uo_out[0] uo_out[1] uo_out[2] uo_out[3] uo_out[4] uo_out[5] uo_out[6] uo_out[7] vdd 0 tt_um_misfit01b
C1 uo_out[1] 0 10f
C0 uo_out[0] 0 10f
.control
tran 50p 130n
meas tran y_reset find v(uo_out[1]) at=40n
meas tran y_after1 find v(uo_out[1]) at=68n
meas tran y_after0 find v(uo_out[1]) at=108n
meas tran q_after1 find v(uo_out[0]) at=88n
meas tran tfall trig v(clk) val=0.9 rise=3 targ v(uo_out[1]) val=0.9 fall=1
meas tran trise trig v(clk) val=0.9 rise=5 targ v(uo_out[1]) val=0.9 rise=1
echo TILE tt_um_misfit01b.dev.spice $&y_reset $&y_after1 $&y_after0 $&q_after1 $&tfall $&trise
quit
.endc
.end
