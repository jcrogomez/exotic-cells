#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Decks for the night plan of 2026-11-11 (cells/preregistros/PLAN_2026-11-11_noche.md), blocks N3, N4 and N5.

n3_cap_<pF>.sp        kickback on the bias node against the filter capacitor
n3_cascode_<mV>.sp    DUT and long twin, each under a cascode whose gate is the next tap of the chain
n4_cross.sp           the two LOD audit transistors (annotated) read by the stage
n5_mc.sp              DUT against an identical twin, 100 mismatch draws, at VDD and VDD + 10 mV
"""
N, Pm = "sky130_fd_pr__nfet_01v8", "sky130_fd_pr__pfet_01v8"
HV = Pm + "_hvt w=0.42 l=0.5"
OPT = ".options gmin=1e-18 abstol=1e-18 reltol=1e-5"
INV = ".include /pdk/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice"

def head(corner="tt"):
    return [f".lib /pdk/libs.tech/ngspice/sky130.lib.spice {corner}", INV, OPT, ".temp 27"]

def chain(cf="1p", ccas=None):
    """V2 chain, K = 4: vdd - c1 - c2 - vb - gnd; bottom = 16 x DUT."""
    L = [f"Xc0 vdd vdd c1 0 {N} w=1 l=1", f"Xc1 c1 c1 c2 0 {N} w=1 l=1", f"Xc2 c2 c2 vb 0 {N} w=1 l=1",
         f"Xc3 vb vb 0 0 {N} w=0.42 l=0.15 m=16", f"Cf vb 0 {cf}"]
    if ccas:
        L.append(f"Cc c2 0 {ccas}")
    return L

def stage(tag, gate, dut, cascode=False):
    """dut: text after the node list, e.g. 'sky130..nfet w=.. l=..' with nodes d g s b supplied here."""
    d = f"m{tag}" if cascode else f"x{tag}"
    L = [f"Xp{tag} x{tag} pre vdd vdd {HV}", f"Xd{tag} {d} {gate} 0 0 {dut}",
         f"Xi{tag} x{tag} 0 0 vdd vdd y{tag} sky130_fd_sc_hd__inv_1"]
    if cascode:
        L.append(f"Xk{tag} x{tag} c2 {d} 0 {N} w=0.42 l=0.15")
    return L

PRE = ["Vctl ctl 0 pulse(0 1 100n 1n 1n 1 2)", "Bpre pre 0 V = v(vdd)*v(ctl)"]
def meas(tags, vdd=1.8):
    return [f"meas tran t{t} when v(y{t})={vdd/2} rise=1" for t in tags]

DUT, TWIN = f"{N} w=0.42 l=0.15", f"{N} w=4.2 l=1.5"

# N3a: capacitor sweep (no cascode)
for c in (1, 10, 30):
    L = [f"* N3: kickback, filter capacitor {c} pF"] + head() + ["Vdd vdd 0 1.8"] + PRE + chain(f"{c}p") + stage("a", "vb", DUT)
    L += [".control", "tran 10n 200u"] + meas("a") + ["let vb0 = v(vb)[0]", "meas tran vbmin min v(vb)",
          f"echo N3CAP {c} $&ta $&vb0 $&vbmin", "quit", ".endc", ".end"]
    open(f"n3_cap_{c}.sp", "w").write("\n".join(L) + "\n")

# N3b: cascode, with emulated step and long twin, at two supplies
for vdd in (1.80, 1.81):
    L = [f"* N3: cascode, VDD = {vdd}"] + head() + [f"Vdd vdd 0 {vdd}", "Vstep vbs vb 0.305m"] + PRE + chain("1p", "1p")
    L += stage("a", "vb", DUT, True) + stage("b", "vbs", DUT, True) + stage("w", "vb", TWIN, True)
    L += [".control", "tran 10n 300u"] + meas("abw", vdd) + ["let vb0 = v(vb)[0]", "meas tran vbmin min v(vb)", "meas tran vbmax max v(vb)",
          "let c20 = v(c2)[0]", "meas tran c2min min v(c2)", "meas tran mamax max v(ma) from=1u to=20u",
          f"echo N3CAS {vdd} $&ta $&tb $&tw $&vb0 $&vbmin $&vbmax $&c20 $&c2min $&mamax", "quit", ".endc", ".end"]
    open(f"n3_cascode_{int(vdd*1000)}.sp", "w").write("\n".join(L) + "\n")

# N4: LOD pair through the stage
L = ["* N4: the LOD audit transistors, annotated, read by the XC-19 stage"] + head() + ["Vdd vdd 0 1.8"] + PRE + chain("30p")
L += [".include ../lod_audit/sim/lod_annotated.inc", ".include ../lod_audit/lod_sa030.spice", ".include ../lod_audit/lod_sa300.spice"]
for tag, sub in (("s", "lod_sa030_lod"), ("l", "lod_sa300_lod"), ("p", "lod_sa030"), ("q", "lod_sa300")):
    L += [f"Xp{tag} x{tag} pre vdd vdd {HV}", f"Xd{tag} 0 x{tag} vb 0 {sub}", f"Xi{tag} x{tag} 0 0 vdd vdd y{tag} sky130_fd_sc_hd__inv_1"]
L += [".control", "tran 10n 400u"] + meas("slpq") + ["echo N4 $&ts $&tl $&tp $&tq", "quit", ".endc", ".end"]
open("n4_cross.sp", "w").write("\n".join(L) + "\n")

# N5: Monte Carlo of mismatch, identical twin, two supplies per draw
L = ["* N5: mismatch Monte Carlo, DUT against an identical twin, VDD and VDD + 10 mV on the same draw"] + head("tt_mm")
L += ["Vdd vdd 0 1.8"] + PRE + chain("30p") + stage("a", "vb", DUT) + stage("e", "vb", DUT)
L += [".control", "set rndseed=20261111", "let i = 0", "while i < 100", "  reset", "  alter Vdd dc = 1.8", "  tran 20n 400u",
      "  meas tran ta when v(ya)=0.9 rise=1", "  meas tran te when v(ye)=0.9 rise=1", "  echo N5A $&ta $&te",
      "  alter Vdd dc = 1.81", "  tran 20n 400u", "  meas tran ua when v(ya)=0.905 rise=1", "  meas tran ue when v(ye)=0.905 rise=1",
      "  echo N5B $&ua $&ue", "  let i = i + 1", "end", "quit", ".endc", ".end"]
open("n5_mc.sp", "w").write("\n".join(L) + "\n")
