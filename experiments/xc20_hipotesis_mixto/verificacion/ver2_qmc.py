#!/usr/bin/env python3
"""Estimador A: verosimilitud por cuasi-Monte Carlo (Sobol aleatorizado) sobre los parámetros, con la calibración
(g común; g y δ en C2) integrada ANALÍTICAMENTE para las lecturas legibles (modelo lineal-gaussiano) y los factores
censurados evaluados con la marginal gaussiana exacta del desplazamiento posterior.

  p(y|m) ~= (1/M) sum_j p(y | x_j),  x_j = corrientes del chip interior j (Sobol, 13 dimensiones)
  p(y | x) = N(r_R; 0, σe² I + A Σz Aᵀ) · prod_c Φ(± (umbral_c − x_c − a_cᵀ μz) / sqrt(σe² + a_cᵀ Pz⁻¹ a_c))
  con r_R = y_R − x_R (legibles), μz, Pz⁻¹ la posterior gaussiana de z=(g[,δ]) dadas las legibles.
- Un factor censurado: exacto. Varios censurados con lecturas legibles: producto de marginales (aproximación; su error
  se mide en ver2_qmc_check). Ninguna legible con C1/C2: la verosimilitud solo depende del patrón y se integra g en
  rejilla fina (1201 puntos, ±6σg) y δ por Gauss-Hermite (7 nodos).
- Exterior: las mismas lecturas de prueba que el estimador B (semilla 2000), primeras N por mecanismo => comparación
  muestra a muestra con la cota de B.

Uso: ver2_qmc.py VAR CALIB LECTOR N_por_mec log2M semilla_sobol [diseños]
"""
import sys, time
import numpy as np
from scipy.stats import qmc
from scipy.special import log_ndtr, logsumexp
from ver2_modelo import MKEYS, MEAS, DESIGNS, DNAMES, VARIANTS, CALIB, NDIM, currents, thresholds
from ver2_clasif import gen

LOG2 = np.log(2.0)


def latent_A(keys, calib):
    se, sg, sd = CALIB[calib]
    if sg == 0:
        return None, None
    if sd == 0:
        return np.ones((len(keys), 1)), np.array([sg ** 2])
    return np.array([[1.0, 1.0 if MEAS[k][1] == 85 else 0.0] for k in keys]), np.array([sg ** 2, sd ** 2])


def loglik_pattern_only(Xin, keys, pat, reader, calib):
    """Ninguna legible, con calibración común: p(patrón | m) promediado sobre los chips interiores."""
    se, sg, sd = CALIB[calib]
    gg = np.linspace(-6 * sg, 6 * sg, 1201)
    wg = np.exp(-0.5 * (gg / sg) ** 2); wg /= wg.sum()
    if sd > 0:
        zh, wh = np.polynomial.hermite_e.hermegauss(7); wh = wh / wh.sum(); dd = sd * zh
    else:
        dd, wh = np.array([0.0]), np.array([1.0])
    M = len(Xin[keys[0]])
    tot = np.zeros(M)
    for d, wd in zip(dd, wh):
        acc = np.zeros(M)
        for s in range(0, M, 4096):
            L = np.zeros((min(M, s + 4096) - s, len(gg)))
            for k, o in zip(keys, pat):
                lf, lc = thresholds(k, reader)
                x = Xin[k][s:s + 4096][:, None] + gg[None, :] + (d if MEAS[k][1] == 85 else 0.0)
                L += log_ndtr((lf - x) / se) if o == 0 else log_ndtr((x - lc) / se)
            acc[s:s + 4096] = np.exp(L) @ wg
        tot += wd * acc
    return np.log(tot.mean() + 1e-300)


def loglik(Y, O, Xin, keys, reader, calib, chunk=24):
    """Y, O: (n, K) lecturas y estados; Xin: dict k -> (M,). Devuelve log p(y|m) (n,)."""
    se, sg, sd = CALIB[calib]
    A, Sz = latent_A(keys, calib)
    n = len(Y); M = len(Xin[keys[0]])
    X = np.stack([Xin[k] for k in keys], axis=1)            # (M, K)
    thr = np.array([thresholds(k, reader) for k in keys])   # (K, 2)
    out = np.empty(n)
    pats, inv = np.unique(O, axis=0, return_inverse=True)
    inv = inv.ravel()
    for ip, pat in enumerate(pats):
        idx = np.where(inv == ip)[0]
        R = np.where(pat == 1)[0]; Cc = np.where(pat != 1)[0]
        nr = len(R)
        if nr == 0 and A is not None:
            out[idx] = loglik_pattern_only(Xin, keys, pat, reader, calib)
            continue
        # constantes del patrón
        if A is not None:
            AR = A[R]; P = AR.T @ AR / se ** 2 + np.diag(1.0 / Sz); Pi = np.linalg.inv(P)
            logdetC = nr * np.log(se ** 2) + np.log(np.linalg.det(np.diag(Sz) @ P))
            if len(Cc):
                AC = A[Cc]; vC = np.einsum('ij,jk,ik->i', AC, Pi, AC); sC = np.sqrt(se ** 2 + vC)
        else:
            logdetC = nr * np.log(se ** 2)
            sC = np.full(len(Cc), se)
        const = -0.5 * nr * np.log(2 * np.pi) - 0.5 * logdetC
        for s in range(0, len(idx), chunk):
            ii = idx[s:s + chunk]
            tot = np.full((len(ii), M), const)
            if nr:
                r = Y[ii][:, None, R] - X[None, :, R]                   # (c, M, nr)
                q = np.einsum('cmr,cmr->cm', r, r) / se ** 2
                if A is not None:
                    b = r @ AR / se ** 2                                # (c, M, nz)
                    mu = b @ Pi                                          # (c, M, nz)
                    q = q - np.einsum('cmz,cmz->cm', b, mu)
                tot += -0.5 * q
            for t, c in enumerate(Cc):
                lf, lc = thr[c]
                off = (mu @ A[c]) if (A is not None and nr) else 0.0
                x = X[None, :, c] + off
                tot += log_ndtr((lf - x) / sC[t]) if pat[c] == 0 else log_ndtr((x - lc) / sC[t])
            out[ii] = logsumexp(tot, axis=1) - np.log(M)
    return out


def main():
    a = sys.argv
    var, calib, reader = a[1], a[2], a[3]
    N = int(a[4]); logM = int(a[5]); sseed = int(a[6])
    designs = a[7].split(',') if len(a) > 7 else DNAMES
    t0 = time.time()
    mechs = VARIANTS[var]['mechs']; C = len(mechs)
    ote, yte = gen(var, calib, reader, 100000, 2000)
    sel = np.concatenate([np.where(yte == j)[0][:N] for j in range(C)])
    M = 2 ** logM
    Xin = {}
    for j, m in enumerate(mechs):
        U = qmc.Sobol(NDIM, scramble=True, seed=sseed * 100 + j).random(M)
        Xin[m] = currents(U, m, var)
    print(f"# A {var} {calib} {reader} N={N}/mec M=2^{logM} sobol={sseed} (interior {time.time()-t0:.0f} s)", flush=True)
    tidx = [mechs.index('T'), mechs.index('M')] if 'M' in mechs else None
    store = {}
    for d in designs:
        keys = DESIGNS[d]
        Y = np.stack([ote[k][1][sel] for k in keys], axis=1)
        O = np.stack([ote[k][0][sel] for k in keys], axis=1)
        L = np.stack([loglik(Y, O, Xin[m], keys, reader, calib) for m in mechs], axis=1)
        post = L - logsumexp(L, axis=1, keepdims=True)
        yt = yte[sel]
        lt = post[np.arange(len(yt)), yt] / LOG2
        per = [lt[yt == j] for j in range(C)]
        I = np.log2(C) + np.mean([p.mean() for p in per])
        se = np.sqrt(sum(p.var(ddof=1) / len(p) for p in per)) / C
        P = np.exp(post)
        mx = P.max(1, keepdims=True); ties = np.isclose(P, mx, rtol=1e-9, atol=1e-12)
        hit = ties[np.arange(len(yt)), yt] / ties.sum(1)
        acc = np.mean([hit[yt == j].mean() for j in range(C)])
        conf = np.array([[np.mean(P[yt == j].argmax(1) == i) for i in range(C)] for j in range(C)])
        cs = ' '.join(f"{mechs[j]}->" + '/'.join(f"{x:.2f}" for x in row) for j, row in enumerate(conf))
        extra = ''
        if tidx:
            qt = P[:, tidx].sum(1); tt = np.isin(yt, tidx)
            lqt = np.log2(np.clip(np.where(tt, qt, 1 - qt), 1e-300, None))
            perT = [lqt[yt == j] for j in range(C)]
            It = 1 + np.mean([p.mean() for p in perT]); seT = np.sqrt(sum(p.var(ddof=1) / len(p) for p in perT)) / C
            accT = np.mean([((qt[yt == j] > 0.5) == tt[yt == j]).mean() for j in range(C)])
            extra = f"  I(tunel)={It:.4f}±{seT:.4f} acierto_tunel={accT:.4f}"
        print(f"A {var} {calib} {reader} {d:<14} I={I:.4f}±{se:.4f} acierto={acc:.4f}{extra}  [{cs}]  ({time.time()-t0:.0f} s)",
              flush=True)
        store[d] = lt
    pairs = [('D0+-0.9V', 'D0+85C'), ('D0+85C', 'D0'), ('D0+-0.9V', 'D0'), ('D0+peine', 'D0')]
    yt = yte[sel]
    for d1, d2 in pairs:
        if d1 in store and d2 in store:
            x = store[d1] - store[d2]; per = [x[yt == j] for j in range(C)]
            print(f"A {var} {calib} {reader} DIF {d1} - {d2} = {np.mean([p.mean() for p in per]):+.4f} ± "
                  f"{np.sqrt(sum(p.var(ddof=1)/len(p) for p in per))/C:.4f}", flush=True)
    np.savez_compressed(f"ver2_A_lt_{var}_{calib}_{reader}_N{N}_M{logM}_s{sseed}.npz", sel=sel, yte=yt,
                        **{d: store[d].astype(np.float32) for d in store})
    print(f"# tiempo {time.time()-t0:.0f} s", flush=True)


if __name__ == '__main__':
    main()
