#!/usr/bin/env python3
"""Compara A (cuasi-MC, verosimilitud) y B (cota con clasificador) muestra a muestra sobre las mismas lecturas.

E[log2 p_A(m|y) - log2 q_B(m|y)] estima la holgura de la cota B (si A es exacto) = E_y KL(p || q) >= 0.
Uso: ver2_cmp.py A.npz B.npz
"""
import sys
import numpy as np

A = np.load(sys.argv[1]); B = np.load(sys.argv[2])
sel = A['sel']; yt = A['yte']
assert np.array_equal(B['yte'][sel], yt)
C = int(yt.max()) + 1
for d in [k for k in A.files if k not in ('sel', 'yte')]:
    if d not in B.files:
        continue
    x = A[d].astype(float) - B[d][sel].astype(float)
    per = [x[yt == j] for j in range(C)]
    m = np.mean([p.mean() for p in per]); se = np.sqrt(sum(p.var(ddof=1) / len(p) for p in per)) / C
    print(f"{d:<14} A - B (bits) = {m:+.4f} ± {se:.4f}   por mecanismo: " + ' '.join(f"{p.mean():+.4f}" for p in per))
