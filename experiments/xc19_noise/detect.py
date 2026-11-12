#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""N8b/N8c: can the reader see a two-level telegraph signal? Behavioural simulation, fixed seed, standard library only.

Signal: two levels 0 and S (per cent of the conversion time), exponential dwell times of mean tau conversions in each level.
Noise: Gaussian, sigma per conversion (shot noise of the discharge); sigma*sqrt(2) when read against an equally noisy twin.
Detector: moving average of M conversions, Schmitt trigger at S/4 and 3S/4. M is fixed beforehand as the smallest
integer with S >= 5 sigma / sqrt(M).
A true transition counts as detected if the detector switches the same way before the next true transition and within
3 M + 3 conversions. Every other detector switch is a false event.
"""
import math, random
from collections import deque

def run(S, sigma, M, tau, n, rng):
    lo, hi = S / 4, 3 * S / 4
    level, state, win, acc = 0, 0, deque(), 0.0
    next_flip = rng.expovariate(1 / tau) if tau else float("inf")
    pending = None            # (direction, deadline) of the last undetected true transition
    true_n = det = false = 0
    for i in range(n):
        if i >= next_flip:
            level ^= 1
            next_flip = i + rng.expovariate(1 / tau)
            true_n += 1
            pending = (level, i + 3 * M + 3)
        x = level * S + rng.gauss(0, sigma)
        win.append(x); acc += x
        if len(win) > M:
            acc -= win.popleft()
        avg = acc / len(win)
        new = 1 if avg > hi else 0 if avg < lo else state
        if new != state:
            state = new
            if pending and pending[0] == new and i <= pending[1]:
                det += 1
            else:
                false += 1
            pending = None
        elif pending and i > pending[1]:
            pending = None
    return true_n, det, false

def table(name, S, sigma1, tconv_us, n=1_500_000):
    print(f"\n{name}: step {S} %, sigma per conversion {sigma1} %, {tconv_us} us per conversion")
    for label, sigma in (("reference", sigma1), ("twin", sigma1 * math.sqrt(2))):
        M = max(1, math.ceil((5 * sigma / S) ** 2))
        rng = random.Random(20261111)
        _, _, f0 = run(S, sigma, M, 0, n, rng)
        per_s = f0 / (n * tconv_us * 1e-6)
        print(f"  against {label}: sigma {sigma:.3f} %, M = {M}, single-conversion separation {S/sigma:.1f} sigma, "
              f"false events with no signal: {f0} in {n} conversions = {per_s:.2f} per second")
        print("     dwell [conversions]  dwell [ms]  transitions  detected [%]  false per second")
        for tau in (3, 10, 30, 100, 300, 1000, 3000):
            rng = random.Random(20261111 + tau)
            t, d, f = run(S, sigma, M, tau, n, rng)
            print(f"     {tau:8d}            {tau*tconv_us/1000:8.2f}   {t:9d}    {100*d/max(t,1):6.1f}       {f/(n*tconv_us*1e-6):8.2f}")

table("N8b  current working point (4 in series, 2.3 fF)", 0.83, 0.82, 30)
table("N8c  more current and capacitance (3 in series, 135 fF)", 0.80, 0.108, 25)
