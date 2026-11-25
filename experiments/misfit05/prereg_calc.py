"""MISFIT-05: numeros de las predicciones, calculados ANTES de correr, solo con datos ya en el repo.
Entrada: experiments/xc19_slot_e2/diseno/contrato.txt (macro v_hm, contrato vigente). Salida: prereg_calc.txt"""
import math, os, re
H = os.path.dirname(os.path.abspath(__file__))
R = {}
for l in open(os.path.join(H, "..", "xc19_slot_e2", "diseno", "contrato.txt")):
    f = l.split()
    if len(f) < 4 or f[0] != "RES": continue
    for kv in f[3:]:
        if "=" in kv:
            k, v = kv.split("=", 1)
            try: R[(f[1], f[2], k)] = float(v)
            except ValueError: pass
T0, WIN = 1e-6, 1.4e-3
out = ["# MISFIT-05 prereg_calc: de contrato.txt (v_hm). tA desde T0 = 1 us."]
for c, t in (("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85")):
    ta = R[(c, t, "h01_oa")] - T0; vb = R[(c, t, "vb")]
    trap = (R[(c, t, "t01_oa")] - R[(c, t, "h01_oa")]) / ta * 100
    # fuga de la rama DUT con su interruptor abierto, ya en el repo: caida de XA en 1,4 ms con DUT (h00) menos sin DUT (f6)
    d = R[(c, t, "f6_XA_min")] - R[(c, t, "h00_XA_min")]
    obs = (d / (WIN - T0)) / (0.9 / ta)                      # cociente de pendientes = L/I aproximado
    cota = [2 * math.exp(-vb / n) for n in (0.037, 0.047)]   # interruptor 0,84 a Vgs = 0 frente a DUT 0,42 a Vgs = VB
    out.append(f"{c} {t}: tA = {ta*1e6:.3f} us; VB = {vb:.4f} V; trampa = {trap:.3f} %; "
               f"L/I por rama abierta: de h00-f6 = {obs:.2e} (caida {d*1e3:.2f} mV); cota subumbral = {cota[0]:.1e}..{cota[1]:.1e}; "
               f"15 ramas, con el mayor de los tres = {15*max(obs, *cota)*100:.3f} %")
open(os.path.join(H, "prereg_calc.txt"), "w").write("\n".join(out) + "\n"); print("\n".join(out))
