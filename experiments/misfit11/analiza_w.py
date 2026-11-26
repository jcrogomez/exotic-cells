"""MISFIT-11 etapa 2: veredictos W1-W4 con las palabras del prerregistro. Escrito ANTES de correr ningun deck. Salida: w.txt
Formas fijadas aqui: tiempo por puesto = (tA(m<N>_k)/tA(n1) - 1) / N, con el peor de los dos puestos medidos (el puesto propio
del lector, abierto, sigue colgado y no se descuenta); W1 se juzga a N = 16 y a N = 64; W4 = |tA(m64_0)/tA(m64_63) - 1|."""
import os
H = os.path.dirname(os.path.abspath(__file__)); T0 = 1e-6
CN = (("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85"))
def lee(p, tag):
    d = {}; last = "sin log"
    if os.path.exists(p):
        for l in open(p, errors="replace"):
            f = l.split(); last = l.strip() or last
            if f and f[0] == tag:
                try: d[f[3]] = float(f[4]) if len(f) == 5 else None
                except ValueError: d[f[3]] = None
    return d, last
o = ["# MISFIT-11 etapa 2 · analiza_w.py · lector pequeno v_f3 con la matriz extraida (cableado incluido). Tiempos desde T0 = 1 us",
     "# referencia sin cableado (noche 1125, bloque D): +0,230 a +0,253 % por rama"]
INS = ("n1", "wc", "t1", "m16_0", "m16_15", "t16_0", "m64_0", "m64_63", "t64_0"); bench = True; R = {k: [] for k in ("W1", "W2", "W3", "W4")}
for c, t in CN:
    d, last = lee(os.path.join(H, "w", f"tr_{c}_{t}", "m.log"), "MW")
    miss = [f"{r}_{s}" for r in INS for s in ("oa", "ob") if d.get(f"{r}_{s}") is None]
    if miss: o.append(f"{c} {t}: DECK INCOMPLETO, faltan {miss} ({last})"); bench = False; continue
    A = {r: d[r + "_oa"] - T0 for r in INS}; B = {r: d[r + "_ob"] - T0 for r in INS}
    r9, _ = lee(os.path.join(H, "..", "misfit09", f"tr_{c}_{t}", "m9.log"), "M9")
    ca = (d["n1_oa"] / r9["hS_oa"] - 1) * 100; cb = (d["n1_ob"] / r9["hS_ob"] - 1) * 100; okc = abs(ca) <= 0.01 and abs(cb) <= 0.01
    wc = (A["wc"] / A["n1"] - 1) * 100; okw = 0.4 <= wc <= 0.9
    o.append(f"\n{c} {t}: control n1 frente al h01 de v_f3: A {ca:+.4f} %, B {cb:+.4f} % -> {'ok' if okc else 'FALLA'} | testigo 1 fF: {wc:+.4f} % -> {'ok' if okw else 'FALLA'}")
    if not (okc and okw): bench = False; continue
    per = {n: max((A[f"m{n}_{k}"] / A["n1"] - 1) * 100 / n for k in (0, n - 1)) for n in (16, 64)}
    o.append(f"  tA (us): lector solo {A['n1']*1e6:.4f} | 16 puestos: puesto 0 {A['m16_0']*1e6:.4f}, puesto 15 {A['m16_15']*1e6:.4f} | 64 puestos: puesto 0 {A['m64_0']*1e6:.4f}, puesto 63 {A['m64_63']*1e6:.4f}")
    o.append(f"  W1, % por puesto: N=16 {per[16]:+.4f}, N=64 {per[64]:+.4f}"); R["W1"].append(all(0.26 <= per[n] <= 0.40 for n in per))
    q = max(A["m64_0"], A["m64_63"]) / A["n1"]; o.append(f"  W2, tA(64 puestos)/tA(lector solo) = {q:.4f}"); R["W2"].append(q <= 1.5)
    s1 = (A["t1"] / A["n1"] - 1) * 100; s16 = (A["t16_0"] / A["m16_0"] - 1) * 100; s64 = (A["t64_0"] / A["m64_0"] - 1) * 100
    o.append(f"  W3, salto de una carga: lector solo {s1:+.4f} %, 16 puestos {s16:+.4f} % ({(s16/s1-1)*100:+.2f} % rel.), 64 puestos {s64:+.4f} % ({(s64/s1-1)*100:+.2f} % rel.)")
    R["W3"].append(abs(s64 / s1 - 1) <= 0.05)
    p4 = (A["m64_0"] / A["m64_63"] - 1) * 100; p16 = (A["m16_0"] / A["m16_15"] - 1) * 100
    o.append(f"  W4, puesto 0 frente al ultimo: N=64 {p4:+.4f} %, N=16 {p16:+.4f} % | lado B igual: N=64 {(B['m64_0']/B['m64_63']-1)*100:+.4f} %")
    R["W4"].append(abs(p4) <= 0.05)
nd = len(R["W1"]); v = lambda k: ("cumplida" if all(R[k]) else "FALSA") if nd == 4 else f"sin veredicto ({nd} de 4 esquinas)"
o += ["\n## Veredictos", f"W1 (+0,26 a +0,40 % por puesto): {v('W1')}", f"W2 (64 puestos <= 1,5 veces): {v('W2')}", f"W3 (salto cambia <= 5 % rel. con 64): {v('W3')}",
      f"W4 (puesto 0 y 63 dentro de 0,05 %): {v('W4')}", f"Benchmark: {'valido' if bench else 'INVALIDO'}"]
if bench and nd == 4: o.append("DECIDE: 64 puestos por lector confirmado con cableado" if all(R["W2"]) and all(R["W3"]) else "DECIDE: 64 puestos NO confirmado; revisar la decision 7")
open(os.path.join(H, "w.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
