#!/usr/bin/env python3
"""v3_g1.py — verificador r3, G1: toma de pozo n con y sin nsdm por las funciones DRC del precheck. Código propio (envoltorios
al estilo de precheck_map/map.py, que sí pude leer). Uso: v3_g1.py <outdir>"""
import sys, os, re, gdstk
out = os.path.abspath(sys.argv[1]); os.makedirs(out + "/gds", exist_ok=True); os.makedirs(out + "/reports", exist_ok=True)
import precheck
from klayout import rdb
precheck.REPORTS_PATH = out + "/reports"
LY = dict(nwell=(64, 20), diff=(65, 20), tap=(65, 44), nsdm=(93, 44), psdm=(94, 20), licon=(66, 44), li=(67, 20))
def sq(c, layer, half, cx=0.0, cy=0.0, halfy=None):
    hy = half if halfy is None else halfy
    c.add(gdstk.rectangle((round(cx - half, 3), round(cy - hy, 3)), (round(cx + half, 3), round(cy + hy, 3)), layer=LY[layer][0], datatype=LY[layer][1]))
def tap_only(c, implant):
    sq(c, "nwell", 1.0); sq(c, "tap", 0.205); sq(c, "licon", 0.085); sq(c, "li", 0.165)
    if implant: sq(c, "nsdm", 0.33)
def tap_with_pdiff(c, implant):          # pozo con difusión p+ contactada a 0,9 um de la toma
    c.add(gdstk.rectangle((-1.0, -1.0), (2.2, 1.0), layer=64, datatype=20))
    sq(c, "tap", 0.205); sq(c, "licon", 0.085); sq(c, "li", 0.165)
    if implant: sq(c, "nsdm", 0.33)
    sq(c, "diff", 0.205, cx=1.2); sq(c, "psdm", 0.33, cx=1.2); sq(c, "licon", 0.085, cx=1.2); sq(c, "li", 0.165, cx=1.2)
def two_taps(c):                         # toma normal con nsdm en x=0 y segunda toma SIN nsdm en x=1,2, mismo pozo
    c.add(gdstk.rectangle((-1.0, -1.0), (2.2, 1.0), layer=64, datatype=20))
    sq(c, "tap", 0.205); sq(c, "licon", 0.085); sq(c, "li", 0.165); sq(c, "nsdm", 0.33)
    sq(c, "tap", 0.205, cx=1.2); sq(c, "licon", 0.085, cx=1.2); sq(c, "li", 0.165, cx=1.2)
def sub_tap(c):                          # toma sin implante y sin pozo (como las cap_vpp shieldl1)
    sq(c, "tap", 0.205); sq(c, "licon", 0.085); sq(c, "li", 0.165)
PROBES = [("v3_ntap_con_nsdm_control", lambda c: tap_only(c, True)), ("v3_ntap_sin_nsdm", lambda c: tap_only(c, False)),
          ("v3_ntap_pdiff_con_nsdm_control", lambda c: tap_with_pdiff(c, True)), ("v3_ntap_pdiff_sin_nsdm", lambda c: tap_with_pdiff(c, False)),
          ("v3_dos_tomas_una_sin_nsdm", two_taps), ("v3_toma_sin_implante_sin_pozo", sub_tap)]
if len(sys.argv) > 2: PROBES = [p for p in PROBES if p[0] in sys.argv[2:]]
def kl(gds, check):
    rep = f"{out}/reports/drc_{check}.xml"
    if os.path.exists(rep): os.rename(rep, rep + ".prev")
    try: precheck.klayout_drc(gds, check); return 0, ""
    except Exception as e:
        if not os.path.exists(rep): return -1, str(e)
        r = rdb.ReportDatabase("x"); r.load(rep)
        return r.num_items(), " ".join(sorted({r.category_by_id(i.category_id()).name() for i in r.each_item()}))
def mg(gds, top):
    rep = f"{out}/reports/magic_drc.txt"
    if os.path.exists(rep): os.rename(rep, rep + ".prev")
    try: precheck.magic_drc(gds, top); return 0, ""
    except Exception as e:
        if not os.path.exists(rep): return -1, str(e)
        t = open(rep).read(); m = re.search(r"COUNT: (\d+)", t)
        return (int(m.group(1)) if m else -2), " | ".join(sorted({l.strip() for l in t.splitlines() if "(" in l and ")" in l and not l.startswith("[")}))[:400]
rows = []
for name, build in PROBES:
    lib = gdstk.Library(unit=1e-6, precision=1e-9); c = lib.new_cell(name); build(c)
    gds = f"{out}/gds/{name}.gds"; lib.write_gds(gds)
    m = mg(gds, name); res = {k: kl(gds, k) for k in ("feol", "beol", "offgrid")}
    rows.append(f"{name:34s} magic {m[0]} [{m[1]}] " + " ".join(f"{k} {v[0]} [{v[1]}]" for k, v in res.items()))
    print("V3ROW", rows[-1], flush=True)
    for k in ("magic_drc.mag", "magic_drc.txt", "drc_feol.xml", "drc_beol.xml", "drc_offgrid.xml"):
        if os.path.exists(f"{out}/reports/{k}"): os.replace(f"{out}/reports/{k}", f"{out}/reports/{name}__{k}")
open(out + "/v3_g1_tabla.txt", "a").write("\n".join(rows) + "\n")
