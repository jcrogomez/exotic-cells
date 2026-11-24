"""MISFIT-03 enmienda 2: ruido de disparo en transitorio sobre el slot (macro v_hm + decodificador), sin desajuste.
M instancias identicas en un deck; en cada una, una fuente trnoise de corriente en XA y otra en XB, con densidad unilateral
2 q I (I = corriente de descarga nominal de su rama, de la corrida de diseno: I = C_X (VDD - 0,896 V) / t). Repite L veces
con reset (ruido nuevo, mismo circuito). Amplitud por instancia: k * sqrt(q I / NT), con k = 0 (control: debe dar el nominal),
1 (la medida) o 3 (testigo: sigma debe triplicarse).
Uso: XC19_INC=<lod.inc> gen_ruido.py <c> <t> <src: 01|11> <tA_us> <tB_us> <M> <L> <k> <semilla> <carpeta>
Salida del deck: 'RN <l> <j> <tA> <tB>'"""
import os, sys, math
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "xc19_slot"))
import gen_contrato as G
c, t, src, tA, tB, M, L, k, seed, out = sys.argv[1:11]
tA, tB, M, L, k = float(tA) * 1e-6, float(tB) * 1e-6, int(M), int(L), float(k)
q, CX, NT = 1.602e-19, 151.3e-15, 10e-9                 # C_X: experiments/xc19_slot_e2/prereg_calc/calc.txt
IA, IB = CX * (1.8 - 0.896) / tA, CX * (1.8 - 0.896) / tB
s1, s0 = {"01": ("0", "hi"), "11": ("hi", "hi")}[src]
s = G.HEAD.format(kind=f"enmienda 2 ruido src={src} k={k}", c=c, t=t) + G.VARS["core"]
s += f"Vd vdd 0 1.8\nVh hi 0 1.8\nVpre pre 0 pwl(0 1.8 {G.T0} 1.8 {G.T0 + 1e-9} 0)\n"
for j in range(M):
    p = f"n{j}"
    s += G.slot(p, "core", "vdd", "vdd", "hi", "pre", s1, s0)
    for side, I in (("XA", IA), ("XB", IB)):
        na = k * math.sqrt(q * I / NT)
        s += f"I{p}{side} {p}_{side} 0 dc 0 trnoise({na:.4e} {NT:.1e} 0 0)\n"
tstop = max(tA, tB) * 1.1 + G.T0
c_ = [".control", "set noaskquit", f"set rndseed={seed}", "save " + " ".join(f"v(n{j}_oa) v(n{j}_ob)" for j in range(M)),
      "let l = 0", f"while l < {L}", "  reset", f"  tran 10n {tstop:.4e} 0 10n"]
for j in range(M):
    c_ += [f"  meas tran a{j} when v(n{j}_oa)=0.9 rise=1", f"  meas tran b{j} when v(n{j}_ob)=0.9 rise=1", f"  echo RN $&l {j} $&a{j} $&b{j}"]
c_ += ["  let l = l + 1", "end", "quit", ".endc", ".end"]
os.makedirs(out, exist_ok=True); open(os.path.join(out, "ruido.sp"), "w").write(s + "\n".join(c_) + "\n")
print("ok", src, f"IA {IA*1e9:.3f} nA IB {IB*1e9:.3f} nA, NA {k*math.sqrt(q*IA/NT):.3e} A", out)
