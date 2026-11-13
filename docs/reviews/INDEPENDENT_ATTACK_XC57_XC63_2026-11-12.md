# Independent attack: XC-57 to XC-63 (12 Nov 2026)

**Status:** mathematical/literature review only. No silicon measurement, no new PDK extraction or TCAD run. Do not treat calculations below as calibrated SKY130 predictions. This is a review of candidate hypotheses described in the working laboratory; the public catalogue checked during this review still listed XC-01 through XC-36. Do not silently insert these entries into or renumber the catalogue.

## Scope and evidence discipline

A useful physical observation need not beat an existing standard cell. Scientific controls and a reproducible signal are required; commercial comparison is optional. Preserve hypotheses that fail in one vehicle as candidates for other vehicles. "DRC pass" and "manufacturing permission" are not interchangeable. Distinguish simulated post-formation devices from actual permitted stress of a shared shuttle.

## XC-58: sampled thermal kT/C noise

For an equilibrated sampling network with effective capacitance C at temperature T,

    sigma_V^2 = k_B*T/C_eff.

At 300 K: C=2.3 fF -> sigma_V=1.342 mV; 5 fF -> 0.910 mV; 10 fF -> 0.644 mV; 20 fF -> 0.455 mV; 100 fF -> 0.204 mV; 135 fF -> 0.175 mV.

At 2.3 fF the RMS charge fluctuation is sqrt(k_B*T*C)/e = 19.3 elementary charges. This is *not* a single-electron device and not a certificate of quantum randomness. The relevant capacitance includes MOS gate/source/drain, clock feedthrough and routing, not only the drawn capacitor. The sample switch can inject correlated charge; the sense amplifier contributes additional noise, and one-bit threshold output alone does not directly measure an analog voltage variance.

**Minimal discriminating experiment:** independent C values; sample/hold switch; variable calibrated comparator threshold or equivalent analog readout; dummy reference for switch feedthrough; different sample dwell/clock periods. Record bit probability vs calibrated threshold for each C and T. Fit measured variance versus 1/C_eff, allowing reader-noise intercept. Autocorrelation and independent-sample rate must be characterized; if marketed as entropy, use NIST SP 800-90B methods and continuous health tests. Control: deterministic input through same comparator. Pre-register model, noise floor, and mismatch before running.

**Potentially fatal observation:** bit variability tracks clock feedthrough or reader flicker/offset rather than 1/C_eff; no measurable temperature trend after independently establishing C_eff and reader floor.

Source: Berkeley, *Noise in Switched-Capacitor Sensing Circuits* (appendix), https://www2.eecs.berkeley.edu/Pubs/TechRpts/1998/Archive/ERL-98-48.pdf

## XC-57: thermoelectric Peltier junction

First-order junction heat depends on current sign, Qdot_Pi = (Pi_A-Pi_B)*I = (S_A-S_B)*T*I. Ordinary Joule heat is I^2 R and does not reverse sign. That distinction is more useful than an estimate of how much a junction can "cool." For an **illustrative only** Seebeck contrast of 100 microV/K at 300 K, |Delta Pi|=30 mV; at 1 mA, |Qdot_Pi|=30 microW, versus 100 microW of Joule heat for R=100 ohm. These assumed material parameters are NOT calibrated to SKY130.

**Discriminating experiment:** matched interfaces with +I, -I, 0, and resistively matched dummy paths; high-sensitivity on-chip thermometry; finite-element heat sinking to substrate. Extract odd-in-I and even-in-I thermal responses across several currents and frequencies. Ensure current reversal does not modify electrical self-heating or reader offset via different driver conduction.

**Potentially fatal observation:** predicted antisymmetric temperature signal lies below calibration/reader drift after substrate thermal conduction.

Background: CMOS-compatible thermoelectric thin-film characterization, https://pubs.aip.org/aip/rsi/article/94/10/105002/2914227/Thermoelectric-transport-properties-of-Si-SiGe-and

## XC-59: charge-trap writing / thermal erase

A thermal relaxation rate may be approximated as Gamma(T)~Gamma0*exp(-Ea/k_B T) for a particular trap; there is no reason to assume one barrier or one mechanism across an unknown defect distribution. Heating can also irreversibly create new traps or accelerate conventional ageing. The heat source's thermal profile and return to baseline are part of the experiment.

**Discriminating experiment:** separate "write", "read", and "thermal perturbation" paths; spatially matched heat-only and electrical-only controls; repeat multiple temperatures and dwell times; quantify retention and irreversible drift. Do not apply unapproved stress to a shared shuttle.

**Potentially fatal observation:** thermal effects cannot be separated from ordinary transient threshold drift or permanent damage.

## XC-60: magnetodiode

Classical field perturbation scales initially with the Hall angle mu B. For **illustrative** mobility 0.1 m^2/(V s) and B=2 mT, mu B=2e-4. It is not evidence of a measurable magnetodiode signal; geometry, carrier lifetime, interface recombination and reader sensitivity control the result.

**Discriminating experiment:** rotate and reverse B, reverse carrier injection where appropriate, include equivalent Hall plate and non-magnetic electrical controls; test temperature, current and die orientation. A current shift under B alone does not discriminate a novel mechanism.

**Potentially fatal observation:** signal is explained by standard Hall, offset or temperature effects within error.

## XC-61: carrier freeze-out as oscillator mechanism

Carrier freeze-out in wells/substrate and cryogenic kinks are experimentally reported in bulk CMOS; behavior varies strongly with doping, field and temperature. A 300 K BSIM parameter set should not be extrapolated to 4 K as a validated prediction. Device-level changes are not automatically a stable oscillator.

**Discriminating experiment:** first model and measure well resistance vs T with independent four-terminal taps and an appropriate cryogenic vehicle; only then design a feedback oscillator and compare with an otherwise equivalent conventional oscillator. Note packaging and cryostat availability.

**Potentially fatal observation:** freeze-out introduces drift and loss of controllability without a reproducible limit cycle.

Sources: https://ietresearch.onlinelibrary.wiley.com/doi/10.1049/el.2019.1099 ; https://www.nature.com/articles/s44287-025-00157-7

## XC-62: lithographic proximity-programmed poly

A DRC-clean mask is not a calibrated prediction of the printed geometry. Distinguish width variation, line-end shortening, orientation, poly-density loading, and well/STI interactions. Standard electrical extraction may omit the as-printed contour.

**Discriminating experiment:** legal arrays with deliberate variation of poly surroundings while keeping nominal W/L, source/drain geometry and contact arrangements controlled. Use optical/lithographic simulation as hypotheses only until calibrated. Measure paired device current/Vth distributions and check if ordinary layout effects already explain the result.

**Potentially fatal observation:** no repeatable dependence above mismatch and gradient once controls are included.

## XC-63: nominally unimplanted metal-to-silicon contact

Do not infer a bare-metal Schottky barrier from a GDS polygon. The physical contact may include Ti/TiN liner, tungsten plug, local silicide, implantation and oxide-cleaning steps. Device rules may require diffusion and doping around the contact. The actual band alignment and Fermi-level pinning are unknown.

**Discriminating experiment:** first establish which legal mask combinations produce an accessible silicon/metal interface, confirmed with full DRC/LVS/process description; then simulate plausible barriers and include ohmic and junction controls. No layout claiming a Schottky primitive until its physical stack is shown.

Sources: https://sky130-process-tech.readthedocs.io/en/latest/steps/097-ti-tin1.html ; https://sky130-process-tech.readthedocs.io/en/latest/steps/098-csil.html . This reconstruction distinguishes documented numbers from process inferences.

## XC-20 cross-check requested by the working agent

The reported "Dutta, TSMC 65nm, 23 microA per micrometre at 1.8 V" is **unverified** in this review. Searches did not locate a primary document establishing all of author, process, device geometry, bias and normalized current. A separate reference uses 23 microA/um for a proposed gated-heterojunction NDR device at 0.4 V, demonstrating why an isolated number is not a valid calibration point. Do not silently adopt or reject the Dutta claim; retrieve its actual figure/table first.

Calibrating a reverse-bias band-to-band-tunnelling component to total diode current is not identification: thermal diffusion, Shockley–Read–Hall generation, trap-assisted tunnelling, surface leakage and impact ionization may coexist. Koga & Toriumi demonstrates a planar Esaki precedent, not a SKY130-specific junction doping profile. Before interpreting NDR, require independent forward I-V, reverse I-V, temperature dependence and realistic concentration gradients with error bounds.

Source on four-way leakage decomposition: https://www.sciencedirect.com/science/article/abs/pii/S0038110109002512

## Proposed immediate order (research gates, not rejection hierarchy)

1. XC-58: calibrate C_eff, switch feedthrough and reader noise; cheapest closed-loop prediction.
2. XC-62 and XC-63: full-rule legal structures and process-stack identity before allocating silicon.
3. XC-57 and XC-60: quantitative signal-to-artifact budgets and differential controls.
4. XC-59: retention/thermal-window model with independently controlled stress.
5. XC-61: vehicle and cryogenic measurement prerequisite.
6. XC-20: locate primary "Dutta" evidence before treating the reported 23 microA/um as a calibration anchor.

**Graduation remains open-ended:** instrument-valid → phenomenon discriminated → controllable behavior → reusable function and limits. A genuinely new physical regime may be worth measuring even before a function is known.
