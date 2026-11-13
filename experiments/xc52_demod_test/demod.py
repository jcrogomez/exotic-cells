#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Unit test of the four-state demodulator proposed for XC-52: which synthetic responses survive
D = (y++ - y+- - y-+ + y--)/4, with B = s1*B1 + s2*B2 ? Pure arithmetic, no physics claimed."""
import numpy as np
B1 = B2 = 1.0e-3                      # tesla per winding
I1 = I2 = 2.7e-3                      # ampere per winding
def D(y): return (y(+1, +1) - y(+1, -1) - y(-1, +1) + y(-1, -1)) / 4
def odd(y): return (y(+1, +1) - y(-1, -1)) / 2
B = lambda s1, s2: s1 * B1 + s2 * B2
cases = {
 "linear in B (Hall, induction)                 y = h*B":            lambda s1, s2: 1.0 * B(s1, s2),
 "quadratic in B (ordinary magnetoresistance)   y = a*B^2":          lambda s1, s2: 1.0 * B(s1, s2) ** 2,
 "spin-pair, saturating                         y = B^2/(B^2+B0^2), B0 = 0.5 mT": lambda s1, s2: B(s1, s2) ** 2 / (B(s1, s2) ** 2 + (0.5e-3) ** 2),
 "heat, separate windings                       y = c*(I1^2+I2^2)":  lambda s1, s2: (s1 * I1) ** 2 + (s2 * I2) ** 2,
 "heat, shared return resistance                y = c*(I1+I2)^2":    lambda s1, s2: (s1 * I1 + s2 * I2) ** 2,
 "electrical coupling, linear                   y = e1*V1 + e2*V2":  lambda s1, s2: 0.3 * s1 + 0.7 * s2,
 "electrical coupling, rectified product        y = g*V1*V2":        lambda s1, s2: 1.0 * s1 * s2,
 "bridge mismatch, static offset                y = y0":             lambda s1, s2: 1.0,
}
print(f"{'response':78s} {'D (product)':>13s} {'odd part':>11s}")
for k, y in cases.items(): print(f"{k:78s} {D(y):13.3e} {odd(y):11.3e}")
print("\nanalytic check: for y = a*B^2, D = 2*a*B1*B2 =", 2 * B1 * B2)
print("\nfield sweep, both windings equal (B1 = B2 = b): D of quadratic vs D of saturating, normalised at b = 0.25 mT")
q0 = s0 = None
for b in (0.25e-3, 0.5e-3, 1e-3, 2e-3):
    B1 = B2 = b
    q = D(lambda s1, s2: B(s1, s2) ** 2); s = D(lambda s1, s2: B(s1, s2) ** 2 / (B(s1, s2) ** 2 + (0.5e-3) ** 2))
    q0 = q0 or q; s0 = s0 or s
    print(f"  b = {b*1e3:4.2f} mT   quadratic x{q/q0:6.1f}   saturating x{s/s0:5.2f}")
