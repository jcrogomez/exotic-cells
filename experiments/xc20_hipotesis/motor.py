#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Motor de hipótesis, prototipo mínimo para XC-20 (ver PREREG.md, escrito antes de este código).

Tres mecanismos rivales para la corriente de la unión p+/n+ pegada: T (túnel banda a banda), R (puente óhmico), G (unión
ordinaria: difusión y generación). Cada uno es una distribución sobre parámetros (intervalos de b20 o supuestos marcados); un
diseño es un conjunto de medidas (estructura, tensión, temperatura) leídas por un lector con piso, techo y error. El motor estima
la información mutua entre mecanismo y lecturas (bits) y la probabilidad de acierto del máximo a posteriori.

    python3 motor.py                 # tabla completa -> resultados.txt
    python3 motor.py --rapido        # menos muestras, para la CI
"""
import itertools, math, sys
import numpy as np

KB = 8.617333e-5           # eV/K
T27, T85 = 300.15, 358.15
ARR = 1 / T27 - 1 / T85     # factor de Arrhenius entre 27 y 85 °C: I85/I27 = exp(Ea/KB * ARR)
MECS = ("T", "R", "G")

# --- Mecanismos: muestreo de parámetros (cada intervalo, con su fuente, en PREREG.md) -----------------------------------
def logu(rng, lo, hi, n):
    return 10 ** rng.uniform(math.log10(lo), math.log10(hi), n)

def muestrea(m, n, rng):
    """Parámetros de n chips bajo el mecanismo m. Todas las hipótesis llevan el fondo térmico G de la unión."""
    p = {"g0": logu(rng, 3e-18, 2e-12, n),            # I(-1,8 V, 27 °C) térmica, celda de 1,4 µm²
         "gea": rng.uniform(0.56, 1.12, n),           # eV: generación (Eg/2) a difusión (Eg)
         "gsh": rng.uniform(1.0, 1.4, n)}             # I(-1,8)/I(-0,9) térmica
    if m == "T":
        p.update(t0=logu(rng, 12e-9, 0.5e-3, n), tea=rng.uniform(0.010, 0.034, n), tsh=logu(rng, 15, 57, n))
    elif m == "R":
        p.update(rb=logu(rng, 10, 1e5, n), tcr=rng.uniform(0.002, 0.004, n))
    return p

def corriente(m, p, est, v, t):
    """Corriente (A) de la estructura est a la tensión inversa v (1,8 o 0,9 V) y temperatura t (27 o 85 °C)."""
    fr = {"base": 1.0, "peine": 4.0, "d027": 0.0}[est]   # largo de frontera pegada relativo (d = 0,27: sin frontera pegada)
    i = p["g0"] * np.exp(p["gea"] / KB * ARR * (t == 85))   # la parte térmica escala con el área (igual en las tres)
    if v == 0.9:
        i = i / p["gsh"]
    if m == "T" and fr:
        it = p["t0"] * fr * np.exp(p["tea"] / KB * ARR * (t == 85))
        i = i + (it / p["tsh"] if v == 0.9 else it)
    if m == "R" and fr:
        ir = v / p["rb"] * fr
        i = i + (ir / (1 + p["tcr"] * 58) if t == 85 else ir)
    return i

# --- Instrumento --------------------------------------------------------------------------------------------------------
LECTORES = {  # (piso a 27 °C, piso a 85 °C, techo) en A
    "XC26":  (150e-15, 0.1e-12, 1.25e-9),   # lector de precarga tal cual; techo calculado (12,5 fC en 100 ciclos de 100 ns)
    "ancho": (1e-9, 1e-9, 1e-3),            # propuesta: espejo divisor o pin analógico
    "ambos": (150e-15, 0.1e-12, 1e-3),      # los dos lectores en el mismo canal
}

def lee(i, lector, t, sigma, rng):
    """Lectura: log10(I) con error gaussiano; -inf = bajo piso, +inf = saturado."""
    piso, piso85, techo = LECTORES[lector]
    lo = math.log10(piso85 if t == 85 else piso)
    y = np.log10(np.maximum(i, 1e-30)) + rng.normal(0, sigma, i.shape)
    return np.where(y < lo, -np.inf, np.where(y > math.log10(techo), np.inf, y))

def loglik(y, i, lector, t, sigma):
    """log p(y | corriente verdadera i), y de forma (N,1), i de forma (1,K)."""
    piso, piso85, techo = LECTORES[lector]
    lo, hi = math.log10(piso85 if t == 85 else piso), math.log10(techo)
    mu = np.log10(np.maximum(i, 1e-30))
    z_lo, z_hi = (lo - mu) / sigma, (hi - mu) / sigma
    phi = lambda z: 0.5 * (1 + _erf(z / math.sqrt(2)))
    out = -0.5 * ((y - mu) / sigma) ** 2 - math.log(sigma * math.sqrt(2 * math.pi))
    out = np.where(np.isneginf(y), np.log(np.maximum(phi(z_lo), 1e-300)), out)
    out = np.where(np.isposinf(y), np.log(np.maximum(1 - phi(z_hi), 1e-300)), out)
    return out

try:
    from scipy.special import erf as _erf
except ImportError:  # sin scipy: erf vectorizada de numpy
    _erf = np.vectorize(math.erf)

# --- Motor: información mutua por Monte Carlo anidado -------------------------------------------------------------------
def corriente_mec(m, p, est, v, t):
    """Solo la parte del mecanismo (sin la fuga térmica), para T y R."""
    q = dict(p, g0=np.zeros_like(p["t0"] if m == "T" else p["rb"]))
    return corriente(m, q, est, v, t)

def logverosimilitudes(diseno, lector, sigma, n_por_mec, n_int, semilla, bloque=100):
    """Lecturas simuladas (n_por_mec por mecanismo verdadero) y log p(y | m) salvo un término común a los tres mecanismos.

    Las lecturas de d = 0,27 (solo fuga térmica, misma distribución bajo T, R y G) dan un factor p_th(y) común a T y R que se
    cancela al comparar; bajo T y R la fuga térmica de las estructuras con frontera se toma de la lectura de d = 0,27 a la misma
    temperatura (misma área; /1,2 a 0,9 V), que es la resta que haría el experimentador. Bajo G se promedia sobre chips
    internos pesados por las lecturas de d = 0,27 (p(y|G)/p_th(y)). Devuelve (verdadero, logp)."""
    rng = np.random.default_rng(semilla)
    ver = np.repeat(np.arange(3), n_por_mec)
    ys = np.empty((3 * n_por_mec, len(diseno)))
    for k, m in enumerate(MECS):
        p = muestrea(m, n_por_mec, rng)
        for j, (est, v, t) in enumerate(diseno):
            ys[k * n_por_mec:(k + 1) * n_por_mec, j] = lee(corriente(m, p, est, v, t), lector, t, sigma, rng)
    ter = [j for j, (est, v, t) in enumerate(diseno) if est == "d027"]
    fro = [j for j, (est, v, t) in enumerate(diseno) if est != "d027"]
    # fuga térmica estimada por lectura para T y R: la de d = 0,27 a la misma temperatura (0 si quedó bajo piso)
    th = {}
    for j in fro:
        est, v, t = diseno[j]
        jt = [i for i in ter if diseno[i][2] == t]
        y0 = ys[:, jt[0]] if jt else np.full(len(ys), -np.inf)
        th[j] = np.where(np.isfinite(y0), 10 ** np.where(np.isfinite(y0), y0, 0), 0.0) / (1.2 if v == 0.9 else 1.0)
    logp = np.empty((len(ys), 3))
    for k, m in enumerate(MECS):
        p = muestrea(m, n_int, rng)
        for a in range(0, len(ys), bloque):
            sl = slice(a, min(a + bloque, len(ys)))
            if m == "G":
                lw = np.zeros((sl.stop - a, n_int))
                for j in ter:
                    est, v, t = diseno[j]
                    lw += loglik(ys[sl, j:j + 1], corriente(m, p, est, v, t)[None, :], lector, t, sigma)
                ll = lw.copy()
                for j in fro:
                    est, v, t = diseno[j]
                    ll += loglik(ys[sl, j:j + 1], corriente(m, p, est, v, t)[None, :], lector, t, sigma)
                logp[sl, k] = np.logaddexp.reduce(ll, axis=1) - np.logaddexp.reduce(lw, axis=1) if ter else \
                    np.logaddexp.reduce(ll, axis=1) - math.log(n_int)
            else:
                ll = np.zeros((sl.stop - a, n_int))
                for j in fro:
                    est, v, t = diseno[j]
                    cur = corriente_mec(m, p, est, v, t)[None, :] + th[j][sl, None]
                    ll += loglik(ys[sl, j:j + 1], cur, lector, t, sigma)
                logp[sl, k] = np.logaddexp.reduce(ll, axis=1) - math.log(n_int)
    return ver, logp

def resume(ver, logp, prior):
    """Información mutua (bits) y su error de MC, acierto del máximo a posteriori y matriz de confusión, para un prior."""
    lpri = np.log(np.asarray(prior))
    lpost = logp + lpri
    lpy = np.logaddexp.reduce(lpost, axis=1)
    bits = (logp[np.arange(len(ver)), ver] - lpy) / math.log(2)
    mapa = np.argmax(lpost, axis=1)
    info = err = acierto = 0.0
    conf = np.zeros((3, 3))
    for k in range(3):
        s = ver == k
        info += prior[k] * bits[s].mean()
        err += (prior[k] * bits[s].std()) ** 2 / s.sum()
        acierto += prior[k] * (mapa[s] == k).mean()
        conf[k] = np.bincount(mapa[s], minlength=3) / s.sum()
    return info, math.sqrt(err), acierto, conf

BASE = [("base", 1.8, 27), ("d027", 1.8, 27)]  # la celda sin unión mide el lector y se resta: no añade lectura
DISENOS = {
    "D0 plan: d=0 y d=0,27; -1,8 V; 27 C": BASE,
    "D0 + 85 C": BASE + [("base", 1.8, 85), ("d027", 1.8, 85)],
    "D0 + -0,9 V": BASE + [("base", 0.9, 27)],
    "D0 + peine": BASE + [("peine", 1.8, 27)],
    "D0 + 85 C + -0,9 V": BASE + [("base", 1.8, 85), ("d027", 1.8, 85), ("base", 0.9, 27)],
    "solo d=0 a -1,8 y -0,9 V": [("base", 1.8, 27), ("base", 0.9, 27)],
}

def main():
    rapido = "--rapido" in sys.argv
    n_por_mec, n_int = (300, 4000) if rapido else (1000, 40000)
    priors = {"uniforme": (1 / 3, 1 / 3, 1 / 3), "G probable (0,2/0,2/0,6)": (0.2, 0.2, 0.6),
              "T probable (0,6/0,2/0,2)": (0.6, 0.2, 0.2)}
    sigmas = (0.05,) if rapido else (0.05, 0.5)
    lineas = ["# Motor de hipótesis XC-20: %d lecturas por mecanismo, %d chips internos; bits de información mutua (máx %.3f) "
              "± error de MC; acierto del máximo a posteriori; confusión = fracción asignada a (T, R, G)" % (n_por_mec, n_int, math.log2(3))]
    res = {}
    for sigma in sigmas:
        for (dn, d), lector in itertools.product(DISENOS.items(), LECTORES):
            res[sigma, dn, lector] = logverosimilitudes(d, lector, sigma, n_por_mec, n_int, semilla=20261114)
    for pn, prior in priors.items():
        for sigma in sigmas:
            lineas += ["", "## prior %s, sigma %.2f décadas" % (pn, sigma), "",
                       "| diseño | lector | bits | acierto | T→ | R→ | G→ |", "|---|---|---|---|---|---|---|"]
            for dn, lector in itertools.product(DISENOS, LECTORES):
                b, e, a, c = resume(*res[sigma, dn, lector], prior)
                fila = lambda r: "/".join("%.2f" % x for x in r)
                lineas.append("| %s | %s | %.3f ± %.3f | %.3f | %s | %s | %s |" % (dn, lector, b, e, a, fila(c[0]), fila(c[1]), fila(c[2])))
    texto = "\n".join(lineas) + "\n"
    print(texto)
    if not rapido:
        open(__file__.replace("motor.py", "resultados.txt"), "w").write(texto)

if __name__ == "__main__":
    main()
