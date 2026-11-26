"""MISFIT-15 (enmienda 1): puntos de operacion DC de un puesto de XC-20 en dos topologias, uno por combinacion (alter + op).
Uso: gen.py -> op_<c>_<t>/m.sp. Lineas 'K <c> <t> <inst> <vj> <ix>': vj = tension catodo-anodo, ix = corriente que sale de la fuente de X.
inst = <A|B>_<18|09>_<s|u>_<k>; k=0: I0=0; k=1..5: n=1, I0 = 1p,100p,10n,1u,10u; k=6..10: n=3, mismos I0; k=11: testigo (solo B_18_s, 100n, n=1).
A: X - nfet - isla n+ ; diodo pw2nd isla->GND (como lo extrae MISFIT-14). B: X = pozo n (catodo) ; isla p+ - nfet - GND ; diodo pd2nw.
Sueltos DPW/DPD a 1,8 V. Bus de 7 puestos, I0=0: BUSA_off/on (subckt extraido de MISFIT-14), BUSB_off/on (pozo supuesto 112 um2, 64 um).
La version de la primera pasada (95 puestos en un solo op, no convergio) esta en pasada1/gen.py."""
import os
H = os.path.dirname(os.path.abspath(__file__))
CORNERS = [("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85")]
I0S = ["1e-12", "1e-10", "1e-8", "1e-6", "1e-5"]
NFET = "sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15"
DSZ = "perim=4.8e+06 area=1.4e+12"


def deck(c, t):
    s = f"* MISFIT-15 puesto de XC-20, esquina {c} {t} C. Generado por gen.py\n.lib /pdk/libs.tech/ngspice/sky130.lib.spice {c}\n"
    s += ".options gmin=1e-18 abstol=1e-18 reltol=1e-6\n.temp " + t + "\n"
    s += open(os.path.join(H, "..", "misfit14", "xc20s", "xc20s.lvs.spice")).read().split("\n", 2)[2]
    s += "Vd vdd 0 1.8\nVg g 0 1.8\nVc ctl 0 0\n"
    for n in (1, 3):
        ua = "*".join(["(max(v(ja%d),0)/1.8)" % n] * n); ub = "*".join(["(max(v(xb%d,jb%d),0)/1.8)" % (n, n)] * n)
        s += f"Vxa{n} xa{n} 0 1.8\nXsa{n} xa{n} g ja{n} 0 {NFET}\nXda{n} 0 ja{n} sky130_fd_pr__diode_pw2nd_05v5 {DSZ}\nBa{n} ja{n} 0 I = v(ctl)*{ua}\n"
        s += f"Vxb{n} xb{n} 0 1.8\nXsb{n} jb{n} g 0 0 {NFET}\nXdb{n} jb{n} xb{n} sky130_fd_pr__diode_pd2nw_05v5 {DSZ}\nBb{n} xb{n} jb{n} I = v(ctl)*{ub}\n"
    s += "Vr1 r1 0 1.8\nXdl1 0 r1 sky130_fd_pr__diode_pw2nd_05v5 " + DSZ + "\nVr2 r2 0 1.8\nXdl2 0 r2 sky130_fd_pr__diode_pd2nw_05v5 " + DSZ + "\n"
    for tag, on in (("off", -1), ("on", 0)):
        s += f"Vua{tag} ua{tag} 0 1.8\nXbusa{tag} " + " ".join("vdd" if k == on else "0" for k in range(7)) + f" ua{tag} 0 xc20s\n"
        s += f"Vub{tag} ub{tag} 0 1.8\nDw{tag} 0 ub{tag} sky130_fd_pr__model__parasitic__diode_ps2nw area=112e12 pj=64e6\n"
        for k in range(7):
            s += f"Xqs{tag}{k} qb{tag}{k} {'vdd' if k == on else '0'} 0 0 {NFET}\nXqd{tag}{k} qb{tag}{k} ub{tag} sky130_fd_pr__diode_pd2nw_05v5 {DSZ}\n"
    s += ".control\nset noaskquit\n"; nk = 0; first = True

    def ech(inst, vj, ix):
        nonlocal s, nk
        s += f"let a = {vj}\nlet b = {ix}\necho K {c} {t} {inst} $&a $&b\n"; nk += 1
    for x in ("1.8", "0.9"):
        for sel in (1, 0):
            s += "".join(f"alter Vx{tp}{n} dc = {x}\n" for tp in "ab" for n in (1, 3)) + f"alter Vg dc = {1.8 if sel else 0}\n"
            tagx = f"{x.replace('.', '')}_{'s' if sel else 'u'}"
            for i0 in ["0"] + I0S + (["1e-7"] if (x, sel) == ("1.8", 1) else []):
                s += f"alter Vc dc = {i0}\nop\n"
                if first:
                    ech("DPW", "v(r1)", "-i(Vr1)"); ech("DPD", "v(r2)", "-i(Vr2)")
                    for tp in "ab":
                        for tag in ("off", "on"): ech(f"BUS{tp.upper()}_{tag}", f"v(u{tp}{tag})", f"-i(Vu{tp}{tag})")
                    first = False
                if i0 == "0":
                    ech(f"A_{tagx}_0", "v(ja1)", "-i(Vxa1)"); ech(f"B_{tagx}_0", "v(xb1)-v(jb1)", "-i(Vxb1)")
                elif i0 == "1e-7":
                    ech(f"B_{tagx}_11", "v(xb1)-v(jb1)", "-i(Vxb1)")
                else:
                    j = I0S.index(i0)
                    for n, k in ((1, 1 + j), (3, 6 + j)):
                        ech(f"A_{tagx}_{k}", f"v(ja{n})", f"-i(Vxa{n})"); ech(f"B_{tagx}_{k}", f"v(xb{n})-v(jb{n})", f"-i(Vxb{n})")
    return s + "quit\n.endc\n.end\n", nk


for c, t in CORNERS:
    d = os.path.join(H, f"op_{c}_{t}"); os.makedirs(d, exist_ok=True); s, n = deck(c, t); open(os.path.join(d, "m.sp"), "w").write(s)
print("ok", n, "lineas K por esquina")
