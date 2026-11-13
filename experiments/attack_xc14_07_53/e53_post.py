"""e53_post.py — lee e53_sp/*.log (ngspice) y resume: V_out estacionaria, asentamiento, corriente de entrada, esfuerzos por
dispositivo; compara con el modelo ideal de Dickson V = VDD + N·(α·VDD − V_d) − N·I/(f·C·(1+0,05)), α = 1/1,05.
Salida: e53_post.txt, e53_post.png
"""
import os, re, glob, numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
HERE = os.path.dirname(os.path.abspath(__file__))
rows = []
for f in sorted(glob.glob(os.path.join(HERE, "e53_sp", "*.log"))):
    nm = os.path.basename(f)[:-4]
    m = re.match(r"e53_(\w+?)_(\dp\d)_N(\d+)_I(\d+)n", nm)
    top, vdd, N, il = m.group(1), float(m.group(2).replace("p", ".")), int(m.group(3)), int(m.group(4)) * 1e-9
    txt = open(f).read()
    meas = dict((k, float(v)) for k, v in re.findall(r"^(\w+)\s*=\s*([-+0-9.eE]+)", txt, re.M))
    if "vo_b" not in meas:
        rows.append((top, vdd, N, il, None)); continue
    rows.append((top, vdd, N, il, meas))
alpha = 1 / 1.05
L = []
P = lambda s="": (L.append(s), print(s))
P("top VDD N I_L | Vout(58-60µs) Vout(48-50µs) rizado | V_ideal(Vd=0) | caída/etapa | Iin(µA) | máx V_inv por dispositivo | máx nodo")
for top, vdd, N, il, m in rows:
    if m is None:
        P(f"{top:3s} {vdd} {N} {il*1e6:.0f}µA: SIN RESULTADO (ver log)"); continue
    vid = vdd + N * alpha * vdd - N * il / (10e6 * 1e-12 * 1.05)
    vd = (vid - m["vo_b"]) / (N + 1)
    iin = -(m["idd"] + m["i1"] + m["i2"]) * 1e6
    revs = [m.get(f"rev{i}", np.nan) for i in range(N + 1)]
    vmx = max(m.get(f"vmax{i}", np.nan) for i in range(N + 1))
    P(f"{top:3s} {vdd} {N} {il*1e6:.0f}µA | {m['vo_b']:6.2f} {m['vo_a']:6.2f} {m['vo_rip']*1e3:5.1f}mV | {vid:6.2f} | {vd:5.2f} V | "
      f"{iin:7.2f} | {np.nanmax(revs):5.2f} | {vmx:6.2f}")
open(os.path.join(HERE, "e53_post.txt"), "w").write("\n".join(L) + "\n")
fig, axs = plt.subplots(1, 2, figsize=(9, 4), sharey=True)
for ax, vdd in zip(axs, (1.8, 3.3)):
    for top, c in zip(("n", "nb", "pa", "pb"), ("C0", "C1", "C2", "C3")):
        for il, ls in ((0, "-"), (1e-6, "--")):
            pts = sorted((N, m["vo_b"]) for t, v, N, i, m in rows if t == top and v == vdd and i == il and m)
            if pts:
                a = np.array(pts); ax.plot(a[:, 0], a[:, 1], ls, marker="o", color=c, label=f"{top}, {il*1e6:.0f} µA")
    Ns = np.arange(2, 9); ax.plot(Ns, vdd + Ns * alpha * vdd, "k:", label="ideal V_d=0")
    for y, t in ((5.5, "V_GS máx 5 V"), (11, "V_DS máx 11 V"), (12.6, "bvs nfet 5 V")):
        ax.axhline(y, color="gray", lw=0.5); ax.text(2, y + 0.1, t, fontsize=7)
    ax.set_title(f"VDD = {vdd} V"); ax.set_xlabel("etapas N"); ax.legend(fontsize=6)
axs[0].set_ylabel("V_out (V)")
fig.tight_layout(); fig.savefig(os.path.join(HERE, "e53_post.png"), dpi=120)
