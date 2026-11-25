"""MISFIT-06: veredictos A1-A5 con las palabras del prerregistro. Escrito ANTES de que termine ninguna corrida. Salida: m6.txt"""
import json, os, re, collections
LF = "/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow"
H = os.path.dirname(os.path.abspath(__file__))
def lee(n):
    f = f"{LF}/misfit06_core_{n}/runs/core/final"
    if not os.path.exists(f + "/metrics.json"): return None
    m = json.load(open(f + "/metrics.json")); d = open(f + "/def/misfit04_core.def").read()
    dbu = int(re.search(r"UNITS DISTANCE MICRONS (\d+)", d).group(1))
    def sect(name):
        i = d.index("\n" + name + " "); return d[i:d.index("END " + name, i)]
    L = collections.Counter()
    for lay, body in re.findall(r"(?:ROUTED|NEW)\s+(\w+)\s+(?:\d+\s+)?(?:\+ SHAPE \w+\s+)?((?:\(\s*[\d*]+\s+[\d*]+(?:\s+\d+)?\s*\)\s*)+)", sect("NETS")):
        px = py = None
        for x, y in re.findall(r"\(\s*([\d*]+)\s+([\d*]+)", body):
            x = px if x == "*" else int(x); y = py if y == "*" else int(y)
            if px is not None: L[lay] += (abs(x - px) + abs(y - py)) / dbu
            px, py = x, y
    # franjas de alimentacion en met4: ancho y posicion x
    st = sorted({(int(x), int(w)) for w, x in re.findall(r"met4\s+(\d+)\s+\+ SHAPE STRIPE\s+\(\s*(\d+)", sect("SPECIALNETS"))})
    die = [int(v) for v in re.search(r"DIEAREA \(\s*(\d+) (\d+)\s*\) \(\s*(\d+) (\d+)", d).groups()]
    return dict(m=m, L=L, st=[(x / dbu, w / dbu) for x, w in st], die=[v / dbu for v in die])
R = {n: lee(n) for n in ("ctl", "m3", "m2")}
o = ["# MISFIT-06 · analiza_m6.py"]
def fila(n):
    r = R[n]
    if r is None: return f"{n}: NO TERMINO (sin final/metrics.json)"
    m = r["m"]
    return (f"{n}: instancias {m.get('design__instance__count')}; rutado {m.get('route__wirelength')} um; DRC ruteo {m.get('route__drc_errors')}; "
            f"DRC Magic {m.get('magic__drc_error__count')}; LVS errores {m.get('design__lvs_error__count')}; setup ws {m.get('timing__setup__ws'):.3f} ns; "
            f"hold ws {m.get('timing__hold__ws'):.4f} ns; violaciones setup/hold {m.get('timing__setup_vio__count')}/{m.get('timing__hold_vio__count')}; "
            f"por capa (um): " + ", ".join(f"{k} {v:.0f}" for k, v in sorted(r['L'].items()) if v))
for n in R: o.append(fila(n))
ok = lambda r: r and r["m"].get("magic__drc_error__count") == 0 and r["m"].get("design__lvs_error__count") == 0 and r["m"].get("timing__setup__ws") >= 0 and r["m"].get("timing__hold__ws") >= 0
c, a, b = R["ctl"], R["m3"], R["m2"]
A1 = bool(c) and c["m"].get("design__instance__count") == 1681 and c["m"].get("route__wirelength") == 31286 and ok(c)
o.append(f"A1 (ctl repite MISFIT-04): {'cumplida' if A1 else 'FALSA'}")
A2 = bool(ok(a)); o.append(f"A2 (m3 termina, DRC 0, LVS limpio, holguras >= 0): {'cumplida' if A2 else 'FALSA'}")
if a:
    A3 = a["L"].get("met4", 0) == 0; o.append(f"A3 (m3 sin metal 4 de senal): {a['L'].get('met4', 0):.1f} um -> {'cumplida' if A3 else 'FALSA'}")
    if c:
        r4 = (a["m"]["route__wirelength"] / c["m"]["route__wirelength"] - 1) * 100
        o.append(f"A4 (rutado de m3 frente a ctl entre 0 y +5 %): {r4:+.2f} % -> {'cumplida' if 0 <= r4 <= 5 else 'FALSA'}")
else: A3 = False
if b and c:
    r5 = (b["m"]["route__wirelength"] / c["m"]["route__wirelength"] - 1) * 100
    A5 = (not ok(b)) or r5 > 5 or (b["m"].get("route__drc_errors") or 0) > 0
    o.append(f"A5 (m2 empeora): rutado {r5:+.2f} %, ok = {bool(ok(b))} -> {'cumplida' if A5 else 'FALSA'}")
else:
    A5 = b is None; o.append(f"A5 (m2 empeora): {'no termino -> cumplida' if A5 else 'sin dato'}")
o.append(f"Benchmark: {'valido' if A1 and A5 else 'INVALIDO'}")
if A1 and A5: o.append("SIGUE: el metal 4 sobre el nucleo queda libre de senales" if A2 and A3 else "MUERE: el nucleo no cierra limitado a metal 3")
if a:
    x0, y0, x1, y1 = a["die"]; st = a["st"]; libre = 0; prev = x0; huecos = []
    for x, w in st:
        if x - w / 2 > prev: huecos.append(x - w / 2 - prev)
        prev = x + w / 2
    if x1 > prev: huecos.append(x1 - prev)
    o.append(f"Metal 4 sobre el bloque de m3 ({x1-x0:.2f} x {y1-y0:.2f} um): {len(st)} franjas de alimentacion (x, ancho): {st}")
    o.append(f"  huecos entre franjas (um): {[round(h, 2) for h in huecos]}; area libre bruta = {sum(huecos)*(y1-y0):.0f} um2 de {(x1-x0)*(y1-y0):.0f} (sin contar pines ni reglas de densidad)")
open(os.path.join(H, "m6.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
