#!/usr/bin/env python3
"""Residual, module 1: put the STI stress geometry (sa, sb) back into a netlist extracted by Magic.

Magic's sky130A extraction emits l, w, as, ad, ps, pd for MOSFETs and drops sa/sb, so every extracted
transistor is simulated at the reference diffusion length. This tool reads the flat layout Magic extracted
from, measures the diffusion on each side of every gate, and writes the values on the matching instances.

    lod_annotate.py cell.mag cell.ext cell.spice -o cell.lod.spice

Scope (v0): flat cells, rectangular gates, Manhattan diffusion. Not handled: sd, bent gates, hierarchy
(flatten in Magic first). Standard library only; no layout package needed.
"""
import argparse, re, sys
from collections import defaultdict

MAG_UNIT_UM = 0.01  # sky130A .mag without magscale: 1 unit = 10 nm (overridden by a magscale line)

GATE = re.compile(r"^(sc|mv|nn)?(n|p)(mos|fet)(lvt|hvt)?$")
DIFF = {"n": {"ndiff", "ndiffc", "mvndiff", "mvndiffc"}, "p": {"pdiff", "pdiffc", "mvpdiff", "mvpdiffc"}}


def read_mag(path):
    rects, layer, unit = defaultdict(list), None, MAG_UNIT_UM
    for line in open(path):
        t = line.split()
        if not t:
            continue
        if t[0] == "magscale":
            unit = MAG_UNIT_UM * int(t[1]) / int(t[2])
        elif t[0] == "<<":
            layer = t[1]
        elif t[0] == "rect" and layer not in (None, "labels", "end"):
            rects[layer].append(tuple(int(v) for v in t[1:5]))
        elif t[0] == "use":
            sys.exit(f"{path}: hierarchical cell; flatten it in Magic first")
    return rects, unit


def merge_touching(rs):
    """Bounding boxes of connected groups of rectangles."""
    rs, out = list(rs), []
    while rs:
        x0, y0, x1, y1 = rs.pop()
        grown = True
        while grown:
            grown = False
            for r in rs[:]:
                if r[0] <= x1 and r[2] >= x0 and r[1] <= y1 and r[3] >= y0:
                    x0, y0, x1, y1 = min(x0, r[0]), min(y0, r[1]), max(x1, r[2]), max(y1, r[3])
                    rs.remove(r)
                    grown = True
        out.append((x0, y0, x1, y1))
    return out


def reach(active, edge, direction, lo, hi):
    """Distance the active area extends from `edge` towards `direction` (+1/-1) across the strip lo..hi.

    `active` rectangles are (a0, a1, b0, b1): a along the channel, b across it.
    Returns the list of (strip_width, distance) for each strip between consecutive b boundaries.
    """
    cuts = sorted({lo, hi} | {b for r in active for b in (r[2], r[3]) if lo < b < hi})
    out = []
    for b0, b1 in zip(cuts, cuts[1:]):
        spans = sorted((r[0], r[1]) for r in active if r[2] <= b0 and r[3] >= b1)
        pos = edge
        moved = True
        while moved:
            moved = False
            for a0, a1 in spans:
                if direction > 0 and a0 <= pos < a1:
                    pos, moved = a1, True
                elif direction < 0 and a0 < pos <= a1:
                    pos, moved = a0, True
        out.append((b1 - b0, abs(pos - edge)))
    return out


def effective(strips, half_l):
    """BSIM4 effective distance for irregular diffusion: 1/(S+L/2) = sum_i (w_i/W) / (s_i+L/2)."""
    w = sum(s[0] for s in strips)
    return 1.0 / sum(sw / w / (d + half_l) for sw, d in strips) - half_l


def measure(rects, unit):
    """Return {(x_um, y_um) of the gate's lower-left corner: dict(sa, sb, l, w, type)}."""
    found = {}
    for layer, rs in rects.items():
        m = GATE.match(layer)
        if not m:
            continue
        pol = m.group(2)
        diff = [r for lay in DIFF[pol] for r in rects.get(lay, [])]
        gates = [r for lay, v in rects.items() if (g := GATE.match(lay)) and g.group(2) == pol for r in v]
        for x0, y0, x1, y1 in merge_touching(rs):
            def touches(side):
                for d in diff:
                    if side == "x" and d[1] < y1 and d[3] > y0 and (d[2] == x0 or d[0] == x1):
                        return True
                    if side == "y" and d[0] < x1 and d[2] > x0 and (d[3] == y0 or d[1] == y1):
                        return True
                return False
            along_x, along_y = touches("x"), touches("y")
            if along_x == along_y:
                sys.exit(f"gate at {x0},{y0}: cannot tell the channel direction")
            if along_x:
                act = [(r[0], r[2], r[1], r[3]) for r in diff + gates]
                e0, e1, lo, hi = x0, x1, y0, y1
            else:
                act = [(r[1], r[3], r[0], r[2]) for r in diff + gates]
                e0, e1, lo, hi = y0, y1, x0, x1
            half_l = (e1 - e0) / 2
            sa = effective(reach(act, e0, -1, lo, hi), half_l) * unit
            sb = effective(reach(act, e1, +1, lo, hi), half_l) * unit
            found[(round(x0 * unit, 4), round(y0 * unit, 4))] = dict(
                sa=sa, sb=sb, l=(e1 - e0) * unit, w=(hi - lo) * unit, type=layer)
    return found


def read_ext_devices(path):
    """Devices in the .ext file: position of the gate's lower-left corner and terminal nodes."""
    unit, devs = None, []
    for line in open(path):
        t = line.split()
        if t[:1] == ["scale"]:
            unit = int(t[3]) * 1e-8  # third field: centimicrons x 1e-6 per internal unit
        elif t[:2] == ["device", "msubckt"]:
            q = re.findall(r'"([^"]*)"', line)
            devs.append(dict(model=t[2], x=int(t[3]) * unit, y=int(t[4]) * unit, bulk=q[0], gate=q[1],
                             sd=frozenset(q[2:4])))
    return devs


def annotate(mag, ext, spice):
    rects, unit = read_mag(mag)
    geo = measure(rects, unit)
    devs = read_ext_devices(ext)
    for d in devs:
        key = (round(d["x"], 4), round(d["y"], 4))
        if key not in geo:
            sys.exit(f"device at {key} um in {ext} has no gate in {mag}")
        d.update(geo[key])
    out, used, report = [], set(), []
    for line in open(spice):
        t = line.split()
        if t and t[0][0] in "Xx" and len(t) > 5 and "sky130_fd_pr__" in t[5] and "fet" in t[5]:
            par = dict(p.split("=") for p in t[6:] if "=" in p)
            cands = [i for i, d in enumerate(devs) if i not in used and d["model"] == t[5] and d["gate"] == t[2]
                     and d["sd"] == frozenset((t[1], t[3]))
                     and abs(d["w"] - float(par["w"])) < 1e-3 and abs(d["l"] - float(par["l"])) < 1e-3]
            if not cands:
                sys.exit(f"no layout device matches: {line.strip()}")
            if len({(round(devs[i]['sa'], 4), round(devs[i]['sb'], 4)) for i in cands}) > 1:
                print(f"warning: {t[0]} has parallel twins with different sa/sb; assigned in file order", file=sys.stderr)
            d = devs[cands[0]]
            used.add(cands[0])
            line = line.rstrip("\n") + f" sa={d['sa']:.4g} sb={d['sb']:.4g}\n"
            report.append((t[0], d["type"], d["w"], d["l"], d["sa"], d["sb"]))
        out.append(line)
    return "".join(out), report


if __name__ == "__main__":
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("mag"), ap.add_argument("ext"), ap.add_argument("spice")
    ap.add_argument("-o", "--output", required=True)
    a = ap.parse_args()
    text, report = annotate(a.mag, a.ext, a.spice)
    open(a.output, "w").write(text)
    for name, typ, w, l, sa, sb in report:
        print(f"{name} {typ} w={w:.3g} l={l:.3g} sa={sa:.4g} sb={sb:.4g}")
