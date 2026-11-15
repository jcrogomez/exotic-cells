#!/usr/bin/env python3
"""Estimador B: cota inferior variacional de Barber-Agakov con un clasificador (MLP en numpy).

  I(M;Y) >= H(M) + E_{m,y}[log2 q(m|y)]   para cualquier q; la igualdad si q = p(m|y).

- Datos de entrenamiento y de prueba simulados del modelo (ver2_modelo.py), independientes.
- La estimación de la cota se hace en el conjunto de prueba (estratificado: n por mecanismo) => insesgada para la cota;
  ± = 1 error típico (sobre las muestras de prueba).
- Números aleatorios comunes entre diseños (mismo chip, mismo g, mismas eps): las diferencias entre diseños son pareadas.
- I(túnel;Y) >= 1 + E[log2 q_t], con q_t = q(T)+q(M) (válida como q para la variable binaria).
- Acierto: el del argmax de q (cota inferior del acierto de Bayes).

Uso: ver2_clasif.py VAR CALIB LECTOR [ntrain_por_mec] [ntest_por_mec] [H] [epocas] [semilla]
"""
import sys, time, json
import numpy as np
from ver2_modelo import (MKEYS, DESIGNS, DNAMES, VARIANTS, sample_world, observe, thresholds)


def features(obs, keys, reader):
    cols = []
    vals = []
    for k in keys:
        o, y = obs[k]
        lf, lc = thresholds(k, reader)
        v = np.clip(y, lf, lc)
        cols.append((o == 0).astype(np.float32)); cols.append((o == 2).astype(np.float32))
        vals.append(v)
    for i in range(len(keys)):
        cols.append(vals[i])
        for j in range(i + 1, len(keys)):
            cols.append(vals[i] - vals[j])
    return np.stack(cols, axis=1).astype(np.float32)


def silu(x):
    s = 1.0 / (1.0 + np.exp(-x))
    return x * s, s


class MLP:
    def __init__(self, din, H, C, nl=3, seed=0):
        r = np.random.default_rng(seed)
        dims = [din] + [H] * nl + [C]
        self.W = [(r.standard_normal((a, b)) * np.sqrt(2.0 / a)).astype(np.float32) for a, b in zip(dims[:-1], dims[1:])]
        self.b = [np.zeros(b, np.float32) for b in dims[1:]]
        self.m = [np.zeros_like(w) for w in self.W + self.b]
        self.v = [np.zeros_like(w) for w in self.W + self.b]
        self.t = 0

    def forward(self, x, keep=False):
        acts = [x]; pre = []
        h = x
        for i, (W, b) in enumerate(zip(self.W, self.b)):
            z = h @ W + b
            if i < len(self.W) - 1:
                h, s = silu(z)
                pre.append((z, s))
            else:
                h = z
            acts.append(h)
        if keep:
            self._cache = (acts, pre)
        return h

    def logsoftmax(self, x):
        z = self.forward(x)
        z = z - z.max(axis=1, keepdims=True)
        return z - np.log(np.exp(z).sum(axis=1, keepdims=True))

    def step(self, x, yl, lr):
        z = self.forward(x, keep=True)
        acts, pre = self._cache
        z = z - z.max(axis=1, keepdims=True)
        p = np.exp(z); p /= p.sum(axis=1, keepdims=True)
        n = len(x)
        loss = -np.mean(np.log(p[np.arange(n), yl] + 1e-30))
        g = p; g[np.arange(n), yl] -= 1.0; g /= n
        gW = [None] * len(self.W); gb = [None] * len(self.b)
        for i in range(len(self.W) - 1, -1, -1):
            gW[i] = acts[i].T @ g; gb[i] = g.sum(axis=0)
            if i > 0:
                g = g @ self.W[i].T
                zz, s = pre[i - 1]
                g = g * (s * (1.0 + zz * (1.0 - s)))
        self.t += 1
        b1, b2, eps = 0.9, 0.999, 1e-8
        params = self.W + self.b; grads = gW + gb
        for j, (P, G) in enumerate(zip(params, grads)):
            self.m[j] = b1 * self.m[j] + (1 - b1) * G
            self.v[j] = b2 * self.v[j] + (1 - b2) * G * G
            mh = self.m[j] / (1 - b1 ** self.t); vh = self.v[j] / (1 - b2 ** self.t)
            P -= (lr * mh / (np.sqrt(vh) + eps)).astype(np.float32)
        return loss


def gen(var, calib, reader, nper, seed):
    rng = np.random.default_rng(seed)
    mechs = VARIANTS[var]['mechs']
    obs_all = {k: ([], []) for k in MKEYS}
    lab = []
    for j, m in enumerate(mechs):
        X, Z = sample_world(nper, m, var, rng)
        obs = observe(X, Z, calib, reader)
        for k in MKEYS:
            obs_all[k][0].append(obs[k][0]); obs_all[k][1].append(obs[k][1])
        lab.append(np.full(nper, j))
    obs = {k: (np.concatenate(a), np.concatenate(b)) for k, (a, b) in obs_all.items()}
    return obs, np.concatenate(lab)


def train_eval(Ftr, ytr, Fte, yte, C, H, epochs, seed, bs=2048, lr0=2e-3):
    mu = Ftr.mean(0); sd = Ftr.std(0) + 1e-6
    Ftr = (Ftr - mu) / sd; Fte = (Fte - mu) / sd
    net = MLP(Ftr.shape[1], H, C, seed=seed)
    rng = np.random.default_rng(seed + 7)
    n = len(Ftr); steps = epochs * (n // bs); s = 0
    for ep in range(epochs):
        perm = rng.permutation(n)
        for i in range(n // bs):
            lr = lr0 * 0.5 * (1 + np.cos(np.pi * s / steps)) + 1e-5
            idx = perm[i * bs:(i + 1) * bs]
            net.step(Ftr[idx], ytr[idx], lr); s += 1
    out = np.concatenate([net.logsoftmax(Fte[i:i + 65536]) for i in range(0, len(Fte), 65536)])
    return out.astype(np.float64)


def summarize(lq, yte, C, tunnel_idx=None):
    """lq: log q (n,C) natural. Prior uniforme."""
    H = np.log2(C)
    n = len(yte)
    lt = lq[np.arange(n), yte] / np.log(2)
    per = []
    for j in range(C):
        per.append(lt[yte == j])
    I = H + np.mean([p.mean() for p in per])
    se = np.sqrt(sum(p.var(ddof=1) / len(p) for p in per)) / C
    hit = (lq.argmax(1) == yte).astype(float)
    acc = np.mean([hit[yte == j].mean() for j in range(C)])
    conf = np.array([[np.mean(lq[yte == j].argmax(1) == i) for i in range(C)] for j in range(C)])
    res = dict(I=I, se=se, acc=acc, conf=conf.tolist(), per_lt=lt)
    if tunnel_idx is not None:
        q = np.exp(lq)
        qt = q[:, tunnel_idx].sum(1)
        tt = np.isin(yte, tunnel_idx)
        lqt = np.log2(np.where(tt, qt, 1 - qt) + 1e-300)
        perT = [lqt[yte == j] for j in range(C)]
        It = 1.0 + np.mean([p.mean() for p in perT])
        seT = np.sqrt(sum(p.var(ddof=1) / len(p) for p in perT)) / C
        hitT = ((qt > 0.5) == tt).astype(float)
        accT = np.mean([hitT[yte == j].mean() for j in range(C)])
        res.update(It=It, seT=seT, accT=accT)
    return res


def main():
    a = sys.argv
    var, calib, reader = a[1], a[2], a[3]
    ntr = int(a[4]) if len(a) > 4 else 300000
    nte = int(a[5]) if len(a) > 5 else 100000
    H = int(a[6]) if len(a) > 6 else 128
    ep = int(a[7]) if len(a) > 7 else 8
    seed = int(a[8]) if len(a) > 8 else 1
    designs = a[9].split(',') if len(a) > 9 else DNAMES
    t0 = time.time()
    mechs = VARIANTS[var]['mechs']; C = len(mechs)
    tidx = [mechs.index(x) for x in ('T', 'M') if x in mechs] if 'M' in mechs else None
    otr, ytr = gen(var, calib, reader, ntr, 1000 + seed)
    ote, yte = gen(var, calib, reader, nte, 2000)      # prueba: misma semilla en todas las corridas
    print(f"# {var} {calib} {reader} ntrain={ntr}/mec ntest={nte}/mec H={H} epocas={ep} semilla={seed} "
          f"(datos {time.time()-t0:.0f} s)", flush=True)
    res = {}
    for d in designs:
        keys = DESIGNS[d]
        lq = train_eval(features(otr, keys, reader), ytr, features(ote, keys, reader), yte, C, H, ep, seed)
        r = summarize(lq, yte, C, tidx)
        res[d] = r
        extra = f"  I(tunel)>={r['It']:.4f}±{r['seT']:.4f} acierto_tunel={r['accT']:.4f}" if tidx else ""
        conf = ' '.join(f"{mechs[j]}->" + '/'.join(f"{x:.2f}" for x in row) for j, row in enumerate(r['conf']))
        print(f"{var} {calib} {reader} {d:<14} I>={r['I']:.4f}±{r['se']:.4f} acierto={r['acc']:.4f}{extra}  [{conf}]"
              f"  ({time.time()-t0:.0f} s)", flush=True)
    # diferencias pareadas
    pairs = [('D0+-0.9V', 'D0+85C'), ('D0+85C', 'D0'), ('D0+-0.9V', 'D0'), ('D0+peine', 'D0'),
             ('D0+85C+-0.9V', 'D0+-0.9V')]
    for d1, d2 in pairs:
        if d1 in res and d2 in res:
            x = res[d1]['per_lt'] - res[d2]['per_lt']
            per = [x[yte == j] for j in range(C)]
            dd = np.mean([p.mean() for p in per]); se = np.sqrt(sum(p.var(ddof=1) / len(p) for p in per)) / C
            print(f"{var} {calib} {reader} DIF {d1} - {d2} = {dd:+.4f} ± {se:.4f}  (diferencia de cotas)", flush=True)
    np.savez_compressed(f"ver2_lt_{var}_{calib}_{reader}_H{H}_s{seed}.npz", yte=yte,
                        **{d: res[d]['per_lt'].astype(np.float32) for d in res})
    print(f"# tiempo {time.time()-t0:.0f} s", flush=True)


if __name__ == '__main__':
    main()
