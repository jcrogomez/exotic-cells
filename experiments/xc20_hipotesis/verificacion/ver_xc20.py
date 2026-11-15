#!/usr/bin/env python3
"""Verificación independiente del motor de hipótesis XC-20 (T, R, G).

Escrito sin leer motor.py / motor.log / resultados.txt; solo PREREG.md y las definiciones del encargo.

Método: I(M;Y) = H(M) + sum_m pi_m E_{y|m}[log2 p(m|y)].
- Exterior: Monte Carlo estratificado (N muestras por mecanismo), con números aleatorios comunes entre diseños
  (mismo theta y mismo ruido para la medida compartida) => diferencias pareadas con error propio.
- Interior: la verosimilitud marginal p(y|m) se integra con cuasi-Monte Carlo (Sobol aleatorizado, M puntos) sobre los
  parámetros molestos; los factores censurados (bajo piso / saturado) se precalculan exactos por punto (log Phi),
  y los legibles son la densidad gaussiana exacta. No hay muestreo del ruido en el interior.
- Convergencia: se repite con M = 2^14, 2^16, 2^18 y dos aleatorizaciones del Sobol.
- Controles analíticos (sigma -> 0): XC26 D0 = log2(3) - 2/3 = 0,9183 bits; ancho D0 = 1,362 bits (ver informe).

Uso: ver_xc20.py [N_por_mecanismo] [log2_M]
"""
import sys, time, json
import numpy as np
from scipy.stats import qmc
from scipy.special import log_ndtr, logsumexp

KB = 8.617333262e-5
T27, T85 = 300.15, 358.15
KT = (1.0 / T27 - 1.0 / T85) / KB          # exp(Ea*KT) = factor 27->85 °C

# medidas: (V, temperatura, dibujo)
MEAS = {
    'd0_18_27':  (1.8, 27, 'd0'),
    'd27_18_27': (1.8, 27, 'd27'),
    'd0_18_85':  (1.8, 85, 'd0'),
    'd27_18_85': (1.8, 85, 'd27'),
    'd0_09_27':  (0.9, 27, 'd0'),
}
MKEYS = list(MEAS)
READERS = {
    'XC26':  {'floor': {27: 150e-15, 85: 0.1e-12}, 'ceil': 1.25e-9},
    'ancho': {'floor': {27: 1e-9, 85: 1e-9}, 'ceil': 1e-3},
}
DESIGNS = {
    'a_D0':        ['d0_18_27', 'd27_18_27'],
    'b_D0+85C':    ['d0_18_27', 'd27_18_27', 'd0_18_85', 'd27_18_85'],
    'c_D0+-0.9V':  ['d0_18_27', 'd27_18_27', 'd0_09_27'],
}
CONFIGS = [('a_D0', 'XC26'), ('a_D0', 'ancho'), ('b_D0+85C', 'ancho'),
           ('c_D0+-0.9V', 'XC26'), ('c_D0+-0.9V', 'ancho')]
HYP = ['T', 'R', 'G']


def logu(u, lo, hi):
    return 10 ** (np.log10(lo) + u * (np.log10(hi) - np.log10(lo)))


def currents(h, U):
    """U: (n, 8) uniformes. Devuelve dict medida -> log10 I."""
    g0 = logu(U[:, 0], 3e-18, 2e-12)
    eag = 0.56 + U[:, 1] * (1.12 - 0.56)
    fg = 1.0 + U[:, 2] * 0.4
    t0 = logu(U[:, 3], 12e-9, 0.5e-3)
    eat = 0.010 + U[:, 4] * 0.024
    ft = logu(U[:, 5], 15, 57)
    R = logu(U[:, 6], 10, 1e5)
    tcr = 0.002 + U[:, 7] * 0.002
    out = {}
    for k, (V, tc, d) in MEAS.items():
        I = g0.copy()
        if V == 0.9:
            I = I / fg
        if tc == 85:
            I = I * np.exp(eag * KT)
        if d == 'd0':
            if h == 'T':
                x = t0 * (1 / ft if V == 0.9 else 1.0) * (np.exp(eat * KT) if tc == 85 else 1.0)
                I = I + x
            elif h == 'R':
                x = V / R / ((1 + tcr * 58) if tc == 85 else 1.0)
                I = I + x
        out[k] = np.log10(I)
    return out


def inner_points(M, seed):
    pts = {}
    for i, h in enumerate(HYP):
        s = qmc.Sobol(8, scramble=True, seed=seed * 10 + i)
        pts[h] = currents(h, s.random(M))
    return pts


def outer_sample(N, seed):
    rng = np.random.default_rng(seed)
    X, E = {}, {}
    for h in HYP:
        X[h] = currents(h, rng.random((N, 8)))
        E[h] = {k: rng.standard_normal(N) for k in MKEYS}   # ruido estándar, se escala por sigma
    return X, E


def censor(y, k, reader):
    tc = MEAS[k][1]
    lf = np.log10(READERS[reader]['floor'][tc]); lc = np.log10(READERS[reader]['ceil'])
    o = np.where(y < lf, 0, np.where(y > lc, 2, 1))
    return o, lf, lc


def loglik(yobs, inner_x, keys, reader, sigma, chunk=48):
    """yobs: dict k -> (o, y) arrays (n,). inner_x: dict k -> (M,). Devuelve log p(y|h) (n,)."""
    n = len(yobs[keys[0]][0])
    M = len(inner_x[keys[0]])
    pre = {}
    for k in keys:
        tc = MEAS[k][1]
        lf = np.log10(READERS[reader]['floor'][tc]); lc = np.log10(READERS[reader]['ceil'])
        x = inner_x[k]
        pre[k] = (log_ndtr((lf - x) / sigma), log_ndtr((x - lc) / sigma), x)
    res = np.empty(n)
    for s in range(0, n, chunk):
        e = min(n, s + chunk)
        tot = np.zeros((e - s, M))
        for k in keys:
            o, y = yobs[k][0][s:e], yobs[k][1][s:e]
            lo, sa, x = pre[k]
            q = -0.5 * ((y[:, None] - x[None, :]) / sigma) ** 2
            tot += np.where(o[:, None] == 1, q, np.where(o[:, None] == 0, lo[None, :], sa[None, :]))
        res[s:e] = logsumexp(tot, axis=1) - np.log(M)
    return res


def run(N, logM, seed_outer=1, seed_inner=1, sigmas=(0.05, 0.5), configs=CONFIGS):
    X, E = outer_sample(N, seed_outer)
    inner = inner_points(2 ** logM, seed_inner)
    results = {}
    for sigma in sigmas:
        for (dname, reader) in configs:
            keys = DESIGNS[dname]
            LL = {}   # LL[htrue][hmodel] -> (N,)
            for ht in HYP:
                yobs = {}
                for k in keys:
                    y = X[ht][k] + sigma * E[ht][k]
                    o, _, _ = censor(y, k, reader)
                    yobs[k] = (o, y)
                LL[ht] = {hm: loglik(yobs, inner[hm], keys, reader, sigma) for hm in HYP}
            results[(sigma, dname, reader)] = LL
    return results


def summarize(LL, prior=(1/3, 1/3, 1/3)):
    lp = np.log(np.array(prior))
    H = -np.sum(np.array(prior) * np.log2(prior))
    I = H; var = 0.0; acc = 0.0; accv = 0.0; bayes = 0.0
    per = {}
    for j, ht in enumerate(HYP):
        L = np.stack([LL[ht][hm] for hm in HYP], axis=1) + lp[None, :]
        post = L - logsumexp(L, axis=1, keepdims=True)
        lpt = post[:, j] / np.log(2)
        P = np.exp(post)
        mx = P.max(axis=1, keepdims=True)
        ties = np.isclose(P, mx, rtol=1e-9, atol=1e-12)
        hit = ties[:, j] / ties.sum(axis=1)
        N = len(lpt)
        I += prior[j] * lpt.mean(); var += prior[j] ** 2 * lpt.var(ddof=1) / N
        acc += prior[j] * hit.mean(); accv += prior[j] ** 2 * hit.var(ddof=1) / N
        bayes += prior[j] * mx[:, 0].mean()
        per[ht] = lpt
    return dict(I=I, se=np.sqrt(var), acc=acc, acc_se=np.sqrt(accv), bayes_acc=bayes, per=per)


def paired_diff(s1, s2, prior=(1/3, 1/3, 1/3)):
    d = 0.0; v = 0.0
    for j, ht in enumerate(HYP):
        x = s1['per'][ht] - s2['per'][ht]
        d += prior[j] * x.mean(); v += prior[j] ** 2 * x.var(ddof=1) / len(x)
    return d, np.sqrt(v)


if __name__ == '__main__':
    N = int(sys.argv[1]) if len(sys.argv) > 1 else 3000
    logM = int(sys.argv[2]) if len(sys.argv) > 2 else 16
    t0 = time.time()
    out = {}
    LL1 = None
    for si in (1, 2):
        res = run(N, logM, seed_outer=1, seed_inner=si)
        if si == 1:
            LL1 = res
        for key, LL in res.items():
            s = summarize(LL)
            out.setdefault(key, []).append(s)
            print(f"sigma={key[0]:<5} {key[1]:<11} {key[2]:<6} innerseed={si} M=2^{logM} N={N}/mec: "
                  f"I={s['I']:.4f}±{s['se']:.4f} bits  acierto={s['acc']:.4f}±{s['acc_se']:.4f} "
                  f"E[max post]={s['bayes_acc']:.4f}", flush=True)
    print('\nDiferencias pareadas (mismo exterior, semilla interior 1):')
    for sigma in (0.05, 0.5):
        g = lambda d, r: out[(sigma, d, r)][0]
        for (d1, r1, d2, r2) in [('b_D0+85C', 'ancho', 'a_D0', 'ancho'),
                                 ('c_D0+-0.9V', 'ancho', 'a_D0', 'ancho'),
                                 ('c_D0+-0.9V', 'XC26', 'a_D0', 'XC26'),
                                 ('c_D0+-0.9V', 'ancho', 'b_D0+85C', 'ancho')]:
            dd, se = paired_diff(g(d1, r1), g(d2, r2))
            print(f"sigma={sigma}: {d1}/{r1} - {d2}/{r2} = {dd:+.4f} ± {se:.4f} bits")
    print('\nSensibilidad al prior (orden T, R, G; semilla interior 1):')
    for pr in [(0.2, 0.2, 0.6), (0.6, 0.2, 0.2)]:
        for key, LL in LL1.items():
            s = summarize(LL, pr)
            print(f"prior={pr} sigma={key[0]:<5} {key[1]:<11} {key[2]:<6}: I={s['I']:.4f}±{s['se']:.4f} "
                  f"(H={-sum(p*np.log2(p) for p in pr):.4f}) acierto={s['acc']:.4f}")
    print(f"\ntiempo {time.time()-t0:.1f} s")
