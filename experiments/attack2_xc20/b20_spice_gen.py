#!/usr/bin/env python3
"""b20_spice_gen.py — genera los netlists de lectura del par de Goto (SKY130, ngspice).

Uso:  python3 b20_spice_gen.py            -> netlists A, B1, C, D, E, Cmm en b20_spice_net/
      python3 b20_spice_gen.py b2 IREF_STD IREF_LVT   -> netlists B2 (réplica y referencia fija)
Los netlists se corren dentro del contenedor (ver b20_spice_run.sh); rutas /work y /foss/pdks.
"""
import os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
NET = os.path.join(HERE, "b20_spice_net")
RAW = "/work/b20_spice_raw"
LIB = "/foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice"
CORNERS = ["tt", "ss", "ff", "sf", "fs"]
TEMPS = [-40, 27, 85]
PR = "sky130_fd_pr__"
N, NL = PR + "nfet_01v8", PR + "nfet_01v8_lvt"
P, PL, PH = PR + "pfet_01v8", PR + "pfet_01v8_lvt", PR + "pfet_01v8_hvt"


def tname(t):
    return ("m%d" % -t) if t < 0 else str(t)


def mos(name, d, g, s, b, model, w, l, m=1):
    # ad/pd explícitos (difusión de 0,29 um) para que la unión cuente
    return (f"X{name} {d} {g} {s} {b} {model} w={w} l={l} m={m} "
            f"ad={w*0.29:.4f} as={w*0.29:.4f} pd={2*(w+0.29):.3f} ps={2*(w+0.29):.3f}")


def head(title, corner, t, gmin="1e-16"):
    return [f"* {title} · esquina {corner} · {t} C · generado por b20_spice_gen.py",
            f".lib {LIB} {corner}", f".temp {t}",
            f".options gmin={gmin} abstol=1e-16 reltol=1e-5 vntol=1e-7"]


def ctl(lines):
    return [".control", "set wr_singlescale", "set wr_vecnames", "set numdgt=7"] + lines + ["quit", ".endc", ".end"]


def write(name, lines):
    with open(os.path.join(NET, name), "w") as f:
        f.write("\n".join(lines) + "\n")


# ---------------- A: inversor a alimentación reducida ----------------
A_VAR = [("nstd_pstd", N, P), ("nlvt_plvt", NL, PL), ("nstd_phvt", N, PH), ("nlvt_phvt", NL, PH), ("nlvt_pstd", NL, P)]
A_RAT = [("n8p1", 8, 1), ("n1p1", 1, 1), ("n1p8", 1, 8)]
A_VDD = ["0.2", "0.3", "0.4", "0.5", "0.6"]


def gen_A(c, t):
    L = head("A inversor a VDD reducida (W=1 L=0.5, m segun relacion)", c, t)
    L += ["Vdd vdd 0 0.4", "Vin in 0 0.2"]
    outs = []
    for vn, nm, pm in A_VAR:
        for rn, mn, mp in A_RAT:
            o = f"o_{vn}_{rn}"
            outs.append(f"v({o})")
            L.append(mos(f"n_{vn}_{rn}", o, "in", "0", "0", nm, 1, 0.5, mn))
            L.append(mos(f"p_{vn}_{rn}", o, "in", "vdd", "vdd", pm, 1, 0.5, mp))
    C = []
    for v in A_VDD:
        C += [f"alter Vdd dc = {v}", f"dc Vin 0 {v} 0.0005",
              f"wrdata {RAW}/A_{c}_{tname(t)}_v{v}.dat " + " ".join(outs)]
    write(f"b20_spice_A_{c}_{tname(t)}.spice", L + ctl(C))


# ---------------- B1: curvas Id(Vg) del nfet en inversión débil ----------------
B_DEV = [("std_5_1", N, 5, 1), ("lvt_5_1", NL, 5, 1), ("std_5_05", N, 5, 0.5), ("lvt_5_05", NL, 5, 0.5)]


def gen_B1(c, t):
    L = head("B1 nfet en inversion debil, Id(Vg) con Vds=0.9 V", c, t, gmin="1e-18")
    L += ["Vg g 0 0.1"]
    outs = []
    for nm, mod, w, l in B_DEV:
        L.append(f"Vd_{nm} d_{nm} 0 0.9")
        L.append(mos(f"m_{nm}", f"d_{nm}", "g", "0", "0", mod, w, l))
        outs.append(f"i(Vd_{nm})")
    C = ["dc Vg 0 0.5 0.01", f"wrdata {RAW}/B1_{c}_{tname(t)}.dat " + " ".join(outs) + " i(Vg)"]
    write(f"b20_spice_B1_{c}_{tname(t)}.spice", L + ctl(C))


# ---------------- B2: lector nfet + espejo pfet, con réplica y con referencia fija ----------------
def gen_B2(c, t, iref):
    L = head("B2 nfet fuente comun + espejo pfet + inversor 1.8 V; replica (r) y referencia fija (f)", c, t, gmin="1e-18")
    L += ["Vdd vdd 0 1.8", "Vin in 0 0.1", "Vref ref 0 0.17"]
    outs = []
    for nm, mod in (("std", N), ("lvt", NL)):
        # réplica: nfet idéntico con puerta en 0,17 V fija la corriente del espejo
        L.append(mos(f"r_{nm}", f"pd_r{nm}", "ref", "0", "0", mod, 5, 1))
        # referencia fija: fuente ideal = Id(0,17 V) en tt/27
        L.append(f"Iref_{nm} pd_f{nm} 0 {iref[nm]:.6e}")
        for k in ("r", "f"):
            s = f"{k}{nm}"
            L.append(mos(f"pa_{s}", f"pd_{s}", f"pd_{s}", "vdd", "vdd", P, 2, 2))
            L.append(mos(f"pb_{s}", f"d_{s}", f"pd_{s}", "vdd", "vdd", P, 2, 2))
            L.append(mos(f"s_{s}", f"d_{s}", "in", "0", "0", mod, 5, 1))
            L.append(mos(f"in_{s}", f"o_{s}", f"d_{s}", "0", "0", N, 0.65, 0.15))
            L.append(mos(f"ip_{s}", f"o_{s}", f"d_{s}", "vdd", "vdd", P, 1, 0.15))
            outs += [f"v(d_{s})", f"v(o_{s})"]
    C = ["dc Vin 0 0.5 0.0005", f"wrdata {RAW}/B2_{c}_{tname(t)}.dat " + " ".join(outs) + " i(Vin)"]
    write(f"b20_spice_B2_{c}_{tname(t)}.spice", L + ctl(C))


# ---------------- C: comparador con par diferencial pfet ----------------
def cmp_subckt(name, pmod, mp=1, mn=1):
    return [f".subckt {name} inp ref o2 out n2 vdd iref=100n",
            "Ib pb 0 {iref}",
            mos("mb", "pb", "pb", "vdd", "vdd", P, 2, 2, 1),
            mos("mt", "tail", "pb", "vdd", "vdd", P, 2, 2, 2),
            mos("m1", "n1", "inp", "tail", "tail", pmod, 4, 1, mp),
            mos("m2", "n2", "ref", "tail", "tail", pmod, 4, 1, mp),
            mos("m3", "n1", "n1", "0", "0", N, 2, 2, mn),
            mos("m4", "n2", "n1", "0", "0", N, 2, 2, mn),
            mos("m6", "o2", "n2", "0", "0", N, 2, 2, mn),
            mos("m7", "o2", "pb", "vdd", "vdd", P, 2, 2, 1),
            mos("mn", "out", "o2", "0", "0", N, 0.65, 0.15),
            mos("mp", "out", "o2", "vdd", "vdd", P, 1, 0.15),
            ".ends"]


C_REF = ["0.05", "0.10", "0.17", "0.25", "0.40"]
C_VAR = [("std200", "cmp_std", "100n"), ("lvt200", "cmp_lvt", "100n"), ("std1u", "cmp_std", "500n")]


def gen_C(c, t):
    L = head("C comparador par pfet (4/1), cola 2x iref, espejo nfet 2/2, 2a etapa, inversor", c, t, gmin="1e-18")
    L += cmp_subckt("cmp_std", P) + cmp_subckt("cmp_lvt", PL)
    L += ["Vdd vdd 0 1.8", "Vref ref 0 0.17", "Vd inp ref 0"]
    outs = []
    for nm, sub, ir in C_VAR:
        L.append(f"Xc_{nm} inp ref o2_{nm} out_{nm} n2_{nm} vdd {sub} iref={ir}")
        outs += [f"v(o2_{nm})", f"v(n2_{nm})", f"v(out_{nm})"]
    Cc = []
    for r in C_REF:
        Cc += [f"alter Vref dc = {r}", "dc Vd -0.02 0.02 0.00001",
               f"wrdata {RAW}/C_{c}_{tname(t)}_r{r}.dat " + " ".join(outs) + " i(Vd)"]
    # barrido ancho con ref 0,17: salida lógica para toda la excursión
    Cc += ["alter Vref dc = 0.17", "dc Vd -0.17 0.33 0.001",
           f"wrdata {RAW}/C_{c}_{tname(t)}_wide.dat " + " ".join(outs)]
    write(f"b20_spice_C_{c}_{tname(t)}.spice", L + ctl(Cc))


def gen_Cmm(nrep=150):
    L = head("Cmm Monte Carlo de mismatch del comparador (seccion tt_mm), 150 copias por variante", "tt_mm", 27, gmin="1e-18")
    L += cmp_subckt("cmp_std", P) + cmp_subckt("cmp_big", P, 4, 4)
    L += ["Vdd vdd 0 1.8", "Vref ref 0 0.17", "Vd inp ref 0"]
    oa, ob = [], []
    for i in range(nrep):
        L.append(f"Xa{i} inp ref o2a{i} outa{i} n2a{i} vdd cmp_std")
        L.append(f"Xb{i} inp ref o2b{i} outb{i} n2b{i} vdd cmp_big")
        oa.append(f"v(o2a{i})")
        ob.append(f"v(o2b{i})")
    Cc = ["dc Vd -0.06 0.06 0.0001",
          f"wrdata {RAW}/Cmm_a.dat " + " ".join(oa),
          f"wrdata {RAW}/Cmm_b.dat " + " ".join(ob)]
    write("b20_spice_Cmm_tt_27.spice", L + ctl(Cc))


# ---------------- D: seguidor pfet + inversor a 1,8 V ----------------
D_VAR = [("std", P), ("lvt", PL), ("hvt", PH)]


def gen_D(c, t):
    L = head("D seguidor pfet (2/0.5, 100 nA, cuerpo a fuente) + inversor 1.8 V", c, t, gmin="1e-18")
    L += ["Vdd vdd 0 1.8", "Vin in 0 0.1", "Vx x 0 0.9", "Ib pb 0 100n",
          mos("mb", "pb", "pb", "vdd", "vdd", P, 2, 2)]
    outs = []
    for nm, mod in D_VAR:
        L.append(mos(f"cs_{nm}", f"sf_{nm}", "pb", "vdd", "vdd", P, 2, 2))
        L.append(mos(f"sf_{nm}", "0", "in", f"sf_{nm}", f"sf_{nm}", mod, 2, 0.5))
        L.append(mos(f"in_{nm}", f"o_{nm}", f"sf_{nm}", "0", "0", N, 0.65, 0.15))
        L.append(mos(f"ip_{nm}", f"o_{nm}", f"sf_{nm}", "vdd", "vdd", P, 1, 0.15))
        outs += [f"v(sf_{nm})", f"v(o_{nm})"]
    # inversor suelto para medir su Vm
    L.append(mos("in_x", "ox", "x", "0", "0", N, 0.65, 0.15))
    L.append(mos("ip_x", "ox", "x", "vdd", "vdd", P, 1, 0.15))
    Cc = ["dc Vin 0 0.6 0.0005", f"wrdata {RAW}/D_{c}_{tname(t)}.dat " + " ".join(outs) + " i(Vin)",
          "dc Vx 0 1.8 0.001", f"wrdata {RAW}/D_{c}_{tname(t)}_inv.dat v(ox)"]
    write(f"b20_spice_D_{c}_{tname(t)}.spice", L + ctl(Cc))


# ---------------- E: fuga de interruptores sobre el nodo ----------------
E_DEV = [("n_015", N, 0.42, 0.15), ("n_05", N, 0.42, 0.5), ("n_1", N, 0.42, 1.0), ("nlvt_015", NL, 0.42, 0.15)]


def gen_E(c, t):
    L = head("E fuga de interruptor apagado colgado del nodo (Vnodo barrido 0.05-0.4 V)", c, t, gmin="1e-21")
    L += ["Vnode nd 0 0.3", "Vdd vdd 0 1.8"]
    outs = []
    for nm, mod, w, l in E_DEV:
        # nfet de reset a masa: drenador = nodo, puerta = fuente = 0; cuerpo con amperímetro propio
        L += [f"Vd_{nm} nd d_{nm} 0", f"Vb_{nm} b_{nm} 0 0",
              mos(f"e_{nm}", f"d_{nm}", "0", "0", f"b_{nm}", mod, w, l)]
        outs += [f"i(Vd_{nm})", f"i(Vb_{nm})"]
    # pfet apagado (puerta y pozo a 1,8 V), fuente = nodo, drenador = masa
    L += ["Vd_p015 nd d_p015 0", "Vb_p015 vdd b_p015 0",
          mos("e_p015", "0", "vdd", "d_p015", "b_p015", P, 0.42, 0.15)]
    outs += ["i(Vd_p015)", "i(Vb_p015)"]
    # nfet de L mínima con la fuente en 0,1 V (apilado / puerta de paso hacia otro nodo bajo)
    L += ["Vd_nst nd d_nst 0", "Vs_nst s_nst 0 0.1",
          mos("e_nst", "d_nst", "0", "s_nst", "0", N, 0.42, 0.15)]
    outs += ["i(Vd_nst)"]
    Cc = ["dc Vnode 0.05 0.4 0.05", f"wrdata {RAW}/E_{c}_{tname(t)}.dat " + " ".join(outs)]
    write(f"b20_spice_E_{c}_{tname(t)}.spice", L + ctl(Cc))


if __name__ == "__main__":
    os.makedirs(NET, exist_ok=True)
    os.makedirs(os.path.join(HERE, "b20_spice_raw"), exist_ok=True)
    if len(sys.argv) > 1 and sys.argv[1] == "b2":
        iref = {"std": float(sys.argv[2]), "lvt": float(sys.argv[3])}
        for c in CORNERS:
            for t in TEMPS:
                gen_B2(c, t, iref)
    else:
        for c in CORNERS:
            for t in TEMPS:
                gen_A(c, t); gen_B1(c, t); gen_C(c, t); gen_D(c, t); gen_E(c, t)
        gen_Cmm()
