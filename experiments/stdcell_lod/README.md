# How wrong is the open flow about the standard cells? (night plan, block N1)

Run on 2026-11-11 against [`PLAN_2026-11-11_noche.md`](../../cells/preregistros/PLAN_2026-11-11_noche.md). Model and extraction only.

Every cell of `sky130_fd_sc_hd` was extracted from the layout shipped with the PDK (`extract_all.tcl`) and annotated with
[`residual/lod_annotate.py`](../../residual/README.md) (`annotate_all.py`). Per-device result: `devices.csv`.

## Coverage

437 cells. 415 annotated. 10 have no transistors. 11 are decoupling or diode cells whose source and drain are the same node,
a format the tool does not read yet. 1 is hierarchical. Of the cells with transistors the tool handles 97 %.

## What the layouts say

8319 transistors. The shorter of the two diffusion sides has a median of 0.68 um and a minimum of 0.25 um; the model's
reference is 1.04 um. In 19 % of the transistors both sides are shorter than the reference. `inv_1` has 0.26 um on both sides
of both transistors.

Prediction: single-finger cells have 0.2 to 0.5 um. Held for `inv_1` (0.26 um).

## What the model then says

The two transistors of `inv_1` at their real geometry against the default (`devices_inv1.sp`):

| | Threshold | Saturation current |
|---|---|---|
| nfet 0.65/0.15 | +31.3 mV | -5.1 % |
| pfet (hvt) 1.0/0.15 | -88.5 mV in magnitude | +15.6 % |

The two move in opposite directions: short diffusion slows the nfet and speeds up the pfet.

Seven-stage rings of extracted cells, as extracted and annotated (`rings.sp`, `rings.txt`):

| Cell | As extracted | Annotated | Change |
|---|---|---|---|
| `inv_1` | 397.7 ps | 377.5 ps | 5.1 % faster |
| `inv_2` | 366.3 ps | 354.5 ps | 3.2 % faster |
| `nand2_1` | 502.4 ps | 489.8 ps | 2.5 % faster |
| `nor2_1` | 814.6 ps | 781.4 ps | 4.1 % faster |

**Prediction: 2 to 10 % slower. Failed in sign.** We had not read the pfet coefficients; the pfet gain outweighs the nfet loss.

## What this does and does not show

It shows that, by the PDK's own model, a SPICE simulation of an extracted standard cell is off by a few per cent in speed and by
tens of millivolts in threshold, because the extractor drops two parameters the model uses.

It does not show that the library timing is wrong. If the timing files were characterised against measured silicon, or with
netlists that carried these parameters, the effect is already inside them and annotating would count it twice. We have not
established how the library was characterised. It also does not show that silicon follows the model.

## Reproduce

```
P=<path to sky130A>; W=<empty work directory>
cp extract_all.tcl $W/ && docker run --rm -v $W:/work -v $P:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c \
  'cd /work && magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc extract_all.tcl'
python3 annotate_all.py $W
docker run --rm -v "$PWD":/work -v $P:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c \
  'cd /work && ngspice -b rings.sp && ngspice -b devices_inv1.sp'
```
