* XC-19 bias noise, K = 4
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
Vdd vdd 0 1.8 ac 1
Xc0 vdd vdd c1 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc1 c1 c1 c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc2 c2 c2 vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc3 vb vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 mult=16
Cf vb 0 1p
.control
noise v(vb) Vdd dec 20 1 1e6
setplot noise2
let vn = sqrt(onoise_total)
echo NOISE 4 total_Vrms $&vn
setplot noise1
let s1 = onoise_spectrum[0]
let s2 = onoise_spectrum[60]
let s3 = onoise_spectrum[100]
echo NOISE 4 spectrum_V_per_rtHz_at_1Hz_1kHz_100kHz $&s1 $&s2 $&s3
quit
.endc
.end
