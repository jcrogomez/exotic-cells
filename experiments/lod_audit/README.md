# LOD audit: does diffusion length reach the simulator?

Run on 2026-11-11. Model and extraction only; no silicon. The prediction and the pass/fail criteria were written before the run.

Tools: ngspice 44.2 and Magic 8.3.530 from the `hpretl/iic-osic-tools:2025.07` image. PDK: sky130A, open_pdks commit
`8afc8346a57fe1ab7934ba5a6056ea8b43078e71`, mounted at `/pdk`.

## Result

**Extraction (`lod.tcl`).** Two `nfet_01v8` devices, W/L = 0.42/0.15 um, with 0.30 um and 3.0 um of diffusion on each side of the
gate. Both are DRC clean in Magic. The extracted netlists differ only in `as/ad/ps/pd`:

```
lod_sa030: X0 D G S VSUBS sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15
lod_sa300: X0 D G S VSUBS sky130_fd_pr__nfet_01v8 ad=1.26 pd=6.84 as=1.26 ps=6.84 w=0.42 l=0.15
```

Magic does not emit `sa`, `sb` or `sd`.

**Simulation (`sim/lod_paso1.sp`, tt, 27 C, Vgs = 0.9 V, Vds = 0.05 V).**

| W/L (um) | `sa = sb` (um) | Vth (V) | Shift vs 1.04 | Predicted | Linear Id | Saturation Id (1.8/1.8 V) |
|---|---|---|---|---|---|---|
| 0.42/0.15 | 0 (default) | 0.774446 | 0 | | same | same |
| 0.42/0.15 | 0.30 | 0.797944 | +23.50 mV | +23.5 mV | -18.1 % | -4.2 % |
| 0.42/0.15 | 1.04 (`saref`) | 0.774446 | 0 | 0 | ref | ref |
| 0.42/0.15 | 3.0 | 0.766855 | -7.59 mV | -7.6 mV | +6.1 % | +1.4 % |
| 5/0.15 | 0.30 | 0.741206 | +33.35 mV | | -20.3 % | -5.1 % |
| 5/0.15 | 3.0 | 0.697078 | -10.77 mV | | +6.6 % | +1.7 % |

- `sa = sb = 0` gives exactly the reference geometry. Zero is a switch-off, not a distance: a control instance with
  `sa = sb = 0.3e-6` um (almost zero) gives Vth = 0.9396 V.
- The open flow therefore simulates every extracted transistor as if it had 1.04 um of diffusion on each side, while the PDK's own
  model says the two layouts above differ by 31.1 mV (44.1 mV at W = 5 um).

**Mismatch (`sim/lod_paso4_mm.sp`, `tt_mm`, 300 draws).** Sigma of Vth for one device: 17.3 mV (0.42/0.15) and 5.13 mV (5/0.15).
One pair of wide devices per level separates the effect at 6 sigma; minimum devices would need 16 pairs per level. This assumes the
PDK mismatch model holds and ignores die gradients.

**End to end (`sim/end_to_end.sp`).** The two extracted netlists simulate 0.0 mV apart as Magic wrote them and 31.09 mV apart
after [`residual/lod_annotate.py`](../../residual/README.md) adds `sa` and `sb`.

## Open

- Whether silicon follows the model.
- `sd`, multi-finger devices, pfet and lvt/hvt variants.
- Whether the standard cells were characterised with or without these parameters.

## Reproduce

```
P=<path to sky130A>
docker run --rm -v "$PWD":/work -v "$P":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c \
  'cd /work && magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc lod.tcl'
cd sim
docker run --rm -v "$PWD":/work -v "$P":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c \
  'cd /work && ngspice -b lod_paso1.sp && ngspice -b lod_paso4_mm.sp'
```

Comments inside the scripts are in Spanish.
