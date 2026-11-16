# Open questions

What we do not know yet, who could answer it, and what each answer would change. Answered questions stay here with their
source and date, so the record of *why* a decision moved is never lost. Last update: 2026-11-16 09:10 (`date`).

Grades for answers: **source** (a document we read), **run** (our own reproducible run), **third party** (someone who knows
the process told us; no document), **inferred** (our reasoning from sources).

## Answered

| # | Question | Answer | Grade | What it changes |
|---|---|---|---|---|
| A1 | Is SKY130 diffusion silicided? | A Tiny Tapeout contributor, 2026-11-16: their understanding is that SKY130 is not silicided. Agrees with what we had inferred from the PDK: n+ 120 Ω/□, p+ 197 Ω/□, poly 48.2 Ω/□, no silicide-block layer ([capability matrix §1](CAPACIDADES_SKY130.md)) | third party + inferred. Not a document | **XC-20:** the first gate (a silicide short across the abutted junction) is very likely open: at 0 gap there should be a real p+/n+ junction. The boring explanation becomes the series resistance (~1 kΩ, arithmetic). The Kelvin strips stay on the chip as the in-silicon check. **XC-51, XC-40:** polysilicon probably unsilicided too (not stated for poly). **XC-63:** the contact interface is still `[?]` |
| A2 | Can a design ignore antenna checks on SKY130? | The same contributor, 2026-11-16: antenna checks can be ignored on SKY130, whereas on GF180 the foundry's antenna DRC rules do have to be met | third party | **XC-14:** the shuttle-side gate is open: floating gates with large antennas can be drawn on SKY130. The contrast with GF180 suggests this is about what is *enforced*, not about the physics: it does not predict that plasma charge is negligible. **SKY130 is the window** for this experiment; GF180 would not allow it. The risk line in [PROPOSAL](PROPOSAL.md#risks) is updated |
| A3 | Does the TT precheck run antenna checks on sky130A? | No (read by an agent in `precheck.py`, 2026-11-12) | source (agent) | Consistent with A2 |
| A4 | Does an abutted p+/n+ pass the precheck? | Yes; overlap or a 0.13 µm gap do not | run (`experiments/precheck_map/`) | XC-20 can be drawn |
| A5 | Is the 0.05-bit threshold of XC-20 round 3 absolute or normalised? | Absolute bits (Juan, 2026-11-16), recorded as a post-result clarification | decision | D5 counts as an exploratory decision, not a confirmatory pass |

## Open: for Tiny Tapeout

| # | Question | Why it matters | Families |
|---|---|---|---|
| Q1 | Is A2 "not enforced, your risk" or "antenna damage is negligible on sky130 in practice"? | The second would predict a null for XC-14 | XC-14 |
| Q2 | Is polysilicon unsilicided too? | Poly fuses and thermopiles | XC-51, XC-40, XC-39 |
| Q3 | Can a project generate 8–10 V inside its tile with a charge pump and use the high-voltage devices? Max voltage on analog pins? | The single question with most families behind it | XC-53, XC-21, XC-07, XC-18 |
| Q4 | Does light reach the die in the TT package or board? Can a bare die be requested? | Optics with external light | XC-26 (transmission), XC-27 |
| Q5 | How much current can one tile draw locally (100 µA steady; 4–8 mA pulses)? | Coils, Peltier, electromigration | XC-56, XC-52, XC-57, XC-01, XC-05 |
| Q6 | Is capm (MiM) fabricated on SKY130 shuttles? Any silicon data? | Reader capacitors | XC-19, XC-58 |
| Q7 | How many chips does one project get, and can more be bought? | Single-trap and antenna results are statistical | XC-19, XC-14, XC-62 |
| Q8 | Is SONOS (`tunm`) definitively forbidden? | Charge-trap variants | XC-09, XC-11 (merged into XC-14) |
| Q9 | What are the TT GF180 shuttles, and which higher-voltage devices does that PDK offer? | Possible natural vehicle for the families waiting for >1.8 V (from memory, not checked) | XC-21, XC-07 |

## Open: physics and process (answered only by silicon or by a source we have not read)

| # | Question | How we would answer it |
|---|---|---|
| P1 | Is the doping at an abutted p+/n+ edge abrupt and high enough to tunnel? | XC-20 matrix: 0, 0.27, 0.54, 1.08 µm and a no-junction cell, temperature and two reverse voltages |
| P2 | How many resolvable oxide traps does a minimum SKY130 transistor have? | XC-19 channel, long time series; the only number now is read off the model card's noise parameter |
| P3 | Does plasma charge survive the anneal on the 11.6 nm oxide? | XC-14 first read after power-up |
| P4 | Substrate resistivity | Decides whether the optical link can work (≤ 10 Ω·cm lives, ≥ 20 dies) |
| P5 | Does silicon follow the LOD stress model that Magic's extraction drops? | Process matrix of XC-12/13/16 read by Residual |
| P6 | Size of spin-dependent recombination at mT fields in stressed SKY130 devices | We have no source; first read the literature (`READING.md`) |
| P7 | Why ngspice noise gives ~0.50 of kT/C where Monte Carlo gives 0.90 | Open disagreement in XC-58 |

## Open: decisions for Juan

- Scope of the first die: the narrow recommendation of [PROPOSAL](PROPOSAL.md#first-silicon) (LOD matrix and the reader), the
  top of the [ranking](RANKING.md), or both.
- Hybrid vehicle: analog pins and 3.3 V, or digital only.
- Number of chips to order (Q7).
- Whether to look at GF180 for the high-voltage families (Q9).
