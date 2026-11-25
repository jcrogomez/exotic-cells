"""E2 (enmienda 3): acoplo a XA de cada tira S7 de longitud l, de la extraccion plana. Misma regla que i4/caps_s78.py: la red
nueva (ausente en el sano) con mayor acoplo a XA. Salida: caps_e2.json, caps_e2.txt"""
import json, os, sys
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "i4"))
os.chdir(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "i4"))
src = open("caps_s78.py").read().split("XA = ")[0]; exec(src)
XA = "xc19_slot_w_0.xc19_slot_core_0.XA"
ok = caps("ext/tile_flat.pex.spice"); okn = {a for a, b in ok}
R, txt = {"21.6": json.load(open("caps_s78.json"))["S7_XA"]}, []
for L in ("4.0", "8.0"):
    C = caps(f"../e2/ext_S7L{L}/tile_flat.pex.spice")
    new = sorted(((b, v) for (a, b), v in C.items() if a == XA and b not in okn), key=lambda x: -x[1])
    R[L] = new[0][1]; txt.append(f"S7 l={L} um: red {new[0][0]} a XA {new[0][1]*1e18:.2f} aF; otras nuevas: {[(b, round(v*1e18,2)) for b, v in new[1:3]]}")
txt.append(f"S7 l=21.6 um: {R['21.6']*1e18:.2f} aF (caps_s78.json)")
json.dump(R, open("../e2/caps_e2.json", "w"), indent=1); open("../e2/caps_e2.txt", "w").write("\n".join(txt) + "\n"); print("\n".join(txt))
