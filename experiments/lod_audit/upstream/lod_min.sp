* Minimal case: what the SKY130 model does with the diffusion length that the extracted netlist does not carry.
* nfet_01v8 W/L = 0.42/0.15, tt, 27 C. x0: as extracted (no sa/sb). x030 / x300: sa = sb = 0.30 / 3.0 um added by hand.
.lib PDKROOT/libs.tech/ngspice/sky130.lib.spice tt
.temp 27
Vg g 0 0.9
Vd d 0 0.05
X0   d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
X030 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=0.3 sb=0.3
X300 d g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 sa=3.0 sb=3.0
.control
op
let v0   = @m.x0.msky130_fd_pr__nfet_01v8[vth]
let v030 = @m.x030.msky130_fd_pr__nfet_01v8[vth]
let v300 = @m.x300.msky130_fd_pr__nfet_01v8[vth]
let i030 = @m.x030.msky130_fd_pr__nfet_01v8[id]
let i300 = @m.x300.msky130_fd_pr__nfet_01v8[id]
let dvth_mV = 1e3*(v030 - v300)
let id_ratio = i300/i030
print v0 v030 v300 dvth_mV id_ratio
.endc
.end
