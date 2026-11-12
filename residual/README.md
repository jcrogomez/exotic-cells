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
`1/(S + L/2) = sum_i (w_i/W) / (s_i + L/2)`. The formula is equation 14.10 of the BSIM4 manual (read in the BSIM4.8.0 edition, section 14.2). The same manual states that
with `SA` or `SB` not given or not positive the stress effect is turned off, which is what the audit observed.

Each instance is tied to one layout device through everything the netlist shows: model, gate, source, drain and body nodes,
width, length and the source/drain area and perimeter Magic recorded for that device. If no layout device fits, the tool stops. Instances identical in
every netlist parameter are interchangeable, so their order cannot change the circuit.

**Checked.**

- `tests/run.py`: eight layouts with lengths known by construction (symmetric, asymmetric, vertical channel, two fingers,
  L-shaped diffusion, pfet, and two parallel devices that differ only in diffusion length), and ten netlists the tool must
  refuse: wrong area, body, gate, width or model, a multiplier (`m`, `mult`) or finger count, missing areas, an extra device.
  All pass. Regenerate the layouts with `tests/cases.tcl`. This is a regression test: the expected values come from the
  geometry we drew, so it is not an independent validation.
- End to end (`experiments/lod_audit/sim/end_to_end.sp`): the two audit netlists simulate 0.0 mV apart as extracted and
  31.09 mV apart after annotation, the value obtained by writing the parameters by hand. This is a model prediction, not a
  silicon measurement.
- The whole standard-cell library ([`experiments/stdcell_lod`](../experiments/stdcell_lod/README.md)): 415 of 437 cells
  annotated, 8319 transistors.
- Our own readout cell ([`cells/xc19_read`](../cells/xc19_read/README.md)).

An external review on 2026-11-11 found that the body node was not part of the match: a netlist with the wrong body was
accepted. It is now, and the rejections above were added because of it.

## Module 2: `drc_edge`

Finds where the legal edge of a geometry is and which rule sits there, in Magic and in KLayout:
[`drc_edge/README.md`](drc_edge/README.md).

**Not done yet.**

- `sd` and bent gates. Hierarchical cells must be flattened in Magic first. Devices whose source and drain are the same node
  (decoupling cells) are not read.
- Independent validation against another extractor or against silicon.
- `NF > 1` instances: Magic writes one instance per finger, which is what the tool assumes.
- Whether the standard cells were characterised with these parameters. Until that is known, annotated and library timing must
  not be mixed.
- Only the 1.8 V devices have been exercised.
- Next context to recover: distance to the well edge, antenna ratio per fabrication step.
