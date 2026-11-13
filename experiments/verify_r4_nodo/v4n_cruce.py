"""v4n_cruce.py — ¿por debajo de qué V_ox la fuga de un interruptor supera al túnel del óxido de la puerta?
I_ox = J(V_ox)·A_puerta (Tsu–Esaki propio, rejilla phi 3,0–3,2 / mox 0,40–0,50; y BSIM4 igc por defecto de v4n_igc.txt).
I_sw: nfet_01v8 apagado 0,42/0,15, simulado (v4n_interruptor.txt, gmin = 1e-20), ≈ 12–45 fA en 0,1–1,8 V; y el
valor 0,66 fA citado por c58 (no reproducido aquí). Se toma I_sw constante en V (cota: varía < 4× en el rango).
"""
import numpy as np
from v4n_tunel import J_tsu_esaki

Vs = np.arange(0.2, 4.01, 0.02)
grid = [(3.0, 0.40), (3.1, 0.45), (3.2, 0.50)]
Jte = {g: np.array([J_tsu_esaki(v, 4.15e-9, *g) for v in Vs]) for g in grid}
d = np.loadtxt("v4n_igc_def.txt")
Jb = np.interp(Vs, d[:, 0], d[:, 1])
out = []
for Isw in (0.66e-15, 25e-15):
    for A in (1.0, 10.0, 100.0, 1000.0):  # µm²
        Acm = A * 1e-8
        cr = []
        for g in grid:
            I = Jte[g] * Acm
            cr.append(Vs[np.argmax(I > Isw)] if (I > Isw).any() else np.nan)
        Ib = Jb * Acm
        cb = Vs[np.argmax(Ib > Isw)] if (Ib > Isw).any() and Vs[np.argmax(Ib > Isw)] <= 3.3 else np.nan
        out.append(f"I_sw={Isw*1e15:.2f} fA, A={A:.0f} um^2: V_ox de cruce TE (3.0/.40, 3.1/.45, 3.2/.50) = "
                   + ", ".join(f"{c:.2f}" for c in cr) + f" ; BSIM4 por defecto = {cb:.2f}")
txt = "\n".join(out)
print(txt)
open("v4n_cruce.txt", "w").write(txt + "\n")
