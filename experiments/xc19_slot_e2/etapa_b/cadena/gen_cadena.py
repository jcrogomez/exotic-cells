"""Etapa b, DISENO: VB de la cadena de xc19_bias (C1 a VDD: dos nfet 1/1 en serie + 16 espejos 0,42/0,15) con un diodo de ajuste
extra en serie, de ancho W (L = 1), cuerpo a GND, como los de la celda. Esquematico, .op. Uso: gen_cadena.py <esquina> <temp>"""
import sys
c, t = sys.argv[1], sys.argv[2]
W = [None, 1, 2, 4, 8, 16, 32, 64]
s = [f"* cadena {c} {t}", f".lib /pdk/libs.tech/ngspice/sky130.lib.spice {c}", f".temp {t}", ".options gmin=1e-15", "Vd vdd 0 1.8"]
for i, w in enumerate(W):
    p = f"k{i}"
    top = "vdd"
    if w is not None:
        s.append(f"X{p}t vdd vdd {p}_t 0 sky130_fd_pr__nfet_01v8 w={w} l=1"); top = f"{p}_t"
    s += [f"X{p}a {top} {top} {p}_c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1", f"X{p}b {p}_c2 {p}_c2 {p}_vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1"]
    s += [f"X{p}m{j} {p}_vb {p}_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15" for j in range(16)]
s += [".control", "op", "print " + " ".join(f"v(k{i}_vb)" for i in range(len(W))), "quit", ".endc", ".end"]
open(f"cad_{c}_{t}.sp", "w").write("\n".join(s) + "\n")
