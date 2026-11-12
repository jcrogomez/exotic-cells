#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""XC-19 budget from the DC sweeps (dc_27.dat, dc_28.dat). Prints the table used in README.md."""
import math
q, kT = 1.602e-19, 0.025852 * 300.15 / 300.0
def load(f):
    rows = []
    for line in open(f):
        v = [float(x) for x in line.split()]
        rows.append((v[0], v[1], v[3], v[5], v[7], v[9]))  # vg, Ia, Ib, Ic, Id, Iw
    return rows
r27, r28 = load("dc_27.dat"), load("dc_28.dat")
C, DV, STEP = 10e-15, 0.9, 0.305e-3
print("Vg[V]  I[A]      n     step[%]  TC[%/K]  ratioTC[%/K]  dI/dVd[%/mV]  t(10fF)[s]  tau5sigma[s]  Iw[A]")
for i, (a, b) in enumerate(zip(r27, r28)):
    vg, Ia, Ib, Ic, Id, Iw = a
    n = float("nan")
    if i + 1 < len(r27):
        n = (r27[i + 1][0] - vg) / (kT * math.log(r27[i + 1][1] / Ia))
    step = (Ib / Ia - 1) * 100
    tc = (b[1] / Ia - 1) * 100
    ratio_tc = ((b[3] / b[1]) / (Ic / Ia) - 1) * 100
    dibl = (Id / Ia - 1) * 100 / 10
    t1 = C * DV / Ia
    tau = (5 / (step / 100)) ** 2 * q / Ia
    print(f"{vg:4.2f}  {Ia:9.3e} {n:5.2f}  {step:6.3f}  {tc:7.2f}  {ratio_tc:8.3f}     {dibl:8.4f}     {t1:9.2e}  {tau:9.2e}   {Iw:9.3e}")
