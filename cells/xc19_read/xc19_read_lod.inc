* NGSPICE file created from xc19_read.ext - technology: sky130A

.subckt xc19_read_lod VB PRE X VDD GND
X0 X VB GND GND sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15 sa=0.3 sb=0.3
X1 X PRE VDD VDD sky130_fd_pr__pfet_01v8_hvt ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.5 sa=0.3 sb=0.3
C0 PRE VB 0.00661f
C1 VDD X 0.06279f
C2 X VB 0.00733f
C3 PRE X 0.02021f
C4 VDD VB 0.00231f
C5 VDD PRE 0.16293f
C6 VB GND 0.22052f
C7 X GND 0.14564f
C8 PRE GND 0.11493f
C9 VDD GND 0.60151f
.ends

