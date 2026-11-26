"""MISFIT-12: veredictos de A (L1-L4), B (E0-E3) y la relectura C. Escrito ANTES de correr A y B. Salida: m12.txt
Formas fijadas aqui: L1 = |tA(replica 0)/tA(replica 1) - 1|; L2 sobre la media de las dos replicas; L4 = (max - min)/media de
los 12 testigos; E1 frente al % por puesto de 64 puestos de misfit11/w.txt, recalculado desde sus logs."""
import os, re, sys, glob
H = os.path.dirname(os.path.abspath(__file__)); T0 = 1e-6
CN = (("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85"))
def lee(p, tag):
    d = {}
    if os.path.exists(p):
        for l in open(p, errors="replace"):
            f = l.split()
            if f and f[0] == tag:
                try: d[f[3]] = float(f[4]) if len(f) == 5 else None
                except ValueError: d[f[3]] = None
    return d
def ctl(d, c, t):
    r9 = lee(os.path.join(H, "..", "misfit09", f"tr_{c}_{t}", "m9.log"), "M9")
    if d.get("n1_oa") is None or d.get("n1_ob") is None: return None
    return max(abs(d["n1_oa"] / r9["hS_oa"] - 1), abs(d["n1_ob"] / r9["hS_ob"] - 1)) * 100
o = ["# MISFIT-12 · analiza.py · tiempos desde T0 = 1 us"]
LV = (0.30, 0.45, 0.75, 1.50, 3.00, 6.00)
o.append("\n## A · lod12 leida por el lector pequeno (12 puestos, difusion variable)")
R = {k: [] for k in ("L1", "L2", "L4")}; l3 = None; okA = True; eff = {}
for c, t in CN:
    d = lee(os.path.join(H, "A", f"tr_{c}_{t}", "m.log"), "MX"); cc = ctl(d, c, t)
    need = [f"{p}{k}_oa" for p in "lw" for k in range(12)]
    if cc is None or cc > 0.01 or any(d.get(k) is None for k in need):
        o.append(f"{c} {t}: control {cc} o deck incompleto ({[k for k in need if d.get(k) is None][:6]})"); okA = False; continue
    A = [d[f"l{k}_oa"] - T0 for k in range(12)]; W = [d[f"w{k}_oa"] - T0 for k in range(12)]
    rep = [abs(A[2 * i] / A[2 * i + 1] - 1) * 100 for i in range(6)]; m = [(A[2 * i] + A[2 * i + 1]) / 2 for i in range(6)]
    mono = all(m[i] < m[i + 1] for i in range(5)) or all(m[i] > m[i + 1] for i in range(5))
    q = max(m[0], m[4]) / min(m[0], m[4]); sp = (max(W) - min(W)) / (sum(W) / 12) * 100; e = abs(m[4] / m[0] - 1) * 100; eff[(c, t)] = (e, sp)
    o.append(f"{c} {t}: control {cc:.4f} % | tA (us) por nivel " + ", ".join(f"{v:g}: {x*1e6:.3f}" for v, x in zip(LV, m)))
    o.append(f"  L1 replicas, peor diferencia {max(rep):.4f} % | L2 monotono: {'si' if mono else 'NO'} | cociente 0,30 / 3,00: {q:.3f} | L4 testigo sin efecto: dispersion de los 12 = {sp:.4f} % (efecto 0,30 -> 3,00: {e:.1f} %)")
    R["L1"].append(max(rep) <= 0.05); R["L2"].append(mono); R["L4"].append(sp <= 0.3)
    if (c, t) == ("tt", "27"): l3 = q
v = lambda x: ("cumplida" if all(x) else "FALSA") if len(x) == 4 else f"sin veredicto ({len(x)} de 4)"
o += [f"L1 (replicas dentro de 0,05 %): {v(R['L1'])}", f"L2 (monotono en los 6 niveles): {v(R['L2'])}",
      f"L3 (cociente a tt 27 entre 1,5 y 1,8): {('cumplida' if 1.5 <= l3 <= 1.8 else 'FALSA') + f' ({l3:.3f})' if l3 else 'sin dato'}",
      f"L4 (testigo: 12 puestos iguales dentro de 0,3 %): {v(R['L4'])}",
      f"Muere XC-12 en esta forma (el testigo falla por mas que el efecto): {'SI' if any(sp > e for e, sp in eff.values()) else 'no'}", f"Prueba A: {'valida' if okA else 'INVALIDA'}"]
o.append("\n## B · 128 puestos con cableado")
lg = open(os.path.join(H, "u128", "u128.log")).read(); drc = int(re.search(r"^DRC \S+ violations=(\d+)", lg, re.M)[1])
kl = [open(os.path.join(H, "u128", f)).read().count("<item>") for f in ("klayout_mr.lyrdb", "klayout_full.lyrdb")]
lvs = re.search(r"Final result:\s*\n?(.*)", open(os.path.join(H, "u128", "netgen_u128_ref.txt")).read())[1].strip()
bb = [int(x) * 0.005 for x in re.search(r"^BBOX (.*)", lg, re.M)[1].split()[:4]]
o.append(f"E0: Magic {drc}, KLayout {kl[0]} / {kl[1]}, LVS '{lvs}', caja {bb[2]-bb[0]:.2f} x {bb[3]-bb[1]:.2f} um -> {'cumplida' if drc == 0 and kl == [0, 0] and lvs.startswith('Circuits match') else 'FALSA'}")
E = {k: [] for k in ("E1", "E2", "E3")}; okB = True
for c, t in CN:
    d = lee(os.path.join(H, "B", f"tr_{c}_{t}", "m.log"), "MX"); cc = ctl(d, c, t)
    need = [f"{r}_oa" for r in ("wc", "t1", "m128_0", "m128_127", "t128_0")]
    if cc is None or cc > 0.01 or any(d.get(k) is None for k in need): o.append(f"{c} {t}: control {cc} o deck incompleto"); okB = False; continue
    a = {r: d[r + "_oa"] - T0 for r in ("n1", "wc", "t1", "m128_0", "m128_127", "t128_0")}; wc = (a["wc"] / a["n1"] - 1) * 100
    if not 0.4 <= wc <= 0.9: o.append(f"{c} {t}: testigo 1 fF {wc:+.4f} % FALLA"); okB = False; continue
    d64 = lee(os.path.join(H, "..", "misfit11", "w", f"tr_{c}_{t}", "m.log"), "MW")
    p64 = max((d64[f"m64_{k}_oa"] - T0) / (d64["n1_oa"] - T0) - 1 for k in (0, 63)) * 100 / 64
    p128 = max(a["m128_0"], a["m128_127"]) / a["n1"]; per = (p128 - 1) * 100 / 128
    s1 = (a["t1"] / a["n1"] - 1) * 100; s = (a["t128_0"] / a["m128_0"] - 1) * 100; rel = (s / s1 - 1) * 100
    o.append(f"{c} {t}: control {cc:.4f} %, testigo {wc:+.4f} % | % por puesto {per:+.4f} (64 puestos: {p64:+.4f}; {(per/p64-1)*100:+.2f} %) | tA(128)/tA(solo) = {p128:.4f} | salto {s:+.4f} % frente a {s1:+.4f} % ({rel:+.2f} % rel.) | puesto 0 frente a 127: {(a['m128_0']/a['m128_127']-1)*100:+.4f} %")
    E["E1"].append(abs(per / p64 - 1) <= 0.03); E["E2"].append(p128 <= 1.5); E["E3"].append(abs(rel) <= 5)
o += [f"E1 (por puesto dentro de +-3 % del de 64): {v(E['E1'])}", f"E2 (<= 1,5 veces): {v(E['E2'])}", f"E3 (salto cambia <= 5 % rel.): {v(E['E3'])}", f"Prueba B: {'valida' if okB else 'INVALIDA'}"]
if okB and len(E["E2"]) == 4: o.append("DECIDE: 128 es alcanzable con cableado; 64 queda con margen de 2" if all(E["E2"]) and all(E["E3"]) else "DECIDE: el techo con cableado esta entre 64 y 128")
# ---- C: relectura (exploracion)
sys.path.insert(0, os.path.join(H, "..", "noche_1125"))
def fit(pts):
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
def periodos(pat, pre):
    D = {}
    for f in glob.glob(pat):
        b = os.path.basename(os.path.dirname(f))
        if not b.startswith(pre) or "_m_" not in b: continue
        for l in open(f, errors="replace"):
            x = l.split()
            if x and x[0] == "R2" and len(x) == 7:
                try: D[(x[1], x[2], float(f"{float(x[4]):.4e}"))] = (float(x[6]) - float(x[5])) / 10
                except ValueError: pass
    return D
o.append("\n## C · lector 2 en dos rangos, relectura de datos ya vistos (EXPLORACION, no veredicto)")
for nom, D, cal, juz in (("rango bajo, L = 1,00", periodos(os.path.join(H, "..", "noche_1125", "A", "*", "lec.log"), "L1.00_"), (1e-9, 3.1623e-8, 1e-6), (1e-10, 3.1623e-10, 1e-8, 1e-7)),
                         ("rango alto, L = 0,15", periodos(os.path.join(H, "..", "xc20_lector", "r2", "*", "lec.log"), ""), (3.1623e-8, 1e-6, 1e-5), (1e-8, 1e-7, 3.1623e-6))):
    worst = 0
    for c, t in CN:
        pts = [(i, D.get((c, t, i))) for i in cal]; fp = None if any(p[1] is None for p in pts) else fit(pts)
        if fp is None: o.append(f"{nom} · {c} {t}: sin ajuste ({pts})"); worst = float("inf"); continue
        q, il, td = fp; e = {i: (D[(c, t, i)] / (q / (i - il) + td) - 1) * 100 for i in juz if D.get((c, t, i))}
        worst = max([worst] + [abs(x) for x in e.values()])
        o.append(f"{nom} · {c} {t}: Q = {q*1e15:.1f} fC, IL = {il*1e12:+.2f} pA, td = {td*1e9:.2f} ns | " + ", ".join(f"{i:.3g} A: {x:+.2f} %" for i, x in e.items()))
    o.append(f"{nom}: peor error {worst:.2f} % -> apuesta (+-3 %) {'acertada' if worst <= 3 else 'fallada'}")
open(os.path.join(H, "m12.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
