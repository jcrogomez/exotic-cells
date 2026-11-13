"""b05 (5): genera los mazos de ngspice del lector de baja tensión y los corre en Docker (hpretl/iic-osic-tools:2025.07, ngspice 44.2)
con el PDK de la imagen (/foss/pdks/sky130A, open_pdks 8afc8346: el mismo commit que el PDK local; el montaje del PDK local
tardaba > 5 min por mazo en cargar).  Esquemático, tt, 27 C, sin parásitos de layout (se añade c_par explícita en el nodo A).

Lector 'Thevenin': riel H = divisor de poly res_high_po (l=56 arriba, l=0,5 abajo; mismo material) desde VDD -> ~45 mV.
(v1 con l=17,5 dio 137 mV: las cabezas del resistor corto pesan; guardada en b05_5_v1_*.)
Tres caminos de H al nodo A: ALTO, permanente, res_xhigh_po l=52 (~300k); MEDIO, nfet w=1 + res_xhigh_po l=1,75 (~10k);
BAJO, nfet w=5 (su R_on es la resistencia serie). Dispositivo entre A y masa. Lectura: nfet 0,42/0,15 con la FUENTE en A y la
puerta en el nodo de polarización de XC-19 (cadena Xc0/Xc1/Xc2 copiada de experiments/xc19_weak_inversion/stage_K3_1800_27.sp),
que descarga un nodo X precargado; un inv_1 marca el cruce. cab = condensador explícito A-masa (0 o 50 fF); cpar = 5 fF de cableado.
Dispositivo: resistencia de comportamiento R = rd*exp(23,03*v(c)): v(c)=0 -> rd ; v(c)=1 -> rd*1e10 (abierto)."""
import subprocess, os, sys, re
HERE = os.path.dirname(os.path.abspath(__file__))
PDK = os.path.abspath(os.path.join(HERE, '../../../local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A'))
W = os.path.join(HERE, 'b05_5_sp'); os.makedirs(W, exist_ok=True)
HEAD = """.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.include /foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.options gmin=1e-15 abstol=1e-15 reltol=1e-4
.temp 27
.subckt canal vdd slo smid c pre a h x y rd=100 cab=50f
XR1 vdd h 0 sky130_fd_pr__res_high_po_0p35 l=56
XR2 h 0 0 sky130_fd_pr__res_high_po_0p35 l=0.5
XRhi h a 0 sky130_fd_pr__res_xhigh_po_0p35 l=52
XMmid h smid m1 0 sky130_fd_pr__nfet_01v8 w=1 l=0.15
XRmid m1 a 0 sky130_fd_pr__res_xhigh_po_0p35 l=1.75
XMlo h slo a 0 sky130_fd_pr__nfet_01v8 w=5 l=0.15
Rdut a 0 r = {rd*exp(23.03*v(c))}
Cab a 0 {cab}
Cpar a 0 5f
Xc0 vdd vdd c1 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc1 c1 c1 vb 0 sky130_fd_pr__nfet_01v8 w=1 l=1
Xc2 vb vb 0 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 m=16
Cf vb 0 1p
Xp x pre vdd vdd sky130_fd_pr__pfet_01v8 w=0.42 l=0.15
Xr x vb a 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15
Xi x 0 0 vdd vdd y sky130_fd_sc_hd__inv_1
.ends
"""
decks = {}
RD = {'100': 100, '12k9': 12906, '1M': 1e6, 'ab': 1e12}
# ---- T0: continua. V(A) y V(H) frente a R del dispositivo en los tres rangos
s = "* b05 T0: continua\n" + HEAD + "Vdd vdd 0 1.8\nVc c 0 0\nVpre pre 0 0\n"
rds = [30, 100, 300, 1e3, 3e3, 1e4, 12906, 3e4, 1e5, 3e5, 1e6, 3e6, 1e12]
for rng, (lo, mid) in {'bajo': (1.8, 0), 'medio': (0, 1.8), 'alto': (0, 0)}.items():
    s += f"Vlo_{rng} slo_{rng} 0 {lo}\nVmid_{rng} smid_{rng} 0 {mid}\n"
    for i, r in enumerate(rds):
        s += f"X{rng}{i} vdd slo_{rng} smid_{rng} c pre a_{rng}_{i} h_{rng}_{i} x_{rng}_{i} y_{rng}_{i} canal rd={r:g} cab=0\n"
s += ".control\nop\n"
for rng in ('bajo', 'medio', 'alto'):
    for i, r in enumerate(rds):
        s += f"echo T0 {rng} {r:g} $&v(a_{rng}_{i}) $&v(h_{rng}_{i})\n"
s += "print i(Vdd)\nquit\n.endc\n.end\n"
decks['t0_dc'] = s
# ---- T0b: calibración del lector: tiempo de descarga frente a la tensión de fuente (fuente ideal en A)
s = "* b05 T0b: tiempo de conversión frente a V(A)\n" + HEAD + "Vdd vdd 0 1.8\nVc c 0 0\nVpre pre 0 pulse(0 1.8 1u 1n 1n 1 2)\nVlo slo 0 0\nVmid smid 0 0\n"
vas = [0, 0.3e-3, 5e-3, 10e-3, 20e-3, 30e-3, 40e-3, 50e-3, 50.3e-3, 60e-3]
for i, v in enumerate(vas):
    s += f"X{i} vdd slo smid c pre a{i} h{i} x{i} y{i} canal rd=1e12 cab=0\nVf{i} a{i} 0 {v}\n"
s += ".control\ntran 20n 1.2m\n"
for i, v in enumerate(vas):
    s += f"meas tran t{i} when v(y{i})=0.9 rise=1\necho T0B {v:g} $&t{i}\n"
s += "quit\n.endc\n.end\n"
decks['t0b_cal'] = s
# ---- T1: arranque y apagado. Rampas de VDD; selectores en el peor caso (siguen a VDD) y a 0
s = "* b05 T1: arranque/apagado\n" + HEAD + "Vc c 0 0\nVz z 0 0\n"
ramps = {'10n': 10e-9, '100n': 100e-9, '1u': 1e-6, '10u': 10e-6}
meas = ""
for rn, tr in ramps.items():
    s += f"Vdd{rn} vdd{rn} 0 pwl(0 0 1n 0 {1e-9+tr:g} 1.8 {1e-9+tr+60e-6:g} 1.8 {1e-9+2*tr+60e-6:g} 0)\n"
    for dn, r in RD.items():
        for sel in ('v', 'z'):
            for cab in ('0', '50f'):
                n = f"{rn}_{dn}_{sel}_{cab}"; sn = f"vdd{rn}" if sel == 'v' else 'z'
                s += f"X{n} vdd{rn} {sn} {sn} c z a_{n} h_{n} x_{n} y_{n} canal rd={r:g} cab={cab}\n"
                meas += f"meas tran mx_{n} max v(a_{n})\nmeas tran mn_{n} min v(a_{n})\necho T1 rampa={rn} R={dn} sel={sel} cab={cab} max=$&mx_{n} min=$&mn_{n}\n"
s += ".control\ntran 1n 85u\n" + meas + "quit\n.endc\n.end\n"
decks['t1_arranque'] = s
# ---- T2/T3: salto del dispositivo 100 Ohm <-> abierto en 1 ns (y 12,9k <-> abierto), en cada rango
s = "* b05 T2/T3: saltos de resistencia en 1 ns\n" + HEAD + "Vdd vdd 0 1.8\nVz z 0 0\nVup cu 0 pwl(0 0 2u 0 2.001u 1)\nVdn cd 0 pwl(0 1 2u 1 2.001u 0)\n"
meas = ""
for rng, (lo, mid) in {'bajo': ('vdd', 'z'), 'medio': ('z', 'vdd'), 'alto': ('z', 'z')}.items():
    for dn in ('100', '12k9'):
        for dirn, cn in (('abre', 'cu'), ('cierra', 'cd')):
            for cab in ('0', '50f'):
                n = f"{rng}_{dn}_{dirn}_{cab}"
                s += f"X{n} vdd {lo} {mid} {cn} z a_{n} h_{n} x_{n} y_{n} canal rd={RD[dn]:g} cab={cab}\n"
                meas += (f"meas tran mx_{n} max v(a_{n})\nmeas tran mn_{n} min v(a_{n})\nmeas tran v0_{n} find v(a_{n}) at=1.9u\nmeas tran v1_{n} find v(a_{n}) at=5.9u\n"
                         f"meas tran hx_{n} max v(h_{n})\necho T2 rango={rng} R={dn} {dirn} cab={cab} antes=$&v0_{n} despues=$&v1_{n} max=$&mx_{n} min=$&mn_{n} maxH=$&hx_{n}\n")
s += ".control\ntran 0.05n 6u 1.99u\n" + meas
s += "set wr_singlescale\nset wr_vecnames\noption numdgt=6\nwrdata /w/t2_trazas.dat v(a_alto_100_abre_0) v(a_alto_100_abre_50f) v(a_bajo_100_abre_0) v(a_medio_100_abre_0) v(a_alto_100_cierra_50f)\nquit\n.endc\n.end\n"
decks['t2_saltos'] = s
# ---- T4: cambio de rango con flanco crudo (1 ns) y con flanco frenado (RC 1 MOhm x 200 fF en la puerta)
s = "* b05 T4: cambio de rango\n" + HEAD + "Vdd vdd 0 1.8\nVz z 0 0\nVc c 0 0\nVs s 0 pulse(0 1.8 2u 1n 1n 10u 20u)\nRg s sg 1meg\nCg sg 0 200f\n"
meas = ""
for dn in ('12k9', '1M', 'ab'):
    for which in ('lo', 'mid'):
        for edge, sn in (('crudo', 's'), ('frenado', 'sg')):
            for cab in ('0', '50f'):
                n = f"{dn}_{which}_{edge}_{cab}"; lo = sn if which == 'lo' else 'z'; mid = sn if which == 'mid' else 'z'
                s += f"X{n} vdd {lo} {mid} c z a_{n} h_{n} x_{n} y_{n} canal rd={RD[dn]:g} cab={cab}\n"
                meas += f"meas tran mx_{n} max v(a_{n})\nmeas tran mn_{n} min v(a_{n})\necho T4 R={dn} conmuta={which} flanco={edge} cab={cab} max=$&mx_{n} min=$&mn_{n}\n"
s += ".control\ntran 0.2n 16u 1u\n" + meas + "set wr_singlescale\nset wr_vecnames\nwrdata /w/t4_trazas.dat v(a_ab_lo_crudo_0) v(a_ab_lo_crudo_50f) v(a_ab_lo_frenado_50f) v(a_ab_lo_frenado_0)\nquit\n.endc\n.end\n"
decks['t4_rango'] = s
# ---- T5: conversión (precarga/descarga) sobre el dispositivo y T6: escalón de 0,2 V en VDD en 1 ns
s = "* b05 T5/T6: retroceso del lector y ruido de alimentación\n" + HEAD + "Vdd vdd 0 1.8\nVz z 0 0\nVc c 0 0\nVpre pre 0 pulse(0 1.8 1u 1n 1n 400u 500u)\n"
s += "Vddn vddn 0 pwl(0 1.8 600u 1.8 600.001u 2.0 610u 2.0 610.001u 1.6 620u 1.6)\n"
meas = ""
for dn in ('100', '12k9', '1M', 'ab'):
    for cab in ('0', '50f'):
        n = f"{dn}_{cab}"
        s += f"X5{n} vdd z z c pre a5_{n} h5_{n} x5_{n} y5_{n} canal rd={RD[dn]:g} cab={cab}\n"
        s += f"X6{n} vddn z z c z a6_{n} h6_{n} x6_{n} y6_{n} canal rd={RD[dn]:g} cab={cab}\n"
        meas += (f"meas tran mx5_{n} max v(a5_{n}) from=0.5u to=590u\nmeas tran mn5_{n} min v(a5_{n}) from=0.5u to=590u\nmeas tran dc5_{n} find v(a5_{n}) at=0.9u\nmeas tran tc5_{n} when v(y5_{n})=0.9 rise=1\n"
                 f"echo T5 R={dn} cab={cab} reposo=$&dc5_{n} max=$&mx5_{n} min=$&mn5_{n} tconv=$&tc5_{n}\n"
                 f"meas tran mx6_{n} max v(a6_{n}) from=599u to=620u\nmeas tran mn6_{n} min v(a6_{n}) from=599u to=620u\necho T6 R={dn} cab={cab} max=$&mx6_{n} min=$&mn6_{n}\n")
s += ".control\ntran 5n 620u\n" + meas + "quit\n.endc\n.end\n"
decks['t5_lector'] = s
# ---- T7: candidato anillo con resistencia serie (EFLD-00 simplificado: nand2_1, inv_1, ebufn_1 -> nA, Rser, DUT, 32 inv_1 en nB, 11 inv_1)
s = "* b05 T7: anillo con resistencia serie; tensión sobre el dispositivo\n" + HEAD
s += """.subckt anillo en vdd m nb rser=100k rd=12906
Xn0 en fb 0 0 vdd vdd s1 sky130_fd_sc_hd__nand2_1
Xi1 s1 0 0 vdd vdd s2 sky130_fd_sc_hd__inv_1
Xeb s2 0 0 0 vdd vdd na sky130_fd_sc_hd__ebufn_1
Rs na m {rser}
Rd m nb {rd}
"""
for i in range(32): s += f"Xl{i} nb 0 0 vdd vdd q{i} sky130_fd_sc_hd__inv_1\n"
prev = 'nb'
for i in range(11):
    nxt = 'fb' if i == 10 else f"c{i}"; s += f"Xc{i} {prev} 0 0 vdd vdd {nxt} sky130_fd_sc_hd__inv_1\n"; prev = nxt
s += ".ends\nVdd vdd 0 1.8\nVen en 0 pwl(0 0 1n 0 1.1n 1.8)\n"
meas = ""
for rs in ('0', '30k', '100k', '1meg'):
    for dn in ('100', '12k9', '1M'):
        n = f"{rs}_{dn}"
        s += f"X{n} en vdd m_{n} nb_{n} anillo rser={rs if rs!='0' else '1'} rd={RD[dn]:g}\n"
        meas += f"let d_{n} = v(m_{n})-v(nb_{n})\nmeas tran mx_{n} max d_{n}\nmeas tran mn_{n} min d_{n}\necho T7 Rser={rs} R={dn} max=$&mx_{n} min=$&mn_{n}\n"
s += ".control\ntran 20p 400n\n" + meas + "quit\n.endc\n.end\n"
decks['t7_anillo'] = s
# ---- T8: candidato fuente de corriente en inversión débil sin limitación (pfet espejo ~50 nA), dispositivo 100 Ohm -> abierto
s = "* b05 T8: fuente de corriente sin limitar\n" + HEAD + """Vdd vdd 0 1.8
Ib bp 0 50n
Xm1 bp bp vdd vdd sky130_fd_pr__pfet_01v8 w=1 l=1
Xm2 a bp vdd vdd sky130_fd_pr__pfet_01v8 w=1 l=1
Vc c 0 pwl(0 0 1u 0 1.001u 1)
Rdut a 0 r = {100*exp(23.03*v(c))}
Cpar a 0 5f
.control
tran 1n 20u
meas tran v0 find v(a) at=0.9u
meas tran t50 when v(a)=0.05 rise=1
meas tran t100 when v(a)=0.1 rise=1
meas tran mx max v(a)
echo T8 antes=$&v0 t_50mV=$&t50 t_100mV=$&t100 max=$&mx
quit
.endc
.end
"""
decks['t8_fuente'] = s
only = sys.argv[1:]
for n, s in decks.items():
    open(os.path.join(W, n + '.sp'), 'w').write(s)
names = [n for n in decks if not only or n in only]
groups = [[n for n in g if n in names] for g in (['t0_dc', 't0b_cal', 't8_fuente'], ['t1_arranque'], ['t2_saltos', 't4_rango'], ['t5_lector', 't7_anillo'])]
procs = []
for g in groups:
    if not g: continue
    cmd = "cp /w/*.sp /tmp/ && cd /tmp && head -1 /foss/pdks/sky130A/SOURCES > /w/pdk_imagen.txt; for f in " + " ".join(g) + "; do ngspice -b $f.sp > /tmp/$f.log 2>&1; cp /tmp/$f.log /w/; done"
    procs.append(subprocess.Popen(['docker', 'run', '--rm', '-v', PDK + ':/pdk:ro', '-v', W + ':/w', 'hpretl/iic-osic-tools:2025.07', '--skip', 'sh', '-c', cmd], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL))
for p in procs: p.wait()
out = []
for n in names:
    L = open(os.path.join(W, n + '.log')).read().splitlines()
    out.append(f"## {n}")
    out += [l for l in L if re.match(r'^T\d', l) or 'rror' in l or 'i(vdd)' in l.lower()][:400]
print("\n".join(out))
