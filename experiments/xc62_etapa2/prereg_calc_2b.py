#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Cuentas del prerregistro de la etapa 2b (convergencia). Solo lee explora_alcance.txt (EXPLORATORIO) y cuenta puntos y FFT.
No corre el modelo: la predicción sale de extrapolar la exploración, y se declara como tal."""
import re, math, time, itertools, numpy as np
print("prereg_calc_2b ·", time.strftime("%Y-%m-%d %H:%M:%S"))
rows = {}
for ln in open("explora_alcance.txt"):
    m = re.search(r"N=(\d+).*ns=(\d+).*a2 R1 s0.42: ([\d.]+) nm \| a3 densa: ([\d.]+) nm", ln)
    if m: rows[(int(m[1]), int(m[2]))] = (float(m[3]), float(m[4]))
print("exploración (NA 0,60 σ 0,8):", rows)
LADDER = (7, 13, 19, 25, 31, 37)
def npts(ns):
    s = np.linspace(-1, 1, ns); return sum(1 for a, b in itertools.product(s, s) if a * a + b * b <= 1.0001)
pts = {ns: npts(ns) for ns in LADDER}; print("puntos de fuente:", pts)
# predicción: a2 ~ C ns^-p ajustado a ns 7 y 13, extrapolado a 0,1 nm
for N in (1024, 2048):
    a7, a13 = rows[(N, 7)][0], rows[(N, 13)][0]
    p = math.log(a7 / a13) / math.log(13 / 7); ns01 = 13 * (a13 / 0.1) ** (1 / p)
    print(f"N={N}: p = {p:.2f}; a2 = 0,1 nm en ns ≈ {ns01:.1f} -> primer peldaño ≥: {min(x for x in LADDER if x >= ns01)}")
# coste: FFT medidas a las 19:30:34 en esta máquina (s por FFT); pupila ~ 1 FFT más por punto
tfft = {1024: 0.016, 2048: 0.065, 4096: 0.350}
NGEO, NSET = 6, 4
res = sum(pts[ns] * 2 * tfft[N] for ns in LADDER for N in (1024, 2048)) * NGEO * NSET
print(f"presupuesto de resolución estimado: escalera completa, {NGEO} geometrías × {NSET} ajustes = {res/3600:.2f} h")
aud_polar = 576 * 2 * tfft[2048] * NGEO * NSET * 2          # polar 12×48, y su mutante sigma 0,85
aud_dx = pts[37] * 2 * tfft[4096] * 3                       # dx 2,5 nm: G0, G1, G2 en un ajuste, peor caso ns = 37
print(f"auditoría estimada: polar + mutante {aud_polar/3600:.2f} h; dx 2,5 nm {aud_dx/3600:.2f} h")
# consecuencia para la etapa 2 (no es criterio): memoria del evaluador incremental crece con los puntos de fuente
print(f"memoria por forma del evaluador incremental: 0,22 GB a 29 puntos -> {0.22*pts[31]/29:.1f} GB a ns 31, {0.22*pts[37]/29:.1f} GB a ns 37")
print("tolerancia secundaria, R2: 0,5 nm × 1,8 mV/nm =", 0.5 * 1.8, "mV frente a σ de la diferencia 4,99 mV (n = 24, prereg_calc.txt)")
