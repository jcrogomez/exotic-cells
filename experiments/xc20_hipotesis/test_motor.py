#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Pruebas del motor de hipótesis de XC-20 (motor.py) para la CI rápida. Escritas 2026-11-15.

    python3 experiments/xc20_hipotesis/test_motor.py        # numpy y scipy; ~10 s

Tres clases de prueba, separadas a propósito:
  A. Deterministas, sin Monte Carlo: fórmulas de corriente en sus límites analíticos, truncado del lector, normalización de la
     verosimilitud censurada, y resume() contra una información mutua calculada a mano en un canal discreto. Tolerancia de
     redondeo (1e-9 relativo), no estadística.
  B. Caso pequeño con solución exacta: el plan con el lector de XC-26 tiene I = log2 3 - 2/3 bits (T y R saturan siempre, G nunca;
     verificador, ver_INFORME.md). Se exige |estimado - exacto| <= 4 errores estándar + 1e-6 bits. En este caso las verosimilitudes
     internas son 0 o 1 (saturación a más de 20 sigmas), así que el Monte Carlo anidado no tiene sesgo apreciable: sale 0,918296.
  C. Monotonía: I(H; Y1, Y2) = I(H; Y1) + I(H; Y2 | Y1) >= I(H; Y1) es una identidad. Para el estimador se exige
     est(D + medida) - est(D) >= -4 sigma, con sigma el error estándar combinado de las dos estimaciones (independientes): una
     caída mayor es un fallo del estimador, no una fluctuación (más 1e-9 de redondeo: con los dos diseños en log2 3 el error
     estándar es 0). El primer estimador del prototipo la violaba con 0,48 bits
     («D0 + 85 C, ambos» 0,955 frente a 1,434), unas 40 sigmas.
  D. Coherencia bayesiana: el promedio sobre las lecturas simuladas de P(h | y) es el prior de h (ley de la probabilidad total).
     Se exige |media - prior| <= 4 errores estándar + 1e-9.
Mutaciones probadas a mano el 2026-11-15 (copia de motor.py en el scratchpad): invertir la cola saturada de la verosimilitud
censurada -> 13 fallos; ignorar el prior en resume() -> 1 fallo; quitar la normalización de G por las lecturas de d = 0,27 ->
0 fallos, y tampoco cambia ningún número del motor en estos diseños: G está separada de T y R por órdenes de magnitud y ese
factor no pesa. Es una mutación equivalente aquí; con mecanismos que se solapan (túnel + puente, punto 4) sí pesaría y hará
falta una prueba que la vea.
"""
import math, os, sys
import numpy as np

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import motor as M

fallos = []
def ok(nombre, cond, detalle):
    print(("ok   " if cond else "FAIL ") + nombre + ": " + detalle)
    if not cond:
        fallos.append(nombre)

def cerca(a, b, rel=1e-9):
    return np.all(np.abs(np.asarray(a) - np.asarray(b)) <= rel * np.maximum(np.abs(np.asarray(b)), 1e-300))

# ---------------- A. Deterministas ----------------
p = {"g0": np.array([1e-15]), "gea": np.array([0.8]), "gsh": np.array([1.2]),
     "t0": np.array([1e-6]), "tea": np.array([0.02]), "tsh": np.array([30.0]),
     "rb": np.array([1e4]), "tcr": np.array([0.003])}
arr = lambda ea: math.exp(ea / M.KB * M.ARR)
ok("A1 G a 27 C, -1,8 V es g0", cerca(M.corriente("G", p, "base", 1.8, 27), 1e-15), "")
ok("A2 G a 85 C sigue Arrhenius", cerca(M.corriente("G", p, "base", 1.8, 85), 1e-15 * arr(0.8)), "%.4g" % arr(0.8))
ok("A3 G a -0,9 V es g0/gsh", cerca(M.corriente("G", p, "base", 0.9, 27), 1e-15 / 1.2), "")
ok("A4 G igual en d=0 y d=0,27 (escala con el área)",
   cerca(M.corriente("G", p, "base", 1.8, 27), M.corriente("G", p, "d027", 1.8, 27)), "")
ok("A5 T en d=0,27 es solo la térmica", cerca(M.corriente("T", p, "d027", 1.8, 27), 1e-15), "")
ok("A6 T a -0,9 V: t0/tsh + g0/gsh", cerca(M.corriente("T", p, "base", 0.9, 27), 1e-6 / 30 + 1e-15 / 1.2), "")
ok("A7 T en el peine es x4 de la parte de túnel", cerca(M.corriente("T", p, "peine", 1.8, 27), 4e-6 + 1e-15), "")
ok("A8 T a 85 C", cerca(M.corriente("T", p, "base", 1.8, 85), 1e-6 * arr(0.02) + 1e-15 * arr(0.8)), "")
ok("A9 R óhmico: I(1,8)/I(0,9) = 2 sin la térmica",
   cerca(M.corriente_mec("R", p, "base", 1.8, 27) / M.corriente_mec("R", p, "base", 0.9, 27), 2.0), "")
ok("A10 R a 85 C baja por TCR", cerca(M.corriente_mec("R", p, "base", 1.8, 85), 1.8 / 1e4 / (1 + 0.003 * 58)), "")
ok("A11 R en d=0,27 es solo la térmica", cerca(M.corriente("R", p, "d027", 1.8, 27), 1e-15), "")

rng = np.random.default_rng(1)
piso, piso85, techo = M.LECTORES["XC26"]
y = M.lee(np.array([1e-20, 1e-6, 1e-11]), "XC26", 27, 1e-9, rng)
ok("A12 lector: bajo piso -> -inf, sobre techo -> +inf, dentro -> log10(I)",
   np.isneginf(y[0]) and np.isposinf(y[1]) and abs(y[2] + 11) < 1e-6, str(y))
# La verosimilitud censurada es una distribución: P(bajo piso) + integral de la densidad + P(saturado) = 1
for i_v in (1e-14, 1e-12, 1.2e-9, 1e-7):
    s = 0.3
    lo, hi = math.log10(piso), math.log10(techo)
    yy = np.linspace(lo, hi, 200001)[:, None]
    dens = np.exp(M.loglik(yy, np.array([[i_v]]), "XC26", 27, s))[:, 0]
    total = np.trapezoid(dens, yy[:, 0]) if hasattr(np, "trapezoid") else np.trapz(dens, yy[:, 0])
    total += math.exp(M.loglik(np.array([[-np.inf]]), np.array([[i_v]]), "XC26", 27, s)[0, 0])
    total += math.exp(M.loglik(np.array([[np.inf]]), np.array([[i_v]]), "XC26", 27, s)[0, 0])
    ok("A13 verosimilitud censurada suma 1, I = %.0e" % i_v, abs(total - 1) < 1e-6, "%.9f" % total)
ok("A14 saturado con I 20 sigmas sobre el techo: log p = 0",
   abs(M.loglik(np.array([[np.inf]]), np.array([[techo * 10]]), "XC26", 27, 0.05)[0, 0]) < 1e-12, "")

# resume() contra un canal discreto calculado a mano: tres hipótesis, salida en {0, 1, 2}
# p(y|T) = (0.8, 0.2, 0), p(y|R) = (0.2, 0.8, 0), p(y|G) = (0, 0, 1); muestras en proporción exacta (10 por hipótesis)
P = np.array([[0.8, 0.2, 0.0], [0.2, 0.8, 0.0], [0.0, 0.0, 1.0]])
ver, ys = [], []
for k in range(3):
    for j, n in enumerate((P[k] * 10).round().astype(int)):
        ver += [k] * n; ys += [j] * n
ver = np.array(ver)
logp = np.log(np.maximum(P[:, ys].T, 1e-300))
for prior in ((1 / 3, 1 / 3, 1 / 3), (0.6, 0.2, 0.2)):
    pr = np.array(prior)
    py = pr @ P
    exacto = sum(pr[k] * P[k, j] * math.log2(P[k, j] / py[j]) for k in range(3) for j in range(3) if P[k, j] > 0)
    acierto_exacto = sum(max(pr[k] * P[k, j] for k in range(3)) for j in range(3))
    b, e, a, c = M.resume(ver, logp, prior)
    ok("A15 resume(): información mutua exacta, prior %s" % str(prior), abs(b - exacto) < 1e-9, "%.9f vs %.9f" % (b, exacto))
    ok("A16 resume(): acierto del MAP exacto, prior %s" % str(prior), abs(a - acierto_exacto) < 1e-9, "%.6f vs %.6f" % (a, acierto_exacto))
ok("A17 resume(): matriz de confusión con prior uniforme", np.allclose(M.resume(ver, logp, (1/3, 1/3, 1/3))[3], P), "")

# ---------------- B. Caso con solución exacta ----------------
ver_, lp_ = M.logverosimilitudes(M.DISENOS["D0 plan: d=0 y d=0,27; -1,8 V; 27 C"], "XC26", 0.05, 300, 2000, semilla=11)
b, e, a, _ = M.resume(ver_, lp_, (1 / 3, 1 / 3, 1 / 3))
exacto = math.log2(3) - 2 / 3
ok("B1 plan con XC-26: I = log2 3 - 2/3", abs(b - exacto) <= 4 * e + 1e-6, "%.6f ± %.6f vs %.6f" % (b, e, exacto))

# ---------------- C. Monotonía al añadir medidas ----------------
D = M.DISENOS
pares = [("D0 plan: d=0 y d=0,27; -1,8 V; 27 C", "D0 + 85 C"),
         ("D0 plan: d=0 y d=0,27; -1,8 V; 27 C", "D0 + -0,9 V"),
         ("D0 + 85 C", "D0 + 85 C + -0,9 V"),
         ("D0 + -0,9 V", "D0 + 85 C + -0,9 V")]
cache = {}
def est(dn, lector, sigma, semilla):
    key = (dn, lector, sigma)
    if key not in cache:
        v, lp = M.logverosimilitudes(D[dn], lector, sigma, 300, 3000, semilla=semilla)
        cache[key] = M.resume(v, lp, (1 / 3, 1 / 3, 1 / 3))[:2]
    return cache[key]
for lector, sigma in (("ancho", 0.05), ("ancho", 0.5), ("ambos", 0.05)):
    for i, (d1, d2) in enumerate(pares):
        b1, e1 = est(d1, lector, sigma, 100 + i)
        b2, e2 = est(d2, lector, sigma, 200 + i)
        s = math.hypot(e1, e2)
        ok("C monotonía %s, sigma %.2f: %s -> %s" % (lector, sigma, d1.split(":")[0], d2),
           b2 - b1 >= -4 * s - 1e-9, "%+.4f bits (límite %.4f)" % (b2 - b1, -4 * s))

# ---------------- D. Media de la posterior = prior ----------------
for dn, lector, sigma, prior in (("D0 + 85 C", "ambos", 0.5, (1 / 3, 1 / 3, 1 / 3)),
                                 ("D0 plan: d=0 y d=0,27; -1,8 V; 27 C", "ancho", 0.05, (0.6, 0.2, 0.2)),
                                 ("D0 + 85 C + -0,9 V", "XC26", 0.5, (0.2, 0.2, 0.6))):
    v, lp = M.logverosimilitudes(D[dn], lector, sigma, 300, 3000, semilla=7)
    # las lecturas se simulan en igual número por hipótesis: se reponderan por el prior
    w = np.array(prior)[v] * 3
    lpost = lp + np.log(prior)
    post = np.exp(lpost - np.logaddexp.reduce(lpost, axis=1)[:, None])
    m = (post * w[:, None]).mean(0)
    se = (post * w[:, None]).std(0) / math.sqrt(len(post))
    ok("D media de la posterior = prior, %s, %s, sigma %.2f" % (dn.split(":")[0], lector, sigma),
       bool(np.all(np.abs(m - prior) <= 4 * se + 1e-9)), "media %s, prior %s" % (np.round(m, 4), np.round(prior, 4)))

print("fallos:", len(fallos))
sys.exit(bool(fallos))
