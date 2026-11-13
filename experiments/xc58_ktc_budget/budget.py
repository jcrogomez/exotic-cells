#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""XC-58, arithmetic only: kT/C noise sampled on the GATE of the XC-19 reader against the reader's own noise.
Inputs from this repository: reader gain 0.83 % per 0.305 mV, shot noise 0.55 % per conversion, node X of 2.3 fF,
about 0.9 V of swing on X (assumed), 30 us per conversion."""
import numpy as np
k = 1.380649e-23
gain = 0.83 / 0.305            # % of discharge time per mV on the gate
shot = 0.55                    # % per conversion (experiments/xc19_noise)
def sig_mV(C_fF, T=300.0): return np.sqrt(k * T / (C_fF * 1e-15)) * 1e3
x_reset = sig_mV(2.3) / 900.0 * 100      # kT/C of the precharge on node X, as % of the swing
print(f"kT/C already present on node X (2.3 fF) at each precharge: {sig_mV(2.3):.2f} mV = {x_reset:.2f} % of a 0.9 V swing (assumed swing)")
floor = np.hypot(shot, x_reset)
print(f"reader floor per conversion: shot {shot:.2f} %  (+) reset {x_reset:.2f} %  = {floor:.2f} %\n")
print("gate-node C   sigma_V     as time spread   total spread   kT/C share of variance")
for C in (0.5, 1, 2.3, 5, 10, 30, 100, 300):
    s = sig_mV(C) * gain; tot = np.hypot(s, floor)
    print(f"  {C:6.1f} fF   {sig_mV(C):5.2f} mV   {s:6.2f} %         {tot:6.2f} %        {100*s*s/tot/tot:5.1f} %")
print("\nconversions to know the variance to 1 % (Gaussian): N = 2/0.01^2 =", int(2 / 0.01 ** 2), "-> about", 2 / 0.01 ** 2 * 30e-6, "s at 30 us each")
print("temperature step that changes the variance by 1 %: 3 K at 300 K (variance is proportional to T)")
