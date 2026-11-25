"""MISFIT-09: veredicto S5 y controles. Escrito ANTES de ver ninguna salida. Salida: m9.txt"""
import os, math
H = os.path.dirname(os.path.abspath(__file__)); T0 = 1e-6
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
o = ["# MISFIT-09 · analiza_m9.py · B = macro v_hm (33 dedos), S = macro pequeno v_f3 (3 dedos). Tiempos desde T0 = 1 us"]
ok5 = []; bench = True
for c, t in CN:
    p = os.path.join(H, f"tr_{c}_{t}", "m9.log"); d = {}; last = "sin log"
    if os.path.exists(p):
        for l in open(p, errors="replace"):
            f = l.split(); last = l.strip() or last
            if f and f[0] == "M9":
                try: d[f[3]] = float(f[4]) if len(f) == 5 else None
                except ValueError: d[f[3]] = None
    need = [f"{g}{m}_{s}" for m in "BS" for g in "htrc" for s in ("oa", "ob")] + ["wS_oa"]
    miss = [x for x in need if d.get(x) is None]
    if miss: o.append(f"{c} {t}: DECK INCOMPLETO, faltan {miss[:5]} ({last})"); bench = False; continue
    ca = (d["hB_oa"] / C[(c, t, "h01_oa")] - 1) * 100; cb = (d["hB_ob"] / C[(c, t, "h01_ob")] - 1) * 100
    okc = abs(ca) <= 0.01 and abs(cb) <= 0.01
    o.append(f"{c} {t}: control hB frente al contrato: A {ca:+.4f} %, B {cb:+.4f} % -> {'ok' if okc else 'FALLA: el deck no cuenta'}")
    if not okc: bench = False; continue
    q = {}
    for m in "BS":
        A = lambda g: d[f"{g}{m}_oa"] - T0; B = lambda g: d[f"{g}{m}_ob"] - T0
        q[m] = dict(tA=A("h"), S=(A("t") / A("h") - 1) * 100, P=(A("c") / B("c") - A("r") / B("r")) * 100, R=math.log(A("h") / B("h")) * 100)
    dT = (q["S"]["tA"] / q["B"]["tA"] - 1) * 100; dS = (q["S"]["S"] / q["B"]["S"] - 1) * 100; dP = (q["S"]["P"] / q["B"]["P"] - 1) * 100; dR = q["S"]["R"] - q["B"]["R"]
    w = ((d["wS_oa"] - T0) / q["S"]["tA"] - 1) * 100; okw = 0.4 <= w <= 0.9; bench &= okw
    ok = abs(dT) <= 0.5 and abs(dS) <= 2 and abs(dP) <= 2 and abs(dR) <= 0.02; ok5.append(ok)
    o.append(f"  tA: B {q['B']['tA']*1e6:.4f} us, S {q['S']['tA']*1e6:.4f} us ({dT:+.4f} %) | salto: B {q['B']['S']:+.4f} %, S {q['S']['S']:+.4f} % ({dS:+.2f} % rel.) | paso: B {q['B']['P']:+.4f} %, S {q['S']['P']:+.4f} % ({dP:+.2f} % rel.) | ln(tA/tB): {dR:+.5f} puntos -> {'cumple' if ok else 'NO cumple'}")
    o.append(f"  testigo (1 fF en XA del pequeno): {w:+.4f} % -> {'ok' if okw else 'FALLA'}")
if len(ok5) == 4:
    o.append(f"S5 (4 esquinas): {'cumplida' if all(ok5) else 'FALSA'}"); o.append(f"Benchmark (controles y testigo): {'valido' if bench else 'INVALIDO'}")
else: o.append(f"Sin veredicto de S5: {len(ok5)} de 4 esquinas validas")
p = os.path.join(H, "ac_tt_27", "m9.log")
if os.path.exists(p):
    o.append("Capacidad de VB (AC, tt 27; sin prediccion): C = -Im(V)/(2 pi f |V|^2) con 1 A de prueba")
    for l in open(p, errors="replace"):
        f = l.split()
        if f and f[0] == "AC" and len(f) == 5:
            fr, x, y = float(f[2]), float(f[3]), float(f[4]); cap = -y / (2 * math.pi * fr * (x * x + y * y))
            o.append(f"  macro {f[1]} a {fr:.0e} Hz: C = {cap*1e12:.3f} pF; R paralelo = {(x*x+y*y)/x/1e3 if x else float('inf'):.0f} kOhm")
open(os.path.join(H, "m9.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
