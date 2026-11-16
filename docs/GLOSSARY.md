# Glossary

Short definitions for readers arriving from digital design or from Tiny Tapeout. Each points to where the term matters.

| Term | Meaning here |
|---|---|
| **Abutted junction** | p+ and n+ diffusion drawn touching, with 0 gap. Legal in SKY130 (so is ≥ 0.27 µm; nothing in between). The precursor of [XC-20](../cells/xc20_abutted_junction/PLAN.md) |
| **Antenna effect** | During plasma etching, a long metal line collects charge and dumps it on the gate it connects to. Antenna rules and diodes prevent it; [XC-14](../cells/xc14_antenna_write/PLAN.md) uses it on purpose |
| **Attack round** | An agent or a person tries to kill a family with the most boring explanation first, using the PDK, a simulator or a design-rule run ([protocol](../experiments/PROTOCOLO_ATAQUES.md)) |
| **Band-to-band tunnelling** | Electrons crossing directly from the valence band on one side of a very thin, heavily doped junction to the conduction band on the other. What a tunnel diode uses |
| **Barber-Agakov bound** | A lower bound on mutual information computed with a trained classifier. Each bound is valid; the *difference* between two of them is not a bound on the difference of the true values |
| **Boring explanation** | The ordinary cause that would produce the same reading: plain leakage, the reader itself, heat, supply droop, mismatch. Ruled out first |
| **Calibration step** | A known current, capacitor or gate step on each reader channel. If it shows up and the cell does not, the null is real |
| **E-fuse** | A thin trace blown on purpose by a current pulse: a one-time-programmable bit. The hard part is that it stays open. In the catalogue it is the XC-01 forge, and a fuse that does not open cleanly leads to the few-channel contact of [XC-05](../cells/xc05_atomic_contact/PLAN.md) |
| **Extraction** | Turning a layout into a netlist for simulation. Magic's extraction drops the diffusion-length parameters ([LOD](#lod)) |
| **Hypothesis engine** | For XC-20: a simulation of many possible chips, each read by a candidate design, scored by how much the readings tell us about the mechanism ([round 3](../experiments/xc20_hipotesis_r3/INFORME.md)) |
| **K** | In XC-20, how much tunnelling drops when the gap opens from 0 to 0.27 µm. Large K: tunnelling vanishes fast |
| **Kelvin strip** | A long resistor with four contacts, two to force a current and two to read a voltage, so contacts do not count. Measures sheet resistance; decides whether a layer is silicided |
| **kT/C noise** | The random voltage frozen on a capacitor when a switch opens: variance kT/C. Usually fought; [XC-58](../cells/xc58_ktc_cell/PLAN.md) uses it |
| <a id="lod"></a>**LOD** | Length of diffusion: how far a transistor's gate is from the edge of its active area. The isolation around it stresses the silicon and shifts the threshold. The model includes it; Magic's extraction drops it ([CLAIMS](CLAIMS.md)) |
| **Mutual information (bits)** | How much a set of readings reduces our uncertainty about something. 1 bit halves the possibilities |
| **Pre-registration** | The prediction and the criteria for success and failure, written and committed before running ([folder](../cells/preregistros/README.md)) |
| **Precursor** | What the GDS draws. Physics, or a forming step, finishes the device |
| **Reader** | The shared instrument: a cell's current discharges a precharged node and an on-chip counter times it. Built for [XC-19](../cells/xc19_single_trap/PLAN.md) |
| **Residual** | Our software that compares model and silicon; module 1 puts the LOD parameters back into extracted netlists ([residual](../residual/README.md)) |
| **RTN** | Random telegraph noise: a current or threshold that jumps between two levels as one defect captures and releases one electron |
| **Silicide** | A metal-silicon layer some processes put on diffusion and poly to lower resistance. SKY130 diffusion appears not to have it ([OPEN_QUESTIONS](OPEN_QUESTIONS.md) A1) |
| **Three regions** | What standard cells already do; what fails; and a usable unconventional behaviour in between. The catalogue hunts the third |
| **Tier** | Position in the [ranking](RANKING.md): A design now, B add if area allows, C another vehicle |
| **Verified / verified to order** | Reproduced by an independent verifier with their own code / same order of magnitude, differences explained. Never "works in silicon" |
| **Weak inversion** | A transistor biased below threshold, where current depends exponentially on gate voltage, so a 0.3 mV shift becomes ~1 % of current |
