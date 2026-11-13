# Exotic Cells

An open catalogue of physical primitives that the SKY130 standard library does not offer, and **MISFIT**, the Tiny Tapeout
chip that will measure them. Made in TaiJuan.

> The GDS draws a precursor. Physics finishes the device. Engineering turns the result into a primitive.

Standard cells are built by suppressing everything a process does that was not asked for: leakage, stress, traps, parasitics,
plasma charging. Exotic Cells starts from the opposite question: **which of those behaviours can be drawn on purpose, predicted,
measured, and turned into a component?**

**Nothing here has been fabricated.** Every result is a calculation, a simulation with the open PDK, or a design-rule run. A
family turns green when it survives an attack that tries to kill it *and* an independent verifier who reproduces the numbers with
their own code. Green means "worth putting on silicon", not "works".

## The idea in one picture

The configuration space of SKY130 has three regions:

1. **What standard cells already do.**
2. **What fails.**
3. **A usable, unconventional physical behaviour** that is neither: quantum, magnetic, optical, spin, single charges,
   frequencies, randomness that helps conventional logic, a bridge between classical and quantum.

The catalogue hunts the third region. Each family's job is to find its two borders: with the conventional and with failure.

## Catalogue

### Legend

| | Meaning | Count |
|---|---|---|
| 🟢 | **Survived**: attacked from first principles and checked by an independent verifier; it survives, sometimes transformed. Ready to be designed for silicon | 15 |
| 🟡 | **Open**: an active family not yet attacked, or whose key number could not be verified | 8 |
| 🔵 | **Instrument**: built on the chip because other cells need it (forge, heater, pump, coil, metrology) | 14 |
| ⚪ | **Merged** into another family; kept so its identifier is never reused | 18 |
| 🔴 | **Cancelled**: out of the catalogue, with the reason in its row | 8 |

Columns: **Engine** F = a wanted function looking for a mechanism, P = poorly characterised physics looking for what emerges.
**Vehicle** D = digital flow plus custom macros at 1.8 V, H = hybrid (analog pins, 3.3 V), S = specialised (bare die, light,
cryogenics, high voltage); the vehicle classifies, it does not reject. **U / I** = expected usefulness / physical information
gained even if no function comes out (judgements, not measurements). The catalogue stays open: new families are welcome, and
filtering happens at the end.

### Map by physics

| Physics | Active families | Enabled by |
|---|---|---|
| Quantum, and the classical-quantum bridge | XC-20 silicon tunnel junction; XC-05 few-channel metal contact; XC-06 self-formed Coulomb island; XC-54 superconducting local interconnect | XC-01 forge; cryostat for XC-54 |
| Single charges | XC-19 single defect (oxide, junction, interface); XC-14 floating node | XC-10 ageing; XC-53 pump |
| Spin and magnetism | XC-52 spin-pair magnetoresistance; XC-25 Hall plate as a magnetic link | XC-56 microcoil |
| Optics | XC-26 internal optical link; XC-27 hole arrays in reflection; XC-21 avalanche and Geiger emitters | XC-23 control; XC-53 pump |
| Frequencies | XC-24 parasitic bipolar oscillator; XC-39 heat as signal; XC-55 phonons in the metal stack; the tunnel oscillator of XC-20 | XC-31 heater |
| High field | XC-07 oxide breakdown and filament; XC-18 field-oxide transistor | XC-53 pump |
| Heat | XC-57 Peltier junction; XC-59 electrical write, thermal erase | XC-31 heater |
| Noise as a resource | XC-58 kT/C cell | the XC-19 reader |
| Interfaces and printing | XC-60 magnetodiode; XC-62 proximity-printed transistor; XC-63 unimplanted contact | XC-56 microcoil |
| Cold | XC-54 superconducting interconnect; XC-61 freeze-out oscillator | cryostat |

### All identifiers

Identifiers are stable: an `XC-nn` is never reused. Each family name links to its folder, which holds its plan: first
principles, readout and noise floor, the boring explanation and its controls, simulation, layout and bench tests, and what is
still open.

| | ID | Family | Mechanism | Engine | Vehicle | U | I | State |
|---|---|---|---|---|---|---|---|---|
| 🔵 | XC-01 | [Metal-1 constriction](cells/xc01_m1_constriction/PLAN.md) | Electromigration | F | D | H | H | INSTRUMENT (the forge: formation path for XC-05). Formation path verified in the flow; transformation not demonstrated |
| ⚪ | XC-02 | [Local-interconnect constriction](cells/xc02_li_constriction/PLAN.md) | Joule heating | F+P | D | H | H | MERGED into XC-01. Geometry drawn, not integrated |
| ⚪ | XC-03 | [Contact or via as the transformation site](cells/xc03_contact_site/PLAN.md) | Interface failure | P | D | M | H | MERGED into XC-01. Observation only |
| ⚪ | XC-04 | [Tunnelling nanogap](cells/xc04_tunnel_nanogap/PLAN.md) | Direct tunnelling across about 1 nm | P | H/S | M | H | MERGED into XC-05. Outside the range of a digital readout |
| 🟢 | XC-05 | [Atomic contact](cells/xc05_atomic_contact/PLAN.md) | Transport through a few channels | P | S | L | M | CELL. Round 2: a map by material instead of a verdict. Metal 1 is bridged by its barrier (20 to 240 ohm per um, verified); a local-interconnect neck heats to roughly 500 to 1800 K with 4 to 8 mA (verified); low-bias reader holds 48 mV or less (verified) |
| 🟡 | XC-06 | [Coulomb island](cells/xc06_coulomb_island/PLAN.md) | Coulomb blockade | P | S | L | M | CELL. Attack round 1: the arithmetic holds; it rides on XC-05, which is still open |
| 🟡 | XC-07 | [Oxide breakdown: antifuse, filament](cells/xc07_oxide_breakdown/PLAN.md) | Dielectric breakdown | F+P | H | H | H | CELL. Round 4: out of reach at 3.3 V; plausible with the XC-53 pump; breakdown time unverifiable (7–14 decades), so the cell must sweep area and voltage. Waits for more than 1.8 V |
| ⚪ | XC-08 | [Silicon filament emitter](cells/xc08_filament_emitter/PLAN.md) | Emission from the XC-07 filament | F | H/S | M | H | MERGED into XC-07. Depends on XC-07 |
| ⚪ | XC-09 | [Charge-trap transistor](cells/xc09_charge_trap/PLAN.md) | Hot-carrier trapping | F | H | H | M | MERGED into XC-14. No SKY130 data |
| 🔵 | XC-10 | [Ageing at 1.8 V](cells/xc10_ageing/PLAN.md) | BTI and HCI | P | D | M | M | INSTRUMENT (creates traps for XC-19 and, after attack round 1, for XC-52). No design |
| ⚪ | XC-11 | [Single-poly floating gate](cells/xc11_floating_gate/PLAN.md) | Injection and tunnelling | F | H | H | L | MERGED into XC-14. Waits for a charge pump |
| 🔵 | XC-12 | [Diffusion-length stress (LOD)](cells/xc12_lod_stress/PLAN.md) | STI mechanical stress | P | D | M | H | INSTRUMENT (process metrology; Residual). Extraction gap confirmed; annotator applied to the whole standard-cell library; model prediction only |
| 🔵 | XC-13 | [Well proximity (WPE)](cells/xc13_well_proximity/PLAN.md) | Extra doping near the well edge | P | D | M | H | INSTRUMENT (process metrology). Not in the model card |
| 🟢 | XC-14 | [Antenna as a fab-time write](cells/xc14_antenna_write/PLAN.md) | Plasma charge on a floating gate | F+P | D | H | H | CELL. Round 4, verified to order: on 4.15 nm oxide the plasma charge tunnels away (no fab-time memory); the residual drifts ~mV/day and tracks oxide thickness (clock / thickness gauge, conjecture). On 11.6 nm oxide it does not tunnel; survival through anneal unknown |
| ⚪ | XC-15 | [Antenna factorial](cells/xc15_antenna_factorial/PLAN.md) | Plasma damage to gate oxide | P | D | M | H | MERGED into XC-14. Experiment defined |
| 🔵 | XC-16 | [Placement environment](cells/xc16_placement/PLAN.md) | Neighbours, orientation, density | P | D | L | M | INSTRUMENT (process metrology). Real diffusion lengths of every library cell now known (`experiments/stdcell_lod`) |
| 🔴 | XC-17 | [Electrode by design](cells/xc17_electrode/PLAN.md) | Parasitic capacitance | P | D | L | M | OUT (a parasitic capacitor: standard-cell territory). Low priority |
| 🟡 | XC-18 | [Field-oxide transistor](cells/xc18_field_oxide_fet/PLAN.md) | Parasitic channel under isolation | F | H | M | M | CELL. Threshold unknown |
| 🟡 | XC-19 | [Single trap (RTN)](cells/xc19_single_trap/PLAN.md) | Capture and emission at one defect | F+P | D/H | H | H | CELL. Reader simulated against four pre-registrations and drawn as a rule-clean channel; working point revised for shot noise; no trap demonstrated, no silicon |
| 🟢 | XC-20 | [Abutted p+/n+ junction](cells/xc20_abutted_junction/PLAN.md) | Band-to-band tunnelling | P | D/H | M | H | CELL. Round 2: reverse tunnelling at zero separation is the firm observable (tens of nA to tens of uA at 1.8 V per 1.4 um, verified to the order of magnitude); negative resistance left open, it depends on a doping profile that is not public |
| 🟢 | XC-21 | [Avalanche junction as emitter](cells/xc21_avalanche_emitter/PLAN.md) | Reverse breakdown | F | H/S | M | M | CELL. Round 4: drawn-gap knob dead; drawn corner 6.6–9.7 V verified to order; with a pump 3–37 pA (one agent). Waits for high voltage |
| ⚪ | XC-22 | [SPAD](cells/xc22_spad/PLAN.md) | Geiger-mode avalanche | F | H/S | M | M | MERGED into XC-21. Waits for high voltage |
| 🔵 | XC-23 | [Lateral multi-terminal junction](cells/xc23_lateral_junction/PLAN.md) | Minority-carrier diffusion | P | H | M | H | INSTRUMENT (control of XC-26 (carriers before photons)). Stated only; also the control for XC-26 |
| 🟡 | XC-24 | [Parasitic bipolar and PNPN](cells/xc24_parasitic_bipolar/PLAN.md) | Thyristor feedback | F | H | M | M | CELL. Latch-up risk |
| 🟢 | XC-25 | [Well Hall plate](cells/xc25_hall_plate/PLAN.md) | Hall effect | F | H | M | L | CELL. Attack round 1: with the microcoil it is the most solid result of the round; Hall voltage 0.017 to 0.66 mV per mA depending on unknown well doping |
| 🟢 | XC-26 | [On-chip optical link](cells/xc26_optical_link/PLAN.md) | Radiative recombination in a forward junction | P | D/H | M | H | CELL. Round 4, verified to order: lives only with the emitter well at ~+1 V and substrate ≤10 Ω·cm (0.21–0.42 pA at 5 µm vs 0.15 pA floor); dies at ≥20 Ω·cm or cathode grounded |
| 🟢 | XC-27 | [Metal hole arrays](cells/xc27_hole_arrays/PLAN.md) | Sub-wavelength apertures; diffraction at pitch near the wavelength | P | D/S | M | H | CELL. Round 4, verified to order: a cap changes only the escape cone, +1–4 %; needs ≥5 pA and <1 % matching. Reflection variant with the internal emitter of XC-26 entered 2026-11-12; depends on XC-26 emitting and on fill blocking; transmission still needs light on the die |
| 🔴 | XC-28 | [Waveguides in the dielectric](cells/xc28_waveguides/PLAN.md) | Guiding in the metal stack oxide | F | S | M | M | OUT (needs post-processing). Needs die access |
| 🔴 | XC-29 | [Physical nanopores](cells/xc29_nanopores/PLAN.md) | to be written | P | S |  |  | OUT (never defined). Named only |
| ⚪ | XC-30 | [Mesoscopic coherence](cells/xc30_mesoscopic/PLAN.md) | to be written | P | S |  |  | MERGED into XC-54. Named only |
| 🔵 | XC-31 | [Heat as a channel](cells/xc31_heat_channel/PLAN.md) | Self-heating and thermal diffusion | F+P | D | M | M | INSTRUMENT (temperature knob and control). Unverified estimate |
| 🔵 | XC-32 | [Supply-network coupling](cells/xc32_supply_coupling/PLAN.md) | Supply droop | P | D | L | M | INSTRUMENT (supply control). The boring explanation every coupling experiment must rule out |
| 🔴 | XC-33 | [Metastability and entropy](cells/xc33_metastability/PLAN.md) | Bistable resolution | F | D | H | L | OUT (done with standard cells). The conventional baseline XC-19 must beat |
| 🔵 | XC-34 | [Cells outside their intended use](cells/xc34_offlabel_cells/PLAN.md) | Delay cells as vernier, contention | F | D | M | L | INSTRUMENT (readout tooling). Tooling |
| 🔴 | XC-35 | [Die identity](cells/xc35_die_identity/PLAN.md) | Mismatch | F | D | M | L | OUT (done with standard cells). Idea |
| 🔴 | XC-36 | [Consumer architectures](cells/xc36_consumers/PLAN.md) | Coupled oscillators, race logic and others | F | D |  |  | OUT (not cells). Not cells: they use cells |
| ⚪ | XC-37 | [Variable retention time](cells/xc37_retention_time/PLAN.md) | Single defect in a junction switching its leakage | P | D | M | H | MERGED into XC-19. Entered 2026-11-12; reuses the XC-19 reader; step size `[?]`; needs an array and temperature |
| ⚪ | XC-38 | [Gate-induced drain leakage](cells/xc38_gidl/PLAN.md) | Band-to-band tunnelling under the gate edge | P | D | L | M | MERGED into XC-20. Entered 2026-11-12; expected weak at 1.8 V (unread source) |
| 🟡 | XC-39 | [Electrothermal polysilicon resistor](cells/xc39_poly_electrothermal/PLAN.md) | Self-heating of a resistor with negative temperature coefficient | F+P | D | M | M | CELL. Entered 2026-11-12; coefficient read in the model card; oscillation judged unlikely, drift readable |
| ⚪ | XC-40 | [Thermopile](cells/xc40_thermopile/PLAN.md) | Seebeck effect between polysilicon and diffusion next to a heater | F | D | M | M | MERGED into XC-39. Entered 2026-11-12; the reader's own thermal drift exceeds one pair: needs a differential reference |
| ⚪ | XC-41 | [Dielectric relaxation](cells/xc41_dielectric_relaxation/PLAN.md) | Charge that an oxide or MiM capacitor gives back after discharge | P | D | L | M | MERGED into XC-14. Entered 2026-11-12; signal expected near the reader step; MiM variant depends on the template |
| ⚪ | XC-42 | [Floating-well transistor](cells/xc42_floating_well/PLAN.md) | Well potential set by leakage, threshold through body effect | F+P | D | M | M | MERGED into XC-14. Entered 2026-11-12; latch-up and precheck risk to be checked |
| ⚪ | XC-43 | [Charge pumping](cells/xc43_charge_pumping/PLAN.md) | Interface traps filled and emptied by gate pulses | P | D | M | H | MERGED into XC-19. Entered 2026-11-12; f·q per trap is above the modelled floor at 1 MHz; needs body bias at mid-supply |
| 🔵 | XC-44 | [Package stress](cells/xc44_package_stress/PLAN.md) | Piezoresistance of silicon under the mechanical stress of the package | F | D | M | M | INSTRUMENT (stress monitor). Entered 2026-11-12; only interpretable with an external bending control |
| ⚪ | XC-45 | [Gate-tunnelling timer](cells/xc45_tunnel_timer/PLAN.md) | Direct tunnelling through the 1.8 V gate oxide discharging a floating gate | F+P | D | M | H | MERGED into XC-14. Entered 2026-11-12; time constant `[?]`; area sweep separates it from switch leakage |
| 🔵 | XC-46 | [Isolation-corner transistor](cells/xc46_corner_fet/PLAN.md) | Parasitic edge device and narrow-width threshold shift | P | D | L | M | INSTRUMENT (control of XC-12/13). Entered 2026-11-12; partly in the model card already: a control more than a cell |
| 🔵 | XC-47 | [Model discontinuities](cells/xc47_model_gaps/PLAN.md) | Places where the open model is known to be wrong: bin edges, subthreshold hump | P | D | L | H | INSTRUMENT (model metrology; Residual). Entered 2026-11-12; upstream issue read; a job for Residual |
| 🔴 | XC-48 | [Junction-pinched well resistor](cells/xc48_pinched_well/PLAN.md) | Depletion narrowing a well resistor | F+P | D | M | M | OUT (a junction transistor: conventional physics). Entered 2026-11-12; sheet resistance spread read in the PDK; bias dependence `[?]` |
| 🔴 | XC-49 | [Particle strikes on dynamic nodes](cells/xc49_particle_strikes/PLAN.md) | Charge deposited by alpha or cosmic particles | P | D | L | L | OUT (event rate too low for one chip). Entered 2026-11-12; event rate estimated far too low for one chip (unread source) |
| ⚪ | XC-50 | [Hot-carrier transistor emitter](cells/xc50_hot_carrier_emitter/PLAN.md) | Light from hot carriers in a saturated transistor | P | D | L | M | MERGED into XC-26. Entered 2026-11-12; estimated below the reader floor (from memory, no source) |
| ⚪ | XC-51 | [Polysilicon constriction](cells/xc51_poly_constriction/PLAN.md) | Thermal rupture or migration in a polysilicon link | F | D | M | M | MERGED into XC-01. Entered 2026-11-12; published fuse used 10 mA at 3.3 V; whether SKY130 polysilicon is silicided `[?]` |
| 🟢 | XC-52 | [Spin-pair magnetoresistance](cells/xc52_spin_pair/PLAN.md) | Recombination at interface traps changes with a millitesla field | P | D | M | H | CELL. Round 2: the four-state sequence does not remove classical even-in-field terms; discrimination rests on the shape against field. Coil verified at 0.373 mT per mA. No area assigned yet |
| 🔵 | XC-53 | [High-voltage charge pump](cells/xc53_hv_pump/PLAN.md) | Dickson pump with the high-voltage devices of the PDK | F | D/H | H | L | INSTRUMENT (unlocks XC-07, 14, 18, 21). Round 4, verified: 8–10 V from 1.8 V with N=6–8, no device above 2.8 V, 15–18 % of a 1×2 tile; do not pump from 3.3 V (well exceeds 16.85 V breakdown); vertical PNP not yet modelled |
| 🟡 | XC-54 | [Superconducting local interconnect](cells/xc54_tin_superconductor/PLAN.md) | Titanium nitride may superconduct at a few kelvin | P | S | L | H | CELL. Entered 2026-11-12; costs no area (the lines exist); needs a cryostat; absorbs XC-30 |
| 🟡 | XC-55 | [Phonons in the metal stack](cells/xc55_beol_phonons/PLAN.md) | Metal gratings as acoustic mirrors around an unreleased resonator | P | D | M | H | CELL. Entered 2026-11-12; the most speculative entry; no calculation yet |
| 🔵 | XC-56 | [On-chip microcoil](cells/xc56_microcoil/PLAN.md) | Millitesla field under a metal spiral | F | D | M | L | INSTRUMENT (field source for XC-25 and XC-52). Attack round 1, verified: 0.19 to 0.26 mT per mA; about 2 mT at the DC current limit of metal 3 |
| 🟢 | XC-57 | [Peltier junction](cells/xc57_peltier_junction/PLAN.md) | Heat pumped at a junction of two materials, reversing with the current | P | D | M | M | CELL. Round 3: the odd-in-current heat survives in the model (0.2 to 7 K at the junction at 100 uA); a reader in the silicon sees about 1 % of it, so readout takes seconds |
| 🟢 | XC-58 | [kT/C cell](cells/xc58_ktc_cell/PLAN.md) | Thermal noise frozen on a small sampled capacitor | F | D | H | M | CELL. Round 3: survives as a randomness source and as a meter of 1 to 30 fF capacitances; primary thermometry not demonstrated (the observable goes as T^-1/2, verified), calibrated secondary sensitivity still to be assessed; doubles as the continuous-noise control for XC-19 |
| 🟢 | XC-59 | [Electrical write, thermal erase](cells/xc59_thermal_erase/PLAN.md) | Defects made by stress and annealed by an on-chip heater | F+P | D | M | H | CELL. Round 3: dead for a transistor with an on-chip heater (the channel gets 1 to 16 % of the heater's rise, verified); alive for a polysilicon element on oxide, or with oven erase |
| 🟢 | XC-60 | [Magnetodiode](cells/xc60_magnetodiode/PLAN.md) | Carriers deflected by a field towards a surface where they recombine faster | F+P | D | M | M | CELL. Round 3: survives with another geometry (short diode, well-substrate junction as the active face); about 1 mT from a metal 1 strip (verified); cannot be claimed to beat a Hall plate |
| 🟢 | XC-61 | [Freeze-out breakdown oscillator](cells/xc61_freezeout_oscillator/PLAN.md) | Impact ionisation of frozen-out dopants in lightly doped silicon at low temperature | P | S | L | H | CELL. Round 3: transformed into a forward diode that fires pulses at 4.2 K; nothing at 77 K (well still 6 to 37 % ionised); needs a cryostat |
| 🟢 | XC-62 | [Proximity-printed transistor](cells/xc62_proximity_fet/PLAN.md) | Lithographic rounding and pull-back changing the real gate where the drawing is legal | P | D | M | H | CELL. Round 3: legal and submittable; threshold moves 1.2 to 1.8 mV per nm of gate length (verified); would measure the residue of the fab's proximity correction |
| 🟢 | XC-63 | [Unimplanted contact](cells/xc63_schottky_contact/PLAN.md) | Metal on lightly doped silicon forms a rectifying barrier instead of an ohmic contact | F+P | D/S | M | M | CELL. Round 3: the PDK itself ships seven cells with a contact on an unimplanted tap, all on p substrate (verified); on an n-well it passes only next to a normal tap; real interface unknown |

The table is the single source of the catalogue. [`cells/catalogue.json`](cells/catalogue.json) is generated from it by
`tools/catalogue_json.py`; CI fails if the two disagree.

## How a family is worked

1. **First principles.** Write the mechanism, the observable and the numbers that would kill the idea.
2. **Pre-register** the prediction before running anything ([`cells/preregistros/`](cells/preregistros/README.md)).
3. **Attack.** An agent or a person tries to kill the family with the most boring explanation first, using the PDK, a
   simulator, a TCAD-style model or a design-rule run.
4. **Verify.** A second, independent party reproduces the key numbers with their own code, without reading the attacker's
   scripts first. Only what is reproduced is consolidated ([`experiments/PROTOCOLO_ATAQUES.md`](experiments/PROTOCOLO_ATAQUES.md)).
5. **Consolidate** into a round report and into the family's plan, with every correction dated.

The full design pipeline is in [`docs/PIPELINE.md`](docs/PIPELINE.md); the tests a family can draw on are in
[`cells/PRUEBAS.md`](cells/PRUEBAS.md).

## Repository layout

| Path | What |
|---|---|
| [`cells/`](cells/) | One folder per family (`xcNN_name/PLAN.md`), the plan template ([`PLANTILLA.md`](cells/PLANTILLA.md)), the test catalogue ([`PRUEBAS.md`](cells/PRUEBAS.md)), process data ([`notas/DATOS_PROCESO.md`](cells/notas/DATOS_PROCESO.md)), the map of the design space ([`notas/MAPA_ESPACIO.md`](cells/notas/MAPA_ESPACIO.md)) and pre-registrations. `xc19_read/`, `xc19_bias/`, `xc19_channel/` hold the first drawn layout: the readout of XC-19 |
| [`experiments/`](experiments/README.md) | Every run, each against a prediction written first: attack and verify rounds, the LOD audit, the precheck map, lithography |
| [`docs/`](docs/) | [Motivation](docs/MOTIVATION.md), [pipeline](docs/PIPELINE.md), [MISFIT chip proposal](docs/PROPOSAL.md), [exploration plan](docs/PLAN_EXPLORATORIO.md), [experiment table](docs/EXPERIMENTOS.md), [claims and evidence](docs/CLAIMS.md), [reading list](docs/READING.md) |
| [`lab/`](lab/README.md) | The lab notebook where the project started (4–12 Nov 2026): [philosophy](lab/docs/FILOSOFIA.md), decisions, the first portfolio, and the first drawn macros (constriction, cold spark, photon, LOD etch) |
| [`residual/`](residual/README.md) | Residual, the software that compares model and silicon. Module 1 annotates extracted netlists with stress geometry; module 2 maps the legal edge of a geometry |
| [`tools/`](tools/) | `catalogue_json.py` (catalogue → JSON), `check_runs.py` (judges committed simulation runs), `manifest.sh` (records a run's environment) |

## Contributing

Read [`CONTRIBUTING.md`](CONTRIBUTING.md). In short: propose a family with its mechanism and what would kill it, or attack or
verify an existing one. A number exists only if it comes from the PDK, a reproducible run or a source you have read; otherwise
write `[?]`.

## Conventions

The front pages (this README, `CONTRIBUTING.md`, `docs/MOTIVATION.md`, `docs/PIPELINE.md`, `docs/PROPOSAL.md`) are in English.
Family plans, round reports, lab notes and many experiment reports are in Spanish, the working language of the project; pull
requests in either language are welcome.

Tools used: SKY130 open PDK, Magic, KLayout, ngspice, the Tiny Tapeout precheck, Python (numpy, scipy, devsim, scikit-fem).
Scripts that read the PDK expect the environment variable `SKY130A` (the `sky130A` directory) and, for a few, `ZTASIC` (the
folder that holds the local flow).

Licence: Apache-2.0 (see [`LICENSE`](LICENSE) and [`NOTICE`](NOTICE)).
