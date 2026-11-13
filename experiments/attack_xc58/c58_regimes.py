#!/usr/bin/env python3
"""c58 regimes: presupuesto rehecho, mapa de regímenes, correlación, entropía y termómetro. Solo aritmética.
Cada entrada lleva su procedencia:
  C0, G, tiempos, sensibilidad a VDD, fuga        -> corridas ngspice de esta carpeta (c58_det2/3/4, c58_swdc)
  factor f = var/(kT/C)                            -> c58_mc.py / c58_mc2.py (Monte Carlo propio), cota inferior c58_trn.py (ngspice)
  piso del lector 0,57 %                           -> experiments/xc58_ktc_budget/budget.txt (corrida de XC-19 + supuesto de 0,9 V)
  ruido lento del lector, trampas del interruptor  -> SUPUESTOS barridos (no públicos): se dan como intervalo
"""
import numpy as np, math
k, q = 1.380649e-23, 1.602176634e-19
C0 = 0.963            # fF, nodo de puerta mínimo (pulso de 1 aC -> 1,038 mV; c58_det4.txt)
COV = 0.125           # fF, Cov efectivo que reproduce el pedestal de ngspice en el MC (c58_mc2.py)
G = {0.963: 2.732, 2.959: 2.728, 10.0: 2.73}     # %/mV respecto de la tensión congelada, 27 C (c58_det4.txt). CORREGIDO: la v1 no restaba los 3 us previos a soltar la precarga (c58_regimes_v1_*.txt)
TCONV = {0.963: 330e-6, 2.959: 54e-6, 10.0: 34e-6}  # s, polarización K=4 compensada (c58_det3_pass2.txt)
FLOOR = 0.57          # % por conversión (presupuesto previo; no resimulado con la puerta flotante)
ILEAK = {27: 0.66e-15, 85: 290e-15}   # A, unión + canal del interruptor abierto, modelo tt (c58_swdc_*.log, c58_det2 deriva 0,69 V/s)
SUP = 0.50            # %/mV de alimentación, una etapa (c58_det3_pass2.txt, 1,80 -> 1,81 V)
def f(C): return max(1 - 0.85 * COV / C, 0.5)       # ajuste a c58_mc.txt: 0,916 con Cov/C=0,103; 0,827 con 0,2; 0,66 con 0,4
def gain(C): return np.interp(np.log(C), np.log([0.963, 2.959, 10.0]), [2.732, 2.728, 2.73])
def tconv(C): return float(np.exp(np.interp(np.log(C), np.log([0.963, 2.959, 10.0]), np.log([330e-6, 54e-6, 34e-6]))))
out = []
P = out.append
P("== 1. Presupuesto rehecho (27 C = 300,15 K) ==")
P("C_puerta  sigma kT/C  f(MC)  sigma congelada  G      disp. tiempo  piso   parte kT/C   t_conv   vs presupuesto previo")
for C in (C0, 2.0, 2.959, 5.0, 10.0, 30.0, 100.0, 300.0):
    s0 = math.sqrt(k * 300.15 / (C * 1e-15)) * 1e3; s = s0 * math.sqrt(f(C)); st = s * gain(C); prev = s0 * 0.83 / 0.305
    P(f"{C:7.3f} fF  {s0:5.3f} mV  {f(C):.3f}   {s:5.3f} mV      {gain(C):.2f}   {st:5.2f} %       {FLOOR:.2f}   {100*st*st/(st*st+FLOOR**2):5.1f} %     {tconv(C)*1e6:5.0f} us   {prev:5.2f} %")
P("El presupuesto previo daba 5,54 % a 1 fF y 1,75 % a 10 fF: con el nodo mínimo real (0,96 fF) sale 5,35 %; a 10 fF, 1,75 %. La aritmética previa se sostiene.")
P("\n== 2. Términos deterministas (corrida) ==")
P("pedestal del interruptor nfet mínimo, flanco 50p/500p/5n: C0: -223/-154/-113 mV; +2 fF: -94/-59/-47 mV; +9 fF: -33/-23/-16 mV (c58_det2_pass1.txt)")
P("salto al soltar la precarga: +28,0 / +9,2 / +2,7 mV (0,96 / 2,96 / 10 fF); caída de la puerta durante la descarga (Miller): -132 / -34 / -10 mV")
P("\n== 3. Fuga del nodo aislado ==")
for T in (27, 85):
    for mult in (0.1, 1, 10):
        I = ILEAK[T] * mult; row = f"T={T} C  I_fuga={I*1e15:8.2f} fA (modelo x{mult:<4}):"
        for C, th in ((C0, 25e-6), (C0, 330e-6), (C0, 1e-3), (10.0, 34e-6), (10.0, 1e-3)):
            drift = I * th / (C * 1e-15) * 1e3; shot = math.sqrt(q * I * th) / (C * 1e-15) * 1e3
            sk = math.sqrt(k * (T + 273.15) / (C * 1e-15)) * 1e3
            row += f"  [{C:.2f} fF,{th*1e6:4.0f} us: deriva {drift:7.3f} mV, disparo {shot:6.3f} mV = {100*shot*shot/sk/sk:6.2f} % de kT/C]"
        P(row)
P("\n== 4. Fronteras ==")
Cx = [C for C in np.geomspace(0.963, 1000, 4000) if (math.sqrt(k*300.15/(C*1e-15))*1e3*math.sqrt(f(C))*gain(C)) < FLOOR][0]
P(f"kT/C = piso del lector (0,57 %) en C = {Cx:.0f} fF; kT/C = 3x piso en C = {[C for C in np.geomspace(0.963,1000,4000) if (math.sqrt(k*300.15/(C*1e-15))*1e3*math.sqrt(f(C))*gain(C)) < 3*FLOOR][0]:.1f} fF")
for T in (27, 85):
    for C in (C0, 10.0):
        th10 = 0.1 * k * (T + 273.15) * C * 1e-15 / (q * ILEAK[T]); thd = math.sqrt(k*(T+273.15)*C*1e-15) / ILEAK[T]
        P(f"T={T} C, C={C:5.2f} fF: el ruido de disparo de la fuga llega al 10 % de kT/C con retención de {th10*1e3:9.3f} ms; la deriva iguala a sigma en {thd*1e3:9.3f} ms (fuga del modelo; x0,1..x10 escala inverso)")
for se in (0.9, 1.5, 2.7):
    P(f"trampas del interruptor, sigma = {se} e (SUPUESTO, Dit 1e10..1e11/cm2/eV): {100*(se*q)**2/(k*300.15*C0*1e-15):5.2f} % de kT/C a {C0} fF; {100*(se*q)**2/(k*300.15*10e-15):5.2f} % a 10 fF (va como 1/C respecto de kT/C)")
P(f"granularidad: sqrt(kTC)/q = {math.sqrt(k*300.15*C0*1e-15)/q:.1f} e a {C0} fF; {math.sqrt(k*300.15*10e-15)/q:.1f} e a 10 fF; un electrón = {q/(C0*1e-15)*1e3:.3f} mV a {C0} fF")
P("\n== 5. Correlación entre muestras sucesivas (estimación) ==")
for C in (C0, 10.0, 100.0):
    T0 = 300.15; vk = k*T0/(C*1e-15)*1e6*f(C); vfl = (FLOOR/gain(C))**2
    row = f"C={C:6.2f} fF: var kT/C {vk:.4f} mV2, piso {vfl:.4f} mV2;"
    for nm, vb in (("polarizacion 17 uV (n·kT/2Cf, Cf=10 pF)", 0.017**2), ("polarizacion 37 uV (README XC-19 escalado a 10 pF)", 0.037**2)):
        row += f" rho1<= {vb/(vk+vfl):.1e} [{nm}];"
    for nm, vs in (("lector lento 0,0012 mV2/decada x6 decadas", 0.0012*6), ("lector lento 0,012 mV2/decada x6 decadas", 0.012*6)):
        row += f" rho1~ {vs/(vk+vfl+vs):.3f} [{nm}];"
    for sv in (0.1, 1.0):
        vv = (SUP*sv/gain(C))**2; row += f" alimentacion {sv} mV ef.: {100*vv/(vk+vfl+vv):.2f} % de la varianza;"
    P(row)
P("memoria del nodo: con el interruptor cerrado tau = C/g_on = 0,963 fF / 3,8e-4 S = 2,5 ps; cerrado 1 ns -> exp(-400): nula. Reparto de carga con Cf: C/Cf = 1e-4 (0,96 fF) .. 1e-2 (100 fF) de la muestra anterior")
P("\n== 6. Entropía mínima por muestra (gaussiana cuantizada por un contador; reloj supuesto 50 MHz [?]) ==")
for C in (C0, 2.959, 10.0, 30.0, 100.0):
    st = math.sqrt(k*300.15/(C*1e-15))*1e3*math.sqrt(f(C))*gain(C); tot = math.hypot(st, FLOOR)/100*tconv(C); tick = 20e-9
    pmax = math.erf(tick/(2*math.sqrt(2)*tot)); H = -math.log2(pmax)
    P(f"C={C:6.2f} fF: sigma_t = {tot*1e9:8.1f} ns = {tot/tick:6.1f} ticks -> H_min ideal {H:.2f} bit/muestra (SP 800-90B reduce el alfabeto a <=256: tope 8); a {1/tconv(C)/1e3:.1f} kmuestras/s")
P("NIST SP 800-90B (leído): 1 000 000 muestras crudas consecutivas + 1000 reinicios x 1000 muestras = 2e6 conversiones:")
for C in (C0, 10.0): P(f"   C={C} fF: {2e6*tconv(C):.0f} s de datos")
P("\n== 7. Termómetro ==")
G27, G85 = 2.728, 2.280       # %/mV a 2,96 fF (c58_det4.txt, restados los 3 us: 53,9624->53,4672 us y 6,69706->6,64566 us por 0,338 mV). A 0,963 fF sale 2,732 y 2,445, pero a 85 C la puerta deriva 8 mV durante la conversión
dlnG = math.log(G85 / G27) / 58.0
P(f"ganancia del lector: {G27} %/mV a 27 C, {G85} %/mV a 85 C -> dlnG/dT = {100*dlnG:.3f} %/K (1/T puro daría {-100/329:.3f} %/K)")
sens = 1 / 329.0 + 2 * dlnG
P(f"con los dos pares medidos: dlnG/dT = {100*math.log(2.445/2.732)/58:.3f} %/K (0,963 fF, contaminado por fuga) .. {100*dlnG:.3f} %/K (2,96 fF) -> sensibilidad de la varianza relativa del tiempo entre {100*(1/329+2*math.log(2.445/2.732)/58):+.2f} y {100*(1/329+2*dlnG):+.2f} %/K")
P(f"varianza de la TENSION: +{100/329:.2f} %/K. Varianza RELATIVA DEL TIEMPO (lo que se mide): {100*sens:+.2f} %/K  -> signo contrario al del plan")
for dT in (3.0, 1.0, 0.1):
    N = 2 / (sens * dT) ** 2
    P(f"  resolver {dT} K (1 sigma): N = {N:,.0f} conversiones = {N*tconv(C0):.1f} s a {C0} fF ({tconv(C0)*1e6:.0f} us) o {N*1.27*tconv(10.0):.1f} s a 10 fF (x1,27 por restar el piso)")
P("  control (no filtro): el tiempo medio de descarga cambia ~5 %/K (README XC-19) con 0,57 % de ruido: 0,1 K en una conversión, pero no es primario")
P("  error absoluto sin calibrar: C ±10 % (SUPUESTO: óxido ±5 %, solape ±20 %, unión ±15 %, hilo ±25 %, sumados sobre 0,96 fF) -> "
  f"±{10/abs(100*sens):.0f} K; f(C) ±3 % -> ±{3/abs(100*sens):.0f} K; G (n) ±2 % -> ±{4/abs(100*sens):.0f} K")
for mult in (0.1, 1, 10):
    I = ILEAK[85] * mult; th = 25e-6; shot2 = q * I * th / (C0 * 1e-15) ** 2 / 3; kt = k * 358.15 / (C0 * 1e-15) * f(C0)
    P(f"  a 85 C, fuga x{mult}: el disparo de la fuga durante la conversión (25 us, peso 1/3) añade {100*shot2/kt:.1f} % de varianza = lectura {100*shot2/kt/(100*sens):+.0f} K (la varianza extra se lee como temperatura más baja) (a 10 fF, diez veces menos)")
P("  cociente entre dos capacidades: var1/var2 = (C2/C1)(f1/f2)(G1/G2)^2: no contiene T. Mide C2/C1, no la temperatura.")
P("  lo que sí cancela la ganancia: un escalón de tensión conocido en la puerta (da G = 1/(n·kT/q) en el mismo canal).")
open("c58_regimes.txt", "w").write("\n".join(out) + "\n"); print("\n".join(out))
# mapa de regímenes
import matplotlib; matplotlib.use("Agg"); import matplotlib.pyplot as plt
from matplotlib.colors import ListedColormap
Cs = np.geomspace(0.3, 300, 300); ths = np.geomspace(1e-6, 1, 300); CC, TT = np.meshgrid(Cs, ths)
fig, ax = plt.subplots(1, 2, figsize=(12, 5), sharey=True)
names = ["kT/C", "lector (piso 0,57 %)", "fuga (disparo)", "trampas del interruptor (1,5 e, supuesto)"]
for a, T in zip(ax, (27, 85)):
    Tk = T + 273.15; ff = np.maximum(1 - 0.85 * COV / CC, 0.5)
    g = np.interp(np.log(np.clip(CC, 0.963, 10)), np.log([0.963, 2.959, 10.0]), [2.732, 2.728, 2.73]) * (1 + dlnG * (T - 27))
    v = np.stack([k * Tk / (CC * 1e-15) * ff, (FLOOR / g * 1e-3) ** 2 + 0 * CC, q * ILEAK[T] * TT / (CC * 1e-15) ** 2, (1.5 * q / (CC * 1e-15)) ** 2 + 0 * CC])
    dom = np.argmax(v, axis=0).astype(float); share = v[0] / v.sum(axis=0)
    a.pcolormesh(Cs, ths, dom, cmap=ListedColormap(["#4c9f70", "#8d99ae", "#d1495b", "#edae49"]), vmin=-0.5, vmax=3.5, shading="auto")
    cs = a.contour(Cs, ths, share, levels=[0.5, 0.9], colors="k", linewidths=1); a.clabel(cs, fmt={0.5: "kT/C 50 %", 0.9: "kT/C 90 %"}, fontsize=8)
    drift = ILEAK[T] * TT / (CC * 1e-15); a.contour(Cs, ths, drift / np.sqrt(k * Tk / (CC * 1e-15)), levels=[1], colors="w", linestyles="--")
    a.axvspan(0.3, 0.963, color="k", alpha=0.35); a.text(0.33, 3e-6, "no alcanzable\n(< 0,96 fF)", color="w", fontsize=8)
    a.plot([0.963, 2.959, 10.0], [330e-6, 54e-6, 34e-6] if T == 27 else [25e-6, 6.7e-6, np.nan], "ko-", ms=4)
    a.set_xscale("log"); a.set_yscale("log"); a.set_xlabel("capacidad del nodo de puerta (fF)"); a.set_title(f"{T} °C (fuga del modelo: {ILEAK[T]*1e15:g} fA)")
ax[0].set_ylabel("tiempo de retención = conversión (s)")
fig.legend(handles=[plt.Rectangle((0, 0), 1, 1, color=c) for c in ["#4c9f70", "#8d99ae", "#d1495b", "#edae49"]], labels=names, loc="lower center", ncol=4, fontsize=8)
fig.suptitle("XC-58: término dominante de la varianza. Blanco a trazos: deriva por fuga = sigma. Puntos: conversiones simuladas", fontsize=9)
fig.tight_layout(rect=(0, 0.06, 1, 0.95)); fig.savefig("c58_mapa.png", dpi=130)
