"""Control de la aritmética de los priors de la ronda 3 (§6 del PREREG), sin motor: solo log-uniformes.
Exacto por integración numérica en una rejilla fina más Monte Carlo de 10^6 muestras como cotejo.
Explica por qué cambian las fracciones respecto a la ronda 2 (añadido 2026-11-15, revisión externa)."""
import numpy as np
L = np.log10
T0 = (L(1.2e-8), L(5e-4))           # t0 log-U 12 nA – 0,5 mA (ronda 1 y 2)
XC = (L(150e-15), L(1.25e-9))        # piso y techo de XC26 a 27 °C
def frac(kmax, cond, n=4001):
    a = np.linspace(*T0, n)[:, None]; b = np.linspace(L(7e3), L(kmax), n)[None, :]
    return cond(a, b).mean()
def mc(kmax, cond, n=10**6, s=1):
    r = np.random.default_rng(s); return cond(r.uniform(*T0, n), r.uniform(L(7e3), L(kmax), n)).mean()
casos = [
    ("t0/K en 150 fA–1,25 nA", lambda a, b: (a - b > XC[0]) & (a - b < XC[1])),
    ("t0/K en 1 pA–1,25 nA (umbral del PREREG §6)", lambda a, b: (a - b > -12) & (a - b < XC[1])),
    ("t0/K ≥ 1,25 nA (satura XC26)", lambda a, b: a - b >= XC[1]),
    ("t0/K ≤ 1 pA", lambda a, b: a - b <= -12),
    ("t0/K² > 1 pA (d = 0,54, q = 1)", lambda a, b: a - 2 * b > -12),
    ("t0/K² > 150 fA", lambda a, b: a - 2 * b > XC[0]),
]
print("%-46s %14s %14s" % ("", "K ≤ 10^6 (r2)", "K ≤ 10^12 (r3)"))
for nom, c in casos:
    print("%-46s %7.4f/%.4f %7.4f/%.4f" % (nom, frac(1e6, c), mc(1e6, c), frac(1e12, c), mc(1e12, c)))
r = np.random.default_rng(2); n = 10**6
a, b, q = r.uniform(*T0, n), r.uniform(L(7e3), 12, n), r.uniform(0.5, 1.5, n)
print("t0·K^-(2^q) > 1 pA, q U 0,5–1,5, K ≤ 10^12: %.4f;  q = 0,5: %.4f" % ((a - 2**q * b > -12).mean(), (a - 2**0.5 * b > -12).mean()))
