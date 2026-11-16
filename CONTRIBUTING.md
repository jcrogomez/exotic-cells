# Contributing

Exotic Cells is an open hunt for usable, unconventional physics in a standard CMOS process (SKY130). You can help in four ways.

## Good first tasks

Small, self-contained, and each one changes something real. Pick one, say so in an issue, and write down what you find with
its source. Codes refer to [`docs/OPEN_QUESTIONS.md`](docs/OPEN_QUESTIONS.md).

| Task | Skills | What it unblocks |
|---|---|---|
| Find and read a paper on e-fuses in processes **without silicide on poly**, or in metal / TiN; write what it says about clean opening and rejoining (Q10, P8) | Literature | Whether the e-fuse (XC-01 → XC-05) is worth area |
| Read Moxim et al. 2022 (APL 120, 063502) and extract the size of spin-dependent recombination at room temperature in silicon (P6) | Literature, device physics | Whether XC-52 gets any area |
| Read the subfolders of `TinyTapeout/tt-multiplexer/pg/sky130` and `iic-jku/sky130_power_gate`: on-resistance and pulse rating of the tile power switches (A7) | Reading layouts or SPICE | The droop model behind "no reading during pulses" |
| Run the short verifier check of [`REGENERAR.md`](experiments/xc20_hipotesis_r3/verificacion/REGENERAR.md) on Linux and report whether the line matches to the last digit | Python | Cross-machine reproducibility (`[?]` today) |
| Build a toy problem with exact mutual information where the difference of two Barber-Agakov lower bounds **overshoots** the true difference | Information theory, Python | How much to trust every "this structure adds X bits" ([research agenda §3](docs/RESEARCH_AGENDA.md)) |
| Propose a digital readout for a Kelvin strip that keeps the four-terminal property (material vs contact and switch resistance) | Analog design | Checking silicide in silicon without paying for analog pins |
| Attack an open family (🟡): XC-39, XC-55, XC-24, XC-18 have no attack round yet | Any of the above | A new family turns green, or dies with its reason |

The bigger picture of what is open is the [research agenda](docs/RESEARCH_AGENDA.md); what each cell would make possible is in
[architectures](docs/ARCHITECTURES.md).

## 1. Propose a family

Open an issue or a pull request with:

- **Mechanism**: the physics, in one sentence, and why the standard library does not offer it.
- **Observable**: what you would measure, with which readout, and how big you expect it to be.
- **What kills it**: the most boring explanation, and the number that would rule the idea out.
- **Vehicle**: does it fit the 1.8 V digital flow with custom macros (D), does it need analog pins or 3.3 V (H), or a bare die,
  light, cryogenics or high voltage (S)? Any vehicle is welcome; the vehicle classifies, it does not reject.

If accepted, the family gets the next free `XC-nn` (identifiers are never reused), a row in the catalogue in
[`README.md`](README.md#catalogue) marked 🟡, and a folder `cells/xcNN_name/` with a `PLAN.md` copied from
[`cells/PLANTILLA.md`](cells/PLANTILLA.md). Run `python3 tools/catalogue_json.py` after editing the table.

## 2. Attack a family

Pick a 🟡 family, or a 🟢 one whose plan lists open questions.

1. Write a pre-registration first: prediction, controls, and what would kill the idea
   ([`cells/preregistros/`](cells/preregistros/README.md)). Date it with the real time.
2. Work in a new folder `experiments/attack_xcNN/` with your own prefix on every file.
3. Start with the boring explanation. Use the PDK, ngspice, Magic, KLayout, the Tiny Tapeout precheck, or a physical model you
   state. Process data already gathered is in [`cells/notas/DATOS_PROCESO.md`](cells/notas/DATOS_PROCESO.md).
4. End with a report (`*_INFORME.md` or `REPORT.md`) that says, for every claim, whether it is computed, simulated, read in a
   source or assumed.

## 3. Verify an attack

Verification is what turns a family green. Write your own code, and fix your numbers (with the time) **before** reading the
attacker's scripts. Then compare, explain every difference, and say what you read and when. Rules:
[`experiments/PROTOCOLO_ATAQUES.md`](experiments/PROTOCOLO_ATAQUES.md).

## 4. Improve the tools

[`residual/`](residual/README.md) (model versus silicon), [`tools/`](tools/), and the CI checks.

## Rules that are not negotiable

- **No invented numbers.** A number comes from the PDK, a reproducible run or a source you have read. Otherwise write `[?]`.
- **Separate what is observed, demonstrated and conjectured.** A model without calibration gives intervals and scenarios, not a
  value.
- **Correct in place, with a date.** Wrong statements are not silently rewritten: they are marked `[corrected <date>]`.
- **Do not delete other people's results.** Generated outputs (decks, logs, DRC reports) are not committed; scripts and reports
  are.
- **No local paths.** Scripts read the PDK from the `SKY130A` environment variable.

## Before a pull request

```
python3 residual/tests/run.py
python3 tools/check_runs.py
python3 tools/catalogue_json.py --check
python3 tools/check_docs.py
```

English or Spanish are both fine. By contributing you agree that your work is released under Apache-2.0.
