"""MISFIT-28: la UNIDAD del lector 2 (bloque + reader2fe, ensamblados) extraida plana de su GDS, con la matriz xc20w.
Como gen26 (misfit26), pero la parte analogica ya va dentro de la extraccion, y la medida se corrige:
  - tiempos con 12 cifras (en MISFIT-26, con 6, xa y su flanco salian empatados a corrientes bajas);
  - cada flanco de q se mide a 0,3, 0,9 y 1,5 V: un pulso a medias (el fallo de MISFIT-26) separa las tres cuentas.
q y qb se localizan por los alias de la extraccion (lineas 'equiv' del .ext), no por nombre fijo.
Uso como modulo: deck(pex, ext, c, t, rng, caso, i, ...). Imprime con 'print' (12 cifras): ed<n> (0,9 V), el<n> (0,3), eh<n> (1,5), ek<n>, txa, txb, qidle, xidle, xmin."""
import os, re, importlib.util
H = os.path.dirname(os.path.abspath(__file__))
_sp = importlib.util.spec_from_file_location("gen24", os.path.join(H, "..", "misfit24", "gen24.py")); g24 = importlib.util.module_from_spec(_sp); _sp.loader.exec_module(g24)
G = g24.G; CASOS = g24.CASOS; QEST = g24.QEST; ESTIRA = {"bajo": 1.5, "alto": 1.1}
LOOP = ("Xo_ie", "Xo_ir", "Xo_gl", "Xo_gh", "Xo_cmp", "Xo_s1", "Xo_s2", "Xo_q", "Xo_qb") + tuple(f"Xo_d{k}" for k in range(8))
PORT = {"VGND": "0", "VPWR": "vdd", "en": "en", "pre": "pre", "src[0]": "s0", "src[1]": "s1", "x": "o_x", "xa": "xa", "xb": "xb"}
san = lambda n: PORT[n] if n in PORT else "b_" + re.sub(r"[^A-Za-z0-9_]", "_", n)
P0 = "reader2_slot_0."


def alias(ext):
    """nombre -> nombre que usa el SPICE (el primero de su linea 'equiv')."""
    a = {}
    for l in open(ext):
        if l.startswith("equiv "):
            n = re.findall(r'"([^"]+)"', l); a[n[1]] = n[0]
    def can(n):
        while n in a: n = a[n]
        return n
    return can


def unidad(pex):
    txt = open(pex).read().replace("\n+", " ").splitlines(); i = next(k for k, l in enumerate(txt) if l.startswith(".subckt r2uflat ")); out = []
    assert txt[i].split()[2:] == ["x", "VPWR", "VGND", "en", "pre", "src[0]", "src[1]", "xa", "xb"], txt[i]
    for l in txt[i + 1:]:
        f = l.split()
        if not f: continue
        if f[0] == ".ends": break
        if f[0][0] == "X":
            k = next(j for j, x in enumerate(f) if x.startswith("sky130_")); out.append("Xb" + f[0][1:] + " " + " ".join(san(x) for x in f[1:k]) + " " + " ".join(f[k:]))
        elif f[0][0] == "C": out.append("Cb" + f[0][1:] + f" {san(f[1])} {san(f[2])} {f[3]}")
        else: raise ValueError(l)
    return out


def deck(pex, ext, c, t, rng, caso, i, extra=(), nq=18, largo=None, kedges=(), seed=None):
    s = g24.deck(c, t, rng, caso, i).splitlines()
    if seed is not None:
        assert s[1].endswith(f"sky130.lib.spice {c}"); s[1] += "_mm"; j = s.index("set noaskquit"); s[j + 1:j + 1] = [f"setseed {seed}", "reset"]
    k = [j for j, l in enumerate(s) if l.split() and (l.split()[0] in LOOP or l.split()[0] in ("Ven", "Vrs") or l[:2] in ("Xf", "Cf"))]
    assert sum(1 for j in k if s[j][:2] == "Xf") == 9 and sum(1 for j in k if s[j].split()[0] in LOOP) == 17, len(k)
    s = [l for j, l in enumerate(s) if j not in k]; can = alias(ext); body = unidad(pex); nodes = {x for l in body for x in l.split()[1:5]}
    q, qb = san(can(P0 + "u_loop.u_q.Y")), san(can(P0 + "u_loop.u_qb.Y")); assert q in nodes and qb in nodes and q != qb, (q, qb)
    T = QEST[rng] / i + 4e-9 if i else None; t0 = min(3 * T, 2e-6) if i else 2e-6
    j = s.index("Vd vdd 0 1.8")
    s[j + 1:j + 1] = [f"Ven en 0 pwl(0 0 {t0:.4e} 0 {t0 + 1e-9:.4e} 1.8)", "Vpre pre 0 0",
                      f"Vs0 s0 0 {1.8 if rng == 'bajo' else 0}", f"Vs1 s1 0 {0 if rng == 'bajo' else 1.8}"] + body + list(extra)
    s[0] = f"* MISFIT-28: unidad del lector 2 extraida, rango {rng}, caso {caso}, I = {i:.4e} A, {c} {t} C"
    j = next(j for j, l in enumerate(s) if l.startswith(".ic ")); s[j] += f" v({q})=0 v({qb})=1.8"
    j = next(j for j, l in enumerate(s) if l.startswith("save ")); s[j] = f"save v({q}) v({qb}) v(o_x) v(xa) v(xb) i(vd)"
    j = next(j for j, l in enumerate(s) if l.startswith("tran ")); f = s[j].split()
    if i: te = t0 + (largo or (nq + 12)) * T * ESTIRA[rng]; s[j] = f"tran {f[1]} {te:.4e} 0 {f[4]}"
    a = j + 1; b = s.index("quit"); ex = ["set numdgt=12", f"echo T0 {t0:.6e}"]
    for n in range(1, nq + 1):
        for tag, th in (("ED", 0.9), ("EL", 0.3), ("EH", 1.5)): ex += [f"meas tran {tag.lower()}{n} when v({q})={th} rise={n}", f"print {tag.lower()}{n}"]
    for e in kedges: ex += [f"meas tran ek{e} when v({q})=0.9 rise={e}", f"print ek{e}"]
    ex += ["meas tran txa when v(xa)=0.9 rise=1", "print txa", "meas tran txb when v(xb)=0.9 rise=1", "print txb",
           f"meas tran qidle max v({q}) from=0 to={t0:.4e}", "print qidle", f"meas tran xidle min v(o_x) from=0 to={t0:.4e}", "print xidle",
           f"meas tran xmin min v(o_x) from={t0:.4e} to={te if i else 2e-2:.4e}", "print xmin"]
    s[a:b] = ex
    return "\n".join(s) + "\n"


PEX = os.path.join(H, "ext", "r2uflat.pex.spice"); EXT = os.path.join(H, "ext", "r2uflat.ext")
BAJO_EXTRA = (3.1623e-11, 5.6234e-11, 1.7783e-10, 5.6234e-10)      # por debajo y dentro de la decada baja: rampas mas lentas
CAL = lambda rng: [(k, i) for k, i in CASOS[rng] if k in ("cal", "oos")]
MEDIDAS = ("set numdgt=12",)


def lista():
    L = []
    for c, t in G.CORN:
        for rng in G.LP: L += [("a", c, t, rng, k, i, {}) for k, i in CAL(rng)]                                    # 48
        L += [("lento", c, t, "bajo", "oos", i, {}) for i in BAJO_EXTRA]                                            # 16
    for c, t in (("ff", "85"), ("ff", "-40")):
        for seed in range(1, 6): L += [("mm", c, t, "bajo", "oos" if i > 2e-10 else "cal", i, {"seed": seed}) for i in (1e-10, 3.1623e-10)]   # 20
    L += [("zero", "ff", "85", rng, "zero", 0.0, {}) for rng in G.LP]                                               # 2
    L += [("largo", c, t, "alto", "cal", 1e-5, {"nq": 12, "largo": 520, "kedges": (255, 256, 257)}) for c, t in (("tt", "27"), ("ss", "85"))]   # 2
    return L


def nombre(grp, c, t, rng, k, i, kw): return os.path.join(H, grp, f"{rng}_{c}{t}_{k}_{i:.4e}" + (f"_s{kw['seed']}" if "seed" in kw else ""))


def testigo(name):
    """Deck de MISFIT-26 (bloque sin histeresis) con la medida nueva: el detector tiene que ver el fallo conocido."""
    s = open(os.path.join(H, "..", "misfit26", "d", name, "lec.sp")).read().splitlines() if os.path.exists(os.path.join(H, "..", "misfit26", "d", name, "lec.sp")) else None
    if s is None:
        import importlib.util as iu
        sp = iu.spec_from_file_location("gen26", os.path.join(H, "..", "misfit26", "gen26.py")); g26 = iu.module_from_spec(sp); sp.loader.exec_module(g26)
        _, rng, ct, k, i = name.split("_"); c, t = re.match(r"([a-z]+)(-?\d+)", ct).groups(); s = g26.deck("m", c, t, rng, k, float(i)).splitlines()
    q = "b_u_loop_u_d0_A"; a = next(j for j, l in enumerate(s) if l.startswith("tran ")) + 1; b = s.index("quit"); ex = ["set numdgt=12"]
    for n in range(1, 19):
        for tag, th in (("ed", 0.9), ("el", 0.3), ("eh", 1.5)): ex += [f"meas tran {tag}{n} when v({q})={th} rise={n}", f"print {tag}{n}"]
    ex += ["meas tran txa when v(xa)=0.9 rise=1", "print txa", "meas tran txb when v(xb)=0.9 rise=1", "print txb"]
    s[a:b] = ex; return "\n".join(s) + "\n"


TESTIGOS = ("m_bajo_ff85_oos_3.1623e-10", "m_bajo_ff-40_cal_1.0000e-10")
if __name__ == "__main__":
    n = {}
    for grp, c, t, rng, k, i, kw in lista():
        d = nombre(grp, c, t, rng, k, i, kw); os.makedirs(d, exist_ok=True); open(os.path.join(d, "lec.sp"), "w").write(deck(PEX, EXT, c, t, rng, k, i, **kw)); n[grp] = n.get(grp, 0) + 1
    for name in TESTIGOS:
        d = os.path.join(H, "testigo", name); os.makedirs(d, exist_ok=True); open(os.path.join(d, "lec.sp"), "w").write(testigo(name)); n["testigo"] = n.get("testigo", 0) + 1
    print("decks:", n, sum(n.values()))
