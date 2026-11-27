"""Enmienda 1 del plan nocturno 2026-11-26: los tres decks mudos del bloque S (tt 27, 1,70 V) y un control, con .ic en el cerrojo."""
import os
H = os.path.dirname(os.path.abspath(__file__))
CASOS = ["bajo_tt27_v1.70_cal_1.0000e-10", "bajo_tt27_v1.70_oos_3.1623e-09", "alto_tt27_v1.70_cal_1.0000e-08", "bajo_tt27_v1.70_cal_1.0000e-08"]
for c in CASOS:
    s = open(os.path.join(H, "S", c, "lec.sp")).read().splitlines(); j = s.index(".ic v(o_x)=1.70"); s[j] += " v(o_q)=0 v(o_qb)=1.70"; s[0] += " · enmienda 1"
    d = os.path.join(H, "S_enm1", c); os.makedirs(d, exist_ok=True); open(os.path.join(d, "lec.sp"), "w").write("\n".join(s) + "\n")
print("decks:", len(CASOS))
