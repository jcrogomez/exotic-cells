#!/usr/bin/env python3
"""c62: sensibilidad de la corriente en inversión débil al largo dibujado, modelo del PDK (nfet_01v8 y pfet_01v8, tt, 27 C).
Genera c62_dvth.sp; correr con c62_dvth_run.sh; leer con c62_dvth_read.py"""
Ls = [0.150, 0.152, 0.155, 0.160, 0.165, 0.170, 0.180, 0.200, 0.250]
o = ["* c62 dVth/dL", ".lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt", ".temp 27", "Vg g 0 0", "Vgp gp 0 0",
     ".options gmin=1e-18 abstol=1e-18 reltol=1e-6"]
names = []
for i, L in enumerate(Ls):
    o.append(f"Vn{i} dn{i} 0 0.9"); o.append(f"Xn{i} dn{i} g 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l={L}")
    o.append(f"Vp{i} dp{i} 0 -0.9"); o.append(f"Xp{i} dp{i} gp 0 0 sky130_fd_pr__pfet_01v8 w=0.42 l={L}")
o += [".control", "dc Vg 0 0.6 0.01"]
o += ["wrdata c62_dvth_n.dat " + " ".join(f"i(Vn{i})" for i in range(len(Ls)))]
o += ["dc Vgp 0 -0.6 -0.01", "wrdata c62_dvth_p.dat " + " ".join(f"i(Vp{i})" for i in range(len(Ls))), "quit", ".endc", ".end"]
open("c62_dvth.sp", "w").write("\n".join(o) + "\n")
