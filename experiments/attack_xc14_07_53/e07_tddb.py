"""e07_tddb.py — tiempo hasta la ruptura (TDDB) del óxido de 4,15 nm frente a la tensión de puerta y el área, en intervalos.

Ancla (LEÍDA DE FIGURA, fuente secundaria que compila datos de sus refs. [6],[10],[11]): Samadder & Mahapatra, «Tunneling
Leakage Current Dependent RDD Model Framework for Gate Oxide TDDB», SISPAD 2023, P-5, Fig. 9(a): «Normalized Mean T_BD» frente
a V_G, condensador NMOS en inversión (V_G > 0), área 5e-4 cm², 140 °C, Tox = 4,2 nm. https://in4.iue.tuwien.ac.at/pdfs/sispad2023/SISPAD2023_P-5.pdf
Puntos leídos a ojo (±0,05 V, ±0,2 déc). Para acumulación (V_G < 0), Fig. 10(a), 4,2 nm: la curva está ~0,5–0,6 V más arriba.
Pendiente de Weibull β a 4,15 nm: ~2 (Fig. 5 de la misma fuente; leído de figura), barrida 1,7–2,5.
Temperatura 140 → 27 °C: factor exp(Ea/k·(1/300−1/413)) con Ea barrida 0,3–0,8 eV: PARÁMETRO SUPUESTO (no leído).
Tres leyes de aceleración ajustadas a los mismos cuatro puntos: exponencial en V («E»), exponencial en 1/V («1/E»), potencia.
Salida: e07_tddb.txt, e07_tddb.png
"""
import numpy as np, os
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
HERE = os.path.dirname(os.path.abspath(__file__))
PTS = np.array([(4.60, 4e4), (4.70, 1.0e4), (4.85, 1.2e3), (5.20, 2.2e2)])  # NI, 4,2 nm, 140 °C, 5e-4 cm²
V, lt = PTS[:, 0], np.log10(PTS[:, 1])
A_REF = 5e-4 * 1e8  # µm²
k = 8.617e-5
models = {
    "E": (np.polyfit(V, lt, 1), lambda p, v: np.polyval(p, v)),
    "1/E": (np.polyfit(1 / V, lt, 1), lambda p, v: np.polyval(p, 1 / v)),
    "potencia": (np.polyfit(np.log10(V), lt, 1), lambda p, v: np.polyval(p, np.log10(v))),
}
lines = []
P = lambda s="": (lines.append(s), print(s))
for n, (p, f) in models.items():
    rms = np.sqrt(np.mean((f(p, V) - lt) ** 2))
    P(f"ajuste {n}: p = {p}, rms {rms:.2f} déc" + (f"  (exponente n = {-p[0]:.1f})" if n == "potencia" else "")
      + (f"  ({-p[0]:.2f} déc/V)" if n == "E" else ""))


def tbd(v, area_um2, beta, Ea, model, polar_shift=0.0):
    p, f = models[model]
    t140 = 10 ** f(p, v - polar_shift)
    tf = np.exp(Ea / k * (1 / 300.15 - 1 / 413.15))
    return t140 * (A_REF / area_um2) ** (1 / beta) * tf


P("\nt_BD medio a 27 °C, intervalo sobre {E, 1/E, potencia} × β ∈ {1,7; 2; 2,5} × Ea ∈ {0,3; 0,8} eV. Polaridad: puerta +")
P("(inversión n). Para puerta − (acumulación) restar ~0,5 V de efectividad (Fig. 10a). Segundos.")
Vs = [1.8, 2.5, 3.3, 3.9, 4.5, 5.0, 5.5, 6.0, 6.5, 7.0, 7.5, 8.0]
areas = [0.063, 1.0, 100.0, 1e4]
P(f"{'V':>5} " + " ".join(f"{'A='+str(a)+' µm²':>26}" for a in areas))
grid = {}
for v in Vs:
    row = []
    for a in areas:
        ts = [tbd(v, a, b, Ea, m) for m in models for b in (1.7, 2.0, 2.5) for Ea in (0.3, 0.8)]
        grid[(v, a)] = (min(ts), max(ts))
        row.append(f"[{min(ts):9.1e} – {max(ts):9.1e}]")
    P(f"{v:5.1f} " + " ".join(f"{r:>26}" for r in row))

P("\nTensión a la que t_BD (27 °C) = 1 ms, 1 s, 1 h, 10 años, para 1 µm² (intervalo sobre modelos, β, Ea):")
vv = np.linspace(1.5, 12, 2000)
for target, nm in ((1e-3, "1 ms"), (1.0, "1 s"), (3600, "1 h"), (3.156e8, "10 años")):
    vs = []
    for m in models:
        for b in (1.7, 2.0, 2.5):
            for Ea in (0.3, 0.8):
                t = tbd(vv, 1.0, b, Ea, m)
                i = np.argmin(np.abs(np.log10(t) - np.log10(target)))
                vs.append(vv[i])
    P(f"  {nm:>8}: V = {min(vs):.2f} – {max(vs):.2f} V")
P("\nComprobación de cordura: el ajuste exponencial en V da t_BD(1,8 V) del orden de "
  f"{tbd(1.8,1,2,0.3,'E'):.1e}–{tbd(1.8,1,2,0.8,'E'):.1e} s; lejos del ancla (4,6–5,2 V) los modelos divergen.")
with open(os.path.join(HERE, "e07_tddb.txt"), "w") as fo:
    fo.write("\n".join(lines) + "\n")

fig, ax = plt.subplots(figsize=(6.5, 4.5))
vv = np.linspace(1.8, 8, 300)
for m, c in zip(models, ("C0", "C1", "C2")):
    lo = np.min([tbd(vv, 1.0, b, Ea, m) for b in (1.7, 2.5) for Ea in (0.3, 0.8)], axis=0)
    hi = np.max([tbd(vv, 1.0, b, Ea, m) for b in (1.7, 2.5) for Ea in (0.3, 0.8)], axis=0)
    ax.fill_between(vv, lo, hi, color=c, alpha=0.3, label=f"{m}, 1 µm², 27 °C")
ax.semilogy(V, 10 ** lt, "ko", label="ancla leída (140 °C, 5e-4 cm²)")
for y, t in ((1e-3, "1 ms"), (3600, "1 h"), (3.156e8, "10 a")):
    ax.axhline(y, color="gray", lw=0.5); ax.text(7.3, y * 1.5, t, fontsize=7)
ax.axvline(3.3, ls=":", color="k"); ax.text(3.35, 1e-6, "3,3 V", fontsize=7)
ax.set_ylim(1e-8, 1e30); ax.set_xlabel("V puerta (V)"); ax.set_ylabel("t_BD medio (s)"); ax.legend(fontsize=7)
ax.set_title("e07: TDDB de 4,15 nm (intervalos)")
fig.tight_layout(); fig.savefig(os.path.join(HERE, "e07_tddb.png"), dpi=120)
