#!/usr/bin/env python3
"""Control determinista del diseño (a) D0, sin Monte Carlo: cuadratura 1D en el espacio de la lectura.

Reducción usada (y su cota):
- La térmica g (<= 2e-12 A) sumada al túnel o al puente en d = 0 cambia log10 I en <= 7e-5 décadas: se desprecia.
- Lector ancho: G da bajo piso en d0 y d27 (g <= 2e-12 está 2,7 décadas bajo 1 nA; con sigma = 0,5, 5,4 sigma);
  d27 tiene la misma distribución bajo T, R y G y es independiente de d0 salvo bajo G => solo d0 informa.
  (Bajo G, d0 y d27 comparten g, pero ambos son 'bajo piso' con probabilidad 1 - O(1e-8).)
- Lector XC26: d27 = log g + ruido, misma distribución bajo los tres. Bajo G, d0 lleva el mismo g; bajo T y R, d0 está
  sobre el techo (T >= 12 nA, R >= 18 uA) salvo ruido. G nunca alcanza el techo (2e-12 frente a 1,25e-9: 2,8 décadas).
  => Y se reduce a la clase de d0: 'patrón G' / saturado / legible alto; solo T puede dar 'legible alto'.
"""
import numpy as np
from scipy.stats import norm

LT = (np.log10(12e-9), np.log10(0.5e-3))
LR = (np.log10(1.8 / 1e5), np.log10(1.8 / 10))   # log10(V/R) a -1,8 V


def H(p):
    p = np.asarray(p, float); p = p[p > 0]
    return -np.sum(p * np.log2(p))


def dens_uniform_conv(y, lo, hi, s):
    return (norm.cdf((y - lo) / s) - norm.cdf((y - hi) / s)) / (hi - lo)


def p_below(c, lo, hi, s):   # P(a + e < c), a ~ U(lo,hi)
    f = lambda a: s * (a * norm.cdf(a) + norm.pdf(a))
    return (f((c - lo) / s) - f((c - hi) / s)) / (hi - lo)


def ancho(s):
    lf, lc = np.log10(1e-9), np.log10(1e-3)
    y = np.linspace(lf, lc, 400001); dy = y[1] - y[0]
    pT = dens_uniform_conv(y, *LT, s); pR = dens_uniform_conv(y, *LR, s)
    lowT, lowR = p_below(lf, *LT, s), p_below(lf, *LR, s)
    satT, satR = 1 - p_below(lc, *LT, s), 1 - p_below(lc, *LR, s)
    # G: siempre bajo piso
    pri = 1 / 3
    Hc = 0.0; acc = 0.0
    # clases discretas
    for pt, pr, pg in [(lowT, lowR, 1.0), (satT, satR, 0.0)]:
        tot = pri * (pt + pr + pg)
        if tot > 0:
            Hc += tot * H(np.array([pt, pr, pg]) / (pt + pr + pg)); acc += pri * max(pt, pr, pg)
    tot = pT + pR
    post = np.stack([pT, pR]) / np.where(tot > 0, tot, 1)
    hh = -np.sum(np.where(post > 0, post * np.log2(np.where(post > 0, post, 1)), 0), axis=0)
    w = np.ones_like(y); w[0] = w[-1] = 0.5
    Hc += pri * np.sum(w * tot * hh) * dy
    acc += pri * np.sum(w * np.maximum(pT, pR)) * dy
    return np.log2(3) - Hc, acc


def xc26(s):
    lc = np.log10(1.25e-9)
    q = 1 - p_below(lc, *LT, s)       # P(saturado | T)
    qr = 1 - p_below(lc, *LR, s)      # ~1
    pri = 1 / 3
    Hc = pri * (q + qr) * H(np.array([q, qr]) / (q + qr))
    acc = pri * (1 + max(q, qr) + (1 - q))   # G siempre; saturado -> el mayor; legible alto -> T
    return np.log2(3) - Hc, acc, q


if __name__ == '__main__':
    for s in (0.05, 0.5):
        Ia, aa = ancho(s)
        Ix, ax, q = xc26(s)
        print(f"sigma={s}: (a) XC26 I={Ix:.5f} bits acierto={ax:.5f} [P(sat|T)={q:.6f}] | "
              f"(a) ancho I={Ia:.5f} bits acierto={aa:.5f}")
    print("límite sigma->0: XC26 = log2(3)-2/3 =", np.log2(3) - 2 / 3)
