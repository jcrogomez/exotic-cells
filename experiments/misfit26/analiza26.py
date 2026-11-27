"""MISFIT-26: veredictos B1..B8. Escrito y sellado antes de la tanda. Uso: analiza26.py > m26.txt
Periodo = media de los diez intervalos entre los flancos 2..12 de q. Modelo T = Q/(I - IL) + td (ajuste de misfit24/analiza24.py)."""
import os, re, statistics
import gen26 as g
H = g.H; G = g.G; bad = []


def lee(grp, lvl, c, t, rng, k, i, d=None):
    f = os.path.join(d or g.nombre(grp, lvl, c, t, rng, k, i), "lec.log"); r = {"e": {}, "k": {}, "fin": "sin log"}
    if not os.path.exists(f): bad.append((grp, lvl, rng, c, t, k, "sin log")); return r
    L = open(f, errors="replace").read().splitlines(); r["fin"] = L[-1].strip() if L else "vacio"
    for l in L:
        x = l.split()
        try:
            if len(x) == 3 and x[0] in ("ED", "EK"): r["e" if x[0] == "ED" else "k"][int(x[1])] = float(x[2])
            if len(x) == 2 and x[0] in ("XA", "XB", "QIDLE", "XIDLE", "T0"): r[x[0]] = float(x[1])
        except ValueError: pass
    if r["fin"] != "salida 0": bad.append((grp, lvl, rng, c, t, k, r["fin"]))
    e = r["e"]; per = [e[n + 1] - e[n] for n in range(2, 12) if n in e and n + 1 in e]
    if len(per) == 10: r["T"] = statistics.mean(per); r["dis"] = statistics.stdev(per) / r["T"] * 100
    return r


def fit(pts):
    (i1, t1), (i2, t2), (i3, t3) = pts
    def gg(il):
        a1, a3 = 1 / (i1 - il), 1 / (i3 - il); q = (t1 - t3) / (a1 - a3); td = t3 - q * a3
        return q / (i2 - il) + td - t2, q, td
    lo, hi = -i1 * 5, i1 * 0.999; flo, fhi = gg(lo)[0], gg(hi)[0]
    if flo * fhi > 0: return None
    for _ in range(200):
        mid = (lo + hi) / 2; fm = gg(mid)[0]
        if flo * fm <= 0: hi = mid
        else: lo, flo = mid, fm
    il = (lo + hi) / 2; _, q, td = gg(il); return q, il, td


def grupo(grp, lvl, c, t, rng, casos):
    R = {(k, i): lee(grp, lvl, c, t, rng, k, i) for k, i in casos}; cal = [(i, R[(k, i)].get("T")) for k, i in casos if k == "cal"]
    return R, (None if len(cal) != 3 or any(x[1] is None for x in cal) else fit(cal))


Q24 = {}; cur = None
for l in open(os.path.join(H, "..", "misfit24", "m24.txt")):
    m = re.match(r"## rango (\w+) · (\w+) (-?\d+)", l)
    if m: cur = m.groups()
    m = re.match(r"\s+ajuste: Q = ([\d.]+) fC", l)
    if m and cur and cur not in Q24: Q24[cur] = float(m.group(1)) * 1e-15
V = {k: [] for k in ("B1", "B2", "B3", "B4", "B5", "CTL")}; QM = {}; QNV = {}; SIN = []
for rng in G.LP:
    for c, t in G.CORN:
        print(f"\n## rango {rng} · {c} {t}"); casos = g.CAL(rng); R, fp = grupo("d", "m", c, t, rng, casos)
        for (k, i), r in R.items():
            V["B1"].append((rng, c, t, k, i, len(r["e"]) == 18 and r["fin"] == "salida 0"))
            V["B5"].append((rng, c, t, k, i, r.get("QIDLE", 9) <= 0.2 and r.get("XIDLE", 0) >= 1.7 and 1 in r["e"] and r["e"][1] > r.get("T0", 9)))
            if rng == "bajo":
                e = r["e"]; ok = all(n in e for n in (4, 5, 16, 17)) and "XA" in r and "XB" in r and e[4] < r["XA"] < e[5] and e[16] < r["XB"] < e[17]
                d = None if not ok else ((r["XB"] - r["XA"]) / (e[16] - e[4]) - 1) * 100; V["B4"].append((rng, c, t, k, i, ok and abs(d) <= 0.1, d))
        if (c, t) in (("tt", "27"), ("ss", "85")):
            Rn, fn = grupo("ctl", "n", c, t, rng, casos)
            if fn: QNV[(rng, c, t)] = fn[0]; dn = (fn[0] / Q24[(rng, c, t)] - 1) * 100; V["CTL"].append((rng, c, t, dn)); print(f"  control (netlist + libreria): Q = {fn[0]*1e15:.2f} fC ({dn:+.2f} % frente a MISFIT-24), IL = {fn[1]*1e12:+.3f} pA, td = {fn[2]*1e9:.2f} ns")
            else: V["CTL"].append((rng, c, t, None)); print("  control: SIN AJUSTE")
        if fp is None: print("  SIN AJUSTE:", [(i, r.get("T")) for (k, i), r in R.items() if k == "cal"]); SIN.append((rng, c, t)); continue
        q, il, td = fp; QM[(rng, c, t)] = q; d24 = (q / Q24[(rng, c, t)] - 1) * 100; V["B3"].append((rng, c, t, d24))
        dn = f", {(q / QNV[(rng, c, t)] - 1) * 100:+.1f} % frente al control" if (rng, c, t) in QNV else ""
        print(f"  extraido: Q = {q*1e15:.2f} fC ({d24:+.1f} % frente a MISFIT-24{dn}), IL = {il*1e12:+.3f} pA, td = {td*1e9:.2f} ns")
        for (k, i), r in R.items():
            if k != "oos": continue
            T = r.get("T"); e = None if T is None else ((q / (T - td) + il) / i - 1) * 100; V["B2"].append((rng, c, t, i, e))
            print(f"  fuera de muestra {i:.3e} A: " + ("sin periodo" if T is None else f"error {e:+.2f} %, dispersion {r['dis']:.2f} %"))
print("\n## testigo: +20 fF en el nodo, rango alto, tt 27"); _, fw = grupo("w20", "m", "tt", "27", "alto", [x for x in g.CASOS["alto"] if x[0] == "cal"])
q0 = QM.get(("alto", "tt", "27")); dw = None if not (fw and q0) else (fw[0] / q0 - 1) * 100; print("  Q:", "sin ajuste" if dw is None else f"{fw[0]*1e15:.2f} fC ({dw:+.2f} %)")
print("\n## reparto: extraccion sin condensadores, tt 27"); DV = {}
for rng in G.LP:
    _, fv = grupo("dev", "v", "tt", "27", rng, [x for x in g.CASOS[rng] if x[0] == "cal"]); qn, qm = QNV.get((rng, "tt", "27")), QM.get((rng, "tt", "27"))
    if fv and qn and qm: DV[rng] = fv[0]; print(f"  {rng}: Q = {fv[0]*1e15:.2f} fC; control {qn*1e15:.2f}, extraido {qm*1e15:.2f}; del cambio total, las difusiones explican {(fv[0] - qn) / (qm - qn) * 100:.0f} %")
    else: print(f"  {rng}: sin ajuste")
print("\n## sin corriente, ff 85"); Z = []
for rng in G.LP:
    r = lee("zero", "m", "ff", "85", rng, "zero", 0.0); Z.append(r["fin"] == "salida 0" and not r["e"]); print(f"  {rng}: {len(r['e'])} flancos, {r['fin']}")
print("\n## contador a ritmo maximo: rango alto, 10 uA"); K = []
for c, t in (("tt", "27"), ("ss", "85")):
    r = lee("largo", "m", c, t, "alto", "cal", 1e-5, d=os.path.join(H, "largo", f"m_alto_{c}{t}")); k = r["k"]
    ok = 256 in k and 257 in k and "XA" in r and k[256] < r["XA"] < k[257] and "XB" not in r; K.append(ok)
    print(f"  {c} {t}: flanco 256 {k.get(256)}, xa {r.get('XA')}, flanco 257 {k.get(257)}, xb {r.get('XB', 'no sube')}, periodo {r.get('T')} -> {'bien' if ok else 'MAL'}")
print("\n## mutante: bloque 'libre' de MISFIT-25, tt 27"); ML = []
for rng in G.LP:
    R, fl = grupo("libre", "l", "tt", "27", rng, [x for x in g.CASOS[rng] if x[0] == "cal"]); qm = QM.get((rng, "tt", "27")); n = sum(1 for r in R.values() if "T" in r)
    d = None if not (fl and qm) else (fl[0] / qm - 1) * 100; ML.append((rng, n, d)); print(f"  {rng}: oscilan {n} de 3; Q " + ("sin ajuste" if d is None else f"{fl[0]*1e15:.2f} fC ({d:+.2f} % frente al bloque protegido)"))
print("\n## Veredictos")
def vd(n, txt, p, ok, tot, show): f = [x for x in p if not ok(x)]; print(f"{n} ({txt}): {'cumplida' if len(p) == tot and not f else 'FALSA'} ({len(p) - len(f)} de {len(p)}, se esperan {tot}); fallan: {[show(x) for x in f]}")
sh = lambda x: tuple(round(y, 3) if isinstance(y, float) and abs(y) > 1e-3 else y for y in x)
vd("B1", "los 48 decks del bloque extraido oscilan: 18 flancos", V["B1"], lambda x: x[5], 48, sh)
vd("B2", "24 fuera de muestra dentro de +-3 % con su propia calibracion", V["B2"], lambda x: x[4] is not None and abs(x[4]) <= 3, 24, sh)
lim = {"bajo": (30, 100), "alto": (2, 15)}
vd("B3", "Q frente a MISFIT-24: bajo +30..+100 %, alto +2..+15 %", V["B3"], lambda x: lim[x[0]][0] <= x[3] <= lim[x[0]][1], 8, sh)
vd("B4", "contador, rango bajo: xa entre los flancos 4 y 5, xb entre 16 y 17, y (xb - xa) = 12 periodos dentro de 0,1 %", V["B4"], lambda x: x[5], 24, sh)
vd("B5", "reposo: q <= 0,2 V y nodo >= 1,7 V antes de EN, primer flanco despues de EN", V["B5"], lambda x: x[5], 48, sh)
print(f"B6 (sin corriente, ff 85: ningun flanco en los dos rangos): {'cumplida' if len(Z) == 2 and all(Z) else 'FALSA'}")
print(f"B7 (contador a ritmo maximo: xa entre los flancos 256 y 257, tt 27 y ss 85): {'cumplida' if len(K) == 2 and all(K) else 'FALSA'}")
print(f"B8 (mutante 'libre': oscila en 6 de 6 y su Q difiere mas de 2 % en algun rango): {'cumplida' if len(ML) == 2 and all(n == 3 for _, n, _ in ML) and any(d is not None and abs(d) > 2 for _, _, d in ML) else 'FALSA'} {[(r, n, None if d is None else round(d, 2)) for r, n, d in ML]}")
inv = []
if bad: inv.append(f"decks que no acabaron en 'salida 0': {bad}")
if dw is None or dw < 4: inv.append(f"testigo de +20 fF: Q {dw} % (se exige >= +4 %)")
cl = {"bajo": 5, "alto": 5}
if len(V["CTL"]) != 4 or any(x[3] is None or abs(x[3]) > cl[x[0]] for x in V["CTL"]): inv.append(f"control fuera de +-5 % de MISFIT-24: {[sh(x) for x in V['CTL']]}")
print("control (netlist + libreria frente a MISFIT-24, +-5 %):", [sh(x) for x in V["CTL"]])
print("sin ajuste:", SIN or "ninguno"); print("TANDA INVALIDA:" if inv else "tanda valida", *inv, sep="\n  ")
