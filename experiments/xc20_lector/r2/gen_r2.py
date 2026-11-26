"""XC-20 lector 2 (R2): decks. Prerregistro: cells/preregistros/XC-20_2026-11-25_lector_rango_ancho.md.
Un deck por (esquina, caso). Caso = corriente con nodo MOS (nfet 4,3/4,0, el del lector 1), o control con 200 fF ideales.
Circuito del lazo: el de diseno/gen.py v4 (latch SR, 8 dlygate4sd3_1, precarga pfet_01v8_hvt w=1 m=2 en pila)."""
import os
H = os.path.dirname(os.path.abspath(__file__))
CORN = (("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85"))
JUZ = [1e-10, 1e-9, 1e-8, 1e-7, 1e-6, 1e-5]; CAL = [3.1623e-10, 3.1623e-8, 3.1623e-6]; WIT = [1.01e-8, 1.01e-6]
def deck(c, t, i, ideal):
    p = "o"; s = [f"* XC-20 lector 2, R2: I = {i:.4e} A, nodo {'200 fF ideal' if ideal else 'MOS 4,3/4,0'}, {c} {t} C",
                  f".lib /pdk/libs.tech/ngspice/sky130.lib.spice {c}", ".include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice",
                  f".temp {t}", ".options gmin=1e-15 reltol=1e-4", "Vd vdd 0 1.8"]
    s += [f"C{p} {p}_x 0 200f" if ideal else f"X{p}_c 0 {p}_x 0 0 sky130_fd_pr__nfet_01v8 w=4.3 l=4"]
    if i > 0: s += [f"I{p} {p}_x 0 {i:.4e}"]
    s += [f"X{p}_pre {p}_x {p}_pren {p}_st vdd sky130_fd_pr__pfet_01v8_hvt w=1 l=0.15 m=2",
          f"X{p}_pre2 {p}_st {p}_pren vdd vdd sky130_fd_pr__pfet_01v8_hvt w=1 l=0.15 m=2",
          f"X{p}_cmp {p}_x 0 0 vdd vdd {p}_c sky130_fd_sc_hd__inv_1", f"X{p}_s1 {p}_c 0 0 vdd vdd {p}_c2 sky130_fd_sc_hd__inv_1",
          f"X{p}_s2 {p}_c2 0 0 vdd vdd {p}_s sky130_fd_sc_hd__inv_1", f"X{p}_q {p}_r {p}_qb 0 0 vdd vdd {p}_q sky130_fd_sc_hd__nor2_1",
          f"X{p}_qb {p}_s {p}_q 0 0 vdd vdd {p}_qb sky130_fd_sc_hd__nor2_1", f"X{p}_p {p}_q 0 0 vdd vdd {p}_pren sky130_fd_sc_hd__inv_4"]
    prev = f"{p}_q"
    for k in range(8):
        nxt = f"{p}_r" if k == 7 else f"{p}_d{k}"; s += [f"X{p}_d{k} {prev} 0 0 vdd vdd {nxt} sky130_fd_sc_hd__dlygate4sd3_1"]; prev = nxt
    s += [f".ic v({p}_x)=1.8"]
    ts = 20e-3 if i == 0 else 14 * 200e-15 * 2.0 / i + 16 * 10e-9
    s += [".control", "set noaskquit", f"save v({p}_q) v({p}_x)", f"tran {min(ts/20000, 1e-9):.3e} {ts:.4e} 0 {min(ts/2000, 1e-6):.3e}",
          f"meas tran r2 when v({p}_q)=0.9 rise=2", f"meas tran r12 when v({p}_q)=0.9 rise=12", f"meas tran r1 when v({p}_q)=0.9 rise=1",
          f"meas tran xmin min v({p}_x) from=0 to={ts:.4e}", f"echo R2 {c} {t} {'ideal' if ideal else 'mos'} {i:.4e} $&r2 $&r12", f"echo R2X {c} {t} {i:.4e} xmin $&xmin",
          "quit", ".endc", ".end"]
    return "\n".join(s) + "\n"
n = 0
for c, t in CORN:
    casos = [(i, False) for i in JUZ + CAL + WIT + [0.0]] + ([(1e-9, True), (1e-6, True)] if (c, t) == ("tt", "27") else [])
    for i, ideal in casos:
        d = os.path.join(H, f"{c}{t}_{'id' if ideal else 'm'}_{i:.4e}"); os.makedirs(d, exist_ok=True)
        open(os.path.join(d, "lec.sp"), "w").write(deck(c, t, i, ideal)); n += 1
print("decks:", n)
