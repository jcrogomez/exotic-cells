#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""DUT current per corner, temperature and chain length K, from bias.txt. Usable = 3.2 pA .. 40 nA."""
LO, HI = 3.2e-12, 40e-9
d = {}
for l in open("bias.txt"):
    _, c, T, var, K, sup, vb, i = l.split()
    d[(c, int(T), var, int(K), sup)] = (float(vb), float(i))
for var in ("v1", "v2"):
    print(var, "DUT current [A]; * = usable")
    print("corner  T   " + "".join(f"K={K:<10d}" for K in range(3, 9)) + "usable K")
    for c in ("tt", "ss", "ff", "sf", "fs"):
        for T in (27, 85):
            row, ok = "", []
            for K in range(3, 9):
                i = d[(c, T, var, K, "vdd")][1]
                u = LO <= i <= HI
                ok += [K] if u else []
                row += f"{i:9.2e}{'*' if u else ' '}  "
            print(f"{c:6s} {T:3d}  {row}{ok}")
