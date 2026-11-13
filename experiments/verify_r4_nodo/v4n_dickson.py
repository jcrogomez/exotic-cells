"""v4n_dickson.py — bomba de Dickson con sky130_fd_pr__pfet_g5v0d10v5 en diodo, mazo propio del verificador.

Elección declarada (antes de correr):
- N = número de condensadores de bombeo; N+1 diodos (el último carga C_out). Nodo 0 = VDD.
- Diodo k: fuente = nodo k-1, puerta = drenaje = nodo k, POZO = nodo k ("pozo a la salida"). W = 5 µm, L = 0,5 µm.
- C de bombeo: sky130_fd_pr__cap_mim_m3_1 w = l = 22 µm (≈ 1,0 pF, 2 fF/µm² + 0,19 fF/µm del PDK), placa c1 al reloj.
  Parásita en el nodo: 0,1 pF ideal a tierra (10 %); la MIM del PDK no trae parásita de placa inferior.
- Pozo n – sustrato de cada pfet: diodo sky130_fd_pr__model__parasitic__diode_ps2nw, 100 µm² (supuesto de área).
- Relojes: dos fases no solapadas, 10 MHz, 0→VDD, flancos de 1 ns, ancho 45 ns.
- C_out = 2 pF; carga = fuente de corriente ideal I_L a tierra (0, 0,5, 1, 2 µA).
- tt, 27 °C. Transitorio de 80 µs; V_out = media de los últimos 2 µs; máximos de tensión entre terminales en los últimos 4 µs.
Lo que NO modela: PNP vertical (p+ fuente / pozo / sustrato) cuando la fuente supera al pozo; ruptura de MIM.
"""
import itertools
import os
import subprocess
import numpy as np

PDK_REL = "../../../local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A"
AQUI = os.path.dirname(os.path.abspath(__file__))
TSIM = 80e-6


def netlist(vdd, N, IL, tag):
    L = [f"* v4n Dickson pfet_g5v0d10v5 vdd={vdd} N={N} IL={IL}",
         ".lib /pdk/libs.tech/ngspice/sky130.lib.spice tt",
         ".temp 27",
         f"Vdd n0 0 {vdd}",
         f"Vp1 p1 0 pulse(0 {vdd} 2n 1n 1n 45n 100n)",
         f"Vp2 p2 0 pulse(0 {vdd} 52n 1n 1n 45n 100n)"]
    for k in range(1, N + 1):
        clk = "p1" if k % 2 == 1 else "p2"
        L.append(f"XC{k} n{k} {clk} sky130_fd_pr__cap_mim_m3_1 w=22 l=22")
        L.append(f"Cp{k} n{k} 0 0.1p")
    for k in range(1, N + 2):
        a, b = f"n{k-1}", (f"n{k}" if k <= N else "out")
        L.append(f"XM{k} {b} {b} {a} {b} sky130_fd_pr__pfet_g5v0d10v5 w=5 l=0.5 nf=1")
        L.append(f"Dnw{k} 0 {b} sky130_fd_pr__model__parasitic__diode_ps2nw area=100e-12")
    L.append("Cout out 0 2p")
    L.append(f"IL out 0 {IL}")
    L.append(".control")
    L.append(f"tran 0.5n {TSIM} 0 1n")
    nodes = ["n0"] + [f"n{k}" for k in range(1, N + 1)] + ["out"]
    L.append(f"meas tran vout avg v(out) from={TSIM-2e-6} to={TSIM}")
    L.append(f"meas tran vout_prev avg v(out) from={TSIM-12e-6} to={TSIM-10e-6}")
    for k in range(1, N + 2):
        a, b = nodes[k - 1], nodes[k]
        L.append(f"let d{k} = v({b})-v({a})")
        L.append(f"meas tran dmax{k} max d{k} from={TSIM-4e-6} to={TSIM}")
        L.append(f"meas tran dmin{k} min d{k} from={TSIM-4e-6} to={TSIM}")
    L.append(f"meas tran ivdd avg i(Vdd) from={TSIM-2e-6} to={TSIM}")
    L.append(f"meas tran ip1 avg i(Vp1) from={TSIM-2e-6} to={TSIM}")
    L.append(f"meas tran ip2 avg i(Vp2) from={TSIM-2e-6} to={TSIM}")
    L.append(f"echo RES {tag} $&vout $&vout_prev " + " ".join(f"$&dmax{k} $&dmin{k}" for k in range(1, N + 2))
             + " $&ivdd $&ip1 $&ip2")
    L.append(".endc")
    L.append(".end")
    return "\n".join(L) + "\n"


def main():
    casos = []
    for vdd, N, IL in itertools.product((1.8, 3.3), (4, 6, 8), (0.0, 0.5e-6, 1e-6, 2e-6)):
        if vdd == 3.3 and N == 8:
            continue
        tag = f"v{vdd}_N{N}_I{IL*1e6:.1f}"
        fn = f"v4n_dk_{tag}.sp"
        open(os.path.join(AQUI, fn), "w").write(netlist(vdd, N, f"{IL:.3e}", tag))
        casos.append((vdd, N, IL, tag, fn))
    script = " ".join(f"ngspice -b {c[4]} > v4n_dk_{c[3]}.log 2>&1 &" for c in casos) + " wait"
    pdk = os.path.normpath(os.path.join(AQUI, PDK_REL))
    subprocess.run(["docker", "run", "--rm", "-v", f"{AQUI}:/w", "-v", f"{pdk}:/pdk:ro", "-w", "/w",
                    "hpretl/iic-osic-tools:2025.07", "--skip", "bash", "-c", script], check=True,
                   stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    out = ["# vdd N IL_uA | Vout(fin) Vout(-10us) | max|V_SD| sobre diodos (=|V_GS|, puerta=drenaje) | max V(pozo)-V(fuente) inversa | P_in uW | eficiencia"]
    for vdd, N, IL, tag, fn in casos:
        log = open(os.path.join(AQUI, f"v4n_dk_{tag}.log")).read()
        line = [l for l in log.splitlines() if l.startswith("RES ")]
        if not line:
            out.append(f"{tag} FALLO (ver log)")
            continue
        v = [float(x) for x in line[-1].split()[2:]]
        vout, vprev = v[0], v[1]
        dm = v[2:2 + 2 * (N + 1)]
        dmax = max(abs(x) for x in dm)
        ivdd, ip1, ip2 = v[-3:]
        pin = -vdd * (ivdd + ip1 + ip2)
        eff = vout * IL / pin if pin > 0 else float("nan")
        out.append(f"{vdd} {N} {IL*1e6:.1f} | {vout:.3f} {vprev:.3f} | {dmax:.3f} | {max(dm[0::2]):.3f} | {pin*1e6:.2f} | {eff:.3f}")
    txt = "\n".join(out)
    print(txt)
    open(os.path.join(AQUI, "v4n_dickson.txt"), "w").write(txt + "\n")


if __name__ == "__main__":
    main()
