"""MISFIT-19: corriente de un puesto con la puerta forzada (V_fg barrida), tres transistores, tres tensiones de X. Uso: gen.py -> op_<c>_<t>/m.sp
Cada barrido escribe op_<c>_<t>/f_<x>.txt con columnas (barrido, i(Vx1), i(Vx2), i(Vx3)); la corriente del puesto es -i. En la pasada 1 (pasada1/) escribi "-i(Vx1) -i(Vx2) -i(Vx3)" y ngspice lo tomo como una sola resta: una columna, inservible."""
import os
H = os.path.dirname(os.path.abspath(__file__)); CORN = [("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85")]
DEV = [("T1", "sky130_fd_pr__nfet_01v8 w=0.42 l=0.15"), ("T2", "sky130_fd_pr__nfet_01v8 w=1 l=0.5"), ("T3", "sky130_fd_pr__nfet_g5v0d10v5 w=0.42 l=0.5")]
XS = ["1.35", "0.9", "1.8"]
def deck(c, t):
    s = f"* MISFIT-19 puesto con puerta forzada, {c} {t} C\n.lib /pdk/libs.tech/ngspice/sky130.lib.spice {c}\n.options gmin=1e-18 abstol=1e-16 reltol=1e-6\n.temp {t}\nVfg fg 0 0\nVsel sel 0 1.8\n"
    for k, (n, d) in enumerate(DEV, 1):
        s += f"Vx{k} x{k} 0 1.35\nXd{k} x{k} fg m{k} 0 {d}\nXs{k} m{k} sel 0 0 sky130_fd_pr__nfet_01v8 w=0.84 l=0.15\n"
    s += ".control\nset noaskquit\nset numdgt=10\nset wr_singlescale\n"
    for x in XS:
        s += "".join(f"alter Vx{k} dc = {x}\n" for k in (1, 2, 3)) + f"dc Vfg 0 1.8 0.005\nwrdata f_{x}.txt i(Vx1) i(Vx2) i(Vx3)\necho HECHO {x}\n"
    return s + "quit\n.endc\n.end\n"
if __name__ == "__main__":
    for c, t in CORN:
        d = os.path.join(H, f"op_{c}_{t}"); os.makedirs(d, exist_ok=True); open(os.path.join(d, "m.sp"), "w").write(deck(c, t))
    print("ok")
