#!/usr/bin/env python3
"""Cantidades derivadas (las que citan README/INFORME/PREREG) en A y en B para los decks que cambian."""
import re, os, sys
S = os.path.dirname(os.path.abspath(__file__))
def L(mode, path, tag):
    p = os.path.join(S, mode, "repo", path)
    return [l for l in open(p, errors="replace").read().splitlines() if l.startswith(tag)]
def kv(line):
    return {k: float(v) for k, v in re.findall(r"(\w+)=([-+0-9.eE]+)", line)}
def nums(line):
    return [float(x) for x in line.split()[1:]]
out = []
def row(name, a, b, fmt="{:.4g}"):
    rel = (b - a) / a * 100 if a else float("nan")
    out.append(f"| {name} | {fmt.format(a)} | {fmt.format(b)} | {rel:+.2f} % |")
for m in ("A", "B"): pass
R = {}
for m in ("A", "B"):
    d = {}
    ch = nums(L(m, "cells/xc19_bias/channel.hsa_%s.log" % m, "CHANNEL ")[-1])
    d["bias4_vb"], d["bias4_t"], d["bias4_step"] = ch[4], ch[0] * 1e6, (ch[0] - ch[1]) / ch[0] * 100
    d["bias3_vb"], d["bias3_t"], d["bias3_step"] = ch[5], ch[2] * 1e6, (ch[2] - ch[3]) / ch[2] * 100
    cs = nums(L(m, "cells/xc19_channel/channel_sim.hsa_%s.log" % m, "CHSIM ")[-1])
    d["ch_t"], d["ch_AB"], d["ch_stage10"], d["ch_ratio10"] = cs[0] * 1e6, abs(cs[0] - cs[1]) / cs[0], (cs[2] - cs[0]) / cs[0] * 100, abs(cs[0] / cs[1] - cs[2] / cs[3])
    mo = nums(L(m, "cells/xc19_channel/explore_moscap.hsa_%s.log" % m, "MOSCAP ")[-1])
    d["mos4x4_t"], d["mos4x4_ratio"] = mo[0] * 1e6, mo[0] / mo[1]
    po = nums(L(m, "cells/xc19_read/post_layout.hsa_%s.log" % m, "POST ")[-1])
    d["read_ta"], d["read_tm"], d["read_tc"], d["read_tm_tc"] = po[0] * 1e6, po[4] * 1e6, po[2] * 1e6, po[4] / po[2]
    for l in L(m, "experiments/xc19_caps/moscap.hsa_%s.log" % m, "RES MOSCAP"):
        k = kv(l)
        if abs(k["wc"] - 4.3) < 1e-9:
            d["C1_tmos"], d["C1_rel"], d["C6_mim_rel"], d["C4_step_mos"] = k["t_mos"] * 1e6, (k["t_mos"] / k["t_ideal"] - 1) * 100, (k["t_mim8"] / k["t_ideal"] - 1) * 100, k["step_mos_pct"]
    pn = kv([l for l in L(m, "experiments/xc19_caps/post.hsa_%s.log" % m, "RES POST new")][-1])
    po2 = kv([l for l in L(m, "experiments/xc19_caps/post.hsa_%s.log" % m, "RES POST old")][-1])
    d["C2_post_t"] = pn["new_tA"] * 1e6
    d["C2_vs_29p3"] = (pn["new_tA"] / 29.3e-6 - 1) * 100
    d["C2_vs_ideal"] = (pn["new_tA"] / po2["old_ideal_tA"] - 1) * 100
    d["C3_AB"] = (pn["new_tB"] - pn["new_tA"]) / pn["new_tA"] * 100
    d["C4_step_post"] = (pn["new_tA"] - pn["new_tA_step"]) / pn["new_tA"] * 100
    d["stage10_new"] = (pn["new_tA_1v81"] / pn["new_tA"] - 1) * 100
    f = {kv(l)["cf"]: kv(l) for l in L(m, "experiments/xc19_caps/filt.hsa_%s.log" % m, "RES FILT")}
    for cf, nm in ((1e-18, "none"), (1e-12, "1p"), (2e-12, "2p"), (5e-12, "5p"), (10e-12, "10p")):
        k = f[min(f, key=lambda x: abs(x - cf))]
        d[f"C10_kick_{nm}_mV"] = k["kick_async_max"] * 1e3
        d[f"C11_inter_{nm}_pct"] = (k["tA_async"] - k["tA_alone"]) / k["tA_alone"] * 100
    cal = {}
    for l in L(m, "experiments/xc19_caps/cal.hsa_%s.log" % m, "RES CAL"):
        c = re.search(r"case=(\w+)", l).group(1); cal[c] = kv(l)
    t0 = cal["s0"]["tA"]
    for c in ("r2", "r10", "r20", "f2", "f10", "f20"):
        d[f"C13_{c}_pct"] = (cal[c]["tA"] - t0) / t0 * 100
    d["C14_change_pct"] = (d["C13_r20_pct"] / d["C13_r2_pct"] - 1) * 100
    sw = kv(L(m, "experiments/xc19_caps/sw.hsa_%s.log" % m, "RES SW")[-1])
    d["sw_p_pct"], d["sw_tg_pct"] = sw["p_pct"], sw["tg_pct"]
    for l in L(m, "experiments/xc19_caps/sw_current.hsa_%s.log" % m, "RES SWI"):
        off = re.search(r"offset=(\S+)", l).group(1); k = kv(l)
        d[f"swi_{off}_t0"], d[f"swi_{off}_sw"], d[f"swi_{off}_inj"], d[f"swi_{off}_step"] = k["t0"] * 1e6, k["sw_pct"], k["inj_pct"], k["step_pct"]
    a = kv(L(m, "experiments/xc19_caps/async.hsa_%s.log" % m, "RES ASYNC")[-1])
    d["async_change_pct"] = a["change_pct"]
    v = kv(L(m, "experiments/xc19_caps/vb_ac.hsa_%s.log" % m, "RES VBAC")[-1])
    d["vb_R_kohm"], d["vb_C_pF"] = v["R_lowf"] / 1e3, v["C_at_1MHz"] * 1e12
    d["vb_tau_us"] = v["R_lowf"] * v["C_at_1MHz"] * 1e6
    R[m] = d
print("| cantidad | A (guardado) | B (hsa) | B/A − 1 |\n|---|---|---|---|")
for k in R["A"]:
    a, b = R["A"][k], R["B"][k]
    rel = (b - a) / abs(a) * 100 if a else float("nan")
    print(f"| `{k}` | {a:.6g} | {b:.6g} | {rel:+.3f} % |")
