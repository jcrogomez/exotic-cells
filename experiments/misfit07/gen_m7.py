"""MISFIT-07: decks. Prerregistro: cells/preregistros/MISFIT-07_2026-11-25_filtro_de_polarizacion.md (sellado 12:12:25 EST).
Variantes del macro v_hm con k dedos de filtro (se borran los demas 'GND VB GND GND nfet w=5.5 l=10' por orden de aparicion).
Uso: XC19_INC=<v_hm lod.inc> gen_m7.py -> tr_<c>_<t>/m7.sp"""
import os, sys
H = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(H, "..", "xc19_slot"))
assert "xc19_slot_core_a2/v_hm" in os.environ.get("XC19_INC", "")
import gen_contrato as G
KS = (33, 16, 8, 4, 2, 0)
isf = lambda f: f[0].startswith("X") and f[1:5] == ["GND", "VB", "GND", "GND"] and "w=5.5" in f and "l=10" in f
assert sum(1 for l in G.BODY if isf(l.split() or ["-"])) == 33

def var(name, k, trap):
    out = [f".subckt {name} " + " ".join(G.PORTS + (["GT"] if trap else []))]; seen = 0
    for l in G.BODY:
        f = l.split()
        if not f: continue
        if f[0] == ".ends": out.append(l); break
        if isf(f):
            seen += 1
            if seen > k: continue
        if trap and f == G.dutA: f = list(f); f[2] = "GT"; l = " ".join(f)
        out.append(l)
    assert seen == 33
    return "\n".join(out) + "\n"

def deck(c, t):
    ts = "160u" if (c, t) == ("ff", "-40") else "80u"
    s = G.HEAD.format(kind="MISFIT-07 filtro", c=c, t=t)
    for k in KS: s += var(f"core{k}", k, False) + var(f"trap{k}", k, True)
    s += f"Vd vdd 0 1.8\nVh hi 0 1.8\nVpre pre 0 pwl(0 1.8 {G.T0} 1.8 {G.T0 + 1e-9} 0)\n"
    run = []
    for k in KS:
        for tag, v, s1, s0 in (("h", "core", "0", "hi"), ("t", "trap", "0", "hi"), ("r", "core", "hi", "hi"), ("c", "core", "hi", "0")):
            inst = f"{tag}{k}"; blk = G.slot(inst, v, "vdd", "vdd", "hi", "pre", s1, s0)
            old = f" {v}\n"; i = blk.index(f"X{inst}_M "); j = blk.index("\n", i) + 1
            assert blk[i:j].endswith(old); blk = blk[:i] + blk[i:j][:-len(old)] + f" {v}{k}\n" + blk[j:]
            s += blk; run.append(inst)
    c_ = [".control", "set noaskquit", "save " + " ".join(f"v({r}_oa) v({r}_ob) v({r}_VB)" for r in run), f"tran 10n {ts}"]
    for r in run:
        for sd in ("oa", "ob"):
            c_ += [f"meas tran {r}_{sd} when v({r}_{sd})=0.9 rise=1", f"echo M7 {c} {t} {r}_{sd} $&{r}_{sd}"]
        c_ += [f"meas tran {r}_vb find v({r}_VB) at=0.9e-6", f"echo M7 {c} {t} {r}_vb $&{r}_vb"]
    return s + "\n".join(c_ + ["quit", ".endc", ".end"]) + "\n"

if __name__ == "__main__":
  for c, t in G.CORNERS:
      d = os.path.join(H, f"tr_{c}_{t}"); os.makedirs(d, exist_ok=True); open(os.path.join(d, "m7.sp"), "w").write(deck(c, t))
print("ok", KS)
