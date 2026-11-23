#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Números que cita PREREG de la etapa 2, calculados con código antes de congelar (hueco 3 de la skill preregistro).
Solo aritmética sobre datos ya en el repo; no corre el experimento."""
import math, re
L = open("../attack_xc60_62_63/c62_litho.txt").read().splitlines()
out = []
st = None
for l in L:
    if l.startswith("NA "): st = l.split(" umbral")[0]
    if l.strip().startswith("nb2_021_longcap") and st and "L(0) " not in l:
        w = float(l.split()[1]); out.append(f"A (c62, sin OPC) {st}: L centro densa 0,21 x3 = {w:.3f} -> cociente R_densa/R_aislada = {0.150/w:.3f}")
s_mm = 17.3                                   # mV, docs/CLAIMS.md (0.42/0.15)
for n in (8, 16, 24, 32):
    out.append(f"R2 n={n}: desajuste del peine {s_mm/math.sqrt(n):.2f} mV; de la diferencia peine-referencia (ambos n) {math.sqrt(2)*s_mm/math.sqrt(n):.2f} mV")
nmin = math.ceil(2 * (s_mm / 5.0) ** 2)
out.append(f"R2: n mínimo para que la diferencia baje de 5 mV: {nmin}")
out.append(f"R1 línea 0,15 x 30 um a 48,2 ohm/cuadro: {30/0.15:.0f} cuadros, {30/0.15*48.2/1e3:.2f} kohm")
for sr in (0.1, 0.3, 1.0, 3.0):
    out.append(f"R1 sigma_R {sr}% por línea -> sigma del cociente {math.sqrt(2)*sr:.3f}%")
out.append(f"testigo R1 (C, impreso = dibujado): 0,150 / 0,160 = {0.150/0.160:.4f}")
out.append(f"techo de información sobre la clase de OPC (3 clases equiprobables): {math.log2(3):.4f} bits")
open("prereg_calc.txt", "w").write("\n".join(out) + "\n"); print("\n".join(out))
