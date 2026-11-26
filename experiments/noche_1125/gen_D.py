"""Plan nocturno 2026-11-25, bloque D (R6): N ramas DUT + interruptor en el lector pequeno v_f3. Metodo de MISFIT-05.
Uso: XC19_INC=<v_f3 lod.inc> gen_D.py -> D/tr_<c>_<t>/m.sp y D/lg_<c>_85/m.sp"""
import os, sys
H = os.path.dirname(os.path.abspath(__file__)); sys.path.insert(0, os.path.join(H, "..", "xc19_slot"))
assert "xc19_slot_core_a2/v_f3" in os.environ.get("XC19_INC", "")
import gen_contrato as G


def rama(side):
    sw = G.find(lambda d: d[2] == "DUT" + side); mid = [n for n in (sw[1], sw[3]) if n != "GND"][0]
    dut = G.find(lambda d: d[2] == "VB" and {d[1], d[3]} == {"X" + side, mid}); caps = []
    for l in G.BODY:
        f = l.split()
        if f and f[0].startswith("C") and mid in (f[1], f[2]) and float(f[3].rstrip("f")) > 0:
            caps.append(([n for n in (f[1], f[2]) if n != mid][0], f[3]))
    return dut, sw, mid, caps


RA, RB = rama("A"), rama("B")


def extra(p, n, first_a=None):
    L = []
    for side, (dut, sw, mid, caps) in (("A", RA), ("B", RB)):
        for k in range(n):
            m = f"{p}_m{side}{k}"; g = first_a if (side == "A" and k == 0 and first_a) else "0"
            sub = {mid: m, "X" + side: f"{p}_X{side}", "VB": f"{p}_VB", "GND": "0", "DUT" + side: g, "VDD": "vdd"}
            for dev, tag in ((dut, "d"), (sw, "s")):
                L.append(f"X{p}e{tag}{side}{k} " + " ".join(sub.get(x, x) for x in dev[1:5]) + " " + " ".join(dev[5:]))
            for j, (other, val) in enumerate(caps):
                L.append(f"C{p}e{side}{k}_{j} {m} {sub[other]} {val}")
    return "\n".join(L) + "\n"


def tr(c, t):
    ts = "240u" if (c, t) == ("ff", "-40") else "120u"
    s = G.HEAD.format(kind="noche 1125 bloque D", c=c, t=t) + G.VARS["core"] + G.VARS["trap"]
    s += f"Vd vdd 0 1.8\nVh hi 0 1.8\nVpre pre 0 pwl(0 1.8 {G.T0} 1.8 {G.T0 + 1e-9} 0)\n"; run = []

    def add(inst, var, n, more="", **kw):
        nonlocal s
        s += G.slot(inst, var, "vdd", "vdd", "hi", "pre", "0", "hi", extra=extra(inst, n - 1, **kw) + more); run.append(inst)
    for n in (1, 32, 64, 128): add(f"n{n}", "core", n)
    add("t1", "trap", 1); add("t64", "trap", 64); add("t128", "trap", 128)
    add("mc", "core", 2, first_a="vdd"); add("wi", "core", 1, more="Iwi wi_XA 0 40p\n"); add("wc", "core", 1, more="Cwc wc_XA 0 1f\n")
    c_ = [".control", "set noaskquit", "save " + " ".join(f"v({r}_oa) v({r}_ob)" for r in run), f"tran 10n {ts}"]
    for r in run:
        for sd in ("oa", "ob"):
            c_ += [f"meas tran {r}_{sd} when v({r}_{sd})=0.9 rise=1", f"echo MD {c} {t} {r}_{sd} $&{r}_{sd}"]
    return s + "\n".join(c_ + ["quit", ".endc", ".end"]) + "\n"


def lg(c, t):
    s = G.HEAD.format(kind="noche 1125 bloque D, todo abierto", c=c, t=t) + G.VARS["core"]
    s += f"Vd vdd 0 1.8\nVh hi 0 1.8\nVpre pre 0 pwl(0 1.8 {G.T0} 1.8 {G.T0 + 1e-9} 0)\n"
    s += G.slot("h00", "core", "vdd", "vdd", "hi", "pre", "0", "0")
    for n in (32, 128):
        s += G.slot(f"a{n}", "core", "vdd", "vdd", "hi", "pre", "0", "0", extra=extra(f"a{n}", n - 1))
    c_ = [".control", "set noaskquit", "save v(h00_XA) v(a32_XA) v(a128_XA) v(a32_oa) v(a128_oa)", "tran 100n 1.4m 0 200n"]
    for r in ("h00", "a32", "a128"):
        c_ += [f"meas tran {r}_min min v({r}_XA) from={G.T0} to=1.4m", f"echo LD {c} {t} {r}_XA_min $&{r}_min"]
    for r in ("a32", "a128"):
        c_ += [f"meas tran {r}_omax max v({r}_oa) from={G.T0} to=1.4m", f"echo LD {c} {t} {r}_oa_max $&{r}_omax",
               f"meas tran {r}_tx when v({r}_oa)=0.9 rise=1", f"echo LD {c} {t} {r}_cruce $&{r}_tx"]
    return s + "\n".join(c_ + ["quit", ".endc", ".end"]) + "\n"


for c, t in G.CORNERS:
    for kind, fn in (("tr", tr),) + ((("lg", lg),) if t == "85" else ()):
        d = os.path.join(H, "D", f"{kind}_{c}_{t}"); os.makedirs(d, exist_ok=True)
        open(os.path.join(d, "m.sp"), "w").write(fn(c, t))
print("ok D")
