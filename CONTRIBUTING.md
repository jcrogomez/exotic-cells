# Contributing

Exotic Cells is an open hunt for usable, unconventional physics in a standard CMOS process (SKY130). You can help in four ways.

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
```

English or Spanish are both fine. By contributing you agree that your work is released under Apache-2.0.
