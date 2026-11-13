#!/usr/bin/env python3
"""v3_g3.py — G3: qué hay bajo los licon de las celdas cap_vpp del PDK. Uso: v3_g3.py <sky130_fd_pr.gds>"""
import sys, gdstk
lib = gdstk.read_gds(sys.argv[1])
LY = dict(diff=(65, 20), tap=(65, 44), poly=(66, 20), nsdm=(93, 44), psdm=(94, 20), licon=(66, 44), nwell=(64, 20), li=(67, 20))
def area(ps): return sum(p.area() for p in ps)
n = 0
for c in sorted(lib.cells, key=lambda c: c.name):
    if "cap_vpp" not in c.name: continue
    n += 1
    by = {k: c.get_polygons(depth=None, layer=l, datatype=d) for k, (l, d) in LY.items()}
    lic = by["licon"]
    if not lic: print(f"{c.name}: sin licon"); continue
    on_tap = gdstk.boolean(lic, by["tap"], "and") if by["tap"] else []
    on_diff = gdstk.boolean(lic, by["diff"], "and") if by["diff"] else []
    on_poly = gdstk.boolean(lic, by["poly"], "and") if by["poly"] else []
    imp = by["nsdm"] + by["psdm"]
    tap_noimp = gdstk.boolean(on_tap, imp, "not") if (on_tap and imp) else on_tap
    tapA = area(by["tap"]); tap_cov = area(gdstk.boolean(by["tap"], imp, "and")) if (by["tap"] and imp) else 0.0
    inwell = area(gdstk.boolean(on_tap, by["nwell"], "and")) if (on_tap and by["nwell"]) else 0.0
    print(f"{c.name}: licon n={len(lic)} A={area(lic):.3f} | sobre tap {area(on_tap):.3f} (en nwell {inwell:.3f}) diff {area(on_diff):.3f} poly {area(on_poly):.3f} | "
          f"licon∩tap sin nsdm/psdm = {area(tap_noimp):.3f} um2 | tap A={tapA:.2f}, cubierta por implante {tap_cov:.2f} | nsdm A={area(by['nsdm']):.2f} psdm A={area(by['psdm']):.2f}")
print("celdas cap_vpp:", n)
