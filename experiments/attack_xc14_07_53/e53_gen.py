"""e53_gen.py — genera y corre en ngspice (Docker hpretl/iic-osic-tools:2025.07, PDK de la imagen) bombas de Dickson con
dispositivos de 5 V del PDK. Única carpeta montada: e53_sp/ (lectura-escritura, nuestra). El PDK no se monta.

Topologías (diodo = transistor con puerta a drenaje), W = 4 µm, L = 0,5 µm (dentro de un bin del modelo):
  n   : nfet_g5v0d10v5, cuerpo a 0 (sustrato p).
  nb  : nfet_g5v0d10v5, cuerpo a su fuente (exige pozo p aislado; el diodo pozo-p/pozo-n profundo NO está en el netlist: [?]).
  pa  : pfet_g5v0d10v5, pozo n unido al nodo de entrada del diodo (a).
  pb  : pfet_g5v0d10v5, pozo n unido al nodo de salida del diodo (b).
Condensador de bombeo C ideal (1 pF ≈ 500 µm² de MiM, camimc = 2,00e-15 F/µm², PDK local r+c/res_typical__cap_typical__lin.spice l.7),
parásito de placa a tierra 5 % de C en cada nodo. Reloj de dos fases complementarias de amplitud VDD, 10 MHz, flancos de 1 ns.
Salida: 2 pF a tierra y carga de corriente I_L. Barrido: VDD ∈ {1,8; 3,3}, N ∈ {2, 4, 6, 8}, I_L ∈ {0; 1 µA}.
"""
import os, subprocess, itertools, re, sys
HERE = os.path.dirname(os.path.abspath(__file__))
W = os.path.join(HERE, "e53_sp"); os.makedirs(W, exist_ok=True)
HEAD = """.lib /foss/pdks/sky130A/libs.tech/ngspice/sky130.lib.spice tt
.options gmin=1e-15 reltol=1e-4 method=gear
.temp 27
"""


def dev(top, k, a, b):
    if top == "n":
        return f"X{k} {a} {a} {b} 0 sky130_fd_pr__nfet_g5v0d10v5 w=4 l=0.5"
    if top == "nb":
        return f"X{k} {a} {a} {b} {b} sky130_fd_pr__nfet_g5v0d10v5 w=4 l=0.5"
    if top == "pa":
        return f"X{k} {b} {b} {a} {a} sky130_fd_pr__pfet_g5v0d10v5 w=4 l=0.5"
    if top == "pb":
        return f"X{k} {b} {b} {a} {b} sky130_fd_pr__pfet_g5v0d10v5 w=4 l=0.5"


def deck(top, vdd, N, il, C=1e-12, f=10e6, tstop=60e-6):
    T = 1 / f
    s = [f"* e53 {top} VDD={vdd} N={N} IL={il}", HEAD,
         f"Vdd in 0 {vdd}",
         f"V1 c1 0 PULSE(0 {vdd} 0 1n 1n {T/2-1e-9} {T})",
         f"V2 c2 0 PULSE({vdd} 0 0 1n 1n {T/2-1e-9} {T})"]
    nodes = ["in"] + [f"n{i}" for i in range(1, N + 1)] + ["out"]
    for i in range(N + 1):
        s.append(dev(top, i, nodes[i], nodes[i + 1]))
    for i in range(1, N + 1):
        s.append(f"C{i} n{i} {'c1' if i % 2 else 'c2'} {C}")
        s.append(f"Cp{i} n{i} 0 {0.05*C}")
    s += ["Cout out 0 2p", f"IL out 0 {il}"]
    meas = [f".meas tran vo_a AVG v(out) from={tstop-12e-6} to={tstop-10e-6}",
            f".meas tran vo_b AVG v(out) from={tstop-2e-6} to={tstop}",
            f".meas tran vo_rip PP v(out) from={tstop-2e-6} to={tstop}",
            f".meas tran idd AVG i(Vdd) from={tstop-2e-6} to={tstop}",
            f".meas tran i1 AVG i(V1) from={tstop-2e-6} to={tstop}",
            f".meas tran i2 AVG i(V2) from={tstop-2e-6} to={tstop}"]
    for i in range(N + 1):
        a, b = nodes[i], nodes[i + 1]
        meas.append(f".meas tran rev{i} MAX par('v({b})-v({a})') from={tstop-2e-6} to={tstop}")
        meas.append(f".meas tran fwd{i} MAX par('v({a})-v({b})') from={tstop-2e-6} to={tstop}")
        meas.append(f".meas tran vmax{i} MAX v({b}) from={tstop-2e-6} to={tstop}")
    s += meas + [f".tran 1n {tstop} 0 1n", ".end"]
    return "\n".join(s) + "\n"


def main():
    names = []
    for top, vdd, N, il in itertools.product(("n", "nb", "pa", "pb"), (1.8, 3.3), (2, 4, 6, 8), (0, 1e-6)):
        nm = f"e53_{top}_{str(vdd).replace('.', 'p')}_N{N}_I{int(il*1e9)}n"
        open(os.path.join(W, nm + ".sp"), "w").write(deck(top, vdd, N, il))
        names.append(nm)
    if "--gen" in sys.argv:
        return
    # 6 contenedores en paralelo
    groups = [names[i::6] for i in range(6)]
    procs = []
    for g in groups:
        cmd = ("head -1 /foss/pdks/sky130A/SOURCES > /w/pdk_imagen.txt 2>/dev/null; cd /tmp && for f in " + " ".join(g) +
               "; do cp /w/$f.sp /tmp/; ngspice -b $f.sp > /tmp/$f.log 2>&1; cp /tmp/$f.log /w/; done")
        procs.append(subprocess.Popen(["docker", "run", "--rm", "-v", W + ":/w", "hpretl/iic-osic-tools:2025.07", "--skip",
                                       "sh", "-c", cmd], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL))
    for p in procs:
        p.wait()


if __name__ == "__main__":
    main()
