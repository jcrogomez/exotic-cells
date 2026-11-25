"""MISFIT-07: veredictos F1-F5 con las palabras del prerregistro. Escrito ANTES de ver ninguna salida. Salida: m7.txt"""
import os
H = os.path.dirname(os.path.abspath(__file__)); T0 = 1e-6; KS = (33, 16, 8, 4, 2, 0)
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
o = ["# MISFIT-07 · analiza_m7.py · tiempos desde T0 = 1 us. S = salto, X = diafonia hacia B, P = paso de calibracion, D = desplazamiento de tA"]
okk = {k: True for k in KS}; bench = True; f5 = 0; nd = 0
for c, t in CN:
    p = os.path.join(H, f"tr_{c}_{t}", "m7.log"); d = {}; last = "sin log"
    if os.path.exists(p):
        for l in open(p, errors="replace"):
            f = l.split(); last = l.strip() or last
            if f and f[0] == "M7":
                try: d[f[3]] = float(f[4]) if len(f) == 5 else None
                except ValueError: d[f[3]] = None
    need = [f"{g}{k}_{s}" for k in KS for g in "htrc" for s in ("oa", "ob")]
    miss = [x for x in need if d.get(x) is None]
    if miss: o.append(f"{c} {t}: DECK INCOMPLETO, faltan {len(miss)} medidas, p. ej. {miss[:4]} ({last})"); bench = False; continue
    ca = (d["h33_oa"] / C[(c, t, "h01_oa")] - 1) * 100; cb = (d["h33_ob"] / C[(c, t, "h01_ob")] - 1) * 100
    okc = abs(ca) <= 0.01 and abs(cb) <= 0.01
    o.append(f"{c} {t}: control h33 frente al contrato: A {ca:+.4f} %, B {cb:+.4f} % -> {'ok' if okc else 'FALLA: el deck no cuenta'}")
    if not okc: bench = False; continue
    nd += 1; q = {}
    for k in KS:
        A = lambda g: d[f"{g}{k}_oa"] - T0; B = lambda g: d[f"{g}{k}_ob"] - T0
        q[k] = dict(S=(A("t") / A("h") - 1) * 100, X=abs(B("t") / B("h") - 1) * 100, P=(A("c") / B("c") - A("r") / B("r")) * 100, tA=A("h"), vb=d.get(f"h{k}_vb"))
    for k in KS:
        r = q[k]; r0 = q[33]
        dS = (r["S"] / r0["S"] - 1) * 100; dP = (r["P"] / r0["P"] - 1) * 100; D = (r["tA"] / r0["tA"] - 1) * 100; dvb = (r["vb"] - r0["vb"]) * 1e3
        ok = abs(dS) < 2 and r["X"] <= 0.08 and abs(dP) < 2 and abs(D) <= 0.5
        okk[k] &= ok
        o.append(f"  k={k:2d}: S {r['S']:+.4f} % (cambio {dS:+.2f} %); X {r['X']:.5f} %; P {r['P']:+.4f} % (cambio {dP:+.2f} %); D {D:+.4f} %; VB {r['vb']:.5f} V ({dvb:+.3f} mV) -> {'cumple' if ok else 'NO cumple'}")
    w = q[0]["X"] >= 3 * q[33]["X"]; f5 += w
    o.append(f"  F5 en esta esquina: X(0) = {q[0]['X']:.5f} %, X(33) = {q[33]['X']:.5f} % -> {'ve el filtro' if w else 'no lo ve'}")
if nd == 4:
    pred = all(okk[k] for k in (33, 16, 8, 4))
    o.append(f"F1-F4 (k >= 4 cumple en las 4 esquinas): {'cumplidas' if pred else 'FALSA alguna'}; por k: " + ", ".join(f"k={k} {'si' if okk[k] else 'no'}" for k in KS))
    o.append(f"F5 (testigo, >= 3 de 4 esquinas): {f5} de 4 -> {'cumplida' if f5 >= 3 else 'FALSA'}"); bench &= f5 >= 3
    kmin = None
    for k in sorted(KS):
        if all(okk[j] for j in KS if j >= k): kmin = k; break
    o.append(f"Benchmark: {'valido' if bench else 'INVALIDO'}")
    if bench:
        o.append(f"Corte: el k mas pequeno que cumple (con todos los mayores) = {kmin} dedos = {kmin * 55} um2 de puerta")
        o.append("SIGUE: el filtro cabe en la franja (k <= 8)" if kmin is not None and kmin <= 8 else "MUERE: hace falta k >= 16")
else: o.append(f"Sin veredicto: {nd} de 4 esquinas validas"); 
open(os.path.join(H, "m7.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
