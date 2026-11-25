#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Reads the MISFIT-04 tile as built (GDS of the healthy tile and of each sabotaged one, the core's DEF) and the result files of
the experiments, and writes data.json for the page. Every number the page shows comes from here; nothing is typed into the page.
Usage: extract.py   (paths are relative to the repo; the core's DEF comes from local_flow, outside the repo)"""
import collections, hashlib, json, os, re, subprocess, sys
import gds
H = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.normpath(os.path.join(H, "..", "..", ".."))
ZT = os.path.normpath(os.path.join(REPO, ".."))
P = lambda *a: os.path.join(REPO, *a)
SRC = []                                   # every file read, with its SHA-256, for the provenance panel
def src(path):
    SRC.append([os.path.relpath(path, ZT), hashlib.sha256(open(path, "rb").read()).hexdigest()[:16]]); return path

LAY = {(64, 20): "nwell", (65, 20): "diff", (66, 20): "poly", (67, 20): "li1", (68, 20): "met1", (69, 20): "met2", (70, 20): "met3",
       (71, 20): "met4", (66, 44): "licon", (67, 44): "mcon", (68, 44): "via1", (69, 44): "via2", (70, 44): "via3"}
TOP, CORE, WRAP, MAC = "tt_um_misfit04", "misfit04_core", "xc19_slot_w", "xc19_slot_core"

def rect(pts):
    xs = [p[0] for p in pts]; ys = [p[1] for p in pts]
    return min(xs), min(ys), max(xs), max(ys)

def shapes(cells, name, ox=0, oy=0, skip=(), out=None):
    """Flattens a cell's own shapes and those of its references (except the ones in skip) into {layer: [x0, y0, x1, y1, ...]}."""
    out = collections.defaultdict(list) if out is None else out
    c = cells[name]
    for l, d, pts in c["b"]:
        if (l, d) in LAY:
            if len(pts) != 4 or len({p[0] for p in pts}) != 2 or len({p[1] for p in pts}) != 2:   # not a rectangle: kept as a polygon
                out["~" + LAY[(l, d)]].append([v for p in pts for v in (p[0] + ox, p[1] + oy)]); continue
            x0, y0, x1, y1 = rect(pts); out[LAY[(l, d)]] += [x0 + ox, y0 + oy, x1 + ox, y1 + oy]
    for r in c["r"]:
        if r[0] in skip or r[0].startswith("sky130_fd_sc_hd__"): continue
        assert not r[3] and r[4] == 0 and r[5] == r[6] == 1, r
        shapes(cells, r[0], ox + r[1], oy + r[2], skip, out)
    return out

def boundary(cells, name, layer=(235, 4)):
    b = [pts for l, d, pts in cells[name]["b"] if (l, d) == layer]
    return rect(b[0]) if b else None

def cls(master):
    m = master.replace("sky130_fd_sc_hd__", "")
    if m.startswith(("fill", "decap")): return "fill"
    if m.startswith("tap"): return "tap"
    if m.startswith(("df", "dl", "sdf")): return "ff"
    if m.startswith(("clkbuf", "clkdlybuf", "clkinv", "buf", "dlygate", "dlymetal")): return "buf"
    if m.startswith("diode"): return "diode"
    if m.startswith("conb"): return "tie"
    return "logic"

def tile(gdsfile):
    dbu, C = gds.read(gdsfile); assert abs(dbu - 0.001) < 1e-12
    top = C[TOP]; refs = {r[0]: r for r in top["r"]}
    return C, refs

def results(D):
    """The experiments' numbers, parsed from their own result files (never retyped)."""
    X = lambda *a: P("experiments", "misfit04", *a)
    num = lambda t: float(t.replace(",", "."))
    # corners: discharge time, counts at 50 MHz, sensitivity per trapped charge, I4's threshold (10 % of it)
    D["corners"] = []
    for c, t, ta, cnt, sc, thr, thc in re.findall(r"^(\w+) (-?\d+): tA = ([\d.]+) us = ([\d.]+) cuentas ; s_c = ([\d.]+) % ; 10 % de s_c = ([\d.]+) % del cociente ; = ([\d.]+) cuentas",
                                                 open(src(X("prereg_calc.txt"))).read(), re.M):
        D["corners"].append({"c": c, "t": int(t), "tA_us": float(ta), "counts": float(cnt), "sc": float(sc), "thr": float(thr), "thr_counts": float(thc)})
    assert len(D["corners"]) == 4
    # I4: real aggressors, active against quiet
    txt = open(src(X("i4", "i4.txt"))).read(); D["i4"] = {}
    for c, t, ctl, mx, thr, ph in re.findall(r"^(\w+)\s+(-?\d+): control c frente al contrato ([\d.]+) % \(vale\) · max_k \|D\(tA/tB\)\| = ([\d.]+) % \(umbral ([\d.]+) %; margen \w+\) por fase ([\d. ]+)$", txt, re.M):
        D["i4"]["%s %s" % (c, t)] = {"control": float(ctl), "max": float(mx), "thr": float(thr), "phases": [float(v) for v in ph.split()]}
    assert len(D["i4"]) == 4
    m = re.findall(r"S7 testigo max_k ([\d.]+) % \(([\d.]+)x umbral\) · S8 ([\d.]+) % \(([\d.]+)x umbral\)", txt)
    D["i4wit"] = {"S7": [float(m[0][0]), float(m[0][1])], "S8": [float(m[0][2]), float(m[0][3])]}        # first match: tt 27
    D["abl"] = dict((k, float(v)) for k, v in re.findall(r"(ag685|agin2|agin3) ([\d.]+) %", txt.split("ablacion")[1].split("\n")[0]))
    D["agr"] = json.load(open(src(X("i4", "agresores.json"))))
    e1 = open(src(X("i4", "e1.txt"))).read()
    D["e1"] = [[c, int(t), float(r.replace(",", "."))] for c, t, r in re.findall(r"^(\w+) (-?\d+)\s+[\d,]+ %\s+([\d,]+) %", e1, re.M)]
    # I5: the sabotage campaign. Standard checks (last row of each variant counts), E3's extra LVS, measurement checks
    std = {}
    for l in open(src(X("i5", "estandar.tsv"))):
        f = l.rstrip("\n").split("\t"); std[f[0]] = {"drc": int(f[1]), "lvs": f[2], "precheck": f[3]}
    D["std"] = std
    D["e3"] = dict(re.findall(r"^(ok|S\d+)\t(\w+)", open(src(X("e3", "e3.txt"))).read(), re.M))
    last = lambda f, key: [l for l in open(src(f)) if key in l][-1]
    D["meas"] = {"ok_i2": int(re.search(r"discrepancias=(\d+)", last(X("i2", "i2a.txt"), "I2A")).group(1)),
                 "S9_i2": int(re.search(r"discrepancias=(\d+)", last(X("i5", "medida_S9", "i2a.txt"), "I2A")).group(1)),
                 "ok_i3": int(re.search(r"= (\d+) \(prediccion", last(X("i3", "i3.txt"), "veredicto")).group(1)),
                 "S10_i3": int(re.search(r"= (\d+) \(prediccion", last(X("i5", "medida_S10", "i3.txt"), "veredicto")).group(1))}
    # E2: phase sweep of the S7 strips (signed change of tA/tB against the quiet instance of the same deck), tt 27
    T0 = 1e-6; caps = json.load(open(src(X("e2", "caps_e2.json")))); D["e2"] = {"caps_aF": {k: v * 1e18 for k, v in caps.items()}, "decks": [], "d": {}}
    def lee(fn):
        R = {}
        for l in open(fn, errors="replace"):
            f = l.split()
            if len(f) == 4 and f[0] == "RES": k, v = f[3].split("="); R[k] = float(v)
        return R
    r = lambda d, p: (d[p + "_oa"] - T0) / (d[p + "_ob"] - T0)
    import glob
    p3 = {}
    for l in open(src(X("i4", "p3.txt"))):
        f = l.split()
        if f[:3] == ["RES", "tt", "27"]: k, v = f[3].split("="); p3[k] = float(v)
    D["e2"]["p3"] = [(r(p3, "s7%d" % k) - r(p3, "q")) / r(p3, "q") * 100 for k in range(5)]
    ref = {"l216f%d" % (4 * k): v for k, v in enumerate(D["e2"]["p3"])}
    # a deck counts only if it finished and each control phase it carries repeats p3 within 0.001 points (same rule as analiza_e2.py)
    for fn in sorted(glob.glob(X("i4", "corridas", "p5*_*", "i4.log"))):
        d = lee(fn); name = os.path.basename(os.path.dirname(fn)); aborted = "aborted" in open(fn, errors="replace").read()
        if aborted or "q_oa" not in d or "q_ob" not in d: D["e2"]["decks"].append([name, "aborted"]); continue
        q = r(d, "q"); dd = {k[:-3]: (r(d, k[:-3]) - q) / q * 100 for k in d if k.endswith("_oa") and k[:-3] not in ("c", "q") and k[:-3] + "_ob" in d}
        if any(k in dd and abs(dd[k] - ref[k]) > 0.001 for k in ref): D["e2"]["decks"].append([name, "control"]); continue
        src(fn); D["e2"]["decks"].append([name, "ok"])
        for k, v in dd.items(): D["e2"]["d"].setdefault(k, []).append([name, v])

def main():
    D = {}
    C, refs = tile(src(P("instrument/misfit04/tile/build/tt_um_misfit04.gds")))
    die = boundary(C, TOP); D["die"] = list(die)
    cr, wr = refs[CORE], refs[WRAP]
    cb = boundary(C, CORE); D["core"] = [cb[0] + cr[1], cb[1] + cr[2], cb[2] + cr[1], cb[3] + cr[2]]
    mac = shapes(C, MAC, wr[1], wr[2]); wrap = shapes(C, WRAP, wr[1], wr[2], skip=(MAC,))
    xs = [v for l in mac.values() for v in l[0::2]]; ys = [v for l in mac.values() for v in l[1::2]]
    D["macro"] = [min(xs), min(ys), max(xs), max(ys)]
    D["mac"] = mac; D["wrap"] = wrap
    D["top"] = shapes(C, TOP, skip=(CORE, WRAP))
    cw = shapes(C, CORE, cr[1], cr[2]); D["corew"] = {k: v for k, v in cw.items() if k.lstrip("~") in ("met1", "met2", "met3", "met4")}
    # labels: the macro's nodes (li1/met1 text), the wrapper's 15 stubs, the tile's pins
    D["nodes"] = [[t[4], t[2] + wr[1], t[3] + wr[2]] for t in C[MAC]["t"]]
    D["stubs"] = [[t[4], t[2] + wr[1], t[3] + wr[2]] for t in C[WRAP]["t"] if t[0] == 69]
    D["pins"] = [[t[4], t[2], t[3]] for t in C[TOP]["t"] if t[0] == 71]
    # the core's cells, from its DEF (names and masters); sizes from each master's boundary in the GDS
    size = {n: boundary(C, n, (81, 4)) for n in C if n.startswith("sky130_fd_sc_hd__")}     # areaid.standardc: the cell's outline
    deff = open(src(os.path.join(ZT, "local_flow/misfit04_core/runs/core/final/def/misfit04_core.def"))).read()
    comp = deff[deff.index("\nCOMPONENTS"):deff.index("END COMPONENTS")]
    masters = []; cells = []
    for name, m, x, y in re.findall(r"- (\S+) (\S+) .*?(?:PLACED|FIXED) \( (\d+) (\d+) \)", comp):
        if m not in masters: masters.append(m)
        b = size[m]; cells.append([int(x) + cr[1], int(y) + cr[2], b[2] - b[0], b[3] - b[1], masters.index(m), name])
    assert len(cells) == int(re.search(r"COMPONENTS (\d+)", comp).group(1)) == len(C[CORE]["r"])
    D["masters"] = [m.replace("sky130_fd_sc_hd__", "") for m in masters]; D["mcls"] = [cls(m) for m in masters]; D["cells"] = cells
    # sabotaged tiles: what each adds to or removes from the healthy one (shapes outside the core's standard cells)
    def allsh(C, refs):
        out = set()
        for part, sh in (("m", shapes(C, WRAP, refs[WRAP][1], refs[WRAP][2])), ("t", shapes(C, TOP, skip=(CORE, WRAP)))):
            for l, v in sh.items():
                assert not l.startswith("~"), l
                for i in range(0, len(v), 4): out.add((l,) + tuple(v[i:i + 4]))
        return out
    ok = allsh(C, refs); D["sab"] = {}
    for s in ["S%d" % i for i in range(1, 11)]:
        f = P("experiments/misfit04/i5/build_%s/tt_um_misfit04.gds" % s)
        if not os.path.exists(f): D["sab"][s] = None; continue
        Cs, rs = tile(src(f)); a = allsh(Cs, rs)
        D["sab"][s] = {"add": sorted(a - ok), "del": sorted(ok - a), "macro_at": [rs[WRAP][1], rs[WRAP][2], bool(rs[WRAP][3])],
                       "core_cells": len(Cs[CORE]["r"])}
    results(D)
    D["prov"] = {"commit": subprocess.check_output(["git", "-C", REPO, "rev-parse", "--short", "HEAD"], text=True).strip(),
                 "dirty": bool(subprocess.check_output(["git", "-C", REPO, "status", "--porcelain"], text=True).strip()),
                 "date": subprocess.check_output(["date", "+%Y-%m-%d"], text=True).strip(), "files": SRC}
    json.dump(D, open(os.path.join(H, "data.json"), "w"), separators=(",", ":"))
    print("data.json", os.path.getsize(os.path.join(H, "data.json")), "bytes;", len(cells), "cells;",
          {k: len(v) // 4 for k, v in mac.items()}, {k: len(v) for k, v in D["corew"].items()}, {s: (len(v["add"]), len(v["del"]), v["macro_at"]) if v else None for s, v in D["sab"].items()})
if __name__ == "__main__": main()
