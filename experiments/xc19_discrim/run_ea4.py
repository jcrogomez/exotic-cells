"""Estimador E_A v3 (enmienda 4, sellada 2026-11-24 09:50:32) y sus veredictos. Salida: ea4.txt y ea4.json (humo: humo_ea4.txt).

E_A v3 (A4.1-A4.3):
  - detector de saltos: d[i] = media(y[i..i+w)) - media(y[i-w..i)), w = 5; salto donde |d| > 0,5 u_c (u_c = s_c t_c 50 MHz,
    la unidad de la esquina en cuentas), con supresion de no maximos en 2w. J = saltos por fila
  - D1: detectado si J >= 2
  - D2: por chip Z = (log(1 + J_0), log(1 + J_k)); regresion logistica (L2 = 1) entrenada en chips de entrenamiento y evaluada en
    chips de prueba con otra semilla; bits = I(H; H_est) de la matriz de confusion de prueba, IC 95 % por 1000 remuestreos
Variantes de B: BT (gemelo C0, b_area = 1) y BR (referencia 2x6, b_area = 12). Semillas: sd('e4', ...) (A4.7).
Uso: python run_ea4.py            (todo, NCHIP = 2000)
     HUMO=1 python run_ea4.py     (A4.6: solo T1 y T2 con 400 chips; si T2 < 0,80 del techo, se para)
"""
import json, math, os, sys, time, zlib
from multiprocessing import Pool
import numpy as np
import sim
from run_ea import mi_bits, mi_ci, poisson_bits, leg_area

HERE = os.path.dirname(os.path.abspath(__file__))
FA, T = 1e3, 1.0
HUMO = os.environ.get("HUMO") == "1"
NCHIP = 400 if HUMO else int(os.environ.get("NCHIP", 2000))
W, KTH = 5, 0.5
sd = lambda *k: zlib.crc32(repr(("e4",) + k).encode()) % 100000


def unit(corner):
    tc, sc = sim.CP[corner]
    return sc * tc * sim.FCLK


def saltos(Y, u, kth=KTH, w=W):
    """J por fila (A4.1)."""
    Y = np.asarray(Y, float); nd, n = Y.shape
    c = np.concatenate([np.zeros((nd, 1)), np.cumsum(Y, 1)], 1)
    m = (c[:, w:] - c[:, :-w]) / w                          # m[:, i] = media de y[i..i+w)
    d = np.zeros((nd, n)); d[:, w:n - w + 1] = m[:, w:] - m[:, :n - 2 * w + 1]
    a = np.abs(d); thr = kth * u; out = np.zeros(nd, int)
    for r in range(nd):
        idx = np.flatnonzero(a[r] > thr)
        last = None
        for i in idx:
            if last is None or i - last >= 2 * w:
                out[r] += 1; last = i
            elif a[r, i] > a[r, last]:
                last = i
    return out


def logit_fit(X, h, l2=1.0, it=100):
    X = np.column_stack([np.ones(len(X)), X]); wv = np.zeros(X.shape[1])
    for _ in range(it):
        p = 1 / (1 + np.exp(-X @ wv))
        g = X.T @ (p - h) + l2 * np.r_[0, wv[1:]]
        Hm = (X * (p * (1 - p))[:, None]).T @ X + l2 * np.diag(np.r_[0, np.ones(len(wv) - 1)])
        step = np.linalg.solve(Hm, g); wv -= step
        if np.abs(step).max() < 1e-8: break
    return wv


def logit_pred(wv, X):
    X = np.column_stack([np.ones(len(X)), X]); return (X @ wv > 0).astype(int)


def d1(seed, corner, variant, n, kth=KTH, **kw):
    rng = np.random.default_rng(seed)
    Y, tr, tk = sim.simulate(rng, corner, "A1", 1.0, 1, FA, T, variant, n, **kw)
    J = saltos(Y, unit(corner), kth)
    det = J >= 2; has = tr[:, 0] > 0; vis = tr[:, 1] > 0
    I, lo, hi = mi_ci(has.astype(int), det.astype(int), np.random.default_rng(seed + 5))
    return dict(det_vis=float(det[vis].mean()) if vis.any() else None, fp=float(det[~has].mean()) if (~has).any() else None,
                n_vis=int(vis.sum()), n_none=int((~has).sum()), bits=I, lo=lo, hi=hi, h=has.astype(int), e=det.astype(int))


def d2(seed, corner, cls, variant, fhi=3.0, n=None, kth=KTH, **kw):
    n = n or NCHIP
    A = round(sim.GEOM[cls][0] * sim.GEOM[cls][1] / (0.42 * 0.15)); R = 16 // A; u = unit(corner)
    Z = {}
    for part, s in (("train", seed), ("test", seed + 7919)):
        rng = np.random.default_rng(s)
        H = rng.integers(0, 2, n); z = np.zeros((n, 2))
        for i in range(n):
            Y0, _, _ = sim.simulate(rng, corner, "A1", 1.0, 1, FA, T, variant, 16, **kw)
            YA, _, tk = sim.simulate(rng, corner, cls, fhi if H[i] else 1.0, 1, FA, T, variant, R, **kw)
            if YA is None:
                return dict(status="no adquirible", tk=tk)
            z[i] = (math.log1p(saltos(Y0, u, kth).sum()), math.log1p(saltos(YA, u, kth).sum()))
        Z[part] = (H, z)
    wv = logit_fit(Z["train"][1], Z["train"][0])
    Ht, zt = Z["test"]; est = logit_pred(wv, zt)
    lam = sim.NB[(corner[0], corner[1], FA, T, 1)] * A * R
    ceil = poisson_bits(lam, fhi * lam)
    I, lo, hi = mi_ci(Ht, est, np.random.default_rng(seed + 1))
    return dict(status="ok", A=A, R=R, bits=I, lo=lo, hi=hi, ceil=ceil, frac=I / ceil, area=R * leg_area(cls),
                bits_um2=I / (R * leg_area(cls)), w=wv.tolist())


def t1(n):
    rng = np.random.default_rng(sd("T1"))
    tc, sc = sim.CP[("tt", "27")]; N = int(FA * T); Ys, Yn = [], []
    for i in range(n):
        dV = sim.telegraph(rng, [1e-3], [sim.TRAP], N, 1 / FA)
        for lst, v in ((Ys, dV), (Yn, 0 * dV)):
            b = rng.normal(0, sim.SIGB, N)
            tA = tc * (1 + sc * (v + b) / sim.TRAP) * (1 + rng.normal(0, sim.EPS, N))
            tB = tc * (1 + sc * (0.95 * b) / sim.TRAP) * (1 + rng.normal(0, sim.EPS, N))
            lst.append(np.floor(tA * sim.FCLK + rng.random()) - np.floor(tB * sim.FCLK + rng.random()))
    u = unit(("tt", "27"))
    return float((saltos(np.array(Ys), u) >= 2).mean()), float((saltos(np.array(Yn), u) >= 2).mean())


def job(j):
    kind, args, kw = j
    if kind == "d1":
        r = d1(*args, **kw); r.pop("h"); r.pop("e"); return j, r
    return j, d2(*args, **kw)


def fmt_d2(name, r):
    if r["status"] != "ok":
        return f"{name}: {r['status']} (t_k = {r['tk']*1e6:.1f} us)"
    return (f"{name} (A={r['A']}, R={r['R']}): I = {r['bits']:.4f} [{r['lo']:.4f}, {r['hi']:.4f}], techo {r['ceil']:.4f}, "
            f"fraccion {r['frac']:.3f}, area {r['area']:.1f} um^2, {1000*r['bits_um2']:.3f} mbit/um^2")


if __name__ == "__main__":
    t0 = time.time(); out = []; p = out.append; R = {}
    p(f"# E_A v3 · {time.strftime('%Y-%m-%d %H:%M:%S %Z')} · fa = 1 kHz, T = 1 s, NCHIP = {NCHIP}{' (HUMO)' if HUMO else ''}")
    a, b = t1(NCHIP)
    p(f"T1: deteccion {a:.4f} (>= 0,95 -> {'pasa' if a >= 0.95 else 'FALLA'}), falsos {b:.4f} (<= 0,01 -> {'pasa' if b <= 0.01 else 'FALLA'})")
    R["T1"] = (a, b)
    tt = ("tt", "27")
    r = d2(sd("T2"), tt, "A1", "S", fhi=10.0)
    p(fmt_d2("T2 (f = 10 frente a 1, A1, R = 16, tt, BT)", r) + f" (>= 0,80 -> {'pasa' if r['frac'] >= 0.80 else 'FALLA'})")
    R["T2"] = {k: v for k, v in r.items() if k != "w"}
    if HUMO:
        p(f"(humo: {time.time()-t0:.0f} s)")
        open(os.path.join(HERE, "humo_ea4.txt"), "w").write("\n".join(out) + "\n"); print("\n".join(out)); sys.exit()
    if r["frac"] < 0.80:
        p("T2 FALLA en la corrida completa: se para (A4.6)"); open(os.path.join(HERE, "ea4.txt"), "w").write("\n".join(out) + "\n")
        print("\n".join(out)); sys.exit()
    J = []
    for corner in sim.CORNERS:
        for var in ("S", "D"):
            J.append(("d1", (sd("D1", corner, var), corner, var, NCHIP), {}))
    J.append(("d1", (sd("D1", tt, "S", "BR"), tt, "S", NCHIP), {"b_area": 12}))          # PD6
    J.append(("d1", (sd("M1"), tt, "S", NCHIP), {"amp_scale": 0.0}))
    J.append(("d1", (sd("M4"), tt, "S", NCHIP), {}))
    J.append(("d1", (sd("M4"), tt, "S", NCHIP), {"same_traps_in_B": True}))
    J.append(("d1", (sd("M3"), ("ff", "85"), "S", NCHIP), {"quant": False}))
    J.append(("d1", (sd("M5"), tt, "S", NCHIP), {"kth": KTH * 100}))
    for corner in sim.CORNERS:
        for var in (("S", "D") if corner == ("ff", "85") else ("S",)):
            for cls in ("A1", "A2", "A4", "A8"):
                J.append(("d2", (sd("D2", corner, var, cls), corner, cls, var), {}))
    for cls in ("A1", "A2", "A4", "A8"):
        J.append(("d2", (sd("D2", tt, "S", cls, "BR"), tt, cls, "S"), {"b_area": 12}))
    for f in (1.5, 2.0, 3.0):
        for ba in (1, 12):
            J.append(("d2", (sd("D4", f, ba), tt, "A1", "S"), {"fhi": f, "b_area": ba}))
    J.append(("d2", (sd("M1D2"), tt, "A1", "S"), {"amp_scale": 0.0}))
    J.append(("d2", (sd("M5D2"), tt, "A1", "S"), {"kth": KTH * 100}))
    with Pool(int(os.environ.get("NPROC", 4))) as pool:
        res = pool.map(job, J, chunksize=1)
    for (kind, args, kw), r in res:
        key = f"{kind} {args[1][0]} {args[1][1]} " + (f"{args[2]}" if kind == "d1" else f"{args[3]} {args[2]}") + (f" {kw}" if kw else "")
        R[key] = r
        if kind == "d1":
            p(f"{key}: deteccion (permanencia >= 10) {r['det_vis']} de {r['n_vis']}, falsos {r['fp']} de {r['n_none']}, "
              f"I = {r['bits']:.4f} [{r['lo']:.4f}, {r['hi']:.4f}] bits")
        else:
            p(fmt_d2(key, r))
    p(f"(total {time.time()-t0:.0f} s)")
    open(os.path.join(HERE, "ea4.txt"), "w").write("\n".join(out) + "\n")
    json.dump(R, open(os.path.join(HERE, "ea4.json"), "w"), indent=1, default=float)
    print("\n".join(out))
