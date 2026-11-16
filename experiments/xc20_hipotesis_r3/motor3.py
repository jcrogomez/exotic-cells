#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Motor de hipótesis de XC-20, ronda 3 (PREREG.md, congelado 2026-11-15 19:05:04 EST; Enmienda 1 19:27). Escrito después.

Variantes W0 (reducción a la ronda 2), W1 (T, R, M, G, F exclusivos, más B), W1q1, W1K6 y W2 (componentes simultáneos:
G + B + s_T·T + s_R·R + s_F·F). Lectores X, A, A2 y S_f. Calibración C1 y C3a/b/c (g_c + δ_s, δ_a).

Estimador (PREREG §5): para cada lectura externa y y cada clase m, p(y | m) por muestreo de importancia en dos etapas.
  1. N1 chips internos del prior, compartidos por todas las lecturas.
  2. Para cada y, N2 chips de una propuesta: mezcla 0,3·prior + 0,7·normal en coordenadas logit, ajustada con los pesos de la
     etapa 1 de esa y (media y varianza ponderadas, con piso e inflado).
  p̂(y | m) = media de L·p/q sobre la etapa 2. Es insesgado para cada y dado q, porque q solo depende de la etapa 1, que es
  independiente. La calibración latente se integra analíticamente, como en motor2.py.
  Desviación del PREREG, anotada en INFORME: la propuesta se ajusta con la etapa 1 y no «centrada en los parámetros del chip
  que generó la lectura». Esa versión solo existe para la clase verdadera, y para las demás clases habría que inventar el centro.

    python3 motor3.py --rapido            # humo
    python3 motor3.py --lista principal   # una de las listas de §4 (reduccion, principal, calibracion, ley, k6, w2)
    python3 motor3.py --lista X --x4      # la misma lista con 4× chips de la etapa 2 (validez, §5)
"""
import json, math, os, sys, time
import numpy as np
from scipy.special import log_ndtr, expit

KB = 8.617333e-5
ARR = 1 / 300.15 - 1 / 358.15
L10 = math.log10
AQUI = os.path.dirname(os.path.abspath(__file__))

# ---------------- lecturas y diseños (PREREG §4) ----------------
LECTURAS = [("base", 1.8, 27), ("d027", 1.8, 27), ("base", 1.8, 85), ("d027", 1.8, 85), ("base", 0.9, 27),
            ("sinu", 1.8, 27), ("sinu", 1.8, 85), ("d054", 1.8, 27), ("d108", 1.8, 27), ("d054", 1.8, 85), ("d108", 1.8, 85)]
DISENOS = {"E1": [0, 1, 2, 3, 4], "E2": [0, 1, 2, 3, 4, 5, 6], "E3": [0, 1, 2, 3, 4, 5, 6, 7], "E4": [0, 1, 2, 3, 4, 5, 6, 7, 8],
           "E5": list(range(11)), "E6": [0, 1, 7, 8, 5], "E6c": [0, 1, 5]}
DIST = {"base": 0.0, "d027": 0.27, "d054": 0.54, "d108": 1.08}
CELDAS_B = ["base", "d027", "d054", "d108", "sinu"]
XC26 = (150e-15, 0.1e-12, 1.25e-9)
ANCHO = (1e-9, 1e-9, 1e-3)

def lector_de(arq, celda):
    """(piso27, piso85, techo, cual) con cual 0 = sensible, 1 = ancho, 2 = rango seleccionable."""
    if arq == "X": return XC26 + (0,)
    if arq == "A": return ANCHO + (1,)
    if arq == "A2": return ANCHO + (1,) if celda == "base" else XC26 + (0,)
    f = float(arq[1:])
    return (f * 150e-15, f * 0.1e-12, 1e-3, 2)

# ---------------- variantes y clases ----------------
def clases(var):
    if var == "W0": return [frozenset("T"), frozenset("R"), frozenset("TR"), frozenset()], ["T", "R", "M", "G"]
    if var == "W2":
        cs = [frozenset(), frozenset("T"), frozenset("R"), frozenset("F"), frozenset("TR"), frozenset("TF"), frozenset("RF"), frozenset("TRF")]
        return cs, ["".join(sorted(c)) or "0" for c in cs]
    return [frozenset("T"), frozenset("R"), frozenset("TR"), frozenset(), frozenset("F")], ["T", "R", "M", "G", "F"]

def kmax(var): return 1e6 if var in ("W0", "W1K6") else 1e12
def qlibre(var): return var not in ("W0", "W1q1")
def con_b(var): return var != "W0"

def especificacion(var, comp, arq):
    """Lista de parámetros (nombre, tipo, a, b): 'lu' log-uniforme, 'u' uniforme, 'n' normal(0, b)."""
    s = [("g0", "lu", 3e-18, 2e-12), ("gea", "u", 0.56, 1.12), ("gsh", "u", 1.0, 1.4), ("rs", "lu", 100, 5e3), ("imax", "lu", 1e-4, 4e-3)]
    if con_b(var): s += [("B", "lu", 1e-16, 1e-12), ("B85", "u", 1.0, 50.0)]
    if var == "W2": s += [("bu_" + c, "n", 0.0, 0.15) for c in CELDAS_B]
    if "T" in comp:
        s += [("t0", "lu", 12e-9, 0.5e-3), ("tea", "u", 0.010, 0.034), ("tsh", "lu", 15, 57), ("K", "lu", 7e3, kmax(var))]
        if qlibre(var): s += [("q", "u", 0.5, 1.5)]
    if "R" in comp: s += [("rb", "lu", 10, 1e7), ("tcr", "u", 0.002, 0.004), ("v0", "lu", 0.3, 2.0)]
    if "F" in comp: s += [("f0", "lu", 1e-15, 1e-11), ("lf", "u", 0.2, 1.0), ("fea", "u", 0.3, 0.7)]
    if arq.startswith("S"): s += [("lsw", "lu", 0.1, 1.0), ("lsw85", "u", 1.0, 50.0)]
    return s

def a_param(spec, z):
    """z (N, P) en coordenadas sin borde -> dict de parámetros físicos; y log p_z(z) del prior."""
    p, lp = {}, np.zeros(len(z))
    for i, (nom, tipo, a, b) in enumerate(spec):
        if tipo == "n":
            p[nom] = b * z[:, i]; lp += -0.5 * z[:, i] ** 2 - 0.5 * math.log(2 * math.pi)
            continue
        u = expit(z[:, i])
        lp += -np.logaddexp(0, -z[:, i]) - np.logaddexp(0, z[:, i])        # log u(1-u)
        p[nom] = 10 ** (L10(a) + u * (L10(b) - L10(a))) if tipo == "lu" else a + u * (b - a)
    return p, lp

def z_prior(spec, n, rng):
    z = np.empty((n, len(spec)))
    for i, (_, tipo, _, _) in enumerate(spec):
        if tipo == "n": z[:, i] = rng.normal(size=n)
        else:
            u = rng.random(n); z[:, i] = np.log(u) - np.log1p(-u)
    return z

def lp_prior_z(spec, z):
    return a_param(spec, z)[1]

# ---------------- física ----------------
def i_dev(comp, p, celda, v, t, var):
    """Corriente por el dispositivo (sin B), tensión v (array) sobre él."""
    if celda == "sinu": return np.zeros_like(v)
    d = DIST[celda]
    act = (lambda ea: np.exp(ea / KB * ARR)) if t == 85 else (lambda ea: 1.0)
    i = p["g0"] * (v / 1.8) ** np.log2(p["gsh"]) * act(p["gea"])
    if "T" in comp:
        it = p["t0"] * (v / 1.8) ** np.log2(p["tsh"]) * act(p["tea"])
        if d > 0:
            q = p["q"] if "q" in p else 1.0
            it = it * p["K"] ** (-(d / 0.27) ** q)
        i = i + it
    if "R" in comp and d == 0:
        nl = p["nl"]
        v0s = np.where(nl, p["v0"], 1.0)
        forma = np.where(nl, np.sinh(v / v0s) / np.sinh(1.8 / v0s), v / 1.8)
        ir = 1.8 / p["rb"] * forma
        i = i + (ir / (1 + p["tcr"] * 58) if t == 85 else ir)
    if "F" in comp:
        i = i + p["f0"] * np.exp(-d / p["lf"]) * (v / 1.8) ** np.log2(p["gsh"]) * act(p["fea"])
    return i

def corriente(comp, p, celda, vap, t, var, arq):
    n = len(p["g0"])
    v = np.full(n, vap)
    i = i_dev(comp, p, celda, v, t, var)
    lazo = p["rs"] * i > 1e-6 * vap                 # solo donde Rs·I pesa: V + Rs·I(V) = Vap por bisección
    if lazo.any():
        q = {k: (val[lazo] if isinstance(val, np.ndarray) and val.shape[:1] == (n,) else val) for k, val in p.items()}
        lo, hi = np.zeros(lazo.sum()), np.full(lazo.sum(), vap)
        for _ in range(32):
            mid = 0.5 * (lo + hi)
            f = mid + q["rs"] * i_dev(comp, q, celda, mid, t, var) - vap
            lo, hi = np.where(f < 0, mid, lo), np.where(f < 0, hi, mid)
        i = i.copy(); i[lazo] = i_dev(comp, q, celda, 0.5 * (lo + hi), t, var)
    i = np.minimum(i, p["imax"])
    if con_b(var):
        b = p["B"] * (p["B85"] if t == 85 else 1.0)
        if var == "W2": b = b * 10 ** p["bu_" + celda]
        i = i + b
    if arq.startswith("S"):
        f = float(arq[1:])
        i = i + f * 150e-15 * p["lsw"] * (p["lsw85"] if t == 85 else 1.0)
    return i

def medias(comp, p, idx, var, arq):
    return np.stack([np.log10(np.maximum(corriente(comp, p, LECTURAS[j][0], LECTURAS[j][1], LECTURAS[j][2], var, arq), 1e-30))
                     for j in idx], axis=1)

# ---------------- instrumento ----------------
CAL = {"C1": (0.5, None), "C3a": (0.5, 0.05), "C3b": (0.5, 0.2), "C3c": (0.5, 0.5)}
SIG_E, SIG_R = 0.02, 0.05

def instrumento(arq, cal, idx):
    lo, hi, A, s = [], [], [], []
    sc, sx = CAL[cal]
    for j in idx:
        celda, _, t = LECTURAS[j]
        p27, p85, techo, cual = lector_de(arq, celda)
        lo.append(L10(p85 if t == 85 else p27)); hi.append(L10(techo))
        if sx is None: A.append([1.0])
        else: A.append([1.0, 1.0 if cual == 0 else 0.0, 1.0 if cual == 1 else 0.0])
        s.append(math.hypot(SIG_E, SIG_R) if cual == 2 else SIG_E)
    var0 = np.array([sc ** 2]) if sx is None else np.array([sc ** 2, sx ** 2, sx ** 2])
    return np.array(lo), np.array(hi), np.array(A), np.array(s), var0

def loglik(y, mu, lo, hi, A, s, var0):
    """y (b, J) con ±inf censurados; mu (N, J) compartida o (b, N, J) propia de cada y. log p(y | mu) (b, N), latente
    gaussiana z ~ N(0, diag var0) integrada; de varias censuradas del mismo tipo, carga y σ cuenta la más restrictiva."""
    b, J = y.shape
    propia = mu.ndim == 3
    N = mu.shape[-2]
    out = np.empty((b, N))
    pat = np.where(np.isfinite(y), 0, np.where(np.isneginf(y), 1, 2))
    claves = {}
    for k in range(b): claves.setdefault(tuple(pat[k]), []).append(k)
    P0 = np.diag(1 / var0)
    for clave, filas in claves.items():
        filas = np.array(filas)
        m = mu[filas] if propia else mu[None]
        u = [j for j in range(J) if clave[j] == 0]
        Au, su = A[u], s[u]
        Lam = P0 + (Au / su[:, None] ** 2).T @ Au
        Cov = np.linalg.inv(Lam)
        logdet = np.linalg.slogdet(Lam)[1] + np.sum(np.log(var0))
        ll = np.zeros((len(filas), N))
        if u:
            r = y[filas][:, None, u] - m[..., u]
            eta = (r / su ** 2) @ Au
            quad = np.sum(r ** 2 / su ** 2, axis=2) - np.einsum("bnd,de,bne->bn", eta, Cov, eta)
            ll += -0.5 * quad - 0.5 * logdet - 0.5 * np.sum(np.log(2 * math.pi * su ** 2))
            zm = eta @ Cov
        else:
            zm = np.zeros((len(filas), N, len(var0)))
        grupos = {}
        for j in range(J):
            if clave[j]: grupos.setdefault((clave[j], tuple(A[j]), s[j]), []).append(j)
        for (tipo, a, sj), js in grupos.items():
            a = np.array(a)
            sd = math.sqrt(sj ** 2 + a @ Cov @ a)
            loc = zm @ a
            if tipo == 1:
                c = np.min(np.stack([lo[j] - m[..., j] for j in js]), axis=0)
                ll += log_ndtr((c - loc) / sd)
            else:
                d = np.max(np.stack([hi[j] - m[..., j] for j in js]), axis=0)
                ll += log_ndtr((loc - d) / sd)
        out[filas] = ll
    return out

# ---------------- lecturas externas (pareadas: una sola vez por variante y calibración) ----------------
def externas(var, cal, n_ext, semilla):
    """Chips externos, ruido y calibración para las 11 lecturas; cada arquitectura y diseño toma lo suyo (Enmienda 1, §5)."""
    rng = np.random.default_rng(semilla)
    cs, nombres = clases(var)
    sc, sx = CAL[cal]
    out = []
    for k, comp in enumerate(cs):
        spec = especificacion(var, comp, "S1")          # incluye lsw: los usan solo las S
        z = z_prior(spec, n_ext, rng)
        p, _ = a_param(spec, z)
        p["nl"] = rng.random(n_ext) < 0.5
        lat = np.stack([rng.normal(0, sc, n_ext), rng.normal(0, sx or 0, n_ext), rng.normal(0, sx or 0, n_ext)], 1)
        eps = rng.normal(0, 1, (n_ext, len(LECTURAS)))
        epr = rng.normal(0, 1, (n_ext, len(LECTURAS)))
        out.append(dict(comp=comp, p=p, lat=lat, eps=eps, epr=epr))
    return out

def lecturas(ext, var, cal, arq, idx):
    lo, hi, A, s, var0 = instrumento(arq, cal, idx)
    ys, ver, verdad = [], [], []
    for k, e in enumerate(ext):
        mu = medias(e["comp"], e["p"], idx, var, arq)
        g = e["lat"][:, :1] if A.shape[1] == 1 else e["lat"]
        ruido = np.where(s == SIG_E, SIG_E * e["eps"][:, idx], SIG_E * e["eps"][:, idx] + SIG_R * e["epr"][:, idx])
        y = mu + g @ A.T + ruido
        ys.append(np.where(y < lo, -np.inf, np.where(y > hi, np.inf, y))); ver += [k] * len(y)
        verdad.append(e["p"])
    return np.vstack(ys), np.array(ver), verdad, (lo, hi, A, s, var0)

# ---------------- estimador ----------------
KBIN_ANCHO, QBINS = 1.0, np.linspace(0.5, 1.5, 5)
def kbordes(var):
    """Bins iguales de ~1 década que dividen el prior exactamente: 8 con K ≤ 10¹², 2 con K ≤ 10⁶ (la misma decisión que el
    verificador, ver3_INFORME §12; los bins de 1 década dejaban un resto de 0,155)."""
    a, b = L10(7e3), L10(kmax(var))
    return np.linspace(a, b, (8 if b > 7 else 2) + 1)
HK = np.arange(L10(7e3), 12.0001, 0.05)      # rejilla fina de log10 K para intervalos
HB = np.arange(-16, -11.9999, 0.05)

def estima(var, cal, arq, dis, ext, n1, n2, semilla, mutante=None, seguir=()):
    idx = DISENOS[dis]
    y, ver, _, inst = lecturas(ext, var, cal, arq, idx)
    lo, hi, A, s, var0 = inst
    if mutante == "lector_d027":    # mutante de §5: la verosimilitud lee d027 con el ancho
        lo = lo.copy(); hi = hi.copy()
        for jj, j in enumerate(idx):
            if LECTURAS[j][0] == "d027": lo[jj], hi[jj] = L10(1e-9), L10(1e-3)
    cs, nombres = clases(var)
    rng = np.random.default_rng(semilla)
    nb = len(y)
    logp = np.empty((nb, len(cs)))
    kb = kbordes(var)
    post = {"kbin": np.zeros((nb, len(cs), len(kb) - 1)), "qbin": np.zeros((nb, len(cs), 4)),
            "khist": np.zeros((nb, len(cs), len(HK) - 1)), "bhist": np.zeros((nb, len(cs), len(HB) - 1))}
    for nom in seguir: post["seg_" + nom] = np.full((nb, len(cs)), np.nan)
    for k, comp in enumerate(cs):
        spec = especificacion(var, comp, arq)
        P = len(spec)
        z1 = z_prior(spec, n1, rng)
        p1, _ = a_param(spec, z1); nl1 = rng.random(n1) < 0.5; p1["nl"] = nl1
        mu1 = medias(comp, p1, idx, var, arq)
        bloque = 20
        ancla_z = anclas(ext, spec, comp, var)             # z del chip que generó cada lectura, en las coordenadas de esta clase
        for a0 in range(0, nb, bloque):
            yb = y[a0:a0 + bloque]; b = len(yb)
            ll1 = loglik(yb, mu1, lo, hi, A, s, var0)
            w1 = np.exp(ll1 - ll1.max(axis=1, keepdims=True)); w1 /= w1.sum(axis=1, keepdims=True)
            m1, C1 = ajuste(np.broadcast_to(z1, (b,) + z1.shape), w1)
            pi = np.clip(w1 @ nl1, 0.05, 0.95)
            az, ahay = ancla_z[0][a0:a0 + b], ancla_z[1][a0:a0 + b]
            top = np.argsort(-ll1, axis=1)[:, :3]               # las tres mejores muestras de la etapa 1 (modos distintos)
            mejor = z1[top[:, 0]]
            centro = np.where(ahay, az, mejor)
            fl = ancla_z[2][a0:a0 + b]                         # bandera verdadera (o -1 si la verdad no tiene R)
            pia = np.where(fl < 0, np.where(nl1[top[:, 0]], 0.9, 0.1), np.where(fl == 1, 0.95, 0.05))
            ca, Sa = laplace(centro, pia > 0.5, yb, spec, comp, idx, var, arq, A, s, var0)
            lap = [(0.2, ca, Sa, pia), (0.1, ca, Sa * 9, pia)]
            for t in range(3):
                nlt = nl1[top[:, t]]
                cb, Sb = laplace(z1[top[:, t]], nlt, yb, spec, comp, idx, var, arq, A, s, var0)
                pib = np.where(nlt, 0.9, 0.1)
                lap += [(0.14, cb, Sb, pib), (0.06, cb, Sb * 9, pib)]
            comps = [(0.1, None, None, None)] + lap
            z2, nl2, lw, ll2, p2 = etapa(comps, spec, comp, idx, var, arq, yb, lo, hi, A, s, var0, n2, rng)
            w2 = np.exp(lw - lw.max(axis=1, keepdims=True)); w2 /= w2.sum(axis=1, keepdims=True)
            m2, C2 = ajuste(z2, w2)
            pi2 = np.clip(np.einsum("bn,bn->b", w2, nl2), 0.05, 0.95)
            comps = [(0.05, None, None, None), (0.45, m2, C2 * 1.2 ** 2, pi2)] + [(w * 0.5 / 0.9, c, C, pp) for (w, c, C, pp) in lap]
            z2, nl2, lw, ll2, p2 = etapa(comps, spec, comp, idx, var, arq, yb, lo, hi, A, s, var0, n2, rng)
            if mutante == "sin_norm":   # mutante: olvida p/q (pesos como si fueran del prior)
                lw = ll2
            logp[a0:a0 + b, k] = np.logaddexp.reduce(lw, axis=1) - math.log(n2)
            w = np.exp(lw - lw.max(axis=1, keepdims=True)); w /= w.sum(axis=1, keepdims=True)
            for nom in seguir:
                if nom in p2: post["seg_" + nom][a0:a0 + b, k] = np.einsum("bn,bn->b", w, np.log10(p2[nom]).reshape(b, n2))
            if "B" in p2:
                lb = np.log10(p2["B"]).reshape(b, n2)
                post["bhist"][a0:a0 + b, k] = hist_pond(lb, w, HB)
            if "T" in comp:
                lk = np.log10(p2["K"]).reshape(b, n2)
                post["kbin"][a0:a0 + b, k] = hist_pond(lk, w, kb)
                post["khist"][a0:a0 + b, k] = hist_pond(lk, w, HK)
                if "q" in p2: post["qbin"][a0:a0 + b, k] = hist_pond(p2["q"].reshape(b, n2), w, QBINS)
    return dict(ver=ver, logp=logp, post=post, nombres=nombres, cs=cs, kb=kb, ext=ext, idx=idx)

def laplace(c, nl, yb, spec, comp, idx, var, arq, A, s, var0, h=0.01, pasos=2):
    """Propuesta local en c (b, P): pasos de Gauss-Newton hacia la moda del posterior aproximado (lecturas no censuradas con
    la latente marginalizada, prior en z aproximado por N(0, 1,8²)) y covarianza inv(Jᵀ Σy⁻¹ J + I/1,8²) en el punto final.
    Devuelve (centro, cov). Solo define la propuesta: los pesos L·p/q siguen siendo exactos."""
    b, P = c.shape
    J = len(idx)
    Sy = np.diag(s ** 2) + A @ np.diag(var0) @ A.T
    fin = np.isfinite(yb)
    c = c.copy()
    for paso in range(pasos + 1):
        zz = np.repeat(c[:, None, :], 2 * P + 1, axis=1)
        for i in range(P):
            zz[:, 2 * i, i] += h; zz[:, 2 * i + 1, i] -= h
        p, _ = a_param(spec, zz.reshape(-1, P)); p["nl"] = np.repeat(nl, 2 * P + 1)
        mu = medias(comp, p, idx, var, arq).reshape(b, 2 * P + 1, J)
        Jac = ((mu[:, 0:2 * P:2] - mu[:, 1:2 * P:2]) / (2 * h)).transpose(0, 2, 1)   # (b, J, P)
        m0 = mu[:, 2 * P]
        out = np.empty((b, P, P))
        for k in range(b):
            u = np.where(fin[k])[0]
            H = np.eye(P) / 1.8 ** 2
            g = -c[k] / 1.8 ** 2
            if len(u):
                Ju = Jac[k][u]
                Si = np.linalg.inv(Sy[np.ix_(u, u)])
                H = H + Ju.T @ Si @ Ju
                g = g + Ju.T @ Si @ (yb[k, u] - m0[k, u])
            C = np.linalg.inv(H); C = 0.5 * (C + C.T) + np.eye(P) * 1e-6
            out[k] = C
            if paso < pasos:
                d = C @ g
                n = np.linalg.norm(d)
                c[k] = c[k] + (d if n < 1.0 else d / n)          # paso acotado a 1 en z
    return c, out

def ajuste(z, w):
    """media y covarianza ponderadas por y: z (b, N, P), w (b, N); regularizada (piso 0,05² y contracción hacia la diagonal)."""
    m = np.einsum("bn,bnp->bp", w, z)
    d = z - m[:, None]
    C = np.einsum("bn,bnp,bnq->bpq", w, d, d)
    P = z.shape[-1]
    diag = np.einsum("bpp->bp", C)
    C = 0.7 * C + 0.3 * np.einsum("bp,pq->bpq", diag, np.eye(P)) + np.eye(P) * 0.05 ** 2
    return m, C

def anclas(ext, spec, comp, var):
    """z de los chips externos en las coordenadas de spec; máscara de qué coordenadas existen en el chip verdadero."""
    zs, hay, fl = [], [], []
    for e in ext:
        n = len(e["p"]["g0"]); z = np.zeros((n, len(spec))); h = np.zeros((n, len(spec)), bool)
        for i, (nom, tipo, a, b) in enumerate(spec):
            if nom not in e["p"]: continue
            x = e["p"][nom]
            if tipo == "n": z[:, i] = x / b
            else:
                u = (np.log10(x) - L10(a)) / (L10(b) - L10(a)) if tipo == "lu" else (x - a) / (b - a)
                u = np.clip(u, 1e-9, 1 - 1e-9); z[:, i] = np.log(u) - np.log1p(-u)
            h[:, i] = True
        zs.append(z); hay.append(h)
        fl.append(e["p"]["nl"].astype(int) if "R" in e["comp"] else np.full(n, -1))
    return np.vstack(zs), np.vstack(hay), np.concatenate(fl)

def etapa(comps, spec, comp, idx, var, arq, yb, lo, hi, A, s, var0, n, rng):
    """Una etapa de muestreo de importancia con una mezcla (peso, media, cov) por y; None = prior. Devuelve z, bandera de no
    linealidad, log pesos L·p/q, log L y parámetros."""
    b, P = len(yb), len(spec)
    pesos = np.array([c[0] for c in comps])
    cual = rng.choice(len(comps), size=(b, n), p=pesos)
    z = z_prior(spec, b * n, rng).reshape(b, n, P)
    chol, GL = [], 4.0
    for j, (_, m, C, _) in enumerate(comps):
        if m is None: chol.append(None); continue
        Lc = np.linalg.cholesky(C)
        esc = np.sqrt(GL / rng.chisquare(GL, size=(b, n, 1)))
        zj = m[:, None, :] + esc * np.einsum("bpq,bnq->bnp", Lc, rng.normal(size=(b, n, P)))
        z = np.where((cual == j)[..., None], zj, z)
        chol.append(np.linalg.inv(Lc))
    pis = np.stack([np.full(b, 0.5) if c[3] is None else c[3] for c in comps], 1)      # (b, comps)
    pin = np.take_along_axis(pis, cual, 1)
    nl = rng.random((b, n)) < pin
    p, lpz = a_param(spec, z.reshape(b * n, P)); p["nl"] = nl.reshape(-1)
    lpz = lpz.reshape(b, n)
    erre = "R" in comp
    lprior = lpz + (math.log(0.5) if erre else 0.0)
    partes = []
    for j, (w, m, C, pj) in enumerate(comps):
        if m is None: partes.append(math.log(w) + lprior); continue
        lflag = np.where(nl, np.log(pj[:, None]), np.log1p(-pj[:, None])) if erre else 0.0
        Li = chol[j]
        sol = np.einsum("bpq,bnq->bnp", Li, z - m[:, None])
        ld = -np.log(np.einsum("bpp->bp", Li)).sum(-1)        # log det de L
        q2 = (sol ** 2).sum(-1)
        lt = (math.lgamma((GL + P) / 2) - math.lgamma(GL / 2) - 0.5 * P * math.log(GL * math.pi)
              - ld[:, None] - 0.5 * (GL + P) * np.log1p(q2 / GL))
        partes.append(math.log(w) + lt + lflag)
    lq = np.logaddexp.reduce(np.stack(partes), axis=0)
    mu = medias(comp, p, idx, var, arq).reshape(b, n, len(idx))
    ll = loglik(yb, mu, lo, hi, A, s, var0)
    return z, nl, ll + lprior - lq, ll, p

def hist_pond(x, w, bordes):
    j = np.clip(np.searchsorted(bordes, x, side="right") - 1, 0, len(bordes) - 2)
    h = np.zeros((x.shape[0], len(bordes) - 1))
    np.add.at(h, (np.repeat(np.arange(x.shape[0]), x.shape[1]), j.reshape(-1)), w.reshape(-1))
    return h

# ---------------- resúmenes ----------------
def bits_por_lectura(ver, logp, grupos=None, prior=None):
    K = logp.shape[1]
    prior = np.full(K, 1 / K) if prior is None else prior
    lpost = logp + np.log(prior)
    lpy = np.logaddexp.reduce(lpost, axis=1)
    if grupos is None:
        return (lpost[np.arange(len(ver)), ver] - lpy - np.log(prior[ver])) / math.log(2), np.argmax(lpost, 1) == ver
    lg = np.stack([np.logaddexp.reduce(lpost[:, list(g)], axis=1) for g in grupos], axis=1)
    verd = np.array([next(i for i, g in enumerate(grupos) if v in g) for v in ver])
    pg = np.array([prior[list(g)].sum() for g in grupos])
    return (lg[np.arange(len(ver)), verd] - lpy - np.log(pg[verd])) / math.log(2), np.argmax(lg, 1) == verd

def media_clase(x, ver, pesos):
    """media sobre clases con sus pesos de prior, y error estándar."""
    m = e = 0.0
    for k, pk in pesos.items():
        sel = ver == k
        m += pk * x[sel].mean(); e += (pk * x[sel].std()) ** 2 / sel.sum()
    return m, math.sqrt(e)

def resumen(r):
    ver, logp, cs, post = r["ver"], r["logp"], r["cs"], r["post"]
    K = len(cs)
    uni = {k: 1 / K for k in range(K)}
    out = {}
    b, ok = bits_por_lectura(ver, logp)
    out["I_M"] = media_clase(b, ver, uni); out["acierto"] = media_clase(ok.astype(float), ver, uni)[0]
    out["_b_M"] = b
    tun = [k for k, c in enumerate(cs) if "T" in c]
    grupos = [set(tun), set(range(K)) - set(tun)]
    b, ok = bits_por_lectura(ver, logp, grupos)
    out["I_tun"] = media_clase(b, ver, uni); out["acierto_tun"] = media_clase(ok.astype(float), ver, uni)[0]; out["_b_tun"] = b
    for comp in "RF":
        con = [k for k, c in enumerate(cs) if comp in c]
        if len(cs) == 8:
            b, _ = bits_por_lectura(ver, logp, [set(con), set(range(K)) - set(con)])
            out["I_s" + comp] = media_clase(b, ver, uni); out["_b_s" + comp] = b
    if len(cs) == 8: out["I_sT"] = out["I_tun"]
    # F frente a túnel residual (W1): verdad en {T, M, F}, prior restringido
    if len(cs) == 5:
        sub = [0, 2, 4]
        sel = np.isin(ver, sub)
        lp = logp[sel][:, sub]; vv = np.searchsorted(sub, ver[sel])
        b, _ = bits_por_lectura(vv, lp, [{0, 1}, {2}])
        out["I_FvT"] = media_clase(b, vv, {0: 1 / 3, 1: 1 / 3, 2: 1 / 3}); bb = np.full(len(ver), np.nan); bb[sel] = b; out["_b_FvT"] = bb
    # K y q, condicionados a túnel
    lpost = logp + math.log(1 / K)
    pm = np.exp(lpost - np.logaddexp.reduce(lpost, axis=1, keepdims=True))
    selt = np.isin(ver, tun)
    pt = pm[:, tun] / pm[:, tun].sum(1, keepdims=True)
    for nom, prior_b in (("kbin", np.diff(r["kb"]) / (r["kb"][-1] - r["kb"][0])), ("qbin", np.full(4, 0.25))):
        h = np.einsum("bm,bmk->bk", pt, post[nom][:, tun])
        if nom == "qbin" and h.sum() == 0: continue
        h = h / h.sum(1, keepdims=True)
        verd = verdad_bin(r, nom)
        ii = np.where(selt)[0]
        bits = np.log2(np.maximum(h[ii, verd[ii]], 1e-300)) - np.log2(prior_b[verd[ii]])
        H = -(prior_b * np.log2(prior_b)).sum()
        x = np.full(len(ver), np.nan); x[ii] = bits
        out["I_" + nom] = media_clase(x, ver, {k: 1 / len(tun) for k in tun}); out["H_" + nom] = H; out["_b_" + nom] = x
    # clases de K
    hk = np.einsum("bm,bmk->bk", pt, post["khist"][:, tun]); hk = hk / hk.sum(1, keepdims=True)
    c = np.cumsum(hk, 1)
    q05 = HK[1:][np.argmax(c >= 0.05, 1)]; q95 = HK[1:][np.argmax(c >= 0.95, 1)]
    a, bmax = L10(7e3), L10(kmax_de(r))
    toca_a, toca_b = q05 < a + 0.25, q95 > bmax - 0.25
    est = (~toca_a) & (~toca_b) & (q95 - q05 <= 2)
    acot = (toca_a & (bmax - q95 >= 2)) | (toca_b & (q05 - a >= 2))
    clase_k = np.where(est, "estimada", np.where(acot, "acotada", "nada"))
    out["K_estimada"] = float(np.mean(clase_k[selt] == "estimada")); out["K_acotada"] = float(np.mean(clase_k[selt] == "acotada"))
    # B: ancho del posterior
    if post["bhist"].sum() > 0:
        hb = np.einsum("bm,bmk->bk", pm, post["bhist"]); hb = hb / hb.sum(1, keepdims=True)
        cen = 0.5 * (HB[1:] + HB[:-1])
        mB = hb @ cen; sdB = np.sqrt(np.maximum(hb @ cen ** 2 - mB ** 2, 0))
        out["sdB_post"] = float(sdB.mean()); out["sdB_prior"] = 4 / math.sqrt(12); out["_sdB"] = sdB
    return out

def kmax_de(r):
    return 10 ** r["kb"][-1]

def verdad_bin(r, nom):
    vals = np.full(len(r["ver"]), 0)
    off = 0
    for e in r["ext"]:
        n = len(e["p"]["g0"])
        if nom == "kbin" and "K" in e["p"] and "T" in e["comp"]:
            vals[off:off + n] = np.clip(np.searchsorted(r["kb"], np.log10(e["p"]["K"]), side="right") - 1, 0, len(r["kb"]) - 2)
        if nom == "qbin" and "q" in e["p"] and "T" in e["comp"]:
            vals[off:off + n] = np.clip(np.searchsorted(QBINS, e["p"]["q"], side="right") - 1, 0, 3)
        off += n
    return vals

# ---------------- listas de corridas (PREREG §4 y Enmienda 1) ----------------
def listas():
    L = {}
    L["reduccion"] = [("W0", "C1", a, "E1") for a in ("A", "X", "A2")]
    L["principal"] = [("W1", "C3b", a, d) for a in ("X", "A", "A2", "S1", "S10", "S100") for d in ("E1", "E2", "E3", "E4", "E5", "E6", "E6c")]
    L["calibracion"] = [("W1", c, a, d) for c in ("C1", "C3a", "C3c") for a in ("A2", "S10") for d in ("E1", "E2", "E4")]
    L["ley"] = [("W1q1", "C3b", a, d) for a in ("A2", "S10") for d in ("E2", "E4", "E6")]
    L["k6"] = [("W1K6", "C3b", a, d) for a in ("X", "A", "A2", "S10") for d in ("E1", "E4")]
    L["w2"] = [("W2", "C3b", a, d) for a in ("X", "A", "A2", "S10") for d in ("E1", "E2", "E4", "E6", "E6c")]
    return L

def correr(lista, n_ext, n1, n2, etiqueta, semilla_ext=20261115, semilla_int=31):
    filas = listas()[lista] if isinstance(lista, str) else lista
    cache, res = {}, []
    dest = os.path.join(AQUI, "res3_%s.jsonl" % etiqueta)
    npz = {}
    for (var, cal, arq, dis) in filas:
        if (var, cal) not in cache: cache[(var, cal)] = externas(var, cal, n_ext, semilla_ext)
        t0 = time.time()
        r = estima(var, cal, arq, dis, cache[(var, cal)], n1, n2, semilla_int)
        o = resumen(r)
        fila = {"var": var, "cal": cal, "arq": arq, "dis": dis, "n_ext": n_ext, "n1": n1, "n2": n2, "s": round(time.time() - t0, 1)}
        for k, v in o.items():
            if k.startswith("_"): npz["%s|%s|%s|%s|%s" % (var, cal, arq, dis, k)] = v
            else: fila[k] = v
        print(json.dumps(fila, ensure_ascii=False), flush=True)
        with open(dest, "a") as f: f.write(json.dumps(fila, ensure_ascii=False) + "\n")
        res.append(fila)
    np.savez_compressed(os.path.join(AQUI, "res3_%s.npz" % etiqueta), **npz)
    return res

if __name__ == "__main__":
    a = sys.argv
    if "--rapido" in a:
        correr([("W0", "C1", "A2", "E1"), ("W1", "C3b", "A2", "E4"), ("W2", "C3b", "S10", "E6")], 40, 2000, 200, "rapido")
        sys.exit()
    lista = a[a.index("--lista") + 1]
    n_ext = int(a[a.index("--n_ext") + 1]) if "--n_ext" in a else 400
    n2 = 2000 * (4 if "--x4" in a else 1)
    correr(lista, n_ext, 20000, n2, lista + ("_x4" if "--x4" in a else ""))
