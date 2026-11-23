"""MISFIT-03 etapa a: decks del contrato del slot XC-19 (macro extraido + decodificador en celdas estandar), 4 esquinas.

Prerregistro: cells/preregistros/MISFIT-03_2026-11-23_slot_xc19.md + enmienda 1 (E1-E10). Escrito antes de correr.
Genera, por esquina:
  contrato_<c>_<t>.sp  temporizacion (80 us): P3, P4, P5', P6, P6', P7 y fallos F1, F2, F3, F4, F7
  largo_<c>_<t>.sp     1,4 ms (ventana TMO=16 a 50 MHz = 1,31 ms): src=00, P2 (en=0 con entradas moviendose), F5, F6
Variantes del netlist (fallos e inyeccion del salto), todas por edicion de texto del netlist extraido, identificando cada
dispositivo por su conectividad (no por su numero X):
  core     sano
  trap     puerta del DUT de A sacada a un puerto GT (el salto de 0,305 mV se aplica como fuente ideal, como en xc19_caps)
  f1       F1: placa de S2 de A abierta (se quitan todas las capacidades extraidas del nodo de fuente de S2A; la union del
           interruptor queda, va en el modelo del dispositivo)
  f4       F4: precarga de A abierta (se quita el pfet de precarga de A)
  f6       F6: DUT de A abierto (se quita el dispositivo)
F2 (S1 de A pegado cerrado), F3 (xa en corto a VDD), F5 (en no corta la polarizacion) y F7 (interruptor del DUT de A pegado
cerrado) se inyectan en el decodificador o con una resistencia de 1 ohm.
"""
import os, re

HERE = os.path.dirname(os.path.abspath(__file__))
INC = os.path.join(HERE, "..", "..", "cells", "xc19_slot_core", "xc19_slot_core_lod.inc")
CORNERS = (("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85"))
T0 = 1e-6          # flanco de bajada de pre (fin de la precarga)
TRAP = 0.305e-3    # salto de una carga en la puerta, como xc19_caps/post.sp

lines = open(INC).read().splitlines()
# cabecera con continuaciones
i0 = next(k for k, l in enumerate(lines) if l.startswith(".subckt"))
hdr = lines[i0].split()
k = i0 + 1
while lines[k].startswith("+"):
    hdr += lines[k][1:].split(); k += 1
PORTS = hdr[2:]
BODY = lines[k:]
dev = [l.split() for l in BODY if l.startswith("X")]


def find(pred):
    m = [d for d in dev if pred(d)]
    assert len(m) == 1, (len(m), m[:3])
    return m[0]


# nodo de fuente del DUT de A = drenador del interruptor con puerta DUTA
swd = find(lambda d: d[2] == "DUTA")
sA = [n for n in (swd[1], swd[3]) if n != "GND"][0]
dutA = find(lambda d: d[2] == "VB" and {d[1], d[3]} == {"XA", sA})
s2A = find(lambda d: d[2] == "SA2B")
p2A = [n for n in (s2A[1], s2A[3]) if n != "XA"][0]
preA = find(lambda d: d[2] == "PREA")


def variant(name, gate_to_gt=False, drop_dev=None, drop_cap_node=None):
    ports = PORTS + (["GT"] if gate_to_gt else [])
    out = [f".subckt {name} " + " ".join(ports)]
    ncap = 0
    for l in BODY:
        f = l.split()
        if not f:
            continue
        if f[0] == ".ends":
            out.append(l); break
        if drop_dev is not None and f == drop_dev:
            continue
        if drop_cap_node and f[0].startswith("C") and drop_cap_node in (f[1], f[2]):
            ncap += 1; continue
        if gate_to_gt and f == dutA:
            f = list(f); f[2] = "GT"; l = " ".join(f)
        out.append(l)
    return "\n".join(out) + "\n", ncap


VARS = {}
VARS["core"], _ = variant("core")
VARS["trap"], _ = variant("trap", gate_to_gt=True)
VARS["f1"], NC_F1 = variant("f1", drop_cap_node=p2A)
VARS["f4"], _ = variant("f4", drop_dev=preA)
VARS["f6"], _ = variant("f6", drop_dev=dutA)
assert NC_F1 > 0

# --- decodificador (E7) en celdas sky130_fd_sc_hd; una celda por linea cruda para que A y B vean la misma carga
SC = "sky130_fd_sc_hd__"


def slot(inst, var, vdd, vdc, en, pre, s1, s0, over=None, extra=""):
    """Instancia: decodificador alimentado por vdd, macro por vdc (fuentes separadas para medir corriente).
    over: {linea cruda: nodo fijo} para inyectar fallos en el decodificador."""
    over = over or {}
    p = f"{inst}_"
    n = lambda s: over.get(s, p + s)
    L = [f"* --- {inst}: {var}"]
    L.append(f"X{p}ienn {en} 0 0 {vdd} {vdd} {p}enn {SC}inv_1")
    L.append(f"X{p}is1n {s1} 0 0 {vdd} {vdd} {p}s1n {SC}inv_1")
    L.append(f"X{p}is0n {s0} 0 0 {vdd} {vdd} {p}s0n {SC}inv_1")
    cells = [("nor2_1", [pre, p + "enn"], "PREA"), ("nor2_1", [pre, p + "enn"], "PREB"),
             ("buf_2", [en], "VBIAS"), ("buf_2", [en], "C1"),
             ("and3_1", [en, p + "s1n", s0], "DUTA"), ("and3_1", [en, p + "s1n", s0], "DUTB"),
             ("and2_1", [en, s1], "REFA"), ("and2_1", [en, s1], "REFB"),
             ("nand3_1", [en, s1, s0], "SA0B"), ("nand2_1", [en, s1], "SA1B"), ("nand3_1", [en, s1, p + "s0n"], "SA2B"),
             ("nand2_1", [en, s1], "SB0B"), ("nand2_1", [en, s1], "SB1B")]
    for cell, ins, out in cells:
        y = n(out)
        if out in over:      # linea pegada: la celda sigue ahi (carga), su salida va a un nodo flotante con 1 Gohm
            L.append(f"X{p}{out} {' '.join(ins)} 0 0 {vdd} {vdd} {p}{out}_nc {SC}{cell}")
            L.append(f"R{p}{out}nc {p}{out}_nc 0 1G")
        else:
            L.append(f"X{p}{out} {' '.join(ins)} 0 0 {vdd} {vdd} {y} {SC}{cell}")
    # puertos del macro (VB, CALA, CALB y X quedan como nodos de la instancia; CAL a GND como en xc19_caps)
    m = {"VDD": vdc, "GND": "0", "CALA": "0", "CALB": "0", "XA_OUT": p + "oa", "XB_OUT": p + "ob",
         "XA": p + "XA", "XB": p + "XB", "VB": p + "VB", "GT": p + "GT"}
    for s in ("PREA", "PREB", "VBIAS", "C1", "DUTA", "DUTB", "REFA", "REFB", "SA0B", "SA1B", "SA2B", "SB0B", "SB1B"):
        m[s] = n(s)
    ports = PORTS + (["GT"] if var == "trap" else [])
    L.append(f"X{p}M " + " ".join(m[q] for q in ports) + f" {var}")
    if var == "trap":
        L.append(f"B{p}gt {p}GT 0 V=v({p}VB)+{TRAP}")
    L.append(extra)
    return "\n".join(L) + "\n"


HEAD = """* MISFIT-03 etapa a · {kind} · esquina {c} {t} C. Generado por gen_contrato.py (no editar a mano).
* Macro: cells/xc19_slot_core/xc19_slot_core_lod.inc (Magic, extraccion con capacidades, LOD anotado por Residual).
* Decodificador: celdas sky130_fd_sc_hd en SPICE (E7). El contador es aritmetico: cuentas = (t_xa - t_pre) * 50 MHz.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice {c}
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-18 abstol=1e-15 reltol=1e-5
.temp {t}
"""


def timing_deck(c, t):
    s = HEAD.format(kind="temporizacion", c=c, t=t) + "".join(VARS.values())
    s += f"""Vd vdd 0 1.8
Vdl vdl 0 1.79
Vdh vdh 0 1.81
Vh hi 0 1.8
Vpre pre 0 pwl(0 1.8 {T0} 1.8 {T0 + 1e-9} 0)
"""
    run = []
    def add(inst, var, s1, s0, vdd="vdd", over=None, extra=""):
        nonlocal s
        s += slot(inst, var, vdd, vdd, "hi", "pre", s1, s0, over, extra)
        run.append(inst)
    add("h01", "core", "0", "hi")
    add("h11", "core", "hi", "hi")
    add("h10", "core", "hi", "0")
    add("t01", "trap", "0", "hi")
    add("l01", "core", "0", "hi", vdd="vdl")
    add("u01", "core", "0", "hi", vdd="vdh")
    add("f1a", "f1", "hi", "hi")
    add("f1b", "f1", "hi", "0")
    add("f2", "core", "0", "hi", over={"SA1B": "0"})
    add("f3", "core", "0", "hi", extra="Rf3 f3_oa vdd 1")
    add("f4", "f4", "0", "hi")
    add("f7", "core", "hi", "hi", over={"DUTA": "vdd"})
    meas = []
    echo = []
    for r in run:
        for side in ("oa", "ob"):
            meas.append(f"meas tran {r}_{side} when v({r}_{side})=0.9 rise=1")
            meas.append(f"meas tran {r}_{side}_pre avg v({r}_{side}) from={T0 - 30e-9} to={T0 - 10e-9}")
            echo.append(f"{r}_{side}=$&{r}_{side} {r}_{side}_pre=$&{r}_{side}_pre")
    meas.append("meas tran vb find v(h01_VB) at=0.5u")
    echo.append("vb=$&vb")
    s += ".control\nset noaskquit\ntran 10n 80u\n" + "\n".join(meas) + "\n"
    s += "".join(f"echo RES {c} {t} {e}\n" for e in echo)
    s += "quit\n.endc\n.end\n"
    return s


def pwl_toggle(period, t_end, hi=1.8, start_hi=False):
    pts = []; v = hi if start_hi else 0.0; tt = 0.0
    pts.append(f"0 {v}")
    while tt + period < t_end:
        tt += period
        pts.append(f"{tt:.9g} {v}"); v = hi - v
        pts.append(f"{tt + 1e-9:.9g} {v}")
    if v != 0.0:   # termina en 0 tras t_end, como garantiza el nucleo fuera de adquisicion
        pts.append(f"{t_end:.9g} {v}"); pts.append(f"{t_end + 1e-9:.9g} 0")
    return "pwl(" + " ".join(pts) + ")"


def long_deck(c, t):
    s = HEAD.format(kind="largo (1,4 ms)", c=c, t=t) + VARS["core"] + VARS["f6"]
    s += f"""Vd vdd 0 1.8
Vh hi 0 1.8
Vpre pre 0 pwl(0 1.8 {T0} 1.8 {T0 + 1e-9} 0)
* en = 0: el nucleo garantiza pre = src = 0 fuera de la adquisicion, pero P2 pide xa = xb = 0 con pre y src moviendose: se
* mueven durante 0-50 us y luego quedan en 0. Corriente estatica: media entre 200 us y 1,4 ms.
Vtp tpre 0 {pwl_toggle(3e-6, 50e-6)}
Vt1 ts1 0 {pwl_toggle(7e-6, 50e-6)}
Vt0 ts0 0 {pwl_toggle(5e-6, 50e-6)}
* fuentes separadas: decodificador (vdd_*) y macro (vdc_*), para P2 y F5
Vdd0 vdd_e0 0 1.8
Vdc0 vdc_e0 0 1.8
Vdd5 vdd_f5 0 1.8
Vdc5 vdc_f5 0 1.8
"""
    s += slot("h00", "core", "vdd", "vdd", "hi", "pre", "0", "0")
    s += slot("f6", "f6", "vdd", "vdd", "hi", "pre", "0", "hi")
    s += slot("e0", "core", "vdd_e0", "vdc_e0", "0", "tpre", "ts1", "ts0")
    s += slot("f5", "core", "vdd_f5", "vdc_f5", "0", "tpre", "ts1", "ts0", over={"VBIAS": "vdd_f5", "C1": "vdd_f5"})
    meas = []; echo = []
    for r in ("h00", "f6"):
        for side in ("oa", "ob"):
            meas.append(f"meas tran {r}_{side} when v({r}_{side})=0.9 rise=1")
            echo.append(f"{r}_{side}=$&{r}_{side}")
        meas.append(f"meas tran {r}_XA_min min v({r}_XA) from={T0} to=1.4m")
        echo.append(f"{r}_XA_min=$&{r}_XA_min")
    for r in ("e0", "f5"):
        for side in ("oa", "ob"):
            meas.append(f"meas tran {r}_{side}_max max v({r}_{side}) from=0 to=1.4m")
            echo.append(f"{r}_{side}_max=$&{r}_{side}_max")
        meas.append(f"meas tran {r}_icore avg i(vdc{r[1]}) from=200u to=1.4m")
        meas.append(f"meas tran {r}_idec avg i(vdd{r[1]}) from=200u to=1.4m")
        meas.append(f"meas tran {r}_vb max v({r}_VB) from=200u to=1.4m")
        echo.append(f"{r}_icore=$&{r}_icore {r}_idec=$&{r}_idec {r}_vb=$&{r}_vb")
    s += ".control\nset noaskquit\ntran 100n 1.4m 0 200n\n" + "\n".join(meas) + "\n"
    s += "".join(f"echo RES {c} {t} {e}\n" for e in echo)
    s += "quit\n.endc\n.end\n"
    return s


if __name__ == "__main__":
    for c, t in CORNERS:
        open(os.path.join(HERE, f"contrato_{c}_{t}.sp"), "w").write(timing_deck(c, t))
        open(os.path.join(HERE, f"largo_{c}_{t}.sp"), "w").write(long_deck(c, t))
    print("DUT A:", " ".join(dutA[:5]), "| nodo S2A:", p2A, f"({NC_F1} capacidades quitadas en F1)",
          "| precarga A:", " ".join(preA[:5]), "| puertos:", " ".join(PORTS))
