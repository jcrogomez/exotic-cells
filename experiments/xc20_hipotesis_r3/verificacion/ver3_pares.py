#!/usr/bin/env python3
"""Diferencias pareadas entre filas del verificador (mismo mundo de prueba => mismos chips, mismas normales).
Media estratificada por clase verdadera, error típico pareado. Uso: ver3_pares.py [etiqueta=base] > ver3_pares.txt"""
import os, sys
import numpy as np

TAG = sys.argv[1] if len(sys.argv) > 1 else 'base'


def fn(var, cal, rd, des, tag=TAG):
    """Busca la fila con la etiqueta dada; si no existe, en las corridas complementarias del mismo mundo de prueba."""
    for t in (tag, 'unicos', 'calib'):
        f = f"ver3_lt_{var}_{cal}_{rd}_{des}_{t}.npz"
        if os.path.exists(f):
            return f
    return f"ver3_lt_{var}_{cal}_{rd}_{des}_{tag}.npz"


def load(f):
    return np.load(f) if os.path.exists(f) else None


def pdiff(fa, fb, key, keyb=None, sign=1.0):
    A, B = load(fa), load(fb)
    if A is None or B is None:
        return None
    keyb = keyb or key
    if key not in A.files or keyb not in B.files:
        return None
    assert np.array_equal(A['lab'], B['lab'])
    lab = A['lab']
    x = sign * (A[key].astype(float) - B[keyb].astype(float))
    ok = np.isfinite(x)
    cl = [j for j in np.unique(lab) if ok[lab == j].any()]
    per = [x[(lab == j) & ok] for j in cl]
    m = np.mean([p.mean() for p in per]); se = np.sqrt(sum(p.var(ddof=1) / len(p) for p in per)) / len(per)
    return m, se


def show(lab, r, thr=0.05):
    if r is None:
        print(f"{lab}: [?] (falta la fila)")
        return
    m, se = r
    tag = '≥0,05 y >2σ' if (m >= thr and m > 2 * se) else ('≤−0,05 y >2σ' if (m <= -thr and -m > 2 * se) else 'bajo umbral')
    print(f"{lab}: {m:+.4f} ± {se:.4f}  [{tag}]")


Q = {'ltM': 'I(M;Y)', 'ltT': 'I(túnel;Y)', 'ltK': 'I(Kbin;Y|túnel)', 'ltF': 'I(F/túnel res.;Y)', 'ltq': 'I(qbin;Y|túnel)',
     'ltsT': 'I(s_T;Y)', 'ltsR': 'I(s_R;Y)', 'ltsF': 'I(s_F;Y)'}

print("## D5 (E4 − E2, C3b)")
for var in ('W1', 'W2', 'W1q1'):
    for rd in ('A2', 'S10'):
        for k in (('ltT', 'ltK', 'ltF') if var != 'W2' else ('ltsT', 'ltK', 'ltF', 'ltsF')):
            show(f"{var} {rd} {Q[k]}", pdiff(fn(var, 'C3b', rd, 'E4'), fn(var, 'C3b', rd, 'E2'), k))
        show(f"{var} {rd} estrechamiento d.t. log10 B (E2 − E4, décadas)",
             pdiff(fn(var, 'C3b', rd, 'E2'), fn(var, 'C3b', rd, 'E4'), 'sdB'), thr=0.3)
        show(f"{var} {rd} I(qbin;Y|túnel) E4 − E2", pdiff(fn(var, 'C3b', rd, 'E4'), fn(var, 'C3b', rd, 'E2'), 'ltq'))
print("## D5 extra: E3 − E2 y E5 − E4 (W1, C3b)")
for rd in ('A2', 'S10'):
    for k in ('ltT', 'ltK', 'ltF', 'ltM'):
        show(f"W1 {rd} E3−E2 {Q[k]}", pdiff(fn('W1', 'C3b', rd, 'E3'), fn('W1', 'C3b', rd, 'E2'), k))
        show(f"W1 {rd} E5−E4 {Q[k]}", pdiff(fn('W1', 'C3b', rd, 'E5'), fn('W1', 'C3b', rd, 'E4'), k))
print("## D6 (E2 − E1, C3b)")
for var in ('W1', 'W2'):
    for rd in ('A2', 'S10'):
        for k in ('ltM', 'ltK'):
            show(f"{var} {rd} {Q[k]}", pdiff(fn(var, 'C3b', rd, 'E2'), fn(var, 'C3b', rd, 'E1'), k))
print("## D7 (S_f − A2, C3b), I(M;Y) e I(Kbin|túnel)")
for var in ('W1', 'W2', 'W1K6'):
    for des in ('E1', 'E2', 'E4'):
        for f in (1, 10, 100):
            for k in ('ltM', 'ltK'):
                r = pdiff(fn(var, 'C3b', f'S{f}', des), fn(var, 'C3b', 'A2', des), k)
                if r is not None:
                    show(f"{var} {des} S{f} − A2 {Q[k]}", r)
print("## D7 calibración: S10 − A2 con C1, C3a, C3c")
for cal in ('C1', 'C3a', 'C3b', 'C3c'):
    for des in ('E1', 'E2', 'E4'):
        for k in ('ltM', 'ltK'):
            r = pdiff(fn('W1', cal, 'S10', des), fn('W1', cal, 'A2', des), k)
            if r is not None:
                show(f"W1 {cal} {des} S10 − A2 {Q[k]}", r)
print("## P6: A2 con C1 frente a C3b (efecto de g_s, g_a independientes), y D8 con C1")
for des in ('E1', 'E2', 'E4'):
    for k in ('ltM', 'ltK'):
        show(f"W1 {des} A2: C1 − C3b {Q[k]}", pdiff(fn('W1', 'C1', 'A2', des), fn('W1', 'C3b', 'A2', des), k))
for des in ('E1', 'E4'):
    for u in ('X', 'A'):
        r = pdiff(fn('W1', 'C1', 'A2', des), fn('W1', 'C1', u, des), 'ltM')
        if r is not None:
            show(f"W1 C1 {des} A2 − {u}", r)
print("## D8 (A2 − X y A2 − A, C3b, I(M;Y))")
for var in ('W1', 'W1K6', 'W2'):
    for des in ('E1', 'E4'):
        for u in ('X', 'A'):
            r = pdiff(fn(var, 'C3b', 'A2', des), fn(var, 'C3b', u, des), 'ltM')
            if r is not None:
                show(f"{var} {des} A2 − {u}", r)
print("## P3 (W1K6, E4): S10 − A2 en I(Kbin|túnel)")
for des in ('E1', 'E4'):
    show(f"W1K6 {des} S10 − A2 I(Kbin|túnel)", pdiff(fn('W1K6', 'C3b', 'S10', des), fn('W1K6', 'C3b', 'A2', des), 'ltK'))
    show(f"W1K6 {des} S10 − A2 I(M;Y)", pdiff(fn('W1K6', 'C3b', 'S10', des), fn('W1K6', 'C3b', 'A2', des), 'ltM'))
print("## Mecanismo de la ganancia de K con q = 1: W1q1 frente a W1q1cut (túnel anulado en 0,54 y 1,08)")
for rd in ('A2', 'S10'):
    for v in ('W1q1', 'W1q1cut'):
        show(f"{v} {rd} E4 − E2 I(Kbin|túnel)", pdiff(fn(v, 'C3b', rd, 'E4'), fn(v, 'C3b', rd, 'E2'), 'ltK'))
    show(f"W1q1 − W1q1cut {rd} E4 I(Kbin|túnel) (mismos chips)", pdiff(fn('W1q1', 'C3b', rd, 'E4'), fn('W1q1cut', 'C3b', rd, 'E4'), 'ltK'))
print("## P4: E3 − E2 y E6 − E6c en I(F/túnel residual)")
for var in ('W1', 'W2'):
    for rd in ('A2', 'S10'):
        show(f"{var} {rd} E3 − E2", pdiff(fn(var, 'C3b', rd, 'E3'), fn(var, 'C3b', rd, 'E2'), 'ltF'))
        show(f"{var} {rd} E6 − E6c", pdiff(fn(var, 'C3b', rd, 'E6'), fn(var, 'C3b', rd, 'E6c'), 'ltF'))
        if var == 'W2':
            show(f"{var} {rd} E6 − E6c I(s_F;Y)", pdiff(fn(var, 'C3b', rd, 'E6'), fn(var, 'C3b', rd, 'E6c'), 'ltsF'))
print("## Monotonía (I(M;Y), siguiente − anterior; debe ser ≥ −(2σ + 0,005))")
for var in ('W1',):
    for rd in ('A2', 'S10'):
        seq = ['E1', 'E2', 'E3', 'E4', 'E5']
        for a, b in zip(seq[:-1], seq[1:]):
            for k in ('ltM', 'ltT', 'ltK', 'ltF'):
                r = pdiff(fn(var, 'C3b', rd, b), fn(var, 'C3b', rd, a), k)
                if r is not None:
                    m, se = r
                    print(f"{var} {rd} {b}−{a} {Q[k]}: {m:+.4f} ± {se:.4f} {'VIOLA' if m < -(2*se + 0.005) else 'ok'}")
