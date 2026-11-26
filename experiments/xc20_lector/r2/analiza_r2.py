"""XC-20 lector 2 (R2): veredictos W0-W6. Escrito ANTES de ver ninguna salida. Salida: r2.txt
Modelo: T(I) = Q/(I - IL) + td, ajustado en 3 corrientes de calibracion (solucion exacta de 3 ecuaciones, por biseccion en IL)."""
import os, glob
H = os.path.dirname(os.path.abspath(__file__))
CORN = (("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85"))
JUZ = [1e-10, 1e-9, 1e-8, 1e-7, 1e-6, 1e-5]; CAL = [3.1623e-10, 3.1623e-8, 3.1623e-6]
D = {}; flancos0 = {}
for f in glob.glob(os.path.join(H, "*", "lec.log")):
    for l in open(f, errors="replace"):
        t = l.split()
        if t and t[0] == "R2":
            c, te, kind, i = t[1], t[2], t[3], float(t[4])
            try: T = (float(t[6]) - float(t[5])) / 10 if len(t) == 7 else None
            except ValueError: T = None
            D[(c, te, kind, float(f"{i:.4e}"))] = T
def fit(pts):
    (i1, t1), (i2, t2), (i3, t3) = pts
    def g(il):   # con IL fijo, Q y td salen de los puntos 1 y 3; residuo en el punto 2
        a1, a3 = 1 / (i1 - il), 1 / (i3 - il); q = (t1 - t3) / (a1 - a3); td = t3 - q * a3
        return q / (i2 - il) + td - t2, q, td
    lo, hi = -i1 * 5, i1 * 0.999
    flo, fhi = g(lo)[0], g(hi)[0]
    if flo * fhi > 0: return None
    for _ in range(200):
        mid = (lo + hi) / 2; fm = g(mid)[0]
        if flo * fm <= 0: hi = mid
        else: lo, flo = mid, fm
    il = (lo + hi) / 2; _, q, td = g(il); return q, il, td
o = ["# XC-20 lector 2 (R2) · analiza_r2.py · T = (flanco 12 - flanco 2)/10; modelo T = Q/(I - IL) + td ajustado en 316 pA, 31,6 nA y 3,16 uA"]
a, b = D.get(("tt", "27", "ideal", 1e-9)), D.get(("tt", "27", "ideal", 1e-6))
w0 = a and b and abs(a / 1.995e-4 - 1) <= 0.005 and abs(b / 2.027e-7 - 1) <= 0.005
o.append(f"W0 (control 200 fF ideal, tt 27): 1 nA T = {a}, 1 uA T = {b}; frente a la v4: {((a/1.995e-4-1)*100 if a else float('nan')):+.3f} %, {((b/2.027e-7-1)*100 if b else float('nan')):+.3f} % -> {'cumplida' if w0 else 'FALSA'}")
w1 = []; w2 = []; w3 = []; w4 = []; w5 = []; w6 = []
for c, t in CORN:
    o.append(f"\n## {c} {t}")
    cal = [(i, D.get((c, t, "mos", i))) for i in CAL]
    if any(x[1] is None for x in cal): o.append(f"  calibracion incompleta: {cal}"); w1.append(False); continue
    fp = fit(cal)
    if fp is None: o.append("  el ajuste no tiene solucion en el intervalo de IL"); w1.append(False); continue
    q, il, td = fp; o.append(f"  ajuste: Q = {q*1e15:.2f} fC, IL = {il*1e12:+.2f} pA, td = {td*1e9:.2f} ns")
    w5.append(abs(il) <= 5e-12 if t in ("27", "-40") else 5e-12 <= il <= 150e-12); w6.append(2e-9 <= td <= 8e-9)
    for i in JUZ:
        T = D.get((c, t, "mos", i))
        if T is None: o.append(f"  I = {i:.1e} A: sin periodo (no oscila en la ventana)"); (w2 if i == 1e-10 else w1).append(False); continue
        e = (T / (q / (i - il) + td) - 1) * 100
        o.append(f"  I = {i:.1e} A: T = {T:.4e} s, f = {1/T:.4g} Hz, error del modelo {e:+.2f} %")
        if i == 1e-10:
            if t in ("27", "-40"): w2.append(abs(e) <= 3)
        else: w1.append(abs(e) <= 3)
    for i0 in (1e-8, 1e-6):
        T0, T1 = D.get((c, t, "mos", i0)), D.get((c, t, "mos", float(f"{i0 * 1.01:.4e}")))
        if T0 and T1: d = (T1 / T0 - 1) * 100; w3.append(-1.2 <= d <= -0.8); o.append(f"  testigo +1 % en {i0:.0e} A: periodo {d:+.3f} %")
        else: w3.append(False); o.append(f"  testigo en {i0:.0e} A: sin dato")
    k = (c, t, "mos", 0.0)
    if k in D:
        log = open(glob.glob(os.path.join(H, f"{c}{t}_m_0.0000e+00", "lec.log"))[0], errors="replace").read()
        r1 = [l for l in log.splitlines() if l.strip().startswith("r1 ")]; xm = [l.split()[-1] for l in log.splitlines() if l.startswith("R2X")]
        w4.append(not r1); o.append(f"  I = 0: {'ningun flanco en 20 ms' if not r1 else 'HAY FLANCOS: ' + r1[0]}; minimo del nodo {xm[0] if xm else '?'} V")
    else: w4.append(False); o.append("  I = 0: sin dato")
v = lambda x, n: ("cumplida" if all(x) and len(x) == n else "FALSA") if x else "sin dato"
o += ["\n## Veredictos", f"W1 (1 nA a 10 uA dentro de +-3 %, 4 esquinas): {v(w1, 20)}", f"W2 (100 pA dentro de +-3 % a tt 27 y ff -40): {v(w2, 2)}",
      f"W3 (testigo, 8 puntos entre -1,2 y -0,8 %): {v(w3, 8)}", f"W4 (I = 0 sin flancos, 4 esquinas): {v(w4, 4)}",
      f"W5 (IL: <= 5 pA en frio y templado, 5-150 pA a 85 C): {v(w5, 4)}", f"W6 (td entre 2 y 8 ns): {v(w6, 4)}"]
valid = bool(w0) and all(w3) and len(w3) == 8
o.append(f"Benchmark: {'valido' if valid else 'INVALIDO'}")
if valid: o.append("SIGUE: se dibuja el lector 2 con esta arquitectura" if all(w1) and len(w1) == 20 and all(w4) and len(w4) == 4 else "MUERE o no sigue: ver W1 y W4")
open(os.path.join(H, "r2.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
