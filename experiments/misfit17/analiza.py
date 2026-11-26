"""MISFIT-17: veredictos R1..R6. Escrito antes de correr. Uso: analiza.py > m17.txt. T = (flanco 12 - flanco 2)/10.
Modelo por (rango, esquina): T = Q/(I - IL) + td con las 3 corrientes de calibracion; I_leida = Q/(T - td) + IL."""
import os, glob
import gen
H = gen.H; D = {}; CD = []; nlog = 0
for f in glob.glob(os.path.join(H, "d", "*", "lec.log")):
    nlog += 1
    for l in open(f, errors="replace"):
        t = l.split()
        if t and t[0] == "R17":
            try: T = (float(t[7]) - float(t[6])) / 10 if len(t) == 8 else None
            except ValueError: T = None
            D[(t[3], t[1], t[2], t[4], float(t[5]))] = T
        if t and t[0] == "CD" and len(t) == 2: CD.append(float(t[1]))
    if any(l.strip().startswith("r1 ") for l in open(f, errors="replace")): D[("r1", os.path.basename(os.path.dirname(f)))] = True
def fit(pts):      # copia de noche_1125/analiza_A.py
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
print(f"# MISFIT-17 · logs leidos: {nlog} de 88 · control de capacidad del diodo de isla: {len(CD)} valores, min {min(CD)*1e15 if CD else float('nan'):.3f} fF, max {max(CD)*1e15 if CD else float('nan'):.3f} fF")
cdok = bool(CD) and all(0.5e-15 <= x <= 3e-15 for x in CD)
V = {k: [] for k in ("R1", "R2", "R3", "R4", "R5", "R6")}; INV = []
for rng in gen.LP:
    for c, t in gen.CORN:
        cas = gen.CASOS[rng]; g = lambda caso, i: D.get((rng, c, t, caso, float(f"{i:.4e}")))
        cal = [(i, g("cal", i)) for k, i in cas if k == "cal"]; fp = None if any(x[1] is None for x in cal) else fit(cal)
        print(f"\n## rango {rng} · {c} {t}")
        if fp is None: print("  SIN AJUSTE:", cal); INV.append((rng, c, t)); continue
        q, il, td = fp; print(f"  ajuste: Q = {q*1e15:.2f} fC, IL = {il*1e12:+.3f} pA, td = {td*1e9:.2f} ns")
        rd = lambda T: q / (T - td) + il
        for k, i in cas:
            T = g(k, i)
            if k == "oos":
                e = None if T is None else (rd(T) / i - 1) * 100; V["R1"].append((rng, c, t, i, e)); print(f"  fuera de muestra {i:.3e} A: " + ("sin periodo" if T is None else f"T = {T:.4e} s, leida {rd(T):.4e} A, error {e:+.2f} %"))
            if k in ("sh1", "sh3"):
                r = None if T is None else rd(T) / i; V["R6"].append((rng, c, t, k, r)); print(f"  forma n={k[2]} I0 = {i:.1e} A: " + ("sin periodo" if T is None else f"leida/I0 = {r:.4f}"))
            if k == "wit":
                T0 = g("oos", 3.1623e-9 if rng == "bajo" else 1e-6); d = None if not (T and T0) else (T / T0 - 1) * 100; V["R3"].append((rng, c, t, d)); print(f"  testigo +1 %: periodo {d if d is None else round(d, 3)} %")
                if d is None or not (-1.2 <= d <= -0.8): INV.append((rng, c, t))
            if k == "zero":
                edge = D.get(("r1", f"{rng}_{c}{t}_zero_{0.0:.4e}"), False); V["R4"].append((rng, c, t, not edge)); print("  sin corriente:", "HAY FLANCOS" if edge else "ningun flanco en 20 ms")
            if k == "s6":
                T0 = g("oos", i); d = None if not (T and T0) else (T / T0 - 1) * 100; V["R5"].append((c, t, d)); print(f"  puesto 6 frente a 0: {d if d is None else round(d, 4)} %")
            if k == "bare":
                T0 = g("oos", i); r = None if not (T and T0) else T0 / T; V["R2"].append((c, t, r)); print(f"  periodo con matriz / sin matriz: {r if r is None else round(r, 4)}")
print("\n## Veredictos")
r1 = [x for x in V["R1"]]; f1 = [x for x in r1 if x[4] is None or abs(x[4]) > 3]
print(f"R1 (24 lecturas fuera de muestra dentro de +-3 %): {'cumplida' if len(r1) == 24 and not f1 else 'FALSA'} ({len(r1) - len(f1)} de {len(r1)}); fallan: {[(a, b, c_, f'{i:.2e}', None if e is None else round(e, 2)) for a, b, c_, i, e in f1]}")
r2 = V["R2"]; print(f"R2 (periodo con/sin matriz entre 1,12 y 1,30): {'cumplida' if len(r2) == 4 and all(x[2] and 1.12 <= x[2] <= 1.30 for x in r2) else 'FALSA'} {[None if x[2] is None else round(x[2], 4) for x in r2]}")
r3 = V["R3"]; print(f"R3 (testigo entre -1,2 y -0,8 %): {'cumplida' if len(r3) == 8 and all(x[3] is not None and -1.2 <= x[3] <= -0.8 for x in r3) else 'FALSA'} {[None if x[3] is None else round(x[3], 3) for x in r3]}")
r4 = V["R4"]; print(f"R4 (sin corriente, ningun flanco): {'cumplida' if len(r4) == 8 and all(x[3] for x in r4) else 'FALSA'} ({sum(1 for x in r4 if x[3])} de {len(r4)})")
r5 = V["R5"]; print(f"R5 (puesto 6 frente a 0 dentro de 0,5 %): {'cumplida' if len(r5) == 4 and all(x[2] is not None and abs(x[2]) <= 0.5 for x in r5) else 'FALSA'} {[None if x[2] is None else round(x[2], 4) for x in r5]}")
ok6 = lambda k, r: r is not None and ((0.68 <= r <= 0.78) if k == "sh1" else (0.25 <= r <= 0.42))
r6 = V["R6"]; print(f"R6 (ohmica 0,68-0,78; cubica 0,25-0,42): {'cumplida' if len(r6) == 16 and all(ok6(x[3], x[4]) for x in r6) else 'FALSA'} ({sum(1 for x in r6 if ok6(x[3], x[4]))} de {len(r6)})")
print("casos invalidos (testigo o calibracion):", sorted(set(INV)) or "ninguno"); print("control de capacidad:", "bien" if cdok else "FALLA -> tanda INVALIDA")
