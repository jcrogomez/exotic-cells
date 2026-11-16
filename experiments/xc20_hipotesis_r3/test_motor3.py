#!/usr/bin/env python3
"""Mutantes y testigos de motor3 (PREREG §5), antes de correr la lista. Tamaños pequeños; imprime ok/FALLA y sale con 1 si algo
falla. El mutante «sin d027» se hace con un diseño sin esa lectura: la verosimilitud solo ve lo que el diseño lee."""
import math, sys, warnings
import numpy as np
warnings.filterwarnings("ignore")
import motor3 as M
fallos = []
def ok(nombre, cond, detalle):
    print(("ok   " if cond else "FALLA") + " " + nombre + ": " + detalle, flush=True)
    if not cond: fallos.append(nombre)

N1, N2 = 5000, 2000
# --- mutantes del estimador, sobre la reducción W0 C1 A2 E1 ---
ext = M.externas("W0", "C1", 150, 20261115)
r0 = M.estima("W0", "C1", "A2", "E1", ext, N1, N2, 31); o0 = M.resumen(r0)
for mut in ("sin_norm", "lector_d027"):
    r1 = M.estima("W0", "C1", "A2", "E1", ext, N1, N2, 31, mutante=mut); o1 = M.resumen(r1)
    d = o1["_b_M"] - o0["_b_M"]; se = d.std() / math.sqrt(len(d))
    ok("mutante " + mut, abs(d.mean()) > 4 * se, "I_M motor %.4f, mutante %.4f, diferencia pareada %.4f ± %.4f" % (o0["I_M"][0], o1["I_M"][0], d.mean(), se))

def fijo(ext, clase, valores):
    for e in ext:
        if e["comp"] == clase:
            for k, v in valores.items(): e["p"][k] = np.full(len(e["p"]["g0"]), v)
    return ext

# --- testigo K: túnel en d027 = 1 pA dentro de XC26 ---
extK = fijo(M.externas("W1q1", "C3b", 60, 7), frozenset("T"), {"t0": 1e-5, "K": 1e7})
rK = M.estima("W1q1", "C3b", "A2", "E2", extK, N1, N2, 41); oK = M.resumen(rK)
selT = rK["ver"] == 0
def clases_por_chip(r):
    cs = r["cs"]; tun = [k for k, c in enumerate(cs) if "T" in c]
    lpost = r["logp"] - np.logaddexp.reduce(r["logp"], axis=1, keepdims=True)
    pt = np.exp(lpost[:, tun]); pt /= pt.sum(1, keepdims=True)
    hk = np.einsum("bm,bmk->bk", pt, r["post"]["khist"][:, tun]); hk /= hk.sum(1, keepdims=True)
    c = np.cumsum(hk, 1); q05 = M.HK[1:][np.argmax(c >= 0.05, 1)]; q95 = M.HK[1:][np.argmax(c >= 0.95, 1)]
    return q05, q95
q05, q95 = clases_por_chip(rK)
a, bm = math.log10(7e3), math.log10(M.kmax("W1q1"))
est = (q05 > a + 0.25) & (q95 < bm - 0.25) & (q95 - q05 <= 2)
contiene = (q05 <= 7.05) & (q95 >= 6.95)
ok("testigo K, estimada", est[selT].mean() > 0.8, "fracción estimada %.2f; intervalo mediano [%.2f, %.2f]; contiene 10^7: %.2f"
   % (est[selT].mean(), np.median(q05[selT]), np.median(q95[selT]), contiene[selT].mean()))
ok("testigo K, contiene 10^7", contiene[selT].mean() > 0.8, "%.2f" % contiene[selT].mean())
M.DISENOS["E2sin027"] = [j for j in M.DISENOS["E2"] if M.LECTURAS[j][0] != "d027"]
rKm = M.estima("W1q1", "C3b", "A2", "E2sin027", extK, N1, N2, 41)
q05m, q95m = clases_por_chip(rKm)
estm = (q05m > a + 0.25) & (q95m < bm - 0.25) & (q95m - q05m <= 2)
ok("testigo K, mutante sin d027 deja de estimar", estm[selT].mean() < 0.2, "fracción estimada %.2f" % estm[selT].mean())

# --- testigo B: fondo grande, unión pequeña ---
extB = fijo(M.externas("W1", "C3b", 60, 8), frozenset(), {"B": 5e-13, "B85": 5.0, "g0": 1e-15})
for dis, debe in (("E1", True), ("E2", False)):
    rB = M.estima("W1", "C3b", "A2", dis, extB, N1, N2, 43, seguir=("g0",))
    selG = rB["ver"] == 3
    lg = rB["post"]["seg_g0"][selG, 3]
    sesgo = np.nanmedian(lg) - (-15)
    ok("testigo B, %s: sesgo de log10 g0 %s 1 década" % (dis, "> " if debe else "≤"), (abs(sesgo) > 1) == debe, "sesgo mediano %.2f décadas" % sesgo)

# --- testigo F: fuga convencional visible en el perfil con d ---
extF = fijo(M.externas("W1", "C3b", 60, 9), frozenset("F"), {"f0": 1e-12, "lf": 0.5})
rF = M.estima("W1", "C3b", "A2", "E6", extF, N1, N2, 47)
lp = rF["logp"] - np.logaddexp.reduce(rF["logp"], axis=1, keepdims=True)
pF = np.exp(lp[rF["ver"] == 4, 4])
ok("testigo F, E6: P(F | y) > 0,8", np.median(pF) > 0.8, "mediana %.3f, fracción > 0,8: %.2f" % (np.median(pF), (pF > 0.8).mean()))
print("fallos:", len(fallos))
sys.exit(1 if fallos else 0)
