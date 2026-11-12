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
| **Exotic Cells** | The open library: layout generator, model, prediction and limits for each cell | Catalogue of candidates, no cell graduated |
| **Test chip** (name to be decided) | A mixed-signal Tiny Tapeout chip that measures the candidates in silicon | Architecture proposal |
| **Residual** | Software that compares model and silicon, starting by recovering layout context the extraction flow drops | First problem confirmed by a reproducible run, no code yet |

Target: Tiny Tapeout on SKY130, analog/mixed-signal 2x2 tile, shuttle TTSKY27a.

## Read next

- [`docs/MOTIVATION.md`](docs/MOTIVATION.md): why do this, what counts as exotic, design primitives and rules.
- [`docs/PIPELINE.md`](docs/PIPELINE.md): the standard Tiny Tapeout flow, and what we add to each step.
- [`docs/PROPOSAL.md`](docs/PROPOSAL.md): the chip, the candidate cells, open decisions and risks.

## Conventions

Public documents are in English. Working notes are in Spanish. A number exists only if it comes from the PDK, a reproducible run
or a source we have read; otherwise it is marked `[?]`. Licence: to be decided before the first cell is published.
