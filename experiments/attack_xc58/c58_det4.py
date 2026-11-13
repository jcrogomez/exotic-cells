#!/usr/bin/env python3
"""c58 det4: ganancia del lector respecto de la tensión CONGELADA en la puerta: el canal B recibe 1 aC tras abrir el interruptor (antes de soltar la precarga); el canal C recibe lo mismo y no se suelta (da el escalón en mV). Compensaciones tomadas de c58_det2_pass1.txt.
c58 det2: sustituye a c58_gen_det.py (cuya corrida abortó en t=2,001 us por el pulso de carga de 1 ps; se conserva).
Dos pasadas por caso: 1) pedestal con la polarización nominal; 2) polarización subida en ese pedestal para que la puerta
aislada quede cerca de 0,317 V, y entonces capacidad (pulso de 1 aC), ganancia (+1 mV), tiempo de descarga y fuga (deriva en 2,8 ms).
Uso: python c58_det2.py   (llama a docker)"""
import subprocess, re, os, itertools
P = os.environ["ZTASIC"]
PDK = P + "/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A"
HERE = os.path.dirname(os.path.abspath(__file__))
T = """* c58 det2: Cx={cx}f tf={tf} VDD={vdd} T={temp} variante={var} vboff={vboff}
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include /cells/xc19_read/xc19_read.pex.spice
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp {temp}
Vdd vdd 0 {vdd}
Xc0 vdd vdd c1 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc1 c1 c1 c2 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc2 c2 c2 vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc3 vb vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=16
Cf vb 0 10p
Ea sa 0 vb 0 1
Va2 sa2 sa {vboff}
Vb1 sb1 sa2 0
Iqb 0 gb pulse(0 1p 2u 10n 10n 0.99u 1)
Vclk clk 0 pulse({vdd} 0 1u {tf} {tf} 1 2)
Vclkb clkb 0 pulse(0 {vdd} 1u {tf} {tf} 1 2)
Vpre pre 0 pulse(0 {vdd} 3u 1n 1n 1 2)
Vpre0 pre0 0 0
{swA}
Xa ga pre xa vdd 0 xc19_read
Cxa ga 0 {cx}f
Xia xa 0 0 vdd vdd ya sky130_fd_sc_hd__inv_1
{swB}
Xb gb pre xb vdd 0 xc19_read
Cxb gb 0 {cx}f
Xib xb 0 0 vdd vdd yb sky130_fd_sc_hd__inv_1
{swC}
Xcc gc pre0 xc vdd 0 xc19_read
Cxc gc 0 {cx}f
Iq 0 gc pulse(0 1p 2u 10n 10n 0.99u 1)
.control
tran 20n {tstop}
meas tran vb0 find v(vb) at=0.9u
meas tran ga_on find v(ga) at=0.9u
meas tran ga_off find v(ga) at=1.9u
echo DETA {tag} $&vb0 $&ga_on $&ga_off
meas tran ga_rel find v(ga) at=3.2u
meas tran gc1 find v(gc) at=1.9u
meas tran gc2 find v(gc) at=3.2u
meas tran gc3 find v(gc) at=200u
meas tran gc4 find v(gc) at=390u
echo DETB {tag} $&ga_rel $&gc1 $&gc2 $&gc3 $&gc4
meas tran ta when v(ya)=0.9 rise=1
meas tran tb when v(yb)=0.9 rise=1
meas tran ga_end find v(ga) when v(ya)=0.9 rise=1
echo DETC {tag} $&ta $&tb $&ga_end
quit
.endc
.end
"""
def sw(var, node, src):
    s = f"Xs{node} {src} clk {node} 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 ad=0.126 pd=1.44 as=0.126 ps=1.44\n"
    if var == "dummy":
        s = (f"Xs{node} {src} clk {node} 0 sky130_fd_pr__nfet_01v8 w=0.84 l=0.15 ad=0.252 pd=2.28 as=0.126 ps=1.44\n"
             f"Xd{node} {node} clkb {node} 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 ad=0.063 pd=0.72 as=0.063 ps=0.72\n")
    if var == "pcomp":
        s += f"Xp{node} {src} clkb {node} vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15 ad=0.126 pd=1.44 as=0.126 ps=1.44\n"
    if var == "ideal":
        s = f"Rs{node} {src} {node} 1\n"
    return s
def deck(tag, cx, tf, vdd, temp, var, vboff, tstop):
    open(f"{HERE}/c58_d4_{tag}.sp", "w").write(T.format(cx=cx, tf=tf, vdd=vdd, temp=temp, var=var, vboff=vboff, tag=tag, tstop=tstop,
        swA=sw(var, "ga", "sa2"), swB=sw(var, "gb", "sb1"), swC=sw(var, "gc", "sa2")))
def run(tags):
    sh = "cd /w; for t in " + " ".join(tags) + "; do ngspice -b c58_d4_$t.sp > c58_d4_$t.log 2>&1; grep '^DET' c58_d4_$t.log; done"
    out = subprocess.run(["docker", "run", "--rm", "-v", PDK + ":/pdk:ro", "-v", P + "/06_exotic_cells/cells:/cells:ro", "-v", HERE + ":/w",
                          "hpretl/iic-osic-tools:2025.07", "--skip", "bash", "-c", sh], capture_output=True, text=True).stdout
    return [l for l in out.splitlines() if l.startswith("DET")]

ped = {}
for l in open(f"{HERE}/c58_det2_pass1.txt"):
    f = l.split()
    if f[0] == "DETA": ped[f[1]] = float(f[4]) - float(f[2])
cases = [(cx, "500p", 1.8, T, "n") for T in (27, 85) for cx in (0, 2, 9)]
name = lambda c, p: f"cx{c[0]}_tf{c[1]}_v{c[2]}_T{c[3]}_{c[4]}_p{p}"
tags = []
for c in cases:
    deck(name(c, 4), *c, round(-ped[name(c, 1)], 6), "400u"); tags.append(name(c, 4))
r = run(tags); open(f"{HERE}/c58_det4.txt", "w").write("\n".join(r) + "\n"); print("\n".join(r))
