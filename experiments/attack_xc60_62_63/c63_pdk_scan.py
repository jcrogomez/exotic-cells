#!/usr/bin/env python3
"""c63 (c): busca en las celdas del propio PDK contactos (licon 66/44) sobre zona activa (diff 65/20 o tap 65/44) que NO
estén bajo nsdm (93/44) ni psdm (94/20): metal sobre silicio sin implante dibujado por la fábrica. Celda a celda, aplanada.
Uso: c63_pdk_scan.py <gds> <salida.txt>"""
import sys, gdstk
lib = gdstk.read_gds(sys.argv[1]); out = []; nhit = 0; ncell = 0
def get(polys, l, d): return [p for p in polys if p.layer == l and p.datatype == d]
for cell in lib.cells:
    c = cell.copy(cell.name + "_f"); c.flatten(); P = c.polygons
    if len(P) > 60000: out.append(f"{cell.name}: omitida ({len(P)} polígonos)"); continue
    ncell += 1
    lic = get(P, 66, 44)
    if not lic: continue
    act = get(P, 65, 20) + get(P, 65, 44); imp = get(P, 93, 44) + get(P, 94, 20)
    poly = get(P, 66, 20)
    a = gdstk.boolean(lic, act, "and")
    if not a: continue
    a = gdstk.boolean(a, poly, "not") if poly else a
    r = gdstk.boolean(a, imp, "not") if imp else a
    ar = sum(p.area() for p in r)
    if ar > 1e-4:
        nw = get(P, 64, 20); inw = sum(p.area() for p in gdstk.boolean(r, nw, "and")) if nw else 0.0
        ontap = sum(p.area() for p in gdstk.boolean(r, get(P, 65, 44), "and")) if get(P, 65, 44) else 0.0
        nhit += 1; out.append(f"{cell.name}: licon sobre activo sin implante {ar:.4f} um2 ({len(r)} trozos); en nwell {inw:.4f}; sobre tap {ontap:.4f}; total licon-activo {sum(p.area() for p in a):.3f}")
out.insert(0, f"# {sys.argv[1]}\n# celdas examinadas {ncell}; con licon sobre activo sin nsdm ni psdm: {nhit}")
open(sys.argv[2], "w").write("\n".join(out) + "\n"); print("\n".join(out[:60]))
