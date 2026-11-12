# Catalogue of candidate families

Stable identifiers. An `XC-nn` is never reused or deleted: a family is merged (the line stays and points to the one that absorbs
it) or dropped with evidence (the line stays, with the evidence). A new idea takes the next number.

No family has graduated to a cell. Graduation requires the functional contract described in
[`docs/MOTIVATION.md`](../docs/MOTIVATION.md).

- **Engine**: F = a wanted function looking for a mechanism. P = poorly characterised physics looking for what emerges.
- **Vehicle**: D = today's digital flow plus custom macros, 1.8 V, no analog pins. H = hybrid (analog pins, 3.3 V, analog layout).
  S = specialised (bare die, light, post-processing, cryogenics or high voltage). The vehicle classifies; it does not reject.
- **U / I**: expected functional usefulness / physical information gained even if no function comes out. High, medium, low.
  These are judgements, not measurements.

| ID | Family | Mechanism | Engine | Vehicle | U | I | State |
|---|---|---|---|---|---|---|---|
| XC-01 | Metal-1 constriction | Electromigration | F | D | H | H | Formation path verified in the flow; transformation not demonstrated |
| XC-02 | Local-interconnect constriction | Joule heating | F+P | D | H | H | Geometry drawn, not integrated |
| XC-03 | Contact or via as the transformation site | Interface failure | P | D | M | H | Observation only |
| XC-04 | Tunnelling nanogap | Direct tunnelling across about 1 nm | P | H/S | M | H | Outside the range of a digital readout |
| XC-05 | Atomic contact | Transport through a few channels | P | S | L | M | On file: needs a precursor that can cycle |
| XC-06 | Coulomb island | Coulomb blockade | P | S | L | M | On file: island cannot be drawn at this node |
| XC-07 | Oxide breakdown: antifuse, filament | Dielectric breakdown | F+P | H | H | H | Waits for more than 1.8 V |
| XC-08 | Silicon filament emitter | Emission from the XC-07 filament | F | H/S | M | H | Depends on XC-07 |
| XC-09 | Charge-trap transistor | Hot-carrier trapping | F | H | H | M | No SKY130 data |
| XC-10 | Ageing at 1.8 V | BTI and HCI | P | D | M | M | No design |
| XC-11 | Single-poly floating gate | Injection and tunnelling | F | H | H | L | Waits for a charge pump |
| XC-12 | Diffusion-length stress (LOD) | STI mechanical stress | P | D | M | H | Extraction gap confirmed; annotator written; model prediction only |
| XC-13 | Well proximity (WPE) | Extra doping near the well edge | P | D | M | H | Not in the model card |
| XC-14 | Antenna as a fab-time write | Plasma charge on a floating gate | F+P | D | H | H | Foundry rules to be read |
| XC-15 | Antenna factorial | Plasma damage to gate oxide | P | D | M | H | Experiment defined |
| XC-16 | Placement environment | Neighbours, orientation, density | P | D | L | M | Needs no macro |
| XC-17 | Electrode by design | Parasitic capacitance | P | D | L | M | Low priority |
| XC-18 | Field-oxide transistor | Parasitic channel under isolation | F | H | M | M | Threshold unknown |
| XC-19 | Single trap (RTN) | Capture and emission at one defect | F+P | D/H | H | H | Readout stage and bias simulated against two pre-registrations; twin and precharge redesigned; no layout, no silicon |
| XC-20 | Abutted p+/n+ junction | Band-to-band tunnelling | P | D/H | M | H | Legal geometries drawn; no readout |
| XC-21 | Avalanche junction as emitter | Reverse breakdown | F | H/S | M | M | Waits for high voltage |
| XC-22 | SPAD | Geiger-mode avalanche | F | H/S | M | M | Waits for high voltage |
| XC-23 | Lateral multi-terminal junction | Minority-carrier diffusion | P | H | M | H | Stated only; also the control for XC-26 |
| XC-24 | Parasitic bipolar and PNPN | Thyristor feedback | F | H | M | M | Latch-up risk |
| XC-25 | Well Hall plate | Hall effect | F | H | M | L | An instrument, not a cell |
| XC-26 | On-chip optical link | Radiative recombination in a forward junction | P | D/H | M | H | Legal detector, modelled floor |
| XC-27 | Metal hole arrays | Sub-wavelength apertures | P | S | M | H | Needs light on the die |
| XC-28 | Waveguides in the dielectric | Guiding in the metal stack oxide | F | S | M | M | Needs die access |
| XC-29 | Physical nanopores | to be written | P | S | | | Named only |
| XC-30 | Mesoscopic coherence | to be written | P | S | | | Named only |
| XC-31 | Heat as a channel | Self-heating and thermal diffusion | F+P | D | M | M | Unverified estimate |
| XC-32 | Supply-network coupling | Supply droop | P | D | L | M | The boring explanation every coupling experiment must rule out |
| XC-33 | Metastability and entropy | Bistable resolution | F | D | H | L | The conventional baseline XC-19 must beat |
| XC-34 | Cells outside their intended use | Delay cells as vernier, contention | F | D | M | L | Tooling |
| XC-35 | Die identity | Mismatch | F | D | M | L | Idea |
| XC-36 | Consumer architectures | Coupled oscillators, race logic and others | F | D | | | Not cells: they use cells |

Working notes for each family (the full chain from mechanism to experiment) are kept in Spanish and will be added here as each
family gets a pre-registration.
