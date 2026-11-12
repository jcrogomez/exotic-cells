# DRC as an instrument: where exactly is the legal edge?

A design-rule check is normally a filter: pass or fail. Here it is used to measure. Given a geometry with one free dimension,
`scan.tcl` walks that dimension on the 5 nm manufacturing grid through Magic's full rule set and records, at every step, which
rules fire. `klayout_points.sh` runs the KLayout deck on chosen points and `klayout_read.py` puts both verdicts side by side.

A grid scan is used instead of bisection because legality is not monotonic: a spacing can be legal at zero, illegal in between,
and legal again.

```
docker run --rm -v "$PWD":/work -v $P:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c \
  'cd /work && PROBE=probes/pn_space.tcl OUT=out magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc scan.tcl'
python3 edges.py out
```

A probe is a few lines of Tcl: a range and a `draw {v}` procedure. See `probes/`.

## First results (night plan, block N2)

Run on 2026-11-11 against [`PLAN_2026-11-11_noche.md`](../../cells/preregistros/PLAN_2026-11-11_noche.md).

| Probe | Legal region (Magic, full rules) | Rule at the edge | KLayout manufacturing deck |
|---|---|---|---|
| Metal-1 width (control) | from 0.140 um | m1.1 | agrees |
| Local-interconnect width (control) | from 0.170 um | li.1 | agrees |
| p+ to n+ inside an n-well | exactly 0, then from 0.270 um | nsd.5a/b and difftap.3 in between | agrees |
| Diffusion beside a gate, no contact | from 0.250 um | poly.7 | **manufacturing deck reports nothing, down to 0.050 um** |
| Diffusion beside a gate, centred contact | from 0.275 um | licon.11, then licon.5a and poly.7 | **manufacturing deck reports nothing, down to 0.150 um** |

- Both controls recover the known rule values. All four numeric predictions held.
- **The prediction that the two tools agree failed, and the reason is in how the decks ship.** The PDK carries two KLayout
  decks. The manufacturing-rules deck (`sky130A_mr.drc`), the one in the table, has no rule named poly.7 or licon.11 and passes
  transistors whose diffusion extends 0.05 um beyond the gate. The full deck (`sky130A.lydrc`) has both rules, but it ships
  with its front-end section switched off (`FEOL = false` in the file), so run as shipped it also reports nothing, not even
  the diffusion spacing violation. With that switch on it agrees with Magic at both edges (`klayout_full_deck.txt`).
  Our first reading, "the KLayout deck lacks the rules", was half right; a control with a known answer on the second deck
  showed the rest. We have not checked which decks and switches the Tiny Tapeout precheck uses.

## What the control caught in our own work

The first version of the scanner reported a 0.10 um metal line as clean. Magic had been asked to check only the box left on the
last painted shape, with its default fast rule set. With the whole cell and `drc(full)` the violation appears. Rechecking our
earlier "DRC clean" cells the same way showed that the two transistors of the LOD audit violated LU.2 (no substrate tap within
15 um). They now carry a tap and pass. `recheck.tcl` does this for any existing cell.

## Limits

One free dimension at a time. A probe that is clean says nothing about rules that neither deck implements. The tool does not
yet produce the edge report of a finished cell (which rules it sits one grid step from); that gate in
[`docs/PIPELINE.md`](../../docs/PIPELINE.md) is not automated.
