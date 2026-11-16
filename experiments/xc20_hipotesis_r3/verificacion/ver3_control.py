#!/usr/bin/env python3
"""Holgura del estimador: compara la fila 'base' con sus controles (H=256, doble de datos, otra semilla, cabeza única),
pareado sobre el mismo mundo de prueba. Una cota más alta en el control = la base tenía al menos esa holgura.
Uso: ver3_control.py > ver3_control.txt"""
import os
import numpy as np


def fn(var, cal, rd, des, tag):
    return f"ver3_lt_{var}_{cal}_{rd}_{des}_{tag}.npz"


def pdiff(fa, fb, key):
    if not (os.path.exists(fa) and os.path.exists(fb)):
        return None
    A, B = np.load(fa), np.load(fb)
    if key not in A.files or key not in B.files:
        return None
    assert np.array_equal(A['lab'], B['lab'])
    lab = A['lab']
    x = A[key].astype(float) - B[key].astype(float)
    ok = np.isfinite(x)
    per = [x[(lab == j) & ok] for j in np.unique(lab) if ok[lab == j].any()]
    return np.mean([p.mean() for p in per]), np.sqrt(sum(p.var(ddof=1) / len(p) for p in per)) / len(per)

ROWS = [('W1', 'C3b', 'A2', 'E2'), ('W1', 'C3b', 'A2', 'E4'), ('W1', 'C3b', 'S10', 'E2'), ('W1', 'C3b', 'S10', 'E4')]
CTRL = ['h256', 'n2', 's2', 'soloM', 'soloK']
for var, cal, rd, des in ROWS:
    for c in CTRL:
        for k in ('ltM', 'ltT', 'ltK'):
            if c == 'soloM' and k == 'ltK':
                continue
            if c == 'soloK' and k != 'ltK':
                continue
            r = pdiff(fn(var, cal, rd, des, c), fn(var, cal, rd, des, 'base'), k)
            print(f"{var} {cal} {rd} {des} {c} − base {k}: " + ('[?]' if r is None else f"{r[0]:+.4f} ± {r[1]:.4f}"))
    # diferencia E4 − E2 (D5) en cada control
    for c in ['base'] + CTRL:
        for k in ('ltK', 'ltT'):
            r = pdiff(fn(var, cal, rd, 'E4', c), fn(var, cal, rd, 'E2', c), k)
            if r is not None and des == 'E4':
                print(f"   D5 en control {c}: {rd} E4 − E2 {k}: {r[0]:+.4f} ± {r[1]:.4f}")
