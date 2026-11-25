"""XC-64 caza de islas: intervalos legales por sonda y veredictos K0-K4. Escrito ANTES de ver ninguna salida. Salida: islas.txt
Enviable = Magic drc(full) 0 y KLayout (deck de fabricacion) 0."""
import os, re
H = os.path.dirname(os.path.abspath(__file__)); O = os.path.join(H, "out")
def lee(p):
    rows = [l.rstrip("\n").split(";") for l in open(os.path.join(O, p + ".magic.csv"))][1:]
    out = []
    for v, n, rules in rows:
        f = os.path.join(O, f"{p}_{v.replace('.', 'p')}.lyrdb"); k = None; kr = ""
        if os.path.exists(f):
            t = open(f).read(); k = t.count("<item>"); kr = ",".join(sorted(set(re.findall(r"<category>'?([^<']*)'?</category>", t.split("<items>")[-1]))))[:80]
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
o = ["# XC-64 caza de islas · analiza.py · 'enviable' = Magic drc(full) 0 y KLayout de fabricacion 0"]
R = {}
for p in ("pn_space", "m1_width", "tfet_n", "tfet_p", "vt_edge", "well_edge"):
    if not os.path.exists(os.path.join(O, p + ".magic.csv")): o.append(f"{p}: SIN DATOS"); continue
    rows = lee(p); R[p] = rows
    mg = tramos(rows, lambda r: r[1] == 0); env = tramos(rows, lambda r: r[1] == 0 and r[3] == 0)
    sin_k = sum(1 for r in rows if r[1] == 0 and r[3] is None)
    o.append(f"\n## {p}: {len(rows)} puntos, de {rows[0][0]:.3f} a {rows[-1][0]:.3f} um")
    o.append("  legal en Magic: " + (", ".join(f"[{a:.3f}, {b:.3f}]" if a != b else f"{{{a:.3f}}}" for a, b in mg) or "nada"))
    o.append("  enviable (Magic y KLayout): " + (", ".join(f"[{a:.3f}, {b:.3f}]" if a != b else f"{{{a:.3f}}}" for a, b in env) or "nada") + (f"  (ojo: {sin_k} puntos legales en Magic sin pasar por KLayout)" if sin_k else ""))
    seen = []
    for r in rows:
        for x in filter(None, (y.strip() for y in r[2].split("|"))):
            if x not in seen:
                seen.append(x); vs = [q[0] for q in rows if x in q[2]]; o.append(f"  Magic, de {vs[0]:.3f} a {vs[-1]:.3f}: {x[:110]}")
    kk = {}
    for r in rows:
        if r[3]: kk.setdefault(r[4], []).append(r[0])
    for k, vs in kk.items(): o.append(f"  KLayout, de {vs[0]:.3f} a {vs[-1]:.3f} (puntos muestreados): {k}")
    solo_m = [r[0] for r in rows if r[1] == 0 and r[3]]; solo_k = [r[0] for r in rows if r[1] > 0 and r[3] == 0]
    if solo_m: o.append(f"  legal en Magic y NO en KLayout: {solo_m[0]:.3f}..{solo_m[-1]:.3f} ({len(solo_m)} puntos)")
    if solo_k: o.append(f"  legal en KLayout y NO en Magic (muestreo): {solo_k[0]:.3f}..{solo_k[-1]:.3f} ({len(solo_k)} puntos)")
    R[p + "_env"] = env; R[p + "_mg"] = mg
o.append("\n## Veredictos")
def eq(seg, exp): return len(seg) == len(exp) and all(abs(a - c) < 1e-9 and abs(b - d) < 1e-9 for (a, b), (c, d) in zip(seg, exp))
k0a = "pn_space_mg" in R and len(R["pn_space_mg"]) == 2 and R["pn_space_mg"][0] == (0.0, 0.0) and abs(R["pn_space_mg"][1][0] - 0.27) < 1e-9
k0b = "m1_width_mg" in R and len(R["m1_width_mg"]) == 1 and abs(R["m1_width_mg"][0][0] - 0.14) < 1e-9
o.append(f"K0 (controles): pn_space {'repite la isla en 0 y el borde en 0,270' if k0a else 'NO repite'}; m1_width {'repite un borde unico en 0,140' if k0b else 'NO repite'} -> {'cumplida' if k0a and k0b else 'FALSA: benchmark invalido'}")
for k, p in (("K1", "tfet_n"), ("K2", "tfet_p")):
    if p + "_env" in R:
        e = R[p + "_env"]; ok = len(e) == 1 and 0.20 <= e[0][0] <= 0.40 and abs(e[0][1] - 0.40) < 1e-9
        isla0 = any(abs(a) < 1e-9 for a, b in e)
        o.append(f"{k} ({p}: un solo intervalo, d_min entre 0,20 y 0,40, sin isla en 0): {'cumplida' if ok else 'FALSA'}; enviable = {e}; isla en d = 0: {'SI' if isla0 else 'no'}")
if "vt_edge_env" in R:
    e = R["vt_edge_env"]; ok = all(a == b and (abs(a) < 1e-9 or abs(a - 1.0) < 1e-9) for a, b in e) and len(e) >= 1
    o.append(f"K3 (vt_edge: legal solo en los extremos): {'cumplida' if ok else 'FALSA'}; enviable = {e}")
if "well_edge_env" in R:
    e = R["well_edge_env"]; ok = len(e) <= 1 and all(b < 0 for a, b in e)
    o.append(f"K4 (well_edge: legal solo fuera del pozo): {'cumplida' if ok else 'FALSA'}; enviable = {e}")
open(os.path.join(H, "islas.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
