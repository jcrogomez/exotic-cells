"""MISFIT-10: que alturas cierran limpio. Escrito antes de que termine ninguna corrida completa (la de 20 filas fallo en 15 s
por ocupacion > 100 % en la colocacion global, visto antes de escribir esto). Salida: m10.txt"""
import json, os, re, glob
LF = "/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow"; H = os.path.dirname(os.path.abspath(__file__))
PTS = [("lean", r) for r in (28, 26, 24, 22, 20)] + [("orig", r) for r in (26, 24, 22)]
o = ["# MISFIT-10 · analiza_m10.py · 'limpio' = termina, DRC Magic 0, LVS 0, 0 violaciones de setup y hold, 0 um de met4 de senal en la obstruccion"]
res = {}
for v, r in PTS:
    d = f"{LF}/misfit10_core_{v}_r{r}"; f = d + "/runs/core/final"; hmm = r * 2.72
    log = open(d + "_harden.log", errors="replace").read() if os.path.exists(d + "_harden.log") else ""
    if not os.path.exists(f + "/metrics.json"):
        m = re.search(r"\[(GPL-\d+)\]\s+([^\n]*)\n?\s*([^\n]*)", log); why = " ".join(x.strip() for x in m.groups()) if m else ("tope de 20 min" if "Start" in log[-3000:] else "sin metricas")
        dm = re.search(r"(\d+) Magic DRC errors", log); why = f"{dm.group(1)} errores de DRC de Magic" if dm else why
        res[(v, r)] = False; o.append(f"{v} {r} filas ({hmm:.2f} um): NO cierra ({why[:90]})"); continue
    m = json.load(open(f + "/metrics.json")); de = open(f + "/def/misfit04_core.def").read(); i = de.index("\nNETS "); s = de[i:de.index("END NETS", i)]
    below = 0.0; lim = hmm - 7.04
    for body in re.findall(r"(?:ROUTED|NEW)\s+met4\s+(?:\d+\s+)?((?:\(\s*[\d*]+\s+[\d*]+(?:\s+\d+)?\s*\)\s*)+)", s):
        px = py = None
        for x, y in re.findall(r"\(\s*([\d*]+)\s+([\d*]+)", body):
            x = px if x == "*" else int(x); y = py if y == "*" else int(y)
            if px is not None and min(y, py) / 1000 < lim: below += (abs(x - px) + abs(y - py)) / 1000
            px, py = x, y
    ok = (m.get("magic__drc_error__count") == 0 and m.get("design__lvs_error__count") == 0 and m.get("timing__setup_vio__count") == 0
          and m.get("timing__hold_vio__count") == 0 and below == 0)
    res[(v, r)] = ok
    cells = m["design__instance__area__stdcell"] - m["design__instance__area__class:fill_cell"] - m["design__instance__area__class:tap_cell"]
    o.append(f"{v} {r} filas ({hmm:.2f} um): {'cierra limpio' if ok else 'NO limpio'} | DRC {m.get('magic__drc_error__count')}, LVS {m.get('design__lvs_error__count')}, setup ws {m.get('timing__setup__ws'):.2f} ns, hold ws {m.get('timing__hold__ws'):.3f} ns, viol. {m.get('timing__setup_vio__count')}/{m.get('timing__hold_vio__count')}, met4 en la obstruccion {below:.1f} um | celdas {cells:.0f} um2, relleno {m['design__instance__area__class:fill_cell']:.0f} um2, rutado {m.get('route__wirelength')} um")
g = lambda v, r: res.get((v, r))
o.append(f"H1 (lean limpio a 28 y 26): {'cumplida' if g('lean',28) and g('lean',26) else 'FALSA'}")
o.append(f"H2 (lean limpio a 24): {'cumplida' if g('lean',24) else 'FALSA'}")
o.append(f"H3 (testigo: lean no cierra a 20): {'cumplida' if g('lean',20) is False else 'FALSA'}")
o.append(f"H4 (original limpio a 26): {'cumplida' if g('orig',26) else 'FALSA'}")
mn = lambda v, rows: min([r for r in rows if g(v, r)], default=None)
ml, mo = mn("lean", (28, 26, 24, 22, 20)), mn("orig", (26, 24, 22))
o.append(f"Minimo que cierra limpio: lean {ml} filas; original {mo} filas (el original solo se probo a 26, 24 y 22; a 32 cierra, MISFIT-06)")
o.append(f"H5 (lean 2 filas por debajo del original): {'cumplida' if ml and mo and mo - ml == 2 else 'FALSA o no decidible con estos puntos'}")
valid = g("lean", 20) is False and bool(g("lean", 28))
o.append(f"Benchmark: {'valido' if valid else 'INVALIDO'}")
if valid and ml:
    hd = ml + 2; o.append(f"Altura de diseno (minimo + 2 filas): {hd} filas = {hd*2.72:.2f} um; libera {32-hd} filas = {(32-hd)*2.72*161:.0f} um2 -> {'SIGUE' if 32 - hd >= 4 else 'no llega a 4 filas'}")
open(os.path.join(H, "m10.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
