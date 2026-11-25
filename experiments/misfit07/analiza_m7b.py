"""MISFIT-07 enmienda 1: veredictos G1-G3. Escrito ANTES de ver ninguna salida de as_*. Salida: m7b.txt"""
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
o = ["# MISFIT-07 enmienda 1 · analiza_m7b.py · K = golpe sobre VB (mV), Sa = salto en lectura asincrona, Da = desplazamiento de tA(a) frente a k = 33"]
okk = {k: True for k in KS}; bench = True; nd = 0
for c, t in CN:
    p = os.path.join(H, f"as_{c}_{t}", "m7.log"); d = {}; last = "sin log"
    if os.path.exists(p):
        for l in open(p, errors="replace"):
            f = l.split(); last = l.strip() or last
            if f and f[0] == "M7":
                try: d[f[3]] = float(f[4]) if len(f) == 5 else None
                except ValueError: d[f[3]] = None
    need = [f"{g}{k}_{s}" for k in KS for g in ("h", "a", "at") for s in ("oa", "ob")] + [f"a{k}_{s}" for k in KS for s in ("vb0", "vbmax", "vbmin")]
    miss = [x for x in need if d.get(x) is None]
    if miss: o.append(f"{c} {t}: DECK INCOMPLETO o A no cruza: faltan {len(miss)}, p. ej. {miss[:4]} ({last})"); bench = False; continue
    ca = (d["h33_oa"] / C[(c, t, "h01_oa")] - 1) * 100; cb = (d["h33_ob"] / C[(c, t, "h01_ob")] - 1) * 100
    okc = abs(ca) <= 0.01 and abs(cb) <= 0.01
    o.append(f"{c} {t}: control h33 frente al contrato: A {ca:+.4f} %, B {cb:+.4f} % -> {'ok' if okc else 'FALLA: el deck no cuenta'}")
    if not okc: bench = False; continue
    nd += 1; q = {}
    for k in KS:
        ta = d[f"a{k}_oa"] - T0; tat = d[f"at{k}_oa"] - T0; tb = d[f"a{k}_ob"] - T0
        K = max(d[f"a{k}_vbmax"] - d[f"a{k}_vb0"], d[f"a{k}_vb0"] - d[f"a{k}_vbmin"]) * 1e3
        q[k] = dict(ta=ta, tb=tb, Sa=(tat / ta - 1) * 100, K=K)
    for k in KS:
        r = q[k]; r0 = q[33]; dS = (r["Sa"] / r0["Sa"] - 1) * 100; Da = (r["ta"] / r0["ta"] - 1) * 100
        ok = abs(dS) < 2 and abs(Da) <= 0.08; okk[k] &= ok
        o.append(f"  k={k:2d}: tA {r['ta']*1e6:.3f} us, tB {r['tb']*1e6:.3f} us (A/B = {r['ta']/r['tb']:.2f}); K {r['K']:.4f} mV; Sa {r['Sa']:+.4f} % (cambio {dS:+.2f} %); Da {Da:+.4f} % -> {'cumple' if ok else 'NO cumple'}")
    w = q[0]["K"] >= 3 * q[33]["K"]; bench &= w
    o.append(f"  G1 en esta esquina: K(0)/K(33) = {q[0]['K']/q[33]['K'] if q[33]['K'] else float('inf'):.1f} -> {'las variantes difieren' if w else 'FALLA'}")
if nd == 4:
    o.append(f"G1 (testigo, 4 esquinas): {'cumplida' if bench else 'FALSA'}")
    o.append(f"G2-G3 (k >= 4 cumple en las 4 esquinas): {'cumplidas' if all(okk[k] for k in (33, 16, 8, 4)) else 'FALSA alguna'}; por k: " + ", ".join(f"k={k} {'si' if okk[k] else 'no'}" for k in KS))
    kmin = None
    for k in sorted(KS):
        if all(okk[j] for j in KS if j >= k): kmin = k; break
    o.append(f"Benchmark: {'valido' if bench else 'INVALIDO'}")
    if bench:
        o.append(f"Corte: {kmin} dedos = {kmin * 55} um2 de puerta")
        o.append("SIGUE: el filtro cabe en la franja (corte <= 8)" if kmin is not None and kmin <= 8 else "MUERE: hace falta k >= 16")
else: o.append(f"Sin veredicto: {nd} de 4 esquinas validas")
open(os.path.join(H, "m7b.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
