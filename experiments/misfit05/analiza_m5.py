"""MISFIT-05: veredictos con las palabras del prerregistro. Escrito ANTES de ver ninguna salida (2026-11-25).
Lee tr_*/m5.log, dc_*/m5.log, lg_*/m5.log y el contrato. Salida: m5.txt"""
import os, math
H = os.path.dirname(os.path.abspath(__file__))
T0 = 1e-6
CN = (("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85"))
C = {}
for l in open(os.path.join(H, "..", "xc19_slot_e2", "diseno", "contrato.txt")):
    f = l.split()
    if len(f) >= 4 and f[0] == "RES":
        for kv in f[3:]:
            if "=" in kv:
                k, v = kv.split("=", 1)
                try: C[(f[1], f[2], k)] = float(v)
                except ValueError: pass
def lee(kind, c, t, tag):
    p = os.path.join(H, f"{kind}_{c}_{t}", "m5.log"); d = {}; rows = []
    if not os.path.exists(p): return d, rows, "sin log"
    last = ""
    for l in open(p, errors="replace"):
        f = l.split(); last = l.strip() or last
        if f and f[0] == tag:
            rows.append(f)
            if tag != "DC":
                try: d[f[3]] = float(f[4]) if len(f) == 5 else None      # 5 campos = un numero; mas = sin cruce
                except ValueError: d[f[3]] = None
    return d, rows, last
o = ["# MISFIT-05 · analiza_m5.py · tiempos desde T0 = 1 us"]
ok_all = {}; bench = True
o.append("\n## Fuga en DC (D1) y testigo de 40 pA")
D1 = {}
for c, t in CN:
    _, rows, last = lee("dc", c, t, "DC")
    v = {(r[3], r[4]): (float(r[5]), float(r[6]), float(r[7])) for r in rows if len(r) == 8}
    if len(v) != 4: o.append(f"{c} {t}: DECK SIN DATOS ({len(v)} de 4; {last})"); bench = False; continue
    worst = 0
    for vx in ("vx=1.8", "vx=0.9"):
        L, Ly, vb = v[(vx, "g=0")]; I = v[(vx, "g=1.8")][0]
        wit = (Ly - L) / 40e-12
        worst = max(worst, L / I)
        okw = abs(wit - 1) <= 0.01; bench &= okw
        o.append(f"{c} {t} {vx}: I = {I:.4e} A; L = {L:.4e} A; L/I = {L/I:.3e}; VB = {vb:.4f}; testigo 40 pA leido {wit*40:.3f} pA -> {'ok' if okw else 'FALLA'}")
    D1[(c, t)] = worst
if len(D1) == 4:
    band = all(1e-6 <= x <= 1e-3 for x in D1.values()); hot = min(D1[("ss", "85")], D1[("ff", "85")]) > max(D1[("tt", "27")], D1[("ff", "-40")])
    cut = all(x <= 1e-3 for x in D1.values())
    o.append(f"D1: L/I maximo por esquina = " + ", ".join(f"{c} {t} {x:.2e}" for (c, t), x in D1.items()))
    o.append(f"D1 prediccion (banda 1e-6..1e-3 y mayor a 85 C): {'cumplida' if band and hot else 'FALSA'} | corte <= 1e-3: {'cumple' if cut else 'NO cumple'} | 15*L/I maximo = {15*max(D1.values())*100:.4f} % (muere si > 5 %)")
    ok_all["D1"] = cut
o.append("\n## Transitorio (D2-D5) y controles")
res = {k: [] for k in ("D2", "D2c", "D3", "D4", "D4c", "D5", "D5c")}
for c, t in CN:
    d, _, last = lee("tr", c, t, "M5")
    need = [f"{r}_{s}" for r in ("n1", "n2", "n4", "n8", "n16", "t1", "t16", "mc", "wi", "wc") for s in ("oa", "ob")]
    if any(d.get(k) is None for k in need):
        o.append(f"{c} {t}: DECK INCOMPLETO, faltan {[k for k in need if d.get(k) is None]} ({last})"); bench = False; continue
    A = {r: d[r + "_oa"] - T0 for r in ("n1", "n2", "n4", "n8", "n16", "t1", "t16", "mc", "wi", "wc")}
    B = {r: d[r + "_ob"] - T0 for r in A}
    ca = (d["n1_oa"] / C[(c, t, "h01_oa")] - 1) * 100; cb = (d["n1_ob"] / C[(c, t, "h01_ob")] - 1) * 100
    okc = abs(ca) <= 0.01 and abs(cb) <= 0.01
    o.append(f"{c} {t}: control n1 frente al contrato: A {ca:+.4f} %, B {cb:+.4f} % -> {'ok' if okc else 'FALLA: el deck no cuenta'}")
    if not okc: bench = False; continue
    mc = A["mc"] / A["n1"]; mcb = (B["mc"] / B["n1"] - 1) * 100
    wi = (A["wi"] / A["n1"] - 1) * 100; wc = (A["wc"] / A["n1"] - 1) * 100
    okm = 0.45 <= mc <= 0.60 and abs(mcb) <= 0.3
    okwi = wi < 0 and (not (c, t) == ("tt", "27") or -3 <= wi <= -0.3)
    okwc = 0.4 <= wc <= 0.9
    bench &= okm and okwi and okwc
    o.append(f"  mutante mc: tA/tA(1) = {mc:.4f}, B {mcb:+.4f} % -> {'ok' if okm else 'FALLA'} | testigo wi (40 pA): {wi:+.4f} % -> {'ok' if okwi else 'FALLA'} | testigo wc (1 fF): {wc:+.4f} % -> {'ok' if okwc else 'FALLA'}")
    per = {n: (A[f"n{n}"] / A["n1"] - 1) * 100 / (n - 1) for n in (2, 4, 8, 16)}
    o.append("  tA (us): " + ", ".join(f"N={n} {A[f'n{n}']*1e6:.4f}" for n in (1, 2, 4, 8, 16)))
    o.append("  D2, % por rama extra: " + ", ".join(f"N={n} {per[n]:+.4f}" for n in per) + f" | tA(16)/tA(1) = {A['n16']/A['n1']:.4f}")
    res["D2"].append(all(0.05 <= per[n] <= 0.30 for n in per)); res["D2c"].append(A["n16"] <= 1.10 * A["n1"])
    lin = per[16] / per[2] - 1 if per[2] else float("nan")
    o.append(f"  D3, linealidad: incremento por rama N=16 frente a N=2 = {lin*100:+.2f} %"); res["D3"].append(abs(lin) <= 0.20)
    s1 = (A["t1"] / A["n1"] - 1) * 100; s16 = (A["t16"] / A["n16"] - 1) * 100; rel = (s16 / s1 - 1) * 100
    o.append(f"  D4, salto de una carga: N=1 {s1:+.4f} %, N=16 {s16:+.4f} %, cambio relativo {rel:+.2f} %")
    res["D4"].append(abs(rel) < 3); res["D4c"].append(abs(rel) <= 5)
    r5 = (math.log(A["n16"] / B["n16"]) - math.log(A["n1"] / B["n1"])) * 100
    o.append(f"  D5, ln(tA/tB) N=16 menos N=1 = {r5:+.5f} puntos de %"); res["D5"].append(abs(r5) <= 0.02); res["D5c"].append(abs(r5) <= 0.0807)
nd = len(res["D2"])
def v(k): return "cumplida" if all(res[k]) and nd == 4 else ("FALSA" if nd == 4 else f"sin veredicto ({nd} de 4 esquinas)")
def cc(k): return "cumple" if all(res[k]) and nd == 4 else ("NO cumple" if nd == 4 else "sin veredicto")
o.append(f"D2 prediccion (+0,05..+0,30 % por rama): {v('D2')} | corte tA(16) <= 1,10 tA(1): {cc('D2c')}")
o.append(f"D3 prediccion (+-20 %): {v('D3')}")
o.append(f"D4 prediccion (< 3 % relativo): {v('D4')} | corte <= 5 %: {cc('D4c')}")
o.append(f"D5 prediccion (<= 0,02): {v('D5')} | corte <= 0,0807: {cc('D5c')}")
for k in ("D2c", "D4c", "D5c"): ok_all[k[:2]] = all(res[k]) and nd == 4
o.append("\n## Todo abierto, 1,4 ms (D6)")
d6 = []
for c, t in (("ss", "85"), ("ff", "85")):
    d, _, last = lee("lg", c, t, "LG")
    if any(d.get(k) is None for k in ("h00_XA_min", "a16_XA_min", "a16_XB_min", "a16_oa_max", "a16_ob_max")):
        o.append(f"{c} {t}: DECK INCOMPLETO ({last})"); bench = False; continue
    cz = (d["h00_XA_min"] / C[(c, t, "h00_XA_min")] - 1) * 100; okc = abs(cz) <= 0.01
    cruza = d["a16_oa_max"] > 0.9 or d["a16_ob_max"] > 0.9
    o.append(f"{c} {t}: control h00 XA_min {d['h00_XA_min']:.5f} frente al contrato {cz:+.4f} % -> {'ok' if okc else 'FALLA'} | a16: XA min {d['a16_XA_min']:.4f} V, XB min {d['a16_XB_min']:.4f} V, salidas max {d['a16_oa_max']:.3f}/{d['a16_ob_max']:.3f} V -> {'CRUZA' if cruza else 'no cruza'}")
    if not okc: bench = False; continue
    d6.append((not cruza, min(d["a16_XA_min"], d["a16_XB_min"]) >= 1.2))
if len(d6) == 2:
    o.append(f"D6 prediccion (no cruza y XA min >= 1,2 V): {'cumplida' if all(a and b for a, b in d6) else 'FALSA'} | corte (no cruza): {'cumple' if all(a for a, _ in d6) else 'NO cumple'}")
    ok_all["D6"] = all(a for a, _ in d6)
o.append("\n## Veredicto")
o.append(f"Benchmark: {'valido' if bench else 'INVALIDO (ver arriba)'}")
if bench and len(ok_all) == 5:
    o.append("SIGUE: un lector puede llevar hasta 16 ramas (cortes de D1, D2, D4, D5 y D6 en las 4 esquinas)" if all(ok_all.values())
             else "No sigue tal cual: fallan los cortes de " + ", ".join(k for k, x in ok_all.items() if not x))
open(os.path.join(H, "m5.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
