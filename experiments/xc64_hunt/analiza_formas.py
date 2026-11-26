"""XC-64 caza de formas: intervalos enviables por sonda y veredictos F1-F4. Escrito ANTES de ver salidas. Salida: formas.txt"""
import os, re
H = os.path.dirname(os.path.abspath(__file__)); O = os.path.join(H, "out_formas")
def lee(p):
    out = []
    for l in open(os.path.join(O, p + ".magic.csv")).read().splitlines()[1:]:
        v, n, rules = l.split(";", 2); f = os.path.join(O, f"{p}_{v.replace('.', 'p')}.lyrdb"); k = None; kr = ""
        if os.path.exists(f):
            t = open(f).read(); k = t.count("<item>"); kr = ",".join(sorted(set(re.findall(r"<category>'?([^<']*)'?</category>", t.split("<items>")[-1]))))[:70]
        out.append((float(v), int(n), rules, k, kr))
    return out
def tramos(rows, ok):
    seg = []; a = None; prev = None
    for r in rows:
        if ok(r):
            if a is None: a = r[0]
            prev = r[0]
        elif a is not None: seg.append((a, prev)); a = None
    if a is not None: seg.append((a, prev))
    return seg
fmt = lambda s: ", ".join(f"[{a:.3f}, {b:.3f}]" if a != b else f"{{{a:.3f}}}" for a, b in s) or "nada"
o = ["# XC-64 caza de formas · analiza_formas.py · enviable = Magic drc(full) 0 y KLayout de fabricacion 0"]; E = {}
for p in ("step_gate", "hole_gate", "bent_gate", "ring_gate"):
    if not os.path.exists(os.path.join(O, p + ".magic.csv")): o.append(f"\n## {p}: SIN DATOS"); continue
    rows = lee(p); env = tramos(rows, lambda r: r[1] == 0 and r[3] == 0); mg = tramos(rows, lambda r: r[1] == 0); E[p] = (rows, env)
    o.append(f"\n## {p}: {len(rows)} puntos, de {rows[0][0]:.3f} a {rows[-1][0]:.3f} um")
    o.append(f"  legal en Magic: {fmt(mg)}"); o.append(f"  enviable: {fmt(env)}")
    seen = []
    for r in rows:
        for x in filter(None, (y.strip() for y in r[2].split("|"))):
            if x not in seen: seen.append(x); vs = [q[0] for q in rows if x in q[2]]; o.append(f"  Magic, de {vs[0]:.3f} a {vs[-1]:.3f}: {x[:105]}")
    kk = {}
    for r in rows:
        if r[3]: kk.setdefault(r[4], []).append(r[0])
    for k, vs in kk.items(): o.append(f"  KLayout, de {vs[0]:.3f} a {vs[-1]:.3f} (muestreo): {k}")
o.append("\n## Veredictos")
env_en = lambda p, a, b: any(x <= b and y >= a for x, y in E[p][1]) if p in E else None      # algun punto enviable en [a, b]
pt = lambda p, v: any(x - 1e-9 <= v <= y + 1e-9 for x, y in E[p][1]) if p in E else None
if "step_gate" in E:
    c = pt("step_gate", -0.35) and pt("step_gate", 0.50); bajo = env_en("step_gate", 0.005, 0.145)
    o.append(f"step_gate: control (escalon lejos, a los dos lados) {'ok' if c else 'FALLA: sonda invalida'}; F1 (ningun punto enviable con el escalon bajo la puerta, 0,005 a 0,145): {'cumplida' if not bajo else 'FALSA: HAY FORMA LEGAL'}")
if "hole_gate" in E:
    c = pt("hole_gate", 0.0); f2 = all(pt("hole_gate", v / 100) for v in range(27, 61))
    o.append(f"hole_gate: control (sin hueco) {'ok' if c else 'FALLA: sonda invalida'}; F2 (enviable de 0,27 a 0,60): {'cumplida: HAY FORMA LEGAL' if f2 else 'FALSA'}; enviable = {fmt(E['hole_gate'][1])}")
if "bent_gate" in E:
    c = pt("bent_gate", 2.30); dentro = env_en("bent_gate", 0.60, 1.80)
    o.append(f"bent_gate: control (codo sobre el campo) {'ok' if c else 'FALLA: sonda invalida'}; F3 (nunca enviable con el codo sobre la difusion, 0,60 a 1,80): {'cumplida' if not dentro else 'FALSA: HAY FORMA LEGAL'}")
if "ring_gate" in E:
    o.append(f"ring_gate: sin control propio; F4 (nunca enviable): {'cumplida' if not E['ring_gate'][1] else 'FALSA: HAY FORMA LEGAL'}; enviable = {fmt(E['ring_gate'][1])}")
open(os.path.join(H, "formas.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
