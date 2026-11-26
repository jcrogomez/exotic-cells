"""MISFIT-17 enmienda 1: rango bajo, ff -40, paso maximo diez veces menor, 12 flancos impresos.
Uso: e1.py gen -> e1/<caso>_<I>/lec.sp ; e1.py > e1.txt (analiza). Escrito antes de correr."""
import os, re, sys, glob, statistics
import gen
H = gen.H; C, T, RNG = "ff", "-40", "bajo"
if sys.argv[1:] == ["gen"]:
    for caso, i in gen.CASOS[RNG]:
        s = gen.deck(C, T, RNG, caso, i); m = re.search(r"^tran (\S+) (\S+) 0 (\S+)$", s, re.M); assert m
        s = s.replace(m.group(0), f"tran {m.group(1)} {m.group(2)} 0 {float(m.group(3)) / 10:.3e}")
        ex = []
        for n in range(1, 13): ex += [f"meas tran e{n} when v(o_q)=0.9 rise={n}", f"echo ED {n} $&e{n}"]
        s = s.replace("quit\n.endc", "\n".join(ex) + "\nquit\n.endc"); assert "ED 12" in s
        d = os.path.join(H, "e1", f"{caso}_{i:.4e}"); os.makedirs(d, exist_ok=True); open(os.path.join(d, "lec.sp"), "w").write(s)
    print("decks:", len(gen.CASOS[RNG])); sys.exit()
P = {}; bad = []
for caso, i in gen.CASOS[RNG]:
    f = os.path.join(H, "e1", f"{caso}_{i:.4e}", "lec.log"); L = open(f, errors="replace").read().splitlines()
    if not L or L[-1].strip() != "salida 0": bad.append((caso, i, L[-1] if L else "vacio"))
    e = {}
    for l in L:
        t = l.split()
        if len(t) == 3 and t[0] == "ED":
            try: e[int(t[1])] = float(t[2])
            except ValueError: pass
    per = [e[n + 1] - e[n] for n in range(2, 12) if n in e and n + 1 in e]
    P[(caso, i)] = (statistics.mean(per), statistics.stdev(per) / statistics.mean(per) * 100, len(per)) if len(per) == 10 else None
    print(f"{caso} {i:.4e}: " + ("sin diez periodos" if P[(caso, i)] is None else f"T = {P[(caso, i)][0]:.4e} s, dispersion {P[(caso, i)][1]:.3f} %"))
print("decks que no acabaron bien:", bad or "ninguno")
def fit(pts):      # copia de analiza.py
    (i1, t1), (i2, t2), (i3, t3) = pts
    def g(il):
        a1, a3 = 1 / (i1 - il), 1 / (i3 - il); q = (t1 - t3) / (a1 - a3); td = t3 - q * a3
        return q / (i2 - il) + td - t2, q, td
    lo, hi = -i1 * 5, i1 * 0.999; flo, fhi = g(lo)[0], g(hi)[0]
    if flo * fhi > 0: return None
    for _ in range(200):
        mid = (lo + hi) / 2; fm = g(mid)[0]
        if flo * fm <= 0: hi = mid
        else: lo, flo = mid, fm
    il = (lo + hi) / 2; _, q, td = g(il); return q, il, td
cal = [(i, P[(k, i)]) for k, i in gen.CASOS[RNG] if k == "cal"]
fp = None if any(x[1] is None for x in cal) else fit([(i, p[0]) for i, p in cal])
if bad or fp is None: print("TANDA INVALIDA"); sys.exit()
q, il, td = fp; print(f"ajuste: Q = {q*1e15:.2f} fC, IL = {il*1e12:+.3f} pA, td = {td*1e9:.2f} ns")
errs = []
for k, i in gen.CASOS[RNG]:
    if k == "oos": e = ((q / (P[(k, i)][0] - td) + il) / i - 1) * 100; errs.append(e); print(f"fuera de muestra {i:.3e} A: error {e:+.2f} %")
T0 = P[("oos", 3.1623e-9)]; w = (P[("wit", 3.1939e-9)][0] / T0[0] - 1) * 100; r = T0[0] / P[("bare", 3.1623e-9)][0]
print(f"E1 (dispersion a 3,16 nA < 0,16 %): {'cumplida' if T0[1] < 0.16 else 'FALSA'} ({T0[1]:.3f} %)")
print(f"E2 (testigo entre -1,2 y -0,8 %): {'cumplida' if -1.2 <= w <= -0.8 else 'FALSA'} ({w:.3f} %)")
print(f"E3 (tres lecturas dentro de +-3 %): {'cumplida' if all(abs(e) <= 3 for e in errs) else 'FALSA'}")
print(f"E4 (con/sin matriz entre 0,98 y 1,02): {'cumplida' if 0.98 <= r <= 1.02 else 'FALSA'} ({r:.4f})")
print(f"puesto 6 frente a 0: {(P[('s6', 3.1623e-9)][0] / T0[0] - 1) * 100:+.4f} %")
