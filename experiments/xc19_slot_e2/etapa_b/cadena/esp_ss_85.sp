* espejos ss 85
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ss
.temp 85
.options gmin=1e-15
Vd vdd 0 1.8
Xk0a vdd vdd k0_c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk0b k0_c2 k0_c2 k0_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk0m k0_vb k0_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=16
Xk1a vdd vdd k1_c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk1b k1_c2 k1_c2 k1_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk1m k1_vb k1_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=32
Xk2a vdd vdd k2_c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk2b k2_c2 k2_c2 k2_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk2m k2_vb k2_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=64
Xk3a vdd vdd k3_c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk3b k3_c2 k3_c2 k3_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk3m k3_vb k3_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=128
Xk4a vdd vdd k4_c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk4b k4_c2 k4_c2 k4_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk4m k4_vb k4_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=256
.control
op
print v(k0_vb) v(k1_vb) v(k2_vb) v(k3_vb) v(k4_vb)
quit
.endc
.end
