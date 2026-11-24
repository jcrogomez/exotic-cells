"""Estimador E_A (autor) y veredictos de PD1-PD5, T1, T2, M1-M4 (prerregistro + enmiendas 1 y 2). Salida: ea.txt y ea.json.

E_A, fijado antes de correr las celdas que deciden:
  - sigma de la serie = MAD(diferencias primeras) / (0,6745*sqrt(2))
  - media movil de w = 5 conversiones; paso en n si |m(n..n+w) - m(n-w..n)| > 5 sigma / sqrt(w/2), con supresion de no maximos
    a +-w; trampa "detectada" si hay >= 2 pasos de signo opuesto (sube y baja: dos niveles)
  - D2: por chip, (k0 = detecciones en las 16 patas C0, kA = detecciones en las R patas de la clase); P(f = 3 | k0, kA) se
    aprende en chips de entrenamiento (semilla propia) y se evalua en chips de prueba con otra semilla.
Bits = I(H; H_est) de la matriz de confusion de prueba; IC 95 % por 1000 remuestreos (A4 de la enmienda 1).
Area por pata (para PD5, supuesto declarado): (W + 1,2)(L + 1,5) + (0,84 + 1,2)(0,15 + 1,5) um^2 (DUT + interruptor, con
margen de contacto y separacion); es aritmetica de huella, no un dibujo.
"""
import json, math, os, sys, time, zlib
import numpy as np
import sim

HERE = os.path.dirname(os.path.abspath(__file__))
FA, T = 1e3, 1.0
NCHIP = int(os.environ.get("NCHIP", 2000))
ONLY_T1 = os.environ.get("ONLY_T1") == "1"   # prueba de humo: solo el testigo T1 y el tiempo
sd = lambda *k: zlib.crc32(repr(k).encode()) % 100000


def detect(Y):
    """Devuelve un booleano por fila: >= 2 pasos de signo opuesto."""
    w = 5
    out = np.zeros(len(Y), bool)
    for i, y in enumerate(Y):
        y = y.astype(float)
        d = np.diff(y)
        sg = np.median(np.abs(d - np.median(d))) / (0.6745 * math.sqrt(2))
        if sg == 0:
            sg = np.std(d) / math.sqrt(2) or 0.5
        cs = np.concatenate([[0], np.cumsum(y)])
        n = len(y)
        idx = np.arange(w, n - w)
        m1 = (cs[idx + w] - cs[idx]) / w; m0 = (cs[idx] - cs[idx - w]) / w
        st = m1 - m0
        thr = 5 * sg / math.sqrt(w / 2)
        cand = np.where(np.abs(st) > thr)[0]
        steps = []
        for j in cand:
            if steps and j - steps[-1][0] <= w:
                if abs(st[j]) > abs(steps[-1][1]):
                    steps[-1] = (j, st[j])
                continue
            steps.append((j, st[j]))
        s = [np.sign(v) for _, v in steps]
        out[i] = len(s) >= 2 and (1 in s) and (-1 in s)
    return out


def mi_bits(h, e):
    h = np.asarray(h, int); e = np.asarray(e, int)
    I = 0.0; n = len(h)
    for a in (0, 1):
        for b in (0, 1):
            pab = np.mean((h == a) & (e == b))
            if pab > 0:
                I += pab * math.log2(pab / (np.mean(h == a) * np.mean(e == b)))
    return I


def mi_ci(h, e, rng, nb=1000):
    h = np.asarray(h); e = np.asarray(e); n = len(h)
    v = [mi_bits(h[ix], e[ix]) for ix in (rng.integers(0, n, n) for _ in range(nb))]
    return mi_bits(h, e), np.percentile(v, 2.5), np.percentile(v, 97.5)


def poisson_bits(l1, l3):
    nmax = int(l3 + 12 * math.sqrt(l3) + 30); I = 0.0; a = -l1; b = -l3
    for n in range(nmax + 1):
        if n:
            a += math.log(l1) - math.log(n); b += math.log(l3) - math.log(n)
        p1, p3 = math.exp(a), math.exp(b); pm = 0.5 * (p1 + p3)
        if p1 > 0: I += 0.5 * p1 * math.log2(p1 / pm)
        if p3 > 0: I += 0.5 * p3 * math.log2(p3 / pm)
    return I


def leg_area(cls):
    W, L = sim.GEOM[cls]
    return (W + 1.2) * (L + 1.5) + (0.84 + 1.2) * (0.15 + 1.5)


def d1(rng, corner, variant, n, **kw):
    Y, tr, tk = sim.simulate(rng, corner, "A1", 1.0, 1, FA, T, variant, n, **kw)
    det = detect(Y)
    has = tr[:, 0] > 0; vis = tr[:, 1] > 0
    return dict(det_vis=float(det[vis].mean()) if vis.any() else None, fp=float(det[~has].mean()),
                n_vis=int(vis.sum()), n_none=int((~has).sum()), h=has.astype(int), e=det.astype(int))


def d2(seed, corner, cls, variant, fhi=3.0, n=NCHIP, **kw):
    """Chips con 16 patas C0 y R = 16/A patas de la clase. Mitad f = 1, mitad f = fhi. Entrena y prueba con semillas distintas."""
    A = round(sim.GEOM[cls][0] * sim.GEOM[cls][1] / (0.42 * 0.15))
    R = 16 // A
    feats = {}
    for part, sd in (("train", seed), ("test", seed + 7919)):
        rng = np.random.default_rng(sd)
        H = rng.integers(0, 2, n)
        k0 = np.zeros(n, int); kA = np.zeros(n, int)
        for i in range(n):
            Y0, _, _ = sim.simulate(rng, corner, "A1", 1.0, 1, FA, T, variant, 16, **kw)
            YA, _, tk = sim.simulate(rng, corner, cls, fhi if H[i] else 1.0, 1, FA, T, variant, R, **kw)
            if YA is None:
                return dict(status="no adquirible", tk=tk)
            k0[i] = detect(Y0).sum(); kA[i] = detect(YA).sum()
        feats[part] = (H, k0, kA)
    H, k0, kA = feats["train"]
    tab = {}
    for a, b, h in zip(k0, kA, H):
        tab.setdefault((min(a, 8), b), []).append(h)
    Ht, k0t, kAt = feats["test"]
    est = np.array([int(np.mean(tab.get((min(a, 8), b), [0.5])) > 0.5) for a, b in zip(k0t, kAt)])
    lam = sim.NB[(corner[0], corner[1], FA, T, 1)] * A * R
    ceil = poisson_bits(lam, fhi * lam)
    rng = np.random.default_rng(seed + 1)
    I, lo, hi = mi_ci(Ht, est, rng)
    return dict(status="ok", A=A, R=R, bits=I, lo=lo, hi=hi, ceil=ceil, frac=I / ceil, area=R * leg_area(cls),
                bits_um2=I / (R * leg_area(cls)), H=Ht.tolist(), est=est.tolist())


if __name__ == "__main__":
    t0 = time.time(); R = {}; out = []; p = out.append
    p(f"# E_A · {time.strftime('%Y-%m-%d %H:%M:%S %Z')} · fa = 1 kHz, T = 1 s, NCHIP = {NCHIP}")
    # T1: una trampa de 0,305 mV, tau = 1 ms, tt, A1
    rng = np.random.default_rng(11)
    tc, sc = sim.CP[("tt", "27")]
    N = int(FA * T); Ys = []; Yn = []
    for i in range(NCHIP):
        dV = sim.telegraph(rng, [1e-3], [sim.TRAP], N, 1 / FA)
        for lst, v in ((Ys, dV), (Yn, 0 * dV)):
            b = rng.normal(0, sim.SIGB, N)
            tA = tc * (1 + sc * (v + b) / sim.TRAP) * (1 + rng.normal(0, sim.EPS, N))
            tB = tc * (1 + sc * (0.95 * b) / sim.TRAP) * (1 + rng.normal(0, sim.EPS, N))
            lst.append(np.floor(tA * sim.FCLK + rng.random()) - np.floor(tB * sim.FCLK + rng.random()))
    t1d, t1f = detect(np.array(Ys)).mean(), detect(np.array(Yn)).mean()
    p(f"T1: deteccion {t1d:.4f} (>= 0,95 -> {'pasa' if t1d >= 0.95 else 'FALLA'}), falsos {t1f:.4f} (<= 0,01 -> {'pasa' if t1f <= 0.01 else 'FALLA'})")
    R["T1"] = (t1d, t1f)
    if ONLY_T1:
        print("\n".join(out)); print(f"tiempo T1 con {NCHIP} dispositivos: {time.time()-t0:.1f} s"); sys.exit()
    # PD1, PD2 (D1)
    for corner in sim.CORNERS:
        for var in ("S", "D"):
            r = d1(np.random.default_rng(sd('D1', corner, var)), corner, var, NCHIP)
            I, lo, hi = mi_ci(r["h"], r["e"], np.random.default_rng(5))
            R[("D1", corner, var)] = dict(det_vis=r["det_vis"], fp=r["fp"], bits=I, lo=lo, hi=hi)
            p(f"D1 {corner[0]} {corner[1]} {var}: deteccion (permanencia >= 10) {r['det_vis']:.3f} de {r['n_vis']}, "
              f"falsos {r['fp']:.4f} de {r['n_none']}, I = {I:.4f} [{lo:.4f}, {hi:.4f}] bits")
    # M1, M4 (D1, tt)
    r = d1(np.random.default_rng(31), ("tt", "27"), "S", NCHIP, amp_scale=0.0)
    p(f"M1 D1 (amplitudes x0): I = {mi_bits(r['h'], r['e']):.4f} bits (<= 0,02)")
    R["M1_D1"] = mi_bits(r["h"], r["e"])
    rr = d1(np.random.default_rng(32), ("tt", "27"), "S", NCHIP)
    rm = d1(np.random.default_rng(32), ("tt", "27"), "S", NCHIP, same_traps_in_B=True)
    p(f"M4 (mismas trampas en B): deteccion {rm['det_vis']:.3f} frente a {rr['det_vis']:.3f} sano (debe caer)")
    R["M4"] = (rm["det_vis"], rr["det_vis"])
    # M2: etiquetas barajadas sobre D1 tt S
    h = rr["h"].copy(); np.random.default_rng(33).shuffle(h)
    p(f"M2 (etiquetas barajadas): I = {mi_bits(h, rr['e']):.4f} bits (<= 0,02)")
    R["M2"] = mi_bits(h, rr["e"])
    # M3: ff 85 sin cuantizacion frente a S
    r3 = d1(np.random.default_rng(34), ("ff", "85"), "S", NCHIP, quant=False)
    p(f"M3 (ff 85 sin cuantizacion): deteccion {r3['det_vis']:.3f}, I = {mi_bits(r3['h'], r3['e']):.4f} bits "
      f"frente a S {R[('D1', ('ff', '85'), 'S')]['bits']:.4f} (debe subir)")
    R["M3"] = mi_bits(r3["h"], r3["e"])
    p(f"(D1 terminado en {time.time()-t0:.0f} s)")
    # D2: PD3-PD5, T2, M1 D2
    for corner in sim.CORNERS:
        for var in (("S", "D") if corner == ("ff", "85") else ("S",)):
            for cls in ("A1", "A2", "A4", "A8"):
                r = d2(sd('D2', corner, var, cls), corner, cls, var)
                R[("D2", corner, var, cls)] = {k: v for k, v in r.items() if k not in ("H", "est")}
                if r["status"] != "ok":
                    p(f"D2 {corner[0]} {corner[1]} {var} {cls}: {r['status']} (t_k = {r['tk']*1e6:.1f} us)"); continue
                p(f"D2 {corner[0]} {corner[1]} {var} {cls} (A={r['A']}, R={r['R']}): I = {r['bits']:.4f} [{r['lo']:.4f}, {r['hi']:.4f}], "
                  f"techo {r['ceil']:.4f}, fraccion {r['frac']:.3f}, area {r['area']:.1f} um^2, {1000*r['bits_um2']:.3f} mbit/um^2")
    r = d2(4242, ("tt", "27"), "A1", "S", fhi=10.0)
    p(f"T2 (f = 10 frente a 1, A1, R = 16, tt): I = {r['bits']:.4f}, techo {r['ceil']:.4f}, fraccion {r['frac']:.3f} (>= 0,80)")
    R["T2"] = (r["bits"], r["ceil"])
    r = d2(4343, ("tt", "27"), "A1", "S", amp_scale=0.0)
    p(f"M1 D2 (amplitudes x0): I = {r['bits']:.4f} bits (<= 0,02)")
    R["M1_D2"] = r["bits"]
    p(f"(total {time.time()-t0:.0f} s)")
    open(os.path.join(HERE, "ea.txt"), "w").write("\n".join(out) + "\n")
    json.dump({str(k): v for k, v in R.items()}, open(os.path.join(HERE, "ea.json"), "w"), indent=1, default=float)
    print("\n".join(out))
