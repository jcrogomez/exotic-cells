#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Aerial image (Abbe) of a metal line with a neck and of two facing line ends. Exploratory: see
cells/preregistros/XC-01_2026-11-12_litografia_imagen_aerea.md. Units: um. Dark-line binary mask, constant threshold."""
import numpy as np, itertools, sys
N, dx, LAM = 512, 0.01, 0.248
x = (np.arange(N) - N // 2) * dx
X, Y = np.meshgrid(x, x, indexing="ij")
f = np.fft.fftfreq(N, dx); FX, FY = np.meshgrid(f, f, indexing="ij")

def image(chrome, na, sigma, ns=7):
    T = np.fft.fft2(1.0 - chrome)
    s = np.linspace(-1, 1, ns); I = np.zeros((N, N)); n = 0
    for a, b in itertools.product(s, s):
        if a * a + b * b > 1.0001: continue
        fx, fy = a * sigma * na / LAM, b * sigma * na / LAM
        P = ((FX + fx) ** 2 + (FY + fy) ** 2) <= (na / LAM) ** 2
        I += np.abs(np.fft.ifft2(T * P)) ** 2; n += 1
    return I / n

def rect(x0, x1, y0, y1): return ((X >= x0) & (X < x1) & (Y >= y0) & (Y < y1)).astype(float)

def width_at(I, thr, ix):
    """printed (dark) width across y at column ix, around y = 0, sub-pixel"""
    c = I[ix, :]; j = N // 2
    if c[j] >= thr: return 0.0
    a = j
    while c[a] < thr: a -= 1
    b = j
    while c[b] < thr: b += 1
    ya = x[a] + (thr - c[a]) / (c[a + 1] - c[a]) * dx
    yb = x[b - 1] + (thr - c[b - 1]) / (c[b] - c[b - 1]) * dx
    return yb - ya

def neck(w, L, head=0.50, total=4.0):
    m = rect(-total / 2, -L / 2, -head / 2, head / 2) + rect(L / 2, total / 2, -head / 2, head / 2) + rect(-L / 2, L / 2, -w / 2, w / 2)
    return np.clip(m, 0, 1)

def ends(g, w, total=4.0):
    return rect(-total / 2, -g / 2, -w / 2, w / 2) + rect(g / 2, total / 2, -w / 2, w / 2)

out = []
for na, sg in [(0.60, 0.5), (0.60, 0.8), (0.70, 0.5), (0.70, 0.8)]:
    Iref = image(rect(-2.4, 2.4, -0.07, 0.07), na, sg)
    lo, hi = 0.0, 1.0
    for _ in range(40):                       # dose to size: long 0.14 line prints 0.14
        thr = (lo + hi) / 2
        if width_at(Iref, thr, N // 2) > 0.14: hi = thr
        else: lo = thr
    out.append(f"\nNA {na:.2f}  sigma {sg:.1f}  threshold {thr:.3f}  (0.25*lambda/NA = {0.25*LAM/na:.3f} um)")
    out.append("neck: drawn width x length -> printed width at the centre (0 = open)")
    for w in (0.14, 0.10, 0.07, 0.05):
        row = []
        for L in (0.07, 0.14, 0.30, 1.00):
            row.append(f"L={L:.2f}: {width_at(image(neck(w, L), na, sg), thr, N // 2):.3f}")
        out.append(f"  w={w:.2f}   " + "   ".join(row))
    out.append("facing ends: gap -> printed bridge width at the centre (0 = stays open); line width 0.14 and 0.50")
    for wl in (0.14, 0.50):
        row = [f"g={g:.2f}: {width_at(image(ends(g, wl), na, sg), thr, N // 2):.3f}" for g in (0.14, 0.10, 0.07, 0.05, 0.03)]
        out.append(f"  w={wl:.2f}   " + "   ".join(row))
open(sys.argv[1] if len(sys.argv) > 1 else "litho.txt", "w").write("\n".join(out) + "\n"); print("\n".join(out))
