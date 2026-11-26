"""MISFIT-17: lector 2 (noche_1125/gen_A.py, mismo lazo) en dos rangos, con la matriz xc20w extraida (misfit16) en el nodo.
Uso: gen.py -> d/<rango>_<c><t>_<caso>_<I>/lec.sp. Lineas 'R17 <c> <t> <rango> <caso> <I> <flanco2> <flanco12>' y 'CD <F>'.
Casos: cal (fuente ideal en el nodo, puestos abiertos), oos (fuente ideal a traves del puesto 0), wit (oos +1 %), s6 (puesto 6),
sh1/sh3 (I0*(V/1,8)^n en el puesto 0), zero (sin corriente, 20 ms), bare (lector sin matriz, fuente en el nodo)."""
import os
H = os.path.dirname(os.path.abspath(__file__))
CORN = (("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85")); LP = {"bajo": "1.00", "alto": "0.15"}
CASOS = {"bajo": [("cal", 1e-10), ("cal", 1e-8), ("cal", 1e-6), ("oos", 3.1623e-10), ("oos", 3.1623e-9), ("oos", 1e-7), ("wit", 3.1939e-9),
                  ("s6", 3.1623e-9), ("sh1", 1e-8), ("sh3", 1e-8), ("zero", 0.0), ("bare", 3.1623e-9)],
         "alto": [("cal", 1e-8), ("cal", 3.1623e-7), ("cal", 1e-5), ("oos", 3.1623e-8), ("oos", 1e-6), ("oos", 3.1623e-6), ("wit", 1.01e-6),
                  ("sh1", 1e-6), ("sh3", 1e-6), ("zero", 0.0)]}


def matriz(sel):
    L = open(os.path.join(H, "..", "misfit16", "xc20w", "xc20w.pex.spice")).read().splitlines()
    i0 = next(i for i, l in enumerate(L) if l.startswith(".subckt")); body = [l for l in L[i0 + 1:] if l and not l.startswith(".ends")]
    nd = lambda n: {"X": "o_x", "GND": "0"}.get(n, n.lower() if n.startswith("SEL") else "m_" + n.replace("#", ""))
    out = []; isl = {}; ndio = 0
    for l in body:
        f = l.split()
        if f[0].startswith("X") and "nfet" in l:
            assert f[1] == "GND" and f[4] == "GND" and f[2].startswith("SEL"), l
            isl[int(f[2][3:])] = nd(f[3]); out.append(f"Xm{f[0][1:]} 0 {nd(f[2])} {nd(f[3])} 0 " + " ".join(f[5:]))
        elif f[0].startswith("X") and "diode_pd2nw" in l:
            assert f[2] == "X", l; ndio += 1; out.append(f"Dm{f[0][1:]} {nd(f[1])} o_x sky130_fd_pr__diode_pd2nw_05v5 area=1.4 pj=4.8")
        elif f[0].startswith("C"): out.append(f"Cm{f[0][1:]} {nd(f[1])} {nd(f[2])} {f[3]}")
        else: raise SystemExit("linea no entendida: " + l)
    assert ndio == 7 and len(isl) == 7
    out.append("Dwell 0 o_x sky130_fd_pr__model__parasitic__diode_ps2nw area=50.195 pj=60.56")
    out += [f"Vsel{k} sel{k} 0 {1.8 if k == sel else 0}" for k in range(7)]
    dj6 = next(o.split()[0] for o in out if o.startswith("Dm") and o.split()[1] == isl[6])
    return out, isl, dj6


def deck(c, t, rng, caso, i):
    p = "o"; lp = LP[rng]
    s = [f"* MISFIT-17 lector 2 rango {rng} (L = {lp}), caso {caso}, I = {i:.4e} A, {c} {t} C", f".lib /pdk/libs.tech/ngspice/sky130.lib.spice {c}",
         ".include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice", f".temp {t}", ".options gmin=1e-15 reltol=1e-4", "Vd vdd 0 1.8",
         f"X{p}_c 0 {p}_x 0 0 sky130_fd_pr__nfet_01v8 w=4.3 l=4"]
    dj6 = None
    if caso != "bare":
        sel = {"cal": -1, "zero": -1, "s6": 6}.get(caso, 0); m, isl, dj6 = matriz(sel); s += m
        if caso in ("oos", "wit", "s6"): s.append(f"Ij o_x {isl[sel]} {i:.4e}")
        if caso in ("sh1", "sh3"):
            u = f"(max(v(o_x,{isl[0]}),0)/1.8)"; s.append(f"Bj o_x {isl[0]} I = {i:.4e}*" + "*".join([u] * int(caso[2])))
    if caso in ("cal", "bare"): s.append(f"I{p} {p}_x 0 {i:.4e}")
    s += [f"X{p}_pre {p}_x {p}_pren {p}_st vdd sky130_fd_pr__pfet_01v8_hvt w=1 l={lp} m=2",
          f"X{p}_pre2 {p}_st {p}_pren vdd vdd sky130_fd_pr__pfet_01v8_hvt w=1 l={lp} m=2",
          f"X{p}_cmp {p}_x 0 0 vdd vdd {p}_c sky130_fd_sc_hd__inv_1", f"X{p}_s1 {p}_c 0 0 vdd vdd {p}_c2 sky130_fd_sc_hd__inv_1",
          f"X{p}_s2 {p}_c2 0 0 vdd vdd {p}_s sky130_fd_sc_hd__inv_1", f"X{p}_q {p}_r {p}_qb 0 0 vdd vdd {p}_q sky130_fd_sc_hd__nor2_1",
          f"X{p}_qb {p}_s {p}_q 0 0 vdd vdd {p}_qb sky130_fd_sc_hd__nor2_1", f"X{p}_p {p}_q 0 0 vdd vdd {p}_pren sky130_fd_sc_hd__inv_4"]
    prev = f"{p}_q"
    for k in range(8):
        nxt = f"{p}_r" if k == 7 else f"{p}_d{k}"; s += [f"X{p}_d{k} {prev} 0 0 vdd vdd {nxt} sky130_fd_sc_hd__dlygate4sd3_1"]; prev = nxt
    s += [f".ic v({p}_x)=1.8"]
    ie = i * (0.25 if caso == "sh3" else 0.6 if caso == "sh1" else 1.0)
    ts = 20e-3 if i == 0 else 14 * 260e-15 * 2.0 / ie + 16 * 10e-9
    s += [".control", "set noaskquit", f"save v({p}_q) v({p}_x)" + (f" @{dj6.lower()}[cd]" if dj6 else ""), f"tran {min(ts/20000, 1e-9):.3e} {ts:.4e} 0 {min(ts/2000, 1e-6):.3e}",
          f"meas tran r2 when v({p}_q)=0.9 rise=2", f"meas tran r12 when v({p}_q)=0.9 rise=12", f"meas tran r1 when v({p}_q)=0.9 rise=1",
          f"echo R17 {c} {t} {rng} {caso} {i:.4e} $&r2 $&r12"]
    if dj6: s += [f"let cdj = @{dj6.lower()}[cd]", "let cd0 = cdj[length(cdj)-1]", "echo CD $&cd0"]
    return "\n".join(s + ["quit", ".endc", ".end"]) + "\n"


if __name__ == "__main__":
    n = 0
    for c, t in CORN:
        for rng in LP:
            for caso, i in CASOS[rng]:
                d = os.path.join(H, "d", f"{rng}_{c}{t}_{caso}_{i:.4e}"); os.makedirs(d, exist_ok=True); open(os.path.join(d, "lec.sp"), "w").write(deck(c, t, rng, caso, i)); n += 1
    print("decks:", n)
