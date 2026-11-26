"""MISFIT-13: que variantes del nucleo crecido cierran limpio. Escrito ANTES de lanzar ninguna corrida. Salida: m13.txt
'limpio' como en MISFIT-10: termina, DRC Magic 0, LVS 0, 0 violaciones de setup y hold, 0 um de met4 de senal bajo y = 80 um."""
import json, os, re
LF = "/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow"; H = os.path.dirname(os.path.abspath(__file__))
V = (("v0", "control: nucleo actual, pines colocados por el flujo"), ("v1", "64 lineas compartidas + 2o lector"), ("v2", "128 lineas + 2o lector"), ("v3", "8 filas + 8 columnas + 2o lector"))
o = ["# MISFIT-13 · analiza.py · bloque 161 x 87,04 um (32 filas), obstruccion de met4 hasta y = 80"]; res = {}; area = {}
import sys; SUF = sys.argv[1] if len(sys.argv) > 1 else ""; OUT = "m13" + SUF + ".txt"   # enmienda 1: SUF = _e1 (densidad sin fijar)
for v, what in V:
    d = f"{LF}/misfit13_core_{v}{SUF if v != 'v0' else ''}"; f = d + "/runs/core/final"; top = "misfit04_core" if v == "v0" else "misfit13_core"
    log = open(d + "_harden.log", errors="replace").read() if os.path.exists(d + "_harden.log") else ""
    if not os.path.exists(f + "/metrics.json"):
        why = "sin metricas"
        for pat, txt in ((r"ERROR\s+\[(\w+-\d+)\]\s+([^\n]*?)\s+openroad", None), (r"\[(DPL-\d+)\]\s+([^\n]*)", None), (r"(\d+) Magic DRC errors", "errores de DRC de Magic"), (r"\[(GRT-\d+)\]\s+([^\n]*)", None), (r"\[(DRT-\d+)\]\s+([^\n]*)", None)):
            m = re.search(pat, log)
            if m: why = (" ".join(m.groups()) if txt is None else f"{m.group(1)} {txt}")[:110]; break
        last = [l for l in log.splitlines() if l.strip()][-1:] or [""]
        res[v] = False; o.append(f"{v} ({what}): NO cierra ({why}; ultima linea: {last[0][:80]})"); continue
    m = json.load(open(f + "/metrics.json")); de = open(f"{f}/def/{top}.def").read(); i = de.index("\nNETS "); s = de[i:de.index("END NETS", i)]
    below = 0.0
    for body in re.findall(r"(?:ROUTED|NEW)\s+met4\s+(?:\d+\s+)?((?:\(\s*[\d*]+\s+[\d*]+(?:\s+\d+)?\s*\)\s*)+)", s):
        px = py = None
        for x, y in re.findall(r"\(\s*([\d*]+)\s+([\d*]+)", body):
            x = px if x == "*" else int(x); y = py if y == "*" else int(y)
            if px is not None and min(y, py) / 1000 < 80: below += (abs(x - px) + abs(y - py)) / 1000
            px, py = x, y
    ok = (m.get("magic__drc_error__count") == 0 and m.get("design__lvs_error__count") == 0 and m.get("timing__setup_vio__count") == 0 and m.get("timing__hold_vio__count") == 0 and below == 0)
    res[v] = ok; cells = m["design__instance__area__stdcell"] - m["design__instance__area__class:fill_cell"] - m["design__instance__area__class:tap_cell"]; area[v] = cells
    o.append(f"{v} ({what}): {'cierra limpio' if ok else 'NO limpio'} | DRC {m.get('magic__drc_error__count')}, LVS {m.get('design__lvs_error__count')}, setup ws {m.get('timing__setup__ws'):.2f} ns, hold ws {m.get('timing__hold__ws'):.2f} ns, "
             f"viol. setup {m.get('timing__setup_vio__count')}, hold {m.get('timing__hold_vio__count')} | celdas {cells:.0f} um2 ({m.get('design__instance__count__stdcell')} inst. con relleno), cable {m.get('route__wirelength')} um, met4 bajo 80: {below:.1f} um")
if "v0" in area:
    for v in ("v1", "v2", "v3"):
        if v in area: o.append(f"  {v} frente al control: {area[v]-area['v0']:+.0f} um2 de celdas ({(area[v]/area['v0']-1)*100:+.1f} %)")
g = res.get
o += [f"N0 (control cierra limpio): {'cumplida' if g('v0') else 'FALSA'}", f"N1 (64 lineas NO cierra limpio): {'cumplida' if g('v1') is False else 'FALSA'}",
      f"N2 (128 lineas NO cierra limpio): {'cumplida' if g('v2') is False else 'FALSA'}", f"N3 (8 + 8 cierra limpio): {'cumplida' if g('v3') else 'FALSA'}",
      f"Benchmark: {'valido' if g('v0') else 'INVALIDO'}"]
if g("v0"): o.append("SE ADOPTA: " + ("v1, 64 lineas compartidas" if g("v1") else "v3, dos niveles (el puesto necesita un segundo interruptor)" if g("v3") else "ninguna cierra: el bloque del nucleo tiene que crecer"))
open(os.path.join(H, OUT), "w").write("\n".join(o) + "\n"); print("\n".join(o))
