"""MISFIT-11 etapa 1: veredictos M1-M5 con las palabras del prerregistro. Lee lo que dejo generator/run.sh. Salida: m11.txt"""
import os, re
H = os.path.dirname(os.path.abspath(__file__)); o = ["# MISFIT-11 etapa 1 · analiza_m11.py · matrices generadas por generator/matrix.py"]
def info(d, n, ref=None):
    p = os.path.join(H, d); log = open(os.path.join(p, n + ".log")).read()
    drc = int(re.search(r"^DRC \S+ violations=(\d+)", log, re.M)[1]); bb = [int(x) * 0.005 for x in re.search(r"^BBOX (.*)", log, re.M)[1].split()[:4]]
    kl = [open(os.path.join(p, f)).read().count("<item>") for f in ("klayout_mr.lyrdb", "klayout_full.lyrdb")]
    ng = open(os.path.join(p, f"netgen_{ref or n + '_ref'}.txt")).read(); m = re.search(r"Final result:\s*\n?(.*)", ng)
    return drc, kl, (m[1].strip() if m else "sin resultado"), bb
def devs(path):
    r = []
    for l in open(path):
        f = l.split()
        if f and f[0][0] == "X" and "nfet" in l: r.append((f[1], f[2], f[3], dict(kv.split("=") for kv in f[6:] if "=" in kv)))
    return r
# M1
u = devs(os.path.join(H, "u1", "u1.lvs.spice")); rd = devs(os.path.join(H, "..", "..", "cells", "xc19_slot_core_a2", "v_f3", "xc19_slot_core.lvs.spice"))
sw_r = [d for d in rd if d[1] == "DUTA"][0]; s = [n for n in (sw_r[0], sw_r[2]) if n != "GND"][0]
dut_r = [d for d in rd if s in (d[0], d[2]) and d[1] == "VB"][0]
sw_u = [d for d in u if d[1] == "SEL0"][0]; dut_u = [d for d in u if d[1] == "VB"][0]
K = ("w", "l", "ad", "as", "pd", "ps"); m1 = all(dut_u[3].get(k) == dut_r[3].get(k) and sw_u[3].get(k) == sw_r[3].get(k) for k in K)
o.append("M1: dispositivo  generado " + " ".join(f"{k}={dut_u[3].get(k)}" for k in K) + " | lector " + " ".join(f"{k}={dut_r[3].get(k)}" for k in K))
o.append("    interruptor  generado " + " ".join(f"{k}={sw_u[3].get(k)}" for k in K) + " | lector " + " ".join(f"{k}={sw_r[3].get(k)}" for k in K))
o.append(f"M1 (mismos W, L, areas y perimetros que el lector): {'cumplida' if m1 else 'FALSA'}")
m2 = True; A = {}
for n in ("u1", "u16", "u64", "lod12"):
    drc, kl, lvs, bb = info(n, n); ok = drc == 0 and kl == [0, 0] and lvs.startswith("Circuits match"); m2 &= ok or n == "u1"
    ns = len(open(os.path.join(H, n, n + "_seats.csv")).readlines()) - 1; a = (bb[2] - bb[0]) * (bb[3] - bb[1]); A[n] = a / ns
    o.append(f"{n}: {ns} puestos | Magic drc(full) {drc} | KLayout mr {kl[0]}, completo {kl[1]} | LVS: {lvs} | caja {bb[2]-bb[0]:.3f} x {bb[3]-bb[1]:.3f} um = {a:.1f} um2, {a/ns:.2f} um2 por puesto -> {'ok' if ok else 'FALLA'}")
o.append(f"M2 (u16, u64 y lod12 limpias y con LVS match, sin editar a mano): {'cumplida' if m2 else 'FALSA'}")
mw = info("u16", "u16", "u16_mutw")[2]; mn = info("u16", "u16", "u16_mutn")[2]
pw = "Property errors" in open(os.path.join(H, "u16", "netgen_u16_mutw.txt")).read()
okw = not mw.startswith("Circuits match") or pw; okn = not mn.startswith("Circuits match")
o.append(f"M3 mutante W = 0,50 en un puesto: '{mw}'{' + Property errors were found' if pw else ''} -> {'detectado' if okw else 'NO detectado'}")
o.append(f"M3 mutante con un puesto de menos: '{mn}' -> {'detectado' if okn else 'NO detectado'}")
o.append(f"M3: {'cumplida' if okw and okn else 'FALSA'}")
d4 = info("u16_pitch", "u16")[0]; log = open(os.path.join(H, "u16_pitch", "u16.log")).read(); w = re.search(r"^   (.*?)  @", log, re.M)
o.append(f"M4 (testigo: paso 0,10 um menor): Magic da {d4} error(es){': ' + w[1] if w else ''} -> {'cumplida' if d4 > 0 else 'FALSA'}")
o.append(f"M5 (area por puesto en u64 entre 4 y 7 um2): {A['u64']:.2f} um2 -> {'cumplida' if 4 <= A['u64'] <= 7 else 'FALSA'}")
o.append(f"Benchmark: {'valido' if okw and okn and d4 > 0 else 'INVALIDO'}")
open(os.path.join(H, "m11.txt"), "w").write("\n".join(o) + "\n"); print("\n".join(o))
