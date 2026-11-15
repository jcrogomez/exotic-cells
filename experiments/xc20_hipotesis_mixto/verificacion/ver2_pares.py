#!/usr/bin/env python3
"""Diferencias pareadas entre corridas de B (mismas lecturas de prueba: semilla 2000 => mismos chips, mismo g, δ, ε
estándar en todas las calibraciones y lectores). Uso: ver2_pares.py  (lista fija abajo)."""
import os
import numpy as np


def f(var, cal, rd, H=128, s=1):
    return f"ver2_lt_{var}_{cal}_{rd}_H{H}_s{s}.npz"


PAIRS = [
    # D3: lector ancho frente a XC26 en D0 + -0,9 V
    *[(f('V4', c, 'ancho'), 'D0+-0.9V', f('V4', c, 'XC26'), 'D0+-0.9V', f'D3 {c}: ancho - XC26 (D0+-0.9V)')
      for c in ('C0_0.05', 'C0_0.5', 'C1', 'C2')],
    # Predicción 5: C2 frente a C1
    (f('V4', 'C1', 'ancho'), 'D0+85C', f('V4', 'C2', 'ancho'), 'D0+85C', 'P5: C1 - C2, D0+85C (ancho)'),
    (f('V4', 'C1', 'ancho'), 'D0+-0.9V', f('V4', 'C2', 'ancho'), 'D0+-0.9V', 'P5: C1 - C2, D0+-0.9V (ancho)'),
    # efecto del túnel en d=0,27 (V0 frente a V0 con K infinito): no pareable (distintos chips) -> no se lista
]

for a, da, b, db, lab in PAIRS:
    if not (os.path.exists(a) and os.path.exists(b)):
        print(f"{lab}: falta {a if not os.path.exists(a) else b}")
        continue
    A = np.load(a); B = np.load(b)
    assert np.array_equal(A['yte'], B['yte'])
    yt = A['yte']; C = int(yt.max()) + 1
    x = A[da].astype(float) - B[db].astype(float)
    per = [x[yt == j] for j in range(C)]
    m = np.mean([p.mean() for p in per]); se = np.sqrt(sum(p.var(ddof=1) / len(p) for p in per)) / C
    print(f"{lab}: {m:+.4f} ± {se:.4f} bits (diferencia de cotas, pareada)")
