#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Reads the conversion times of shot_trnoise.log and prints their spread."""
import re, statistics as st
t = [float(x) for x in re.findall(r"^SHOT \d+ ([0-9.eE+-]+)\s*$", open("shot_trnoise.log").read(), re.M)]
conv = [x - (k * 40e-6 + 3e-6) for k, x in enumerate(t)]   # release of conversion k is at k * 40 us + 3 us
m, s = st.mean(conv), st.stdev(conv)
print(f"conversions: {len(conv)}")
print(f"mean {m*1e6:.3f} us, standard deviation {s*1e9:.1f} ns, relative {100*s/m:.3f} %")
print(f"uncertainty of that spread from the sample size: about {100/ (2*(len(conv)-1))**0.5:.0f} % of its value")
print(f"first conversion {conv[0]*1e6:.3f} us, last {conv[-1]*1e6:.3f} us")
