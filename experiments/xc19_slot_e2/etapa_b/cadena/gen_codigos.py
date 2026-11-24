"""Etapa b, DISENO: los 8 codigos de un ajuste de 3 bits (toma C1: 2 o 3 diodos 1/1 en serie; 2 bits: M espejos 0,42/0,15).
Codigos: 2 diodos con M = 16..512; 3 diodos con M = 1..16 (v2: relleno del hueco central).
Uso: gen_codigos.py <esquina> <temp>"""
import sys
c, t = sys.argv[1], sys.argv[2]
COD = [(2, 16), (2, 32), (2, 64), (2, 128), (2, 256), (2, 512), (3, 1), (3, 2), (3, 4), (3, 8), (3, 16)]
s = [f"* codigos {c} {t}", f".lib /pdk/libs.tech/ngspice/sky130.lib.spice {c}", f".temp {t}", ".options gmin=1e-15", "Vd vdd 0 1.8"]
for i, (nd, m) in enumerate(COD):
    p = f"k{i}"; prev = "vdd"
    for d in range(nd):
        nxt = f"{p}_vb" if d == nd - 1 else f"{p}_n{d}"
        s.append(f"X{p}d{d} {prev} {prev} {nxt} 0 sky130_fd_pr__nfet_01v8 w=1 l=1"); prev = nxt
    s.append(f"X{p}m {p}_vb {p}_vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m={m}")
s += [".control", "op", "print " + " ".join(f"v(k{i}_vb)" for i in range(len(COD))), "quit", ".endc", ".end"]
open(f"cod_{c}_{t}.sp", "w").write("\n".join(s) + "\n")
