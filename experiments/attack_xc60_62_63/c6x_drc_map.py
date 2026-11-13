#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""c63 + c62 probes through the DRC functions of the Tiny Tapeout precheck (same harness as precheck_map/map.py).
Run inside the precheck container. Usage: c6x_drc_map.py <outdir> [prefix-filter]"""
import sys, os, re, gdstk
out = os.path.abspath(sys.argv[1]); os.makedirs(out + "/gds", exist_ok=True); os.makedirs(out + "/reports", exist_ok=True)
flt = sys.argv[2] if len(sys.argv) > 2 else ""
import precheck
from klayout import rdb
precheck.REPORTS_PATH = out + "/reports"
L = dict(nwell=(64, 20), diff=(65, 20), tap=(65, 44), nsdm=(93, 44), psdm=(94, 20), poly=(66, 20), npc=(95, 20),
         licon=(66, 44), li=(67, 20), mcon=(67, 44), m1=(68, 20))
def R(c, layer, x0, y0, x1, y1):
    c.add(gdstk.rectangle((round(x0, 3), round(y0, 3)), (round(x1, 3), round(y1, 3)), layer=L[layer][0], datatype=L[layer][1]))
def box(c, x, y, layer="tap", impl=None, w=0.42, h=0.30, contact=True):
    """active box centred at x,y with a licon+li; impl = 'nsdm' / 'psdm' / None"""
    R(c, layer, x - w / 2, y - h / 2, x + w / 2, y + h / 2)
    if impl: R(c, impl, x - w / 2 - 0.125, y - h / 2 - 0.125, x + w / 2 + 0.125, y + h / 2 + 0.125)
    if contact:
        R(c, "licon", x - 0.085, y - 0.085, x + 0.085, y + 0.085); R(c, "li", x - 0.165, y - 0.165, x + 0.165, y + 0.165)
def nw(c): R(c, "nwell", -2, -2, 2, 2); box(c, 0, 1.15, "tap", "nsdm")          # well with its normal contacted tap
def psub(c): box(c, 0, 1.15, "tap", "psdm")
# ---------------- XC-63
def p_bare(c): nw(c); R(c, "licon", -0.085, -1.085, 0.085, -0.915); R(c, "li", -0.165, -1.165, 0.165, -0.835)
def p_tap_far(c): nw(c); box(c, 0, -1.0, "tap", None)
def p_tap_near(c): nw(c); box(c, 0.69, 1.15, "tap", None)                         # 0.27 from the implanted tap
def p_diff_far(c): nw(c); box(c, 0, -1.0, "diff", None)
def p_straddle(c):
    nw(c); box(c, 0, -1.0, "tap", None); R(c, "nsdm", -0.5, -1.275, 0.0, -0.725)   # implant edge through the licon centre
def p_edge_out(c):                                                               # one tap, half implanted, licon 0.3 outside
    nw(c); R(c, "tap", -0.6, -1.15, 0.6, -0.85); R(c, "nsdm", -0.725, -1.275, -0.1, -0.725)
    for x in (-0.4, 0.285): R(c, "licon", x - 0.085, -1.085, x + 0.085, -0.915); R(c, "li", x - 0.165, -1.165, x + 0.165, -0.835)
def p_edge_out_only(c):                                                          # same, only the unimplanted end is contacted
    nw(c); R(c, "tap", -0.6, -1.15, 0.6, -0.85); R(c, "nsdm", -0.725, -1.275, -0.1, -0.725)
    x = 0.285; R(c, "licon", x - 0.085, -1.085, x + 0.085, -0.915); R(c, "li", x - 0.165, -1.165, x + 0.165, -0.835)
def p_psub_tap_far(c): psub(c); box(c, 0, -1.0, "tap", None)
def p_psub_diff_far(c): psub(c); box(c, 0, -1.0, "diff", None)
def p_psub_edge_out(c):
    psub(c); R(c, "tap", -0.6, -1.15, 0.6, -0.85); R(c, "psdm", -0.725, -1.275, -0.1, -0.725)
    x = 0.285; R(c, "licon", x - 0.085, -1.085, x + 0.085, -0.915); R(c, "li", x - 0.165, -1.165, x + 0.165, -0.835)
def p_psdm_in_nwell_tap(c):   # p+ in n-well drawn on TAP layer: an ordinary p+/n junction, as contrast
    nw(c); box(c, 0, -1.0, "tap", "psdm")
# ---------------- XC-62 (nfet 0.42/0.15 in substrate, p-tap nearby)
W = 0.42
def fet(c, xs=(0.0,), ext_top=0.13, ext_bot=0.13, dl=None, field=(), bar=None, long_top=False):
    xl = min(xs) - 0.075 - (dl or 0.25); xr = max(xs) + 0.075 + (dl or 0.25)
    R(c, "diff", xl, -W / 2, xr, W / 2); R(c, "nsdm", xl - 0.125, -W / 2 - 0.125, xr + 0.125, W / 2 + 0.125)
    box(c, 0, -1.2, "tap", "psdm")
    top = W / 2 + ext_top
    for x in xs: R(c, "poly", x - 0.075, -W / 2 - ext_bot, x + 0.075, top)
    for x in field: R(c, "poly", x - 0.075, -W / 2 - ext_bot, x + 0.075, top)
    if bar is not None:                      # horizontal poly bar whose lower edge is `bar` above the diffusion edge
        y0 = W / 2 + bar; R(c, "poly", bar_x0, y0, bar_x1, y0 + 0.15)
bar_x0 = bar_x1 = 0
def f_iso(c): fet(c)
def f_iso_longcap(c): fet(c, ext_top=0.50, ext_bot=0.50)
def f_cap_010(c): fet(c, ext_top=0.10)                                    # illegal control
def f_nb1(c): fet(c, xs=(0.0, 0.36))
def f_nb2(c): fet(c, xs=(-0.36, 0.0, 0.36))
def f_nb2_042(c): fet(c, xs=(-0.57, 0.0, 0.57))
def f_nb2_100(c): fet(c, xs=(-1.15, 0.0, 1.15))
def f_field2(c): fet(c, field=(-0.475, 0.475))                            # field poly 0.075 from the diffusion ends (0.325 from gate)
def f_field2_illegal(c): fet(c, field=(-0.435, 0.435))                    # 0.035 from diffusion: control, must fail poly.4
def elbow(c, d, xs=(0.0,), U=False):
    global bar_x0, bar_x1
    bar_x0 = min(xs) - 0.075; bar_x1 = (max(xs) + 0.075) if U else 0.8
    fet(c, xs=xs, ext_top=d, bar=d)
def f_elbow_0075(c): elbow(c, 0.075)
def f_elbow_013(c): elbow(c, 0.13)
def f_elbow_005(c): elbow(c, 0.05)                                        # illegal control
def f_T_0075(c):
    global bar_x0, bar_x1; bar_x0, bar_x1 = -0.8, 0.8; fet(c, ext_top=0.075, bar=0.075)
def f_U_0075(c): elbow(c, 0.075, xs=(0.0, 0.36), U=True)
def f_U_013(c): elbow(c, 0.13, xs=(0.0, 0.36), U=True)
def f_bend_on_diff(c):                                                    # illegal control: bend over diffusion
    fet(c); R(c, "poly", 0.075, -0.075, 0.30, 0.075)
PROBES = [
 ("c63_ntap_control", lambda c: nw(c)), ("c63_licon_bare_nwell", p_bare), ("c63_tap_noimpl_far", p_tap_far),
 ("c63_tap_noimpl_near", p_tap_near), ("c63_diff_noimpl_nwell", p_diff_far), ("c63_licon_straddle", p_straddle),
 ("c63_tap_half_licon_out_both", p_edge_out), ("c63_tap_half_licon_out_only", p_edge_out_only),
 ("c63_psub_ptap_control", lambda c: psub(c)), ("c63_psub_tap_noimpl", p_psub_tap_far), ("c63_psub_diff_noimpl", p_psub_diff_far),
 ("c63_psub_tap_half_licon_out", p_psub_edge_out), ("c63_ptap_in_nwell_contrast", p_psdm_in_nwell_tap),
 ("c62_iso_control", f_iso), ("c62_iso_longcap", f_iso_longcap), ("c62_cap_010_illegal", f_cap_010),
 ("c62_nb1_021", f_nb1), ("c62_nb2_021", f_nb2), ("c62_nb2_042", f_nb2_042), ("c62_nb2_100", f_nb2_100),
 ("c62_field2_0325", f_field2), ("c62_field2_illegal", f_field2_illegal),
 ("c62_elbow_0075", f_elbow_0075), ("c62_elbow_013", f_elbow_013), ("c62_elbow_005_illegal", f_elbow_005),
 ("c62_T_0075", f_T_0075), ("c62_U_0075", f_U_0075), ("c62_U_013", f_U_013), ("c62_bend_on_diff_illegal", f_bend_on_diff),
]
# ---------------- XC-60 (added after the first run; filter "c60")
def md_sti(c, gap=0.27, hw=2):          # p+ | STI | n+ in an n-well: the ordinary diode, top face = STI bottom
    R(c, "nwell", -hw, -2, hw, 2)
    R(c, "diff", -gap / 2 - 0.72, -0.21, -gap / 2, 0.21); R(c, "psdm", -gap / 2 - 0.845, -0.335, -gap / 2 + 0.125 if gap > 0.25 else 0, 0.335)
    R(c, "tap", gap / 2, -0.21, gap / 2 + 0.72, 0.21); R(c, "nsdm", gap / 2 - 0.125 if gap > 0.25 else 0, -0.335, gap / 2 + 0.845, 0.335)
    for x in (-gap / 2 - 0.4, gap / 2 + 0.4): R(c, "licon", x - 0.085, -0.085, x + 0.085, 0.085); R(c, "li", x - 0.165, -0.165, x + 0.165, 0.165)
def md_gated(c, lg=0.5):          # p+ | poly gate over active | n+ : gated diode, top face = gate oxide (s tunable by the gate)
    R(c, "nwell", -3, -2, 3, 2); xe = lg / 2 + 0.6
    R(c, "diff", -xe, -0.21, 0, 0.21); R(c, "tap", 0, -0.21, xe, 0.21)
    R(c, "psdm", -xe - 0.125, -0.335, 0, 0.335); R(c, "nsdm", 0, -0.335, xe + 0.125, 0.335)
    R(c, "poly", -lg / 2, -0.34, lg / 2, 0.34)
    for x in (-xe + 0.2, xe - 0.2): R(c, "licon", x - 0.085, -0.085, x + 0.085, 0.085); R(c, "li", x - 0.165, -0.165, x + 0.165, 0.165)
PROBES += [("c60_md_sti_027", lambda c: md_sti(c, 0.27)), ("c60_md_sti_100", lambda c: md_sti(c, 1.0)),
           ("c60_md_sti_300", lambda c: md_sti(c, 3.0)), ("c60b_md_sti_300_pozo_ancho", lambda c: md_sti(c, 3.0, 4)), ("c60_md_gated_050", lambda c: md_gated(c, 0.5)),
           ("c60_md_gated_200", lambda c: md_gated(c, 2.0))]
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
        open(f"{out}/reports/magic_{top}.txt", "w").write(t)
        rules = sorted(set(re.findall(r"\(([a-z0-9A-Z_.]+(?:\.[0-9a-z]+)?(?: \+ [a-zA-Z0-9_. +*]+)?)\)", t)))
        return n, " ".join(rules)
rows = []
for name, build in PROBES:
    if flt and not name.startswith(flt): continue
    lib = gdstk.Library(unit=1e-6, precision=1e-9); c = lib.new_cell(name); build(c)
    gds = f"{out}/gds/{name}.gds"; lib.write_gds(gds)
    m = mg(gds, name); f = kl(gds, "feol"); b = kl(gds, "beol"); o = kl(gds, "offgrid")
    ok = all(v[0] == 0 for v in (m, f, b, o))
    rows.append(f"{name:30s} {'PASS' if ok else 'fail'}  magic {m[0]:3d} [{m[1]}]  feol {f[0]:3d} [{f[1]}]  beol {b[0]:3d} [{b[1]}]  offgrid {o[0]:3d} [{o[1]}]")
    print(rows[-1], flush=True)
open(out + f"/map{('_' + flt) if flt else ''}.txt", "w").write("\n".join(rows) + "\n")
