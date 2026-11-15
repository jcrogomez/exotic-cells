#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Motor de hipótesis de XC-20, ronda 2 (ver PREREG.md, escrito antes de este código, 2026-11-15 17:03:37 EST).

Mecanismos T (túnel), R (puente, óhmico o no lineal), M (los dos a la vez), G (unión ordinaria); fondo térmico en todos;
excitador con resistencia serie y límite de corriente; lector censurado; calibración independiente (C0), con ganancia común
(C1) o con ganancia común más deriva a 85 °C (C2).

    python3 motor2.py              # todas las corridas del prerregistro -> resultados2.txt
    python3 motor2.py --rapido     # pocas muestras, para probar
    python3 motor2.py --convergencia   # C1 y C2 con 4 veces más chips internos

Estimador: Monte Carlo anidado sobre los parámetros (lecturas externas por mecanismo; chips internos por mecanismo). La parte
latente de la calibración (g, y δ en C2) se integra analíticamente: es lineal y gaussiana dada la corriente. Las lecturas no
censuradas dan una gaussiana exacta en (g, δ); cada lectura censurada se toma como Φ evaluada con la posterior de (g, δ) de las
no censuradas, y de varias censuradas del mismo tipo y grupo de temperatura solo cuenta la más restrictiva (exacto con una sola;
aproximación con varias, porque dependen casi solo de la misma g). Lo prerregistrado era cuadratura de Gauss-Hermite; se cambió
porque con σe = 0,02 frente a σg = 0,5 la integral en g tiene un pico ~25 veces más estrecho que el prior, que una cuadratura de
nodos fijos no resuelve (anotado en INFORME.md).
"""
import itertools, math, sys, time
import numpy as np
from scipy.special import log_ndtr

KB = 8.617333e-5
ARR = 1 / 300.15 - 1 / 358.15
LN10 = math.log(10)

VARIANTES = {  # mecanismos, R no lineal, Rb máximo, excitador, túnel en d = 0,27 nulo (K = ∞)
    "V0inf": ("TRG", False, 1e5, False, True),
    "V0": ("TRG", False, 1e5, False, False),
    "V1": ("TRMG", False, 1e5, False, False),
    "V2": ("TRG", True, 1e5, False, False),
    "V3": ("TRG", False, 1e5, True, False),
    "V4": ("TRMG", True, 1e7, True, False),
    # añadidas tras la verificación (no prerregistradas): sensibilidad al techo de K, el supuesto que decide la lectura de d = 0,27
    "V4K9": ("TRMG", True, 1e7, True, False),
    "V4K12": ("TRMG", True, 1e7, True, False),
}
KMAX = {"V4K9": 1e9, "V4K12": 1e12}
LECTORES = {"ancho": (1e-9, 1e-9, 1e-3), "XC26": (150e-15, 0.1e-12, 1.25e-9)}  # piso 27 °C, piso 85 °C, techo
CALIB = {"C0_0.05": ("C0", 0.05), "C0_0.5": ("C0", 0.5), "C1": ("C1", 0.02), "C2": ("C2", 0.02)}  # tipo, sigma de lectura
SIG_G, SIG_D = 0.5, 0.03
DISENOS = {
    "D0": [("base", 1.8, 27), ("d027", 1.8, 27)],
    "D0+85C": [("base", 1.8, 27), ("d027", 1.8, 27), ("base", 1.8, 85), ("d027", 1.8, 85)],
    "D0-0.9V": [("base", 1.8, 27), ("d027", 1.8, 27), ("base", 0.9, 27)],
    "D0+peine": [("base", 1.8, 27), ("d027", 1.8, 27), ("peine", 1.8, 27)],
    "D0+85C-0.9V": [("base", 1.8, 27), ("d027", 1.8, 27), ("base", 1.8, 85), ("d027", 1.8, 85), ("base", 0.9, 27)],
}

def logu(rng, lo, hi, n):
    return 10 ** rng.uniform(math.log10(lo), math.log10(hi), n)

def muestrea(m, n, rng, var):
    mecs, nolineal, rbmax, exc, kinf = VARIANTES[var]
    p = {"g0": logu(rng, 3e-18, 2e-12, n), "gea": rng.uniform(0.56, 1.12, n), "gsh": rng.uniform(1.0, 1.4, n)}
    if m in "TM":
        p.update(t0=logu(rng, 12e-9, 0.5e-3, n), tea=rng.uniform(0.010, 0.034, n), tsh=logu(rng, 15, 57, n),
                 K=np.full(n, np.inf) if kinf else logu(rng, 7e3, KMAX.get(var, 1e6), n))
    if m in "RM":
        v0 = np.full(n, np.inf)
        if nolineal:
            nl = rng.random(n) < 0.5
            v0[nl] = logu(rng, 0.3, 2.0, int(nl.sum()))
        p.update(rb=logu(rng, 10, rbmax, n), tcr=rng.uniform(0.002, 0.004, n), v0=v0)
    if exc:
        p.update(rs=logu(rng, 100, 5e3, n), imax=logu(rng, 1e-4, 4e-3, n))
    return p

def i_dev(m, p, est, v, t):
    """Corriente del dispositivo con tensión v (array) sobre él."""
    fr = {"base": 1.0, "peine": 4.0, "d027": 0.0}[est]
    i = p["g0"] * (v / 1.8) ** np.log2(p["gsh"]) * (np.exp(p["gea"] / KB * ARR) if t == 85 else 1.0)
    if m in "TM":
        it = p["t0"] * (v / 1.8) ** np.log2(p["tsh"]) * (np.exp(p["tea"] / KB * ARR) if t == 85 else 1.0)
        i = i + (it * fr if fr else it / p["K"])
    if m in "RM" and fr:
        v0 = p["v0"]
        lin = np.isinf(v0)
        v0s = np.where(lin, 1.0, v0)
        forma = np.where(lin, v / 1.8, np.sinh(v / v0s) / np.sinh(1.8 / v0s))
        ir = 1.8 / p["rb"] * forma * fr
        i = i + (ir / (1 + p["tcr"] * 58) if t == 85 else ir)
    return i

def corriente(m, p, est, vap, t, var):
    if not VARIANTES[var][3]:
        return i_dev(m, p, est, np.full(len(p["g0"]), vap), t)
    lo, hi = np.zeros(len(p["g0"])), np.full(len(p["g0"]), vap)
    for _ in range(60):  # V + Rs·I(V) = Vap, I creciente en V: bisección
        mid = 0.5 * (lo + hi)
        f = mid + p["rs"] * i_dev(m, p, est, mid, t) - vap
        lo, hi = np.where(f < 0, mid, lo), np.where(f < 0, hi, mid)
    return np.minimum(i_dev(m, p, est, 0.5 * (lo + hi), t), p["imax"])

def medias(m, p, diseno, var):
    return np.stack([np.log10(np.maximum(corriente(m, p, e, v, t, var), 1e-30)) for (e, v, t) in diseno], axis=1)

def limites(diseno, lector):
    """lector «mixto» (exploratorio, propuesto por el verificador, no prerregistrado): d = 0,27 con XC26, el resto con el ancho."""
    lo, hi = [], []
    for (e, _, t) in diseno:
        l = ("XC26" if e == "d027" else "ancho") if lector == "mixto" else lector
        piso, piso85, techo = LECTORES[l]
        lo.append(math.log10(piso85 if t == 85 else piso)); hi.append(math.log10(techo))
    return np.array(lo), np.array(hi)

def cargas(diseno, cal):
    """Fila a_j de cada lectura sobre la latente: C1 z = g; C2 z = (g, δ), δ solo en las de 85 °C."""
    if cal == "C1":
        return np.ones((len(diseno), 1)), np.array([SIG_G ** 2])
    return np.array([[1.0, 1.0 if t == 85 else 0.0] for (_, _, t) in diseno]), np.array([SIG_G ** 2, SIG_D ** 2])

def simula(mu, diseno, lector, calib, rng):
    tipo, s = CALIB[calib]
    y = mu + rng.normal(0, s, mu.shape)
    if tipo != "C0":
        A, var0 = cargas(diseno, tipo)
        z = rng.normal(0, 1, (len(mu), len(var0))) * np.sqrt(var0)
        y = y + z @ A.T
    lo, hi = limites(diseno, lector)
    return np.where(y < lo, -np.inf, np.where(y > hi, np.inf, y))

def loglik_c0(y, mu, lo, hi, s):
    """y (B,J) con ±inf censurados, mu (N,J): log p(y | mu) (B,N), lecturas independientes."""
    out = 0.0
    for j in range(y.shape[1]):
        yj, mj = y[:, j:j + 1], mu[None, :, j]
        fin = np.isfinite(yj)
        g = -0.5 * ((np.where(fin, yj, 0) - mj) / s) ** 2 - math.log(s * math.sqrt(2 * math.pi))
        bajo = log_ndtr((lo[j] - mj) / s)
        alto = log_ndtr((mj - hi[j]) / s)
        out = out + np.where(fin, g, np.where(np.isneginf(yj), bajo, alto))
    return out

def loglik_lat(y, mu, lo, hi, s, A, var0):
    """C1/C2: log p(y | mu) integrando la latente z ~ N(0, diag(var0)), y = mu + A z + e, e ~ N(0, s²), con censura.
    Agrupa las lecturas externas por patrón de censura: la posterior de z solo depende del patrón."""
    B, J = y.shape
    N = mu.shape[0]
    out = np.empty((B, N))
    pat = np.where(np.isfinite(y), 0, np.where(np.isneginf(y), 1, 2))
    claves = {}
    for b in range(B):
        claves.setdefault(tuple(pat[b]), []).append(b)
    P0 = np.diag(1 / var0)
    for clave, filas in claves.items():
        filas = np.array(filas)
        u = [j for j in range(J) if clave[j] == 0]
        Au = A[u]
        Lam = P0 + Au.T @ Au / s ** 2
        Cov = np.linalg.inv(Lam)
        logdet = np.linalg.slogdet(Lam)[1] + np.sum(np.log(var0))
        ll = np.zeros((len(filas), N))
        if u:
            r = y[filas][:, u][:, None, :] - mu[None, :, u]          # (b, N, nu)
            eta = r @ Au / s ** 2                                      # (b, N, d)
            quad = np.sum(r ** 2, axis=2) / s ** 2 - np.einsum("bnd,de,bne->bn", eta, Cov, eta)
            ll += -0.5 * quad - 0.5 * logdet - 0.5 * len(u) * math.log(2 * math.pi * s ** 2)
            zm = eta @ Cov                                             # media posterior de z (b, N, d)
        else:
            zm = np.zeros((len(filas), N, len(var0)))
        # censuradas: la más restrictiva por (tipo, fila de carga)
        grupos = {}
        for j in range(J):
            if clave[j]:
                grupos.setdefault((clave[j], tuple(A[j])), []).append(j)
        for (tipo, a), js in grupos.items():
            a = np.array(a)
            sd = math.sqrt(s ** 2 + a @ Cov @ a)
            loc = zm @ a                                               # (b, N)
            if tipo == 1:   # bajo piso: mu_j + a z + e < lo_j para todas -> el menor margen
                c = np.min(np.stack([lo[j] - mu[:, j] for j in js]), axis=0)
                ll += log_ndtr((c[None, :] - loc) / sd)
            else:           # saturado: mu_j + a z + e > hi_j
                d = np.max(np.stack([hi[j] - mu[:, j] for j in js]), axis=0)
                ll += log_ndtr((loc - d[None, :]) / sd)
        out[filas] = ll
    return out

def logverosimilitudes(var, diseno, lector, calib, n_ext, n_int, semilla, bloque=40):
    rng = np.random.default_rng(semilla)
    mecs = VARIANTES[var][0]
    lo, hi = limites(diseno, lector)
    tipo, s = CALIB[calib]
    ys, ver = [], []
    for k, m in enumerate(mecs):
        mu = medias(m, muestrea(m, n_ext, rng, var), diseno, var)
        ys.append(simula(mu, diseno, lector, calib, rng)); ver += [k] * n_ext
    ys, ver = np.vstack(ys), np.array(ver)
    logp = np.empty((len(ys), len(mecs)))
    for k, m in enumerate(mecs):
        mu = medias(m, muestrea(m, n_int, rng, var), diseno, var)
        for a in range(0, len(ys), bloque):
            yb = ys[a:a + bloque]
            if tipo == "C0":
                ll = loglik_c0(yb, mu, lo, hi, s)
            else:
                A, var0 = cargas(diseno, tipo)
                ll = loglik_lat(yb, mu, lo, hi, s, A, var0)
            logp[a:a + bloque, k] = np.logaddexp.reduce(ll, axis=1) - math.log(n_int)
    return ver, logp, mecs

def resume(ver, logp, grupos=None):
    """Información mutua (bits) ± error de MC y acierto del MAP, prior uniforme sobre mecanismos. grupos: lista de conjuntos
    de índices de mecanismo para una pregunta agregada (p. ej. túnel sí / no)."""
    K = logp.shape[1]
    prior = np.full(K, 1 / K)
    lpost = logp + np.log(prior)
    lpy = np.logaddexp.reduce(lpost, axis=1)
    if grupos is None:
        bits = (logp[np.arange(len(ver)), ver] - lpy) / LN10 * LN10 / math.log(2)
        mapa = np.argmax(lpost, axis=1)
        verd = ver
        pg = prior
    else:
        lg = np.stack([np.logaddexp.reduce(lpost[:, list(g)], axis=1) for g in grupos], axis=1)
        verd = np.array([next(i for i, g in enumerate(grupos) if v in g) for v in ver])
        pg = np.array([prior[list(g)].sum() for g in grupos])
        bits = (lg[np.arange(len(ver)), verd] - lpy - np.log(pg[verd])) / math.log(2)
        mapa = np.argmax(lg, axis=1)
    info = err = acierto = 0.0
    for k in range(K):
        sel = ver == k
        info += prior[k] * bits[sel].mean()
        err += (prior[k] * bits[sel].std()) ** 2 / sel.sum()
        acierto += prior[k] * (mapa[sel] == verd[sel]).mean()
    return info, math.sqrt(err), acierto

CORRIDAS = (
    [("V0inf", c, "ancho") for c in ("C0_0.05", "C0_0.5")]
    + [("V0", c, "ancho") for c in ("C0_0.05", "C0_0.5")]
    + [(v, c, "ancho") for v in ("V1", "V2", "V3") for c in ("C0_0.05", "C1")]
    + [("V4", c, "ancho") for c in ("C0_0.05", "C0_0.5", "C1", "C2")]
    + [("V4", c, "XC26") for c in ("C0_0.05", "C1")]
)

def main():
    rapido, conv = "--rapido" in sys.argv, "--convergencia" in sys.argv
    n_ext, n_int = (60, 2000) if rapido else (600, 40000)
    corridas = CORRIDAS
    if conv:
        n_int *= 4
        corridas = [("V4", c, "ancho") for c in ("C1", "C2")]
    if "--mixto" in sys.argv:  # exploratorio: el lector mixto con los dos techos de K
        corridas = [(v, c, "mixto") for v in ("V4", "V4K9") for c in ("C0_0.05", "C0_0.5", "C1")]
    if "--extra" in sys.argv:  # tras la verificación: las de V4 con XC26 que faltaban, y la sensibilidad a K
        corridas = [("V4", c, "XC26") for c in ("C0_0.5", "C2")] + \
                   [(v, c, l) for v in ("V4K9", "V4K12") for c in ("C0_0.05", "C0_0.5", "C1") for l in ("ancho", "XC26")]
    lineas = ["# motor2: %d lecturas por mecanismo, %d chips internos; bits ± error de MC; acierto del MAP" % (n_ext, n_int),
              "| variante | calibración | lector | diseño | I(M;Y) | acierto | I(túnel;Y) | acierto túnel | s |", "|" + "---|" * 9]
    print(lineas[0], flush=True)
    for (var, cal, lector) in corridas:
        for dn, d in DISENOS.items():
            t0 = time.time()
            ver, logp, mecs = logverosimilitudes(var, d, lector, cal, n_ext, n_int, semilla=20261115)
            b, e, a = resume(ver, logp)
            tun = [{i for i, m in enumerate(mecs) if m in "TM"}, {i for i, m in enumerate(mecs) if m in "RG"}]
            bt, et, at = resume(ver, logp, tun)
            l = "| %s | %s | %s | %s | %.3f ± %.3f | %.3f | %.3f ± %.3f | %.3f | %.0f |" % (
                var, cal, lector, dn, b, e, a, bt, et, at, time.time() - t0)
            print(l, flush=True); lineas.append(l)
    if not rapido:
        nombre = "convergencia2.txt" if conv else ("extra2.txt" if "--extra" in sys.argv else ("mixto2.txt" if "--mixto" in sys.argv else "resultados2.txt"))
        open(__file__.replace("motor2.py", nombre), "w").write("\n".join(lineas) + "\n")

if __name__ == "__main__":
    main()
