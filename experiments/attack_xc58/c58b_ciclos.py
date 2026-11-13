#!/usr/bin/env python3
"""c58b ciclos: muestreo REPETIDO sobre el mismo nodo (ciclos sucesivos) con el mismo método de ruido que c58_trn.py
(fuente blanca 4kT·g(t) de equilibrio, g de dos réplicas). Sirve para: (1) autocorrelación entre muestras sucesivas del mismo
nodo; (2) traza de ejemplo de v(g) alrededor de la apertura. Lector extraído xc19_read + nfet 0,42/0,15, nodo mínimo (Cx=0),
tt, 27 C, VDD 1,8 V, fuente del interruptor a 0,3168 V ideal, punto inicial = .op de ngspice. Reloj: cerrado 0,3 ns, baja en
500 ps, abierto 0,3 ns, sube en 100 ps; periodo 1,2 ns. Muestra 'antes' 8 ps antes de empezar a bajar; 'después' 10 ps antes de subir.
Uso: python c58b_ciclos.py NINST NCICLOS SEMILLA [traza]"""
import subprocess, os, sys, numpy as np
P = os.environ["ZTASIC"]
PDK = P + "/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A"
HERE = os.path.dirname(os.path.abspath(__file__))
ninst, ncic, seed = int(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3]); traza = len(sys.argv) > 4
kT = 1.380649e-23 * 300.15; nt = 1.0; td, tf, pw, tr, per = 0.30037e-9, 0.5e-9, 0.3e-9, 0.1e-9, 1.2e-9
tag = f"c58b_ciclos_n{ninst}_c{ncic}_s{seed}" + ("_traza" if traza else "")
s = f"""* {tag}
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /cells/xc19_read/xc19_read.pex.spice
.options gmin=1e-18 abstol=1e-16 reltol=1e-5
.temp 27
Vdd vdd 0 1.8
Vsa sa 0 0.3168
Vclk clk 0 pulse(1.8 0 {td} {tf} {tr} {pw} {per})
Vpre0 pre0 0 0
Vr1 r1 sa 1m
Vr2 r2 sa -1m
Vm1 r1 r1m 0
Vm2 r2 r2m 0
Xr1 r1m clk sa 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 ad=0.126 pd=1.44 as=0.126 ps=1.44
Xr2 r2m clk sa 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 ad=0.126 pd=1.44 as=0.126 ps=1.44
Bg 0 gg I = (i(Vm1)-i(Vm2))/2m
Rgg gg 0 1
Cgg gg 0 0.2p
"""
for i in range(ninst):
    s += f"""Xs{i} sa clk g{i} 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 ad=0.126 pd=1.44 as=0.126 ps=1.44
Xa{i} g{i} pre0 x{i} vdd 0 xc19_read
Vn{i} n{i} 0 dc 0 trnoise(1 {nt}p 0 0)
Bn{i} sa g{i} I = v(n{i})*sqrt({2*kT/(nt*1e-12):.6e}*sqrt(v(gg)*v(gg)+1e-22))
"""
s += f".control\nset rndseed={seed}\ntran {nt}p {ncic*per}\n"
if traza:
    s += f"wrdata {tag}.dat v(clk) v(gg) " + " ".join(f"v(g{i})" for i in range(ninst)) + "\n"
else:
    for c in range(ncic):
        ta, tb = td - 8e-12 + c * per, td + tf + pw - 10e-12 + c * per
        for i in range(ninst):
            s += f"meas tran a find v(g{i}) at={ta:.6e}\nmeas tran b find v(g{i}) at={tb:.6e}\necho CIC {i} {c} $&a $&b\n"
s += "quit\n.endc\n.end\n"
open(f"{HERE}/{tag}.sp", "w").write(s)
sh = f"cd /w; ngspice -b {tag}.sp 2>&1 | grep -E '^CIC|too small|aborted' > {tag}.out"
subprocess.run(["docker", "run", "--rm", "-v", PDK + ":/pdk:ro", "-v", P + "/06_exotic_cells/cells:/cells:ro", "-v", HERE + ":/w",
                "hpretl/iic-osic-tools:2025.07", "--skip", "bash", "-c", sh], capture_output=True, text=True)
print(tag, "hecho")
