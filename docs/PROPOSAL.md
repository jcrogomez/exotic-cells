# MISFIT: chip proposal

A proposal, not a decision. The only result claimed is the extraction audit under "First finding".

## Vehicle

| Item | Proposal |
|---|---|
| Shuttle | Tiny Tapeout TTSKY27a (SKY130) |
| Tile | Analog/mixed-signal 2x2, about 334 x 225 um |
| Analog pins | 4 (force and sense pairs), to be compared against 2 and 6 before paying |
| Supplies | 1.8 V digital; 3.3 V analog under evaluation, only with compatible devices and biases |
| Layout | Parametric macros scripted in Magic, with manual review of physical sections, contacts and extraction |
| Fee as read on the Tiny Tapeout site (2026-11) | 280 EUR for the 2x2 area plus 280 EUR for four analog pins |

Constraints taken from the Tiny Tapeout analog specification: metal 5 is reserved, analog pins pass through a switch (under
500 ohm, 4 mA maximum), chips arrive packaged, so no external light reaches the die.

## Architecture

**Two zones, kept apart.**

- **FAB zone**: cells finished by the foundry. Nothing is stressed. This zone alone is a complete chip.
- **BENCH zone**: cells transformed after fabrication by current or overvoltage. Isolated, interlocked, own supply, and removable
  if permission is not granted.

**Five islands** share **four instruments** instead of each experiment carrying its own readout.

| Island | Looks for |
|---|---|
| Forge | Transformable interconnect and contacts, programmable resistance |
| Opto | Emission, detection, optical structures |
| Charge | Single defects, trapped charge |
| Process | What manufacturing leaves behind: stress, proximity, plasma |
| Junction | Lateral transport, parasitic bipolars, magnetotransport |

| Instrument | Measures |
|---|---|
| R | Resistance, formation, Kelvin sensing |
| I | Small currents by integration on a known capacitance |
| T | Microscopic events and dynamics: weak-inversion stage, differential, time-stamped |
| X | Four-terminal differential experiments with a matched reference |

**The unit of design is an experimental cell**: device, twin and ghost, read through the same path. Coupling between mechanisms
gets no island of its own; it is studied with pairs placed on the borders between islands, each with an inactive control at the
same distance.

## Candidate cells

FAB zone:

| Candidate | Unwanted behaviour used | Function sought | Class |
|---|---|---|---|
| Diffusion-length (STI stress) transistor | Mechanical stress from isolation | Threshold set by layout | A, but lost by the extractor: see finding below |
| Well-proximity transistor | Extra doping near the well edge | Threshold set by distance to well | C |
| Antenna as fab-time write | Plasma charge on a floating gate | A cell that is born written | C |
| Antenna factorial | Plasma damage to gate oxide | Threshold shift, created traps | C |
| Abutted p+/n+ junction | Leakage and tunnelling | Low-voltage diode, noise source | C |
| Single-trap transistor (RTN) | One defect in a minimum device | Probabilistic bit, defect sensor | B |
| Junction emitter and photodiode | Recombination light, carrier diffusion | On-chip optical link | B/C |
| Field-oxide transistor | Parasitic device under isolation | Charge or radiation sensor | C |
| Heat as a channel | Self-heating and thermal diffusion | On-chip temperature knob, wireless coupling | B |
| Well Hall plate | Well as a resistive sheet | Magnetic sensing | B |
| Metal hole arrays (periodic, disordered, aperiodic) | Sub-wavelength apertures in metal | Optical filtering | B, needs light on the die |
| Parasitic bipolar and PNPN | Latch-up | Relaxation oscillator | C |

BENCH zone:

| Candidate | Unwanted behaviour used | Function sought | Class |
|---|---|---|---|
| Metal-1 constriction family | Electromigration | Programmable resistance | C |
| Local-interconnect constriction | Electromigration at higher dissipation | Same, at lower current | C |
| Single versus redundant contacts | Contact failure | Transformable interface | C |
| Charge-trap transistor | Hot-carrier ageing | Mask-free memory, analog weight | B |

Kept on file, no silicon this generation: single-poly floating gate (needs a charge pump), oxide-breakdown antifuse and filament
emitter, tunnelling nanogap, Coulomb island, SPAD, physical nanopores, mesoscopic coherence. The catalogue keeps them so that ideas
are pruned by gates, not by recency.

## First finding, and the first job for Residual

Confirmed by extraction and simulation on 2026-11-11 (model only, no silicon). Files and numbers:
[`experiments/lod_audit`](../experiments/lod_audit/README.md).

- The `nfet_01v8` model card carries populated STI stress coefficients.
- Magic extracts `l w as ps ad pd` for that device and does not emit `sa`, `sb` or `sd`. Two layouts that differ only in diffusion
  length extract to the same transistor.
- With `sa = sb = 0` the model behaves exactly as the reference geometry, so the open flow simulates both layouts identically.
- With the parameters written by hand, the same model predicts a threshold difference of 31.1 mV between 0.30 um and 3.0 um of
  diffusion at W = 0.42 um, and 44.1 mV at W = 5 um.

The first module of Residual is therefore defined: read the layout, compute those parameters per instance, annotate the netlist.
Whether silicon follows the model is the experiment.

## First silicon priorities

One complete channel of each instrument before any array:

1. Forge channel with separate formation and readout paths.
2. Charge channel: a weak-inversion stage that can see a single trap, with a large-area twin.
3. Opto channel: emitter, detector and dummy at several distances.
4. Process matrix: diffusion length crossed with well distance, mirrored replicas; antenna structures with their own references.

## Open decisions

- Number of analog pins and whether 3.3 V is used.
- Number of chips to order. Single-trap and antenna experiments are statistical: one die says nothing about the process.
- Licence.

## Risks

- Permission for bench stress may be refused: the BENCH zone is designed to be removed.
- A deliberate antenna structure may be rejected by the foundry even though the Tiny Tapeout precheck does not test for it.
- Signals near the mismatch floor need more replicas than the area allows.
- The readout instrument is harder than any cell. If it fails, every result is inconclusive.
