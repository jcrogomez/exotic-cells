# Claims and evidence

Every headline number in this repository, with the files that produce it. Grade: **run** = reproducible run here (model,
extraction or layout; never silicon so far); **arithmetic** = computed by hand from runs, with its assumptions; **estimate** =
depends on assumptions we have not checked. `tools/check_runs.py` fails if a committed log shows a known failure mode.
Environment of the runs: `experiments/manifest_2026-11-11.json`.

| Claim | Grade | Produced by | Result file |
|---|---|---|---|
| Magic's extraction omits `sa`/`sb`; two layouts differing only in diffusion length extract to the same transistor | run | `experiments/lod_audit/lod.tcl` | `lod_sa030.spice`, `lod_sa300.spice` |
| The model then separates them by 31.09 mV (W = 0.42 um); 44.1 mV at W = 5 um | run | `experiments/lod_audit/sim/lod_paso1.sp`, `end_to_end.sp` | `lod_paso1.log`, `end_to_end.log` |
| Mismatch sigma of threshold: 17.3 mV (0.42/0.15), 5.13 mV (5/0.15) | run | `experiments/lod_audit/sim/lod_paso4_mm.sp` | `lod_paso4_mm.log` |
| Irregular-diffusion formula is BSIM4 eq. 14.10; `SA`/`SB` not positive turns the stress effect off | source read (BSIM4.8.0 manual, section 14.2 and parameter table) | | `residual/README.md` |
| Annotator: 8 geometries and 12 rejections pass (an already-annotated netlist and a truncated `.ext` terminal added 2026-11-13) | run | `residual/tests/run.py` | CI workflow `tests` |
| 415 of 437 standard cells annotated; shorter diffusion side median 0.68 um | run | `experiments/stdcell_lod/extract_all.tcl`, `annotate_all.py` | `summary.txt`, `devices.csv` |
| `inv_1`: nfet +31.3 mV, pfet 88.5 mV lower in magnitude; rings 2.5 to 5.1 % faster when annotated | run | `experiments/stdcell_lod/devices_inv1.sp`, `rings.sp` | `rings.txt` |
| Legal edges: m1 0.140, li 0.170, p+/n+ at 0 and from 0.270, diffusion beside a gate 0.250 bare and 0.275 with a centred contact | run | `residual/drc_edge/scan.tcl`, `probes/` | `out/*.magic.csv` |
| The KLayout manufacturing deck has no poly.7 or licon.11; the full deck has them but ships with front-end checks off; switched on, it agrees with Magic | run | `residual/drc_edge/klayout_points.sh`, `klayout_read.py` | `out/sa_*.lyrdb`, `klayout_full_deck.txt` |
| Weak-inversion step 0.83 to 0.84 % per 0.305 mV; slope factor 1.41 | run | `experiments/xc19_weak_inversion/dc_27.sp`, `budget.py` | `budget.txt` |
| Bias chain with 16 mirror devices, 4 in series, usable in five corners at 27 and 85 C | run | `gen_bias.py`, `bias_table.py` | `bias_table.txt` |
| Complete stage: 24.5 us, 0.86 %, 2.0 fF, 0.53 % per mV of supply | run | `gen_stage.py` | `stage.txt` |
| Long twin fails (0.75 % for 10 mV); identical twin 0.02 %, array twin 0.09 % (single mismatch case, long high-threshold precharge) | run, the second part exploratory | `gen_stage.py`, `gen_explore.py` | `stage.txt`, `explore.txt` |
| Precharge leakage: 5.3 pA minimum pfet, 0.010 pA long high-threshold | run, exploratory | `gen_explore.py` | `explore.txt` |
| Kickback of one small stage: 0.076 mV at 1 pF, 0.016 mV at 10 pF | run | `gen_night.py` | `night.txt` |
| LOD pair through the stage: time ratio 1.64, current ratio 2.36 | run and arithmetic | `gen_night.py` (`n4_cross.sp`) | `night.txt` |
| Readout cell, bias cell and channel: 0 violations in Magic (full rules), in the KLayout manufacturing deck and in the full KLayout deck with front-end checks on; 23 devices as intended | run | `cells/*/xc19_*.tcl` | `cells/*/xc19_*.log`, `*.lyrdb`, `*.lvs.spice`, `residual/drc_edge/klayout_full_deck.txt` |
| Channel from layout, three in series, 133 fF: 29.2 us, 0.80 % | run | `cells/xc19_bias/channel.sp`, `cells/xc19_channel/channel_sim.sp` | `channel.txt`, `channel_sim.txt` |
| Shot noise of one conversion at 81 pA and 2.3 fF: 0.55 % in transient simulation (48 conversions), 0.82 % from the electron count | run and arithmetic | `experiments/xc19_noise/shot_trnoise.sp`, `shot_read.py` | `shot.txt` |
| Mismatch: device/twin ratio moves a median of 0.047 % for 10 mV of supply; discharge times spread over two orders of magnitude | run (39 of 100 planned draws) | `experiments/xc19_weak_inversion/n5_mc.sp`, `n5_read.py` | `n5.txt` |
| Detection at 81 pA and 2.3 fF: false events above one per second at every dwell | run (behavioural model) | `experiments/xc19_noise/detect.py` | `detect.txt` |
| Detection at 5.5 nA and 135 fF: 98 % from three conversions, no false events against a reference | run (behavioural model) | `experiments/xc19_noise/detect.py`, `k3_cap.sp` | `detect.txt`, `k3_cap.txt` |
| About 0.66 visible traps per decade of dwell time per minimum device | estimate | arithmetic in `experiments/xc19_weak_inversion/README.md` | from `noia` of the model card, read as a trap density |
| A single trap moves the threshold 0.305 mV | arithmetic | q / (C_ox W L), sheet-charge bound | |

Not in this table because they are not established: that silicon follows any of these models; how the standard-cell library was
characterised; that SKY130 devices show resolvable single traps.

## Attack rounds 1–4 (2026-11-12/13)

Grades here are those of the rounds: **verified** = reproduced by an independent verifier with their own code;
**verified to order** = same order of magnitude, differences explained; **one agent** = not reproduced; **not verifiable** =
models disagree by more than the claim. Everything is calculation or simulation; nothing is silicon. Models without calibration
give intervals and scenarios. Process data used by all rounds: `cells/notas/DATOS_PROCESO.md`.

| Claim | Grade | Main assumptions and limits | Source |
|---|---|---|---|
| XC-20: reverse tunnelling at zero separation, tens of nA to tens of uA per 1.4 um at 1.8 V | verified to order | doping profile not public; silicide over the junction unknown (first gate, see the plan) | `experiments/RONDA_1_2026-11-12.md`, `experiments/RONDA_2_2026-11-12.md` |
| XC-05: met1 bridged by its barrier, 20–240 ohm/um; li neck 500–1800 K at 4–8 mA; reader <= 48 mV | verified | thin-film resistivities partly from literature read by agents | `experiments/RONDA_2_2026-11-12.md` |
| XC-52: four-state demodulation does not remove classical even-in-field terms; coil 0.373 mT/mA | verified | needs traps; coil current path not audited | `experiments/RONDA_2_2026-11-12.md`, `experiments/xc52_demod_test/` |
| XC-57/59/60/61/62/63 (see each row of the catalogue) | verified or to order, per row | per round report | `experiments/RONDA_3_2026-11-12.md` |
| XC-58: Monte Carlo 0.90 of kT/C in variance at the minimum node; ngspice noise ~0.50 after removing a spurious source | verified (Monte Carlo); **open disagreement** with ngspice, unexplained | the two models are not reconciled | `experiments/RONDA_3_2026-11-12.md`, `cells/xc58_ktc_cell/PLAN.md` |
| XC-26: collected fraction 2.3–2.45e-3 at 5 um; 0.21–0.42 pA at 5 um with the emitter well at +1 V and substrate <= 10 ohm cm | verified to order | substrate resistivity not public; emission efficiency x100 interval; saturation of the vertical PNP is outside the PDK model domain | `experiments/RONDA_4_OPTICA_2026-11-13.md` |
| XC-27: a metal cap changes only the escape cone, +1–4 % | verified to order (gratings: one agent) | no RCWA by the verifier | `experiments/RONDA_4_OPTICA_2026-11-13.md` |
| XC-21: drawn corner breakdown 6.6–9.7 V; drawn gap is not a useful knob | verified to order | abrupt-junction model | `experiments/RONDA_4_OPTICA_2026-11-13.md` |
| XC-14: plasma charge tunnels out of 4.15 nm oxide; residual drifts 0–1.2 mV/day | verified (discharge), to order (residual) | physics below 0.5 V least reliable; `toxe_slope` as thickness unconfirmed | `experiments/RONDA_4_NODO_2026-11-13.md` |
| XC-07: breakdown time at 5.7–7.4 V in 1 h | not verifiable | TDDB models span 7–14 decades | `experiments/RONDA_4_NODO_2026-11-13.md` |
| XC-53: Dickson pump 8.0–8.4 V (N=6), 10.1–10.6 V (N=8) from 1.8 V; no device above 2.8 V | verified | vertical PNP of each stage not modelled | `experiments/RONDA_4_NODO_2026-11-13.md` |

