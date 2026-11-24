"""E_B, estimador independiente de XC-19 (prerregistro XC-19_2026-11-23_discriminacion_abanico.md, §6, + enmiendas 1-3).

Escrito por un agente que NO ha leido run_ea.py, run_ea_v1.py, ea.*, ea_corrida.log ni humo_T1_*.txt. Usa sim.py tal cual
(simulate, CORNERS, GEOM, NB, CP, in_band); no lo modifica. Celda de juicio: fa = 1 kHz, T = 1 s, eta = 1 (enmienda 1, A1).

DEFINICIONES FIJADAS ANTES DE CORRER NINGUNA CELDA QUE DECIDE (solo se corre antes la prueba de humo de T1):

Rasgos por dispositivo, sobre la serie y[n] = cuenta_A - cuenta_B (N = fa*T = 1000 conversiones), en float:
  d = y - media(y); m2 = media(d^2); m4 = media(d^4)
  x1 = log(m2 + 1e-2)                                   varianza
  x2 = sign(k)*log(1 + |k|), k = m4/m2^2 - 3 (k = 0 si m2 = 0)   curtosis en exceso, comprimida
  x3, x4, x5 = log(ADEV(m) + 1e-2), m = 1, 10, 100 conversiones (1, 10, 100 ms): desviacion de Allan solapada,
       ADEV(m)^2 = 0,5 * media_k (Ybar_{k+m} - Ybar_k)^2, Ybar_k = media de y[k..k+m-1]
  x6 = cruces de nivel por conversion: fraccion de n con [y[n] > media(y)] != [y[n+1] > media(y)]
Clasificador: regresion logistica (numpy, Newton/IRLS, rasgos estandarizados con media y desviacion del entrenamiento,
  penalizacion L2 = 1,0 sobre los pesos, sin penalizar el intercepto). Umbral de decision: el que maximiza I(H; decision) en el
  conjunto de ENTRENAMIENTO (rejilla: 0,5 y los cuantiles 0,5 %..99,5 % de las probabilidades de entrenamiento). Ningun dato de
  prueba toca el ajuste ni el umbral. Entrenamiento y prueba son chips distintos con semillas distintas
  (SeedSequence([20261123, crc32(nombre de celda), 0 entrenamiento | 1 prueba])).
Bits: I(H; Hhat) en bits de la matriz de confusion 2x2 empirica en prueba. IC 95 %: percentiles 2,5/97,5 de 1000 remuestreos
  bootstrap de los chips de prueba (clasificador fijo).

D1 (por dispositivo, un C0 = A1 por chip, rho_scale = 1): etiqueta de entrenamiento H = truth[:,0] > 0. Se reporta deteccion
  entre truth[:,1] > 0, falsos positivos entre truth[:,0] == 0 y bits I(truth[:,0] > 0; decision).
D2 (por chip): 16 patas C0 (A1, f = 1) + R = 16/A patas de prueba de la clase A (f = 1 o 3, mitad y mitad, alternando).
  Dos poblaciones de lambda0:
   - "prior": rho_scale ~ log-uniforme en [0,1, 10] por chip (b6 del prerregistro), el mismo para todas las patas del chip.
   - "fijo": rho_scale = 1.
  Rasgos de chip: media de x1..x6 sobre las patas de prueba (6), media de x1..x6 sobre las patas C0 (6),
   log(1e-3 + media p_prueba) y log(1e-3 + media p_C0), donde p es la probabilidad de un modelo logistico por dispositivo
   ("al menos una trampa en banda", truth[:,0] > 0) entrenado en los chips de entrenamiento, uno para patas C0 y otro para
   patas de prueba. Modelo de chip: logistica sobre esos 14 rasgos, etiqueta f = 3.
  Techo de Poisson (prereg_calc.py, poisson_bits): lam = NB[(c, t, 1000.0, 1.0, 1)] * A * R, f = 3 frente a 1 ("techo").
   En "prior" se da ademas el techo con lambda0 conocido chip a chip (A5): media sobre los chips de prueba de
   poisson_bits(s*lam, 3*s*lam) ("techo_prior").
  Celdas con simulate() == None: "no adquirible".
Testigos y mutantes:
  T1: una sola trampa de 0,305 mV, tau = 1 ms en A (mitad de los dispositivos; la otra mitad sin trampas), B sin trampas,
      tt 27, C0, S. Pasa si deteccion >= 0,95 y falsos <= 0,01. Se reporta tambien T1b (B con sus trampas naturales), sin
      criterio. (truth[:,1] no sirve aqui: tau = 1 ms < 10/fa; la etiqueta es la trampa inyectada.)
  T2: f = 10 frente a 1, A1, R = 16, tt, S (prior y fijo), con su techo (f = 10).
  M1: amp_scale = 0, tt, S: D1 y D2 (A1, prior). M2: etiquetas de entrenamiento barajadas, tt, S: D1 y D2 (A1, prior).
  M3: ff 85, quant = False: D1 y D2 (A1, prior) frente a S. M4: same_traps_in_B = True, tt, S: D1.
Uso: python e_b.py humo   (solo T1; NCHIP por mitad, por defecto 1000)
     python e_b.py todo   (NCHIP por mitad, por defecto 2000) -> eb.txt, eb.json
"""
import json, math, os, subprocess, sys, time, zlib
from multiprocessing import Pool
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import sim  # noqa: E402
from sim import simulate, CORNERS, GEOM, NB, CP, in_band  # noqa: E402,F401

FA, T, ETA = 1000.0, 1.0, 1
BASE = 20261123
AREA = {k: round(w * l / (0.42 * 0.15)) for k, (w, l) in GEOM.items()}


# ---------------------------------------------------------------- rasgos
def features(Y):
    y = np.asarray(Y, dtype=float)
    n = y.shape[1]
    mu = y.mean(1, keepdims=True)
    d = y - mu
    m2 = (d ** 2).mean(1)
    m4 = (d ** 4).mean(1)
    with np.errstate(divide="ignore", invalid="ignore"):
        k = np.where(m2 > 0, m4 / np.where(m2 > 0, m2, 1) ** 2 - 3.0, 0.0)
    c = np.concatenate([np.zeros((y.shape[0], 1)), np.cumsum(y, 1)], 1)
    ad = []
    for m in (1, 10, 100):
        M = (c[:, m:] - c[:, :-m]) / m          # medias solapadas, longitud n - m + 1
        D = M[:, m:] - M[:, :-m]
        ad.append(np.sqrt(0.5 * (D ** 2).mean(1)))
    s = d > 0
    cr = (s[:, 1:] != s[:, :-1]).mean(1)
    return np.column_stack([np.log(m2 + 1e-2), np.sign(k) * np.log1p(np.abs(k)),
                            np.log(ad[0] + 1e-2), np.log(ad[1] + 1e-2), np.log(ad[2] + 1e-2), cr])


# ---------------------------------------------------------------- logistica
class Logit:
    def fit(self, X, h, l2=1.0, it=60):
        X = np.asarray(X, float); h = np.asarray(h, float)
        self.mu = X.mean(0); sd = X.std(0); self.sd = np.where(sd > 0, sd, 1.0)
        Z = np.column_stack([np.ones(len(X)), (X - self.mu) / self.sd])
        w = np.zeros(Z.shape[1]); P = np.full(Z.shape[1], l2); P[0] = 0.0
        for _ in range(it):
            p = 1 / (1 + np.exp(-np.clip(Z @ w, -35, 35)))
            g = Z.T @ (p - h) + P * w
            H = (Z * (p * (1 - p))[:, None]).T @ Z + np.diag(P + 1e-9)
            step = np.linalg.solve(H, g)
            w -= step
            if np.max(np.abs(step)) < 1e-8:
                break
        self.w = w
        return self

    def prob(self, X):
        Z = np.column_stack([np.ones(len(X)), (np.asarray(X, float) - self.mu) / self.sd])
        return 1 / (1 + np.exp(-np.clip(Z @ self.w, -35, 35)))


def mi_counts(n):
    """n = [n00, n01, n10, n11] (h, d). I en bits."""
    n = np.asarray(n, float); N = n.sum()
    if N == 0:
        return 0.0
    p = n.reshape(2, 2) / N
    ph = p.sum(1); pd = p.sum(0)
    I = 0.0
    for i in range(2):
        for j in range(2):
            if p[i, j] > 0:
                I += p[i, j] * math.log2(p[i, j] / (ph[i] * pd[j]))
    return I


def mi(h, d):
    return mi_counts(np.bincount(2 * np.asarray(h, int) + np.asarray(d, int), minlength=4))


def pick_threshold(p, h):
    cand = np.unique(np.concatenate([[0.5], np.quantile(p, np.linspace(0.005, 0.995, 199))]))
    best = (-1.0, 0.5)
    for c in cand:
        v = mi(h, p > c)
        if v > best[0]:
            best = (v, c)
    return best[1]


def boot(h, d, extra=None, B=1000, seed=0):
    """IC 95 % de bits (y de tasas si extra = (mask_pos, mask_neg))."""
    rng = np.random.default_rng(seed)
    h = np.asarray(h, int); d = np.asarray(d, int); n = len(h)
    code = 2 * h + d
    bits = np.empty(B); det = np.empty(B); fp = np.empty(B)
    for b in range(B):
        idx = rng.integers(0, n, n)
        bits[b] = mi_counts(np.bincount(code[idx], minlength=4))
        if extra is not None:
            mp, mn = extra[0][idx], extra[1][idx]; dd = d[idx]
            det[b] = dd[mp].mean() if mp.any() else np.nan
            fp[b] = dd[mn].mean() if mn.any() else np.nan
    q = lambda a: [float(np.nanpercentile(a, 2.5)), float(np.nanpercentile(a, 97.5))]
    out = {"bits_ic": q(bits)}
    if extra is not None:
        out["det_ic"] = q(det); out["fp_ic"] = q(fp)
    return out


def poisson_bits(lam1, lam3):
    """Copia literal de prereg_calc.py."""
    nmax = int(lam3 + 12 * math.sqrt(lam3) + 30)
    I = 0.0
    lp1 = -lam1; lp3 = -lam3
    for n in range(nmax + 1):
        if n:
            lp1 += math.log(lam1) - math.log(n); lp3 += math.log(lam3) - math.log(n)
        p1, p3 = math.exp(lp1), math.exp(lp3)
        pm = 0.5 * (p1 + p3)
        if p1 > 0: I += 0.5 * p1 * math.log2(p1 / pm)
        if p3 > 0: I += 0.5 * p3 * math.log2(p3 / pm)
    return I


def rng_for(name, split):
    return np.random.default_rng(np.random.SeedSequence([BASE, zlib.crc32(name.encode()), split]))


# ---------------------------------------------------------------- T1
def sim_t1(rng, n, b_natural=False):
    lab = rng.random(n) < 0.5
    orig = sim.traps
    calls = [0]
    e = (np.empty(0), np.empty(0))

    def fake(rng_, n_dev, rho, f, A, eta):
        calls[0] += 1
        if calls[0] == 1:
            return [(np.array([1e-3]), np.array([0.305e-3])) if l else e for l in lab]
        return orig(rng_, n_dev, rho, f, A, eta) if b_natural else [e for _ in range(n_dev)]

    sim.traps = fake
    try:
        Y, tr, tk = simulate(rng, ("tt", "27"), "A1", 1.0, ETA, FA, T, "S", n)
    finally:
        sim.traps = orig
    return features(Y), lab.astype(int)


def job_t1(args):
    name, n, b_nat = args
    Xa, ha = sim_t1(rng_for(name, 0), n, b_nat)
    Xb, hb = sim_t1(rng_for(name, 1), n, b_nat)
    m = Logit().fit(Xa, ha); thr = pick_threshold(m.prob(Xa), ha)
    d = (m.prob(Xb) > thr).astype(int)
    r = {"celda": name, "n_prueba": n, "det": float(d[hb == 1].mean()), "fp": float(d[hb == 0].mean()),
         "bits": mi(hb, d), "umbral": float(thr)}
    r.update(boot(hb, d, (hb == 1, hb == 0), seed=1))
    r["pasa"] = bool(r["det"] >= 0.95 and r["fp"] <= 0.01)
    return r


# ---------------------------------------------------------------- D1
def gen_d1(rng, corner, variant, n, **kw):
    Y, tr, tk = simulate(rng, corner, "A1", 1.0, ETA, FA, T, variant, n, **kw)
    if Y is None:
        return None
    return features(Y), tr


def job_d1(args):
    name, corner, variant, n, kw, shuffle = args
    a = gen_d1(rng_for(name, 0), corner, variant, n, **kw)
    b = gen_d1(rng_for(name, 1), corner, variant, n, **kw)
    if a is None:
        return {"celda": name, "no_adquirible": True}
    Xa, tra = a; Xb, trb = b
    ha = (tra[:, 0] > 0).astype(int); hb = (trb[:, 0] > 0).astype(int)
    if shuffle:
        ha = np.random.default_rng(99).permutation(ha)
    m = Logit().fit(Xa, ha); thr = pick_threshold(m.prob(Xa), ha)
    d = (m.prob(Xb) > thr).astype(int)
    pos = trb[:, 1] > 0; neg = trb[:, 0] == 0
    r = {"celda": name, "esquina": " ".join(corner), "variante": variant, "n_prueba": n,
         "det": float(d[pos].mean()), "n_pos": int(pos.sum()), "fp": float(d[neg].mean()), "n_neg": int(neg.sum()),
         "bits": mi(hb, d), "frac_h1": float(hb.mean()), "umbral": float(thr)}
    r.update(boot(hb, d, (pos, neg), seed=2))
    return r


# ---------------------------------------------------------------- D2
def gen_d2(rng, corner, cls, variant, nchip, prior, f_alt=3.0, **kw):
    A = AREA[cls]; R = 16 // A
    X0 = np.empty((nchip, 16, 6)); Xt = np.empty((nchip, R, 6))
    h0 = np.empty((nchip, 16), int); ht = np.empty((nchip, R), int)
    lab = np.arange(nchip) % 2
    S = np.empty(nchip)
    for i in range(nchip):
        s = 10 ** rng.uniform(-1, 1) if prior else 1.0
        S[i] = s
        f = f_alt if lab[i] else 1.0
        Y0, tr0, _ = simulate(rng, corner, "A1", 1.0, ETA, FA, T, variant, 16, rho_scale=s, **kw)
        Yt, trt, tk = simulate(rng, corner, cls, f, ETA, FA, T, variant, R, rho_scale=s, **kw)
        if Y0 is None or Yt is None:
            return None, tk
        X0[i] = features(Y0); Xt[i] = features(Yt)
        h0[i] = tr0[:, 0] > 0; ht[i] = trt[:, 0] > 0
    return (X0, Xt, h0, ht, lab, S), None


def chip_feats(X0, Xt, m0, mt):
    nc, R, _ = Xt.shape
    p0 = m0.prob(X0.reshape(-1, 6)).reshape(nc, 16).mean(1)
    pt = mt.prob(Xt.reshape(-1, 6)).reshape(nc, R).mean(1)
    return np.column_stack([Xt.mean(1), X0.mean(1), np.log(1e-3 + pt), np.log(1e-3 + p0)])


def job_d2(args):
    name, corner, cls, variant, nchip, prior, f_alt, kw, shuffle = args
    A = AREA[cls]; R = 16 // A
    c, t = corner
    lam = NB[(c, t, 1000.0, 1.0, 1)] * A * R
    base = {"celda": name, "esquina": " ".join(corner), "clase": cls, "A": A, "R": R, "variante": variant,
            "prior": prior, "f_alt": f_alt, "techo": poisson_bits(lam, f_alt * lam)}
    a, tk = gen_d2(rng_for(name, 0), corner, cls, variant, nchip, prior, f_alt, **kw)
    if a is None:
        base.update({"no_adquirible": True, "t_k_us": tk * 1e6})
        return base
    b, _ = gen_d2(rng_for(name, 1), corner, cls, variant, nchip, prior, f_alt, **kw)
    X0a, Xta, h0a, hta, la, Sa = a
    X0b, Xtb, h0b, htb, lb, Sb = b
    m0 = Logit().fit(X0a.reshape(-1, 6), h0a.ravel())
    mt = Logit().fit(Xta.reshape(-1, 6), hta.ravel()) if hta.any() and not hta.all() else m0
    Za = chip_feats(X0a, Xta, m0, mt); Zb = chip_feats(X0b, Xtb, m0, mt)
    if shuffle:
        la = np.random.default_rng(98).permutation(la)
    m = Logit().fit(Za, la); thr = pick_threshold(m.prob(Za), la)
    d = (m.prob(Zb) > thr).astype(int)
    base.update({"n_prueba": nchip, "bits": mi(lb, d), "acierto": float((d == lb).mean()), "umbral": float(thr)})
    base.update(boot(lb, d, seed=3))
    if prior:
        base["techo_prior"] = float(np.mean([poisson_bits(s * lam, f_alt * s * lam) for s in Sb]))
        base["frac_techo_prior"] = base["bits"] / base["techo_prior"]
    base["frac_techo"] = base["bits"] / base["techo"]
    return base


# ---------------------------------------------------------------- principal
def run_jobs(jobs):
    with Pool(min(8, len(jobs))) as P:
        return P.map(_dispatch, jobs)


def _dispatch(j):
    kind, args = j
    return {"t1": job_t1, "d1": job_d1, "d2": job_d2}[kind](args)


def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else "todo"
    t0 = time.time()
    fecha = subprocess.run(["date"], capture_output=True, text=True).stdout.strip()
    if mode == "humo":
        n = int(os.environ.get("NCHIP", "1000"))
        res = run_jobs([("t1", ("T1", n, False)), ("t1", ("T1b", n, True))])
        print(fecha)
        for r in res:
            print(json.dumps(r))
        print(f"tiempo {time.time() - t0:.1f} s")
        return
    n = int(os.environ.get("NCHIP", "2000"))
    jobs = [("t1", ("T1", n, False)), ("t1", ("T1b", n, True))]
    for corner in CORNERS:
        for v in ("S", "D"):
            jobs.append(("d1", (f"D1 {' '.join(corner)} {v}", corner, v, n, {}, False)))
    tt, ff85 = ("tt", "27"), ("ff", "85")
    jobs += [("d1", ("M1 D1 tt 27 S", tt, "S", n, {"amp_scale": 0.0}, False)),
             ("d1", ("M2 D1 tt 27 S", tt, "S", n, {}, True)),
             ("d1", ("M3 D1 ff 85 noquant", ff85, "S", n, {"quant": False}, False)),
             ("d1", ("M4 D1 tt 27 S", tt, "S", n, {"same_traps_in_B": True}, False))]
    for prior in (True, False):
        pz = "prior" if prior else "fijo"
        for corner in CORNERS:
            vs = ("S", "D") if corner == ff85 else ("S",)
            for v in vs:
                for cls in GEOM:
                    jobs.append(("d2", (f"D2 {pz} {' '.join(corner)} {v} {cls}", corner, cls, v, n, prior, 3.0, {},
                                        False)))
        jobs.append(("d2", (f"T2 {pz} tt 27 S A1", tt, "A1", "S", n, prior, 10.0, {}, False)))
    jobs += [("d2", ("M1 D2 prior tt 27 S A1", tt, "A1", "S", n, True, 3.0, {"amp_scale": 0.0}, False)),
             ("d2", ("M2 D2 prior tt 27 S A1", tt, "A1", "S", n, True, 3.0, {}, True)),
             ("d2", ("M3 D2 prior ff 85 noquant A1", ff85, "A1", "S", n, True, 3.0, {"quant": False}, False))]
    # las celdas de D2 mas pesadas primero
    jobs.sort(key=lambda j: 0 if j[0] == "d2" else 1)
    res = run_jobs(jobs)
    dt = time.time() - t0
    json.dump({"fecha": fecha, "nchip_por_mitad": n, "tiempo_s": dt, "celdas": res},
              open(os.path.join(HERE, "eb.json"), "w"), indent=1)
    L = [fecha, f"E_B (e_b.py), NCHIP = {n} por mitad (entrenamiento y prueba aparte), fa = 1 kHz, T = 1 s, eta = 1",
         f"tiempo de pared {dt:.0f} s", ""]
    f3 = lambda x: f"{x:.3f}"
    ic = lambda r, k: f"[{r[k][0]:.3f}, {r[k][1]:.3f}]"
    L.append("## Testigo T1 (y T1b sin criterio)")
    for r in res:
        if r["celda"] in ("T1", "T1b"):
            L.append(f"{r['celda']}: det {f3(r['det'])} {ic(r, 'det_ic')} | fp {f3(r['fp'])} {ic(r, 'fp_ic')} | "
                     f"bits {f3(r['bits'])} {ic(r, 'bits_ic')} | pasa(>=0,95 y <=0,01) {r['pasa']}")
    L.append("\n## D1 y mutantes de D1: celda | det (truth1>0) [IC] | fp (truth0==0) [IC] | bits [IC] | n_pos | n_neg")
    for r in res:
        if r["celda"].startswith(("D1", "M1 D1", "M2 D1", "M3 D1", "M4 D1")):
            if r.get("no_adquirible"):
                L.append(f"{r['celda']} | no adquirible"); continue
            L.append(f"{r['celda']} | {f3(r['det'])} {ic(r, 'det_ic')} | {f3(r['fp'])} {ic(r, 'fp_ic')} | "
                     f"{f3(r['bits'])} {ic(r, 'bits_ic')} | {r['n_pos']} | {r['n_neg']}")
    L.append("\n## D2, T2 y mutantes de D2: celda | A | R | bits [IC] | techo | frac techo | techo_prior | frac techo_prior")
    for r in res:
        if r["celda"].startswith(("D2", "T2", "M1 D2", "M2 D2", "M3 D2")):
            if r.get("no_adquirible"):
                L.append(f"{r['celda']} | {r['A']} | {r['R']} | no adquirible (t_k = {r['t_k_us']:.1f} us)"); continue
            tp = f"{f3(r['techo_prior'])} | {f3(r['frac_techo_prior'])}" if "techo_prior" in r else "- | -"
            L.append(f"{r['celda']} | {r['A']} | {r['R']} | {f3(r['bits'])} {ic(r, 'bits_ic')} | {f3(r['techo'])} | "
                     f"{f3(r['frac_techo'])} | {tp}")
    open(os.path.join(HERE, "eb.txt"), "w").write("\n".join(L) + "\n")
    print("\n".join(L))


if __name__ == "__main__":
    main()
