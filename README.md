# Exotic Cells

An open library of physical primitives that the SKY130 standard library does not offer. Made in TaiJuan.

> The GDS draws a precursor. Physics finishes the device. Engineering turns the result into a primitive.

Standard cells are built by suppressing everything a process does that was not asked for: leakage, stress, traps, parasitics,
plasma charging. Exotic Cells starts from the opposite question: **which of those unwanted behaviours can be drawn on purpose,
predicted, measured, and turned into a component?**

## Status: proposal

Nothing here has been fabricated. This repository holds the motivation, the design pipeline, the chip proposal and one
reproducible result: an audit showing that the open extraction flow drops the layout parameters of the STI stress model
([`experiments/lod_audit`](experiments/lod_audit/README.md)). Results are added only when they come from a reproducible run.

| Piece | What it is | State |
|---|---|---|
| **Exotic Cells** | The open library: layout generator, model, prediction and limits for each cell | 36 candidate families, no cell graduated |
| **MISFIT** | The test chip: a Tiny Tapeout chip that measures the candidates in silicon. Not a MOSFET: a misfit | Architecture proposal |
| **Residual** | Software that compares model and silicon, starting by recovering layout context the extraction flow drops | Module 1 written and tested: stress geometry annotator. Model prediction only, no silicon |

MISFIT is an experimental vehicle on Tiny Tapeout (SKY130). Its first integration route is the digital flow with custom physical
macros: digital first, not digital only. The selection of structures, their controls and the measurement they need will decide
whether the tapeout uses a hybrid template, analog pins, another supply, or more than one die.

## Layout of this repository

| Path | What |
|---|---|
| [`docs/MOTIVATION.md`](docs/MOTIVATION.md) | Why do this, what counts as exotic, design primitives and rules |
| [`docs/PIPELINE.md`](docs/PIPELINE.md) | The standard Tiny Tapeout flow, and what we add to each step |
| [`docs/PROPOSAL.md`](docs/PROPOSAL.md) | MISFIT: the chip proposal, open decisions and risks |
| [`cells/CATALOGUE.md`](cells/CATALOGUE.md) | The candidate families, with stable identifiers |
| [`cells/notas/FICHAS.md`](cells/notas/FICHAS.md) | Exploratory working notes for each family, in Spanish |
| [`cells/preregistros/`](cells/preregistros/README.md) | Pre-registrations, dated before their experiments run |
| [`residual/`](residual/README.md) | Residual: the software. Module 1 annotates extracted netlists with stress geometry; module 2 maps the legal edge of a geometry |
| [`cells/xc19_read/`](cells/xc19_read/README.md) | First layout: the readout cell of XC-19, rule-clean and extracted |
| [`tools/`](tools/) | `check_runs.py` judges the committed runs; `manifest.sh` records the environment of a run |
| [`experiments/`](experiments/) | Reproducible runs, each against a prediction written first: [LOD audit](experiments/lod_audit/README.md), [standard cells](experiments/stdcell_lod/README.md), [XC-19 readout](experiments/xc19_weak_inversion/README.md), [XC-19 noise and detection](experiments/xc19_noise/README.md) |

## Conventions

Public documents are in English. Working notes are in Spanish. A number exists only if it comes from the PDK, a reproducible run
or a source we have read; otherwise it is marked `[?]`. Licence: Apache-2.0 (see `LICENSE` and `NOTICE`).
