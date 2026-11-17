#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Writes the decks of the supply transfer experiment. Pre-registration:
cells/preregistros/XC-19_2026-11-17_transferencia_alimentacion.md"""
CASES = {  # name: (Rs ohm, load source, C on node B in fF, max step)
    "q":    (1.85, "dc 0", 133, "10n"),
    "s1":   (1.85, "dc 1m", 133, "10n"),
    "s8":   (1.85, "dc 8m", 133, "10n"),
    "s1r5": (5.0,  "dc 1m", 133, "10n"),
    "m1":   (1.85, "pwl(0 0 15u 0 15.01u 1m)", 133, "10n"),
    "r1":   (1.85, "pulse(0 2m 0 1n 1n 9n 20n)", 133, "2n"),
    "uq":   (1.85, "dc 0", 266, "10n"),
    "u1":   (1.85, "pwl(0 0 36u 0 36.01u 1m)", 266, "10n"),
}
for name, (rs, load, cb, step) in CASES.items():
    open(f"st_{name}.sp", "w").write(f"""* Supply transfer, case {name}: Rs = {rs} ohm, load {load}, C(B) = {cb} fF. Extracted XC-19 channel, tt, 27 C.
.lib /pdk/libs.tech/ngspice/sky130.lib.spice tt
.include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice
.include ../../cells/xc19_channel/xc19_channel_lod.inc
.options gmin=1e-18 abstol=1e-18 reltol=1e-5
.temp 27
Vs vs 0 1.8
Rs vs vdd {rs}
Iload vdd 0 {load}
Vctl ctl 0 pulse(0 1 100n 1n 1n 1 2)
Bpre pre 0 V = v(vdd)*v(ctl)
X1 vdd 0 vdd pre xa pre xb xc19_channel_lod
Ca xa 0 133f
Cb xb 0 {cb}f
Xia xa 0 0 vdd vdd oa sky130_fd_sc_hd__inv_1
Xib xb 0 0 vdd vdd ob sky130_fd_sc_hd__inv_1
.control
tran {step} 130u 0 {step}
meas tran ta when v(oa)=0.9 rise=1
meas tran tb when v(ob)=0.9 rise=1
meas tran vmin min v(vdd) from=1u to=100u
echo STRANS {name} $&ta $&tb $&vmin
quit
.endc
.end
""")
