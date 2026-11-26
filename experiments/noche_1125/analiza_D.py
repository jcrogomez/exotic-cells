"""Plan nocturno 2026-11-25, bloque D (R6). Veredictos con las palabras del prerregistro. Escrito ANTES de abrir ningun log
(solo se habian contado lineas). Salida: D.txt
Formas que el prerregistro no fijaba y se fijan aqui, antes de ver datos:
 - D1 "lineal dentro de +-10 %": el % por rama extra a 64 y a 128 frente al de 32.
 - D3: se juzga a 32 y 64; el 128 se reporta sin veredicto ("puede pasarlo" no es falsable).
 - Control de los decks tr: n1 frente al h01 de v_f3 medido en MISFIT-09 (misfit09/tr_<c>_<t>/m9.log, hS), 0,01 %.
 - Control de los decks lg: h00 XA_min frente al contrato de v_hm (v_f3 no tiene contrato de h00; hueco del prerregistro).
 - Cruza = aparece el cruce de 0,9 V en la salida (o su maximo > 0,9 V).
 - Fuga por rama (corte 3): L/I maximo por esquina de MISFIT-05 (m5.txt, linea D1)."""
import os, math
H = os.path.dirname(os.path.abspath(__file__)); T0 = 1e-6
CN = (("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85"))
LI = {("tt", "27"): 2.53e-06, ("ff", "-40"): 3.70e-08, ("ss", "85"): 3.58e-04, ("ff", "85"): 6.53e-05}
def lee(p, tag):
    d = {}; last = "sin log"
    if os.path.exists(p):
        for l in open(p, errors="replace"):
            f = l.split(); last = l.strip() or last
            if f and f[0] == tag:
                try: d[f[3]] = float(f[4]) if len(f) == 5 else None
                except ValueError: d[f[3]] = None
    return d, last
C9 = {}
for c, t in CN:
    d, _ = lee(os.path.join(H, "..", "misfit09", f"tr_{c}_{t}", "m9.log"), "M9"); C9[(c, t)] = (d.get("hS_oa"), d.get("hS_ob"))
CH = {}
for l in open(os.path.join(H, "..", "xc19_slot_e2", "diseno", "contrato.txt")):
    f = l.split()
    if len(f) == 4 and f[0] == "RES" and f[3].startswith("h00_XA_min="): CH[(f[1], f[2])] = float(f[3].split("=")[1])
o = ["# Noche 1125, bloque D · analiza_D.py · lector pequeno v_f3 con N ramas (sin cableado). Tiempos desde T0 = 1 us"]
bench = True; R = {k: [] for k in ("D1", "D1l", "D2", "D3")}; cut = {n: [] for n in (32, 64, 128)}; d5 = []
INS = ("n1", "n32", "n64", "n128", "t1", "t64", "t128", "mc", "wi", "wc")
for c, t in CN:
    d, last = lee(os.path.join(H, "D", f"tr_{c}_{t}", "m.log"), "MD")
    need = [f"{r}_{s}" for r in INS for s in ("oa", "ob")]; miss = [k for k in need if d.get(k) is None]
    if miss: o.append(f"{c} {t}: DECK INCOMPLETO, faltan {miss} ({last})"); bench = False; continue
    A = {r: d[r + "_oa"] - T0 for r in INS}; B = {r: d[r + "_ob"] - T0 for r in INS}
    ra, rb = C9[(c, t)]
    if not ra or not rb: o.append(f"{c} {t}: sin referencia de MISFIT-09"); bench = False; continue
    ca = (d["n1_oa"] / ra - 1) * 100; cb = (d["n1_ob"] / rb - 1) * 100; okc = abs(ca) <= 0.01 and abs(cb) <= 0.01
    o.append(f"\n{c} {t}: control n1 frente al h01 de v_f3 (MISFIT-09): A {ca:+.4f} %, B {cb:+.4f} % -> {'ok' if okc else 'FALLA: el deck no cuenta'}")
    if not okc: bench = False; continue
    mc = A["mc"] / A["n1"]; wi = (A["wi"] / A["n1"] - 1) * 100; wc = (A["wc"] / A["n1"] - 1) * 100
    okd = 0.45 <= mc <= 0.60 and wi < 0 and 0.4 <= wc <= 0.9; d5.append(okd); bench &= okd
    o.append(f"  D5: mutante mc tA/tA(1) = {mc:.4f} (0,45-0,60) | testigo 40 pA {wi:+.4f} % (baja) | testigo 1 fF {wc:+.4f} % (+0,4 a +0,9) -> {'ok' if okd else 'FALLA'}")
    o.append("  tA (us): " + ", ".join(f"N={n} {A[f'n{n}']*1e6:.4f}" for n in (1, 32, 64, 128)) + " | tA(N)/tA(1): " + ", ".join(f"{A[f'n{n}']/A['n1']:.4f}" for n in (32, 64, 128)))
    per = {n: (A[f"n{n}"] / A["n1"] - 1) * 100 / (n - 1) for n in (32, 64, 128)}
    lin = {n: (per[n] / per[32] - 1) * 100 for n in (64, 128)}
    o.append("  D1, % por rama extra: " + ", ".join(f"N={n} {per[n]:+.4f}" for n in per) + " | frente a N=32: " + ", ".join(f"N={n} {lin[n]:+.2f} %" for n in lin))
    R["D1"].append(all(0.20 <= per[n] <= 0.28 for n in per)); R["D1l"].append(all(abs(x) <= 10 for x in lin.values()))
    s = {1: (A["t1"] / A["n1"] - 1) * 100, 64: (A["t64"] / A["n64"] - 1) * 100, 128: (A["t128"] / A["n128"] - 1) * 100}
    rel = {n: (s[n] / s[1] - 1) * 100 for n in (64, 128)}
    o.append(f"  D2, salto de una carga: N=1 {s[1]:+.4f} %, N=64 {s[64]:+.4f} % ({rel[64]:+.2f} % rel.), N=128 {s[128]:+.4f} % ({rel[128]:+.2f} % rel.)")
    R["D2"].append(abs(rel[128]) < 2)
    r = {n: (math.log(A[f"n{n}"] / B[f"n{n}"]) - math.log(A["n1"] / B["n1"])) * 100 for n in (32, 64, 128)}
    o.append("  D3, ln(tA/tB) frente a N=1, puntos de %: " + ", ".join(f"N={n} {r[n]:+.5f}" for n in r))
    R["D3"].append(abs(r[32]) < 0.0807 and abs(r[64]) < 0.0807)
    for n in (32, 64, 128):
        c1 = abs(rel[n]) <= 5 if n in rel else None       # no hay trampa a 32: se acota con la de 64
        if n == 32: c1 = abs(rel[64]) <= 5
        c2 = A[f"n{n}"] <= 1.5 * A["n1"]; c3 = (n - 1) * LI[(c, t)] <= 0.05
        cut[n].append(c1 and c2 and c3)
        o.append(f"  cortes N={n}: salto <= 5 % rel. {'si' if c1 else 'NO'}{' (acotado con N=64)' if n == 32 else ''} | tA <= 1,5 tA(1) {'si' if c2 else 'NO'} | (N-1) L/I = {(n-1)*LI[(c,t)]*100:.3f} % <= 5 % {'si' if c3 else 'NO'}")
nd = len(R["D1"])
def v(k, k2=None):
    if nd != 4: return f"sin veredicto ({nd} de 4 esquinas)"
    return "cumplida" if all(R[k]) and (k2 is None or all(R[k2])) else "FALSA"
o.append("\n## Todo abierto, 1,4 ms a 85 C (D4)")
d4 = {}
for c, t in (("ss", "85"), ("ff", "85")):
    d, last = lee(os.path.join(H, "D", f"lg_{c}_{t}", "m.log"), "LD")
    if any(d.get(k) is None for k in ("h00_XA_min", "a32_XA_min", "a128_XA_min", "a32_oa_max", "a128_oa_max")):
        o.append(f"{c} {t}: DECK INCOMPLETO ({last})"); bench = False; continue
    cz = (d["h00_XA_min"] / CH[(c, t)] - 1) * 100; okc = abs(cz) <= 0.01
    x = {n: (d.get(f"a{n}_cruce") is not None or d[f"a{n}_oa_max"] > 0.9) for n in (32, 128)}; d4[(c, t)] = x
    o.append(f"{c} {t}: control h00 XA_min {d['h00_XA_min']:.5f} V frente al contrato de v_hm {cz:+.4f} % -> {'ok' if okc else 'FUERA de 0,01 % (contrato de otro macro: se dice, no invalida)'}")
    for n in (32, 128):
        o.append(f"  {n} ramas abiertas: XA minimo {d[f'a{n}_XA_min']:.4f} V, salida maxima {d[f'a{n}_oa_max']:.4f} V, cruce {d.get(f'a{n}_cruce')} -> {'CRUZA' if x[n] else 'no cruza'}")
if len(d4) == 2:
    ok4 = (not d4[("ss", "85")][32]) and d4[("ss", "85")][128] and d4[("ff", "85")][128]
    o.append(f"D4 (32 no cruza a ss 85; 128 cruza en las dos): {'cumplida' if ok4 else 'FALSA'}")
o += ["\n## Veredictos", f"D1 (+0,20 a +0,28 % por rama, y lineal +-10 %): {v('D1', 'D1l')}  [banda: {v('D1')}; linealidad: {v('D1l')}]",
      f"D2 (salto cambia < 2 % rel. a 128 ramas): {v('D2')}", f"D3 (ln(tA/tB) < 0,0807 puntos hasta 64 ramas): {v('D3')}",
      f"D5 (testigos y mutante, 4 esquinas): {'cumplida' if len(d5) == 4 and all(d5) else 'FALSA o incompleta'}",
      f"Benchmark: {'valido' if bench else 'INVALIDO (ver arriba)'}"]
if nd == 4:
    nmax = max([1] + [n for n in (32, 64, 128) if all(cut[n])])
    o.append(f"N maximo que cumple los tres cortes en las 4 esquinas (de 1, 32, 64, 128; sin cableado): {nmax}")
open(os.path.join(H, "D.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
