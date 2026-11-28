"""MISFIT-28: veredictos C1..C11. Escrito y sellado antes de la tanda. Uso: analiza28.py > m28.txt
Lee los decks de gen28.lista(), los testigos, el bloque (local_flow/misfit28_r2_a) y unidad.txt / mutantes.txt."""
import os, re, sys, json
import gen28 as g
from lee28 import lee
H = g.H; G = g.G; bad = []; LF = "/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow"


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


def sano(r): return len(r["ed"]) == 18 and len(r["el"]) == 18 and len(r["eh"]) == 18 and not r["medias"] and r["fin"] == "salida 0"
def regular(r): return "T" in r and 0.97 <= r["pmin"] and r["pmax"] <= 1.03
def cuenta(r):
    e = r["ed"]
    if not all(k in e for k in (4, 5, 16, 17)) or "txa" not in r or "txb" not in r: return False, None, None
    da, db = r["txa"] - e[4], r["txb"] - e[16]; return (-1e-9 <= da <= 2e-8 and -1e-9 <= db <= 2e-8), da, db


R = {}
for x in g.lista():
    grp, c, t, rng, k, i, kw = x; r = lee(os.path.join(g.nombre(*x), "lec.log")); R[(grp, c, t, rng, k, i, kw.get("seed"))] = r
    if r["fin"] != "salida 0": bad.append((grp, rng, c, t, k, i, kw.get("seed"), r["fin"]))
Q26 = {}; cur = None
for l in open(os.path.join(H, "..", "misfit26", "m26.txt")):
    m = re.match(r"## rango (\w+) · (\w+) (-?\d+)", l)
    if m: cur = m.groups()
    m = re.match(r"\s+extraido: Q = ([\d.]+) fC", l)
    if m and cur: Q26[cur] = float(m.group(1)) * 1e-15
V = {k: [] for k in ("C1", "C2", "C3", "C4", "C5", "C9", "C11")}
for rng in G.LP:
    for c, t in G.CORN:
        print(f"\n## rango {rng} · {c} {t}"); casos = g.CAL(rng); rr = {(k, i): R[("a", c, t, rng, k, i, None)] for k, i in casos}
        if rng == "bajo": rr.update({("lento", i): R[("lento", c, t, "bajo", "oos", i, None)] for i in g.BAJO_EXTRA})
        for (k, i), r in rr.items():
            V["C1"].append((rng, c, t, k, i, sano(r))); V["C2"].append((rng, c, t, k, i, regular(r), r.get("pmin"), r.get("pmax")))
            V["C11"].append((rng, c, t, k, i, r.get("qidle", 9) <= 0.2, r.get("xidle")))
            if rng == "bajo": ok, da, db = cuenta(r); V["C4"].append((rng, c, t, k, i, ok, da, db))
        cal = [(i, rr[(k, i)].get("T")) for k, i in casos if k == "cal"]; fp = None if any(x[1] is None for x in cal) else fit(cal)
        if fp is None: print("  SIN AJUSTE:", cal); continue
        q, il, td = fp; d26 = (q / Q26[(rng, c, t)] - 1) * 100; V["C9"].append((rng, c, t, d26))
        print(f"  Q = {q*1e15:.2f} fC ({d26:+.1f} % frente al bloque de MISFIT-26), IL = {il*1e12:+.3f} pA, td = {td*1e9:.2f} ns; nodo minimo {min(r.get('xmin', 9) for r in rr.values()):.3f} V")
        for (k, i), r in sorted(rr.items(), key=lambda x: x[0][1]):
            if k == "cal": continue
            T = r.get("T"); e = None if T is None else ((q / (T - td) + il) / i - 1) * 100
            if k == "oos": V["C3"].append((rng, c, t, i, e))
            print(f"  {'fuera de muestra' if k == 'oos' else 'extra (no cuenta en C3)'} {i:.3e} A: " + ("sin periodo" if T is None else f"error {e:+.2f} %, dispersion {r['dis']:.2f} %, intervalos {r['pmin']:.3f}..{r['pmax']:.3f}"))
print("\n## desajuste: ff_mm, 5 semillas, 100 y 316 pA")
for (grp, c, t, rng, k, i, seed), r in R.items():
    if grp != "mm": continue
    ok, da, db = cuenta(r); V["C5"].append((c, t, i, seed, sano(r) and regular(r) and ok))
    print(f"  {c} {t} {i:.3e} A semilla {seed}: flancos {len(r['el'])}/{len(r['ed'])}/{len(r['eh'])}, a medias {r['medias']}, intervalos {r.get('pmin')}..{r.get('pmax')}, xa {da}, xb {db}, T {r.get('T')}")
print("\n## sin corriente, ff 85"); Z = []
for rng in G.LP:
    r = R[("zero", "ff", "85", rng, "zero", 0.0, None)]; n = len(r["ed"]) + len(r["el"]); Z.append(r["fin"] == "salida 0" and n == 0); print(f"  {rng}: {n} flancos (a 0,3 o 0,9 V), {r['fin']}")
print("\n## contador a ritmo maximo: rango alto, 10 uA"); K = []
for c, t in (("tt", "27"), ("ss", "85")):
    r = R[("largo", c, t, "alto", "cal", 1e-5, None)]; k = r["ek"]; ok = 256 in k and 257 in k and "txa" in r and k[256] - 1e-9 <= r["txa"] < k[257] and "txb" not in r; K.append(ok)
    print(f"  {c} {t}: flanco 256 {k.get(256)}, xa {r.get('txa')}, flanco 257 {k.get(257)}, xb {r.get('txb', 'no sube')}, periodo {r.get('T')} -> {'bien' if ok else 'MAL'}")
print("\n## testigos: decks de MISFIT-26 (sin histeresis) con la medida nueva"); W = []
for name in g.TESTIGOS:
    r = lee(os.path.join(H, "testigo", name, "lec.log")); ok, da, db = cuenta(r); visto = r["fin"] == "salida 0" and not (sano(r) and ok); W.append(visto)
    if r["fin"] != "salida 0": bad.append(("testigo", name, r["fin"]))
    print(f"  {name}: flancos {len(r['el'])}/{len(r['ed'])}/{len(r['eh'])}, a medias {r['medias']}, xa {da}, xb {db} -> {'fallo visto' if visto else 'NO VISTO'}")
print("\n## fisico")
def txt(f): return open(os.path.join(H, f)).read().strip() if os.path.exists(os.path.join(H, f)) else "(falta " + f + ")"
blo, uni, mut = txt("m28_bloque.txt"), txt("unidad.txt"), txt("mutantes.txt"); print(blo); print(uni); print(mut)
c10 = ("H1 (cierra limpio): cumplida" in blo and "H2 (lazo intacto y sin buferes): cumplida" in blo and "violations=0" in uni and "match uniquely" in uni and mut.count("do not match") == 3 and "conductores multiples solo en c2: si" in blo)
print("\n## Veredictos")
def vd(n, txt_, p, ok, tot):
    f = [x for x in p if not ok(x)]; print(f"{n} ({txt_}): {'cumplida' if len(p) == tot and not f else 'FALSA'} ({len(p) - len(f)} de {len(p)}, se esperan {tot}); fallan: {f}")
vd("C1", "64 decks: 18 flancos a 0,3, 0,9 y 1,5 V, ningun pulso a medias", V["C1"], lambda x: x[5], 64)
vd("C2", "64 decks: cada intervalo dentro de +-3 % de la media", V["C2"], lambda x: x[5], 64)
vd("C3", "24 fuera de muestra dentro de +-3 %", V["C3"], lambda x: x[4] is not None and abs(x[4]) <= 3, 24)
vd("C4", "contador, 40 decks de rango bajo: xa y xb entre -1 y 20 ns tras los flancos 4 y 16", V["C4"], lambda x: x[5], 40)
vd("C5", "desajuste, 20 chips-punto: sanos, regulares y con la cuenta bien", V["C5"], lambda x: x[4], 20)
print(f"C6 (sin corriente, ff 85: ningun flanco): {'cumplida' if len(Z) == 2 and all(Z) else 'FALSA'}")
print(f"C7 (ritmo maximo: xa tras el flanco 256, tt 27 y ss 85): {'cumplida' if len(K) == 2 and all(K) else 'FALSA'}")
print(f"C8 (testigos: la medida nueva ve el fallo de MISFIT-26 en los dos decks): {'cumplida' if len(W) == 2 and all(W) else 'FALSA'}")
vd("C9", "Q frente al bloque extraido de MISFIT-26 dentro de +-10 %", V["C9"], lambda x: abs(x[3]) <= 10, 8)
print(f"C10 (bloque limpio y lazo intacto; unidad limpia, LVS coincide, tres mutantes distintos; doble conductor solo en c2): {'cumplida' if c10 else 'FALSA'}")
vd("C11", "reposo: q <= 0,2 V antes de EN en los 64", V["C11"], lambda x: x[5], 64)
inv = []
if bad: inv.append(f"decks que no acabaron en 'salida 0': {bad}")
if not (len(W) == 2 and all(W)): inv.append("algun testigo no visto: el detector no esta probado")
print("TANDA INVALIDA:" if inv else "tanda valida", *inv, sep="\n  ")
