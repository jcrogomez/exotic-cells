#!/usr/bin/env python3
"""c58 mc: Monte Carlo propio (Langevin) de la apertura del interruptor con flanco finito.
Interruptor: interpolación EKV ajustada a la conductancia del nfet 0,42/0,15 del PDK (c58_swdc_27.dat, corrida ngspice).
Ruido: densidad 2kT(g_nodo + g_fuente) (= 4kTg en equilibrio; = 2q(If+Ir) en inversión débil, incluido el caso unidireccional).
Acoplo del reloj por Cov (cgso del modelo: 0,103 fF, c58_swdc_27_show.txt). NO incluye la carga de canal ni su capacidad
(eso lo cubre c58_trn.py con el modelo BSIM4). Supuestos: fuente rígida, C constante.
Salida: varianza congelada / (kT/C) para cada C, flanco y temperatura."""
import numpy as np
from scipy.optimize import least_squares
k, q = 1.380649e-23, 1.602176634e-19
d = np.loadtxt("c58_swdc_27.dat"); Vg, g = d[:, 0], d[:, 1] / 1e-3
m = g > 1e-13; Vs0 = 0.317
def G(p, Vg, Vt, Vs=Vs0):
    Is, VT0, n, th = p; x = ((Vg - VT0) / n - Vs) / Vt
    L = np.logaddexp(0, x / 2); sg = 1 / (1 + np.exp(-x / 2))
    return np.exp(Is) / Vt * L * sg / (1 + th * np.maximum(Vg - VT0 - n * Vs, 0))
Vt27 = k * 300.15 / q
fit = least_squares(lambda p: np.log(G(p, Vg[m], Vt27)) - np.log(g[m]), [np.log(1e-6), 0.6, 1.4, 0.5])
p = fit.x; rms = np.sqrt(np.mean(fit.fun ** 2))
print(f"ajuste EKV: Is={np.exp(p[0]):.3e} A  VT0={p[1]:.3f} V  n={p[2]:.3f}  theta={p[3]:.3f}/V  error rms en ln(g) {rms:.3f}; g(1,8 V)={g[-1]:.3e} S")
def sample(C, tf, T, Cov=0.103e-15, N=40000, steps=6000, Vb=Vs0, vdd=1.8, seed=1):
    rng = np.random.default_rng(seed); Vt = k * T / q
    Is, VT0, n, th = np.exp(p[0]), p[1], p[2], p[3]
    V = Vb + rng.normal(0, np.sqrt(k * T / C), N)
    dt = tf / steps; dVg = -vdd / steps
    for i in range(steps):
        vg = vdd + dVg * (i + 0.5)
        V += Cov / C * dVg
        mob = 1 / (1 + th * max(vg - VT0 - n * Vb, 0))
        xn = ((vg - VT0) / n - V) / Vt; xb = ((vg - VT0) / n - Vb) / Vt
        Ln = np.logaddexp(0, xn / 2); Lb = np.logaddexp(0, xb / 2)
        I = Is * mob * (Ln ** 2 - Lb ** 2)
        gn = Is * mob / Vt * Ln / (1 + np.exp(-xn / 2)); gb = Is * mob / Vt * Lb / (1 + np.exp(-xb / 2))
        gn = np.maximum(gn, 1e-30)
        e = np.exp(-gn * dt / C)
        Veq = V + I / gn
        V = Veq + (V - Veq) * e + np.sqrt(k * T * (gn + gb) / (2 * gn * C) * (1 - e * e)) * rng.normal(size=N)
        # límite a·dt<<1: Veq-(Veq-V)(1-a dt) = V + I dt/C ; varianza = 2kT(gn+gb) dt/(2C^2)·... = S_I dt /(2 C^2)
    r = np.var(V, ddof=1) / (k * T / C)
    z = (V - V.mean()) / V.std()
    return r, (V.mean() - Vb) * 1e3, (z ** 3).mean(), (z ** 4).mean() - 3
out = []
out.append("control (Cov=0, sin acoplo: el nodo nunca sale del equilibrio; debe dar 1,00 ± 0,007 con N=40000):")
for C in (1e-15, 10e-15): 
    r = sample(C, 500e-12, 300.15, Cov=0); out.append(f"  C={C*1e15:4.0f} fF tf=500p: var/(kT/C) = {r[0]:.3f}")
out.append("\nC_total   flanco    T(K)   var/(kT/C)   pedestal(mV, solo acoplo)   asimetria   curtosis-3")
for T in (300.15, 358.15):
    for C in (1e-15, 3e-15, 10e-15):
        for tf in (50e-12, 500e-12, 5e-9, 50e-9, 500e-9, 5e-6):
            if T > 301 and tf not in (500e-12, 50e-9): continue
            r = sample(C, tf, T); out.append(f"{C*1e15:5.0f} fF  {tf:8.1e}  {T:6.1f}  {r[0]:8.3f}   {r[1]:10.1f}   {r[2]:+.3f}   {r[3]:+.3f}")
out.append("\nbarrido de Cov (no publico en silicio; el modelo da 0,103 fF) con C=1 fF, T=300 K:")
for Cov in (0.05e-15, 0.103e-15, 0.2e-15, 0.4e-15):
    for tf in (500e-12, 50e-9):
        r = sample(1e-15, tf, 300.15, Cov=Cov); out.append(f"  Cov={Cov*1e15:.3f} fF tf={tf:.1e}: var/(kT/C) = {r[0]:.3f}  pedestal {r[1]:.1f} mV")
print("\n".join(out)); open("c58_mc.txt", "w").write(f"ajuste EKV: Is={np.exp(p[0]):.3e} VT0={p[1]:.3f} n={p[2]:.3f} theta={p[3]:.3f} rms ln(g)={rms:.3f}\n" + "\n".join(out) + "\n")
