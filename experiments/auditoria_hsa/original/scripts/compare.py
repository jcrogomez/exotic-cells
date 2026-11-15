#!/usr/bin/env python3
"""Compara salidas de ngspice: guardada (repo) vs A (entorno por defecto) vs B (sin SPICE_USERINIT_DIR + spinit sky130A).
Extrae, de cada línea de resultado, los números; la clave es el esqueleto de la línea (números -> #) + ocurrencia."""
import re, sys, os, json, math
NUM = re.compile(r"(?<![A-Za-z_0-9.])[-+]?(?:\d+\.\d*|\.\d+|\d+)(?:[eE][-+]?\d+)?")
DROP = re.compile(r"^(Warning|Note|Circuit:|Doing analysis|Using |No\. of Data|ngspice-|Error|Reset re-loads|option SCALE|"
                  r"Original line|binary raw|Total |Simulation|Initial Transient|Node\s+Voltage|----|\s*$|Source conductance|"
                  r"Drain conductance|.*#branch\s)", re.I)

def parse(text):
    text = re.sub(r"Reference value\s*:\s*[-+0-9.eE]+", "\n", text)
    out, seen, in_op = {}, {}, False
    for line in text.splitlines():
        s = line.strip()
        if s.startswith("Initial Transient Solution") or s.startswith("Node ") and "Voltage" in s:
            in_op = True; continue
        if in_op:
            if s == "" or s.startswith("---") or s.startswith("Node"):
                if s == "" and seen.get("_op_started"):
                    in_op = False
                continue
            seen["_op_started"] = 1
            continue
        if DROP.match(s) or "#branch" in s:
            continue
        nums = NUM.findall(s)
        if not nums:
            continue
        skel = NUM.sub("#", s)
        skel = re.sub(r"\s+", " ", skel)
        k = seen.get(skel, 0); seen[skel] = k + 1
        out[f"{skel} @{k}"] = [float(x) for x in nums]
    seen.pop("_op_started", None)
    return out

def parse_dat(path):
    rows = []
    for line in open(path):
        try:
            rows.append([float(x) for x in line.split()])
        except ValueError:
            pass
    return {f"row{i}": r for i, r in enumerate(rows)}

def rel(a, b):
    if a == b: return 0.0
    d = max(abs(a), abs(b))
    return abs(a - b) / d if d else 0.0

MEAS = re.compile(r"^\S+ = # @\d+$")
def compare(x, y, cls=None):
    """devuelve (n comparados, max rel, clave del max, claves faltantes). cls: None todo, 'echo' solo líneas de resultado, 'meas' solo meas"""
    n, mx, km, missing = 0, 0.0, None, 0
    if cls == "echo": x = {k: v for k, v in x.items() if not MEAS.match(k)}; y = {k: v for k, v in y.items() if not MEAS.match(k)}
    if cls == "meas": x = {k: v for k, v in x.items() if MEAS.match(k)}; y = {k: v for k, v in y.items() if MEAS.match(k)}
    for k, v in x.items():
        if k not in y or len(y[k]) != len(v):
            missing += 1; continue
        for i, (a, b) in enumerate(zip(v, y[k])):
            r = rel(a, b); n += 1
            if r > mx: mx, km = r, f"{k}[{i}]: {a:.6g} -> {b:.6g}"
    missing += sum(1 for k in y if k not in x)
    return n, mx, km, missing

if __name__ == "__main__":
    S, R = sys.argv[1], sys.argv[2]
    res = []
    for deck in open(os.path.join(S, "decks.txt")).read().split():
        d, b = os.path.dirname(deck), os.path.basename(deck)[:-3]
        rec = {"deck": deck}
        saved = os.path.join(R, d, b + ".log")
        la = os.path.join(S, "A/repo", d, b + ".hsa_A.log")
        lb = os.path.join(S, "B/repo", d, b + ".hsa_B.log")
        P = {}
        for tag, p in (("S", saved), ("A", la), ("B", lb)):
            if os.path.exists(p):
                P[tag] = parse(open(p, errors="replace").read())
        rec["n"] = {k: sum(len(v) for v in P[k].values()) for k in P}
        if "S" in P and "A" in P: rec["SA"] = compare(P["S"], P["A"])
        if "A" in P and "B" in P:
            rec["AB"] = compare(P["A"], P["B"]); rec["ABe"] = compare(P["A"], P["B"], "echo"); rec["ABm"] = compare(P["A"], P["B"], "meas")
        # .dat de wrdata: comparar si existen en las tres
        for f in sorted(os.listdir(os.path.join(R, d))):
            if f.endswith(".dat") and f.startswith(b):
                fa, fb = os.path.join(S, "A/repo", d, f), os.path.join(S, "B/repo", d, f)
                if os.path.exists(fa) and os.path.exists(fb):
                    rec.setdefault("dat", {})[f] = {"SA": compare(parse_dat(os.path.join(R, d, f)), parse_dat(fa)), "AB": compare(parse_dat(fa), parse_dat(fb))}
        # .dat escritos por wrdata
        for f in os.listdir(os.path.join(R, d)):
            pass
        res.append(rec)
    json.dump(res, open(os.path.join(S, "compare.json"), "w"), indent=1)
    for r in res:
        sa = r.get("SA"); ab = r.get("AB")
        f = lambda c: "-" if c is None else f"n={c[0]} max={c[1]:.2e} miss={c[3]}"
        print(f"{r['deck']:62s} S-A {f(sa):32s} A-B {f(ab)} | echo {f(r.get('ABe'))} | meas {f(r.get('ABm'))}"); print("      maxAB:", ab[2] if ab else "-", "| maxSA:", sa[2] if sa else "-")
        for k, v in r.get("dat", {}).items(): print("      dat", k, "S-A", f(v["SA"]), "A-B", f(v["AB"]), v["AB"][2])
