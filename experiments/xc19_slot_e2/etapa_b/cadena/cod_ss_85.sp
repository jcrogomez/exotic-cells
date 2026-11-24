* codigos ss 85
.lib /pdk/libs.tech/ngspice/sky130.lib.spice ss
.temp 85
.options gmin=1e-15
Vd vdd 0 1.8
Xk0d0 vdd vdd k0_n0 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk0d1 k0_n0 k0_n0 k0_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk0m k0_vb k0_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=16
Xk1d0 vdd vdd k1_n0 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk1d1 k1_n0 k1_n0 k1_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk1m k1_vb k1_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=32
Xk2d0 vdd vdd k2_n0 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk2d1 k2_n0 k2_n0 k2_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk2m k2_vb k2_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=64
Xk3d0 vdd vdd k3_n0 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk3d1 k3_n0 k3_n0 k3_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk3m k3_vb k3_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=128
Xk4d0 vdd vdd k4_n0 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk4d1 k4_n0 k4_n0 k4_n1 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk4d2 k4_n1 k4_n1 k4_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk4m k4_vb k4_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=2
Xk5d0 vdd vdd k5_n0 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk5d1 k5_n0 k5_n0 k5_n1 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk5d2 k5_n1 k5_n1 k5_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk5m k5_vb k5_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=4
Xk6d0 vdd vdd k6_n0 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk6d1 k6_n0 k6_n0 k6_n1 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk6d2 k6_n1 k6_n1 k6_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk6m k6_vb k6_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=8
Xk7d0 vdd vdd k7_n0 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk7d1 k7_n0 k7_n0 k7_n1 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk7d2 k7_n1 k7_n1 k7_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xk7m k7_vb k7_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=16
.control
op
print v(k0_vb) v(k1_vb) v(k2_vb) v(k3_vb) v(k4_vb) v(k5_vb) v(k6_vb) v(k7_vb)
quit
.endc
.end
