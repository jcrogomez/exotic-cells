"""Plan nocturno 2026-11-25, bloque A (lector 2, precarga L = 0,50 / 1,00 / 2,00). Mismo modelo y criterios que R2
(experiments/xc20_lector/r2/analiza_r2.py: W1, W3, W4). Escrito ANTES de abrir ningun log. Salida: A.txt
Formas fijadas aqui: A2 = L 1,00 cumple +-3 % de 1 nA a 1 uA en las 4 esquinas y falla a 10 uA en al menos una;
A3 = L 2,00 falla a 1 uA en al menos una esquina; A4 se juzga solo donde 10 nA y 1 uA (y sus +1 %) dan periodo.
Un caso (variante, esquina) es invalido si algun testigo con dato cae fuera de [-1,2, -0,8] %."""
import os, glob, sys
H = os.path.dirname(os.path.abspath(__file__)); sys.path.insert(0, os.path.join(H, "..", "xc20_lector", "r2"))
CORN = (("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85")); LS = ("0.50", "1.00", "2.00")
JUZ = [1e-10, 1e-9, 1e-8, 1e-7, 1e-6, 1e-5]; CAL = [3.1623e-10, 3.1623e-8, 3.1623e-6]
D = {}; LOG = {}
for f in glob.glob(os.path.join(H, "A", "*", "lec.log")):
    LP = os.path.basename(os.path.dirname(f)).split("_")[0][1:]
    for l in open(f, errors="replace"):
        t = l.split()
        if t and t[0] == "R2":
            c, te, kind, i = t[1], t[2], t[3], float(t[4])
            try: T = (float(t[6]) - float(t[5])) / 10 if len(t) == 7 else None
            except ValueError: T = None
            D[(LP, c, te, float(f"{i:.4e}"))] = T; LOG[(LP, c, te, float(f"{i:.4e}"))] = f
def fit(pts):      # copia literal de analiza_r2.py
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
o = [f"# Noche 1125, bloque A · analiza_A.py · lector 2 con precarga de canal largo · decks leidos: {len(D)} de 144",
     "# T = (flanco 12 - flanco 2)/10; modelo T = Q/(I - IL) + td ajustado en 316 pA, 31,6 nA y 3,16 uA"]
E = {}; W3 = {}; W4 = {}; INV = {}
for LP in LS:
    for c, t in CORN:
        o.append(f"\n## L = {LP} um · {c} {t}")
        cal = [(i, D.get((LP, c, t, i))) for i in CAL]
        fp = None if any(x[1] is None for x in cal) else fit(cal)
        if fp is None: o.append(f"  sin ajuste (calibracion: {cal})")
        else: q, il, td = fp; o.append(f"  ajuste: Q = {q*1e15:.2f} fC, IL = {il*1e12:+.2f} pA, td = {td*1e9:.2f} ns")
        for i in JUZ:
            T = D.get((LP, c, t, i))
            if T is None or fp is None: o.append(f"  I = {i:.1e} A: {'sin periodo' if T is None else f'T = {T:.4e} s, sin modelo'}"); E[(LP, c, t, i)] = None; continue
            e = (T / (q / (i - il) + td) - 1) * 100; E[(LP, c, t, i)] = e
            o.append(f"  I = {i:.1e} A: T = {T:.4e} s, f = {1/T:.4g} Hz, error del modelo {e:+.2f} %")
        w = []
        for i0 in (1e-8, 1e-6):
            T0, T1 = D.get((LP, c, t, i0)), D.get((LP, c, t, float(f"{i0 * 1.01:.4e}")))
            if T0 and T1: d = (T1 / T0 - 1) * 100; w.append(-1.2 <= d <= -0.8); o.append(f"  testigo +1 % en {i0:.0e} A: periodo {d:+.3f} %")
            else: w.append(None); o.append(f"  testigo en {i0:.0e} A: sin dato")
        W3[(LP, c, t)] = w; INV[(LP, c, t)] = any(x is False for x in w)
        k = (LP, c, t, 0.0)
        if k in LOG:
            log = open(LOG[k], errors="replace").read()
            r1 = [l for l in log.splitlines() if l.strip().startswith("r1 ")]; xm = [l.split()[-1] for l in log.splitlines() if l.startswith("R2X")]
            W4[(LP, c, t)] = not r1; o.append(f"  I = 0: {'ningun flanco en 20 ms' if not r1 else 'HAY FLANCOS: ' + r1[0]}; minimo del nodo {xm[0] if xm else '?'} V")
        else: W4[(LP, c, t)] = None; o.append("  I = 0: sin dato")
ok = lambda LP, c, t, i: E.get((LP, c, t, i)) is not None and abs(E[(LP, c, t, i)]) <= 3
def w1(LP, cur=JUZ[1:]): return all(ok(LP, c, t, i) for c, t in CORN for i in cur)
o.append("\n## Tabla: error del modelo (%) por variante, esquina y corriente")
for LP in LS:
    for c, t in CORN:
        o.append(f"L {LP} {c:>2} {t:>3}: " + "  ".join((f"{E[(LP,c,t,i)]:+7.2f}" if E.get((LP, c, t, i)) is not None else "   ----") for i in JUZ) + ("   [caso INVALIDO: testigo]" if INV[(LP, c, t)] else ""))
o.append("            (100 pA, 1 nA, 10 nA, 100 nA, 1 uA, 10 uA; se juzga de 1 nA a 10 uA)")
o.append("\n## Veredictos")
res = {}
for LP in LS:
    a = w1(LP); b = all(all(x is True for x in W3[(LP, c, t)]) for c, t in CORN); d = all(W4[(LP, c, t)] is True for c, t in CORN)
    res[LP] = a and b and d
    o.append(f"L = {LP}: W1 {'cumple' if a else 'NO cumple'} | W3 (8 testigos) {'cumple' if b else 'NO cumple'} | W4 (sin corriente, 4 esquinas) {'cumple' if d else 'NO cumple'}")
o.append(f"A1 (L 0,50 cumple W1 en las 4 esquinas): {'cumplida' if w1('0.50') else 'FALSA'}")
a2 = w1("1.00", JUZ[1:5]) and not all(ok("1.00", c, t, 1e-5) for c, t in CORN)
o.append(f"A2 (L 1,00 cumple de 1 nA a 1 uA y falla a 10 uA): {'cumplida' if a2 else 'FALSA'}  [1 nA-1 uA: {'cumple' if w1('1.00', JUZ[1:5]) else 'no'}; 10 uA: {'cumple' if all(ok('1.00', c, t, 1e-5) for c, t in CORN) else 'falla'}]")
o.append(f"A3 (L 2,00 falla ya a 1 uA): {'cumplida' if not all(ok('2.00', c, t, 1e-6) for c, t in CORN) else 'FALSA'}")
a4 = [x for k in W3 for x in W3[k] if x is not None]
o.append(f"A4 (testigo entre -1,2 y -0,8 % donde hay dato): {'cumplida' if a4 and all(a4) else 'FALSA'} ({sum(a4)} de {len(a4)} con dato, de 24)")
a5 = [W4[k] for k in W4]
o.append(f"A5 (sin corriente, ningun flanco en las 12): {'cumplida' if len(a5) == 12 and all(x is True for x in a5) else 'FALSA'} ({sum(1 for x in a5 if x is True)} de 12)")
ad = [LP for LP in LS if res[LP]]
o.append(f"SE ADOPTA L = {ad[0]} um (la mas corta que cumple W1, W3 y W4)" if ad else "MUERE: ninguna L cumple W1, W3 y W4 -> dos rangos con dos precargas")
open(os.path.join(H, "A.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
