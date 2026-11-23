#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""EXPLORATORIO (no prerregistrado): por qué fallan a2 y a3 en la etapa 2.
Varía por separado el muestreo de la fuente (ns) y el tamaño de la caja (N con dx fijo). NA 0,60 sigma 0,8 (peor caso de a2)."""
import sys, time, numpy as np
sys.path.insert(0, "../xc62_incremental")
from xc62inc import Grid, LG, cross
na, sg = 0.60, 0.8
def width(g, I, thr):
    iy = int(np.argmin(np.abs(g.x))); c = I[:, iy]; j = iy
    return cross(c, g.x, thr, j, +1, False) - cross(c, g.x, thr, j, -1, False)
def lines(w, s, m, length, trunc):
    out = []
    for k in range(-m, m + 1):
        xc = round(k * (w + s), 6)
        if abs(xc) <= trunc + 1e-9: out.append((xc - w / 2, xc + w / 2, -length / 2, length / 2))
    return out
def img(g, rects, ns):
    m = np.zeros((g.N, g.N))
    for r in rects: m += g.rect(*r)
    return g.image(np.clip(m, 0, 1), na, sg, ns=ns)
def thr_of(g, ns):
    I = g.image(g.rect(-LG / 2, LG / 2, -2.4, 2.4), na, sg, ns=ns); lo, hi = 0.0, 1.0
    for _ in range(40):
        t = (lo + hi) / 2
        if width(g, I, t) > LG: hi = t
        else: lo = t
    return t
print(time.strftime("%H:%M:%S"), "NA", na, "sigma", sg)
for N in (1024, 2048):
    g = Grid(N)
    for ns in (7, 13):
        thr = thr_of(g, ns)
        a = width(g, img(g, lines(0.15, 0.42, 3, 3.0, 1.2), ns), thr); b = width(g, img(g, lines(0.15, 0.42, 3, 3.0, 2.0), ns), thr)
        c = width(g, img(g, lines(0.15, 0.21, 3, 3.0, 1.2), ns), thr); d = width(g, img(g, lines(0.15, 0.21, 3, 4.5, 1.2), ns), thr)
        print(f"N={N} (caja {N*0.005:.2f} um) ns={ns}: umbral {thr:.4f} | a2 R1 s0.42: {abs(a-b)*1e3:.3f} nm | a3 densa: {abs(c-d)*1e3:.3f} nm", flush=True)
print(time.strftime("%H:%M:%S"))
