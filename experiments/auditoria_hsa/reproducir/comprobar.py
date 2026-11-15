#!/usr/bin/env python3
"""Juzga la reproducción mínima de la auditoría HSA.

    python3 comprobar.py A/minimo.log B/minimo.log esperado.txt        # juzga
    python3 comprobar.py A/minimo.log B/minimo.log esperado.txt --escribe   # (re)genera esperado.txt; solo a mano

Tres juicios, todos deben pasar:
1. Modo: A dice «No compatibility mode selected!» y B dice «Compatibility modes selected: hs a».
2. Mecanismo (cifras de la auditoría, §3, escritas antes de este script): diferencia de vth B - A
   pfet_hvt 0,42/0,5 con sa/sb -7,957 mV (±0,05); nfet 1/1 con sa/sb +2,242 mV (±0,05; de original/minimos/t0 y t1/bin4.log, a la
   misma polarización: el texto de la auditoría decía «+1,8 a +2,2», corregido); pfet_hvt 0,42/0,18 -17,7 mV (±0,2);
   controles (pfet_hvt 0,42/0,5 sin sa/sb, nfet 0,42/0,15 con sa/sb): |diferencia| < 1e-6 V.
3. Regresión: cada número de A y de B igual al de esperado.txt con tolerancia relativa 1e-4 (ngspice imprime 6 cifras).
"""
import re, sys

NOMBRES = ["n15s", "n1s", "p5s", "p5", "p18"]

def lee(log):
    txt = open(log).read()
    out = {}
    for tag in ("MINVTH", "MINID"):
        m = re.findall(r"^%s (.+)$" % tag, txt, re.M)
        if not m:
            sys.exit("%s: falta la línea %s" % (log, tag))
        out[tag] = [float(v) for v in m[-1].split()]
        if len(out[tag]) != 5:
            sys.exit("%s: %s con %d valores" % (log, tag, len(out[tag])))
    return txt, out

def main():
    la, lb, esp = sys.argv[1:4]
    ta, a = lee(la)
    tb, b = lee(lb)
    fallos = []
    if "No compatibility mode selected!" not in ta:
        fallos.append("A no corrió sin modo")
    if "Compatibility modes selected: hs a" not in tb:
        fallos.append("B no corrió en modo hsa")
    dv = {n: (b["MINVTH"][i] - a["MINVTH"][i]) * 1e3 for i, n in enumerate(NOMBRES)}  # mV
    print("diferencia de vth B - A (mV): " + "  ".join("%s %+.4f" % (n, dv[n]) for n in NOMBRES))
    did = {n: (b["MINID"][i] / a["MINID"][i] - 1) * 100 for i, n in enumerate(NOMBRES)}
    print("diferencia de corriente B/A - 1 (%): " + "  ".join("%s %+.3f" % (n, did[n]) for n in NOMBRES))
    if abs(dv["p5s"] + 7.957) > 0.05: fallos.append("p5s: %+.4f mV, la auditoría dice -7,957" % dv["p5s"])
    if abs(dv["n1s"] - 2.242) > 0.05: fallos.append("n1s: %+.4f mV, los logs originales dan +2,242" % dv["n1s"])
    if abs(dv["p18"] + 17.7) > 0.2: fallos.append("p18: %+.4f mV, la auditoría dice -17,7" % dv["p18"])
    for n in ("p5", "n15s"):
        if abs(dv[n]) > 1e-3: fallos.append("control %s cambia: %+.6f mV" % (n, dv[n]))
    if "--escribe" in sys.argv:
        with open(esp, "w") as f:
            for modo, d in (("A", a), ("B", b)):
                for tag in ("MINVTH", "MINID"):
                    f.write("%s %s %s\n" % (modo, tag, " ".join("%.6g" % v for v in d[tag])))
        print("escrito", esp)
    else:
        ref = {}
        for l in open(esp):
            p = l.split()
            ref[p[0], p[1]] = [float(v) for v in p[2:]]
        for modo, d in (("A", a), ("B", b)):
            for tag in ("MINVTH", "MINID"):
                for i, (g, w) in enumerate(zip(d[tag], ref[modo, tag])):
                    if abs(g - w) > 1e-4 * max(abs(w), 1e-30):
                        fallos.append("%s %s %s: %g, esperado %g" % (modo, tag, NOMBRES[i], g, w))
    if fallos:
        print("FALLA:\n  " + "\n  ".join(fallos))
        sys.exit(1)
    print("ok: modos correctos, mecanismo como en la auditoría, números como en esperado.txt")

if __name__ == "__main__":
    main()
