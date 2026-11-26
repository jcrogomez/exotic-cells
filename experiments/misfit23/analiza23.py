"""MISFIT-23: veredictos P1..P5. Escrito antes de correr. Uso: analiza23.py > m23.txt
Periodo = media de los diez intervalos entre los flancos 2..12. Modelo T = Q/(I - IL) + td (copia de misfit17/analiza.py)."""
import os, re, statistics
import gen23 as g
H = g.H; G = g.G
def lee(rng, c, t, caso, i):
    f = os.path.join(H, "d", f"{rng}_{c}{t}_{caso}_{i:.4e}", "lec.log")
    if not os.path.exists(f): return None, None, "sin log", None
    L = open(f, errors="replace").read().splitlines(); e = {}; cd = None
    for l in L:
        x = l.split()
        if len(x) == 3 and x[0] == "ED":
            try: e[int(x[1])] = float(x[2])
            except ValueError: pass
        if len(x) == 2 and x[0] == "CD":
            try: cd = float(x[1])
            except ValueError: pass
    per = [e[n + 1] - e[n] for n in range(2, 12) if n in e and n + 1 in e]
    fin = L[-1].strip() if L else "vacio"
    if len(per) != 10: return None, len(e), fin, cd
    return statistics.mean(per), statistics.stdev(per) / statistics.mean(per) * 100, fin, cd
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
Q17 = {}; cur = None                      # cargas de MISFIT-17
for l in open(os.path.join(H, "..", "misfit17", "m17.txt")):
    m = re.match(r"## rango (\w+) · (\w+) (-?\d+)", l)
    if m: cur = m.groups()
    m = re.match(r"\s+ajuste: Q = ([\d.]+) fC", l)
    if m and cur: Q17[cur] = float(m.group(1))
V = {k: [] for k in ("P1", "P2", "P3", "P4")}; INV = []; CD = []; bad = []; il85 = None
for rng in G.LP:
    for c, t in G.CORN:
        print(f"\n## rango {rng} · {c} {t}"); R = {}
        for k, i in g.CASOS[rng]:
            R[(k, i)] = lee(rng, c, t, k, i)
            if R[(k, i)][2] != "salida 0": bad.append((rng, c, t, k, R[(k, i)][2]))
            if R[(k, i)][3] is not None: CD.append(R[(k, i)][3])
        cal = [(i, R[(k, i)][0]) for k, i in g.CASOS[rng] if k == "cal"]; fp = None if any(x[1] is None for x in cal) else fit(cal)
        if fp is None: print("  SIN AJUSTE:", cal); INV.append((rng, c, t)); continue
        q, il, td = fp; dq = (q * 1e15 / Q17[(rng, c, t)] - 1) * 100; V["P3"].append((rng, c, t, dq))
        print(f"  ajuste: Q = {q*1e15:.2f} fC ({dq:+.1f} % frente a MISFIT-17), IL = {il*1e12:+.3f} pA, td = {td*1e9:.2f} ns")
        if (rng, c, t) == ("bajo", "ff", "85"): il85 = il * 1e12
        for k, i in g.CASOS[rng]:
            T, dis = R[(k, i)][0], R[(k, i)][1]
            if k == "oos":
                e = None if T is None else ((q / (T - td) + il) / i - 1) * 100; V["P1"].append((rng, c, t, i, e))
                print(f"  fuera de muestra {i:.3e} A: " + ("sin periodo" if T is None else f"error {e:+.2f} %, dispersion {dis:.2f} %"))
            if k == "wit":
                T0 = R[("oos", 3.1623e-9 if rng == "bajo" else 1e-6)][0]; d = None if not (T and T0) else (T / T0 - 1) * 100; V["P2"].append((rng, c, t, d))
                print(f"  testigo +3 %: periodo {d if d is None else round(d, 3)} %")
                if d is None or not (-3.5 <= d <= -2.3): INV.append((rng, c, t))
            if k == "zero":
                ne = R[(k, i)][1] if T is None else 12; V["P4"].append((rng, c, t, not ne)); print("  sin corriente:", f"HAY FLANCOS ({ne})" if ne else "ningun flanco en 20 ms")
print("\n## Veredictos")
p1 = V["P1"]; f1 = [x for x in p1 if x[4] is None or abs(x[4]) > 3]
print(f"P1 (24 fuera de muestra dentro de +-3 %): {'cumplida' if len(p1) == 24 and not f1 else 'FALSA'} ({len(p1) - len(f1)} de {len(p1)}); fallan: {[(a, b, c_, f'{i:.2e}', None if e is None else round(e, 2)) for a, b, c_, i, e in f1]}")
p2 = V["P2"]; print(f"P2 (testigo entre -3,5 y -2,3 %): {'cumplida' if len(p2) == 8 and all(x[3] is not None and -3.5 <= x[3] <= -2.3 for x in p2) else 'FALSA'} {[None if x[3] is None else round(x[3], 3) for x in p2]}")
ok3 = lambda x: (1 <= x[3] <= 6) if x[0] == "alto" else abs(x[3]) <= 10
p3 = V["P3"]; print(f"P3 (Q: alto +1..+6 %, bajo +-10 %): {'cumplida' if len(p3) == 8 and all(ok3(x) for x in p3) else 'FALSA'} {[(x[0], x[1], x[2], round(x[3], 1)) for x in p3]}")
p4 = V["P4"]; print(f"P4 (sin corriente, ningun flanco): {'cumplida' if len(p4) == 8 and all(x[3] for x in p4) else 'FALSA'} ({sum(1 for x in p4 if x[3])} de {len(p4)})")
print(f"P5 (IL bajo ff 85 entre -10 y +20 pA): {'sin dato' if il85 is None else ('cumplida' if -10 <= il85 <= 20 else 'FALSA') + f' ({il85:+.2f} pA)'}")
print("casos invalidos:", sorted(set(INV)) or "ninguno"); print("decks que no acabaron en 'salida 0':", bad or "ninguno")
print("control de capacidad:", f"{len(CD)} valores, min {min(CD)*1e15:.3f} fF, max {max(CD)*1e15:.3f} fF", "bien" if CD and all(0.5e-15 <= x <= 3e-15 for x in CD) else "FALLA -> tanda INVALIDA")
