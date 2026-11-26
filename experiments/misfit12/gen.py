"""MISFIT-12, pruebas A y B: el lector pequeno v_f3 con matrices generadas colgadas de XA y XB (metodo de misfit11/gen_w.py).
Uso: XC19_INC=<v_f3 lod.inc> gen.py -> A/tr_<c>_<t>/m.sp (lod12) y B/tr_<c>_<t>/m.sp (u128). Lineas 'MX <c> <t> <inst>_<oa|ob> <t>'
A: n1 (control), l<k> (puesto k de lod12 cerrado, sa/sb de la tabla), w<k> (igual, todos anotados a 0,30: testigo).
B: n1, wc (1 fF), t1 (trampa en el lector solo), m128_0, m128_127, t128_0 (trampa en el puesto 0)."""
import os, sys, csv
H = os.path.dirname(os.path.abspath(__file__)); sys.path.insert(0, os.path.join(H, "..", "xc19_slot"))
assert "xc19_slot_core_a2/v_f3" in os.environ.get("XC19_INC", "")
import gen_contrato as G


def matriz(path, name, sub, gt=None, flat=False):
    L = open(os.path.join(path, name + ".pex.spice")).read().splitlines()
    seats = {int(r["seat"]): r for r in csv.DictReader(open(os.path.join(path, name + "_seats.csv")))}
    i0 = next(i for i, l in enumerate(L) if l.startswith(".subckt")); hdr = L[i0].split(); k = i0 + 1
    while L[k].startswith("+"): hdr += L[k][1:].split(); k += 1
    ports = hdr[2:]; body = L[k:]; dev = [l.split() for l in body if l.startswith("X")]; src = {}
    for d in dev:
        if d[2].startswith("SEL"): src[[x for x in (d[1], d[3]) if x != "GND"][0]] = int(d[2][3:])
    out = [f".subckt {sub} " + " ".join(ports + ([] if gt is None else ["GT"]))]; nd = 0
    for l in body:
        f = l.split()
        if f and f[0].startswith("X"):
            if f[2] == "VB":
                kk = src[[x for x in (f[1], f[3]) if x != "X"][0]]; r = seats[kk]; nd += 1
                if gt == kk: f[2] = "GT"
                f += ["sa=0.3", "sb=0.3"] if flat else [f"sa={r['sa_um']}", f"sb={r['sb_um']}"]
            else: f += ["sa=0.3", "sb=0.3"]
            l = " ".join(f)
        out.append(l)
    assert nd == len(seats)
    return ports, "\n".join(out) + "\n"


def cuelga(inst, ports, sub, k, subA=None):
    L = []
    for side in ("A", "B"):
        m = {"X": f"{inst}_X{side}", "VB": f"{inst}_VB", "GND": "0"}; gt = subA and side == "A"
        L.append(f"X{inst}mat{side} " + " ".join([m.get(p, "hi" if p == f"SEL{k}" else "0") for p in ports] + ([f"{inst}_GTm"] if gt else [])) + f" {subA if gt else sub}")
    if subA: L.append(f"B{inst}gtm {inst}_GTm 0 V=v({inst}_VB)+{G.TRAP}")
    return "\n".join(L) + "\n"


def deck(c, t, kind):
    ts = "240u" if (c, t) == ("ff", "-40") else "120u"
    s = G.HEAD.format(kind=f"MISFIT-12 prueba {kind}", c=c, t=t) + G.VARS["core"] + G.VARS["trap"]; run = []; extra = []
    if kind == "A":
        p, a = matriz(os.path.join(H, "..", "misfit11", "lod12"), "lod12", "lod12"); _, b = matriz(os.path.join(H, "..", "misfit11", "lod12"), "lod12", "lod12f", flat=True); s += a + b
        extra = [(f"l{k}", "core", "0", cuelga(f"l{k}", p, "lod12", k)) for k in range(12)] + [(f"w{k}", "core", "0", cuelga(f"w{k}", p, "lod12f", k)) for k in range(12)]
    else:
        p, a = matriz(os.path.join(H, "u128"), "u128", "u128"); _, b = matriz(os.path.join(H, "u128"), "u128", "u128g", gt=0); s += a + b
        extra = [("wc", "core", "hi", "Cwc wc_XA 0 1f\n"), ("t1", "trap", "hi", ""), ("m128_0", "core", "0", cuelga("m128_0", p, "u128", 0)),
                 ("m128_127", "core", "0", cuelga("m128_127", p, "u128", 127)), ("t128_0", "core", "0", cuelga("t128_0", p, "u128", 0, subA="u128g"))]
    s += f"Vd vdd 0 1.8\nVh hi 0 1.8\nVpre pre 0 pwl(0 1.8 {G.T0} 1.8 {G.T0 + 1e-9} 0)\n"
    for inst, var, s0, ex in [("n1", "core", "hi", "")] + extra:
        s += G.slot(inst, var, "vdd", "vdd", "hi", "pre", "0", s0, extra=ex); run.append(inst)
    c_ = [".control", "set noaskquit", "save " + " ".join(f"v({r}_oa) v({r}_ob)" for r in run), f"tran 10n {ts}"]
    for r in run:
        for sd in ("oa", "ob"): c_ += [f"meas tran {r}_{sd} when v({r}_{sd})=0.9 rise=1", f"echo MX {c} {t} {r}_{sd} $&{r}_{sd}"]
    return s + "\n".join(c_ + ["quit", ".endc", ".end"]) + "\n"


for kind in "AB":
    for c, t in G.CORNERS:
        d = os.path.join(H, kind, f"tr_{c}_{t}"); os.makedirs(d, exist_ok=True); open(os.path.join(d, "m.sp"), "w").write(deck(c, t, kind))
print("ok")
