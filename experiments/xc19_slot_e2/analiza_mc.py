"""MISFIT-03 enmienda 2 (sellada 2026-11-24 09:46:20), C3: Monte Carlo de desajuste. Salida: mc.txt
Entradas: mc/C0/mc.log (control, biblioteca tt) y mc/M210[1-4]/mc.log (tt_mm). Lineas 'MC <tirada> <estado> <chip> <tA> <tB>',
tiempos absolutos; aqui se restan T0 = 1 us (los cortes de la enmienda estan en tiempos desde T0).
Reglas (enmienda 2, C3 y §3):
  M1 sigma ln(tA/tB) e01: corte 0,655 (debajo n = 1,6; encima n = 1,3); IC bootstrap central 95 %, 10000 remuestreos; si el IC
     contiene el corte, sin decidir. Ademas se predice [0,45, 0,90]
  M2 igual en e11: corte 0,199; se predice [0,12, 0,30]
  M3 D = tA(e01t)/tA(e01) - 1: mediana de abs(D) en [0,70, 0,91] %, y >= 90 % de los chips con abs(D) en [0,50, 1,00] %
  M4 fraccion de chips con abs(D) * tA(e01) * 50 MHz < 10 cuentas, en [15, 50] %
  M5 [tA/tB]e10 - [tA/tB]e11: mediana dentro de +-15 % de 0,9625 %, y >= 90 % de los chips >= 0,50 %
  Control: los 6 chips de C0 identicos entre si y al contrato nominal tt 27 dentro de 0,01 %
  Testigo: en cada tirada tt_mm, los K chips dan cocientes distintos
  Muere: mediana de M5 < 0,50 %, o > 10 % de los chips con abs(D) < 0,30 %
  Invalido: falla control o testigo; > 25 % de los chips sin cruce en 200 us en e01
"""
import os, re
import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
T0, F = 1e-6, 50e6
NOM = {"e01": (31.8732e-6, 31.8689e-6), "e11": (32.6407e-6, 32.6370e-6), "e10": (32.9457e-6, 32.6375e-6),
       "e01t": (31.6236e-6, 31.8676e-6)}   # contrato a2, tt 27 (diseno/contrato.txt: h01, h11, h10, t01), absolutos


def lee(path):
    # una medida sin cruce deja "Error: &ta<j>: no such variable." antes de la linea MC, que trae entonces un solo numero
    d = {}; falta = set()
    for ln in open(path, errors="replace"):
        e = re.match(r"Error: &(t[ab])\d+: no such variable", ln)
        if e:
            falta.add(e[1]); continue
        m1 = re.match(r"MC (\d+) (\w+) (\d+) (\S+)\s*$", ln)
        if m1:
            v = float(m1[4]); i, e_, j = int(m1[1]), m1[2], int(m1[3])
            d[(i, j, e_)] = (np.nan, v) if "ta" in falta else (v, np.nan)
            falta = set(); continue
        if re.match(r"MC (\d+) (\w+) (\d+)\s*$", ln):
            m0 = re.match(r"MC (\d+) (\w+) (\d+)", ln); d[(int(m0[1]), int(m0[3]), m0[2])] = (np.nan, np.nan); falta = set(); continue
        m = re.match(r"MC (\d+) (\w+) (\d+) (\S+) (\S+)", ln)
        if m: falta = set()
        if m:
            i, e, j = int(m[1]), m[2], int(m[3])
            def v(s):
                try:
                    return float(s)
                except ValueError:
                    return np.nan
            d[(i, j, e)] = (v(m[4]), v(m[5]))
    return d


def boot(x, f, n=10000, seed=20261124):
    rng = np.random.default_rng(seed); x = np.asarray(x)
    b = np.array([f(x[rng.integers(0, len(x), len(x))]) for _ in range(n)])
    return np.percentile(b, 2.5), np.percentile(b, 97.5)


out = []; p = out.append
p("# MISFIT-03 enmienda 2, C3 (Monte Carlo tt_mm, 27 C). Tiempos desde T0 = 1 us.")
# control
c = lee(os.path.join(HERE, "mc/C0/mc.log"))
ok_c = True; filas = []
for e, (na, nb) in NOM.items():
    va = [c[(0, j, e)] for j in range(6) if (0, j, e) in c]
    n_ = len(va)
    da = max(abs(a - na) / (na - T0) for a, b in va) if va else np.nan
    db = max(abs(b - nb) / (nb - T0) for a, b in va) if va else np.nan
    sp = max(max(a for a, b in va) - min(a for a, b in va), max(b for a, b in va) - min(b for a, b in va)) if va else np.nan
    ok = n_ == 6 and da <= 1e-4 and db <= 1e-4 and sp == 0
    ok_c &= ok
    filas.append(f"  {e}: {n_} chips, max |tA - nominal| = {da*100:.4f} %, max |tB - nominal| = {db*100:.4f} %, rango entre chips {sp:.3e} s -> {'ok' if ok else 'FALLA'}")
p(f"Control (C0, tt, 6 chips): {'pasa' if ok_c else 'FALLA'}"); out += filas
# guarda anadida tras la v2 (decks generados con el macro viejo): cada deck tt_mm = C0 salvo biblioteca, semilla y tiradas
def norm(fn):
    return [l for l in open(fn) if not re.match(r"(\.lib|setseed|set rndseed|while i <|\*)", l.strip())]
c0n = norm(os.path.join(HERE, "mc/C0/mc.sp"))
for s in (2101, 2102, 2103, 2104):
    ok_n = norm(os.path.join(HERE, f"mc/M{s}/mc.sp")) == c0n
    p(f"Deck M{s} con el mismo circuito que C0: {'si' if ok_n else 'NO (deck invalido)'}")
    ok_c &= ok_n
# tt_mm
chips = {}
for s in (2101, 2102, 2103, 2104):
    d = lee(os.path.join(HERE, f"mc/M{s}/mc.log"))
    for (i, j, e), v in d.items():
        chips.setdefault((s, i, j), {})[e] = v
p(f"Chips tt_mm: {len(chips)} (se esperan 48)")
# testigo
tes = True
for s in (2101, 2102, 2103, 2104):
    for i in (0, 1):
        r = [chips[(s, i, j)]["e01"][0] / chips[(s, i, j)]["e01"][1] for j in range(6) if (s, i, j) in chips]
        if len(set(np.round(r, 9))) < len(r):
            tes = False
p(f"Testigo (cocientes distintos dentro de cada tirada): {'pasa' if tes else 'FALLA'}")
# anadido tras la v1 (semilla ignorada: las 4 semillas dieron los mismos 12 chips). No esta en la enmienda; se reporta aparte
uni = {tuple(np.round(v["e01"], 12)) for v in chips.values()}
p(f"Chips distintos entre semillas (no es criterio de la enmienda; control anadido tras la v1): {len(uni)} de {len(chips)}")
E = ("e01", "e01t", "e11", "e10")
ta = {e: np.array([chips[k][e][0] - T0 if e in chips[k] else np.nan for k in sorted(chips)]) for e in E}
tb = {e: np.array([chips[k][e][1] - T0 if e in chips[k] else np.nan for k in sorted(chips)]) for e in E}
for e in E:
    nn = int(np.sum(np.isnan(ta[e]) | np.isnan(tb[e])))
    p(f"  {e}: sin cruce en 200 us (tA o tB) = {nn} de {len(chips)}")
sinc = np.isnan(ta["e01"]) | np.isnan(tb["e01"])
inval = sinc.mean() > 0.25
p(f"Invalido por cruces e01 (> 25 %): {'SI' if inval else 'no'} ({sinc.mean()*100:.1f} %)")


def sig(e, corte, banda, nombre):
    r = np.log(ta[e] / tb[e]); r = r[~np.isnan(r)]   # sin cruce: fuera, y se reporta arriba
    s = r.std(ddof=1); lo, hi = boot(r, lambda x: x.std(ddof=1))
    dec = "sin decidir" if lo <= corte <= hi else ("n = 1,6" if hi < corte else "n = 1,3")
    p(f"{nombre}: sigma ln(tA/tB) {e} = {s:.4f} [{lo:.4f}, {hi:.4f}] (N = {len(r)}); corte {corte} -> {dec}; "
      f"banda [{banda[0]}, {banda[1]}] -> {'cumplida' if banda[0] <= s <= banda[1] else 'FALSA'}")


sig("e01", 0.655, (0.45, 0.90), "M1")
sig("e11", 0.199, (0.12, 0.30), "M2")
D = ta["e01t"] / ta["e01"] - 1; ok = ~np.isnan(D); aD = np.abs(D[ok]) * 100
med = np.median(aD); f90 = np.mean((aD >= 0.50) & (aD <= 1.00))
p(f"M3: D = tA(e01t)/tA(e01) - 1, N = {ok.sum()}: mediana abs(D) = {med:.4f} % (en [0,70, 0,91] -> {'si' if 0.70 <= med <= 0.91 else 'NO'}); "
  f"fraccion en [0,50, 1,00] % = {f90*100:.1f} % (>= 90 -> {'si' if f90 >= 0.90 else 'NO'}) -> {'cumplida' if 0.70 <= med <= 0.91 and f90 >= 0.90 else 'FALSA'}")
p(f"    signo de D: {int(np.sum(D[ok] < 0))} negativos de {ok.sum()}; min/max abs(D) = {aD.min():.4f} / {aD.max():.4f} %")
cu = np.abs(D[ok]) * ta["e01"][ok] * F
f10 = np.mean(cu < 10)
p(f"M4: cuentas de la trampa abs(D) tA(e01) 50 MHz: mediana {np.median(cu):.2f}, min {cu.min():.2f}, max {cu.max():.2f}; "
  f"fraccion < 10 = {f10*100:.1f} % (en [15, 50] -> {'cumplida' if 0.15 <= f10 <= 0.50 else 'FALSA'})")
P4 = (ta["e10"] / tb["e10"] - ta["e11"] / tb["e11"]) * 100; okp = ~np.isnan(P4); P4 = P4[okp]
m5 = np.median(P4); g5 = np.mean(P4 >= 0.50)
p(f"M5: paso P4 = [tA/tB]e10 - [tA/tB]e11, N = {len(P4)}: mediana {m5:.4f} % (+-15 % de 0,9625 = [0,8181, 1,1069] -> "
  f"{'si' if 0.8181 <= m5 <= 1.1069 else 'NO'}); fraccion >= 0,50 % = {g5*100:.1f} % (>= 90 -> {'si' if g5 >= 0.90 else 'NO'}) "
  f"-> {'cumplida' if 0.8181 <= m5 <= 1.1069 and g5 >= 0.90 else 'FALSA'}; min/max {P4.min():.4f} / {P4.max():.4f} %")
muere = m5 < 0.50 or np.mean(aD < 0.30) > 0.10
p(f"Muere: mediana M5 < 0,50 % ({'si' if m5 < 0.50 else 'no'}) o > 10 % de chips con abs(D) < 0,30 % ({np.mean(aD < 0.30)*100:.1f} %) -> {'SI' if muere else 'no'}")
p(f"Benchmark invalido: {'SI' if (not ok_c or not tes or inval) else 'no'}")
# por chip, para el informe
p("\nPor chip: semilla tirada chip | tA e01 (us) | tB e01 | ln(tA/tB) e01 | ln e11 | D (%) | cuentas trampa | P4 (%)")
for n_, k in enumerate(sorted(chips)):
    a, b = ta["e01"][n_], tb["e01"][n_]
    p(f"  {k[0]} {k[1]} {k[2]} | {a*1e6:.3f} | {b*1e6:.3f} | {np.log(a/b):+.4f} | {np.log(ta['e11'][n_]/tb['e11'][n_]):+.4f} | "
      f"{D[n_]*100:+.4f} | {abs(D[n_])*a*F:.2f} | {(ta['e10'][n_]/tb['e10'][n_]-ta['e11'][n_]/tb['e11'][n_])*100:+.4f}")
open(os.path.join(HERE, "mc.txt"), "w").write("\n".join(out) + "\n"); print("\n".join(out[:20]))
