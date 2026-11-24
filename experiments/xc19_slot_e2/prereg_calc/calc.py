"""MISFIT-03 enmienda 2: numeros de prediccion calculados antes de congelar (regla 3 de la skill). Salida: calc.txt
Entradas, todas de archivos del repo:
  C_X (capacidad del nodo, pequena senal) 151 fF: experiments/xc19_slot_e2/calc/diag_c (0,53 fF ideal -> 0,3503 % => C = 0,53/0,003503)
  dV = 1,8 - 0,9 V (precarga a VDD, cruce del inversor del macro a ~0,9 V; INFORME_etapa_a §2: conmuta con X = 0,896 V)
  sigma_Vth de un nfet 0,42/0,15: 17,3 mV (experiments/lod_audit/README.md, tt_mm, 300 tiradas)
  n (pendiente de subumbral): [?] no medida en el repo para este punto; se usa el intervalo 1,3-1,6 y se reporta el intervalo"""
import math
q, kB = 1.602e-19, 1.381e-23
out = []
C = 0.53e-15 / 0.003503; dV = 1.8 - 0.896
Q = C * dV
s1 = math.sqrt(q / Q)                     # ruido de disparo, una rama: Var(int i dt) = q I t  (PSD unilateral 2qI)
out.append(f"C_X = {C*1e15:.1f} fF, Q = {Q*1e15:.1f} fC, N = Q/q = {Q/q:.0f} electrones")
out.append(f"disparo, una rama: sigma_t/t = sqrt(q/Q) = {s1*100:.4f} %")
out.append(f"disparo, cociente A/B (dos ramas independientes): {math.sqrt(2)*s1*100:.4f} %")
for T in (300.15, 233.15, 358.15):
    kTC = math.sqrt(kB * T / C)
    out.append(f"kT/C al soltar la precarga, {T-273.15:.0f} C: {kTC*1e3:.3f} mV -> {kTC/dV*100:.4f} % por rama")
for n in (1.3, 1.6):
    for T in (300.15,):
        Ut = kB * T / q
        sl = 17.3e-3 / (n * Ut)
        out.append(f"desajuste DUT/gemelo, n = {n}: sigma ln(I) por dispositivo = {sl:.3f}; sigma ln(tA/tB) = {math.sqrt(2)*sl:.3f}"
                   f" (x{math.exp(math.sqrt(2)*sl):.2f} a 1 sigma)")
open("calc.txt", "w").write("\n".join(out) + "\n"); print("\n".join(out))
