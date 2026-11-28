# SPDX-License-Identifier: Apache-2.0
"""Floorplan of the re-placed reader 2 block and of the unit (block + reader2fe). One place for every coordinate (um).
plano.py <out dir> writes template.def (die area and signal pins) for LibreLane's FP_DEF_TEMPLATE."""
import sys
W, H = 46.92, 46.24                       # die: 92 sites x 15 rows of core plus margins of 2.30 and 2.72
CORE = (2.30, 2.72, 44.62, 43.52)
S = {"prenh": 20.93, "prenl": 25.07, "x": 27.83}          # bottom edge, metal-2 tracks nearest to reader2fe's pins
N = {"en": 9.43, "pre": 12.19, "src[0]": 14.95, "src[1]": 17.71, "xa": 30.59, "xb": 33.35}
DIR = {"prenh": "OUTPUT", "prenl": "OUTPUT", "x": "INPUT", "en": "INPUT", "pre": "INPUT", "src[0]": "INPUT", "src[1]": "INPUT", "xa": "OUTPUT", "xb": "OUTPUT"}
# reader2fe (MISFIT-22), local coordinates of its metal-1 pin pads: (x0, y0, x1, y1)
FE = {"PRENH": (1.185, 6.405, 1.585, 6.805), "PRENL": (5.125, 6.405, 5.525, 6.805), "X": (7.910, 4.435, 8.310, 4.835),
      "VDD": (7.480, 6.865, 7.880, 7.265), "GND": (1.800, -0.715, 2.200, -0.315)}
YB = 10.0                                 # y of the block's bottom edge in the unit
FEO = (S["x"] - 8.11, 1.0)                # origin of reader2fe in the unit: its X pin centre under the block's x pin
if __name__ == "__main__":
    for v in list(S.values()) + list(N.values()): assert abs((v - 0.23) / 0.46 - round((v - 0.23) / 0.46)) < 1e-6, v
    u = lambda v: int(round(v * 1000)); L = ["VERSION 5.8 ;", 'DIVIDERCHAR "/" ;', 'BUSBITCHARS "[]" ;', "DESIGN reader2_slot ;", "UNITS DISTANCE MICRONS 1000 ;",
                                         f"DIEAREA ( 0 0 ) ( {u(W)} {u(H)} ) ;", f"PINS {len(S) + len(N)} ;"]
    for n, x in list(S.items()) + list(N.items()):
        y = 0.14 if n in S else H - 0.14
        L += [f"    - {n} + NET {n} + DIRECTION {DIR[n]} + USE SIGNAL", "      + PORT", "        + LAYER met2 ( -140 -140 ) ( 140 140 )", f"        + PLACED ( {u(x)} {u(y)} ) N ;"]
    L += ["END PINS", "END DESIGN"]; open(sys.argv[1] + "/template.def", "w").write("\n".join(L) + "\n")
