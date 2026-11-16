#!/usr/bin/env python3
"""Aporte incremental de cada separación de XC-20 (decisión de Juan del 2026-11-16), desde los volcados del verificador.

  E2 = base, d027, base85, d027_85, base0.9, sin unión 27/85 °C
  E3 = E2 + d054        -> aporte de 0,54 µm dado E2
  E4 = E2 + d054 + d108 -> aporte de 1,08 µm dado E3

ADVERTENCIA (la razón de esta tabla): cada valor es una diferencia entre dos cotas inferiores de Barber-Agakov. Cada cota es
válida, pero su resta NO es una cota de la diferencia verdadera: si la holgura de E2 es mayor que la de E4, la resta exagera.
El ± es el error de Monte Carlo pareado (mismos chips de prueba), no la holgura. La holgura de la diferencia solo se acota
empíricamente con los controles de capacidad (H 256, doble de datos, otra semilla), que existen para E2 y E4 pero no para E3.
Monotonía: E3 ⊂ E4, así que un aporte negativo más allá de 2σ invalida la fila del estimador.

Uso: incremento_separaciones.py  (desde esta carpeta; lee verificacion/ver3_lt_*.npz)
"""
import os
import numpy as np

V = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'verificacion')


def fn(var, rd, des, cal='C3b'):
    for t in ('base', 'unicos', 'd108p', 'd108'):   # d108p: W1 E2d108 pareada (300 k / 100 k); d108: W2
        f = os.path.join(V, f"ver3_lt_{var}_{cal}_{rd}_{des}_{t}.npz")
        if os.path.exists(f):
            return f
    return None


def pdiff(fa, fb, key):
    if fa is None or fb is None:
        return None
    A, B = np.load(fa), np.load(fb)
    if key not in A.files or key not in B.files:
        return None
    assert np.array_equal(A['lab'], B['lab']), 'mundos de prueba distintos'
    lab = A['lab']
    x = A[key].astype(float) - B[key].astype(float)
    ok = np.isfinite(x)
    per = [x[(lab == j) & ok] for j in np.unique(lab) if ok[lab == j].any()]
    m = np.mean([p.mean() for p in per])
    se = np.sqrt(sum(p.var(ddof=1) / len(p) for p in per)) / len(per)
    return m, se


def fmt(r, thr=0.05):
    if r is None:
        return '[?] (falta la fila)'
    m, se = r
    if m < -2 * se - 0.005:
        tag = 'INVÁLIDA (viola monotonía)'
    elif m >= thr and m > 2 * se:
        tag = '≥ 0,05 y > 2σ'
    else:
        tag = 'bajo umbral'
    return f"{m:+.4f} ± {se:.4f}  [{tag}]"


Q = {'W1': [('ltT', 'I(túnel;Y)'), ('ltK', 'I(Kbin;Y|túnel)'), ('ltM', 'I(M;Y)'), ('ltF', 'I(F/túnel res.;Y)')],
     'W1q1': [('ltT', 'I(túnel;Y)'), ('ltK', 'I(Kbin;Y|túnel)'), ('ltM', 'I(M;Y)')],
     'W2': [('ltsT', 'I(s_T;Y)'), ('ltK', 'I(Kbin;Y|túnel)'), ('ltsF', 'I(s_F;Y)'), ('ltM', 'I(clase;Y)')]}

print('# Aporte incremental por separación (diferencias de cotas de Barber-Agakov, pareadas; ver la advertencia del script)')
for var, qs in Q.items():
    for rd in ('A2', 'S10'):
        print(f"\n## {var} · lector {rd} · calibración C3b")
        for a, b, nm in (('E3', 'E2', '0,54 µm dado E2       (E3 − E2)'),
                         ('E4', 'E3', '1,08 µm dado E2 + 0,54 (E4 − E3)'),
                         ('E4', 'E2', 'las dos juntas         (E4 − E2)')):
            fa, fb = fn(var, rd, a), fn(var, rd, b)
            for k, lab in qs:
                print(f"{nm} · {lab:<20} {fmt(pdiff(fa, fb, k))}")
            r = pdiff(fb, fa, 'sdB')
            if r is not None:
                print(f"{nm} · {'estrechamiento d.t. log10 B (décadas)':<20} {r[0]:+.4f} ± {r[1]:.4f}")

# --- añadido 2026-11-16 (PREREG_E2d108.md): 1,08 µm sin 0,54 µm, y reparto de Shapley de dos componentes ---
print('\n# E2 + d108 y reparto de Shapley (PREREG_E2d108.md)')
print('# φ(0,54) = ½[(E3 − E2) + (E4 − E2d108)] · φ(1,08) = ½[(E2d108 − E2) + (E4 − E3)]; el ± de φ es pareado sobre los mismos chips')


def pshap(fs, key, terms):
    """Media estratificada y error pareado de una combinación lineal de filas (todas sobre los mismos chips de prueba)."""
    L = [np.load(fs[d]) for d in fs]
    lab = L[0]['lab']
    for X in L:
        assert np.array_equal(X['lab'], lab), 'mundos de prueba distintos'
    if any(key not in X.files for X in L):
        return None
    x = sum(c * np.load(fs[d])[key].astype(float) for d, c in terms)
    ok = np.isfinite(x)
    per = [x[(lab == j) & ok] for j in np.unique(lab) if ok[lab == j].any()]
    return np.mean([q.mean() for q in per]), np.sqrt(sum(q.var(ddof=1) / len(q) for q in per)) / len(per)


for var, qs in Q.items():
    if var == 'W1q1':
        continue
    for rd in ('A2', 'S10'):
        fs = {d: fn(var, rd, d) for d in ('E2', 'E3', 'E2d108', 'E4')}
        if None in fs.values():
            print(f"\n## {var} {rd}: [?] falta {[d for d, f in fs.items() if f is None]}")
            continue
        print(f"\n## {var} · lector {rd} · calibración C3b")
        for k, lab in qs:
            print(f"1,08 µm dado E2 (E2d108 − E2)   · {lab:<20} {fmt(pdiff(fs['E2d108'], fs['E2'], k))}")
            print(f"0,54 µm dado E2 + 1,08 (E4 − E2d108) · {lab:<20} {fmt(pdiff(fs['E4'], fs['E2d108'], k))}")
            a = pshap(fs, k, [('E3', .5), ('E2', -.5), ('E4', .5), ('E2d108', -.5)])
            b = pshap(fs, k, [('E2d108', .5), ('E2', -.5), ('E4', .5), ('E3', -.5)])
            if a and b:
                print(f"Shapley · {lab:<20} φ(0,54) = {a[0]:+.4f} ± {a[1]:.4f} · φ(1,08) = {b[0]:+.4f} ± {b[1]:.4f}")
