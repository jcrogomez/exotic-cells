"""e14_retention.py — descarga de una puerta flotante por túnel a través de 4,148 nm de SiO2 (toxe de nfet_01v8, PDK local).

Usa el modelo ajustado de e14_tunnel.py (phi = 3,0/3,1/3,2 eV con su m_ox y C0 ajustados a Gupta 1997) y barre:
  V0  = parte de la tensión del nodo que NO cae en el óxido (banda plana, flexión de bandas, agotamiento del poly): 0 / 0,25 / 0,5 V.
        (El ajuste en régimen FN da V0 ≈ 1,15 V; la curva de túnel directo de 25,8 Å se reproduce con V0 ≈ 0. Es [?] para la
        puerta flotante real; se barre.)
  r   = C_total / C_óxido_de_túnel (1 = puerta sola; 10-1000 = placa de metal o condensador añadido que no fuga).
Supuesto: la carga de la puerta solo sale por el óxido; tensión del nodo medida respecto del pozo/sustrato bajo la puerta,
equilibrio en 0 V (niveles de Fermi alineados). Simétrico en polaridad: [?]. 27 °C.
Salida: e14_retention.txt, e14_retention.png
"""
import numpy as np, os
from scipy.integrate import solve_ivp
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from e14_tunnel import J_model

HERE = os.path.dirname(os.path.abspath(__file__))
COX = 3.9 * 8.8541878128e-12 / 4.148e-9 * 1e-4  # F/cm² = 8,32e-7
fits = np.load(os.path.join(HERE, "e14_tunnel_fits.npy"))  # phi, m_ox, V0fit, logC

# Tabla J(V) para interpolar rápido
Vg = np.logspace(-3, np.log10(8), 400)


def make_J(phi, mox, logC, V0):
    J = J_model(41.48, Vg, mox, V0, logC, phi)
    lJ = np.log(np.maximum(J, 1e-300))
    return lambda v: np.exp(np.interp(abs(v), Vg, lJ)) * np.sign(v)


DAY = 86400.0; YEAR = 3.156e7
T_OUT = np.array([1, 60, 3600, DAY, 30 * DAY, 182 * DAY, YEAR, 10 * YEAR])
names = ["1 s", "1 min", "1 h", "1 d", "30 d", "6 meses", "1 año", "10 años"]


def run(Jf, r, Vi):
    f = lambda t, y: [-Jf(y[0]) / (COX * r)]
    s = solve_ivp(f, (0, T_OUT[-1]), [Vi], t_eval=T_OUT, method="LSODA", rtol=1e-6, atol=1e-9)
    return s.y[0]


lines = []
P = lambda s="": (lines.append(s), print(s))
P(f"C_ox = {COX:.3e} F/cm² ({COX*1e-8*1e15:.2f} fF/µm²). τ local = C_ox·r·V/J(V).")
P("Constante de tiempo local τ(V) = C_ox·V/J(V) para r = 1 (puerta sola), por escenario (phi, V0):")
hdr = "   V   " + "  ".join(f"phi{p:.1f}/V0={v0:.2f}" for p in fits[:, 0] for v0 in (0.0, 0.25, 0.5))
P(hdr)
for v in (0.1, 0.2, 0.3, 0.5, 0.7, 1.0, 1.5, 1.8, 2.5, 3.3, 5.0):
    row = []
    for phi, mox, _, logC in fits:
        for V0 in (0.0, 0.25, 0.5):
            J = J_model(41.48, v, mox, V0, logC, phi)[0]
            row.append(COX * v / J)
    P(f"{v:5.2f} " + "  ".join(f"{x:15.2e}" for x in row))

P("\nV(t) del nodo (V) para varias tensiones iniciales; envolvente sobre phi y V0 ∈ {0; 0,25; 0,5}. Columnas: tiempos.")
P("r = C_total/C_óxido. Formato: [mín – máx]")
res = {}
for r in (1, 10, 100, 1000):
    for Vi in (1.8, 3.3, 5.0, 7.0):
        outs = []
        for phi, mox, _, logC in fits:
            for V0 in (0.0, 0.25, 0.5):
                outs.append(run(make_J(phi, mox, logC, V0), r, Vi))
        outs = np.array(outs); res[(r, Vi)] = outs
        P(f"r={r:5d} Vi={Vi:3.1f}: " + "; ".join(f"{n} [{outs[:,i].min():.2f}–{outs[:,i].max():.2f}]" for i, n in enumerate(names)))

# deriva al medir (6 meses tras fabricar) y su lectura con el paso de XC-19 (0,305 mV)
P("\nDeriva en el momento de medir (6 meses), r = 1 y r = 100, desde Vi = 5 V: dV/dt en mV/día y pasos de 0,305 mV por día")
for r in (1, 100):
    for k, (phi, mox, _, logC) in enumerate(fits):
        for j, V0 in enumerate((0.0, 0.25, 0.5)):
            v6 = res[(r, 5.0)][k * 3 + j, 5]
            Jf = make_J(phi, mox, logC, V0)
            d = Jf(v6) / (COX * r) * DAY * 1e3
            P(f"  r={r:4d} phi={phi:.1f} V0={V0:.2f}: V(6 m)={v6:.3f} V, deriva {d:.3g} mV/día = {d/0.305:.3g} pasos/día")

# Dispersión entre celdas: ¿recuerda la tensión inicial?
P("\nMemoria de la condición inicial: V(6 meses) con Vi = 3,3 / 5 / 7 V (phi=3,1, V0=0,25):")
for r in (1, 10, 100, 1000):
    k = 1 * 3 + 1
    P(f"  r={r:5d}: " + ", ".join(f"Vi={Vi}: {res[(r, Vi)][k, 5]:.4f} V" for Vi in (3.3, 5.0, 7.0)))

# Fuga de interruptor frente a túnel: área de cruce
P("\nÁrea de óxido a la que el túnel iguala la fuga de un interruptor nfet mínimo apagado (0,66 fA a 27 °C, c58, corrida")
P("de modelo): A = I_sw / J(V). Envolvente sobre escenarios.")
for v in (0.3, 0.5, 1.0, 1.5, 1.8):
    As = []
    for phi, mox, _, logC in fits:
        for V0 in (0.0, 0.25, 0.5):
            As.append(0.66e-15 / J_model(41.48, v, mox, V0, logC, phi)[0] * 1e8)  # µm²
    P(f"  V={v:.1f}: A_cruce = {min(As):.3g} – {max(As):.3g} µm²")

with open(os.path.join(HERE, "e14_retention.txt"), "w") as f:
    f.write("\n".join(lines) + "\n")

fig, ax = plt.subplots(figsize=(7, 4.5))
tt = np.logspace(-2, np.log10(10 * YEAR), 300)
phi, mox, _, logC = fits[1]
for r, c in zip((1, 100), ("C0", "C3")):
    for V0, ls in zip((0.0, 0.5), ("-", "--")):
        Jf = make_J(phi, mox, logC, V0)
        for Vi in (1.8, 5.0):
            s = solve_ivp(lambda t, y: [-Jf(y[0]) / (COX * r)], (0, tt[-1]), [Vi], t_eval=tt, method="LSODA", rtol=1e-6, atol=1e-9)
            ax.semilogx(tt, s.y[0], ls, color=c, lw=1, label=f"r={r}, V0={V0}, Vi={Vi}")
for tm, nm in ((DAY, "1 d"), (182 * DAY, "6 m"), (YEAR, "1 a")):
    ax.axvline(tm, color="gray", lw=0.5); ax.text(tm, 5.1, nm, fontsize=7)
ax.set_xlabel("t (s)"); ax.set_ylabel("V nodo (V)"); ax.legend(fontsize=6); ax.set_title("e14: puerta flotante 4,15 nm, phi=3,1 eV")
fig.tight_layout(); fig.savefig(os.path.join(HERE, "e14_retention.png"), dpi=120)
