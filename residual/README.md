# Residual

Software that compares model and silicon. It starts by recovering layout context that the open extraction flow drops.

## Module 1: `lod_annotate.py`

Magic's sky130A extraction writes `l w as ad ps pd` for each MOSFET and omits `sa` and `sb`, the distances from the gate to the
edge of the diffusion. The BSIM4 stress model then runs at its reference geometry for every transistor
([audit](../experiments/lod_audit/README.md)). This tool measures those distances in the layout and writes them on the matching
instances.

```
python3 lod_annotate.py cell.mag cell.ext cell.spice -o cell.lod.spice
```

Inputs are the three files Magic already produces for a flat cell. Standard library only.

**What it does.** For each gate it finds the channel direction, walks the active area outwards on both sides (across neighbouring
gates, as the model defines it), and for diffusion whose length changes across the width it combines the strips as
`1/(S + L/2) = sum_i (w_i/W) / (s_i + L/2)`. Instances are matched to layout devices by model, terminals, width and length.

**Checked.**

- `tests/run.py`: seven layouts with lengths known by construction (symmetric, asymmetric, vertical channel, two fingers,
  L-shaped diffusion, pfet). All pass. Regenerate the layouts with `tests/cases.tcl`.
- End to end (`experiments/lod_audit/sim/end_to_end.sp`): the two audit netlists simulate 0.0 mV apart as extracted and
  31.09 mV apart after annotation, the value obtained by writing the parameters by hand.

**Not done yet.**

- `sd` and bent gates. Hierarchical cells must be flattened in Magic first.
- The strip formula is the BSIM4 one as we remember it; it has not been checked against the manual `[?]`. The L-shaped test
  checks the decomposition, not the formula.
- Parallel identical devices with different `sa/sb` are assigned in file order, with a warning.
- Only the 1.8 V devices have been exercised.
- Next context to recover: distance to the well edge, antenna ratio per fabrication step.
