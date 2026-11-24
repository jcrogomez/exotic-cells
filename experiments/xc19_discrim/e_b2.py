"""E_B v2, estimador independiente de XC-19 (prerregistro XC-19_2026-11-23_discriminacion_abanico.md + enmiendas 1-4).

Escrito por un agente que NO ha leido run_ea.py, run_ea_v1.py, run_ea*.py, ea.txt, ea.json ni la seccion 0 de la enmienda 4.
Parte de e_b.py (E_B v1, que no se edita) y cambia solo lo que pide la enmienda 4 (A4.4, A4.5, A4.6, A4.7, A4.8).
Usa sim.py tal cual; no lo modifica. Celda de juicio: fa = 1 kHz, T = 1 s, eta = 1 (enmienda 1, A1).

DEFINICIONES FIJADAS ANTES DE CORRER NADA (ni el humo):

Rasgos por dispositivo, sobre y[n] = cuenta_A - cuenta_B (N = 1000 conversiones), en float. x1..x6 como en E_B v1:
  d = y - media(y); m2 = media(d^2); m3 = media(d^3); m4 = media(d^4)
  x1 = log(m2 + 1e-2); x2 = sign(k)*log(1 + |k|), k = m4/m2^2 - 3; x3..x5 = log(ADEV(m) + 1e-2), m = 1, 10, 100;
  x6 = cruces de la media por conversion.
Rasgos con signo nuevos (enmienda 4, A4.4):
  x7 = sign(g)*log(1 + |g|), g = m3/m2^1.5 (asimetria de y; g = 0 si m2 = 0)
  x8 = lo mismo sobre las diferencias de primer orden D[n] = y[n+1] - y[n] (asimetria de D)
  x9 = log(1 + J+), x10 = log(1 + J-): numero de saltos positivos y negativos, por separado.
Detector de saltos (eleccion de E_B, distinto del de E_A v3 por construccion: no se ha visto aquel codigo):
  diferencia de primer orden D[n] = y[n+1] - y[n] con umbral robusto.
  sigma: escala del ruido del grupo central de D, por recorte iterativo a 2 sigma que arranca desde abajo:
    centro c_0 = mediana(D), sigma_0 = 1 cuenta; c_{j+1} = media y sigma_{j+1} = std(D[|D - c_j| <= 2 sigma_j]) / 0,8796
    (correccion de la normal truncada a +-2 sigma); 12 iteraciones; suelo 0,5 cuentas. Arrancar desde abajo hace que converja al grupo de "sin salto" aunque
    muchas diferencias sean saltos.
  Salto positivo en n si D[n] - c > 3*sigma; negativo si < -3*sigma. J+ y J- = cuentas de cada signo. Sin supresion
  de no maximos: cada conversion es un salto como mucho, y un telegrama que va y vuelve en conversiones seguidas cuenta un + y
  un -. El suelo de 0,5 cuentas (umbral >= 1,5 cuentas) evita que la cuantizacion de +-1 cuenta con ruido nulo cuente como
  saltos.
  HISTORIA, ANTES DEL HUMO (2026-11-24): la primera version usaba sigma = 1,4826*MAD(D) y k = 4; la segunda, el cuantil 25 %
  de |D|/0,3186 y k = 4; la tercera, recorte a 3 sigma (se desboca: los saltos de 11,3 cuentas caen dentro de 3 sigma y
  la escala crece hasta incluirlos). Un chequeo de cordura con 20 dispositivos de T1 (semilla 5, fuera de las semillas "e4"; no es humo
  ni celda que decide) dio J+ = J- = 0 con las tres en los dispositivos con la trampa: la trampa de tau = 1 ms cambia en ~43 %
  de las conversiones, lo que infla esas escalas (y las cuentas enteras sesgan el cuantil), y el salto de 11,3 cuentas es
  solo ~3,6 veces el ruido de D (~3,1 cuentas). La cuarta (recorte a 2 sigma centrado en la mediana entera) daba 72 saltos en un dispositivo sin trampa de ruido
  normal: la mediana entera descentraba el recorte. Se fijo esta quinta version (centro = media recortada) por eso, antes de correr el humo. Ningun otro
  rasgo cambio.
Clasificador, umbral, bits e IC: igual que E_B v1 (logistica L2 = 1, IRLS; umbral que maximiza I en ENTRENAMIENTO; bits =
  I(H; Hhat) de la matriz de confusion 2x2 en chips de PRUEBA con otra semilla; IC 95 % de 1000 remuestreos bootstrap).
Semillas (A4.7): SeedSequence([20261123, crc32("e4"), crc32(nombre de celda), 0 entrenamiento | 1 prueba]); las permutaciones de
  M2 tambien salen de la sal "e4". Ninguna coincide con las de e_b.py.

D1 y D2 como en E_B v1, ahora con 10 rasgos por dispositivo (D2: 22 rasgos de chip = media de x1..x10 en patas de prueba,
  media de x1..x10 en patas C0, log(1e-3 + media p_prueba), log(1e-3 + media p_C0)).
  "prior": rho_scale log-uniforme en [0,1, 10] por chip (b6, lambda0 desconocido, la definicion de D2). "fijo": rho_scale = 1.
Variantes de B (A4.5): BT = gemelo C0 (b_area = 1, la de siempre); BR = referencia 2x6, sim.simulate(..., b_area=12).
Techo: el de Poisson del prerregistro (poisson_bits de prereg_calc.py, lambda0 nominal conocido), lam = NB*A*R, f_alt frente a 1.
  Para R*A = 16 en tt debe reproducir la tabla de la enmienda 4 (0,181 / 0,477 / 0,850 / 1,000 para f = 1,5 / 2 / 3 / 10);
  se imprime al arrancar. En "prior" se da ademas techo_prior (lambda0 conocido chip a chip, A5), sin criterio.
  frac = bits / techo, juzgada sobre el valor central (A4 de la enmienda 1).

Testigos, mutantes y predicciones (fa = 1 kHz, T = 1 s, NCHIP por mitad):
  T1: una trampa de 0,305 mV, tau = 1 ms en A (mitad de dispositivos), B sin trampas, tt, C0, S: pasa si det >= 0,95 y fp <= 0,01.
      T1b (B con sus trampas naturales, BT) sin criterio.
  T2: f = 10 frente a 1, A1, R = 16, tt, S, BT. Pasa si frac = bits/techo >= 0,80. Se juzga en "prior" (D2 del prerregistro es
      con lambda0 desconocido); "fijo" se reporta tambien con su frac.
  Humo (A4.6): solo T1 y T2 (prior y fijo), 400 chips por mitad. Si T2 prior da frac < 0,80, se para: no se corre la tanda
      completa ni se revisa el estimador.
  PD1-PD2: D1 en las 4 esquinas, S y D, BT. PD3-PD5: D2 prior y fijo en las 4 esquinas, S (y D en ff 85), clases A1, A2, A4, A8, BT.
  PD6: D1 tt 27 S con BT y con BR: se reportan las dos fracciones de falsos positivos y su cociente BR/BT.
  BR en D2 (A4.5): D2 prior y fijo, tt 27 S, las 4 clases.
  D4 (A4.8), PD7, PD8: D2 A1, R = 16, tt, S, f in {1,5, 2, 3} frente a 1, BT y BR, prior y fijo.
  M1 (amp x0), M2 (etiquetas barajadas), M3 (ff 85 sin cuantizacion), M4 (mismas trampas en A y B): como en E_B v1, con BT.
  M5 es de E_A v3 (umbral de su detector x100); no aplica a E_B.
Uso: python e_b2.py humo   (NCHIP por mitad, por defecto 400)  -> humo_eb2.txt
     python e_b2.py todo   (NCHIP por mitad, por defecto 2000) -> eb2.txt, eb2.json
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
SALT = zlib.crc32(b"e4")
NF = 10   # rasgos por dispositivo
J_K, J_FLOOR = 3.0, 0.5
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
    sq = lambda v: np.sign(v) * np.log1p(np.abs(v))
    g_y = skew(d)
    D = np.diff(y, axis=1)
    g_d = skew(D - D.mean(1, keepdims=True))
    jp, jn = jumps(D)
    return np.column_stack([np.log(m2 + 1e-2), sq(k),
                            np.log(ad[0] + 1e-2), np.log(ad[1] + 1e-2), np.log(ad[2] + 1e-2), cr,
                            sq(g_y), sq(g_d), np.log1p(jp), np.log1p(jn)])


def skew(d):
    """Tercer momento estandarizado por fila de d (ya centrada); 0 si la varianza es 0."""
    m2 = (d ** 2).mean(1); m3 = (d ** 3).mean(1)
    with np.errstate(divide="ignore", invalid="ignore"):
        return np.where(m2 > 0, m3 / np.where(m2 > 0, m2, 1) ** 1.5, 0.0)


def jumps(D):
    """Detector de saltos de E_B v2 (ver docstring): D = diferencias de primer orden por fila. Devuelve (J+, J-)."""
    med = np.median(D, axis=1, keepdims=True)
    E = D - med
    sig = np.ones((D.shape[0], 1)); mu = np.zeros((D.shape[0], 1))
    for _ in range(12):
        m = np.abs(E - mu) <= 2 * sig
        n = np.maximum(m.sum(1, keepdims=True), 2)
        mu = (E * m).sum(1, keepdims=True) / n
        sig = np.maximum(np.sqrt((((E - mu) ** 2) * m).sum(1, keepdims=True) / (n - 1)) / 0.8796, J_FLOOR)
    E = E - mu
    return (E > J_K * sig).sum(1), (E < -J_K * sig).sum(1)


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
    return np.random.default_rng(np.random.SeedSequence([BASE, SALT, zlib.crc32(name.encode()), split]))


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
        ha = np.random.default_rng([SALT, 99]).permutation(ha)
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
    X0 = np.empty((nchip, 16, NF)); Xt = np.empty((nchip, R, NF))
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
    p0 = m0.prob(X0.reshape(-1, NF)).reshape(nc, 16).mean(1)
    pt = mt.prob(Xt.reshape(-1, NF)).reshape(nc, R).mean(1)
    return np.column_stack([Xt.mean(1), X0.mean(1), np.log(1e-3 + pt), np.log(1e-3 + p0)])


def job_d2(args):
    name, corner, cls, variant, nchip, prior, f_alt, kw, shuffle = args
    A = AREA[cls]; R = 16 // A
    c, t = corner
    lam = NB[(c, t, 1000.0, 1.0, 1)] * A * R
    base = {"celda": name, "esquina": " ".join(corner), "clase": cls, "A": A, "R": R, "variante": variant,
            "prior": prior, "f_alt": f_alt, "b_area": kw.get("b_area", 1.0), "techo": poisson_bits(lam, f_alt * lam)}
    a, tk = gen_d2(rng_for(name, 0), corner, cls, variant, nchip, prior, f_alt, **kw)
    if a is None:
        base.update({"no_adquirible": True, "t_k_us": tk * 1e6})
        return base
    b, _ = gen_d2(rng_for(name, 1), corner, cls, variant, nchip, prior, f_alt, **kw)
    X0a, Xta, h0a, hta, la, Sa = a
    X0b, Xtb, h0b, htb, lb, Sb = b
    m0 = Logit().fit(X0a.reshape(-1, NF), h0a.ravel())
    mt = Logit().fit(Xta.reshape(-1, NF), hta.ravel()) if hta.any() and not hta.all() else m0
    Za = chip_feats(X0a, Xta, m0, mt); Zb = chip_feats(X0b, Xtb, m0, mt)
    if shuffle:
        la = np.random.default_rng([SALT, 98]).permutation(la)
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


def techo_check():
    lam = NB[("tt", "27", 1000.0, 1.0, 1)] * 16
    return "techos tt 27, R*A = 16 (poisson_bits): " + " | ".join(
        f"f = {f}: {poisson_bits(lam, f * lam):.3f}" for f in (1.5, 2.0, 3.0, 10.0))


f3 = lambda x: f"{x:.3f}"
ic = lambda r, k: f"[{r[k][0]:.3f}, {r[k][1]:.3f}]"


def line_t1(r):
    return (f"{r['celda']}: det {f3(r['det'])} {ic(r, 'det_ic')} | fp {f3(r['fp'])} {ic(r, 'fp_ic')} | "
            f"bits {f3(r['bits'])} {ic(r, 'bits_ic')} | pasa(det>=0,95 y fp<=0,01) {r['pasa']}")


def line_d1(r):
    if r.get("no_adquirible"):
        return f"{r['celda']} | no adquirible"
    return (f"{r['celda']} | {f3(r['det'])} {ic(r, 'det_ic')} | {f3(r['fp'])} {ic(r, 'fp_ic')} | "
            f"{f3(r['bits'])} {ic(r, 'bits_ic')} | {r['n_pos']} | {r['n_neg']}")


def line_d2(r):
    if r.get("no_adquirible"):
        return f"{r['celda']} | {r['A']} | {r['R']} | no adquirible (t_k = {r['t_k_us']:.1f} us)"
    tp = f"{f3(r['techo_prior'])} | {f3(r['frac_techo_prior'])}" if "techo_prior" in r else "- | -"
    return (f"{r['celda']} | {r['A']} | {r['R']} | {f3(r['bits'])} {ic(r, 'bits_ic')} | {f3(r['techo'])} | "
            f"{f3(r['frac_techo'])} | {tp}")


H_D1 = "celda | det (truth1>0) [IC 95 %] | fp (truth0==0) [IC 95 %] | bits [IC 95 %] | n_pos | n_neg"
H_D2 = "celda | A | R | bits [IC 95 %] | techo | frac = bits/techo | techo_prior | bits/techo_prior"
tt, ff85 = ("tt", "27"), ("ff", "85")
BR = {"b_area": 12.0}


def t2_jobs(n):
    return [("d2", (f"T2 {'prior' if p else 'fijo'} tt 27 S A1 BT", tt, "A1", "S", n, p, 10.0, {}, False))
            for p in (True, False)]


def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else "todo"
    t0 = time.time()
    fecha = subprocess.run(["date"], capture_output=True, text=True).stdout.strip()
    if mode == "humo":
        n = int(os.environ.get("NCHIP", "400"))
        res = run_jobs([("t1", ("T1", n, False))] + t2_jobs(n))
        dt = time.time() - t0
        L = [fecha, f"E_B v2 (e_b2.py) HUMO (enmienda 4, A4.6): T1 y T2, NCHIP = {n} por mitad (entrenamiento y prueba aparte), "
             f"fa = 1 kHz, T = 1 s, eta = 1, sal de semillas 'e4'", techo_check(), f"tiempo de pared {dt:.0f} s", ""]
        L.append("## T1"); L += [line_t1(r) for r in res if r["celda"] == "T1"]
        L.append("\n## T2: " + H_D2)
        L += [line_d2(r) for r in res if r["celda"].startswith("T2")]
        t2p = next(r for r in res if r["celda"].startswith("T2 prior"))
        L.append(f"\nCriterio del humo (fijado en el docstring): T2 prior frac >= 0,80 -> {t2p['frac_techo'] >= 0.80} "
                 f"(frac = {f3(t2p['frac_techo'])})")
        L.append("\n## JSON\n" + "\n".join(json.dumps(r) for r in res))
        open(os.path.join(HERE, "humo_eb2.txt"), "w").write("\n".join(L) + "\n")
        print("\n".join(L))
        return
    n = int(os.environ.get("NCHIP", "2000"))
    jobs = [("t1", ("T1", n, False)), ("t1", ("T1b BT", n, True))]
    for corner in CORNERS:
        for v in ("S", "D"):
            jobs.append(("d1", (f"D1 {' '.join(corner)} {v} BT", corner, v, n, {}, False)))
    jobs.append(("d1", ("D1 tt 27 S BR", tt, "S", n, BR, False)))
    jobs += [("d1", ("M1 D1 tt 27 S BT", tt, "S", n, {"amp_scale": 0.0}, False)),
             ("d1", ("M2 D1 tt 27 S BT", tt, "S", n, {}, True)),
             ("d1", ("M3 D1 ff 85 noquant BT", ff85, "S", n, {"quant": False}, False)),
             ("d1", ("M4 D1 tt 27 S BT", tt, "S", n, {"same_traps_in_B": True}, False))]
    for prior in (True, False):
        pz = "prior" if prior else "fijo"
        for corner in CORNERS:
            vs = ("S", "D") if corner == ff85 else ("S",)
            for v in vs:
                for cls in GEOM:
                    jobs.append(("d2", (f"D2 {pz} {' '.join(corner)} {v} {cls} BT", corner, cls, v, n, prior, 3.0, {},
                                        False)))
        for cls in GEOM:
            jobs.append(("d2", (f"D2 {pz} tt 27 S {cls} BR", tt, cls, "S", n, prior, 3.0, BR, False)))
        for b, kw in (("BT", {}), ("BR", BR)):
            for fa_ in (1.5, 2.0, 3.0):
                jobs.append(("d2", (f"D4 {pz} tt 27 S A1 f={fa_} {b}", tt, "A1", "S", n, prior, fa_, kw, False)))
    jobs += t2_jobs(n)
    jobs += [("d2", ("M1 D2 prior tt 27 S A1 BT", tt, "A1", "S", n, True, 3.0, {"amp_scale": 0.0}, False)),
             ("d2", ("M2 D2 prior tt 27 S A1 BT", tt, "A1", "S", n, True, 3.0, {}, True)),
             ("d2", ("M3 D2 prior ff 85 noquant A1 BT", ff85, "A1", "S", n, True, 3.0, {"quant": False}, False))]
    jobs.sort(key=lambda j: 0 if j[0] == "d2" else 1)
    res = run_jobs(jobs)
    dt = time.time() - t0
    json.dump({"fecha": fecha, "nchip_por_mitad": n, "tiempo_s": dt, "sal": "e4", "celdas": res},
              open(os.path.join(HERE, "eb2.json"), "w"), indent=1)
    R = {r["celda"]: r for r in res}
    L = [fecha, f"E_B v2 (e_b2.py), NCHIP = {n} por mitad (entrenamiento y prueba aparte), fa = 1 kHz, T = 1 s, eta = 1, "
         f"sal de semillas 'e4'", techo_check(), f"tiempo de pared {dt:.0f} s",
         "BT = B gemelo C0 (b_area = 1); BR = B referencia 2x6 (b_area = 12). prior = lambda0 log-uniforme [0,1, 10] por chip; "
         "fijo = lambda0 nominal.", ""]
    L.append("## Testigo T1 (T1b sin criterio)")
    L += [line_t1(R[k]) for k in ("T1", "T1b BT")]
    L.append("\n## Testigo T2 (criterio: frac >= 0,80, juzgado en prior): " + H_D2)
    L += [line_d2(r) for r in res if r["celda"].startswith("T2")]
    L.append("\n## D1 (PD1, PD2) y mutantes de D1: " + H_D1)
    L += [line_d1(r) for r in res if r["celda"].startswith(("D1", "M1 D1", "M2 D1", "M3 D1", "M4 D1"))]
    bt, br = R["D1 tt 27 S BT"], R["D1 tt 27 S BR"]
    L.append("\n## PD6: D1 tt 27 S, falsos positivos (truth0==0) con BT y con BR")
    L.append(f"PD6 fp BT {f3(bt['fp'])} {ic(bt, 'fp_ic')} | fp BR {f3(br['fp'])} {ic(br, 'fp_ic')} | "
             f"cociente BR/BT {f3(br['fp'] / bt['fp']) if bt['fp'] > 0 else 'nan'} | BR/BT <= 0,5: "
             f"{(br['fp'] <= 0.5 * bt['fp'])}")
    L.append("\n## D2 (PD3-PD5), BT y BR, y mutantes de D2: " + H_D2)
    L += [line_d2(r) for r in res if r["celda"].startswith(("D2", "M1 D2", "M2 D2", "M3 D2"))]
    L.append("\n## D4 (PD7, PD8): D2 A1, R = 16, tt 27 S, f frente a 1: " + H_D2)
    L += [line_d2(r) for r in res if r["celda"].startswith("D4")]
    L.append("\nM5 es un mutante de E_A v3; E_B no lo corre.")
    open(os.path.join(HERE, "eb2.txt"), "w").write("\n".join(L) + "\n")
    print("\n".join(L))


if __name__ == "__main__":
    main()
