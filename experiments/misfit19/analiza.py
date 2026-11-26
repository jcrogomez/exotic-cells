"""MISFIT-19: ventanas [V_lo, V_hi] (100 pA a 10 uA) y veredictos G1..G6. Escrito antes de correr. Uso: analiza.py > m19.txt"""
import os, math
import gen
H = gen.H; LO, HI = 1e-10, 1e-5; W = {}; mono = True; S = {}
def load(c, t, x):
    R = [[float(v) for v in l.split()] for l in open(os.path.join(H, f"op_{c}_{t}", f"f_{x}.txt")) if l.strip()]
    return [r[0] for r in R], [[-r[k] for r in R] for k in (1, 2, 3)]
def cruce(v, i, lim):          # interpolacion log-lineal del primer cruce hacia arriba
    for a in range(len(v) - 1):
        if i[a] < lim <= i[a + 1] and i[a] > 0: return v[a] + (v[a + 1] - v[a]) * math.log(lim / i[a]) / math.log(i[a + 1] / i[a])
    return None
for c, t in gen.CORN:
    for x in gen.XS:
        v, cols = load(c, t, x); assert len(v) == 361, len(v)
        for k, (n, _) in enumerate(gen.DEV):
            i = cols[k]; S[(c, t, x, n)] = (v, i)
            if any(i[a + 1] < i[a] * (1 - 1e-6) for a in range(len(i) - 1)): mono = False; print("NO MONOTONA:", c, t, x, n)
            lo = cruce(v, i, LO); hi = cruce(v, i, HI); W[(c, t, x, n)] = (0.0 if (lo is None and i[0] >= LO) else lo, hi, i[0], i[-1])
f = lambda z: " ---- " if z is None else f"{z:6.3f}"
print("# MISFIT-19 · ventana de V_fg con corriente entre 100 pA y 10 uA. V_hi '----' = no llega a 10 uA en el barrido (hasta 1,8 V)")
for x in gen.XS:
    print(f"\n## X = {x} V      (V_lo, V_hi en V; I a V_fg = 0 y a 1,8 V en A)")
    for n, _ in gen.DEV:
        for c, t in gen.CORN:
            lo, hi, i0, i1 = W[(c, t, x, n)]; print(f"  {n} {c:>2} {t:>3}: V_lo {f(lo)}  V_hi {f(hi)}   I(0) {i0:.2e}  I(1,8) {i1:.2e}")
X = "1.35"; V = {}
lo, hi = W[("tt", "27", X, "T1")][:2]; V["G1"] = lo is not None and hi is not None and 0.22 <= lo <= 0.40 and 0.70 <= hi <= 0.95
lo3, hi3 = W[("tt", "27", X, "T3")][:2]; V["G2"] = lo3 is not None and 0.45 <= lo3 <= 0.80 and (hi3 is None or hi3 >= 1.15)
print("\n## Union T1 + T3 por esquina (X = 1,35 V), recortada a 0-1,3 V")
g3 = []; g4 = []; cub = []
for c, t in gen.CORN:
    a1, b1 = W[(c, t, X, "T1")][:2]; a3, b3 = W[(c, t, X, "T3")][:2]; b1 = 1.8 if b1 is None else b1; b3 = 1.8 if b3 is None else b3
    cont = a3 <= b1; span = (max(b1, b3) - min(a1, a3)) if cont else max(b1 - a1, b3 - a3)
    segs = [(a1, b1), (a3, b3)] if not cont else [(min(a1, a3), max(b1, b3))]; cu = sum(max(0, min(b, 1.3) - max(a, 0)) for a, b in segs)
    g3.append(span >= 0.75); g4.append(not (a1 <= 0 and b1 >= 1.3)); cub.append(cu)
    print(f"  {c:>2} {t:>3}: T1 [{a1:.3f}, {b1:.3f}]  T3 [{a3:.3f}, {b3:.3f}]  {'continuo' if cont else 'CON HUECO'}, tramo {span:.3f} V; cubre {cu:.3f} V de 0-1,3; sin cubrir por abajo {max(0, min(a1, a3)):.3f} V, por arriba {max(0, 1.3 - max(b1, b3)):.3f} V")
V["G3"] = all(g3); V["G4"] = all(g4)
los = [W[(c, t, X, "T1")][0] for c, t in gen.CORN]; V["G5"] = max(los) - min(los) < 0.25; print(f"\nV_lo de T1 en las 4 esquinas: {[round(z, 3) for z in los]}, recorrido {max(los) - min(los):.3f} V")
v, i = S[("tt", "27", X, "T1")]; k = min(range(len(v)), key=lambda a: abs(v[a] - (lo + hi) / 2)); r = i[k + 2] / i[k] - 1
V["G6 testigo"] = 0.20 <= r <= 0.40; print(f"testigo: T1 tt 27 en V_fg = {v[k]:.3f} V, +10 mV sube la corriente {r * 100:.1f} %  (pendiente {10 / math.log10(1 + r):.1f} mV por decada)")
print("\n## Veredictos")
for a, b in V.items(): print(f"{a}: {'cumplida' if b else 'FALSA'}")
print("criterio de muerte (cubren < 0,40 V de 0-1,3 en alguna esquina):", "CUMPLIDO" if min(cub) < 0.40 else f"no cumplido (minimo {min(cub):.3f} V)")
print("benchmark:", "valido" if V["G6 testigo"] and mono else "INVALIDO")
