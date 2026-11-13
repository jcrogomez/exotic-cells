#!/usr/bin/env python3
"""c58b analisis: relee los resultados ya existentes de c58_* (no simula nada) y los de c58b_ciclos.py; escribe c58b_tablas.txt y
c58b_traza.png. Todas las cifras de c58b_ANALISIS.md salen de aquí."""
import numpy as np, math, glob, re, os
k, q = 1.380649e-23, 1.602176634e-19
out = []; P = out.append
def det(fn):
    d = {}
    for l in open(fn):
        f = l.split()
        if len(f) > 2 and f[0] in ("DETA", "DETB", "DETC"): d.setdefault(f[1], {})[f[0]] = [float(x) for x in f[2:]]
    return d
d4 = det("c58_det4.txt"); d3 = det("c58_det3_pass2.txt"); d2 = det("c58_det2_pass2.txt"); p1 = det("c58_det2_pass1.txt")
TREL = 3e-6   # la precarga se suelta en t = 3 us
P("== A. Capacidad efectiva, ganancia y tiempos (c58_det4.txt; pulso de 1 aC sobre el nodo aislado) ==")
P("caso                         C_ef(fF)  [corr. deriva]  dV(mV)  t_conv(us)  G(%/mV)  pedestal_p1(mV)  salto_PRE(mV)  caida_Miller(mV)  deriva(V/s)")
res = {}
for tag, v in d4.items():
    A, B, C = v["DETA"], v["DETB"], v["DETC"]
    ga_rel, gc1, gc2, gc3, gc4 = B
    rate = (gc3 - gc2) / (200e-6 - 3.2e-6)            # V/s, entre 3,2 y 200 us
    step = (gc2 - gc1) - rate * (3.2e-6 - 1.9e-6)     # el pulso cae entre 2 y 3 us; se corrige la deriva de 1,3 us
    Cef = 1e-18 / step * 1e15
    ta, tb, gaend = C; tc = ta - TREL; G = 100 * math.log((ta - TREL) / (tb - TREL)) / (step * 1e3)
    t1 = tag.replace("_p4", "_p1"); ped = (p1[t1]["DETA"][2] - p1[t1]["DETA"][0]) * 1e3
    res[tag] = dict(C=Cef, G=G, tc=tc, rate=rate, step=step)
    P(f"{tag:28s} {Cef:7.3f}   {-rate*1.3e-6*1e3:+.3f} mV       {step*1e3:.3f}   {tc*1e6:8.2f}   {G:6.3f}   {ped:8.1f}        {(ga_rel-A[2])*1e3:+6.1f}        {(gaend-ga_rel)*1e3:+7.1f}        {rate:+9.3f}")
P("control con la puerta atada (ideal, c58_det3_pass2.txt): " + ", ".join(f"T{T}: t_conv {(d3[f'cx0_tf500p_v1.8_T{T}_ideal_p2']['DETC'][0]-TREL)*1e6:.2f} us, G {100*math.log((d3[f'cx0_tf500p_v1.8_T{T}_ideal_p2']['DETC'][0]-TREL)/(d3[f'cx0_tf500p_v1.8_T{T}_ideal_p2']['DETC'][1]-TREL)):.3f} %/mV" for T in (27, 85)))
P("\n== B. Ruido congelado, ngspice con fuente de ruido de equilibrio (c58_trn_*.out, 27 C) ==")
P("Cx   C_ef(fF)  N    sigma_antes(mV)  sigma_desp(mV)  var_desp(mV2)  kT/C(mV2)  cociente VARIANZA  ±1s    cociente EFICAZ  ±1s   corr(antes,desp) ±1s   decks abortados")
trn = {}
for cx, Cef in (("0", res["cx0_tf500p_v1.8_T27_n_p4"]["C"]), ("2", res["cx2_tf500p_v1.8_T27_n_p4"]["C"]), ("9", res["cx9_tf500p_v1.8_T27_n_p4"]["C"])):
    a, b, ab = [], [], 0
    for fn in sorted(glob.glob(f"c58_trn_cx{cx}_tf500p_nt1_T27_s*.out")):
        txt = open(fn).read(); ab += "aborted" in txt
        for l in txt.splitlines():
            f = l.split()
            if f and f[0] == "TRN" and len(f) == 4: a.append(float(f[2])); b.append(float(f[3]))
    a, b = np.array(a), np.array(b); N = len(b); vb = b.var(ddof=1) * 1e6; ktc = k * 300.15 / (Cef * 1e-15) * 1e6
    r = vb / ktc; er = r * math.sqrt(2 / (N - 1)); rho = np.corrcoef(a, b)[0, 1]
    trn[cx] = dict(a=a, b=b, r=r)
    P(f"{cx:3s}  {Cef:6.3f}  {N:4d}   {a.std(ddof=1)*1e3:.4f}          {b.std(ddof=1)*1e3:.4f}        {vb:.4f}        {ktc:.4f}     {r:.3f}           {er:.3f}   {math.sqrt(r):.3f}          {er/2/math.sqrt(r):.3f}   {rho:+.3f} ±{1/math.sqrt(N):.3f}        {ab}")
P("\n== C. Comparación con el verificador (modelo 1 - 0,69·n·Cov/C, en VARIANZA) ==")
for n_ in (1.312, 1.41):
    for Cov in (0.103, 0.125):
        P(f"n={n_} Cov={Cov} fF C=0,963 fF: verificador {1-0.69*n_*Cov/0.963:.3f}; mi ajuste 1-0,85·Cov/C = {1-0.85*Cov/0.963:.3f}  (0,69·n = {0.69*n_:.3f} frente a 0,85)")
P("mi MC (c58_mc.txt, C=1,000 fF, Cov=0,103): 0,899-0,916 según flanco; (c58_mc2.txt, C=0,963, Cov=0,103): 0,902; Cov=0,125: 0,881")
P("\n== D. Temperatura ==")
P("ngspice con ruido a 85 C: NO EXISTE (c58_trn.py solo se corrió a 27 C). Las corridas de 85 C son deterministas (c58_det*).")
mc = {}
for l in open("c58_mc.txt"):
    f = l.split()
    if len(f) == 8 and f[1] == "fF" and "e" in f[2]: mc[(float(f[0]), float(f[2]), float(f[3]))] = float(f[4])
P("MC propio (N=40000 por caso; C constante; el ajuste EKV de 27 C se usa sin cambiar a 358 K):")
for C in (1.0, 3.0, 10.0):
    for tf in (5e-10, 5e-8):
        r27, r85 = mc[(C, tf, 300.1)], mc[(C, tf, 358.1)]
        ratio = math.sqrt(358.15 * r85 / (300.15 * r27)); e = ratio * 0.5 * math.sqrt(2 * 2 / 39999)
        P(f"  C={C:4.0f} fF tf={tf:.0e}: var/(kT/C) {r27:.3f} -> {r85:.3f}; cociente EFICAZ de tension 85/27 = {ratio:.4f} ± {e:.4f} (prediccion 1,0923)")
for cx in ("0", "2", "9"):
    a27, a85 = res[f"cx{cx}_tf500p_v1.8_T27_n_p4"], res[f"cx{cx}_tf500p_v1.8_T85_n_p4"]
    gr = a85["G"] / a27["G"]; cr = a85["C"] / a27["C"]
    I85 = -a85["rate"] * a85["C"] * 1e-15; tc = a85["tc"]
    shot = q * I85 * tc / 3 / (a85["C"] * 1e-15) ** 2; ktc = k * 358.15 / (a85["C"] * 1e-15)
    P(f"  Cx={cx}: G 27->85: {a27['G']:.3f} -> {a85['G']:.3f} %/mV (x{gr:.3f}; 1/T daria x0,838) | C_ef {a27['C']:.3f} -> {a85['C']:.3f} fF (x{cr:.3f}) | t_conv {a27['tc']*1e6:.1f} -> {tc*1e6:.2f} us | fuga 85 C {I85*1e15:.0f} fA, deriva en la conversion {a85['rate']*tc*1e3:+.2f} mV, disparo (peso 1/3) {100*shot/ktc:.2f} % de kT/C")
    P(f"        dispersion relativa del tiempo 85/27 = 1,092 [MC] x {gr:.3f} [G] x {1/math.sqrt(cr):.3f} [C] x {math.sqrt(1+shot/ktc):.3f} [fuga] = {1.092*gr/math.sqrt(cr)*math.sqrt(1+shot/ktc):.3f}  (prediccion 0,915)")
P("\n== E. Muestreo repetido sobre el mismo nodo (c58b_ciclos_*.out) ==")
A = {}; 
for fn in sorted(glob.glob("c58b_ciclos_n8_c80_s*.out")):
    for l in open(fn):
        f = l.split()
        if f and f[0] == "CIC" and len(f) == 5: A.setdefault((fn, int(f[1])), {})[int(f[2])] = (float(f[3]), float(f[4]))
if A:
    xs, ys, a_all, b_all, bn = [], [], [], [], []
    lag = {1: [[], []], 2: [[], []], 5: [[], []]}
    for key, dd in A.items():
        cs = sorted(dd); b = np.array([dd[c][1] for c in cs]); a = np.array([dd[c][0] for c in cs])
        a_all += list(a); b_all += list(b)
        for L in lag:
            lag[L][0] += list(b[:-L] - b.mean()); lag[L][1] += list(b[L:] - b.mean())
        xs += list(b[:-1] - b.mean()); ys += list(a[1:] - a.mean())
    a_all, b_all = np.array(a_all), np.array(b_all); N = len(b_all)
    P(f"series: {len(A)} nodos x ~{N//len(A)} ciclos = {N} muestras. sigma_antes {a_all.std(ddof=1)*1e3:.4f} mV, sigma_despues {b_all.std(ddof=1)*1e3:.4f} mV, media despues {b_all.mean()*1e3:.2f} mV")
    P(f"corr(antes, despues) mismo ciclo: {np.corrcoef(a_all, b_all)[0,1]:+.3f} ± {1/math.sqrt(N):.3f}")
    for L in lag:
        x, y = np.array(lag[L][0]), np.array(lag[L][1]); P(f"autocorrelacion de la muestra congelada, retardo {L} ciclo(s): {np.corrcoef(x, y)[0,1]:+.3f} ± {1/math.sqrt(len(x)):.3f}  (pares: {len(x)})")
    P(f"corr(despues ciclo k, antes ciclo k+1): {np.corrcoef(xs, ys)[0,1]:+.3f} ± {1/math.sqrt(len(xs)):.3f}")
    Cef = res["cx0_tf500p_v1.8_T27_n_p4"]["C"]; r = b_all.var(ddof=1) / (k * 300.15 / (Cef * 1e-15))
    P(f"cociente de VARIANZA respecto de kT/C (C_ef {Cef:.3f} fF): {r:.3f} ± {r*math.sqrt(2/(N-1)):.3f}")
else: P("c58b_ciclos: sin resultados todavía")
# traza
fn = "c58b_ciclos_n2_c3_s77_traza.dat"
if os.path.exists(fn):
    D = np.loadtxt(fn); t, clk, gg, g0, g1 = D[:, 0], D[:, 1], D[:, 3], D[:, 5], D[:, 7]
    m = (t > 0.05e-9) & (t < 0.292e-9); x = g0[m] - g0[m].mean(); dt = np.median(np.diff(t[m]))
    ac = [1.0] + [float(np.mean(x[:-j] * x[j:]) / np.mean(x * x)) for j in range(1, 40)]
    tau = next((j * dt for j, v in enumerate(ac) if v < 1 / math.e), float("nan"))
    P(f"\n== F. Traza de ejemplo ({fn}) ==\ncon el interruptor cerrado (0,05-0,29 ns): sigma {x.std()*1e3:.3f} mV; la autocorrelacion de v(g) cae a 1/e en {tau*1e12:.1f} ps (paso {dt*1e12:.2f} ps)")
    for tt in (0.292e-9, 0.35e-9, 0.40e-9, 0.45e-9, 0.50e-9, 0.55e-9, 0.60e-9, 0.70e-9, 0.80e-9, 1.09e-9):
        i = np.searchsorted(t, tt); P(f"  t={tt*1e12:6.0f} ps  clk={clk[i]:.3f} V  g_interruptor={gg[i]:.3e} S  tau=C/g={0.963e-15/max(gg[i],1e-30)*1e12:10.3g} ps  v(g0)={g0[i]*1e3:8.3f} mV  v(g1)={g1[i]*1e3:8.3f} mV")
    # artefacto: tras el corte la "conductancia" de las replicas se hace negativa (corriente capacitiva que no cancela) y la fuente la usa en valor absoluto
    w2 = (t > 0.3e-9) & (t < 1.1e-9); t2, g2 = t[w2], gg[w2]; i0 = int(np.argmax(g2 < 0)); Isp = float(np.trapezoid(np.abs(g2[i0:]), t2[i0:]))
    P(f"ARTEFACTO de c58_trn.py/c58b_ciclos.py: g de las replicas cruza a negativo en t={t2[i0]*1e12:.0f} ps (clk={clk[w2][i0]:.3f} V); integral de |g| despues = {Isp:.3e} S·s")
    for cx_, C_ in (("0", 0.963e-15), ("2", 2.956e-15), ("9", 9.991e-15)):
        sp = 2 * k * 300.15 * Isp / C_ ** 2 / (k * 300.15 / C_)
        P(f"  Cx={cx_}: ruido espurio inyectado tras el corte = {sp:.3f} de kT/C -> cociente de varianza de ngspice corregido {trn[cx_]['r']:.3f} - {sp:.3f} = {trn[cx_]['r']-sp:.3f}")
    import matplotlib; matplotlib.use("Agg"); import matplotlib.pyplot as plt
    fig, ax = plt.subplots(3, 1, figsize=(9, 7), sharex=True); w = t < 1.2e-9
    ax[0].plot(t[w] * 1e12, clk[w]); ax[0].set_ylabel("reloj (V)")
    ax[1].semilogy(t[w] * 1e12, np.maximum(gg[w], 1e-12)); ax[1].set_ylabel("g del interruptor (S)")
    ax[2].plot(t[w] * 1e12, g0[w] * 1e3, label="nodo 0"); ax[2].plot(t[w] * 1e12, g1[w] * 1e3, label="nodo 1"); ax[2].set_ylabel("v(puerta) (mV)"); ax[2].set_xlabel("t (ps)"); ax[2].legend()
    for a_ in ax: a_.axvline(292, color="k", ls=":"); a_.axvline(1090, color="k", ls=":")
    fig.suptitle("c58b: un ciclo de muestreo, nodo mínimo. Líneas de puntos: instantes 'antes' y 'después'"); fig.tight_layout(); fig.savefig("c58b_traza.png", dpi=120)
P("\n== G. Entropía (reloj supuesto 50 MHz [?], tick 20 ns; sigma_t = hipot(sigma_V·G, 0,57 %)·t_conv) ==")
P("C(fF)   t_conv(us)  sigma_t(ticks)  niveles en ±4s  Shannon(bit)  min-entropia(bit)  tope SP800-90B(8)  1 bit (comparador)  perdida por rho: 0,02 / 0,14 / 0,44")
for cx, f_ in (("0", 0.89), ("2", 0.964), ("9", 0.989)):
    a = res[f"cx{cx}_tf500p_v1.8_T27_n_p4"]; sv = math.sqrt(f_ * k * 300.15 / (a["C"] * 1e-15)) * 1e3
    st = math.hypot(sv * a["G"], 0.57) / 100 * a["tc"] / 20e-9
    ks = np.arange(-int(8 * st) - 2, int(8 * st) + 3); pk = np.array([0.5 * (math.erf((kk + 0.5) / (st * math.sqrt(2))) - math.erf((kk - 0.5) / (st * math.sqrt(2)))) for kk in ks]); pk = pk[pk > 0]
    H = -(pk * np.log2(pk)).sum(); Hm = -math.log2(pk.max())
    P(f"{a['C']:6.3f}  {a['tc']*1e6:7.1f}    {st:8.1f}       {8*st:7.0f}        {H:6.2f}        {Hm:6.2f}             {min(Hm,8):.2f}             <=1              " + " / ".join(f"{-0.5*math.log2(1-r*r):.4f}" for r in (0.02, 0.14, 0.44)))
open("c58b_tablas.txt", "w").write("\n".join(out) + "\n"); print("\n".join(out))
