#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""b20_drc: sondas de la union pegada p+/n+ (XC-20) por las funciones de DRC del precheck de Tiny Tapeout. Derivado de
precheck_map/map.py (mismas funciones mg/kl, mismas capas); cambian las sondas. Se corre dentro del contenedor del precheck
(ver b20_drc_NOTAS.txt). Uso: b20_drc_map.py <outdir>"""
import sys, os, re, shutil, gdstk
out = os.path.abspath(sys.argv[1]); os.makedirs(out + "/gds", exist_ok=True); os.makedirs(out + "/reports", exist_ok=True)
import precheck
from klayout import rdb
precheck.REPORTS_PATH = out + "/reports"
L = dict(nwell=(64, 20), diff=(65, 20), tap=(65, 44), nsdm=(93, 44), psdm=(94, 20), poly=(66, 20), npc=(95, 20),
         licon=(66, 44), li=(67, 20), mcon=(67, 44), m1=(68, 20), hvi=(75, 20), lvtn=(125, 44), hvtp=(78, 44))
def R(c, layer, x0, y0, x1, y1): c.add(gdstk.rectangle((x0, y0), (x1, y1), layer=L[layer][0], datatype=L[layer][1]))
def rects(rs): return [gdstk.rectangle((r[0], r[1]), (r[2], r[3])) for r in rs]
def put(c, layer, polys):
    for p in polys: c.add(gdstk.Polygon(p.points, layer=L[layer][0], datatype=L[layer][1]))
def cont(c, x, y):            # licon 0.17 + li 0.33 centrados en (x, y)
    R(c, "licon", x - 0.085, y - 0.085, x + 0.085, y + 0.085); R(c, "li", x - 0.165, y - 0.165, x + 0.165, y + 0.165)
def bbox(rs): return min(r[0] for r in rs), min(r[1] for r in rs), max(r[2] for r in rs), max(r[3] for r in rs)

def junction(c, a, b, well=True, mid=False):
    """Como junction() de map.py pero con contacto en los dos lados. Izquierda = capa diff hasta x=a; derecha = capa tap desde
    x=b. En pozo n: p+ diff | n+ tap. En sustrato: n+ diff | p+ tap. Implantes al ras de a y b (como map.py) o, con mid, los
    dos hasta el centro del hueco."""
    li_, ri_ = ("psdm", "nsdm") if well else ("nsdm", "psdm")
    if well: R(c, "nwell", -1.5, -1.0, 1.5, 1.0)
    R(c, "diff", -1.0, -0.25, a, 0.25); R(c, "tap", b, -0.25, 1.0, 0.25)
    m = (a + b) / 2
    R(c, li_, -1.125, -0.375, m if mid else a, 0.375); R(c, ri_, m if mid else b, -0.375, 1.125, 0.375)
    cont(c, -0.685, 0); cont(c, 0.685, 0)

def shape(c, P, N, pc, nc, well=True, hv=False, cover=None, PI=None, NI=None):
    """Regiones p+ (P) y n+ (N) como listas de rectangulos que se tocan; implantes = region crecida 0.125, repartidos de modo que
    el borde de los dos implantes coincide con la frontera dentro del activo. pc, nc: centros de contacto."""
    pl, nl = ("diff", "tap") if well else ("tap", "diff")
    Pm = gdstk.boolean(rects(P), [], "or"); Nm = gdstk.boolean(rects(N), [], "or")
    put(c, pl, Pm); put(c, nl, Nm)
    nsdm = gdstk.boolean(gdstk.offset(Nm, 0.125, join="miter"), Pm, "not")
    psdm = gdstk.boolean(gdstk.offset(Pm, 0.125, join="miter"), nsdm, "not")
    if PI is not None:        # ronda 2: implantes dibujados a mano (el reparto automatico deja resaltes de 0.125 en el margen)
        psdm = gdstk.boolean(rects(PI), [], "or"); nsdm = gdstk.boolean(rects(NI), [], "or")
    put(c, "nsdm", nsdm); put(c, "psdm", psdm)
    x0, y0, x1, y1 = bbox(P + N)
    if well: R(c, "nwell", x0 - 0.5, y0 - 0.5, x1 + 0.5, y1 + 0.5)
    if hv: R(c, "hvi", x0 - 1.0, y0 - 1.0, x1 + 1.0, y1 + 1.0)
    if cover: R(c, cover[0], *cover[1])
    for x, y in pc + nc: cont(c, x, y)

CTRL = dict(P=[(-1.0, -0.25, 0, 0.25)], N=[(0, -0.25, 1.0, 0.25)], pc=[(-0.685, 0)], nc=[(0.685, 0)])
def ell(c):                   # la toma n+ rodea dos lados de un cuadrado p+ de 0.5
    shape(c, [(-0.5, -0.5, 0, 0)], [(0, -0.5, 0.5, 0.5), (-0.5, 0, 0, 0.5)], [(-0.25, -0.25)], [(0.25, -0.25)])
def island(c, h, inner_n):    # isla de lado 2h dentro de un anillo de 0.5 de ancho del tipo contrario
    o = h + 0.5
    ring = [(-o, -o, -h, o), (h, -o, o, o), (-h, -o, h, -h), (-h, h, h, o)]; isl = [(-h, -h, h, h)]
    rc = [(-(h + 0.25), 0)]
    if inner_n: shape(c, ring, isl, rc, [(0, 0)])
    else: shape(c, isl, ring, [(0, 0)], rc)
def comb(c):                  # activo unico de 2 x 2; espina p abajo, espina n arriba, 4 dedos de 0.5 alternados
    P = [(0, 0, 2, 0.5), (0, 0.5, 0.5, 1.5), (1.0, 0.5, 1.5, 1.5)]
    N = [(0, 1.5, 2, 2), (0.5, 0.5, 1.0, 1.5), (1.5, 0.5, 2.0, 1.5)]
    shape(c, P, N, [(0.25, 0.25)], [(1.75, 1.75)])
def neck(c, w, ln=0.30):      # pads de 0.5 unidos por un cuello de ancho w; la frontera, en el centro del cuello
    P = [(-1.0, -0.25, -ln, 0.25), (-ln, -w / 2, 0, w / 2)]; N = [(ln, -0.25, 1.0, 0.25), (0, -w / 2, ln, w / 2)]
    shape(c, P, N, [(-0.685, 0)], [(0.685, 0)])
def neck_pad(c, w, ln=0.30):  # cuello p de ancho w que muere contra un pad n ancho
    P = [(-1.0, -0.25, -ln, 0.25), (-ln, -w / 2, 0, w / 2)]; N = [(0, -0.25, 1.0, 0.25)]
    shape(c, P, N, [(-0.685, 0)], [(0.685, 0)])
def corner(c, seg):           # dos cuadrados de 0.5 de tipo contrario que se tocan en una esquina (seg=0) o en un tramo seg
    P = [(-0.5, -0.5, 0, 0)]; N = [(0, -seg, 0.5, 0.5 - seg)]
    shape(c, P, N, [(-0.25, -0.25)], [(0.25, 0.25 - seg)])
def gate(c, Lg, well, mode, shift=0.0):
    """Activo horizontal de 0.5 de ancho con poly de largo Lg cruzado en x=0. Izquierda = difusion (p+ en pozo, n+ en sustrato),
    derecha = el tipo contrario desde xj. xj = 0 (centro del poly) o Lg/2 + shift. mode 'tap': la derecha va en capa tap desde
    xj; mode 'diff': todo el activo en capa diff y solo cambia el implante."""
    li_, ri_ = ("psdm", "nsdm") if well else ("nsdm", "psdm")
    xj = 0.0 if shift == 0 else Lg / 2 + shift
    if well: R(c, "nwell", -1.6, -1.0, 1.6, 1.0)
    if mode == "tap": R(c, "diff", -1.1, -0.25, xj, 0.25); R(c, "tap", xj, -0.25, 1.1, 0.25)
    else: R(c, "diff", -1.1, -0.25, 1.1, 0.25)
    R(c, li_, -1.225, -0.375, xj, 0.375); R(c, ri_, xj, -0.375, 1.225, 0.375)
    R(c, "poly", -Lg / 2, -0.38, Lg / 2, 0.38)
    cont(c, -0.785, 0); cont(c, 0.785, 0)

FULL = (-1.18, -0.43, 1.18, 0.43); BAND = (-0.19, -0.43, 0.19, 0.43)
PROBES = [
 ("01a_ctrl_pdiff_ntap_sep0", lambda c: junction(c, 0.0, 0.0)),
 ("01b_ctrl_gap_013", lambda c: junction(c, -0.065, 0.065)),
 ("02a_ndiff_ptap_sub_sep0", lambda c: junction(c, 0.0, 0.0, well=False)),
 ("02b_ndiff_ptap_sub_gap_027_mid", lambda c: junction(c, -0.135, 0.135, well=False, mid=True)),
 ("03_L_esquina", ell),
 ("04a_isla_n05_en_p", lambda c: island(c, 0.25, True)), ("04b_isla_p05_en_n", lambda c: island(c, 0.25, False)),
 ("04c_isla_n06_en_p", lambda c: island(c, 0.30, True)), ("04d_isla_p06_en_n", lambda c: island(c, 0.30, False)),
 ("05_peine_4dedos_05", comb),
 ("06a_cuello_015", lambda c: neck(c, 0.15)), ("06b_cuello_p015_contra_pad_n", lambda c: neck_pad(c, 0.15)),
 ("07a_hv_mvpdiff_mvntap_pozo", lambda c: shape(c, well=True, hv=True, **CTRL)),
 ("07b_hv_mvndiff_mvptap_sub", lambda c: shape(c, well=False, hv=True, **CTRL)),
 ("08a_lvtn_todo", lambda c: shape(c, cover=("lvtn", FULL), **CTRL)), ("08b_lvtn_banda", lambda c: shape(c, cover=("lvtn", BAND), **CTRL)),
 ("08c_hvtp_todo", lambda c: shape(c, cover=("hvtp", FULL), **CTRL)), ("08d_hvtp_banda", lambda c: shape(c, cover=("hvtp", BAND), **CTRL)),
]
for w, wn in ((True, "pozo"), (False, "sub")):
    for Lg, ln in ((0.15, "L015"), (0.5, "L050")):
        PROBES += [(f"09_puerta_{wn}_{ln}_centro_tap", lambda c, w=w, Lg=Lg: gate(c, Lg, w, "tap")),
                   (f"09_puerta_{wn}_{ln}_centro_diff", lambda c, w=w, Lg=Lg: gate(c, Lg, w, "diff")),
                   (f"09_puerta_{wn}_{ln}_fuera013", lambda c, w=w, Lg=Lg: gate(c, Lg, w, "tap", 0.13))]
    PROBES += [(f"09_puerta_{wn}_L015_fuera030_ctrl", lambda c, w=w: gate(c, 0.15, w, "tap", 0.30))]
PROBES += [
 ("10_solape_0005", lambda c: junction(c, 0.005, 0.0)), ("10_solape_001", lambda c: junction(c, 0.005, -0.005)),
 ("10_gap_0005", lambda c: junction(c, -0.005, 0.0)), ("10_gap_003", lambda c: junction(c, -0.015, 0.015)),
 ("10_gap_026", lambda c: junction(c, -0.13, 0.13)), ("10_gap_027", lambda c: junction(c, -0.135, 0.135)),
 ("10_gap_013_mid", lambda c: junction(c, -0.065, 0.065, mid=True)), ("10_gap_026_mid", lambda c: junction(c, -0.13, 0.13, mid=True)),
 ("10_gap_027_mid", lambda c: junction(c, -0.135, 0.135, mid=True)),
 ("11a_punta_esquina", lambda c: corner(c, 0.0)), ("11b_punta_tramo_015", lambda c: corner(c, 0.15)),
]
# Ronda 2 (escrita tras ver que el reparto automatico de implantes de la ronda 1 dispara MR_nsdm/psdm.WID/SP por si solo)
HALF = dict(PI=[(-1.125, -0.375, 0, 0.375)], NI=[(0, -0.375, 1.125, 0.375)])
def neck2(c, w, kind, ln=0.30):
    pp, npad = (-1.0, -0.25, -ln, 0.25), (ln, -0.25, 1.0, 0.25)
    if kind == "centro": P = [pp, (-ln, -w / 2, 0, w / 2)]; N = [npad, (0, -w / 2, ln, w / 2)]
    elif kind == "p_contra_pad_n": P = [pp, (-ln, -w / 2, 0, w / 2)]; N = [(0, -0.25, 1.0, 0.25)]
    else: P = [(-1.0, -0.25, 0, 0.25)]; N = [npad, (0, -w / 2, ln, w / 2)]          # n_contra_pad_p
    shape(c, P, N, [(-0.685, 0)], [(0.685, 0)], **HALF)
def corner2(c, seg):
    shape(c, [(-0.5, -0.5, 0, 0)], [(0, -seg, 0.5, 0.5 - seg)], [(-0.25, -0.25)], [(0.25, 0.25 - seg)],
          PI=[(-0.625, -0.625, 0, 0.125)], NI=[(0, -seg - 0.125, 0.625, 0.625 - seg)])
PROBES += [
 ("r2_03_L_esquina", lambda c: shape(c, [(-0.5, -0.5, 0, 0)], [(0, -0.5, 0.5, 0.5), (-0.5, 0, 0, 0.5)], [(-0.25, -0.25)], [(0.25, -0.25)],
                                     PI=[(-0.625, -0.625, 0, 0)], NI=[(0, -0.625, 0.625, 0.625), (-0.625, 0, 0, 0.625)])),
 ("r2_05_peine_4dedos_05", lambda c: shape(c, [(0, 0, 2, 0.5), (0, 0.5, 0.5, 1.5), (1.0, 0.5, 1.5, 1.5)],
                                           [(0, 1.5, 2, 2), (0.5, 0.5, 1.0, 1.5), (1.5, 0.5, 2.0, 1.5)], [(0.25, 0.25)], [(1.75, 1.75)],
                                           PI=[(-0.125, -0.125, 2.125, 0.5), (-0.125, 0.5, 0.5, 1.5), (1.0, 0.5, 1.5, 1.5)],
                                           NI=[(-0.125, 1.5, 2.125, 2.125), (0.5, 0.5, 1.0, 1.5), (1.5, 0.5, 2.125, 1.5)])),
 ("r2_06a_cuello_015_centro", lambda c: neck2(c, 0.15, "centro")),
 ("r2_06b_cuello_p015_contra_pad_n", lambda c: neck2(c, 0.15, "p_contra_pad_n")),
 ("r2_06c_cuello_n015_contra_pad_p", lambda c: neck2(c, 0.15, "n_contra_pad_p")),
 ("r2_11a_punta_esquina", lambda c: corner2(c, 0.0)), ("r2_11b_punta_tramo_015", lambda c: corner2(c, 0.15)),
]
PROBES += [
 ("r2_01a_ctrl_via_shape", lambda c: shape(c, **CTRL, **HALF)),
 ("r2_07a_hv_mvpdiff_mvntap_pozo", lambda c: shape(c, well=True, hv=True, **CTRL, **HALF)),
 ("r2_07b_hv_mvndiff_mvptap_sub", lambda c: shape(c, well=False, hv=True, **CTRL, **HALF)),
 ("r2_08a_lvtn_todo", lambda c: shape(c, cover=("lvtn", FULL), **CTRL, **HALF)), ("r2_08b_lvtn_banda", lambda c: shape(c, cover=("lvtn", BAND), **CTRL, **HALF)),
 ("r2_08c_hvtp_todo", lambda c: shape(c, cover=("hvtp", FULL), **CTRL, **HALF)), ("r2_08d_hvtp_banda", lambda c: shape(c, cover=("hvtp", BAND), **CTRL, **HALF)),
]
SUF = sys.argv[3] if len(sys.argv) > 3 else ""
if len(sys.argv) > 2: PROBES = [p for p in PROBES if re.search(sys.argv[2], p[0])]
def kl(gds, check, name):
    rep = f"{out}/reports/drc_{check}.xml"
    if os.path.exists(rep): os.remove(rep)
    try: precheck.klayout_drc(gds, check); return 0, ""
    except Exception as e:
        if not os.path.exists(rep): return -1, str(e)
        r = rdb.ReportDatabase("x"); r.load(rep)
        cats = sorted({r.category_by_id(i.category_id()).name() for i in r.each_item()})
        shutil.copy(rep, f"{out}/reports/{name}.{check}.xml")
        return r.num_items(), " ".join(cats)
MSG = {}
def mg(gds, top):
    rep = f"{out}/reports/magic_drc.txt"
    if os.path.exists(rep): os.remove(rep)
    try: precheck.magic_drc(gds, top); return 0, ""
    except Exception as e:
        if not os.path.exists(rep): return -1, str(e)
        t = open(rep).read(); n = int(re.search(r"COUNT: (\d+)", t).group(1))
        msgs = [l.strip() for l in t.splitlines()[2:] if l.strip() and not l.startswith((" ", "-", "[INFO]"))]
        MSG[top] = msgs
        rules = sorted({m[m.rfind("(") + 1:m.rfind(")")].replace(" ", "") if "(" in m else m for m in msgs})
        shutil.copy(rep, f"{out}/reports/{top}.magic.txt")
        return n, " | ".join(rules)
rows = []
for name, build in PROBES:
    lib = gdstk.Library(unit=1e-6, precision=1e-9); c = lib.new_cell(name); build(c)
    gds = f"{out}/gds/{name}.gds"; lib.write_gds(gds)
    m = mg(gds, name); f = kl(gds, "feol", name); b = kl(gds, "beol", name); o = kl(gds, "offgrid", name)
    ok = all(v[0] == 0 for v in (m, f, b, o))
    rows.append(f"{name:36s} {'PASA ' if ok else 'falla'}  magic {m[0]:3d} [{m[1]}]  feol {f[0]:3d} [{f[1]}]  beol {b[0]:3d} [{b[1]}]  offgrid {o[0]:3d} [{o[1]}]")
    print("ROW " + rows[-1], flush=True)
open(out + f"/map{SUF}.txt", "w").write("\n".join(rows) + "\n")
with open(out + f"/magic_mensajes{SUF}.txt", "w") as fh:
    for k, v in MSG.items(): fh.write(k + "\n" + "".join("    " + m + "\n" for m in v))
