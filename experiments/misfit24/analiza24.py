"""MISFIT-24: veredictos A1..A4, B1..B3, C1. Escrito antes de la tanda. Uso: analiza24.py > m24.txt
Periodo = media de los diez intervalos entre los flancos 2..12. Modelo T = Q/(I - IL) + td (fit y lectura de misfit23/analiza23.py)."""
import os, re, statistics
import gen24 as g
H = g.H; G = g.G
def lee(sub, rng, c, t, caso, i):
    f = os.path.join(H, sub, f"{rng}_{c}{t}_{caso}_{i:.4e}", "lec.log")
    if not os.path.exists(f): return None, None, "sin log", None, {}, {}
    L = open(f, errors="replace").read().splitlines(); e = {}; cd = None; dy = {}
    for l in L:
        x = l.split()
        if len(x) == 3 and x[0] in ("ED", "DY"):
            try: (e if x[0] == "ED" else dy)[int(x[1]) if x[0] == "ED" else x[1]] = float(x[2])
            except ValueError: pass
        if len(x) == 2 and x[0] == "CD":
            try: cd = float(x[1])
            except ValueError: pass
    per = [e[n + 1] - e[n] for n in range(2, 12) if n in e and n + 1 in e]
    fin = L[-1].strip() if L else "vacio"
    if len(per) != 10: return None, len(e), fin, cd, e, dy
    return statistics.mean(per), statistics.stdev(per) / statistics.mean(per) * 100, fin, cd, e, dy
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
Q23 = {}; cur = None
for l in open(os.path.join(H, "..", "misfit23", "m23.txt")):
    m = re.match(r"## rango (\w+) · (\w+) (-?\d+)", l)
    if m: cur = m.groups()
    m = re.match(r"\s+ajuste: Q = ([\d.]+) fC", l)
    if m and cur: Q23[cur] = float(m.group(1))
V = {k: [] for k in ("A1", "A2", "A3", "A4", "B1", "B2", "B3", "C1")}; INV = []; CD = []; bad = []; Q4 = {}
for rng in G.LP:
    for c, t in G.CORN:
        print(f"\n## rango {rng} · {c} {t}"); R = {}
        for k, i in g.CASOS[rng]:
            R[(k, i)] = lee("d", rng, c, t, k, i)
            if R[(k, i)][2] != "salida 0": bad.append(("d", rng, c, t, k, R[(k, i)][2]))
            if R[(k, i)][3] is not None: CD.append(R[(k, i)][3])
        cal = [(i, R[(k, i)][0]) for k, i in g.CASOS[rng] if k == "cal"]; fp = None if any(x[1] is None for x in cal) else fit(cal)
        if fp is None: print("  SIN AJUSTE:", cal); INV.append((rng, c, t)); continue
        q, il, td = fp; dq = (q * 1e15 / Q23[(rng, c, t)] - 1) * 100; V["A3"].append((rng, c, t, dq)); Q4[(rng, c, t)] = q
        print(f"  ajuste: Q = {q*1e15:.2f} fC ({dq:+.1f} % frente a MISFIT-23), IL = {il*1e12:+.3f} pA, td = {td*1e9:.2f} ns")
        for k, i in g.CASOS[rng]:
            T, dis = R[(k, i)][0], R[(k, i)][1]
            if k == "oos":
                e = None if T is None else ((q / (T - td) + il) / i - 1) * 100; V["A1"].append((rng, c, t, i, e))
                print(f"  fuera de muestra {i:.3e} A: " + ("sin periodo" if T is None else f"error {e:+.2f} %, dispersion {dis:.2f} %"))
            if k == "wit":
                T0 = R[("oos", g.MID[rng])][0]; d = None if not (T and T0) else (T / T0 - 1) * 100; V["A2"].append((rng, c, t, d))
                print(f"  testigo +3 %: periodo {d if d is None else round(d, 3)} %")
                if d is None or not (-3.5 <= d <= -2.3): INV.append((rng, c, t))
            if k == "zero":
                ne = R[(k, i)][1] if T is None else 12; V["A4"].append((rng, c, t, not ne)); print("  sin corriente:", f"HAY FLANCOS ({ne})" if ne else "ningun flanco en 20 ms")
        # grupo B
        i = g.MID[rng]; T, dis, fin, cd, e, dy = lee("dyn", rng, c, t, "oos", i); T0 = R[("oos", i)][0]
        if fin != "salida 0": bad.append(("dyn", rng, c, t, fin))
        if cd is not None: CD.append(cd)
        need = ("t0", "qidle", "xidle", "qoff", "xoff")
        if any(k not in dy for k in need): print("  dinamico: faltan medidas", sorted(dy)); [V[b].append((rng, c, t, False)) for b in ("B1", "B2", "B3")]; continue
        b1 = dy["qidle"] <= 0.2 and dy["xidle"] >= 1.7 and 1 in e and e[1] > dy["t0"]
        d2 = None if not (T and T0) else (T / T0 - 1) * 100; b2 = d2 is not None and abs(d2) <= 1
        b3 = dy["qoff"] <= 0.2 and dy["xoff"] >= 1.7
        V["B1"].append((rng, c, t, b1)); V["B2"].append((rng, c, t, b2)); V["B3"].append((rng, c, t, b3))
        ii = dy.get("iidle"); rep = "sin dato" if ii is None else f"{(-ii - i) * 1e9:+.3f} nA"
        print(f"  dinamico: reposo q max {dy['qidle']:.3f} V, nodo min {dy['xidle']:.3f} V, primer flanco {'no hay' if 1 not in e else f'{(e[1] - dy['t0']) * 1e9:.1f} ns tras EN'}"
              f" | periodo frente a EN fijo {'sin dato' if d2 is None else f'{d2:+.3f} %'} | tras bajar EN q max {dy['qoff']:.3f} V, nodo min {dy['xoff']:.3f} V | consumo en reposo menos la celda {rep}")
print("\n## grupo C: puertas _1, tt 27")
for rng in G.LP:
    cal = [(i, lee("f1", rng, "tt", "27", k, i)) for k, i in g.CASOS[rng] if k == "cal"]
    for i, r in cal:
        if r[2] != "salida 0": bad.append(("f1", rng, i, r[2]))
    fp = None if any(r[0] is None for _, r in cal) else fit([(i, r[0]) for i, r in cal]); q4 = Q4.get((rng, "tt", "27"))
    if fp is None or q4 is None: print(f"  {rng}: sin ajuste"); V["C1"].append((rng, None)); continue
    d = (fp[0] / q4 - 1) * 100; V["C1"].append((rng, d)); print(f"  {rng}: Q = {fp[0]*1e15:.2f} fC ({d:+.2f} % frente a _4), IL = {fp[1]*1e12:+.3f} pA, td = {fp[2]*1e9:.2f} ns")
print("\n## Veredictos")
p = V["A1"]; f1 = [x for x in p if x[4] is None or abs(x[4]) > 3]
print(f"A1 (24 fuera de muestra dentro de +-3 %): {'cumplida' if len(p) == 24 and not f1 else 'FALSA'} ({len(p) - len(f1)} de {len(p)}); fallan: {[(a, b, c_, f'{i:.2e}', None if e is None else round(e, 2)) for a, b, c_, i, e in f1]}")
p = V["A2"]; print(f"A2 (testigo entre -3,5 y -2,3 %): {'cumplida' if len(p) == 8 and all(x[3] is not None and -3.5 <= x[3] <= -2.3 for x in p) else 'FALSA'} {[None if x[3] is None else round(x[3], 3) for x in p]}")
ok3 = lambda x: abs(x[3]) <= (3 if x[0] == "alto" else 10)
p = V["A3"]; print(f"A3 (Q frente a MISFIT-23: alto +-3 %, bajo +-10 %): {'cumplida' if len(p) == 8 and all(ok3(x) for x in p) else 'FALSA'} {[(x[0], x[1], x[2], round(x[3], 1)) for x in p]}")
p = V["A4"]; print(f"A4 (sin corriente, ningun flanco): {'cumplida' if len(p) == 8 and all(x[3] for x in p) else 'FALSA'} ({sum(1 for x in p if x[3])} de {len(p)})")
for b, txt in (("B1", "reposo inicial quieto y primer flanco tras EN"), ("B2", "periodo tras EN dentro de +-1 % del de EN fijo"), ("B3", "quieto tras bajar EN")):
    p = V[b]; print(f"{b} ({txt}): {'cumplida' if len(p) == 8 and all(x[3] for x in p) else 'FALSA'} ({sum(1 for x in p if x[3])} de {len(p)}); fallan: {[x[:3] for x in p if not x[3]]}")
p = V["C1"]; okc = lambda x: x[1] is not None and abs(x[1]) < (3 if x[0] == "alto" else 10)
print(f"C1 (puertas _1: Q cambia < 3 % alto, < 10 % bajo): {'cumplida' if len(p) == 2 and all(okc(x) for x in p) else 'FALSA'} {[(x[0], None if x[1] is None else round(x[1], 2)) for x in p]}")
print("casos invalidos:", sorted(set(INV)) or "ninguno"); print("decks que no acabaron en 'salida 0':", bad or "ninguno")
print("control de capacidad:", f"{len(CD)} valores, min {min(CD)*1e15:.3f} fF, max {max(CD)*1e15:.3f} fF" if CD else "sin valores", "bien" if CD and all(0.5e-15 <= x <= 3e-15 for x in CD) else "FALLA -> tanda INVALIDA")
