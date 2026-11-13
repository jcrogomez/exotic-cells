"""e14_toxsens.py — sensibilidad de la tensión residual de una puerta flotante (tras 6 meses de descarga por túnel) al
espesor local del óxido. Mismo modelo que e14_retention.py (phi = 3,1 eV y su ajuste; V0 = 0,25 V; Vi = 5 V).
Dispersión de espesor: parámetro de Monte Carlo del PDK local sky130_fd_pr__nfet_01v8__toxe_slope = 0.003443
(libs.tech/ngspice/parameters/invariant.spice l. 2796), usado en toxe = 4.148e-9*(1 + slope/sqrt(l*w*mult)·N(0,1)).
Unidades de l, w en esa expresión: µm (supuesto; [?]).
"""
import numpy as np, os
from scipy.integrate import solve_ivp
from e14_tunnel import J_model
HERE = os.path.dirname(os.path.abspath(__file__))
fits = np.load(os.path.join(HERE, "e14_tunnel_fits.npy"))
phi, mox, _, logC = fits[1]
COX0 = 3.9 * 8.8541878128e-12 * 1e-4
T6 = 182 * 86400.0
out = []
def V6(t_nm, r=1, V0=0.25, Vi=5.0):
    Vg = np.logspace(-3, np.log10(8), 300)
    lJ = np.log(np.maximum(J_model(t_nm * 10, Vg, mox, V0, logC, phi), 1e-300))
    cox = COX0 / (t_nm * 1e-9)
    f = lambda t, y: [-np.exp(np.interp(y[0], Vg, lJ)) / (cox * r)]
    return solve_ivp(f, (0, T6), [Vi], method="LSODA", rtol=1e-8, atol=1e-10).y[0][-1]
for r in (1, 100):
    a, b = V6(4.098, r), V6(4.198, r)
    s = (b - a) / 0.1
    out.append(f"r={r}: V(6 m) a 4,098 nm = {a:.4f} V; a 4,198 nm = {b:.4f} V; sensibilidad {s*1e3:.0f} mV/nm")
    for (w, l) in ((0.42, 0.15), (1, 1), (5, 5), (20, 20)):
        sig = 4.148 * 0.003443 / np.sqrt(w * l)
        out.append(f"   W×L={w}×{l} µm: σ(tox) = {sig*1e3:.2f} pm → σ(V6m) ≈ {abs(s)*sig*1e3:.1f} mV = {abs(s)*sig*1e3/0.305:.0f} pasos del lector")
print("\n".join(out)); open(os.path.join(HERE, "e14_toxsens.txt"), "w").write("\n".join(out) + "\n")
