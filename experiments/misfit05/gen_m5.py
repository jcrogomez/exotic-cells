"""MISFIT-05: decks. Prerregistro: cells/preregistros/MISFIT-05_2026-11-25_multiplexado_dut.md (sellado 11:11:38 EST).
Ramas extra = copia literal de las lineas del DUT y de su interruptor en el netlist extraido (A: X40/X86, B: X46/X74, halladas
por conectividad) + las capacidades extraidas del nodo intermedio. Interruptor de la rama extra: puerta a 0 (abierta) o a vdd.
Uso: XC19_INC=<v_hm lod.inc> gen_m5.py   -> tr_<c>_<t>/m5.sp, dc_<c>_<t>/m5.sp, lg_<c>_<t>/m5.sp (solo 85 C)"""
import os, sys
H = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(H, "..", "xc19_slot"))
assert "xc19_slot_core_a2/v_hm" in os.environ.get("XC19_INC", ""), "XC19_INC debe apuntar al macro v_hm"
import gen_contrato as G

def rama(side):
    sw = G.find(lambda d: d[2] == "DUT" + side)
    mid = [n for n in (sw[1], sw[3]) if n != "GND"][0]
    dut = G.find(lambda d: d[2] == "VB" and {d[1], d[3]} == {"X" + side, mid})
    caps = []
    for l in G.BODY:
        f = l.split()
        if f and f[0].startswith("C") and mid in (f[1], f[2]) and float(f[3].rstrip("f")) > 0:
            caps.append(([n for n in (f[1], f[2]) if n != mid][0], f[3]))
    return dut, sw, mid, caps
RA, RB = rama("A"), rama("B")

def extra(p, n_extra, gate_a="0", gate_b="0", first_a=None):
    """n_extra ramas en A y en B de la instancia p. first_a: puerta del interruptor de la primera rama extra de A (mutante)."""
    L = []
    for side, (dut, sw, mid, caps) in (("A", RA), ("B", RB)):
        for k in range(n_extra):
            m = f"{p}_m{side}{k}"
            g = (first_a if (side == "A" and k == 0 and first_a) else (gate_a if side == "A" else gate_b))
            sub = {mid: m, "X" + side: f"{p}_X{side}", "VB": f"{p}_VB", "GND": "0", "DUT" + side: g, "VDD": "vdd"}
            for dev, tag in ((dut, "d"), (sw, "s")):
                L.append(f"X{p}e{tag}{side}{k} " + " ".join(sub.get(x, x) for x in dev[1:5]) + " " + " ".join(dev[5:]))
            for j, (other, val) in enumerate(caps):
                o = sub.get(other)
                assert o is not None, other
                L.append(f"C{p}e{side}{k}_{j} {m} {o} {val}")
    return "\n".join(L) + "\n"

def tr(c, t):
    ts = "160u" if (c, t) == ("ff", "-40") else "80u"
    s = G.HEAD.format(kind="MISFIT-05 transitorio", c=c, t=t) + G.VARS["core"] + G.VARS["trap"]
    s += f"Vd vdd 0 1.8\nVh hi 0 1.8\nVpre pre 0 pwl(0 1.8 {G.T0} 1.8 {G.T0 + 1e-9} 0)\n"
    run = []
    def add(inst, var, n, **kw):
        nonlocal s
        ex = kw.pop("more", "")
        s += G.slot(inst, var, "vdd", "vdd", "hi", "pre", "0", "hi", extra=extra(inst, n - 1, **kw) + ex); run.append(inst)
    for n in (1, 2, 4, 8, 16): add(f"n{n}", "core", n)
    add("t1", "trap", 1); add("t16", "trap", 16)
    add("mc", "core", 2, first_a="vdd")
    add("wi", "core", 1, more="Iwi wi_XA 0 40p\n")
    add("wc", "core", 1, more="Cwc wc_XA 0 1f\n")
    c_ = [".control", "set noaskquit", "save " + " ".join(f"v({r}_oa) v({r}_ob)" for r in run), f"tran 10n {ts}"]
    for r in run:
        for sd in ("oa", "ob"):
            c_ += [f"meas tran {r}_{sd} when v({r}_{sd})=0.9 rise=1", f"echo M5 {c} {t} {r}_{sd} $&{r}_{sd}"]
    return s + "\n".join(c_ + ["quit", ".endc", ".end"]) + "\n"

def dc(c, t):
    s = G.HEAD.format(kind="MISFIT-05 fuga DC", c=c, t=t).replace("abstol=1e-15 reltol=1e-5", "abstol=1e-18 reltol=1e-6") + G.VARS["core"]
    assert "abstol=1e-18" in s
    s += "Vd vdd 0 1.8\nVh hi 0 1.8\nVx vx 0 1.8\nVy vy 0 1.8\nVg g 0 0\nIw vy 0 40p\n"
    s += G.slot("d", "core", "vdd", "vdd", "hi", "hi", "0", "hi")          # pre alto: en reposo, VB establecida
    dut, sw, mid, _ = RA
    for node, m in (("vx", "mx"), ("vy", "my")):                            # vy = la misma rama + testigo de 40 pA
        sub = {mid: m, "XA": node, "VB": "d_VB", "GND": "0", "DUTA": "g"}
        for dev, tag in ((dut, "d"), (sw, "s")):
            s += f"X{tag}{m} " + " ".join(sub.get(x, x) for x in dev[1:5]) + " " + " ".join(dev[5:]) + "\n"
    c_ = [".control", "set noaskquit"]
    for vx in (1.8, 0.9):
        for g in (0, 1.8):
            c_ += [f"alter Vx dc = {vx}", f"alter Vy dc = {vx}", f"alter Vg dc = {g}", "op",
                   "let ix = -vx#branch", "let iy = -vy#branch", "let vb = v(d_VB)",
                   f"echo DC {c} {t} vx={vx} g={g} $&ix $&iy $&vb"]
    return s + "\n".join(c_ + ["quit", ".endc", ".end"]) + "\n"

def lg(c, t):
    s = G.HEAD.format(kind="MISFIT-05 todo abierto, 1,4 ms", c=c, t=t) + G.VARS["core"]
    s += f"Vd vdd 0 1.8\nVh hi 0 1.8\nVpre pre 0 pwl(0 1.8 {G.T0} 1.8 {G.T0 + 1e-9} 0)\n"
    s += G.slot("h00", "core", "vdd", "vdd", "hi", "pre", "0", "0")
    s += G.slot("a16", "core", "vdd", "vdd", "hi", "pre", "0", "0", extra=extra("a16", 15))
    c_ = [".control", "set noaskquit", "save v(h00_XA) v(a16_XA) v(a16_XB) v(a16_oa) v(a16_ob)", "tran 100n 1.4m 0 200n"]
    for r, sd in (("h00", "XA"), ("a16", "XA"), ("a16", "XB")):
        c_ += [f"meas tran {r}_{sd}_min min v({r}_{sd}) from={G.T0} to=1.4m", f"echo LG {c} {t} {r}_{sd}_min $&{r}_{sd}_min"]
    for sd in ("oa", "ob"):
        c_ += [f"meas tran a16_{sd}_max max v(a16_{sd}) from={G.T0} to=1.4m", f"echo LG {c} {t} a16_{sd}_max $&a16_{sd}_max"]
    return s + "\n".join(c_ + ["quit", ".endc", ".end"]) + "\n"

for c, t in G.CORNERS:
    for kind, fn in (("tr", tr), ("dc", dc)) + ((("lg", lg),) if t == "85" else ()):
        d = os.path.join(H, f"{kind}_{c}_{t}"); os.makedirs(d, exist_ok=True)
        open(os.path.join(d, "m5.sp"), "w").write(fn(c, t))
print("rama A:", " ".join(RA[0][:5]), "|", " ".join(RA[1][:5]), "| caps", RA[3])
print("rama B:", " ".join(RB[0][:5]), "|", " ".join(RB[1][:5]), "| caps", RB[3])
