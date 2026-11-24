"""XC-52 etapa 0: fondo del modelo SKY130 (sin trampas de interfaz: el modelo no las tiene) en la configuracion DCIV de un pfet.
S = D = 1,8 V, pozo = 1,8 - VF, puerta barrida 0-1,8 V. Corriente del pozo = lo que el lector veria sin senal DCIV.
Uso: gen_fondo.py <corner> <temp>  -> fondo_<corner>_<temp>.sp"""
import sys
c, t = sys.argv[1], sys.argv[2]
s = [f"* xc52 dciv fondo {c} {t}", f".lib /pdk/libs.tech/ngspice/sky130.lib.spice {c}", f".temp {t}", ".options gmin=1e-18 abstol=1e-16",
     "Vsd sd 0 1.8", "Vg g 0 0"]
DEV = [("a100", 10, 10), ("a1000", 30, 33.3)]
for n, w, l in DEV:
    s += [f"Vw_{n} w_{n} 0 1.4", f"X{n} sd g sd w_{n} sky130_fd_pr__pfet_01v8 w={w} l={l} as={w*0.29:.3f} ad={w*0.29:.3f} ps={2*w+0.58:.2f} pd={2*w+0.58:.2f}"]
s += [".control", "set noaskquit"]
for vf in (0.3, 0.4, 0.5):
    for n, _, _ in DEV: s += [f"alter Vw_{n} dc = {1.8 - vf}"]
    s += ["dc Vg 0 1.8 0.05", f"wrdata fondo_{c}_{t}_vf{int(vf*100)}.txt " + " ".join(f"-i(Vw_{n})" for n, _, _ in DEV)]
s += ["quit", ".endc", ".end"]
open(f"fondo_{c}_{t}.sp", "w").write("\n".join(s) + "\n")
