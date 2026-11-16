# Open questions

What we do not know yet, who could answer it, and what each answer would change. Answered questions stay here with their
source and date, so the record of *why* a decision moved is never lost. Last update: 2026-11-16 09:24 (`date`).

Grades for answers: **source** (a document we read), **run** (our own reproducible run), **third party** (someone who knows
the process told us; no document), **inferred** (our reasoning from sources).

## Answered

| # | Question | Answer | Grade | What it changes |
|---|---|---|---|---|
| A1 | Is SKY130 diffusion silicided? | A Tiny Tapeout contributor, 2026-11-16: their understanding is that SKY130 is not silicided. Agrees with what we had inferred from the PDK: n+ 120 Ω/□, p+ 197 Ω/□, poly 48.2 Ω/□, no silicide-block layer ([capability matrix §1](CAPACIDADES_SKY130.md)) | third party + inferred. Not a document | **XC-20:** the first gate (a silicide short across the abutted junction) is very likely open: at 0 gap there should be a real p+/n+ junction. The boring explanation becomes the series resistance (~1 kΩ, arithmetic). The Kelvin strips stay on the chip as the in-silicon check. **XC-51, XC-40:** polysilicon probably unsilicided too (not stated for poly). **XC-63:** the contact interface is still `[?]` |
| A2 | Can a design ignore antenna checks on SKY130? | The same contributor, 2026-11-16: antenna checks can be ignored on SKY130, whereas on GF180 the foundry's antenna DRC rules do have to be met | third party | **XC-14:** the shuttle-side gate is open: floating gates with large antennas can be drawn on SKY130. The contrast with GF180 suggests this is about what is *enforced*, not about the physics: it does not predict that plasma charge is negligible. **SKY130 is the window** for this experiment; GF180 would not allow it. The risk line in [PROPOSAL](PROPOSAL.md#risks) is updated |
| A3 | Does the TT precheck run antenna checks on sky130A? | No (read by an agent in `precheck.py`, 2026-11-12) | source (agent) | Consistent with A2 |
| A4 | Does an abutted p+/n+ pass the precheck? | Yes; overlap or a 0.13 µm gap do not | run (`experiments/precheck_map/`) | XC-20 can be drawn |
| A6 | Which ideas look worth it from the Tiny Tapeout side? | The same contributor, 2026-11-16: several of these ideas could fit in one tile; an e-fuse would be interesting and potentially useful, but hard (read papers first): blowing a short trace is easy, guaranteeing it never joins back together is not | third party, advice | **XC-01/XC-05** move up the ranking (tier B, rank 4). The rejoin problem is the regime XC-05 looks for: one blow, two useful outcomes (a fuse, or a few-channel contact). Consistent with round 2: metal 1 is bridged by its barrier, so a clean open is not guaranteed |
| A7 | How much current can one tile draw locally? | The same contributor, 2026-11-16: about 8 mA should be no problem; tile power runs through power switches (`TinyTapeout/tt-multiplexer`, `pg/sky130`). The analog spec (read 2026-11-16, tinytapeout.com/specs/analog, "Power pins"): ~20 mA gives a 0.1 V drop through the power network; analog `ua` pins are limited to 4 mA. Neither page states a switch on-resistance or a pulse rating. The contributor does not remember where the e-fuse rejoin problem was reported | third party + source | **XC-01/XC-05:** 4–8 mA pulses are feasible if driven from the tile's own 1.8 V supply, not through an analog pin (4 mA). **Every reader:** scaling the stated drop linearly (our arithmetic), 8 mA moves the supply ~40 mV, and the reader stage moves 0.53 % per mV ([CLAIMS](CLAIMS.md)): never read while a fuse, coil or heater pulses. **XC-52:** coil current droops the supply by the same amount for both polarities, an even-in-field artefact like the signal; the constant-power bifilar coil stays mandatory. **Q10 stays open:** the rejoin problem is hearsay until a paper is found |
| A8 | Digital pins or analog pins? | The same contributor, 2026-11-16: a digital design uses only the digital pins; measuring analog voltages needs analog pins, at extra cost; and prioritise design for test (DFT) | third party, advice | **Vehicle:** MISFIT's readout is already digital (current → time → counter), so the core fits digital pins. What still assumed analog pins: the Kelvin strips (A1 check), the Hall plate (XC-25) and any direct voltage reading. Either they get a digital readout (for example resistance read as an RC discharge time through the same reader) or they pay for analog pins (PROPOSAL: 280 EUR for four). **DFT** becomes a design requirement: see [ROADMAP](ROADMAP.md) |
| A5 | Is the 0.05-bit threshold of XC-20 round 3 absolute or normalised? | Absolute bits (Juan, 2026-11-16), recorded as a post-result clarification | decision | D5 counts as an exploratory decision, not a confirmatory pass |

## Open: for Tiny Tapeout

| # | Question | Why it matters | Families |
|---|---|---|---|
| Q1 | Is A2 "not enforced, your risk" or "antenna damage is negligible on sky130 in practice"? | The second would predict a null for XC-14 | XC-14 |
| Q2 | Is polysilicon unsilicided too? | Poly fuses and thermopiles | XC-51, XC-40, XC-39 |
| Q3 | Can a project generate 8–10 V inside its tile with a charge pump and use the high-voltage devices? Max voltage on analog pins? | The single question with most families behind it | XC-53, XC-21, XC-07, XC-18 |
| Q4 | Does light reach the die in the TT package or board? Can a bare die be requested? | Optics with external light | XC-26 (transmission), XC-27 |
| Q6 | Is capm (MiM) fabricated on SKY130 shuttles? Any silicon data? | Reader capacitors | XC-19, XC-58 |
| Q7 | How many chips does one project get, and can more be bought? | Single-trap and antenna results are statistical | XC-19, XC-14, XC-62 |
| Q8 | Is SONOS (`tunm`) definitively forbidden? | Charge-trap variants | XC-09, XC-11 (merged into XC-14) |
| Q10 | Which papers describe e-fuses in processes without silicide on poly, and in metal or TiN? | Classic e-fuses rely on silicide electromigration on poly (from memory, unread); if SKY130 has no silicide (A1), that mechanism is not available | XC-01, XC-05, XC-51 |
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
| P8 | Does a blown metal-1 or li neck stay open, drift, or rejoin over days? | XC-01 cells read right after blowing and re-read over time, against an unblown twin |
| P7 | Why ngspice noise gives ~0.50 of kT/C where Monte Carlo gives 0.90 | Open disagreement in XC-58 |

## Open: decisions for Juan

- Scope of the first die: the narrow recommendation of [PROPOSAL](PROPOSAL.md#first-silicon) (LOD matrix and the reader), the
  top of the [ranking](RANKING.md), or both.
- Hybrid vehicle: analog pins and 3.3 V, or digital only. A Tiny Tapeout contributor advises digital only unless analog voltages
  must be measured (A8).
- Number of chips to order (Q7).
- Whether to look at GF180 for the high-voltage families (Q9).
