#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Exploratory decks, written AFTER the pre-registered run (not covered by its predictions).

explore_twin_<vdd mV>.sp  K = 4 stage without the 4.2/1.5 twin, with a long high-threshold precharge device, and two
                          other twins: an identical 0.42/0.15 device whose gate is 17 mV lower (one sigma of mismatch),
                          and 16 identical devices in parallel.
explore_leak_<T>.sp       off-state current of other precharge devices.
noise_spectrum_K<k>.sp    bias-node noise spectrum written to a file, to integrate it independently.
"""
from gen_stage import HEAD, chain, stage, N, Pm
for vdd in (1.80, 1.81):
    L = [f"* exploratory twins, K = 4, VDD = {vdd}"] + HEAD + [".temp 27", f"Vdd vdd 0 {vdd}",
         f"Vpre pre 0 pulse(0 {vdd} 100n 1n 1n 1 2)", "Vmis vbm vb -17m"]
    L += chain(4) + stage("a", "vb", "w=0.42 l=0.15") + stage("e", "vbm", "w=0.42 l=0.15") + stage("m", "vb", "w=0.42 l=0.15 m=16")
    L += [".control", "tran 10n 200u"] + [f"meas tran t{t} when v(y{t})={vdd/2} rise=1" for t in "aem"]
    L += ["meas tran vbmin min v(vb)", "meas tran vbmax max v(vb)", "let vb0 = v(vb)[0]",
          f"echo EXPLORE {vdd} $&ta $&te $&tm $&vb0 $&vbmin $&vbmax", "quit", ".endc", ".end"]
    open(f"explore_twin_{int(vdd*1000)}.sp", "w").write("\n".join(L) + "\n")
for T in (27, 85):
    L = [f"* precharge alternatives, {T} C"] + HEAD + [f".temp {T}", "Vdd vdd 0 1.8", "Vx x 0 0.9"]
    devs = (("pfet_L015", Pm, "w=0.42 l=0.15"), ("pfet_L050", Pm, "w=0.42 l=0.5"),
            ("hvt_L015", Pm + "_hvt", "w=0.42 l=0.15"), ("hvt_L050", Pm + "_hvt", "w=0.42 l=0.5"))
    ctl = [".control", "op"]
    for name, model, geo in devs:
        L += [f"V{name} x{name} 0 0.9", f"X{name} x{name} vdd vdd vdd {model} {geo}"]
        ctl += [f"let il = i(V{name})", f"echo XLEAK {T} {name} $&il"]
    open(f"explore_leak_{T}.sp", "w").write("\n".join(L + ctl + ["quit", ".endc", ".end"]) + "\n")
for K in (4, 5):
    L = [f"* bias noise spectrum, K = {K}"] + HEAD + [".temp 27", "Vdd vdd 0 1.8 ac 1"] + chain(K)
    L += [".control", "noise v(vb) Vdd dec 20 1 1e6", "setplot noise1", f"wrdata noise_spectrum_K{K}.dat onoise_spectrum", "quit", ".endc", ".end"]
    open(f"noise_spectrum_K{K}.sp", "w").write("\n".join(L) + "\n")
