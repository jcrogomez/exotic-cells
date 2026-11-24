"""XC-52 etapa 0: fondo del modelo SKY130 (sin trampas de interfaz: el modelo no las tiene) en la configuracion DCIV de un pfet.
S = D = 1,8 V, pozo = 1,8 - VF, puerta barrida 0-1,8 V. Corriente del pozo = lo que el lector veria sin senal DCIV.
Uso: gen_fondo.py <corner> <temp>  -> fondo_<corner>_<temp>.sp"""
import sys
c, t = sys.argv[1], sys.argv[2]
s = [f"* xc52 dciv fondo {c} {t}", f".lib /pdk/libs.tech/ngspice/sky130.lib.spice {c}", f".temp {t}", ".options gmin=1e-18 abstol=1e-16",
     "Vsd sd 0 1.8", "Vg g 0 0"]
# v2: un wrdata por vector, sin signo menos (la v1 escribia "-i(a) -i(b)", que ngspice lee como UNA resta: su columna era la suma de los dos) y el diodo pozo-sustrato (ps2nw) aparte, en su propia fuente, con el
# pozo = dispositivo + 1,2 um de margen por lado (area y perimetro de diseno, no de dibujo: [?] hasta el layout)
DEV = [("a100", 10, 10), ("a1000", 30, 33.3)]
for n, w, l in DEV:
    lw, ww = l + 2 * 0.29 + 2 * 1.2, w + 2 * 1.2
    s += [f"Vw_{n} w_{n} 0 1.4", f"X{n} sd g sd w_{n} sky130_fd_pr__pfet_01v8 w={w} l={l} as={w*0.29:.3f} ad={w*0.29:.3f} ps={2*w+0.58:.2f} pd={2*w+0.58:.2f}",
          f"Vn_{n} wn_{n} 0 1.4", f"D{n} 0 wn_{n} sky130_fd_pr__model__parasitic__diode_ps2nw area={lw*ww:.2f} pj={2*(lw+ww):.2f}"]
s += [".control", "set noaskquit"]
for vf in (0.3, 0.4, 0.5):
    for n, _, _ in DEV: s += [f"alter Vw_{n} dc = {1.8 - vf}"]
    for n, _, _ in DEV: s += [f"alter Vn_{n} dc = {1.8 - vf}"]
    s += ["dc Vg 0 1.8 0.05"] + [f"wrdata fondo_{c}_{t}_vf{int(vf*100)}_{n}.txt i(Vw_{n}) i(Vn_{n})" for n, _, _ in DEV]
s += ["quit", ".endc", ".end"]
open(f"fondo_{c}_{t}.sp", "w").write("\n".join(s) + "\n")
