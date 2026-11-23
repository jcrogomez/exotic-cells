#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""XC-62 etapa 2: R1 (ancho de poly leído como cociente de resistencias) y R2 (peine con LOD igualado).

Prerregistro: cells/preregistros/XC-62_2026-11-22_etapa2_R1_R2.md + enmienda1 (SHA-256 en PREREG_SHA256.txt).
Modelo de c62_litho.py vía el evaluador exacto de ../xc62_incremental. La OPC (B, C) es un SUPUESTO declarado, no un dato.
Uso: etapa2.py <salida> [--humo]   (--humo: solo C0 y un banco reducido, para probar el código)
"""
import itertools, json, math, sys, time
import numpy as np
sys.path.insert(0, "../xc62_incremental"); sys.path.insert(0, "../../residual")
from xc62inc import Grid, Inc, OutOfROI, cross, calib, observables, SETTINGS, SVG
import lod_annotate as la

OUT = sys.argv[1] if len(sys.argv) > 1 else "."
HUMO = "--humo" in sys.argv
LOG, J = [], {}
def p(s): print(s, flush=True); LOG.append(s)
def now(): return time.strftime("%Y-%m-%d %H:%M:%S %Z")

G = Grid(1024)
TRUNC = 1.2                                     # µm, a2 / E1
HYPS = [("A", s) for s in SETTINGS] + [("B", s) for s in SETTINGS] + [("C", None)]
CLS = np.array([0, 0, 0, 0, 1, 1, 1, 1, 2])
PRIOR = np.array([1 / 12] * 8 + [1 / 3])
S_MM = 17.3                                     # mV, docs/CLAIMS.md
SIG_R = [0.001, 0.003, 0.01, 0.03]

# ---------------- geometría ----------------
def lines(w, s, m, b=0.0, length=3.0, trunc=TRUNC):
    """Línea central de ancho w en x=0 y m vecinas por lado a separación s; sesgo b por borde si hay vecinas (B)."""
    pitch = w + s; out = []
    for k in range(-m, m + 1):
        xc = round(k * pitch, 6)
        if abs(xc) > trunc + 1e-9: continue
        bb = b if m > 0 else 0.0
        out.append((xc - w / 2 - bb, xc + w / 2 + bb, -length / 2, length / 2))
    return out

def comb_env(s, nl, nr, b=0.0, trunc=TRUNC):
    """Dedo leído en x=0 con nl dedos a la izquierda y nr a la derecha (ya truncados), puerta 0,15 sobre W 0,42, ext. 0,13."""
    pitch = 0.15 + s; out = []
    for k in range(-nl, nr + 1):
        xc = round(k * pitch, 6)
        if abs(xc) > trunc + 1e-9: continue
        bb = b if (nl + nr) > 0 else 0.0
        out.append((xc - 0.075 - bb, xc + 0.075 + bb, -0.21 - 0.13, 0.21 + 0.13))
    return out

def mask(rects):
    m = np.zeros((G.N, G.N))
    for r in rects: m += G.rect(*r)
    return np.clip(m, 0, 1)

R1 = [("R1", w, s, m) for w in (0.15, 0.18, 0.25) for s in (0.21, 0.25, 0.30, 0.36, 0.42, 0.55, 0.75, 1.0) for m in (1, 3)]
R2 = [("R2", s, n) for s in (0.21, 0.25, 0.30, 0.36, 0.42) for n in (8, 16, 24, 32)]
CANDS = R1 + R2
EXPERT = [("R1", 0.15, 0.21, 3), ("R1", 0.15, 0.30, 3), ("R1", 0.15, 0.42, 3), ("R1", 0.15, 1.0, 3),
          ("R1", 0.18, 0.21, 3), ("R1", 0.25, 0.21, 3), ("R2", 0.21, 16), ("R2", 0.42, 16)]

def sigma(c, sr):
    if c[0] == "R1": return math.sqrt(2) * sr * math.sqrt(0.15 / c[1])
    return math.sqrt(2) * S_MM / math.sqrt(c[2])

def bin_ok(s, edge): return s <= edge + 1e-9

# ---------------- lecturas ----------------
def width0(I, i0, j0):
    """Ancho impreso en y=0 alrededor de x=0, sobre una ventana que empieza en (i0, j0)."""
    nx, ny = I.shape
    iy = int(np.argmin(np.abs(G.x))) - j0; j = int(np.argmin(np.abs(G.x))) - i0
    if not (0 <= iy < ny and 0 <= j < nx): raise OutOfROI
    c = I[:, iy]; xa = G.x[i0:i0 + nx]; roi = nx < G.N
    if c[j] >= THR: return 0.0
    return cross(c, xa, THR, j, +1, roi) - cross(c, xa, THR, j, -1, roi)

class Eval:
    """Lecturas bajo una iluminación; modo 'inc' (evaluador incremental) o 'fft' (imagen completa)."""
    def __init__(self, setting, P):
        self.setting, self.P = setting, P; self.inc = Inc(G, P); self.fallback = 0
    def I(self, rects, mode):
        if mode == "fft":
            return G.image_cached(mask(rects), self.P), 0, 0
        try:
            E = self.inc.E_of([G.box(*r) for r in rects]); return Inc.I_of(E), self.inc.rx0, self.inc.ry0
        except OutOfROI:
            self.fallback += 1; return G.image_cached(mask(rects), self.P), 0, 0
    def w(self, rects, mode="inc"):
        I, i0, j0 = self.I(rects, mode)
        try: return width0(I, i0, j0)
        except OutOfROI:
            self.fallback += 1; I, i0, j0 = self.I(rects, "fft"); return width0(I, i0, j0)
    def dv(self, rects, mode="inc"):
        I, i0, j0 = self.I(rects, mode)
        try: o = observables(I, THR, dict(), G, i0, j0, roi=(i0 or j0) != 0)
        except OutOfROI:
            self.fallback += 1; I, i0, j0 = self.I(rects, "fft"); o = observables(I, THR, dict(), G)
        return o[5], o[0]

def readings(ev, opc, b, edge, cands, mode="inc"):
    """μ de cada candidato bajo (opc ∈ {A,B}) en la iluminación de ev."""
    mu, wiso, envc = {}, {}, {}
    _, dv_iso_L = None, None
    dv_iso = ev.dv(comb_env(0.21, 0, 0), mode)[0]
    for c in cands:
        if c[0] == "R1":
            _, w, s, m = c
            if w not in wiso: wiso[w] = ev.w(lines(w, s, 0), mode)
            bb = b if (opc == "B" and bin_ok(s, edge)) else 0.0
            mu[c] = wiso[w] / ev.w(lines(w, s, m, bb), mode)
        else:
            _, s, n = c; pitch = 0.15 + s; kmax = int(math.floor(TRUNC / pitch + 1e-9))
            bb = b if (opc == "B" and bin_ok(s, edge)) else 0.0
            vals = []
            for k in range(n):
                nl, nr = min(k, kmax), min(n - 1 - k, kmax)
                key = (s, nl, nr, bb)
                if key not in envc: envc[key] = ev.dv(comb_env(s, nl, nr, bb), mode)[0]
                vals.append(envc[key])
            mu[c] = float(np.mean(vals)) - dv_iso
    return mu

def null(c): return 1.0 if c[0] == "R1" else 0.0

# ---------------- información mutua (posterior exacto) ----------------
def H2(pk):
    pk = np.clip(pk, 1e-300, 1); return -(pk * np.log2(pk)).sum(-1)

def mi_core(mu, sig, prior, cls, z):
    """mu (H, K), sig (K,), z (H, M, K). Devuelve I(clase; y) en bits y su error típico."""
    Hn, K = mu.shape; ncls = cls.max() + 1
    y = mu[:, None, :] + sig[None, None, :] * z                        # (H, M, K)
    ll = np.stack([-0.5 * (((y - mu[h2]) / sig) ** 2).sum(-1) for h2 in range(Hn)], -1) + np.log(prior)  # (H, M, H')
    ll -= ll.max(-1, keepdims=True); post = np.exp(ll); post /= post.sum(-1, keepdims=True)
    pc = np.stack([post[..., cls == c].sum(-1) for c in range(ncls)], -1)
    hp = H2(pc)                                                        # (H, M)
    pcl = np.array([prior[cls == c].sum() for c in range(ncls)])
    I = H2(pcl) - (prior * hp.mean(1)).sum()
    se = math.sqrt(((prior ** 2) * hp.var(1) / hp.shape[1]).sum())
    return float(I), se

def MU(bank, idx): return np.array([[bank[h][CANDS[i]] for i in idx] for h in range(9)])

def mi_set(bank, idx, sr, z):
    idx = list(idx); sig = np.array([sigma(CANDS[i], sr) for i in idx])
    return mi_core(MU(bank, idx), sig, PRIOR, CLS, z[:, :, idx])

def greedy(score, K, n=len(CANDS)):
    S = []
    for _ in range(K):
        best = max((i for i in range(n) if i not in S), key=lambda i: score(S + [i])); S.append(best)
    for _ in range(3):
        improved = False
        for a in range(K):
            cur = score(S)
            for i in range(n):
                if i in S: continue
                T = S.copy(); T[a] = i
                v = score(T)
                if v > cur + 1e-12: S, cur, improved = T, v, True
        if not improved: break
    return sorted(S)

# ---------------- C0: chequeos y testigos ----------------
def lod_check():
    L, Wd, e = 30, 84, 58                                    # en unidades de 5 nm: 0,15 / 0,42 / 0,29
    res = []
    for n, s_um in ((8, 0.21), (16, 0.42)):
        s = int(round(s_um / 0.005)); xs = [e + k * (L + s) for k in range(n)]; xend = xs[-1] + L + e
        comb = {"nfet": [(x, 0, x + L, Wd) for x in xs], "ndiff": [(0, 0, xs[0], Wd)] +
                [(xs[k] + L, 0, xs[k + 1], Wd) for k in range(n - 1)] + [(xs[-1] + L, 0, xend, Wd)]}
        mc = sorted(la.measure(comb, 0.005).values(), key=lambda d: d["x0"])
        worst, worst_mut = 0.0, 0.0
        for k, x in enumerate(xs):
            for short, store in ((0, "ok"), (20, "mut")):
                ref = {"nfet": [(x, 0, x + L, Wd)], "ndiff": [(0, 0, x, Wd), (x + L, 0, xend - short, Wd)]}
                d = list(la.measure(ref, 0.005).values())[0]
                dd = max(abs(d["sa"] - mc[k]["sa"]), abs(d["sb"] - mc[k]["sb"]))
                if store == "ok": worst = max(worst, dd)
                else: worst_mut = max(worst_mut, dd)
        res.append(dict(n=n, s=s_um, max_dsasb_igualada=worst, max_dsasb_mutante=worst_mut))
    return res

def mi_exact_2gauss(d):
    y = np.linspace(-12, 12 + d, 200001); dy = y[1] - y[0]
    f0 = np.exp(-0.5 * y ** 2) / math.sqrt(2 * math.pi); f1 = np.exp(-0.5 * (y - d) ** 2) / math.sqrt(2 * math.pi)
    py = 0.5 * (f0 + f1); q = np.clip(0.5 * f0 / py, 1e-300, 1); r = np.clip(1 - q, 1e-300, 1)
    hpost = -(q * np.log2(q) + r * np.log2(r))
    return 1.0 - float((py * hpost).sum() * dy)

def main():
    global THR
    J["inicio"] = now(); p(f"etapa2 · inicio {J['inicio']} · humo={HUMO}")
    # ---- testigo T-MI y su mutante ----
    rng = np.random.default_rng(7); z = rng.standard_normal((2, 20000, 1))
    Iest, se = mi_core(np.array([[0.0], [2.0]]), np.array([1.0]), np.array([0.5, 0.5]), np.array([0, 1]), z)
    Iex = mi_exact_2gauss(2.0)
    Imut, _ = mi_core(np.array([[0.0], [2.0]]), np.array([1e-3]), np.array([0.5, 0.5]), np.array([0, 1]),
                      z * 1e3)                                 # mutante: datos con ruido, posterior sin ruido
    tmi = abs(Iest - Iex) <= 0.01 and Imut - Iex > 0.05
    p(f"T-MI: estimado {Iest:.4f} ± {se:.4f}, exacto {Iex:.4f}; mutante {Imut:.4f} -> {'PASA' if tmi else 'FALLA'}")
    J["T_MI"] = dict(est=Iest, se=se, exacto=Iex, mutante=Imut, pasa=tmi)
    # ---- LOD (a9 / E7) ----
    lod = lod_check(); lodok = all(r["max_dsasb_igualada"] <= 1e-9 and r["max_dsasb_mutante"] > 1e-3 for r in lod)
    p(f"a9 LOD: {lod} -> {'PASA' if lodok else 'FALLA'}"); J["a9"] = dict(res=lod, pasa=lodok)

    banks = {0.30: [None] * 9, 0.36: [None] * 9}; checks = {}; bias = {}
    cands = CANDS if not HUMO else [c for c in CANDS if (c[0] == "R1" and c[1] == 0.15 and c[3] == 3) or (c[0] == "R2" and c[2] == 8)]
    for si, st in enumerate(SETTINGS):
        THR = calib(G, *st); P = G.pupils(*st); ev = Eval(st, P)
        # a2 (R2 y R1, E1), a3, T-R1 con FFT completa
        a2 = []
        for nm, short, long_ in (("R2 n32 s0.21 centro", comb_env(0.21, 16, 15, trunc=1.2), comb_env(0.21, 16, 15, trunc=2.0)),
                                 ("R1 0.15 s0.42 m3", lines(0.15, 0.42, 3, trunc=1.2), lines(0.15, 0.42, 3, trunc=2.0))):
            if nm.startswith("R2"):
                a, b = ev.dv(short, "fft")[1][21], ev.dv(long_, "fft")[1][21]
            else:
                a, b = ev.w(short, "fft"), ev.w(long_, "fft")
            a2.append((nm, abs(a - b) * 1e3))
        a3 = [(nm, abs(ev.w(lines(0.15, 0.21, m, length=3.0), "fft") - ev.w(lines(0.15, 0.21, m, length=4.5), "fft")) * 1e3)
              for nm, m in (("densa m3", 3), ("aislada", 0))]
        tr1 = ev.w(lines(0.15, 0.21, 0), "fft") / ev.w(lines(0.16, 0.21, 0), "fft")
        # P1': geometría exacta de nb2_021_longcap (m=1, largo 3,42)
        p1p = ev.w(lines(0.15, 0.21, 0, length=3.42), "fft") / ev.w(lines(0.15, 0.21, 1, length=3.42), "fft")
        # calibración de B (E5): FFT completa
        best = None
        for bi in range(13):
            b = bi * 0.005; wv = ev.w(lines(0.15, 0.21, 3, b), "fft")
            if best is None or abs(wv - 0.150) < best[1] - 1e-12: best = (b, abs(wv - 0.150), wv)
        bias[st] = best
        checks[st] = dict(thr=THR, a2_nm=a2, a3_nm=a3, TR1_A=tr1, P1prima=p1p, sesgo_B=best)
        p(f"NA {st[0]} σ {st[1]}: umbral {THR:.3f}; a2 {[(n, round(v, 4)) for n, v in a2]} nm; a3 {[(n, round(v, 4)) for n, v in a3]} nm; "
          f"T-R1 bajo A {tr1:.4f}; P1' {p1p:.3f}; sesgo B {best[0]*1e3:.0f} nm/borde -> w {best[2]:.4f}")
        # C1 / C2: lecturas (A una vez; B con los dos bordes)
        t = time.perf_counter()
        muA = readings(ev, "A", 0.0, 0.30, cands)
        for edge in (0.30, 0.36):
            banks[edge][si] = muA
            banks[edge][4 + si] = readings(ev, "B", best[0], edge, cands)
        checks[st]["t_lecturas_s"] = time.perf_counter() - t; checks[st]["fallback"] = ev.fallback
        # C5 (a1): equivalencia en una muestra; el conjunto elegido se audita al final
        checks[st]["_ev"] = None
        p(f"   lecturas {checks[st]['t_lecturas_s']:.1f} s, recurrencias a FFT {ev.fallback}")
        del ev
    for edge in banks: banks[edge][8] = {c: null(c) for c in cands}
    a2ok = all(v <= 0.1 for st in SETTINGS for _, v in checks[st]["a2_nm"])
    a3ok = all(v <= 0.1 for st in SETTINGS for _, v in checks[st]["a3_nm"])
    tr1ok = all(abs(checks[st]["TR1_A"] - 0.9375) > 1e-4 for st in SETTINGS)
    p1pok = all(abs(checks[st]["P1prima"] - v) <= 0.001 for st, v in zip(SETTINGS, (1.685, 1.027, 1.376, 1.056)))
    p1 = [banks[0.30][si][("R1", 0.15, 0.21, 3)] for si in range(4)] if ("R1", 0.15, 0.21, 3) in cands else []
    p1ok = bool(p1) and all(abs(a - v) <= 0.001 for a, v in zip(p1, (1.685, 1.027, 1.376, 1.056)))
    nfb = sum(checks[st]["fallback"] for st in SETTINGS)
    p(f"a2 {'PASA' if a2ok else 'FALLA'} · a3 {'PASA' if a3ok else 'FALLA'} · T-R1 {'PASA' if tr1ok else 'FALLA'} · "
      f"P1' {'cumplida' if p1pok else 'FALLADA'} · P1 {[round(v, 3) for v in p1]} {'cumplida' if p1ok else 'FALLADA'} · recurrencias {nfb}")
    J["C0"] = dict(a2=a2ok, a3=a3ok, TR1=tr1ok, P1prima=p1pok, P1=p1ok, P1_valores=p1, recurrencias=nfb,
                   por_ajuste={str(k): {kk: vv for kk, vv in v.items() if kk != "_ev"} for k, v in checks.items()})
    globals()["CANDS"] = cands
    if HUMO:
        p("humo: fin tras C0/C1"); return finish()
    if not (tmi and a2ok and a3ok and lodok):
        p("Benchmark INVÁLIDO por un chequeo de validez: me detengo."); return finish()
    a4 = nfb / (len(cands) * 8 * 2); p(f"a4 recurrencias / evaluaciones de candidato ≈ {a4:.3f}")

    # ---- P2 ----
    p2 = {edge: max(abs(banks[edge][4 + si][c] - 1) for si in range(4) for c in cands if c[0] == "R1") for edge in banks}
    arg = {edge: max(((si, c) for si in range(4) for c in cands if c[0] == "R1"), key=lambda t: abs(banks[edge][4 + t[0]][t[1]] - 1)) for edge in banks}
    p(f"P2 máx |r−1| bajo B: {{0.30: {p2[0.30]*100:.2f} %, 0.36: {p2[0.36]*100:.2f} %}} en {arg}")
    J["P2"] = dict(max=p2, donde={str(k): str(v) for k, v in arg.items()})
    # kill R1 / R2
    killR1 = all(abs(banks[0.30][4 + si][c] - 1) < sigma(c, 0.003) for si in range(4) for c in cands if c[0] == "R1")
    killR2 = all(abs(banks[0.30][4 + si][c]) < 4.33 for si in range(4) for c in cands if c[0] == "R2" and c[2] == 32)
    p(f"muerte R1 (σ_R 0,3 %): {killR1} · muerte R2 (n=32, 4,33 mV): {killR2}"); J["muerte"] = dict(R1=killR1, R2=killR2)

    # ---- C3 / C4 ----
    N = len(cands); z1 = np.random.default_rng(1).standard_normal((9, 4000, N)); z2 = np.random.default_rng(2).standard_normal((9, 20000, N))
    rs = np.random.default_rng(3); RAND = {K: [sorted(rs.choice(N, K, replace=False).tolist()) for _ in range(1000)] for K in (4, 8)}
    iexp = [cands.index(c) for c in EXPERT]
    res = {}
    for edge in (0.30, 0.36):
        bank = banks[edge]
        for sr in SIG_R:
            for K in (4, 8):
                t = time.perf_counter()
                opt = greedy(lambda S: mi_set(bank, S, sr, z1)[0], K)
                Iopt = mi_set(bank, opt, sr, z2)
                snr = [max(abs(bank[h][c] - bank[8][c]) for h in range(8)) / sigma(c, sr) for c in cands]
                topk = sorted(np.argsort(snr)[::-1][:K].tolist()); Itop = mi_set(bank, topk, sr, z2)
                Iexp = mi_set(bank, iexp, sr, z2) if K == 8 else (float("nan"), 0)
                if edge == 0.30:
                    rnd = np.array([mi_set(bank, S, sr, z2)[0] for S in RAND[K]]); p95 = float(np.percentile(rnd, 95))
                else: rnd, p95 = None, float("nan")
                r = dict(opt=[str(cands[i]) for i in opt], I_opt=Iopt, I_topk=Itop, topk=[str(cands[i]) for i in topk],
                         I_exp=Iexp, p95_azar=p95, med_azar=float(np.median(rnd)) if rnd is not None else float("nan"),
                         nR1_opt=sum(cands[i][0] == "R1" for i in opt), t_s=time.perf_counter() - t, _opt=opt)
                res[(edge, sr, K)] = r
                p(f"borde {edge} σ_R {sr*100:g} % K={K}: opt {Iopt[0]:.3f}±{Iopt[1]:.3f} · experto {Iexp[0]:.3f} · top-señal {Itop[0]:.3f} · "
                  f"azar p95 {p95:.3f} (mediana {r['med_azar']:.3f}) · R1 en opt {r['nR1_opt']}/{K} · {r['t_s']:.0f} s")
                p(f"   opt: {r['opt']}")
    # H1 / P3 / P4 / P5 / P6
    h1 = {sr: res[(0.30, sr, 8)]["I_opt"][0] > res[(0.30, sr, 8)]["p95_azar"] + 0.10 and res[(0.30, sr, 8)]["I_opt"][0] >= res[(0.30, sr, 8)]["I_exp"][0] + 0.10 for sr in SIG_R}
    h1_azar = {sr: res[(0.30, sr, 8)]["I_opt"][0] > res[(0.30, sr, 8)]["p95_azar"] for sr in SIG_R}
    p(f"H1 (≥ p95 azar + 0,10 y ≥ experto + 0,10, K=8, borde 0,30): {h1}; supera p95 del azar: {h1_azar}")
    a5 = {sr: len(set(res[(0.30, sr, 8)]["_opt"]) ^ set(res[(0.36, sr, 8)]["_opt"])) // 2 for sr in SIG_R}
    p(f"a5 variantes que cambian entre bordes 0,30 y 0,36 (K=8): {a5}")
    # P5: A frente a {B,C}
    def mi_AvsBC(idx, sr):
        cls = np.array([0, 0, 0, 0, 1, 1, 1, 1, 1]); prior = np.array([1 / 12] * 8 + [1 / 3])
        sig = np.array([sigma(cands[i], sr) for i in idx])
        return mi_core(MU(banks[0.30], idx), sig, prior, cls, z2[:, :, idx])
    p5 = {sr: mi_AvsBC(res[(0.30, sr, 8)]["_opt"], sr)[0] for sr in SIG_R}
    hAvsBC = -(1 / 3 * math.log2(1 / 3) + 2 / 3 * math.log2(2 / 3))
    p(f"P5 I(A frente a B∪C) del conjunto optimizado: {p5} (techo {hAvsBC:.3f})")
    # mutantes de selección
    planted = None
    # candidato plantado: separa B de C por 10σ
    bankP = [dict(b) for b in banks[0.30]]; cP = ("PLANT",)
    for h in range(9): bankP[h][cP] = 10.0 if 4 <= h <= 7 else 0.0
    globals()["CANDS"] = cands + [cP]
    zP = np.concatenate([z1, np.random.default_rng(11).standard_normal((9, 4000, 1))], -1)
    sigma_orig = globals()["sigma"]
    globals()["sigma"] = lambda c, sr: 1.0 if c[0] == "PLANT" else sigma_orig(c, sr)
    plant_ok = {sr: (N in greedy(lambda S: mi_set(bankP, S, sr, zP)[0], 4, N + 1)) for sr in SIG_R}
    globals()["sigma"] = sigma_orig; globals()["CANDS"] = cands
    p(f"plantado elegido en K=4: {plant_ok}")
    rr = np.random.default_rng(5); over = 0; sr0 = 0.003; p95 = res[(0.30, sr0, 8)]["p95_azar"]
    for _ in range(20):
        sc = rr.random(N); S = sorted(np.argsort(sc)[::-1][:8].tolist())   # voraz con puntaje al azar = los 8 de mayor puntaje
        over += mi_set(banks[0.30], S, sr0, z2)[0] > p95
    p(f"mutante objetivo al azar (σ_R 0,3 %): {over}/20 sobre p95 -> {'PASA' if over <= 3 else 'FALLA'}")
    r1idx = [i for i, c in enumerate(cands) if c[0] == "R1"][:8]
    bankM = [{c: (1.0 if c[0] == "R1" else b[c]) for c in cands} for b in banks[0.30]]   # vecinas borradas: r = 1 en todo
    Imut = mi_set(bankM, r1idx, 0.003, z2)
    p(f"mutante R1 sin vecinas: I = {Imut[0]:.4f} ± {Imut[1]:.4f} (debe ser ~0)")
    J.update(H1=h1, H1_azar=h1_azar, a5=a5, P5=p5, plantado=plant_ok, mutante_azar=over, mutante_R1=Imut,
             C34={f"{k[0]}|{k[1]}|{k[2]}": {kk: vv for kk, vv in v.items() if kk != "_opt"} for k, v in res.items()})

    # ---- C5 (a1): FFT completa sobre optimizados (borde 0,30, K=8), experto y 20 al azar ----
    aud = set(iexp)
    for sr in SIG_R: aud |= set(res[(0.30, sr, 8)]["_opt"])
    aud |= set(np.random.default_rng(9).choice(N, 20, replace=False).tolist())
    audc = [cands[i] for i in sorted(aud)]; worst = {"R1": 0.0, "R2": 0.0}
    for si, st in enumerate(SETTINGS):
        THR = checks[st]["thr"]; P = G.pupils(*st); ev = Eval(st, P); b = bias[st][0]
        for opc, off in (("A", 0), ("B", 4)):
            mf = readings(ev, opc, b, 0.30, audc, mode="fft")
            for c in audc: worst[c[0]] = max(worst[c[0]], abs(mf[c] - banks[0.30][off + si][c]))
        del ev
    a1ok = worst["R1"] <= 1e-8 and worst["R2"] <= 1e-6
    p(f"a1 auditoría FFT completa sobre {len(audc)} candidatos × 8 hipótesis: máx Δr {worst['R1']:.2e}, máx ΔVeq {worst['R2']:.2e} mV -> {'PASA' if a1ok else 'FALLA'}")
    J["a1"] = dict(n=len(audc), max_dr=worst["R1"], max_dV_mV=worst["R2"], pasa=a1ok)
    json.dump({str(e): [{str(c): v for c, v in b.items()} for b in banks[e]] for e in banks}, open(f"{OUT}/banco.json", "w"), indent=0)
    finish()

def finish():
    J["fin"] = now(); p(f"fin {J['fin']}")
    open(f"{OUT}/resultados{'_humo' if HUMO else ''}.txt", "w").write("\n".join(LOG) + "\n")
    json.dump(J, open(f"{OUT}/resultados{'_humo' if HUMO else ''}.json", "w"), indent=1, default=str)

if __name__ == "__main__":
    main()
