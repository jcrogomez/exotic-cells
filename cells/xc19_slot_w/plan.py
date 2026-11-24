"""Busca, en el macro aplanado, dónde poner la pila li→m1→m2→m3 de cada pin de señal sin tocar geometría ajena.
Reglas usadas (sky130, µm): li ancho 0.17 y separación 0.17; m1 y m2 separación 0.14; pads de 0.36; viali 0.17.
Salida: plan.json con, por pin, la tira de li (desde el pin hasta el pad) y el centro del pad. Las comprueba luego el DRC."""
import re, json, itertools, sys
U = 0.005
rects = {}
cur = None
for l in open("xc19_slot_core_flat.mag"):
    m = re.match(r"<< (\S+) >>", l)
    if m: cur = m.group(1); continue
    if l.startswith("rect") and cur:
        x0, y0, x1, y1 = (int(v) * U for v in l.split()[1:5]); rects.setdefault(cur, []).append((x0, y0, x1, y1))
labels = {}
for l in open("xc19_slot_core_flat.mag"):
    if l.startswith(("rlabel", "flabel")):
        f = l.split(); i = 1 if f[0] == "rlabel" else 2
        if f[0] == "flabel": layer, x0, y0, x1, y1 = f[1], *map(int, f[2:6])
        else: layer, x0, y0, x1, y1 = f[1], *map(int, f[2:6])
        labels[f[-1]] = (layer, x0 * U, y0 * U, x1 * U, y1 * U)
LIC = ["locali", "viali", "ndiffc", "pdiffc", "polycont", "nsubdiffcont", "psubdiffcont"]
LI = [r for k in LIC for r in rects.get(k, [])]
M1 = rects.get("metal1", []) + rects.get("viali", []) + rects.get("via1", [])
M2 = rects.get("metal2", []) + rects.get("via1", [])
def touch(a, b, g=0.0):
    return a[0] - g < b[2] and b[0] - g < a[2] and a[1] - g < b[3] and b[1] - g < a[3]
def comp(seed, pool):
    own = [seed]; rest = list(pool); grew = True
    while grew:
        grew = False
        for r in rest[:]:
            if any(touch(r, o, 1e-6) or (abs(r[0]-o[2])<1e-6 or abs(o[0]-r[2])<1e-6 or abs(r[1]-o[3])<1e-6 or abs(o[1]-r[3])<1e-6) and touch(r, o, 1e-6+0.0) for o in own):
                own.append(r); rest.remove(r); grew = True
    return own, rest
def clear(r, pool, g):
    return not any(touch(r, p, g - 1e-6) for p in pool)
PINS = ["XA_OUT", "SA2B", "SA1B", "REFA", "SA0B", "C1", "VBIAS", "DUTA", "PREA", "DUTB", "PREB", "SB0B", "REFB", "SB1B", "XB_OUT"]
out = {}
for name in PINS:
    lay, x0, y0, x1, y1 = labels[name]
    pin = (x0, y0, x1, y1)
    own, foreign = comp(pin, LI)
    pcx, pcy = (x0 + x1) / 2, (y0 + y1) / 2
    best = None
    for dx10, dy10 in itertools.product(range(-60, 61, 2), range(-60, 61, 2)):
        dx, dy = dx10 / 20, dy10 / 20
        if dx and dy: continue                      # tira recta: solo horizontal o vertical
        cx, cy = pcx + dx, pcy + dy
        pad_li = (cx - 0.085, cy - 0.165, cx + 0.085, cy + 0.165) if dx == 0 else (cx - 0.165, cy - 0.085, cx + 0.165, cy + 0.085)
        if dx == 0: strip = (pcx - 0.085, min(cy, pcy) - 0.085, pcx + 0.085, max(cy, pcy) + 0.085)
        else: strip = (min(cx, pcx) - 0.085, pcy - 0.085, max(cx, pcx) + 0.085, pcy + 0.085)
        if not clear(strip, foreign, 0.17) or not clear(pad_li, foreign, 0.17): continue
        m1 = (cx - 0.18, cy - 0.18, cx + 0.18, cy + 0.18)
        if not clear(m1, M1, 0.14): continue
        if not clear(m1, M2, 0.14): continue          # pad de m2 del mismo tamaño
        cost = abs(dx) + abs(dy)
        if best is None or cost < best[0]: best = (cost, cx, cy, strip, pad_li)
    out[name] = None if best is None else dict(cx=round(best[1], 3), cy=round(best[2], 3), strip=[round(v, 3) for v in best[3]], pad_li=[round(v, 3) for v in best[4]], pin=pin)
    print(name, "SIN SITIO" if best is None else f"pad en ({best[1]:.3f}, {best[2]:.3f}), desplazado {best[0]:.2f} um; pin centro ({pcx:.3f}, {pcy:.3f})")
json.dump(out, open("plan.json", "w"), indent=1)

# ---- segunda pasada: rutas en L (dos tramos de li) para los pines sin sitio en línea recta
def seg(ax, ay, bx, by):
    return (min(ax, bx) - 0.085, min(ay, by) - 0.085, max(ax, bx) + 0.085, max(ay, by) + 0.085)
for name in [n for n in PINS if out[n] is None]:
    lay, x0, y0, x1, y1 = labels[name]; pin = (x0, y0, x1, y1)
    own, foreign = comp(pin, LI); pcx, pcy = (x0 + x1) / 2, (y0 + y1) / 2
    best = None
    for dx10, dy10 in itertools.product(range(-80, 81, 2), range(-80, 81, 2)):
        dx, dy = dx10 / 20, dy10 / 20
        for order in ("hv", "vh"):
            cx, cy = pcx + dx, pcy + dy
            kx, ky = (cx, pcy) if order == "hv" else (pcx, cy)
            s1, s2 = seg(pcx, pcy, kx, ky), seg(kx, ky, cx, cy)
            pad_li = (cx - 0.085, cy - 0.165, cx + 0.085, cy + 0.165)
            if not all(clear(r, foreign, 0.17) for r in (s1, s2, pad_li)): continue
            m1 = (cx - 0.18, cy - 0.18, cx + 0.18, cy + 0.18)
            if not clear(m1, M1, 0.14) or not clear(m1, M2, 0.14): continue
            cost = abs(dx) + abs(dy)
            if best is None or cost < best[0]: best = (cost, cx, cy, [s1, s2], pad_li)
    if best:
        out[name] = dict(cx=round(best[1], 3), cy=round(best[2], 3), strips=[[round(v, 3) for v in r] for r in best[3]], pad_li=[round(v, 3) for v in best[4]], pin=pin)
        print(name, f"L: pad en ({best[1]:.3f}, {best[2]:.3f}), largo {best[0]:.2f} um")
    else: print(name, "SIN SITIO tampoco en L (±4 um)")
json.dump(out, open("plan.json", "w"), indent=1)
