"""Etapa b, DISENO: VB de la cadena de xc19_bias (C1 a VDD, dos nfet 1/1) con M espejos 0,42/0,15 en paralelo (16 = la celda).
Esquematico, .op, conexion ideal (sin interruptores). Uso: gen_espejos.py <esquina> <temp>"""
import sys
c, t = sys.argv[1], sys.argv[2]
M = [16, 32, 64, 128, 256]
s = [f"* espejos {c} {t}", f".lib /pdk/libs.tech/ngspice/sky130.lib.spice {c}", f".temp {t}", ".options gmin=1e-15", "Vd vdd 0 1.8"]
for i, m in enumerate(M):
    p = f"k{i}"
    s += [f"X{p}a vdd vdd {p}_c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1", f"X{p}b {p}_c2 {p}_c2 {p}_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1",
          f"X{p}m {p}_vb {p}_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m={m}"]
s += [".control", "op", "print " + " ".join(f"v(k{i}_vb)" for i in range(len(M))), "quit", ".endc", ".end"]
open(f"esp_{c}_{t}.sp", "w").write("\n".join(s) + "\n")
