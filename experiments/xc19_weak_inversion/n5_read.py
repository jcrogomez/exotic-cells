#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Reads the Monte Carlo of block N5 from n5_mc.log (the per-draw measurements ta, te at VDD and ua, ue at VDD + 10 mV)."""
import re, statistics as st
vals = re.findall(r"^(ta|te|ua|ue)\s+=\s+([0-9.eE+-]+)", open("n5_mc.log").read(), re.M)
draws, cur = [], {}
for k, v in vals:
    cur[k] = float(v) - 100e-9
    if k == "ue":
        if len(cur) == 4:
            draws.append(cur)
        cur = {}
chg = [((d["ua"] / d["ue"]) / (d["ta"] / d["te"]) - 1) * 100 for d in draws]
single = [(d["ua"] / d["ta"] - 1) * 100 for d in draws]
ratio = [d["ta"] / d["te"] for d in draws]
t = sorted(d["ta"] * 1e6 for d in draws)
n = len(draws)
over = sum(1 for c in chg if abs(c) > 0.4)
print(f"draws: {n}")
print(f"discharge time of one stage: min {t[0]:.1f} us, median {t[n//2]:.1f} us, max {t[-1]:.1f} us")
print(f"DUT/twin time ratio: min {min(ratio):.2f}, max {max(ratio):.2f}")
print(f"one stage, change for +10 mV of supply: median {st.median(single):.2f} %")
print(f"DUT/twin ratio, change for +10 mV: median |.| {st.median(abs(c) for c in chg):.3f} %, max |.| {max(abs(c) for c in chg):.3f} %")
print(f"pairs above the 0.4 % limit: {over} of {n} ({100*over/n:.0f} %)")
