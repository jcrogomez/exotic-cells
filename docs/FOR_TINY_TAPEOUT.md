# For Tiny Tapeout folks: the short version

I'm Juan, pretty new to chip design. This project is kind of backwards. Standard cells are built by suppressing everything the
process does that nobody asked for: leakage, traps, plasma charging, stray light. The design rules say what you're *allowed*
to draw, and standard cells only use a small slice of it. I'm poking at the legal corners nobody draws, to see whether any of
that "junk" can be drawn on purpose and turned into something useful.

If a corner works, even a little, it's a new device in an open PDK. If it doesn't, I still learn something about SKY130 that
isn't written down anywhere, and that's useful for anyone designing on it.

## What's been done (no silicon yet)

- Simulations with the open PDK, DRC runs in Magic and KLayout, the TT precheck, and small physics models in Python.
- Before each run I write down the prediction and what would kill the idea.
- Every idea is attacked first with the most boring explanation (it's just normal leakage, it's the reader, it's heat).
  Whatever survives gets re-checked by a second, independent implementation. Of 64 ideas, 15 survived.
- One side finding: Magic's extraction drops the diffusion-length (LOD) stress info, so two layouts the model separates by
  ~31 mV extract to the same netlist.

## How it's measured: all digital

Each cell discharges a small precharged node, and an on-chip counter times it. The TT board just reads counters (modelled
floor around 0.15 pA). Every cell has a known calibration current next to it, so "calibration seen, cell not" is a real null.
A hot plate (and maybe a borrowed SMU) would only be for heating and calibrating.

## The three I'd put on the chip first

1. **p+ touching n+, a tunnel diode nobody draws.** DRC allows 0 gap or ≥ 0.27 µm, nothing in between. At 0 gap, two heavily
   doped regions touching could let electrons tunnel straight through. The layout is 0, 0.27, 0.54 and 1.08 µm plus a cell
   with no junction. Win: 0 gap leaks far more than 0.27 µm, scales with edge length, barely cares about temperature. Lose: it
   tells me how sharp the edge doping really is.
2. **One electron in one defect.** One oxide trap shifts a threshold ~0.3 mV; a transistor in weak inversion turns that into
   ~0.8 % of the discharge time. Win: discrete on/off jumps. Lose: a bound on traps per transistor, which isn't published.
   This is also the reader for everything else.
3. **Floating gates the fab writes by itself.** Gates on antennas of different sizes with no discharge path, next to twins
   with the diode. Win: the threshold at first power-up tracks antenna size. Lose: in-rule antennas leave nothing readable,
   or the anneal wipes it.

The full ranking, with every other candidate and what would move it up, is in [RANKING](RANKING.md). The questions we
still have are in [OPEN_QUESTIONS](OPEN_QUESTIONS.md); answers from the community have already moved two of them.
