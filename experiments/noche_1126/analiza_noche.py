"""Plan nocturno 2026-11-26: veredictos de los bloques K, S, W, N, M. Escrito antes de lanzar la cola. Uso: analiza_noche.py > noche.txt
Periodo = media de los diez intervalos entre los flancos 2..12. Modelo T = Q/(I - IL) + td, tres corrientes de calibracion (como MISFIT-24)."""
import os, statistics
import gen_noche as g
H = g.H; G = g.G; M24 = os.path.join(H, "..", "misfit24", "d"); BAD = []


def log(path):
    f = os.path.join(path, "lec.log")
    if not os.path.exists(f): BAD.append((path, "sin log")); return []
    L = open(f, errors="replace").read().splitlines()
    if not L or L[-1].strip() != "salida 0": BAD.append((os.path.relpath(path, H), L[-1].strip() if L else "vacio"))
    return L


def edges(L, key="ED", tag=None):
    e = {}
    for l in L:
        x = l.split()
        try:
            if tag is None and len(x) == 3 and x[0] == key: e[int(x[1])] = float(x[2])
            if tag is not None and len(x) == 4 and x[0] == key and x[1] == tag: e[int(x[2])] = float(x[3])
        except ValueError: pass
    return e


def periodo(e):
    per = [e[n + 1] - e[n] for n in range(2, 12) if n in e and n + 1 in e]
    return (statistics.mean(per), len(e)) if len(per) == 10 else (None, len(e))


def fit(pts):
    if any(t is None for _, t in pts): return None
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


def lee(d): return periodo(edges(log(d)))
def err(fp, T, i): return None if (fp is None or T is None) else ((fp[0] / (T - fp[2]) + fp[1]) / i - 1) * 100
def caso24(rng, c, t, k, i): return os.path.join(M24, f"{rng}_{c}{t}_{k}_{i:.4e}")
def fit24(rng, c, t): return fit([(i, lee(caso24(rng, c, t, k, i))[0]) for k, i in g.CASOS[rng] if k == "cal"])
def r(x, n=2): return None if x is None else round(x, n)
def ver(name, ok, extra=""): print(f"{name}: {'cumplida' if ok else 'FALSA'} {extra}")


# ---------- K
print("## Bloque K · el contador de rizado sigue al lazo a 10 uA (rango alto)"); k1 = []
for c, t in G.CORN:
    kd = {}
    for l in log(os.path.join(H, "K", f"{c}{t}")):
        x = l.split()
        if len(x) == 3 and x[0] == "KD":
            try: kd[x[1]] = float(x[2])
            except ValueError: pass
    need = ("q1", "q8", "q9", "q24", "k0_1", "k3_1", "k3_2")
    if any(n not in kd for n in need): print(f"  {c} {t}: faltan medidas {sorted(kd)}"); k1.append(False); continue
    d1, d2, per = (kd["k3_1"] - kd["q8"]) * 1e9, (kd["k3_2"] - kd["q24"]) * 1e9, (kd["q24"] - kd["q8"]) / 16 * 1e9
    ok = 0 < d1 < 3 and 0 < d2 < 3 and kd["k3_1"] < kd["q9"]; k1.append(ok)
    print(f"  {c} {t}: bit 3 sube {d1:.3f} ns tras el flanco 8 y {d2:.3f} ns tras el 24; bit 0 {(kd['k0_1'] - kd['q1']) * 1e9:.3f} ns tras el 1; periodo de q {per:.3f} ns")
ver("K1 (bit 3 entre 0 y 3 ns tras los flancos 8 y 24, 4 de 4)", len(k1) == 4 and all(k1), f"({sum(k1)} de {len(k1)})")

# ---------- S
print("\n## Bloque S · alimentacion a 1,70 y 1,90 V"); s1 = []; s2 = []
for c, t in (("tt", "27"), ("ss", "85")):
    for rng in G.LP:
        f0 = fit24(rng, c, t); i = g.MID[rng]
        for v in (1.70, 1.90):
            R = {(k, ii): lee(os.path.join(H, "S", f"{rng}_{c}{t}_v{v:.2f}_{k}_{ii:.4e}"))[0] for k, ii in g.sub(rng)}
            fp = fit([(ii, R[(k, ii)]) for k, ii in g.sub(rng) if k == "cal"]); T = R[("oos", i)]
            e_re, e_18 = err(fp, T, i), err(f0, T, i); s1.append((rng, c, t, v, e_re)); s2.append((rng, c, t, v, e_18))
            dq = None if not (fp and f0) else (fp[0] / f0[0] - 1) * 100
            print(f"  {rng} {c} {t} {v:.2f} V: Q {r(dq)} % frente a 1,80 V | recalibrado: error {r(e_re)} % | con la calibracion de 1,80 V: error {r(e_18)} %")
ver("S1 (recalibrado a la alimentacion movida, dentro de +-3 %, 8 de 8)", len(s1) == 8 and all(x[4] is not None and abs(x[4]) <= 3 for x in s1), f"{[r(x[4]) for x in s1]}")
ok2 = lambda x: x[4] is not None and ((3 <= abs(x[4]) <= 8) if x[0] == "alto" else (2 <= abs(x[4]) <= 20))
ver("S2 (con la calibracion de 1,80 V, |error| por 100 mV: alto 3-8 %, bajo 2-20 %, 8 de 8)", len(s2) == 8 and all(ok2(x) for x in s2), f"{[(x[0], x[1], x[3], r(x[4])) for x in s2]}")
print("  mayor |error| con la calibracion de 1,80 V:", max((abs(x[4]) for x in s2 if x[4] is not None), default=None))

# ---------- W
print("\n## Bloque W · cable en el nodo: +20 y +50 fF"); w1 = []; w2 = []; w3 = []
for c, t in (("tt", "27"), ("ss", "85")):
    for rng in G.LP:
        f0 = fit24(rng, c, t); i = g.MID[rng]
        for cw in (20, 50):
            R = {(k, ii): lee(os.path.join(H, "W", f"{rng}_{c}{t}_c{cw}_{k}_{ii:.4e}"))[0] for k, ii in g.sub(rng)}
            fp = fit([(ii, R[(k, ii)]) for k, ii in g.sub(rng) if k == "cal"]); e = err(fp, R[("oos", i)], i)
            dq = None if not (fp and f0) else (fp[0] / f0[0] - 1) * 100
            (w1 if rng == "bajo" else w2).append((c, t, cw, dq)); w3.append((rng, c, t, cw, e))
            print(f"  {rng} {c} {t} +{cw} fF: Q {r(dq)} % frente a MISFIT-24 | error fuera de muestra {r(e)} %")
ver("W1 (rango bajo: Q cambia < 2 %, 4 de 4)", len(w1) == 4 and all(x[3] is not None and abs(x[3]) < 2 for x in w1), f"{[r(x[3]) for x in w1]}")
okw = lambda x: x[3] is not None and ((8 <= x[3] <= 13) if x[2] == 20 else (21 <= x[3] <= 31))
ver("W2 (rango alto: +20 fF da +8..+13 %, +50 fF da +21..+31 %, 4 de 4)", len(w2) == 4 and all(okw(x) for x in w2), f"{[(x[2], r(x[3])) for x in w2]}")
ver("W3 (fuera de muestra dentro de +-3 %, 8 de 8)", len(w3) == 8 and all(x[4] is not None and abs(x[4]) <= 3 for x in w3), f"{[r(x[4]) for x in w3]}")

# ---------- N
print("\n## Bloque N · 63 puestos en el nodo (9 matrices)"); N = {}
for c, t, rng in (("tt", "27", "bajo"), ("ss", "85", "bajo"), ("ff", "85", "bajo"), ("ff", "85", "alto")):
    R = {(k, i): lee(os.path.join(H, "N", f"{rng}_{c}{t}_{k}_{i:.4e}")) for k, i in g.CASOS[rng] if k != "wit"}
    fp = fit([(i, R[(k, i)][0]) for k, i in g.CASOS[rng] if k == "cal"]); z = R[("zero", 0.0)]
    es = [(i, err(fp, R[(k, i)][0], i)) for k, i in g.CASOS[rng] if k == "oos"]; N[(rng, c, t)] = (fp, z, es)
    print(f"  {rng} {c} {t}: " + ("SIN AJUSTE" if fp is None else f"Q = {fp[0]*1e15:.2f} fC, IL = {fp[1]*1e12:+.2f} pA, td = {fp[2]*1e9:.2f} ns")
          + f" | sin corriente: {z[1]} flancos" + (f", periodo {z[0]*1e3:.4f} ms" if z[0] else "") + " | fuera de muestra: " + ", ".join(f"{i:.2e} A {r(e)} %" for i, e in es))
zf, zs, zt = N[("bajo", "ff", "85")][1], N[("bajo", "ss", "85")][1], N[("bajo", "tt", "27")][1]
ver("N1a (bajo ff 85 sin corriente: oscila sola, periodo entre 0,1 y 0,5 ms)", zf[0] is not None and 0.1e-3 <= zf[0] <= 0.5e-3)
ver("N1b (bajo ss 85 sin corriente: al menos 2 flancos en 20 ms)", (zs[1] or 0) >= 2, f"({zs[1]})")
ver("N1c (bajo tt 27 sin corriente: menos de 12 flancos en 20 ms)", (zt[1] or 0) < 12, f"({zt[1]})")
inb = lambda e: e is not None and abs(e) <= 3
n2a = [(c, t, i, e) for (rng, c, t), (fp, z, es) in N.items() if rng == "bajo" for i, e in es if i > 1e-9]
ver("N2a (bajo: 3,16 nA y 100 nA dentro de +-3 % en las 3 esquinas, 6 de 6)", len(n2a) == 6 and all(inb(x[3]) for x in n2a), f"{[(x[0], x[1], f'{x[2]:.2e}', r(x[3])) for x in n2a]}")
e_tt = N[("bajo", "tt", "27")][2][0][1]; e_ff = N[("bajo", "ff", "85")][2][0][1]; e_ss = N[("bajo", "ss", "85")][2][0][1]
ver("N2b (bajo, 316 pA: dentro de +-3 % a tt 27)", inb(e_tt), f"({r(e_tt)})")
ver("N2c (bajo, 316 pA: FUERA de +-3 % a ff 85)", not inb(e_ff), f"({r(e_ff)})")
print(f"  sin prediccion: bajo ss 85 a 316 pA, error {r(e_ss)} %")
ea = N[("alto", "ff", "85")][2]; ver("N3 (alto ff 85: las 3 fuera de muestra dentro de +-3 %)", len(ea) == 3 and all(inb(e) for _, e in ea), f"{[r(e) for _, e in ea]}")
suelo = [i for i in (3.1623e-10, 3.1623e-9, 1e-7) if all(inb(dict(N[("bajo", c, t)][2]).get(i)) for c, t in (("tt", "27"), ("ss", "85"), ("ff", "85")))]
print("  suelo del rango bajo con 63 puestos (menor corriente fuera de muestra que pasa en las 3 esquinas):", f"{min(suelo):.3e} A" if suelo else "NINGUNA")

# ---------- M
print("\n## Bloque M · desajuste (tt_mm, un chip por deck)"); inval = []
for rng in G.LP:
    tags = [("cal0", g.sub(rng)[0][1]), ("cal1", g.sub(rng)[1][1]), ("cal2", g.sub(rng)[2][1]), ("oos", g.MID[rng])]
    def chip(name):
        L = log(os.path.join(H, "M", name)); T = {tg: periodo(edges(L, "MC", tg))[0] for tg, _ in tags}
        fp = fit([(i, T[tg]) for tg, i in tags[:3]]); return T, fp, err(fp, T["oos"], g.MID[rng])
    T0, f0, e0 = chip(f"{rng}_control"); Tr = lee(caso24(rng, "tt", "27", "oos", g.MID[rng]))[0]
    d0 = None if not (T0["oos"] and Tr) else (T0["oos"] / Tr - 1) * 100; m0 = d0 is not None and abs(d0) <= 0.2
    print(f"  {rng} control tt: periodo fuera de muestra {r(d0, 4)} % frente a MISFIT-24; Q = {None if f0 is None else round(f0[0]*1e15, 2)} fC; error {r(e0)} %")
    ver(f"M0 {rng} (control dentro de 0,2 % de MISFIT-24)", m0)
    if not m0: inval.append((rng, "control"))
    Q = []; E = []; osc = 0; n = 0
    for k in range(g.NCHIP):
        s = g.SEED0 + k + (100 if rng == "alto" else 0); T, fp, e = chip(f"{rng}_s{s}"); n += 1
        if all(T[tg] is not None for tg, _ in tags): osc += 1
        if fp: Q.append(fp[0] * 1e15)
        E.append(e)
        print(f"    semilla {s}: Q = {None if fp is None else round(fp[0]*1e15, 2)} fC, IL = {None if fp is None else round(fp[1]*1e12, 3)} pA, error fuera de muestra {r(e)} %")
    if len(set(round(q, 3) for q in Q)) < max(2, len(Q) // 2): inval.append((rng, "semillas repetidas"))
    nin = sum(1 for e in E if inb(e)); sg = statistics.stdev(Q) / statistics.mean(Q) * 100 if len(Q) > 2 else None
    print(f"  {rng}: Q media {None if not Q else round(statistics.mean(Q), 2)} fC, sigma {r(sg)} %, min {None if not Q else round(min(Q), 2)}, max {None if not Q else round(max(Q), 2)}")
    ver(f"M1 {rng} (los {g.NCHIP} chips oscilan en las 4 corrientes)", osc == g.NCHIP == n, f"({osc} de {n})")
    ver(f"M2 {rng} (error calibrado por chip dentro de +-3 % en al menos 38 de 40)", nin >= 38, f"({nin} de {n}); muere si < 36")
    lo, hi = (2, 10) if rng == "bajo" else (0.3, 3)
    ver(f"M3 {rng} (sigma de Q entre {lo} y {hi} %)", sg is not None and lo <= sg <= hi, f"({r(sg)} %)")
print("\nbloque M invalido:", inval or "no")
print("decks que no acabaron en 'salida 0':", BAD or "ninguno")
