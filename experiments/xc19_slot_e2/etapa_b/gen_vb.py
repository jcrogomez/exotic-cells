"""MISFIT-03 etapa b, calculo de DISENO (sin prediccion ni veredicto): tA y la trampa frente a la tension de puerta del DUT de A.
Cada instancia (variante 'trap' del macro v_hm) lleva la puerta del DUT de A en GT = v(VB) + desplazamiento + 0,305 mV * k.
Desplazamientos: OFF (V). Estados: k = 0 y k = 1, src = 01. Salida: 'VB <k> <desplazamiento> <tA> <tB> <vb>' (absolutos, T0 = 1 us).
Uso: XC19_INC=<lod.inc del v_hm> gen_vb.py <esquina> <temp> <carpeta> [tstop_us]"""
import os, sys
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "xc19_slot"))
import gen_contrato as G
assert "xc19_slot_core_a2" in os.environ.get("XC19_INC", ""), "XC19_INC debe apuntar al macro v_hm (leccion de la v2 del Monte Carlo)"
c, t, out = sys.argv[1], sys.argv[2], sys.argv[3]
TS = sys.argv[4] if len(sys.argv) > 4 else "1000"
OFF = [-0.20, -0.15, -0.10, -0.05, 0.0, 0.05]
s = G.HEAD.format(kind="etapa b: tA frente a la puerta del DUT", c=c, t=t) + G.VARS["trap"]
s += f"Vd vdd 0 1.8\nVh hi 0 1.8\nVpre pre 0 pwl(0 1.8 {G.T0} 1.8 {G.T0 + 1e-9} 0)\nVs1 s1 0 0\nVs0 s0 0 1.8\nVk k 0 0\n"
P = []
for i, o in enumerate(OFF):
    p = f"g{i}"; P.append((p, o))
    s += G.slot(p, "trap", "vdd", "vdd", "hi", "pre", "s1", "s0")
    old = f"B{p}_gt {p}_GT 0 V=v({p}_VB)+{G.TRAP}\n"; assert old in s
    s = s.replace(old, f"B{p}_gt {p}_GT 0 V=v({p}_VB)+({o})+{G.TRAP}*v(k)\n")
c_ = [".control", "set noaskquit", "save " + " ".join(f"v({p}_oa) v({p}_ob) v({p}_VB)" for p, _ in P)]
for k in (0, 1):
    c_ += [f"alter Vk dc = {k}", f"tran 20n {TS}u 0 50n"]
    for j, (p, o) in enumerate(P):
        c_ += [f"meas tran ta{j} when v({p}_oa)=0.9 rise=1", f"meas tran tb{j} when v({p}_ob)=0.9 rise=1",
               f"meas tran vb{j} find v({p}_VB) at=0.9e-6", f"echo VB {k} {o} $&ta{j} $&tb{j} $&vb{j}"]
c_ += ["quit", ".endc", ".end"]
s += "\n".join(c_) + "\n"
os.makedirs(out, exist_ok=True); open(os.path.join(out, "vb.sp"), "w").write(s); print("ok", c, t, out)
