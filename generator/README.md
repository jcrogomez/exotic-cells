# Seat-matrix generator

A table of devices in; a layout, an LVS reference and a seat list out. Nothing is drawn by hand.

```sh
export SKY130A=/path/to/sky130A          # the PDK folder
sh generator/run.sh generator/tables/u16.json out/u16
```

`run.sh` calls `matrix.py`, runs the generated script in Magic (`drc(full)`, GDS, extraction), both KLayout decks and netgen
LVS, and prints one line with the four results and the bounding box. It needs Docker (image `hpretl/iic-osic-tools:2025.07`).

## What a seat is

One nfet under test with a source switch (nfet 0.84/0.15) under it: the pair the XC-19 reader already uses. All drains join
the reader node `X`, all gates the bias `VB`, all switch sources `GND`; each switch gate is a pin `SEL<k>` on metal 2 at the
bottom edge. Substrate taps are placed by count (`tap_every`) and by distance (`tap_max`, 10 µm; the latch-up rule is 15).

## The table

```json
{"name": "lod12", "tap_every": 4,
 "seats": [{"id": "L0p3", "w": 0.42, "l": 0.15, "sa": 0.30, "sb": 0.30, "n": 2}]}
```

`w`, `l`: width and length of the device; `sa`, `sb`: diffusion on the source and drain side of the gate; `n`: replicas.
Limits: one row, `w` ≥ 0.42, `sa` and `sb` ≥ 0.30.

A second kind, `"kind": "njunction"`, draws the XC-20 cells: an n+ island (painted as a diode, so LVS counts it) with a p+ substrate
tap at distance `d` (0 = touching; `null` = no junction), and a series switch to the reader node. See `tables/xc20s.json`.
A third kind, `"kind": "pjunction"`, is the same family inside one shared n-well: a p+ island touching an n+ well tap, the well on
the reader node and the switch between the island and ground, so the junction sees the node voltage. See `tables/xc20w.json`.

## What is checked, and what is not

Checked on four tables ([report](../experiments/misfit11/RESULTADOS.md)): rule-clean in Magic and both KLayout decks, LVS match
against the generated reference, two altered references caught by LVS, a shrunk pitch caught by DRC, and a one-seat matrix whose
two devices extract identical to the reader's.

The transistor kind takes three per-seat options for the XC-19 fan (`tables/xc19fan.json`): `"bone"` (a diffusion step 0.075 µm from
the gate), `"dummy"` (unconnected poly strips on both sides) and `"butt"` (a p+ block against the source end).

Not there yet: other device kinds (the high-voltage junctions, antennas, contacts), more than one row, the selection logic, the predicted
reading of each seat, the precheck of a tile that contains a matrix.
