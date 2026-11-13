#!/usr/bin/env python3
"""c58 mc2: por qué c58_trn.py (ngspice) da 0,68 de kT/C en el nodo mínimo y c58_mc.py da 0,92.
Hipótesis escrita antes de correr (2026-11-12, tras ver los dos números): la fuente de ruido de c58_trn.py es la de equilibrio,
4kT·g evaluada en la réplica (fuente y drenaje a la tensión de polarización); cuando el pedestal baja el nodo decenas de mV, el
interruptor real conduce en un solo sentido con conductancia del lado del nodo mucho mayor (amortigua) y ruido 2qI que la réplica
no ve. Predicción: el mismo Monte Carlo con ruido 'de réplica' (4kT·g_fuente) y Cov efectivo que reproduzca el pedestal de
ngspice (-154 mV con 0,96 fF -> Cov_ef ~0,125 fF) da 0,60-0,78; con el ruido completo, 0,86-0,92.
Si la variante 'réplica' NO baja de 0,85, la hipótesis es falsa y el 0,68 de ngspice sería física del modelo de carga."""
import numpy as np
k, q = 1.380649e-23, 1.602176634e-19
Is, VT0, n, th = 7.470e-07, 0.662, 1.312, -0.381      # ajuste de c58_mc.py (c58_mc.txt)
def sample(C, tf, T, Cov, mode, N=20000, steps=6000, Vb=0.317, vdd=1.8, seed=2):
    rng = np.random.default_rng(seed); Vt = k * T / q
    V = Vb + rng.normal(0, np.sqrt(k * T / C), N); dt = tf / steps; dVg = -vdd / steps
    for i in range(steps):
        vg = vdd + dVg * (i + 0.5); V += Cov / C * dVg
        mob = 1 / (1 + th * max(vg - VT0 - n * Vb, 0))
        xn = ((vg - VT0) / n - V) / Vt; xb = ((vg - VT0) / n - Vb) / Vt
        Ln = np.logaddexp(0, xn / 2); Lb = np.logaddexp(0, xb / 2)
        I = Is * mob * (Ln ** 2 - Lb ** 2)
        gn = np.maximum(Is * mob / Vt * Ln / (1 + np.exp(-xn / 2)), 1e-30); gb = Is * mob / Vt * Lb / (1 + np.exp(-xb / 2))
        e = np.exp(-gn * dt / C); Veq = V + I / gn
        S = (gn + gb) / 2 if mode == "completo" else gb          # S_I = 4kT·S
        V = Veq + (V - Veq) * e + np.sqrt(k * T * S / (gn * C) * (1 - e * e)) * rng.normal(size=N)
    return np.var(V, ddof=1) / (k * T / C), (V.mean() - Vb) * 1e3
L = []
for C, Cov in ((0.963e-15, 0.125e-15), (0.963e-15, 0.103e-15), (2.963e-15, 0.125e-15), (9.963e-15, 0.125e-15)):
    for mode in ("completo", "replica"):
        r = sample(C, 500e-12, 300.15, Cov, mode)
        L.append(f"C={C*1e15:.3f} fF Cov={Cov*1e15:.3f} fF tf=500p ruido={mode:9s}: var/(kT/C)={r[0]:.3f} pedestal {r[1]:.1f} mV")
print("\n".join(L)); open("c58_mc2.txt", "w").write("\n".join(L) + "\n")
