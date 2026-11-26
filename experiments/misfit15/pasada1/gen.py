"""MISFIT-15: puntos de operacion DC de un puesto de XC-20 en dos topologias. Uso: gen.py -> op_<c>_<t>/m.sp
Lineas 'K <c> <t> <inst> <vj> <ix>': vj = tension catodo-anodo de la union, ix = corriente que sale de la fuente de X.
inst = <A|B>_<18|09>_<s|u>_<k>; k=0: I0=0; k=1..5: n=1, I0 = 1p,100p,10n,1u,10u; k=6..10: n=3, mismos I0; k=11: testigo (solo B_18_s, 100n, n=1).
A: X - nfet - isla n+ ; diodo pw2nd isla->GND (como lo extrae MISFIT-14). B: X = pozo n (catodo) ; isla p+ - nfet - GND ; diodo pd2nw.
Sueltos: 'K .. DPW/DPD 1.8 i'. Bus de 7 puestos, I0=0: BUSA_off, BUSA_on (subckt extraido de MISFIT-14), BUSB_off, BUSB_on (pozo supuesto 112 um2, 64 um)."""
import os
H = os.path.dirname(os.path.abspath(__file__))
CORNERS = [("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85")]
I0S = ["1p", "100p", "10n", "1u", "10u"]
CASES = [(0, "0", 1)] + [(1 + i, v, 1) for i, v in enumerate(I0S)] + [(6 + i, v, 3) for i, v in enumerate(I0S)]
NFET = "sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15"
DSZ = "perim=4.8e+06 area=1.4e+12"


def src(name, a, b, i0, n):
    if i0 == "0": return ""
    u = f"(max(v({a},{b}),0)/1.8)"
    return f"B{name} {a} {b} I = {i0}*" + "*".join([u] * n) + "\n"


def seat(topo, inst, x, sel, i0, n):
    s = f"Vx{inst} x{inst} 0 {x}\nVg{inst} g{inst} 0 {1.8 if sel else 0}\n"
    if topo == "A":
        s += f"Xs{inst} x{inst} g{inst} j{inst} 0 {NFET}\nXd{inst} 0 j{inst} sky130_fd_pr__diode_pw2nd_05v5 {DSZ}\n" + src(inst, f"j{inst}", "0", i0, n)
        vj = f"v(j{inst})"
    else:
        s += f"Xs{inst} j{inst} g{inst} 0 0 {NFET}\nXd{inst} j{inst} x{inst} sky130_fd_pr__diode_pd2nw_05v5 {DSZ}\n" + src(inst, f"x{inst}", f"j{inst}", i0, n)
        vj = f"v(x{inst})-v(j{inst})"
    return s, vj


def deck(c, t):
    s = f"* MISFIT-15 puesto de XC-20, esquina {c} {t} C. Generado por gen.py\n.lib /pdk/libs.tech/ngspice/sky130.lib.spice {c}\n"
    s += ".options gmin=1e-18 abstol=1e-18 reltol=1e-6\n.temp " + t + "\n"
    s += open(os.path.join(H, "..", "misfit14", "xc20s", "xc20s.lvs.spice")).read().split("\n", 2)[2]
    out = []
    for topo in "AB":
        for x in ("1.8", "0.9"):
            for sel in (1, 0):
                cases = CASES + ([(11, "100n", 1)] if (topo, x, sel) == ("B", "1.8", 1) else [])
                for k, i0, n in cases:
                    inst = f"{topo}_{x.replace('.', '')}_{'s' if sel else 'u'}_{k}"; a, vj = seat(topo, inst, x, sel, i0, n); s += a
                    out.append((inst, vj, f"-i(Vx{inst})"))
    s += "Vr1 r1 0 1.8\nXdl1 0 r1 sky130_fd_pr__diode_pw2nd_05v5 " + DSZ + "\nVr2 r2 0 1.8\nXdl2 0 r2 sky130_fd_pr__diode_pd2nw_05v5 " + DSZ + "\n"
    out += [("DPW", "v(r1)", "-i(Vr1)"), ("DPD", "v(r2)", "-i(Vr2)")]
    for tag, on in (("off", -1), ("on", 0)):
        s += f"Vxa{tag} xa{tag} 0 1.8\nXbusa{tag} " + " ".join("vdd" if k == on else "0" for k in range(7)) + f" xa{tag} 0 xc20s\n"
        out.append((f"BUSA_{tag}", f"v(xa{tag})", f"-i(Vxa{tag})"))
        s += f"Vxb{tag} xb{tag} 0 1.8\nDw{tag} 0 xb{tag} sky130_fd_pr__model__parasitic__diode_ps2nw area=112e12 pj=64e6\n"
        for k in range(7):
            s += f"Xsb{tag}{k} jb{tag}{k} {'vdd' if k == on else '0'} 0 0 {NFET}\nXdb{tag}{k} jb{tag}{k} xb{tag} sky130_fd_pr__diode_pd2nw_05v5 {DSZ}\n"
        out.append((f"BUSB_{tag}", f"v(xb{tag})", f"-i(Vxb{tag})"))
    s += "Vd vdd 0 1.8\n.control\nset noaskquit\nop\n"
    for inst, vj, ix in out:
        s += f"let a = {vj}\nlet b = {ix}\necho K {c} {t} {inst} $&a $&b\n"
    return s + "quit\n.endc\n.end\n", len(out)


for c, t in CORNERS:
    d = os.path.join(H, f"op_{c}_{t}"); os.makedirs(d, exist_ok=True); s, n = deck(c, t); open(os.path.join(d, "m.sp"), "w").write(s)
print("ok", n, "lineas K por esquina")
