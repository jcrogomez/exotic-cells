#!/usr/bin/env python3
"""c58 trn: ruido transitorio en ngspice del muestreo sobre el netlist extraído del lector con el interruptor añadido.
El modelo del PDK no genera ruido en transitorio: se añade en paralelo con el interruptor una fuente de corriente blanca de
densidad 4kT·g(t), donde g(t) sale de dos réplicas del interruptor con ±1 mV entre fuente y drenaje y el mismo reloj (la
diferencia cancela la corriente capacitiva del flanco). Es el ruido de equilibrio (Nyquist): válido mientras la caída sobre el
interruptor sea << kT/q o el canal esté en inversión fuerte; el régimen de flanco lento en inversión débil lo cubre c58_mc.py.
N instancias independientes por deck; se mide la tensión de puerta antes de abrir (control de equilibrio) y después.
Uso: python c58_trn.py CX_fF TF NT_ps NINST NSEEDS [TEMP]"""
import subprocess, os, sys, numpy as np
P = os.environ["ZTASIC"]
PDK = P + "/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A"
HERE = os.path.dirname(os.path.abspath(__file__))
cx, tf, nt, ninst, nseeds = sys.argv[1], sys.argv[2], float(sys.argv[3]), int(sys.argv[4]), int(sys.argv[5])
temp = float(sys.argv[6]) if len(sys.argv) > 6 else 27.0
kT = 1.380649e-23 * (temp + 273.15)
tfs = float(tf.replace("p", "e-12").replace("n", "e-9"))
t0 = 0.40037e-9; t1 = t0 + tfs + 0.3e-9   # t0 fuera de la rejilla del ruido: si coincide, ngspice aborta (paso 1e-24)
def deck(seed):
    s = f"""* c58 trn: Cx={cx}f tf={tf} NT={nt}p seed={seed} T={temp}
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /cells/xc19_read/xc19_read.pex.spice
.options gmin=1e-18 abstol=1e-16 reltol=1e-5
.temp {temp}
Vdd vdd 0 1.8
Vsa sa 0 0.3168
Vclk clk 0 pulse(1.8 0 {t0} {tf} {tf} 1 2)
Vpre0 pre0 0 0
* replicas para g(t)
Vr1 r1 sa 1m
Vr2 r2 sa -1m
Vm1 r1 r1m 0
Vm2 r2 r2m 0
Xr1 r1m clk sa 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 ad=0.126 pd=1.44 as=0.126 ps=1.44
Xr2 r2m clk sa 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 ad=0.126 pd=1.44 as=0.126 ps=1.44
Bg 0 gg I = (i(Vm1)-i(Vm2))/2m
Rgg gg 0 1
Cgg gg 0 0.2p
"""
    for i in range(ninst):
        s += f"""Xs{i} sa clk g{i} 0 sky130_fd_pr__nfet_01v8 w=0.42 l=0.15 ad=0.126 pd=1.44 as=0.126 ps=1.44
Xa{i} g{i} pre0 x{i} vdd 0 xc19_read
Cx{i} g{i} 0 {cx}f
Vn{i} n{i} 0 dc 0 trnoise(1 {nt}p 0 0)
Bn{i} sa g{i} I = v(n{i})*sqrt({2*kT/(nt*1e-12):.6e}*sqrt(v(gg)*v(gg)+1e-22))
"""
    s += f".control\nset rndseed={seed}\ntran {nt}p {t1}\n"
    s += "meas tran gpk max v(gg)\nmeas tran gend find v(gg) at=%g\necho TRG $&gpk $&gend\n" % (t1 * 0.999)
    for i in range(ninst):
        s += f"meas tran a{i} find v(g{i}) at={t0*0.98}\nmeas tran b{i} find v(g{i}) at={t1*0.999}\necho TRN {i} $&a{i} $&b{i}\n"
    s += "quit\n.endc\n.end\n"
    return s
tag = f"cx{cx}_tf{tf}_nt{nt:g}_T{temp:g}"
names = []
for k in range(nseeds):
    n = f"c58_trn_{tag}_s{k}"; open(f"{HERE}/{n}.sp", "w").write(deck(20261112 + k)); names.append(n)
sh = "cd /w; for t in " + " ".join(names) + "; do ngspice -b $t.sp 2>&1 | grep -E '^TR[NG]|too small|aborted' > $t.out; done"
subprocess.run(["docker", "run", "--rm", "-v", PDK + ":/pdk:ro", "-v", P + "/06_exotic_cells/cells:/cells:ro", "-v", HERE + ":/w",
                "hpretl/iic-osic-tools:2025.07", "--skip", "bash", "-c", sh], capture_output=True, text=True)
a, b = [], []
for n in names:
    for l in open(f"{HERE}/{n}.out"):
        f = l.split()
        if f[0] == "TRN" and len(f) == 4: a.append(float(f[2])); b.append(float(f[3]))
a, b = np.array(a), np.array(b); N = len(b)
out = (f"{tag}: N={N}  antes de abrir: media {a.mean()*1e3:.3f} mV sigma {a.std(ddof=1)*1e3:.4f} mV | "
       f"despues: media {b.mean()*1e3:.3f} mV sigma {b.std(ddof=1)*1e3:.4f} mV (±{100/np.sqrt(2*(N-1)):.1f} %) "
       f"asimetria {((b-b.mean())**3).mean()/b.std()**3:+.2f} curtosis-3 {((b-b.mean())**4).mean()/b.std()**4-3:+.2f} corr(antes,despues) {np.corrcoef(a,b)[0,1]:+.3f}")
print(out); open(f"{HERE}/c58_trn_resumen.txt", "a").write(out + "\n")
