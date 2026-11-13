#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Probe cells, one per kind of rule break, through the DRC functions of the Tiny Tapeout precheck. Run inside the precheck
container from tt-support-tools/precheck (see README). Usage: map.py <outdir>"""
import sys, os, re, shutil, gdstk
out = os.path.abspath(sys.argv[1]); os.makedirs(out + "/gds", exist_ok=True); os.makedirs(out + "/reports", exist_ok=True)
import precheck
from klayout import rdb
precheck.REPORTS_PATH = out + "/reports"
L = dict(nwell=(64, 20), diff=(65, 20), tap=(65, 44), nsdm=(93, 44), psdm=(94, 20), poly=(66, 20), npc=(95, 20),
         licon=(66, 44), li=(67, 20), mcon=(67, 44), m1=(68, 20))
def R(c, layer, x0, y0, x1, y1): c.add(gdstk.rectangle((x0, y0), (x1, y1), layer=L[layer][0], datatype=L[layer][1]))
def neck(c, layer, w, ln=0.30):
    R(c, layer, -1.0, -0.25, -ln / 2, 0.25); R(c, layer, ln / 2, -0.25, 1.0, 0.25); R(c, layer, -ln / 2, -w / 2, ln / 2, w / 2)
def ends(c, g):
    R(c, "m1", -1.0 - g / 2, -0.07, -g / 2, 0.07); R(c, "m1", g / 2, -0.07, 1.0 + g / 2, 0.07)
def junction(c, a, b):          # p+ diffusion up to x=a, n+ tap from x=b, inside an n-well
    R(c, "nwell", -1.5, -1.0, 1.5, 1.0); R(c, "diff", -1.0, -0.25, a, 0.25); R(c, "tap", b, -0.25, 1.0, 0.25)
    R(c, "psdm", -1.125, -0.375, a, 0.375); R(c, "nsdm", b, -0.375, 1.125, 0.375)
    R(c, "licon", 0.6, -0.085, 0.77, 0.085); R(c, "li", 0.52, -0.165, 0.85, 0.165)      # the tap must be contacted (run 1)
def well(c, tap):
    R(c, "nwell", -1.0, -1.0, 1.0, 1.0); R(c, "diff", -0.5, -0.21, 0.5, 0.21); R(c, "psdm", -0.625, -0.335, 0.625, 0.335)
    if tap:
        R(c, "tap", -0.21, 0.5, 0.21, 0.80); R(c, "nsdm", -0.335, 0.46, 0.335, 0.925)
        R(c, "licon", -0.085, 0.565, 0.085, 0.735); R(c, "li", -0.165, 0.485, 0.165, 0.815)
def fet(c, plate):
    R(c, "diff", -0.4, -0.21, 0.4, 0.21); R(c, "nsdm", -0.525, -0.335, 0.525, 0.335)
    R(c, "poly", -0.075, -0.34, 0.075, 1.0); R(c, "poly", -0.165, 1.0, 0.165, 1.33); R(c, "npc", -0.185, 0.98, 0.185, 1.35)
    R(c, "licon", -0.085, 1.08, 0.085, 1.25); R(c, "li", -0.165, 1.0, 0.165, 1.33); R(c, "mcon", -0.085, 1.08, 0.085, 1.25)
    R(c, "m1", -0.2, 1.0, 0.2, 1.33)
    if plate: R(c, "m1", -30, 1.33, 30, 61.33)
def holes(c, h, p):
    plate = gdstk.rectangle((0, 0), (10, 10)); hs = []
    n = int(9 / p)
    for i in range(n):
        for j in range(n): hs.append(gdstk.rectangle((0.5 + i * p, 0.5 + j * p), (0.5 + i * p + h, 0.5 + j * p + h)))
    for poly in gdstk.boolean(plate, hs, "not", layer=L["m1"][0], datatype=L["m1"][1]): c.add(poly)
PROBES = [
 ("m1_neck_014_control", lambda c: neck(c, "m1", 0.14)), ("m1_neck_010", lambda c: neck(c, "m1", 0.10)),
 ("m1_neck_007", lambda c: neck(c, "m1", 0.07)), ("m1_neck_010_short", lambda c: neck(c, "m1", 0.10, 0.14)),
 ("m1_ends_gap_014_control", lambda c: ends(c, 0.14)), ("m1_ends_gap_010", lambda c: ends(c, 0.10)), ("m1_ends_gap_005", lambda c: ends(c, 0.05)),
 ("li_neck_017_control", lambda c: neck(c, "li", 0.17)), ("li_neck_010", lambda c: neck(c, "li", 0.10)),
 ("pn_abutted_control", lambda c: junction(c, 0.0, 0.0)), ("pn_overlap_010", lambda c: junction(c, 0.05, -0.05)),
 ("pn_gap_013", lambda c: junction(c, -0.065, 0.065)),
 ("well_with_tap_control", lambda c: well(c, True)), ("well_no_tap", lambda c: well(c, False)),
 ("fet_small_metal_control", lambda c: fet(c, False)), ("fet_antenna_plate_60um", lambda c: fet(c, True)),
 ("m1_holes_014", lambda c: holes(c, 0.14, 0.8)), ("m1_holes_040", lambda c: holes(c, 0.40, 1.0)),
]
def kl(gds, check):
    rep = f"{out}/reports/drc_{check}.xml"
    if os.path.exists(rep): os.remove(rep)
    try: precheck.klayout_drc(gds, check); return 0, ""
    except Exception as e:
        if not os.path.exists(rep): return -1, str(e)
        r = rdb.ReportDatabase("x"); r.load(rep)
        cats = sorted({r.category_by_id(i.category_id()).name() for i in r.each_item()})
        return r.num_items(), " ".join(cats)
def mg(gds, top):
    rep = f"{out}/reports/magic_drc.txt"
    if os.path.exists(rep): os.remove(rep)
    try: precheck.magic_drc(gds, top); return 0, ""
    except Exception as e:
        if not os.path.exists(rep): return -1, str(e)
        t = open(rep).read(); n = int(re.search(r"COUNT: (\d+)", t).group(1))
        rules = sorted(set(re.findall(r"\(([a-z0-9A-Z_.]+(?:\.[0-9a-z]+)?)\)", t)))
        return n, " ".join(rules)
rows = []
for name, build in PROBES:
    lib = gdstk.Library(unit=1e-6, precision=1e-9); c = lib.new_cell(name); build(c)
    gds = f"{out}/gds/{name}.gds"; lib.write_gds(gds)
    m = mg(gds, name); f = kl(gds, "feol"); b = kl(gds, "beol"); o = kl(gds, "offgrid")
    ok = all(v[0] == 0 for v in (m, f, b, o))
    rows.append(f"{name:28s} {'PASS' if ok else 'fail'}  magic {m[0]:3d} [{m[1]}]  feol {f[0]:3d} [{f[1]}]  beol {b[0]:3d} [{b[1]}]  offgrid {o[0]:3d} [{o[1]}]")
    print(rows[-1], flush=True)
open(out + "/map.txt", "w").write("\n".join(rows) + "\n")
