"""MISFIT-09, S5: contrato del macro pequeno (v_f3) frente a v_hm en el mismo deck. Prerregistro sellado 12:48 EST aprox.
Uso: gen_m9.py -> tr_<c>_<t>/m9.sp y ac_tt_27/m9.sp"""
import os, sys, importlib.util
H = os.path.dirname(os.path.abspath(__file__))
A2 = os.path.join(H, "..", "..", "cells", "xc19_slot_core_a2")
def load(name, inc):
    os.environ["XC19_INC"] = inc
    sp = importlib.util.spec_from_file_location(name, os.path.join(H, "..", "xc19_slot", "gen_contrato.py"))
    m = importlib.util.module_from_spec(sp); sp.loader.exec_module(m); return m
GB = load("gc_big", os.path.join(A2, "v_hm", "xc19_slot_core_lod.inc"))
GS = load("gc_small", os.path.join(A2, "v_f3", "xc19_slot_core_lod.inc"))
nf = lambda G: sum(1 for l in G.BODY if l.split()[1:5] == ["GND", "VB", "GND", "GND"] and "w=5.5" in l)
assert nf(GB) == 33 and nf(GS) == 3, (nf(GB), nf(GS))
def subs(G, suf):
    return (G.VARS["core"].replace(".subckt core ", f".subckt core{suf} ", 1) + G.VARS["trap"].replace(".subckt trap ", f".subckt trap{suf} ", 1))
def inst(G, suf, name, v, s1, s0, extra=""):
    blk = G.slot(name, v, "vdd", "vdd", "hi", "pre", s1, s0, extra=extra)
    i = blk.index(f"X{name}_M "); j = blk.index("\n", i) + 1; old = f" {v}\n"
    assert blk[i:j].endswith(old); return blk[:i] + blk[i:j][:-len(old)] + f" {v}{suf}\n" + blk[j:]
def deck(c, t):
    ts = "160u" if (c, t) == ("ff", "-40") else "80u"
    s = GB.HEAD.format(kind="MISFIT-09 lector pequeno frente a v_hm", c=c, t=t) + subs(GB, "B") + subs(GS, "S")
    s += f"Vd vdd 0 1.8\nVh hi 0 1.8\nVpre pre 0 pwl(0 1.8 {GB.T0} 1.8 {GB.T0 + 1e-9} 0)\n"
    run = []
    for G, suf in ((GB, "B"), (GS, "S")):
        for tag, v, s1, s0 in (("h", "core", "0", "hi"), ("t", "trap", "0", "hi"), ("r", "core", "hi", "hi"), ("c", "core", "hi", "0")):
            n = f"{tag}{suf}"; s += inst(G, suf, n, v, s1, s0); run.append(n)
    s += inst(GS, "S", "wS", "core", "0", "hi", extra="Cw wS_XA 0 1f\n"); run.append("wS")
    c_ = [".control", "set noaskquit", "save " + " ".join(f"v({r}_oa) v({r}_ob)" for r in run), f"tran 10n {ts}"]
    for r in run:
        for sd in ("oa", "ob"):
            c_ += [f"meas tran {r}_{sd} when v({r}_{sd})=0.9 rise=1", f"echo M9 {c} {t} {r}_{sd} $&{r}_{sd}"]
    return s + "\n".join(c_ + ["quit", ".endc", ".end"]) + "\n"
def acdeck():
    s = GB.HEAD.format(kind="MISFIT-09 capacidad de VB (AC)", c="tt", t="27") + subs(GB, "B") + subs(GS, "S")
    s += "Vd vdd 0 1.8\nVh hi 0 1.8\n"
    for G, suf in ((GB, "B"), (GS, "S")):
        s += inst(G, suf, f"a{suf}", "core", "0", "hi").replace(" pre ", " hi ")      # precarga puesta: reposo
        s += f"Ia{suf} 0 a{suf}_VB dc 0 ac {1 if suf == 'B' else 0}\n"
    c_ = [".control", "set noaskquit"]
    for suf, other in (("B", "S"), ("S", "B")):
        c_ += [f"alter Ia{suf} ac = 1", f"alter Ia{other} ac = 0", "ac dec 5 1e5 1e8"]
        for f in ("1e6", "1e7"):
            c_ += [f"meas ac y{suf}{f[-1]} find vi(a{suf}_VB) at={f}", f"meas ac x{suf}{f[-1]} find vr(a{suf}_VB) at={f}",
                   f"echo AC {suf} {f} $&x{suf}{f[-1]} $&y{suf}{f[-1]}"]
    return s + "\n".join(c_ + ["quit", ".endc", ".end"]) + "\n"
for c, t in GB.CORNERS:
    d = os.path.join(H, f"tr_{c}_{t}"); os.makedirs(d, exist_ok=True); open(os.path.join(d, "m9.sp"), "w").write(deck(c, t))
d = os.path.join(H, "ac_tt_27"); os.makedirs(d, exist_ok=True); open(os.path.join(d, "m9.sp"), "w").write(acdeck())
print("ok")
