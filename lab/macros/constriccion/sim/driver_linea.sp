* Corriente que N buf_16 en paralelo meten en una línea de resistencia R a tierra (DC, tt, 1.8 V, 27 C)
.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.include /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.param R=10 N=1
.temp 27
VDD vdd 0 1.8
VIN in 0 1.8
* N buffers en paralelo: se instancian 8 y se conectan según N por interruptores ideales no; mejor: salida compartida, m=N
Xb out in vdd 0 vdd 0 sky130_fd_sc_hd__buf_16 m=N
Rl out 0 {R}
.control
set wr_vecnames
foreach n 1 2 4 8
  foreach r 1 3 10 30 100 300 750
    alterparam N=$n
    alterparam R=$r
    reset
    op
    let i = -i(VDD)
    let vo = v(out)
    echo N=$n R=$r I_mA= $&i*1000 Vout= $&vo
  end
end
quit
.endc
.end
