"""MISFIT-15 (enmiendas 2 y 3): un puesto de XC-20 en dos topologias; la isla se fuerza y se barre (dc), ningun nodo flota.
Uso: gen.py -> op_<c>_<t>/m.sp ; cada barrido escribe op_<c>_<t>/f_<18|09>_<s|u>_<j>.txt (j = indice de I0 en I0S).
Columnas de wrdata (pares barrido, valor): i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3).
A: X - nfet - isla n+ ; diodo pw2nd isla->GND (como lo extrae MISFIT-14). B: X = pozo n (catodo) ; isla p+ - nfet - GND ; diodo pd2nw.
Vr1/Vr2: diodos sueltos a 1,8 V; Vr3: diodo de pozo supuesto (112 um2, 64 um). Versiones anteriores en pasada1/ y pasada2/."""
import os
H = os.path.dirname(os.path.abspath(__file__))
CORNERS = [("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85")]
I0S = ["0", "1e-12", "1e-10", "1e-8", "1e-6", "1e-5", "1e-7"]   # el ultimo es el testigo, solo en 18_s
NFET = "sky130_fd_pr__nfet_01v8 ad=0.252 pd=2.28 as=0.252 ps=2.28 w=0.84 l=0.15"
DSZ = "area=1.4 pj=4.8"   # enmienda 3: area en um2 como numero; la convencion de la extraccion (1.4e+12) entra sin escalar
COLS = "i(Eja1) i(Vxa1) i(Eja3) i(Vxa3) i(Ejb1) i(Vxb1) i(Ejb3) i(Vxb3) i(Vr1) i(Vr2) i(Vr3)"


def deck(c, t):
    s = f"* MISFIT-15 puesto de XC-20, esquina {c} {t} C. Generado por gen.py\n.lib /pdk/libs.tech/ngspice/sky130.lib.spice {c}\n"
    s += ".options gmin=1e-18 abstol=1e-18 reltol=1e-6\n.temp " + t + "\nVg g 0 1.8\nVc ctl 0 0\nVs s 0 0\n"
    for n in (1, 3):
        ua = "*".join(["(max(v(ja%d),0)/1.8)" % n] * n); ub = "*".join(["(max(v(xb%d,jb%d),0)/1.8)" % (n, n)] * n)
        s += f"Vxa{n} xa{n} 0 1.8\nXsa{n} xa{n} g ja{n} 0 {NFET}\nDda{n} 0 ja{n} sky130_fd_pr__diode_pw2nd_05v5 {DSZ}\nBa{n} ja{n} 0 I = v(ctl)*{ua}\nEja{n} ja{n} 0 s 0 1\n"
        s += f"Vxb{n} xb{n} 0 1.8\nXsb{n} jb{n} g 0 0 {NFET}\nDdb{n} jb{n} xb{n} sky130_fd_pr__diode_pd2nw_05v5 {DSZ}\nBb{n} xb{n} jb{n} I = v(ctl)*{ub}\nEjb{n} jb{n} 0 s 0 1\n"
    s += "Vr1 r1 0 1.8\nDdl1 0 r1 sky130_fd_pr__diode_pw2nd_05v5 " + DSZ + "\nVr2 r2 0 1.8\nDdl2 0 r2 sky130_fd_pr__diode_pd2nw_05v5 " + DSZ + "\n"
    s += "Vr3 r3 0 1.8\nDw 0 r3 sky130_fd_pr__model__parasitic__diode_ps2nw area=112 pj=64\n"
    s += ".control\nset noaskquit\nset numdgt=12\nset wr_singlescale\nop\nlet cdl = @ddl1[cd]\necho CD $&cdl\n"; nf = 0
    for x in ("1.8", "0.9"):
        for sel in (1, 0):
            s += "".join(f"alter Vx{tp}{n} dc = {x}\n" for tp in "ab" for n in (1, 3)) + f"alter Vg dc = {1.8 if sel else 0}\n"
            for j, i0 in enumerate(I0S):
                if i0 == "1e-7" and (x, sel) != ("1.8", 1): continue
                s += f"alter Vc dc = {i0}\ndc Vs 0 1.8 0.002\nwrdata f_{x.replace('.', '')}_{'s' if sel else 'u'}_{j}.txt {COLS}\necho HECHO {x} {sel} {i0}\n"; nf += 1
    return s + "quit\n.endc\n.end\n", nf


if __name__ == "__main__":
    for c, t in CORNERS:
        d = os.path.join(H, f"op_{c}_{t}"); os.makedirs(d, exist_ok=True); s, n = deck(c, t); open(os.path.join(d, "m.sp"), "w").write(s)
    print("ok", n, "barridos por esquina")
