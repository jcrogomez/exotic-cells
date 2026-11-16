#!/usr/bin/env python3
"""Estimador del verificador, ronda 3: cotas de Barber-Agakov con un perceptrón multi-cabeza (ver3_red.py).

  I(Z;Y) >= H(Z) + E[log2 q(z|y)]  para cualquier q (cota INFERIOR; holgura = E KL(p(z|y) || q(z|y)) >= 0).

Cabezas: mecanismo (todas las muestras) · log10 K en 32 bins finos (solo chips con túnel) · q en 4 bins (solo túnel; no en
q fijo) · log10 B en 16 bins (todas; no en W0). I(túnel), I(F frente a túnel residual), I(s_X) y I(Kbin de 1 década) salen
de sumar probabilidades de esas cabezas (también son q válidas).

Uso: ver3_correr.py VAR ETIQUETA fila1 [fila2 ...]   con fila = CALIB:LECTOR:DISEÑO
Opciones por entorno: V3_NTR, V3_NTE (por clase), V3_H, V3_EP, V3_SEED, V3_TESTSEED.
Escribe ver3_R_<VAR>_<ETIQUETA>.txt y ver3_lt_<VAR>_<CALIB>_<LECTOR>_<DISEÑO>_<ETIQUETA>.npz.
"""
import os, sys, time
import numpy as np
from ver3_modelo import VARIANTS, DESIGNS, sample_world, observe, features, flags_of
from ver3_red import train_eval

DESIGNS = dict(DESIGNS)
DESIGNS['E2sin27'] = [k for k in DESIGNS['E2'] if not k.startswith('d27')]   # mutante del testigo K


def env(k, d):
    return type(d)(os.environ.get(k, d))


def world(var, nper, seed):
    fn = f"ver3_mundo_{var}_n{nper}_s{seed}.npz"
    if os.path.exists(fn):
        z = np.load(fn)
        W = dict(lab=z['lab'], X={k[2:]: z[k] for k in z.files if k.startswith('X_')},
                 Z={k[2:]: z[k] for k in z.files if k.startswith('Z_')},
                 p={k[2:]: z[k] for k in z.files if k.startswith('p_')}, lsw_u=z['lsw_u'], lsw85=z['lsw85'], var=var)
        return W
    W = sample_world(nper, var, seed)
    np.savez(fn, lab=W['lab'], lsw_u=W['lsw_u'], lsw85=W['lsw85'], **{'X_' + k: v for k, v in W['X'].items()},
             **{'Z_' + k: v for k, v in W['Z'].items()}, **{'p_' + k: v for k, v in W['p'].items()})
    return W


def strat(v, lab, classes):
    """Media estratificada (peso igual por clase) y su error típico."""
    per = [v[lab == j] for j in classes]
    per = [p[np.isfinite(p)] for p in per]
    m = np.mean([p.mean() for p in per])
    se = np.sqrt(sum(p.var(ddof=1) / len(p) for p in per)) / len(per)
    return m, se


def kbins(var):
    kmax = VARIANTS[var]['kmax']
    lo, hi = np.log10(7e3), np.log10(kmax)
    nf = 32 if kmax > 1e7 else 8
    return lo, hi, nf, nf // 4


def kclass(P, lo, hi):
    """P: (n, nf) posterior en bins finos. Intervalo creíble = el tramo contiguo más corto con masa >= 0,9.
    Devuelve clase (0 estimada, 1 acotada, 2 nada), inicio y fin del tramo (índices) y la versión central."""
    n, nf = P.shape
    w = (hi - lo) / nf
    c = np.concatenate([np.zeros((n, 1)), np.cumsum(P, axis=1)], axis=1)
    best_len = np.full(n, nf + 1); best_a = np.zeros(n, int)
    for L in range(1, nf + 1):
        for a in range(0, nf - L + 1):
            ok = (c[:, a + L] - c[:, a] >= 0.9 - 1e-9) & (L < best_len)
            best_len = np.where(ok, L, best_len); best_a = np.where(ok, a, best_a)
    a = best_a; b = best_a + best_len        # tramo [a, b)
    width = best_len * w
    tlo = a == 0; thi = b == nf
    est = (width <= 2.0 + 1e-9) & ~tlo & ~thi
    exc_other = np.where(thi & ~tlo, a * w, np.where(tlo & ~thi, (nf - b) * w, 0.0))
    aco = (tlo ^ thi) & (exc_other >= 2.0 - 1e-9)
    cls = np.where(est, 0, np.where(aco, 1, 2))
    # central: cuantiles 5 y 95 % con densidad uniforme dentro de cada bin
    def quant(qq):
        idx = np.argmax(c >= qq, axis=1)           # primer borde con acumulada >= qq
        i0 = np.clip(idx - 1, 0, nf - 1)
        pm = P[np.arange(n), i0]
        fr = np.where(pm > 0, (qq - c[np.arange(n), i0]) / np.maximum(pm, 1e-300), 0.0)
        return lo + (i0 + np.clip(fr, 0, 1)) * w
    q05, q95 = quant(0.05), quant(0.95)
    ctlo = q05 < lo + w; cthi = q95 > hi - w
    cest = (q95 - q05 <= 2.0) & ~ctlo & ~cthi
    caco = (ctlo ^ cthi) & (np.where(cthi, q05 - lo, hi - q95) >= 2.0)
    ccls = np.where(cest, 0, np.where(caco, 1, 2))
    return cls, a, b, ccls, q05, q95


def main():
    var, tag = sys.argv[1], sys.argv[2]
    rows = [r.split(':') for r in sys.argv[3:]]
    v = VARIANTS[var]
    w2 = v['w2']
    C = len(v['mechs'])
    ntr = env('V3_NTR', {4: 300000, 5: 240000, 8: 150000}[C])
    nte = env('V3_NTE', {4: 100000, 5: 60000, 8: 40000}[C])
    H = env('V3_H', 128); EP = env('V3_EP', 8); seed = env('V3_SEED', 1); tseed = env('V3_TESTSEED', 2000)
    t00 = time.time()
    Wtr = world(var, ntr, 1000 + seed)
    Wte = world(var, nte, tseed)
    out = open(f"ver3_R_{var}_{tag}.txt", 'a')

    def say(s):
        print(s, flush=True); out.write(s + '\n'); out.flush()
    say(f"# {time.strftime('%Y-%m-%d %H:%M:%S %Z')} {var} {tag} ntr={ntr}/clase nte={nte}/clase H={H} ep={EP} "
        f"semilla={seed} prueba={tseed} (mundos {time.time()-t00:.0f} s)")
    fl_tr = np.array([flags_of(var, j) for j in range(C)])[Wtr['lab']]
    fl_te = np.array([flags_of(var, j) for j in range(C)])[Wte['lab']]
    klo, khi, nf, nc = kbins(var)
    def kidx(K):
        return np.clip(((np.log10(K) - klo) / (khi - klo) * nf).astype(int), 0, nf - 1)
    heads = [C]; labs = [Wtr['lab']]; masks = [np.ones(len(Wtr['lab']))]
    tun_tr = fl_tr[:, 0] == 1
    hk = hq = hb = None
    if var != 'W0':
        hk = len(heads); heads.append(nf); labs.append(kidx(Wtr['p']['K'])); masks.append(tun_tr.astype(float))
        if not v['qfix']:
            hq = len(heads); heads.append(4)
            labs.append(np.clip(((Wtr['p']['q'] - 0.5) * 4).astype(int), 0, 3)); masks.append(tun_tr.astype(float))
        hb = len(heads); heads.append(16)
        labs.append(np.clip(((np.log10(Wtr['p']['B']) + 16) * 4).astype(int), 0, 15)); masks.append(np.ones(len(tun_tr)))
    # control de holgura: V3_SOLO=M entrena solo la cabeza de mecanismo; V3_SOLO=K solo la de K (las demás quedan sin sentido)
    solo = os.environ.get('V3_SOLO', '')
    if solo == 'M':
        masks = [masks[0]] + [m * 0 for m in masks[1:]]
    elif solo == 'K':
        masks = [m * (1 if h == hk else 0) for h, m in enumerate(masks)]
    lab = Wte['lab']
    allc = list(range(C))
    tun = fl_te[:, 0] == 1
    tclasses = [j for j in allc if flags_of(var, j)[0] == 1]
    # testigos
    wit = {}
    if var == 'W1':
        Wk = sample_world(4000, var, 777, override=dict(t0=1e-5, K=1e7, q=1.0))
        wit['K'] = (Wk, Wk['lab'] == v['mechs'].index('T'))
        Wf = sample_world(4000, var, 778, override=dict(f0=1e-12, lF=0.5))
        wit['F'] = (Wf, Wf['lab'] == v['mechs'].index('F'))
    for calib, reader, des in rows:
        t0 = time.time()
        keys = DESIGNS[des]
        Ftr = features(observe(Wtr, calib, reader, keys), keys, reader)
        Fte = features(observe(Wte, calib, reader, keys), keys, reader)
        Fw = {nm: features(observe(Ww, calib, reader, keys), keys, reader) for nm, (Ww, _) in wit.items()}
        nte_ = len(Fte)
        Fall = np.concatenate([Fte] + list(Fw.values()))
        lq_all = train_eval(Ftr, labs, masks, Fall, heads, H=H, epochs=EP, seed=seed)
        lq = [x[:nte_] for x in lq_all]
        del Ftr
        L2 = np.log(2)
        res = {}
        # mecanismo
        ltM = lq[0][np.arange(nte_), lab] / L2
        IM, seM = strat(ltM, lab, allc); IM += np.log2(C)
        pr = np.exp(lq[0])
        mapc = pr.argmax(1)
        acc = np.mean([np.mean(mapc[lab == j] == j) for j in allc])
        conf = np.array([[np.mean(mapc[lab == j] == i) for i in allc] for j in allc])
        # túnel (W1: T o M; W2: s_T)
        tidx = tclasses
        qt = pr[:, tidx].sum(1)
        pt = len(tidx) / C
        Ht = -(pt * np.log2(pt) + (1 - pt) * np.log2(1 - pt))
        ltT = np.log2(np.clip(np.where(tun, qt, 1 - qt), 1e-300, 1))
        IT, seT = strat(ltT, lab, allc); IT += Ht
        accT = np.mean([np.mean((qt[lab == j] > 0.5) == tun[lab == j]) for j in allc])
        res.update(IM=IM, seM=seM, acc=acc, IT=IT, seT=seT, accT=accT)
        arr = dict(lab=lab, ltM=ltM.astype(np.float32), ltT=ltT.astype(np.float32))
        line = (f"{var} {calib} {reader} {des:<7} I(M)>={IM:.4f}±{seM:.4f} acc={acc:.3f} | I(tun)>={IT:.4f}±{seT:.4f}"
                f" (H={Ht:.3f}) accT={accT:.3f}")
        if not w2 and 'F' in v['mechs']:
            iT, iM, iF = v['mechs'].index('T'), v['mechs'].index('M'), v['mechs'].index('F')
            sub = np.isin(lab, [iT, iM, iF])
            qF = pr[:, iF] / (pr[:, [iT, iM, iF]].sum(1) + 1e-300)
            ltF = np.where(sub, np.log2(np.clip(np.where(lab == iF, qF, 1 - qF), 1e-300, 1)), np.nan)
            IF, seF = strat(ltF, lab, [iT, iM, iF]); HF = -(1/3*np.log2(1/3) + 2/3*np.log2(2/3)); IF += HF
            res.update(IF=IF, seF=seF); arr['ltF'] = ltF.astype(np.float32)
            line += f" | I(F/tunres)>={IF:.4f}±{seF:.4f}"
        if w2:
            for nm, bit in (('sT', 0), ('sR', 1), ('sF', 2)):
                on = [j for j in allc if flags_of(var, j)[bit] == 1]
                qs = pr[:, on].sum(1)
                truth = fl_te[:, bit] == 1
                lts = np.log2(np.clip(np.where(truth, qs, 1 - qs), 1e-300, 1))
                Is, ses = strat(lts, lab, allc); Is += 1.0
                res['I' + nm] = Is; res['se' + nm] = ses; arr['lt' + nm] = lts.astype(np.float32)
                line += f" | I({nm})>={Is:.4f}±{ses:.4f}"
            # F frente a túnel, exclusivos: clases con (s_T, s_F) = (1,0) o (0,1)
            exc = [j for j in allc if flags_of(var, j)[0] + flags_of(var, j)[2] == 1]
            fon = [j for j in exc if flags_of(var, j)[2] == 1]
            sub = np.isin(lab, exc)
            qF = pr[:, fon].sum(1) / (pr[:, exc].sum(1) + 1e-300)
            ltF = np.where(sub, np.log2(np.clip(np.where(np.isin(lab, fon), qF, 1 - qF), 1e-300, 1)), np.nan)
            IF, seF = strat(ltF, lab, exc); IF += 1.0
            res.update(IF=IF, seF=seF); arr['ltF'] = ltF.astype(np.float32)
            line += f" | I(F/tun excl)>={IF:.4f}±{seF:.4f}"
        say(line + f"  ({time.time()-t0:.0f} s)")
        say("   confusión (fila = verdad): " + ' '.join(f"{v['mechs'][j]}->" + '/'.join(f"{x:.2f}" for x in conf[j])
                                                  for j in allc))
        if hk is not None:
            PK = np.exp(lq[hk])
            ki = kidx(Wte['p']['K'])
            PKc = PK.reshape(len(PK), nc, nf // nc).sum(2)
            ltK = np.where(tun, np.log2(np.clip(PKc[np.arange(nte_), ki // (nf // nc)], 1e-300, 1)), np.nan)
            IK, seK = strat(ltK, lab, tclasses); IK += np.log2(nc)
            cls, a, b, ccls, q05, q95 = kclass(PK[tun], klo, khi)
            cov = np.mean((ki[tun] >= a) & (ki[tun] < b))
            ccov = np.mean((np.log10(Wte['p']['K'][tun]) >= q05) & (np.log10(Wte['p']['K'][tun]) <= q95))
            fr = [np.mean(cls == c) for c in range(3)]; cfr = [np.mean(ccls == c) for c in range(3)]
            res.update(IK=IK, seK=seK, fr=fr, cfr=cfr)
            arr['ltK'] = ltK.astype(np.float32)
            kc = np.full(nte_, -1); kc[tun] = cls; arr['Kcls'] = kc.astype(np.int8)
            kc2 = np.full(nte_, -1); kc2[tun] = ccls; arr['Kcls_c'] = kc2.astype(np.int8)
            line = (f"   I(Kbin|tun)>={IK:.4f}±{seK:.4f} (H={np.log2(nc):.0f}, normalizada {IK/np.log2(nc):.4f}) | "
                    f"K estimada/acotada/nada = {fr[0]:.3f}/{fr[1]:.3f}/{fr[2]:.3f} (cobertura {cov:.3f}); "
                    f"central: {cfr[0]:.3f}/{cfr[1]:.3f}/{cfr[2]:.3f} (cob. {ccov:.3f})")
            if hq is not None:
                Pq = lq[hq]
                qi = np.clip(((Wte['p']['q'] - 0.5) * 4).astype(int), 0, 3)
                ltq = np.where(tun, Pq[np.arange(nte_), qi] / L2, np.nan)
                Iq, seq = strat(ltq, lab, tclasses); Iq += 2.0
                res.update(Iq=Iq, seq=seq); arr['ltq'] = ltq.astype(np.float32)
                line += f" | I(qbin|tun)>={Iq:.4f}±{seq:.4f}"
            say(line)
            PB = np.exp(lq[hb])
            cen = -16 + (np.arange(16) + 0.5) * 0.25
            mB = PB @ cen
            sdB = np.sqrt(np.clip(PB @ (cen ** 2) + 0.25 ** 2 / 12 - mB ** 2, 0, None))
            bi = np.clip(((np.log10(Wte['p']['B']) + 16) * 4).astype(int), 0, 15)
            ltB = PB[np.arange(nte_), bi]
            IB, seB = strat(np.log2(np.clip(ltB, 1e-300, 1)), lab, allc); IB += 4.0
            sdm, sdse = strat(sdB, lab, allc)
            arr['sdB'] = sdB.astype(np.float32)
            res.update(sdB=sdm, IB=IB)
            say(f"   log10 B: d.t. posterior media {sdm:.4f}±{sdse:.4f} décadas (prior {4/np.sqrt(12):.4f}); "
                f"I(Bbin16;Y)>={IB:.4f}±{seB:.4f}")
            # testigos
            pos = nte_
            for nm, (Ww, sel) in wit.items():
                n_ = len(Fw[nm]); sl = slice(pos, pos + n_); pos += n_
                if nm == 'K' and des in ('E2', 'E2sin27'):
                    PKw = np.exp(lq_all[hk][sl])[sel]
                    clw, aw, bw, cclw, q05w, q95w = kclass(PKw, klo, khi)
                    i7 = kidx(np.array([1e7]))[0]
                    inside = np.mean((aw <= i7) & (bw > i7))
                    say(f"   TESTIGO K (T, t0=10 µA, K=1e7, q=1; {sel.sum()} chips): estimada/acotada/nada = "
                        f"{np.mean(clw==0):.3f}/{np.mean(clw==1):.3f}/{np.mean(clw==2):.3f}; contiene 1e7: {inside:.3f}; "
                        f"central {np.mean(cclw==0):.3f}/{np.mean(cclw==1):.3f}/{np.mean(cclw==2):.3f}")
                if nm == 'F' and des in ('E6', 'E6c', 'E2', 'E4'):
                    prw = np.exp(lq_all[0][sl])[sel]
                    pF = prw[:, v['mechs'].index('F')]
                    pT = prw[:, [v['mechs'].index('T'), v['mechs'].index('M')]].sum(1)
                    say(f"   TESTIGO F (f0=1e-12, λF=0,5; {sel.sum()} chips): P(F|y) media {pF.mean():.3f}, mediana "
                        f"{np.median(pF):.3f}, fracción con P(F)>0,8: {np.mean(pF>0.8):.3f}; P(túnel) media {pT.mean():.3f}")
        np.savez_compressed(f"ver3_lt_{var}_{calib}_{reader}_{des}_{tag}.npz", **arr)
    say(f"# fin {time.strftime('%Y-%m-%d %H:%M:%S %Z')} ({time.time()-t00:.0f} s)")


if __name__ == '__main__':
    main()
