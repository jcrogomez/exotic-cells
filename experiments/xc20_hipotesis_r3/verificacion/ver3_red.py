#!/usr/bin/env python3
"""Perceptrón multi-cabeza en numpy (tronco común + varias softmax), Adam con coseno. Extiende la MLP de ver2_clasif.py.

Cada cabeza h tiene sus clases, sus etiquetas y una máscara (muestras que entran en su pérdida). Cualquier q(.|y) es válida
para la cota de Barber-Agakov, así que compartir el tronco solo puede aflojar la cota, nunca hacerla optimista.
"""
import numpy as np


def silu(x):
    s = 1.0 / (1.0 + np.exp(-x))
    return x * s, s


class MLP:
    def __init__(self, din, H, heads, nl=3, seed=0):
        """heads: lista de número de clases por cabeza."""
        r = np.random.default_rng(seed)
        self.heads = heads
        self.off = np.concatenate([[0], np.cumsum(heads)])
        C = int(self.off[-1])
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
        out = []
        for h in range(len(self.heads)):
            zz = z[:, self.off[h]:self.off[h + 1]]
            zz = zz - zz.max(axis=1, keepdims=True)
            out.append(zz - np.log(np.exp(zz).sum(axis=1, keepdims=True)))
        return out

    def step(self, x, labels, masks, lr):
        z = self.forward(x, keep=True)
        acts, pre = self._cache
        n = len(x)
        g = np.zeros_like(z)
        for h in range(len(self.heads)):
            a, b = self.off[h], self.off[h + 1]
            zz = z[:, a:b] - z[:, a:b].max(axis=1, keepdims=True)
            p = np.exp(zz); p /= p.sum(axis=1, keepdims=True)
            p[np.arange(n), labels[h]] -= 1.0
            g[:, a:b] = p * (masks[h][:, None] / n)
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


def train_eval(Ftr, labs, masks, Fte, heads, H=128, epochs=8, seed=1, bs=2048, lr0=2e-3):
    mu = Ftr.mean(0); sd = Ftr.std(0) + 1e-6
    Ftr = (Ftr - mu) / sd; Fte = (Fte - mu) / sd
    net = MLP(Ftr.shape[1], H, heads, seed=seed)
    rng = np.random.default_rng(seed + 7)
    n = len(Ftr); steps = epochs * (n // bs); s = 0
    labs = [l.astype(np.int64) for l in labs]
    masks = [m.astype(np.float32) for m in masks]
    for ep in range(epochs):
        perm = rng.permutation(n)
        for i in range(n // bs):
            lr = lr0 * 0.5 * (1 + np.cos(np.pi * s / steps)) + 1e-5
            idx = perm[i * bs:(i + 1) * bs]
            net.step(Ftr[idx], [l[idx] for l in labs], [m[idx] for m in masks], lr); s += 1
    outs = [[] for _ in heads]
    for i in range(0, len(Fte), 65536):
        for h, o in enumerate(net.logsoftmax(Fte[i:i + 65536])):
            outs[h].append(o)
    return [np.concatenate(o).astype(np.float64) for o in outs]
