"""MISFIT-04 enmienda 3, E2: veredictos a partir de i4/p5.txt (barrido de fase de las tiras S7, tt 27, decks con method=gear).
Escrito antes de ver p5.txt. Delta con signo = (tA/tB)_tira / (tA/tB)_q - 1, en %, con la q del mismo deck (tiempos desde T0).
Uso: python3 analiza_e2.py > e2.txt"""
import json, os
H = os.path.dirname(os.path.abspath(__file__))
T0 = 1e-6; U = 0.0807                                    # umbral de I4 a tt 27 (%)
C = json.load(open(os.path.join(H, "caps_e2.json")))
CL = {"l216": C["21.6"], "l80": C["8.0"], "l40": C["4.0"]}
def lee(fn):
    D = {}
    for l in open(fn):
        f = l.split()
        if len(f) == 4 and f[0] == "RES":
            k, v = f[3].split("="); D[k] = float(v)
    return D
# cada deck p5_j tiene su c y su q: se leen por separado
decks = {}
import glob   # anadido 12:3x: tambien los decks chicos p5c_* (los de 9 abortaron); un mismo item en dos decks: gana el ultimo
for fn in sorted(glob.glob(os.path.join(H, "..", "i4", "corridas", "p5*_*", "i4.log"))):
    decks[os.path.basename(os.path.dirname(fn)).replace("p5_", "")] = lee(fn)
r = lambda d, p: (d[p + "_oa"] - T0) / (d[p + "_ob"] - T0)
out = []; p = out.append
D = {}
# control del deck: fases 0,4,8,12,16 de l = 21,6 contra s70..s74 de p3 (tt 27)
P3 = {}
for l in open(os.path.join(H, "..", "i4", "p3.txt")):
    f = l.split()
    if f[:3] == ["RES", "tt", "27"]: k, v = f[3].split("="); P3[k] = float(v)
q3 = r(P3, "q")
REF = {f"l216f{4 * k}": (r(P3, f"s7{k}") - q3) / q3 * 100 for k in range(5)}
# anadido 2026-11-24 23:4x, despues de ver datos y declarado: el control se aplica POR DECK. Un deck cuya fase de control se aparta
# de p3 mas de 0,001 puntos no aporta ninguna fase (antes solo se comprobaba el valor final de cada fase de control). Motivo: los
# decks de 2 relojes con paso maximo de 2 ns no estaban convergidos (i4/corre_p5j.sh). Es mas estricto que lo anterior, no menos
for j, d in decks.items():
    if "q_oa" not in d or "q_ob" not in d: p(f"deck p5_{j}: SIN q (incompleto)"); continue
    q = r(d, "q")
    Dd = {k[:-3]: (r(d, k[:-3]) - q) / q * 100 for k in d if k.endswith("_oa") and k[:-3] not in ("c", "q") and k[:-3] + "_ob" in d}
    malos = [(k, Dd[k] - REF[k]) for k in REF if k in Dd and abs(Dd[k] - REF[k]) > 0.001]
    if malos:
        p(f"deck p5_{j}: FUERA, control " + ", ".join(f"{k} se aparta {dv:+.5f}" for k, dv in malos) + f"; no aporta {sorted(set(Dd) - set(REF))}"); continue
    D.update(Dd)
    H01 = [float(l.split()[3].split("=")[1]) for l in open(os.path.join(H, "..", "..", "xc19_slot", "contrato.txt"))
           if l.split()[:3] == ["RES", "tt", "27"] and len(l.split()) >= 4 and l.split()[3].startswith("h01_oa=")][0]
    cc = abs(d["c_oa"] - H01) / (H01 - T0) * 100
    p(f"deck p5_{j}: c frente al contrato {cc:.4f} % (limite 0,01 %) -> {'ok' if cc <= 0.01 else 'FALLA'}; q = {q:.7f}")
p("\n## Control del deck (limite 0,001 puntos de %)")
okc = True
for k in range(5):
    ref = (r(P3, f"s7{k}") - q3) / q3 * 100; got = D.get(f"l216f{4 * k}")
    dd = None if got is None else abs(got - ref); okc &= dd is not None and dd <= 0.001
    p(f"- fase {4*k} ns: p3 s7{k} = {ref:+.5f} %, E2 = {'—' if got is None else f'{got:+.5f}'} %, diferencia {'—' if dd is None else f'{dd:.5f}'} -> {'ok' if dd is not None and dd <= 0.001 else 'FALLA'}")
p(f"Control del deck: {'valido' if okc else 'FALLA: el deck no vale'}")
p("\n## Barrido (Delta con signo, %)")
M = {}
for pre in ("l216", "l80", "l40"):
    fs = sorted((int(k[len(pre) + 1:]), v) for k, v in D.items() if k.startswith(pre + "f"))
    p(f"- {pre} (C = {CL[pre]*1e18:.2f} aF): " + " ".join(f"{ph}:{v:+.4f}" for ph, v in fs))
    if fs: M[pre] = max(abs(v) for _, v in fs); p(f"  max |Delta| = {M[pre]:.5f} % = {M[pre]/U:.2f}x el umbral ({len(fs)} fases)")
p("\n## E2a, linealidad (cociente de maximos dentro de +-30 % del cociente de C)")
for pre in ("l80", "l40"):
    if pre in M and "l216" in M:
        rm, rc = M[pre] / M["l216"], CL[pre] / CL["l216"]
        p(f"- {pre}: max/max_21,6 = {rm:.4f}, C/C_21,6 = {rc:.4f}, desviacion {100*(rm/rc-1):+.1f} % -> {'cumplida' if abs(rm/rc-1) <= 0.30 else 'FALSA'}")
p("\n## E2b, testigo cerca del umbral (al menos una de l = 4, 8 entre 1x y 3x)")
hit = [pre for pre in ("l40", "l80") if pre in M and 1 <= M[pre] / U <= 3]
p(f"- en [1x, 3x]: {hit or 'ninguna'} -> {'cumplida' if hit else 'FALSA: benchmark invalido, hace falta otra longitud'}")
p("\n## Pendiente y acoplo minimo detectable")
for pre in M: p(f"- {pre}: {M[pre]/(CL[pre]*1e18):.6f} %/aF")
if M:
    num = sum(M[k] * CL[k] * 1e18 for k in M); den = sum((CL[k] * 1e18) ** 2 for k in M); s = num / den
    p(f"- ajuste por el origen (3 tiras): {s:.6f} %/aF -> acoplo minimo detectable = umbral / pendiente = {U/s:.1f} aF")
print("\n".join(out))
