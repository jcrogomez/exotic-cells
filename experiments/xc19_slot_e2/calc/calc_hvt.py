"""MISFIT-03 enmienda 2, calculo de diseno (antes del prerregistro): el inversor de salida con pfet hvt.
Edita el macro extraido (xc19_slot_core_lod.inc): los dos pfet 1/0.15 con puerta en XA/XB pasan a pfet_01v8_hvt. Nada mas.
Por esquina, un deck: .op con en = 0 (corriente del macro, P2) y transitorio h01, h11, h10, t01 (P3, P4, P5', P6) para el macro
actual (core) y el hvt. Salida: corridas/<c>_<t>/calc.sp"""
import os, sys
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "xc19_slot"))
import gen_contrato as G
inv = [d for d in G.dev if d[2] in ("XA", "XB") and d[5] == "sky130_fd_pr__pfet_01v8" and "w=1" in d]
assert len(inv) == 2, inv
def hv(text, name):
    out = []
    for l in text.splitlines():
        f = l.split()
        if f and f[0].startswith(".subckt"): l = l.replace(f[1], name, 1)
        if f and f in inv: l = l.replace("sky130_fd_pr__pfet_01v8 ", "sky130_fd_pr__pfet_01v8_hvt ")
        out.append(l)
    return "\n".join(out) + "\n"
V = {"core": G.VARS["core"], "hvt": hv(G.VARS["core"], "hvt"), "trap": G.VARS["trap"], "thvt": hv(G.VARS["trap"], "thvt")}
assert V["hvt"].count("pfet_01v8_hvt ") == V["core"].count("pfet_01v8_hvt ") + 2
for c, t in G.CORNERS:
    s = G.HEAD.format(kind="enmienda 2 calculo hvt", c=c, t=t) + "".join(V.values())
    s += f"Vd vdd 0 1.8\nVh hi 0 1.8\nVpre pre 0 pwl(0 1.8 {G.T0} 1.8 {G.T0 + 1e-9} 0)\n"
    run = []
    for m in ("core", "hvt"):
        tr = "trap" if m == "core" else "thvt"
        for inst, var, s1, s0 in ((f"{m}01", m, "0", "hi"), (f"{m}11", m, "hi", "hi"), (f"{m}10", m, "hi", "0"), (f"{m}t", tr, "0", "hi")):
            s += G.slot(inst, var, "vdd", "vdd", "hi", "pre", s1, s0); run.append(inst)
    s = s.replace(" hvtt_VB 0 0 thvt", " hvtt_VB 0 0 hvtt_GT thvt"); assert "hvtt_GT thvt" in s
    # trap instances need their GT source: G.slot adds it only when var == "trap"
    for m in ("hvt",):
        s += f"Bhvtt_gt hvtt_GT 0 V=v(hvtt_VB)+{G.TRAP}\n"
    # en = 0: macro alimentado por su propia fuente (corriente de P2), solo .op
    op = ""
    for m in ("core", "hvt"):
        op += G.slot(f"e{m}", m, "vdd", f"vm{m}", "0", "0", "0", "0") + f"Vm{m} vm{m} 0 1.8\n"
    meas, echo = [], []
    for r in run:
        for side in ("oa", "ob"):
            meas.append(f"meas tran {r}_{side} when v({r}_{side})=0.9 rise=1"); echo.append(f"{r}_{side}=$&{r}_{side}")
    sv = "save " + " ".join(f"v({r}_{x})" for r in run for x in ("oa", "ob"))
    d = f"corridas/{c}_{t}"; os.makedirs(d, exist_ok=True)
    open(f"{d}/op.sp", "w").write(G.HEAD.format(kind="enmienda 2 calculo hvt, en=0 .op", c=c, t=t) + V["core"] + V["hvt"] +
        "Vd vdd 0 1.8\n" + op + ".control\nop\n" + "".join(f"echo RES {c} {t} i_{m}=$&i(vm{m})\n" for m in ("core", "hvt")) +
        "".join(f"echo RES {c} {t} xa_{m}=$&v(e{m}_XA) oa_{m}=$&v(e{m}_oa)\n" for m in ("core", "hvt")) + "quit\n.endc\n.end\n")
    open(f"{d}/tr.sp", "w").write(s + f".control\nset noaskquit\n{sv}\ntran 10n 80u 0 10n\n" + "\n".join(meas) + "\n" +
        "".join(f"echo RES {c} {t} {e}\n" for e in echo) + "quit\n.endc\n.end\n")
print("ok", [d[0] for d in inv])
