"""MISFIT-07 enmienda 1: decks de lectura asincrona. Uso: XC19_INC=<v_hm lod.inc> gen_m7b.py -> as_<c>_<t>/m7.sp"""
import os, sys
H = os.path.dirname(os.path.abspath(__file__)); sys.path.insert(0, H)
import gen_m7 as M
G = M.G; OFF = -0.05
def deck(c, t):
    s = G.HEAD.format(kind="MISFIT-07 enmienda 1, asincrona", c=c, t=t)
    for k in M.KS: s += M.var(f"core{k}", k, False) + M.var(f"trap{k}", k, True)
    s += f"Vd vdd 0 1.8\nVh hi 0 1.8\nVpre pre 0 pwl(0 1.8 {G.T0} 1.8 {G.T0 + 1e-9} 0)\n"
    run = []
    for k in M.KS:
        for tag, v, gt in (("h", "core", None), ("a", "trap", f"({OFF})"), ("at", "trap", f"({OFF})+{G.TRAP}")):
            inst = f"{tag}{k}"; blk = G.slot(inst, v, "vdd", "vdd", "hi", "pre", "0", "hi")
            old = f" {v}\n"; i = blk.index(f"X{inst}_M "); j = blk.index("\n", i) + 1
            assert blk[i:j].endswith(old); blk = blk[:i] + blk[i:j][:-len(old)] + f" {v}{k}\n" + blk[j:]
            if gt:
                o = f"B{inst}_gt {inst}_GT 0 V=v({inst}_VB)+{G.TRAP}\n"; assert o in blk
                blk = blk.replace(o, f"B{inst}_gt {inst}_GT 0 V=v({inst}_VB)+{gt}\n")
            s += blk; run.append(inst)
    c_ = [".control", "set noaskquit", "save " + " ".join(f"v({r}_oa) v({r}_ob) v({r}_VB)" for r in run), "tran 10n 250u"]
    for r in run:
        for sd in ("oa", "ob"):
            c_ += [f"meas tran {r}_{sd} when v({r}_{sd})=0.9 rise=1", f"echo M7 {c} {t} {r}_{sd} $&{r}_{sd}"]
        c_ += [f"meas tran {r}_vb0 find v({r}_VB) at=0.9e-6", f"meas tran {r}_vbmax max v({r}_VB) from={G.T0} to=250u",
               f"meas tran {r}_vbmin min v({r}_VB) from={G.T0} to=250u",
               f"echo M7 {c} {t} {r}_vb0 $&{r}_vb0", f"echo M7 {c} {t} {r}_vbmax $&{r}_vbmax", f"echo M7 {c} {t} {r}_vbmin $&{r}_vbmin"]
    return s + "\n".join(c_ + ["quit", ".endc", ".end"]) + "\n"
for c, t in G.CORNERS:
    d = os.path.join(H, f"as_{c}_{t}"); os.makedirs(d, exist_ok=True); open(os.path.join(d, "m7.sp"), "w").write(deck(c, t))
print("ok")
