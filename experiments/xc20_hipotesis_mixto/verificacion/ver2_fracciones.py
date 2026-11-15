#!/usr/bin/env python3
"""Fracciones del prior que acotan lo que se puede saber (V4 y V1): bajo M, cuánto pesa el túnel frente al puente."""
import numpy as np
from ver2_modelo import params, i_dev, NDIM, VARIANTS
rng = np.random.default_rng(5)
for var in ('V1', 'V4'):
    p = params(rng.random((400000, NDIM)), var)
    V = np.full(400000, 1.8)
    it = i_dev(V, p, 'T', 27, 'd0') - i_dev(V, p, 'G', 27, 'd0')
    ir = i_dev(V, p, 'R', 27, 'd0') - i_dev(V, p, 'G', 27, 'd0')
    f = it / (it + ir)
    print(f"{var}: bajo M (sin excitador), fracción túnel a -1,8 V/27 C: P(f<0,01)={np.mean(f<0.01):.3f} "
          f"P(f<0,1)={np.mean(f<0.1):.3f} P(f>0,9)={np.mean(f>0.9):.3f} P(f>0,99)={np.mean(f>0.99):.3f}")
    # en d=0,27 el túnel de M es el mismo que el de T: firma independiente del puente
    itd = it / p['K']
    print(f"   t0/K en d=0,27: P(>1 nA)={np.mean(itd>1e-9):.3f}  P(>1,25 nA)={np.mean(itd>1.25e-9):.3f} "
          f"P(>150 fA)={np.mean(itd>150e-15):.3f}  P(>2 pA)={np.mean(itd>2e-12):.3f}")
