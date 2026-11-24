"""MISFIT-03 enmienda 2: Monte Carlo de desajuste del slot (macro v_hm + decodificador en celdas), una instancia por tirada.
En cada tirada (reset = desajuste nuevo, tt_mm u otra seccion _mm) y SIN reset entre estados (mismo chip):
  e01  src = 01, sin trampa      e01t src = 01, con la trampa (puerta del DUT de A + 0,305 mV)
  e11  src = 11                  e10  src = 10
Uso: XC19_INC=<lod.inc> gen_mc.py <lib> <temp> <N> <semilla> <carpeta> [K [tstop_us]]   (lib: tt_mm, ...; 'tt' = control)
K instancias por deck (chips j = 0..K-1, cada una con su desajuste), por defecto 1 y 400 us (el humo).
Salida del deck: lineas 'MC <i> <estado> <tA> <tB>' si K = 1; 'MC <i> <estado> <j> <tA> <tB>' si K > 1 (absolutos; T0 = 1 us)"""
import os, sys
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "xc19_slot"))
import gen_contrato as G
lib, temp, N, seed, out = sys.argv[1], sys.argv[2], int(sys.argv[3]), int(sys.argv[4]), sys.argv[5]
K = int(sys.argv[6]) if len(sys.argv) > 6 else 1
TS = sys.argv[7] if len(sys.argv) > 7 else "400"
s = G.HEAD.format(kind=f"enmienda 2 Monte Carlo {lib}", c=lib, t=temp) + G.VARS["trap"]
s += f"Vd vdd 0 1.8\nVh hi 0 1.8\nVpre pre 0 pwl(0 1.8 {G.T0} 1.8 {G.T0 + 1e-9} 0)\nVs1 s1 0 0\nVs0 s0 0 1.8\nVk k 0 0\n"
P = ["m"] if K == 1 else [f"m{j}" for j in range(K)]
for p in P:
    s += G.slot(p, "trap", "vdd", "vdd", "hi", "pre", "s1", "s0")
    s = s.replace(f"B{p}_gt {p}_GT 0 V=v({p}_VB)+{G.TRAP}\n", f"B{p}_gt {p}_GT 0 V=v({p}_VB)+{G.TRAP}*v(k)\n")
assert s.count("*v(k)") == K
EST = [("e01", 0, 1.8, 0), ("e01t", 0, 1.8, 1), ("e11", 1.8, 1.8, 0), ("e10", 1.8, 0, 0)]
c = [".control", "set noaskquit", f"set rndseed={seed}", "save " + " ".join(f"v({p}_oa) v({p}_ob)" for p in P), "let i = 0", f"while i < {N}", "  reset"]
for e, s1, s0, k in EST:
    c += [f"  alter Vs1 dc = {s1}", f"  alter Vs0 dc = {s0}", f"  alter Vk dc = {k}", f"  tran 10n {TS}u 0 50n"]
    for j, p in enumerate(P):
        c += [f"  meas tran ta{j} when v({p}_oa)=0.9 rise=1", f"  meas tran tb{j} when v({p}_ob)=0.9 rise=1",
              f"  echo MC $&i {e} $&ta{j} $&tb{j}" if K == 1 else f"  echo MC $&i {e} {j} $&ta{j} $&tb{j}"]
c += ["  let i = i + 1", "end", "quit", ".endc", ".end"]
os.makedirs(out, exist_ok=True)
open(os.path.join(out, "mc.sp"), "w").write(s + "\n".join(c) + "\n")
print("ok", lib, temp, N, seed, out)
