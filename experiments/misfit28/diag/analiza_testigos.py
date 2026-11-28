"""MISFIT-28, diagnostico (exploratorio): los dos decks de MISFIT-26 (lazo sin histeresis) a paso maximo 1 us (testigo/) y 0,1 us
(diag/testigo_*_paso). Por flanco n: tiempo entre el cruce n de 0,3 V y el cruce n de 1,5 V de q. Uso: analiza_testigos.py > testigos_paso.txt"""
import os, sys
H = os.path.dirname(os.path.abspath(__file__)); sys.path.insert(0, os.path.join(H, ".."))
from lee28 import lee
for n in ("m_bajo_ff85_oos_3.1623e-10", "m_bajo_ff-40_cal_1.0000e-10"):
    for v, p in (("1 us", os.path.join(H, "..", "testigo", n)), ("0,1 us", os.path.join(H, f"testigo_{n}_paso"))):
        r = lee(os.path.join(p, "lec.log")); e = r["ed"]; T = r.get("T")
        d = [(r["eh"][k] - r["el"][k]) for k in sorted(e) if k in r["eh"] and k in r["el"]]
        print(f"{n}, paso {v}: {r['fin']}; cruces de 0,3 / 0,9 / 1,5 V: {len(r['el'])} / {len(e)} / {len(r['eh'])} (el deck mide 18 como mucho)")
        print(f"  xa - flanco 4: {r['txa'] - e[4]:+.3e} s" if "txa" in r and 4 in e else "  xa no sube", "|", f"xb - flanco 16: {r['txb'] - e[16]:+.3e} s" if "txb" in r and 16 in e else "xb no sube o falta el flanco 16")
        if T: print("  cruce n de 1,5 V menos cruce n de 0,3 V, en periodos:", " ".join(f"{x / T:.2f}" for x in d))
