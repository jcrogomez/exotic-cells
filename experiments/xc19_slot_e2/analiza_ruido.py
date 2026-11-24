"""MISFIT-03 enmienda 2 (sellada 2026-11-24 09:46:20), C4: ruido de disparo en transitorio. Salida: ruido.txt
Entradas: ruido/R{0,1,3,1p}/ruido.log, lineas 'RN <repeticion> <instancia> <tA> <tB>' (absolutos; T0 = 1 us).
Reglas (enmienda 2, C4):
  N1 sigma de ln(tA/tB) entre muestras, R1, en [0,115, 0,195] %
  N2 igual en R1' (src = 01)
  N3 testigo: sigma(R3) / sigma(R1) en [2,4, 3,6]
  N4 control: R0 da sigma = 0 (todas las muestras iguales a 1e-6 relativo) e iguales al h11 nominal dentro de 0,01 %
  Se reporta sin prediccion: abs(trampa nominal) / sigma(ln tA, R1'), la SNR de la trampa en un disparo
  Invalido si falla N3 o N4. Se reporta N real de cada deck (los decks se cortaron por memoria y se volvieron a correr)
"""
import os, re
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
T0 = 1e-6
H11 = (32.6407e-6, 32.6370e-6)          # contrato a2 tt 27, absolutos
H01 = (31.8732e-6, 31.8689e-6)
TRAP = 0.8085e-2                        # abs(trampa nominal) tt 27, contrato a2


def lee(d):
    r = []
    for ln in open(os.path.join(HERE, "ruido", d, "ruido.log"), errors="replace"):
        m = re.match(r"RN (\d+) (\d+) (\S+) (\S+)\s*$", ln)
        if m:
            try:
                r.append((float(m[3]) - T0, float(m[4]) - T0))
            except ValueError:
                pass
    return np.array(r)


out = []; p = out.append
p("# MISFIT-03 enmienda 2, C4 (ruido de disparo, tt 27). Tiempos desde T0 = 1 us. sigma en %.")
S = {}
for d in ("R0", "R1", "R3", "R1p"):
    x = lee(d)
    if len(x) == 0:
        p(f"{d}: sin muestras"); continue
    lr = np.log(x[:, 0] / x[:, 1]); S[d] = (lr.std(ddof=1) * 100 if len(x) > 1 else np.nan, len(x), x)
    p(f"{d}: N = {len(x)} (se esperan 64); sigma ln(tA/tB) = {S[d][0]:.4f} %; sigma ln tA = {np.log(x[:, 0]).std(ddof=1)*100:.4f} %; "
      f"media tA = {x[:, 0].mean()*1e6:.4f} us")
if "R0" in S:
    x = S["R0"][2]
    sp = max(np.ptp(x[:, 0]) / x[:, 0].mean(), np.ptp(x[:, 1]) / x[:, 1].mean())
    dn = max(abs(x[:, 0].mean() - (H11[0] - T0)) / (H11[0] - T0), abs(x[:, 1].mean() - (H11[1] - T0)) / (H11[1] - T0))
    p(f"N4: R0 rango relativo entre muestras {sp:.2e} (<= 1e-6) y distancia al h11 nominal {dn*100:.4f} % (<= 0,01 %) -> "
      f"{'cumplida' if sp <= 1e-6 and dn <= 1e-4 else 'FALSA'}")
for d, n in (("R1", "N1"), ("R1p", "N2")):
    if d in S:
        s = S[d][0]; p(f"{n}: sigma {d} = {s:.4f} % en [0,115, 0,195] -> {'cumplida' if 0.115 <= s <= 0.195 else 'FALSA'} (N = {S[d][1]})")
if "R1" in S and "R3" in S:
    q = S["R3"][0] / S["R1"][0]; p(f"N3: sigma(R3)/sigma(R1) = {q:.3f} en [2,4, 3,6] -> {'cumplida' if 2.4 <= q <= 3.6 else 'FALSA'}")
if "R1p" in S:
    sa = np.log(S["R1p"][2][:, 0]).std(ddof=1)
    p(f"SNR de la trampa en un disparo (R1', una rama): {TRAP:.4%} / {sa:.4%} = {TRAP/sa:.2f}")
open(os.path.join(HERE, "ruido.txt"), "w").write("\n".join(out) + "\n"); print("\n".join(out))
