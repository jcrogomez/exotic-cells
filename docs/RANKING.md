# Candidate ranking

Which cells we would put on MISFIT first, and why. Last update: 2026-11-16. **Everything here is calculation, simulation or a
design-rule run. Nothing has been fabricated.** The [catalogue](../README.md#catalogue) lists every family; this page orders
the ones that survived.

## How the ranking is made

Five questions per family, answered from the round reports, not from enthusiasm:

1. **Evidence on paper.** Did the key number survive an attack *and* an independent verifier with their own code?
2. **Fits the vehicle.** Can it be read on a normal Tiny Tapeout tile, at 1.8 V, through on-chip counters?
3. **Failure teaches.** If it does not work, do we still learn something about SKY130 that is not documented?
4. **New if it works.** Is it a behaviour the PDK does not offer?
5. **Blocking unknown.** What single fact could kill it, and can we find it out before tapeout?

The ranking is a judgement on these five, not a score. It changes when an answer changes: the column **moves it** says which
answer would. Answers already received are in [OPEN_QUESTIONS](OPEN_QUESTIONS.md).

**The shared instrument.** Almost every cell is read the same way: the cell's current discharges a precharged node and an
on-chip counter times it, so current becomes a number on the digital pins. Each channel carries a known calibration (a test
current, a switched capacitor, a gate step), so "calibration seen, cell not" is a real null. Drawn and DRC clean; simulated
only ([XC-19](../cells/xc19_single_trap/PLAN.md)).

**The non-exotic baseline.** One result is already a run, not a bet: Magic's extraction drops the diffusion-length (LOD)
stress parameters, so two layouts the model separates by 31 mV extract to the same netlist ([CLAIMS](CLAIMS.md)). A process
matrix that checks whether silicon follows that model ([PROPOSAL, first silicon](PROPOSAL.md#first-silicon)) is the experiment
most certain to yield data. It is not in the ranking because it is metrology, not an exotic cell.

## Tier A: design these for MISFIT

### 1. XC-20 · p+ touching n+ (tunnel junction) · [plan](../cells/xc20_abutted_junction/PLAN.md)

| | |
|---|---|
| **Process part used** | Band-to-band tunnelling, which spacing rules exist to avoid. DRC allows p+ and n+ to abut (0 gap) or sit ≥ 0.27 µm apart, nothing in between |
| **If it works** | A tunnel diode in an open PDK that does not offer one. Negative resistance would be a transistor-free oscillator (open: depends on a doping profile that is not public) |
| **Tested** | Reverse current tens of nA to tens of µA per 1.4 µm at 1.8 V (verified to order of magnitude). Abutment passes the precheck (run). Hypothesis engine, round 3: the no-junction cell is needed; 0.54 µm carries most of what the extra separations add (model; round not consolidated) |
| **Success** | Leakage at 0 gap far above 0.27 µm by a factor fixed beforehand, scaling with edge length, depending on temperature less than the 0.27 µm cell |
| **Failure teaches** | Ohmic at 0 gap → something bridges the junction after all. Every gap like an ordinary diode → the edge doping is not sharp enough: a bound on an unpublished profile |
| **Blocking unknown** | Silicide: now very likely absent (A1, third party). Reader range: the precharge reader saturates near 1.25 nA, so it needs a wide-range front-end |
| **Moves it** | Already at the top |

### 2. XC-19 · one electron in one defect (random telegraph noise) · [plan](../cells/xc19_single_trap/PLAN.md)

Open in the catalogue (yellow): the reader is built and simulated, but no trap has been demonstrated, so it has not survived an
attack as a cell. It ranks this high because every other cell depends on its reader.

| | |
|---|---|
| **Process part used** | Gate-oxide traps, normally averaged away as 1/f noise |
| **If it works** | Watching one electron captured and released on a digital chip: a single-charge sensor, a physical random bit |
| **Tested** | One trap = 0.305 mV of threshold (arithmetic) = ~0.8 % of discharge time (run). 98 % detection at 5.5 nA and 135 fF with an injected step (behavioural model). Reader cell, bias cell and channel DRC clean in Magic and KLayout (run). Juan's decision: first complete channel of MISFIT |
| **Success** | Two levels > 5σ apart, exponential dwell times that move with gate bias and temperature, amplitude scaling as 1/(W·L) |
| **Failure teaches** | No levels while the calibration step is resolved → an upper bound on visible traps per device in SKY130, which is not published |
| **Blocking unknown** | Whether the reader resolves its own calibration step in silicon. If not, every other cell is inconclusive too |
| **Moves it** | Nothing moves it down: the instrument has to be built anyway |

### 3. XC-14 · floating gates the fab writes (plasma charge) · [plan](../cells/xc14_antenna_write/PLAN.md)

| | |
|---|---|
| **Process part used** | Plasma charging during etch, the damage antenna rules prevent. Gates hung on antennas of different sizes, with no discharge path, next to twins with the diode |
| **If it works** | A chip born with something written on it. Round 4 killed the "factory ROM" on thin oxide (the charge tunnels out, verified); what remains drifts 0–1.2 mV/day and depends on oxide thickness: a chip-age clock or local thickness gauge (conjecture). Thick 11.6 nm oxide does not tunnel; survival through the anneal unknown |
| **Tested** | Discharge through 4.15 nm oxide (verified); residual drift (verified to order) |
| **Success** | Threshold at first read rises monotonically with antenna size, spreads more than the twins, stays put between reads |
| **Failure teaches** | Floating gates look like their twins → in-rule antennas leave no readable charge, or the anneal wipes it. Either answer is about the process |
| **Blocking unknown** | Shuttle side open (A2: antenna checks can be ignored on SKY130; enforced on GF180). Q1: "not enforced" or "negligible in practice"? |
| **Moves it** | Up if Q1 is "not enforced". SKY130 is the only TT window for it |

## Tier B: fit a normal tile; add if area allows

| Rank | Family | Process part used | If it works | Tested | Failure teaches | Moves it up |
|---|---|---|---|---|---|---|
| 4 | [XC-62](../cells/xc62_proximity_fet/PLAN.md) printed transistors | Lithographic rounding: legal shapes print differently from the drawing | Measures what the fab's proximity correction leaves | Legal and submittable; 1.2–1.8 mV per nm of gate length (verified) | Correction good enough at this scale; useful to every designer | More chips (Q7): mismatch (~17 mV on minimum devices) is larger than the effect |
| 5 | [XC-58](../cells/xc58_ktc_cell/PLAN.md) frozen thermal noise | kT/C sampling noise, which circuits fight | Randomness source; meter of 1–30 fF; continuous-noise control for XC-19 | Monte Carlo 0.90 of kT/C (verified); ngspice ~0.50, unexplained | Reader noise above kT/C at that size | Resolving P7 |
| 6 | [XC-52](../cells/xc52_spin_pair/PLAN.md) spin without magnets, with [XC-60](../cells/xc60_magnetodiode/PLAN.md) magnetodiode and [XC-56](../cells/xc56_microcoil/PLAN.md) coil (instrument) | Interface traps created by stress; carriers bent towards a fast-recombining surface | Room-temperature spin effect with no magnetic material | Coil 0.373 mT/mA (verified); demodulation does not remove classical even-in-field terms (verified); magnetodiode ~1 mT from a metal-1 strip (verified) | Little: a null cannot tell "absent" from "too few traps". Expected size 1e-4 to 1e-3 is from memory | A source for the signal size (P6); Q5 on coil current |
| 7 | [XC-57](../cells/xc57_peltier_junction/PLAN.md) Peltier junction | Heat pumped at a junction, reversing with current | On-chip heat pump | 0.2–7 K at 100 µA in the model; the reader sees ~1 %, so seconds per reading | Joule heating swamps it | Q5 (100 µA on a tile) |
| 8 | [XC-26](../cells/xc26_optical_link/PLAN.md) optical link, with [XC-27](../cells/xc27_hole_arrays/PLAN.md) hole arrays | Light from radiative recombination in a forward junction | A chip that talks to itself with light | 0.21–0.42 pA at 5 µm vs 0.15 pA floor, only with substrate ≤ 10 Ω·cm (verified to order) | Bound on emission and substrate resistivity | P4 (substrate resistivity); Q4 (light on the die) |
| 9 | [XC-63](../cells/xc63_schottky_contact/PLAN.md) unimplanted contact | A contact on lightly doped silicon rectifies instead of conducting | A Schottky diode from standard layers | The PDK ships seven such cells on p substrate (verified) | Interface is ohmic after all | Knowing the contact material (A1 removes silicide, not the question) |
| 10 | [XC-59](../cells/xc59_thermal_erase/PLAN.md) electrical write, thermal erase | Defects made by stress, annealed by heat | Rewritable element | Dead for a transistor with on-chip heater (1–16 % of the rise reaches the channel, verified); alive for poly on oxide or oven erase | Which defects anneal at reachable temperatures | An oven at the bench |

## Tier C: need another vehicle or a lab

| Family | Needs | The question that unlocks it |
|---|---|---|
| [XC-21](../cells/xc21_avalanche_emitter/PLAN.md) avalanche light, with [XC-53](../cells/xc53_hv_pump/PLAN.md) pump (8–10 V from 1.8 V, verified) | 6.6–9.7 V | Q3, Q9 |
| [XC-07](../cells/xc07_oxide_breakdown/PLAN.md) oxide breakdown | > 5 V; breakdown time unverifiable (7–14 decades) | Q3 |
| [XC-05](../cells/xc05_atomic_contact/PLAN.md) atomic contact via [XC-01](../cells/xc01_m1_constriction/PLAN.md) forge | 4–8 mA pulses (li neck 500–1800 K, verified) | Q5 |
| [XC-25](../cells/xc25_hall_plate/PLAN.md) Hall plate | Analog pins (0.017–0.66 mV/mA) | Hybrid vehicle decision |
| [XC-54](../cells/xc54_tin_superconductor/PLAN.md), [XC-30](../cells/xc30_mesoscopic/PLAN.md), [XC-61](../cells/xc61_freezeout_oscillator/PLAN.md) | Cryostat (4.2 K) | Access to one |

Open families not yet attacked (XC-06, XC-18, XC-24, XC-28, XC-29, XC-39, XC-55) are in the catalogue and enter the ranking
when they survive a round.
