# Lithography, aerial image only: what prints when the drawing breaks the width and spacing rules

Exploratory, run on 2026-11-12 after its prediction was written
([`XC-01_2026-11-12_litografia_imagen_aerea.md`](../../cells/preregistros/XC-01_2026-11-12_litografia_imagen_aerea.md), no prior commit).
`litho.py` writes `litho.txt`. Abbe imaging, binary dark-line mask, constant threshold calibrated so that a long 0.14 um line prints
at 0.14 um. **Assumed, from memory: 248 nm; numerical aperture 0.60 and 0.70; coherence 0.5 and 0.8.** No resist, no etch, no
correction applied by the fab. This is a map of where to look, not a prediction of silicon.

| Prediction | Result | |
|---|---|---|
| 1. Long neck drawn at 0.14 prints 0.14; a short one (0.14 long) prints over 20 % wider | Long: 0.135 to 0.145. Short: 0.27 to 0.35, twice the drawn width | held |
| 2. Neck of 0.10, long: under 0.08 or open. Neck of 0.07, long: open everywhere | 0.10: open, open, 0.050, 0.074. 0.07: open in all four | held |
| 3. Neck of 0.07, 0.14 long: a continuous bridge of 0.06 to 0.12 | Continuous in all four, but 0.17 to 0.32 wide: the heads merge | **failed**: no sub-minimum constriction there |
| 4. Facing ends of a 0.14 line: open at 0.14, bridged at 0.05, setting-dependent at 0.07 and 0.10 | Open at 0.14, 0.10 and 0.07 in all four; bridged at 0.05 (0.03 to 0.075 wide) and at 0.03 (0.09 to 0.11) in all four | held at the ends of the range, wrong in the middle |

Not pre-registered, seen in the table (exploratory):

- Between a neck length of 0.14 and 0.30 um an under-width neck goes from "heads merged, about 0.3 um wide" to "open". The
  sub-minimum bridge exists only inside that window, and where it sits depends on the optical setting (0.10 wide, 0.30 long:
  0.09 at coherence 0.8, open at 0.5).
- A legal neck, 0.14 wide and 0.30 long, prints from 0.115 to 0.175 depending on the setting: narrower than the minimum in two
  of the four.
- Facing ends of 0.50 um lines bridge at a gap of 0.10 in all four settings, and at the legal 0.14 in one of them.

Abandonment criterion (sign of 3 or 4 changing between settings): not met for the stated cases. The position of the window is
setting-dependent, so the simulation says which dimension to sweep finely, not which value to draw.
