#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""xc62_incremental: evaluador incremental EXACTO del modelo de ../attack_xc60_62_63/c62_litho.py (ver PREREG.md).

Mismo modelo: Abbe, máscara binaria, 29 puntos de fuente, umbral constante. Óptica supuesta, sin resina, sin grabado, SIN OPC.
Idea: E_s = IFFT[P_s FFT(1-M)] es lineal en M y la FFT es circular. Una forma rectangular fija tiene una respuesta precalculada
por punto de fuente; colocarla en otra posición es desplazar esa respuesta. Solo se calcula el campo en una ventana (ROI)
alrededor de la puerta, que es lo único que leen los observables. Si un cruce de umbral cae fuera de la ROI se marca y se usa la
FFT completa. Esto reproduce el modelo; no añade nada sobre el silicio.
"""
import itertools, json, resource, sys, time
import numpy as np

LAM, W, LG = 0.248, 0.42, 0.15
SLN, SLP, SVG = 0.0382, 0.0529, 27.45          # copiados de c62_litho.py (c62_dvth.txt)
SETTINGS = [(0.60, 0.5), (0.60, 0.8), (0.70, 0.5), (0.70, 0.8)]


class OutOfROI(Exception):
    pass


class Grid:
    def __init__(self, N=1024, dx=0.005):
        self.N, self.dx = N, dx
        self.x = (np.arange(N) - N // 2 + 0.5) * dx
        self.X, self.Y = np.meshgrid(self.x, self.x, indexing="ij")
        f = np.fft.fftfreq(N, dx)
        self.FX, self.FY = np.meshgrid(f, f, indexing="ij")

    def image(self, chrome, na, sigma, ns=7):
        """Literal de c62_litho.image (pupila recalculada en cada llamada)."""
        T = np.fft.fft2(1.0 - chrome); s = np.linspace(-1, 1, ns); I = np.zeros((self.N, self.N)); n = 0
        for a, b in itertools.product(s, s):
            if a * a + b * b > 1.0001: continue
            fx, fy = a * sigma * na / LAM, b * sigma * na / LAM
            P = ((self.FX + fx) ** 2 + (self.FY + fy) ** 2) <= (na / LAM) ** 2
            I += np.abs(np.fft.ifft2(T * P)) ** 2; n += 1
        return I / n

    def pupils(self, na, sigma, ns=7):
        s = np.linspace(-1, 1, ns); out = []
        for a, b in itertools.product(s, s):
            if a * a + b * b > 1.0001: continue
            fx, fy = a * sigma * na / LAM, b * sigma * na / LAM
            out.append(((self.FX + fx) ** 2 + (self.FY + fy) ** 2) <= (na / LAM) ** 2)
        return out

    def image_cached(self, chrome, P):
        """Misma cuenta que image(), con las pupilas ya construidas (línea base justa para los tiempos)."""
        T = np.fft.fft2(1.0 - chrome); I = np.zeros((self.N, self.N))
        for p in P: I += np.abs(np.fft.ifft2(T * p)) ** 2
        return I / len(P)

    def rect(self, x0, x1, y0, y1):
        return ((self.X >= x0) & (self.X < x1) & (self.Y >= y0) & (self.Y < y1)).astype(float)

    def box(self, x0, x1, y0, y1):
        """Caja de índices semiabierta (i0, i1, j0, j1) con exactamente los píxeles de rect()."""
        ix = np.nonzero((self.x >= x0) & (self.x < x1))[0]; iy = np.nonzero((self.x >= y0) & (self.x < y1))[0]
        assert len(ix) and len(iy), (x0, x1, y0, y1)
        return (int(ix[0]), int(ix[-1]) + 1, int(iy[0]), int(iy[-1]) + 1)


# ---- geometría: la misma de c62_litho.gate(), como lista de rectángulos ----
def gate_rects(xs=(0.0,), top=0.13, bot=0.13, field=(), bar=None, bx=(0, 0)):
    r = [(xc - LG / 2, xc + LG / 2, -W / 2 - bot, W / 2 + top) for xc in list(xs) + list(field)]
    if bar is not None: r.append((bx[0], bx[1], W / 2 + bar, W / 2 + bar + 0.15))
    return r


def mask_of(g, rects):
    m = np.zeros((g.N, g.N))
    for r in rects: m += g.rect(*r)
    return np.clip(m, 0, 1)


CASES = [
    ("iso_longcap (referencia)", dict(top=1.5, bot=1.5)),
    ("iso_cap013", dict()),
    ("iso_cap013_top_only", dict(bot=1.5)),
    ("nb1_021", dict(xs=(0.0, 0.36))), ("nb2_021", dict(xs=(-0.36, 0.0, 0.36))),
    ("nb2_021_longcap", dict(xs=(-0.36, 0.0, 0.36), top=1.5, bot=1.5)),
    ("nb2_042", dict(xs=(-0.57, 0.0, 0.57))), ("nb2_100", dict(xs=(-1.15, 0.0, 1.15))),
    ("field2_0325", dict(field=(-0.475, 0.475))),
    ("elbow_0075", dict(top=0.075, bar=0.075, bx=(-0.075, 0.8))), ("elbow_013", dict(top=0.13, bar=0.13, bx=(-0.075, 0.8))),
    ("T_0075", dict(top=0.075, bar=0.075, bx=(-0.8, 0.8))),
    ("U_0075", dict(xs=(0.0, 0.36), top=0.075, bar=0.075, bx=(-0.075, 0.435))),
    ("U_013", dict(xs=(0.0, 0.36), top=0.13, bar=0.13, bx=(-0.075, 0.435))),
]
YS = np.linspace(-W / 2, W / 2, 43)


# ---- observables: los de c62_litho.py, sobre una ventana (xa, ya) de la rejilla; en la rejilla completa son idénticos ----
def cross(c, coord, thr, j, step, roi):
    a = j; n = len(c)
    while 0 < a < n - 1 and c[a] < thr: a += step
    if roi and c[a] < thr: raise OutOfROI
    b = a - step
    return coord[b] + (thr - c[b]) / (c[a] - c[b]) * (coord[a] - coord[b])


def observables(I, thr, kw, g, i0=0, j0=0, roi=False):
    """I es la intensidad en la ventana que empieza en el índice global (i0, j0). Devuelve la fila de c62_litho."""
    nx, ny = I.shape; xa = g.x[i0:i0 + nx]; ya = g.x[j0:j0 + ny]
    def gidx(v):                              # argmin global, igual que c62 (np.argmin(np.abs(x - v)))
        k = int(np.argmin(np.abs(g.x - v)))
        return k
    def width_x(yq, x0=0.0):
        iy = gidx(yq) - j0; j = gidx(x0) - i0
        if roi and not (0 <= iy < ny and 0 <= j < nx): raise OutOfROI
        c = I[:, iy]
        if c[j] >= thr: return 0.0
        return cross(c, xa, thr, j, +1, roi) - cross(c, xa, thr, j, -1, roi)
    def tip_y(x0=0.0, sgn=+1):
        ix = gidx(x0) - i0; j = g.N // 2 - j0
        if roi and not (0 <= ix < nx and 0 <= j < ny): raise OutOfROI
        return cross(I[ix, :], ya, thr, j, sgn, roi)
    Ly = np.array([width_x(y) for y in YS])
    cp = tip_y(sgn=+1) - W / 2 if kw.get("bar") is None and kw.get("top", 0.13) < 1 else float("nan")
    cm = -W / 2 - tip_y(sgn=-1) if kw.get("bot", 0.13) < 1 else float("nan")
    if (Ly <= 0).any(): rn = rp = dv = float("inf")
    else:
        dL = (Ly - LG) * 1e3; rn = np.mean(np.exp(-SLN * dL)); rp = np.mean(np.exp(-SLP * dL)); dv = np.log(rn) / SVG * 1e3
    return Ly, cp, cm, rn, rp, dv


def row(name, o):
    Ly, cp, cm, rn, rp, dv = o
    return f"  {name:26s} {Ly[21]:6.3f} {Ly[-1]:7.3f} {Ly[0]:7.3f} {Ly.min():6.3f} {Ly.max():6.3f} {cp:7.3f} {cm:7.3f} {rn:7.3f} {rp:7.3f} {dv:+7.1f}"


def calib(g, na, sg):
    """Umbral de c62: bisección sobre línea aislada larga, imagen completa."""
    Iref = g.image(g.rect(-LG / 2, LG / 2, -2.4, 2.4), na, sg); lo, hi = 0.0, 1.0
    for _ in range(40):
        thr = (lo + hi) / 2
        if observables_width0(Iref, thr, g) > LG: hi = thr
        else: lo = thr
    return thr


def observables_width0(I, thr, g):
    iy = int(np.argmin(np.abs(g.x - 0.0))); c = I[:, iy]; j = int(np.argmin(np.abs(g.x - 0.0)))
    if c[j] >= thr: return 0.0
    return cross(c, g.x, thr, j, +1, False) - cross(c, g.x, thr, j, -1, False)


# ---- evaluador incremental ----
class Inc:
    def __init__(self, g, P, roi=(-0.4, 0.4, -0.7, 0.7), org=(-1.3, 1.3, -1.8, 0.6)):
        self.g, self.P = g, P
        self.rx0, self.rx1, self.ry0, self.ry1 = g.box(*roi)
        self.ox0, self.ox1, self.oy0, self.oy1 = g.box(*org)      # orígenes de caja admitidos
        self.oi_min, self.oi_max = self.rx0 - (self.ox1 - 1), self.rx1 - 1 - self.ox0
        self.oj_min, self.oj_max = self.ry0 - (self.oy1 - 1), self.ry1 - 1 - self.oy0
        self.cache, self.t_pre = {}, []

    @property
    def shape(self): return (len(self.P), self.rx1 - self.rx0, self.ry1 - self.ry0)

    def resp(self, w, h):
        key = (w, h)
        if key not in self.cache:
            t = time.perf_counter(); N = self.g.N
            m = np.zeros((N, N)); m[:w, :h] = 1.0; F = np.fft.fft2(m)
            oi = np.arange(self.oi_min, self.oi_max + 1) % N; oj = np.arange(self.oj_min, self.oj_max + 1) % N
            R = np.empty((len(self.P), len(oi), len(oj)), complex)
            for k, p in enumerate(self.P): R[k] = np.fft.ifft2(F * p)[np.ix_(oi, oj)]
            self.cache[key] = R; self.t_pre.append(time.perf_counter() - t)
        return self.cache[key]

    def field(self, b):
        i0, i1, j0, j1 = b
        if not (self.ox0 <= i0 < self.ox1 and self.oy0 <= j0 < self.oy1): raise OutOfROI
        R = self.resp(i1 - i0, j1 - j0); _, nx, ny = self.shape
        a = self.rx0 - i0 - self.oi_min; c = self.ry0 - j0 - self.oj_min
        return R[:, a:a + nx, c:c + ny]

    @staticmethod
    def disjoint(boxes):
        for p, q in itertools.combinations(boxes, 2):
            if p[0] < q[1] and q[0] < p[1] and p[2] < q[3] and q[2] < p[3]: return False
        return True

    def E_of(self, boxes):
        if not self.disjoint(boxes): raise OutOfROI     # solapamiento: no se suman formas (c62 hace clip)
        E = np.ones(self.shape, complex)
        for b in boxes: E -= self.field(b)
        return E

    @staticmethod
    def I_of(E): return (np.abs(E) ** 2).sum(0) / E.shape[0]

    def obs(self, E, thr, kw):
        return observables(self.I_of(E), thr, kw, self.g, self.rx0, self.ry0, roi=True)


def odiff(a, b):
    """máx. diferencia de L (µm) y de dVeq (mV) entre dos filas de observables (nan e inf deben coincidir)."""
    La, Lb = a[0], b[0]; dL = float(np.max(np.abs(La - Lb)))
    sc = [(x, y) for x, y in zip(a[1:], b[1:])]
    for x, y in sc:
        if np.isnan(x) != np.isnan(y) or np.isinf(x) != np.isinf(y): return float("inf"), float("inf")
    dvx, dvy = a[5], b[5]
    dV = 0.0 if (np.isinf(dvx) and np.isinf(dvy)) else abs(dvx - dvy)
    dtip = max([abs(x - y) for x, y in zip(a[1:3], b[1:3]) if not np.isnan(x)] or [0.0])
    return max(dL, dtip), dV


def rss_gb(): return resource.getrusage(resource.RUSAGE_SELF).ru_maxrss / 2**30   # macOS: bytes


def main(outdir):
    T0 = time.strftime("%Y-%m-%d %H:%M:%S %Z"); log = [f"xc62_incremental · inicio {T0}"]; J = {"inicio": T0}
    def p(s): print(s, flush=True); log.append(s)
    g = Grid(1024); rng = np.random.default_rng(20261122)

    # ---- T1: mi copia reproduce c62_litho.txt ----
    ref = open("../attack_xc60_62_63/c62_litho.txt").read().splitlines()
    mine, full_obs, thrs = [], {}, {}
    for na, sg in SETTINGS:
        thr = calib(g, na, sg); thrs[(na, sg)] = thr
        mine.append(f"NA {na:.2f} sigma {sg:.1f} umbral {thr:.3f}")
        for name, kw in CASES:
            I = g.image(mask_of(g, gate_rects(**kw)), na, sg)
            o = observables(I, thr, kw, g); full_obs[(na, sg, name)] = o; mine.append(row(name, o))
    refrows = [l.strip() for l in ref if l.startswith("  ") and not l.strip().startswith("caso") and "L(0) " not in l]
    refrows = [l for l in refrows if l.split()[0] in {c[0].split()[0] for c in CASES}][:len(CASES) * 4]
    myrows = [l.strip() for l in mine if l.startswith("  ")]
    refthr = [l.strip() for l in ref if l.startswith("NA ")]; mythr = [l for l in mine if l.startswith("NA ")]
    t1 = [i for i, (a, b) in enumerate(zip(myrows, refrows)) if a != b]
    t1ok = len(myrows) == len(refrows) == 56 and not t1 and refthr == mythr
    p(f"T1 filas comparadas {len(myrows)}/{len(refrows)}, diferencias {len(t1)}, umbrales iguales {refthr == mythr} -> {'PASA' if t1ok else 'FALLA'}")
    for i in t1[:5]: p(f"   mía: {myrows[i]}\n   c62: {refrows[i]}")
    J["T1"] = dict(pasa=t1ok, filas=len(myrows), diferencias=len(t1))
    if not t1ok:
        p("Criterio de muerte T1: me detengo."); open(f"{outdir}/resultados.txt", "w").write("\n".join(log) + "\n"); return

    # pupila en caché = misma cuenta que image()
    na, sg = SETTINGS[0]; P = g.pupils(na, sg); M = mask_of(g, gate_rects())
    J["image_cached_igual_bit_a_bit"] = bool(np.array_equal(g.image(M, na, sg), g.image_cached(M, P)))
    p(f"image_cached idéntica bit a bit a image(): {J['image_cached_igual_bit_a_bit']}")

    t3a, t2r, t3b, fallback = [], [], [], 0
    for na, sg in SETTINGS:
        P = g.pupils(na, sg); inc = Inc(g, P); thr = thrs[(na, sg)]
        # ---- T3a: los 14 casos por formas ----
        for name, kw in CASES:
            boxes = [g.box(*r) for r in gate_rects(**kw)]
            assert np.array_equal(sum(g.rect(*r) for r in gate_rects(**kw)).clip(0, 1), mask_of(g, gate_rects(**kw)))
            try: o = inc.obs(inc.E_of(boxes), thr, kw)
            except OutOfROI: fallback += 1; p(f"   T3a fuera de ROI: {name}"); continue
            dL, dV = odiff(o, full_obs[(na, sg, name)]); t3a.append((na, sg, name, dL, dV))
        # ---- T2: 300 cambios de píxel (solo el primer ajuste y el último, para acotar tiempo) ----
        if (na, sg) in (SETTINGS[0], SETTINGS[-1]):
            M = mask_of(g, gate_rects()); E = inc.E_of([g.box(*r) for r in gate_rects()])
            ii = rng.integers(*g.box(-0.6, 0.6, -0.6, 0.6)[:2], 300); jj = rng.integers(*g.box(-0.6, 0.6, -0.6, 0.6)[2:], 300)
            for i, j in zip(ii, jj):
                d = 1.0 - 2.0 * M[i, j]; M[i, j] += d; E -= d * inc.field((int(i), int(i) + 1, int(j), int(j) + 1))
            Ifull = g.image_cached(M, P)[inc.rx0:inc.rx1, inc.ry0:inc.ry1]
            t2r.append((na, sg, float(np.max(np.abs(inc.I_of(E) - Ifull)))))
        # ---- T3b: 60 geometrías al azar, encadenadas ----
        cur, E = [], np.ones(inc.shape, complex)
        for k in range(15):
            top = float(rng.choice([0.075, 0.13])); xs = [0.0]
            for side in (-1, 1):
                for _ in range(int(rng.integers(0, 3))):
                    last = max(xs) if side > 0 else min(xs)
                    xs.append(round(last + side * (0.20 + 0.005 * int(rng.integers(0, 181))), 3))
            xs = [v for v in xs if -1.2 <= v <= 1.2]
            kw = dict(xs=tuple(sorted(xs)), top=top)
            if rng.random() < 0.5: kw.update(bar=top, bx=(-0.075, round(-0.075 + float(rng.choice([0.51, 0.875, 1.6])), 3)))
            new = [g.box(*r) for r in gate_rects(**kw)]
            try:
                for b in set(cur) - set(new): E += inc.field(b)
                for b in set(new) - set(cur): E -= inc.field(b)
                cur = new
                if not inc.disjoint(cur): raise OutOfROI
                o = inc.obs(E, thr, kw)
            except OutOfROI:
                fallback += 1; cur, E = [], np.ones(inc.shape, complex); continue
            Ifull = g.image_cached(mask_of(g, gate_rects(**kw)), P)
            of = observables(Ifull, thr, kw, g)
            dI = float(np.max(np.abs(inc.I_of(E) - Ifull[inc.rx0:inc.rx1, inc.ry0:inc.ry1])))
            dL, dV = odiff(o, of); t3b.append((na, sg, k, dI, dL, dV, kw))
        p(f"ajuste NA {na} σ {sg}: formas en caché {len(inc.cache)}, {sum(r.nbytes for r in inc.cache.values())/2**30:.2f} GB, "
          f"precálculo medio {np.mean(inc.t_pre):.2f} s/forma, RSS pico {rss_gb():.2f} GB")
        J.setdefault("memoria", []).append(dict(na=na, sigma=sg, formas=len(inc.cache),
                                                 gb=sum(r.nbytes for r in inc.cache.values()) / 2**30, pre_s=float(np.mean(inc.t_pre))))
        del inc
    mL = max(r[3] for r in t3a); mV = max(r[4] for r in t3a)
    p(f"T3a {len(t3a)} filas: máx dL {mL:.2e} µm, máx dVeq {mV:.2e} mV -> {'PASA' if mL <= 1e-9 and mV <= 1e-6 and len(t3a) == 56 else 'FALLA'}")
    m2 = max(r[2] for r in t2r)
    p(f"T2 300 píxeles en {len(t2r)} ajustes: máx |ΔI| {m2:.2e} -> {'PASA' if m2 <= 1e-10 else 'FALLA'}")
    if t3b:
        bI = max(r[3] for r in t3b); bL = max(r[4] for r in t3b); bV = max(r[5] for r in t3b)
        p(f"T3b {len(t3b)} geometrías encadenadas: máx |ΔI| {bI:.2e}, dL {bL:.2e} µm, dVeq {bV:.2e} mV -> "
          f"{'PASA' if bL <= 1e-9 and bV <= 1e-6 else 'FALLA'}")
    p(f"recurrencias a FFT completa (fuera de ROI o solape): {fallback}")
    J.update(T3a=dict(filas=len(t3a), max_dL_um=mL, max_dV_mV=mV), T2=[dict(na=a, sigma=b, max_dI=c) for a, b, c in t2r],
             T3b=dict(n=len(t3b), max_dI=max(r[3] for r in t3b), max_dL_um=max(r[4] for r in t3b), max_dV_mV=max(r[5] for r in t3b)),
             fallback=fallback)

    # ---- T4: tiempos (primer ajuste) ----
    na, sg = SETTINGS[0]; thr = thrs[(na, sg)]; P = g.pupils(na, sg); inc = Inc(g, P)
    kw = dict(xs=(0.0, 0.36)); rects = gate_rects(**kw); boxes = [g.box(*r) for r in rects]; inc.E_of(boxes)
    def tm(f, n):
        ts = []
        for _ in range(n): t = time.perf_counter(); f(); ts.append(time.perf_counter() - t)
        return float(np.median(ts))
    tA = tm(lambda: observables(g.image(mask_of(g, rects), na, sg), thr, kw, g), 5)
    tB = tm(lambda: observables(g.image_cached(mask_of(g, rects), P), thr, kw, g), 5)
    tC = tm(lambda: inc.obs(inc.E_of(boxes), thr, kw), 50)
    E0 = inc.E_of(boxes); b_old = boxes[1]; b_new = g.box(*gate_rects(xs=(0.0, 0.40))[1])
    def move():
        E = E0 + inc.field(b_old) - inc.field(b_new); return inc.obs(E, thr, dict(xs=(0.0, 0.40)))
    tD = tm(move, 50)
    p(f"T4 (NA {na} σ {sg}, mediana): c62 literal {tA*1e3:.0f} ms · FFT con pupilas en caché {tB*1e3:.0f} ms · "
      f"incremental desde cero {tC*1e3:.1f} ms · mover una vecina {tD*1e3:.1f} ms")
    p(f"   aceleración frente a FFT en caché: {tB/tC:.0f}× (desde cero), {tB/tD:.0f}× (mover); frente a c62 literal: {tA/tC:.0f}×")
    J["T4_ms"] = dict(c62=tA * 1e3, fft_cache=tB * 1e3, inc=tC * 1e3, mover=tD * 1e3, acel_vs_cache=tB / tC, acel_mover=tB / tD)

    # ---- T6: escala con N y con la ROI (solo tiempo de campo + intensidad; N=512 es otra caja periódica: solo tiempos) ----
    sc = []
    for Nn in (512, 1024):
        gg = Grid(Nn); PP = gg.pupils(na, sg); rr = [gg.box(*r) for r in gate_rects()]
        for roi in ((-0.25, 0.25, -0.45, 0.45), (-0.4, 0.4, -0.7, 0.7)):
            ii = Inc(gg, PP, roi=roi, org=(-0.6, 0.6, -0.8, 0.4)); ii.E_of(rr)
            tf = tm(lambda: gg.image_cached(mask_of(gg, gate_rects()), PP), 3)
            ti = tm(lambda: Inc.I_of(ii.E_of(rr)), 30)
            sc.append((Nn, ii.shape[1] * ii.shape[2], tf * 1e3, ti * 1e3)); del ii
            p(f"T6 N={Nn} ROI {sc[-1][1]} px: FFT {tf*1e3:.0f} ms, incremental {ti*1e3:.1f} ms")
    J["T6"] = [dict(N=a, roi_px=b, fft_ms=c, inc_ms=d) for a, b, c, d in sc]
    J["rss_pico_gb"] = rss_gb(); J["fin"] = time.strftime("%Y-%m-%d %H:%M:%S %Z")
    p(f"RSS pico {rss_gb():.2f} GB · fin {J['fin']}")
    open(f"{outdir}/resultados.txt", "w").write("\n".join(log) + "\n")
    json.dump(J, open(f"{outdir}/resultados.json", "w"), indent=1, default=str)
    with open(f"{outdir}/t3b_geometrias.txt", "w") as fh:
        for r in t3b: fh.write(f"{r[0]} {r[1]} {r[2]} dI={r[3]:.2e} dL={r[4]:.2e} dV={r[5]:.2e} {r[6]}\n")


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else ".")
