"""Plan nocturno 2026-11-25, bloque B: Monte Carlo de desajuste del lector pequeno v_f3. Escrito ANTES de abrir ningun log.
Derivado de xc19_slot_e2/analiza_mc.py (misma lectura de lineas 'MC <tirada> <estado> <chip> <tA> <tB>'). Salida: B.txt
Nominales de v_f3 (tt 27, absolutos): misfit09/tr_tt_27/m9.log (hS, tS, rS, cS). B0 se juzga con lo escrito: 6 chips identicos
y tA de e01 = 30,8832 us (desde T0) dentro de 0,01 %; los otros estados se reportan.
Formas fijadas aqui: B3 = desviacion tipica muestral de ln(tA/tB) en e01, sin el factor 100 (como el 1,204 de v_hm);
B4 = P4 / [tA/tB]e11 con P4 = [tA/tB]e10 - [tA/tB]e11, en %, sobre los chips que cruzan en e10 y e11."""
import os, re
import numpy as np
H = os.path.dirname(os.path.abspath(__file__)); T0 = 1e-6
NOM = {}
for l in open(os.path.join(H, "..", "misfit09", "tr_tt_27", "m9.log"), errors="replace"):
    f = l.split()
    if len(f) == 5 and f[0] == "M9": NOM[f[3]] = float(f[4])
NOM = {e: (NOM[k + "S_oa"], NOM[k + "S_ob"]) for e, k in (("e01", "h"), ("e01t", "t"), ("e11", "r"), ("e10", "c"))}
def lee(path):     # copia de analiza_mc.py
    d = {}; falta = set()
    for ln in open(path, errors="replace"):
        e = re.match(r"Error: &(t[ab])\d+: no such variable", ln)
        if e: falta.add(e[1]); continue
        m1 = re.match(r"MC (\d+) (\w+) (\d+) (\S+)\s*$", ln)
        if m1:
            v = float(m1[4]); d[(int(m1[1]), int(m1[3]), m1[2])] = (np.nan, v) if "ta" in falta else (v, np.nan); falta = set(); continue
        m0 = re.match(r"MC (\d+) (\w+) (\d+)\s*$", ln)
        if m0: d[(int(m0[1]), int(m0[3]), m0[2])] = (np.nan, np.nan); falta = set(); continue
        m = re.match(r"MC (\d+) (\w+) (\d+) (\S+) (\S+)", ln)
        if m:
            falta = set()
            def v(s):
                try: return float(s)
                except ValueError: return np.nan
            d[(int(m[1]), int(m[3]), m[2])] = (v(m[4]), v(m[5]))
    return d
out = []; p = out.append; SE = (2301, 2302, 2303, 2304)
p("# Noche 1125, bloque B · analiza_B.py · Monte Carlo tt_mm 27 C del lector pequeno v_f3. Tiempos desde T0 = 1 us.")
c = lee(os.path.join(H, "B", "C0", "mc.log")); ok_c = True
for e, (na, nb) in NOM.items():
    va = [c[(0, j, e)] for j in range(6) if (0, j, e) in c]
    da = max(abs(a - na) / (na - T0) for a, b in va) if va else np.nan; db = max(abs(b - nb) / (nb - T0) for a, b in va) if va else np.nan
    sp = max(max(a for a, b in va) - min(a for a, b in va), max(b for a, b in va) - min(b for a, b in va)) if va else np.nan
    ok = len(va) == 6 and da <= 1e-4 and sp == 0
    if e == "e01": ok_c &= ok
    else: ok_c &= (len(va) == 6 and sp == 0)
    p(f"  {e}: {len(va)} chips, max |tA - v_f3 nominal| = {da*100:.4f} %, max |tB - nominal| = {db*100:.4f} %, rango entre chips {sp:.3e} s -> {'ok' if ok else 'fuera'}")
va = [c[(0, j, "e01")][0] - T0 for j in range(6) if (0, j, "e01") in c]
p(f"B0 (6 chips tt identicos; tA de e01 = 30,8832 us dentro de 0,01 %): tA = {va[0]*1e6 if va else float('nan'):.4f} us -> {'cumplida' if ok_c else 'FALSA'}")
def norm(fn): return [l for l in open(fn) if not re.match(r"(\.lib|setseed|set rndseed|while i <|\*)", l.strip())]
c0n = norm(os.path.join(H, "B", "C0", "mc.sp"))
for s in SE:
    ok_n = norm(os.path.join(H, "B", f"M{s}", "mc.sp")) == c0n; ok_c &= ok_n
    p(f"Deck M{s} con el mismo circuito que C0: {'si' if ok_n else 'NO (deck invalido)'}")
nf = sum(1 for l in open(os.path.join(H, "B", "C0", "mc.sp")) if "w=5.5 l=10" in l)
p(f"Dedos de filtro en el deck (v_f3 = 3 por subcircuito): {nf}")
chips = {}
for s in SE:
    for (i, j, e), v in lee(os.path.join(H, "B", f"M{s}", "mc.log")).items(): chips.setdefault((s, i, j), {})[e] = v
p(f"Chips tt_mm: {len(chips)} (se esperan 48)")
uni = {tuple(np.round(v.get("e01", (0, 0)), 12)) for v in chips.values()}
p(f"Chips distintos (control de semilla): {len(uni)} de {len(chips)}"); ok_c &= len(uni) == len(chips) == 48
E = ("e01", "e01t", "e11", "e10"); K = sorted(chips)
ta = {e: np.array([chips[k][e][0] - T0 if e in chips[k] else np.nan for k in K]) for e in E}
tb = {e: np.array([chips[k][e][1] - T0 if e in chips[k] else np.nan for k in K]) for e in E}
for e in E: p(f"  {e}: sin cruce en 200 us (tA o tB) = {int(np.sum(np.isnan(ta[e]) | np.isnan(tb[e])))} de {len(chips)}")
sinc = np.isnan(ta["e01"]) | np.isnan(tb["e01"]); inval = sinc.mean() > 0.25
p(f"Invalido por cruces e01 (> 25 %): {'SI' if inval else 'no'} ({sinc.mean()*100:.1f} %)")
D = ta["e01t"] / ta["e01"] - 1; ok = ~np.isnan(D); aD = np.abs(D[ok]) * 100; med = np.median(aD); f90 = np.mean((aD >= 0.50) & (aD <= 1.00))
b1 = 0.70 <= med <= 0.91 and f90 >= 0.90
p(f"B1: D = tA(e01t)/tA(e01) - 1, N = {ok.sum()}: mediana abs(D) = {med:.4f} % (en [0,70, 0,91]); fraccion en [0,50, 1,00] % = {f90*100:.1f} % (>= 90) -> {'cumplida' if b1 else 'FALSA'}")
p(f"    signo de D: {int(np.sum(D[ok] < 0))} negativos de {ok.sum()}; min/max abs(D) = {aD.min():.4f} / {aD.max():.4f} %")
p(f"B2: |mediana - 0,803| = {abs(med - 0.803):.4f} puntos (< 0,03) -> {'cumplida' if abs(med - 0.803) < 0.03 else 'FALSA'}")
r = np.log(ta["e01"] / tb["e01"]); r = r[~np.isnan(r)]; s = r.std(ddof=1)
rng = np.random.default_rng(20261126); bs = np.array([r[rng.integers(0, len(r), len(r))].std(ddof=1) for _ in range(10000)])
p(f"B3: sigma ln(tA/tB) e01 = {s:.4f} [IC 95 % bootstrap {np.percentile(bs, 2.5):.4f}, {np.percentile(bs, 97.5):.4f}] (N = {len(r)}); banda [0,90, 1,51] -> {'cumplida' if 0.90 <= s <= 1.51 else 'FALSA'}")
r11 = ta["e11"] / tb["e11"]; P4 = (ta["e10"] / tb["e10"] - r11); rel = P4 / r11 * 100; okp = ~np.isnan(rel); rel = rel[okp]
b4 = len(rel) == len(chips) and np.all((rel >= 0.90) & (rel <= 1.03))
p(f"B4: paso relativo P4/[tA/tB]e11, N = {len(rel)}: min {rel.min():.4f} %, mediana {np.median(rel):.4f} %, max {rel.max():.4f} % (todos en [0,90, 1,03]) -> {'cumplida' if b4 else 'FALSA'}; fuera de banda: {int(np.sum((rel < 0.90) | (rel > 1.03)))}")
p(f"    paso absoluto P4 (lo que M5 juzgaba): min {np.nanmin(P4)*100:.4f} %, mediana {np.nanmedian(P4)*100:.4f} %, max {np.nanmax(P4)*100:.4f} %")
p(f"MUERE el lector pequeno (falla B1): {'SI' if not b1 else 'no'}")
p(f"Benchmark invalido (falla B0, decks o semilla, o > 25 % sin cruce): {'SI' if (not ok_c or inval) else 'no'}")
p("\nPor chip: semilla tirada chip | tA e01 (us) | tB e01 | ln(tA/tB) e01 | D (%) | paso relativo (%)")
for n_, k in enumerate(K):
    a, b = ta["e01"][n_], tb["e01"][n_]
    p(f"  {k[0]} {k[1]} {k[2]} | {a*1e6:.3f} | {b*1e6:.3f} | {np.log(a/b):+.4f} | {D[n_]*100:+.4f} | {(ta['e10'][n_]/tb['e10'][n_]-r11[n_])/r11[n_]*100:+.4f}")
open(os.path.join(H, "B.txt"), "w").write("\n".join(out) + "\n"); print("\n".join(out[:24]))
