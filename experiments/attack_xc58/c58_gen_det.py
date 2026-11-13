#!/usr/bin/env python3
"""c58: decks deterministas (A1 capacidad, A2/A3 ganancia con puerta flotante, B1 pedestal, B2 fuga).
Lector extraído xc19_read + interruptor nfet 0,42/0,15 entre la polarización (aislada por un seguidor ideal) y la puerta.
Uso: python c58_gen_det.py  -> escribe c58_det_*.sp y c58_run_det.sh"""
import itertools
T = """* c58 det: Cx={cx}f tf={tf} VDD={vdd} T={temp}  variante={var}
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include /cells/xc19_read/xc19_read.pex.spice
.options gmin=1e-18 abstol=1e-18 reltol=1e-5 chgtol=1e-20
.temp {temp}
Vdd vdd 0 {vdd}
* cadena de polarizacion V2, K=4, 10 pF (como post_layout.sp)
Xc0 vdd vdd c1 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc1 c1 c1 c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc2 c2 c2 vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc3 vb vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=16
Cf vb 0 10p
* seguidores ideales: cada canal ve la polarizacion sin cargarla. vboff sube la polarizacion para compensar el pedestal
Ea sa 0 vb 0 1
Va2 sa2 sa {vboff}
Eb sb 0 sa2 0 1
Vb1 sb1 sb 1m
* reloj del interruptor: alto = cerrado. Cae en t=1u con flanco tf
Vclk clk 0 pulse({vdd} 0 1u {tf} {tf} 1 2)
Vclkb clkb 0 pulse(0 {vdd} 1u {tf} {tf} 1 2)
* precarga: PRE bajo = precargando. Se suelta en t=3u
Vpre pre 0 pulse(0 {vdd} 3u 1n 1n 1 2)
Vpre0 pre0 0 0
* canal A: nominal
{swA}
Xa ga pre xa vdd 0 xc19_read
Cxa ga 0 {cx}f
Xia xa 0 0 vdd vdd ya sky130_fd_sc_hd__inv_1
* canal B: +1 mV en la fuente (ganancia)
{swB}
Xb gb pre xb vdd 0 xc19_read
Cxb gb 0 {cx}f
Xib xb 0 0 vdd vdd yb sky130_fd_sc_hd__inv_1
* canal C: nunca se suelta; pulso de carga de 1 aC en t=2u (capacidad) y luego deriva (fuga)
{swC}
Xcc gc pre0 xc vdd 0 xc19_read
Cxc gc 0 {cx}f
Iq 0 gc pulse(0 1n 2u 1p 1p 1n 1)
.control
tran 20n {tstop}
meas tran vb0 find v(vb) at=0.9u
meas tran ga_on find v(ga) at=0.9u
meas tran ga_off find v(ga) at=1.9u
meas tran ga_rel find v(ga) at=3.2u
meas tran gc1 find v(gc) at=1.9u
meas tran gc2 find v(gc) at=2.9u
meas tran gc3 find v(gc) at={t3}
meas tran gc4 find v(gc) at={t4}
meas tran ta when v(ya)=0.9 rise=1
meas tran tb when v(yb)=0.9 rise=1
meas tran ga_end find v(ga) when v(ya)=0.9 rise=1
echo DET {tag} $&vb0 $&ga_on $&ga_off $&ga_rel $&gc1 $&gc2 $&gc3 $&gc4 $&ta $&tb $&ga_end
quit
.endc
.end
"""
def sw(var, node, src):
    s = f"Xs{node} {src} clk {node} 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 ad=0.126 pd=1.44 as=0.126 ps=1.44\n"
    if var == "dummy":   # interruptor ancho + ficticio mitad con reloj complementario, fuente y drenaje unidos al nodo
        s = (f"Xs{node} {src} clk {node} 0 sky130_fd_pr__nfet_01v8 w=0.84 l=0.15 ad=0.252 pd=2.28 as=0.126 ps=1.44\n"
             f"Xd{node} {node} clkb {node} 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 ad=0.063 pd=0.72 as=0.063 ps=0.72\n")
    if var == "pcomp":   # nfet + pfet (que a 0,3 V no conduce: solo compensa el acoplo)
        s += f"Xp{node} {src} clkb {node} vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15 ad=0.126 pd=1.44 as=0.126 ps=1.44\n"
    if var == "ideal":   # control: sin interruptor, puerta atada a la fuente (lector original)
        s = f"Rs{node} {src} {node} 1\n"
    return s
runs = []
def add(cx, tf, vdd, temp, var, vboff=0.0, tstop="3m"):
    tag = f"cx{cx}_tf{tf}_v{vdd}_T{temp}_{var}_o{int(vboff*1000)}"
    t3, t4 = ("100u", "2.9m")
    open(f"c58_det_{tag}.sp", "w").write(T.format(cx=cx, tf=tf, vdd=vdd, temp=temp, var=var, vboff=vboff, tag=tag, tstop=tstop, t3=t3, t4=t4,
        swA=sw(var, "ga", "sa2"), swB=sw(var, "gb", "sb1"), swC=sw(var, "gc", "sa2")))
    runs.append(tag)
for cx, tf in itertools.product((0, 2, 9), ("50p", "500p", "5n")): add(cx, tf, 1.8, 27, "n")
for cx in (0, 2, 9):
    add(cx, "500p", 1.81, 27, "n"); add(cx, "500p", 1.8, 85, "n")
add(0, "500p", 1.8, 27, "ideal"); add(0, "500p", 1.8, 85, "ideal")
add(0, "500p", 1.8, 27, "dummy"); add(0, "500p", 1.8, 27, "pcomp"); add(0, "500p", 1.81, 27, "dummy"); add(0, "500p", 1.81, 27, "pcomp")
open("c58_run_det.sh", "w").write("#!/bin/bash\ncd /w\nfor t in " + " ".join(runs) + "; do ngspice -b c58_det_$t.sp > c58_det_$t.log 2>&1; grep '^DET' c58_det_$t.log; done\n")
print(len(runs), "decks")
