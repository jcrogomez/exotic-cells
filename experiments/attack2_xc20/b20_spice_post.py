#!/usr/bin/env python3
"""b20_spice_post.py — lee b20_spice_raw/*.dat y escribe las tablas b20_spice_{A,B,C,D,E}.txt (python puro)."""
import os, math, sys

HERE = os.path.dirname(os.path.abspath(__file__))
RAW = os.path.join(HERE, "b20_spice_raw")
CORNERS = ["tt", "ss", "ff", "sf", "fs"]
TEMPS = ["m40", "27", "85"]
PTS = [(c, t) for c in CORNERS for t in TEMPS]


def load(name):
    p = os.path.join(RAW, name)
    if not os.path.exists(p):
        return None
    with open(p) as f:
        hdr = f.readline().split()
        cols = {h: [] for h in hdr}
        for line in f:
            v = line.split()
            if len(v) != len(hdr):
                continue
            for h, x in zip(hdr, v):
                cols[h].append(float(x))
    return cols


def cross(x, y, level=None, ref=None):
    """primer cruce de y con level (o con ref[i]); interpolación lineal."""
    for i in range(len(x) - 1):
        a = y[i] - (level if ref is None else ref[i])
        b = y[i + 1] - (level if ref is None else ref[i + 1])
        if a == 0:
            return x[i]
        if a * b < 0:
            return x[i] + (x[i + 1] - x[i]) * a / (a - b)
    return float("nan")


def maxgain(x, y, k=1):
    g = 0.0
    for i in range(k, len(x) - k):
        d = abs((y[i + k] - y[i - k]) / (x[i + k] - x[i - k]))
        g = max(g, d)
    return g


def at(x, y, x0):
    for i in range(len(x) - 1):
        if x[i] <= x0 <= x[i + 1] or abs(x[i] - x0) < 1e-9:
            if x[i + 1] == x[i]:
                return y[i]
            return y[i] + (y[i + 1] - y[i]) * (x0 - x[i]) / (x[i + 1] - x[i])
    if abs(x[-1] - x0) < 1e-9:
        return y[-1]
    return float("nan")


def out(name, lines):
    with open(os.path.join(HERE, name), "w") as f:
        f.write("\n".join(lines) + "\n")
    print("escrito", name, len(lines), "lineas")


def fe(v):
    return "%9.3e" % v


# ------------------------------------------------------------------ A
def post_A():
    VAR = ["nstd_pstd", "nlvt_plvt", "nstd_phvt", "nlvt_phvt", "nlvt_pstd"]
    RAT = ["n8p1", "n1p1", "n1p8"]
    VDD = ["0.2", "0.3", "0.4", "0.5", "0.6"]
    res = {}
    for c, t in PTS:
        for v in VDD:
            d = load(f"A_{c}_{t}_v{v}.dat")
            if d is None:
                continue
            x = d["v-sweep"]
            for va in VAR:
                for r in RAT:
                    y = d[f"v(o_{va}_{r})"]
                    res[(va, r, v, c, t)] = (cross(x, y, ref=x), maxgain(x, y, 2))
    L = ["A. Inversor a alimentación reducida. Fuente: b20_spice_raw/A_<esq>_<T>_v<VDD>.dat (netlists b20_spice_net/b20_spice_A_*.spice)",
         "W=1 um, L=0,5 um; n8p1 = nfet m=8, pfet m=1; etc. Vm = entrada con Vout=Vin. Ganancia = max|dVout/dVin| (dif. central 2 mV).",
         "",
         "Resumen por configuración sobre los 15 puntos (5 esquinas × 3 T):",
         "variante    rel   VDD   Vm_min  Vm_max  disp(mV)  [esq/T min ; max]        gan_min  gan_max  ¿Vm∈[0,15;0,20] y gan>5 en los 15?"]
    ok_any = []
    for va in VAR:
        for r in RAT:
            for v in VDD:
                vals = [(res[(va, r, v, c, t)], c, t) for c, t in PTS if (va, r, v, c, t) in res]
                if len(vals) < 15:
                    L.append(f"{va:11s} {r:5s} {v}  INCOMPLETO ({len(vals)}/15)")
                    continue
                vm = [(a[0], c, t) for a, c, t in vals]
                g = [a[1] for a, c, t in vals]
                lo, hi = min(vm), max(vm)
                ok = all(0.15 <= a[0] <= 0.20 and a[1] > 5 for a, c, t in vals)
                n_ok = sum(1 for a, c, t in vals if 0.15 <= a[0] <= 0.20 and a[1] > 5)
                if ok:
                    ok_any.append((va, r, v))
                L.append(f"{va:11s} {r:5s} {v}   {lo[0]:.3f}   {hi[0]:.3f}   {1e3*(hi[0]-lo[0]):6.1f}   [{lo[1]}/{lo[2]:>3s} ; {hi[1]}/{hi[2]:>3s}]   "
                         f"{min(g):7.2f}  {max(g):7.2f}   {'SI' if ok else 'NO'} ({n_ok}/15)")
    L += ["", "Configuraciones que cumplen en los 15 puntos: " + (", ".join("/".join(k) for k in ok_any) if ok_any else "NINGUNA"), ""]
    # detalle de las configuraciones más cercanas: mayor n_ok
    L.append("Detalle (Vm en V / ganancia) de tres configuraciones:")
    for va, r, v in [("nlvt_phvt", "n1p1", "0.4"), ("nlvt_pstd", "n8p1", "0.4"), ("nstd_pstd", "n1p1", "0.4"), ("nlvt_plvt", "n1p1", "0.3")]:
        L.append(f"  {va} {r} VDD_inv={v}")
        L.append("    esq    " + "".join(f"{t:>16s}" for t in TEMPS))
        for c in CORNERS:
            L.append(f"    {c}     " + "".join(
                f"   {res[(va, r, v, c, t)][0]:.3f} / {res[(va, r, v, c, t)][1]:5.1f}" if (va, r, v, c, t) in res else "        ?       " for t in TEMPS))
    # dispersión mínima alcanzable
    best = None
    for va in VAR:
        for r in RAT:
            for v in VDD:
                vals = [res[(va, r, v, c, t)][0] for c, t in PTS if (va, r, v, c, t) in res]
                if len(vals) == 15:
                    s = max(vals) - min(vals)
                    if best is None or s < best[0]:
                        best = (s, va, r, v)
    if best:
        L += ["", f"Dispersión mínima de Vm entre los 15 puntos, sobre todas las configuraciones: {1e3*best[0]:.1f} mV ({best[1]} {best[2]} VDD={best[3]})"]
    # dispersión solo entre esquinas a 27 C para VDD 0.4
    L.append("Dispersión de Vm solo entre esquinas a 27 °C (VDD_inv=0,4):")
    for va in VAR:
        for r in RAT:
            vals = [res[(va, r, "0.4", c, "27")][0] for c in CORNERS if (va, r, "0.4", c, "27") in res]
            if len(vals) == 5:
                L.append(f"  {va:11s} {r:5s}  {min(vals):.3f}–{max(vals):.3f} V  ({1e3*(max(vals)-min(vals)):.1f} mV)")
    out("b20_spice_A.txt", L)
    return res, ok_any


# ------------------------------------------------------------------ B
def post_B():
    DEV = ["std_5_1", "lvt_5_1", "std_5_05", "lvt_5_05"]
    VG = [0.05, 0.10, 0.20, 0.25, 0.30, 0.40]
    L = ["B1. nfet en inversión débil, fuente común, Vds = 0,9 V. Fuente: b20_spice_raw/B1_<esq>_<T>.dat",
         "Id en A. S = 100 mV / log10(I(0,20)/I(0,10)). R31 = I(0,30)/I(0,10). R2510 = I(0,25)/I(0,10) (peor caso de los dos estados).", ""]
    summ = {}
    igmax = 0.0
    I = {}
    for dv in DEV:
        L.append(f"Dispositivo {dv}  (nfet_01v8{'_lvt' if 'lvt' in dv else ''}, W/L = 5/{'1' if dv.endswith('_1') else '0.5'})")
        L.append("  esq  T    " + "".join(f"  I({v:.2f})  " for v in VG) + "  S(mV/dec)   R31      R2510")
        for c, t in PTS:
            d = load(f"B1_{c}_{t}.dat")
            if d is None:
                L.append(f"  {c}  {t:>3s}  FALTA")
                continue
            x = d["v-sweep"]
            y = [-v for v in d[f"i(Vd_{dv})"]]
            igmax = max(igmax, max(abs(v) for v in d["i(Vg)"]))
            ii = [at(x, y, v) for v in VG]
            I[(dv, c, t)] = dict(zip(VG, ii))
            S = 100.0 / math.log10(ii[2] / ii[1])
            L.append(f"  {c}  {t:>3s}  " + "".join(f" {fe(v)} " for v in ii) + f"   {S:6.1f}   {ii[4]/ii[1]:8.1f}  {ii[3]/ii[1]:7.1f}")
        k = [key for key in I if key[0] == dv]
        if len(k) == 15:
            hi10 = max((I[q][0.10], q[1], q[2]) for q in k)
            lo25 = min((I[q][0.25], q[1], q[2]) for q in k)
            lo30 = min((I[q][0.30], q[1], q[2]) for q in k)
            r31 = min((I[q][0.30] / I[q][0.10], q[1], q[2]) for q in k)
            r25 = min((I[q][0.25] / I[q][0.10], q[1], q[2]) for q in k)
            L.append(f"  max I(0,10) = {fe(hi10[0])} A ({hi10[1]}/{hi10[2]});  min I(0,25) = {fe(lo25[0])} A ({lo25[1]}/{lo25[2]});  "
                     f"min I(0,30) = {fe(lo30[0])} A ({lo30[1]}/{lo30[2]})")
            L.append(f"  Ventana para referencia fija única: min I(0,25)/max I(0,10) = {lo25[0]/hi10[0]:.3g}; "
                     f"min I(0,30)/max I(0,10) = {lo30[0]/hi10[0]:.3g}  -> "
                     f"{'EXISTE' if lo25[0] > hi10[0] else 'NO EXISTE'} (0,10|0,25); {'EXISTE' if lo30[0] > hi10[0] else 'NO EXISTE'} (0,10|0,30)")
            L.append(f"  Cociente mínimo dentro de un mismo punto: R31 = {r31[0]:.1f} ({r31[1]}/{r31[2]}); R2510 = {r25[0]:.1f} ({r25[1]}/{r25[2]})")
            # solo temperatura (misma esquina) y solo esquina (misma T)
            for c in CORNERS:
                h = max(I[(dv, c, t)][0.10] for t in TEMPS)
                l = min(I[(dv, c, t)][0.25] for t in TEMPS)
                L.append(f"    solo temperatura, esquina {c}: min I(0,25)/max I(0,10) = {l/h:.3g}")
            for t in TEMPS:
                h = max(I[(dv, c, t)][0.10] for c in CORNERS)
                l = min(I[(dv, c, t)][0.25] for c in CORNERS)
                L.append(f"    solo esquinas, T = {t}: min I(0,25)/max I(0,10) = {l/h:.3g}")
            summ[dv] = (hi10, lo25, lo30, r31, r25)
        L.append("")
    L.append(f"Corriente de puerta máxima |i(Vg)| (los 4 nfet en paralelo, todo el barrido, todos los puntos): {fe(igmax)} A")
    L.append("  (el modelo tiene igcmod=0 e igbmod=0: la corriente de puerta DC es cero por construcción, no un resultado)")
    L.append("")
    # B2
    L += ["B2. Lector completo: nfet 5/1 (puerta = nodo) + espejo pfet 2/2 + inversor 1,8 V. Fuente: b20_spice_raw/B2_<esq>_<T>.dat",
          "  r = referencia por réplica (nfet idéntico con puerta a 0,17 V);  f = referencia fija = Id(0,17 V) de tt/27.",
          "  Vtrip = Vin a la que la salida del inversor cruza 0,9 V. Sal(x) = salida del inversor (V) con Vin = x. Lógica: nodo alto -> drenador bajo -> salida ALTA.",
          "  esq  T     " + "".join(f"| {k:5s} Vtrip  Sal(0,10) Sal(0,25) " for k in ["rstd", "rlvt", "fstd", "flvt"])]
    b2 = {}
    iin = 0.0
    for c, t in PTS:
        d = load(f"B2_{c}_{t}.dat")
        if d is None:
            L.append(f"  {c}  {t:>3s}  FALTA")
            continue
        x = d["v-sweep"]
        iin = max(iin, max(abs(v) for v in d["i(Vin)"]))
        row = f"  {c}  {t:>3s}   "
        for k in ["rstd", "rlvt", "fstd", "flvt"]:
            y = d[f"v(o_{k})"]
            vt = cross(x, y, 0.9)
            b2[(k, c, t)] = (vt, at(x, y, 0.10), at(x, y, 0.25))
            row += f"|       {vt:6.4f}   {at(x, y, 0.10):6.3f}    {at(x, y, 0.25):6.3f}  "
        L.append(row)
    for k in ["rstd", "rlvt", "fstd", "flvt"]:
        v = [b2[q][0] for q in b2 if q[0] == k]
        if len(v) == 15:
            nan = sum(1 for a in v if a != a)
            vv = [a for a in v if a == a]
            okc = sum(1 for q in b2 if q[0] == k and b2[q][1] < 0.18 and b2[q][2] > 1.62)
            L.append(f"  {k}: Vtrip {min(vv):.4f}–{max(vv):.4f} V (dispersión {1e3*(max(vv)-min(vv)):.1f} mV; sin cruce en 0–0,5 V: {nan}); "
                     f"puntos con salida correcta (Sal(0,10) < 0,18 y Sal(0,25) > 1,62): {okc}/15")
    L.append(f"  |i(Vin)| máx (carga DC sobre el nodo, 4 puertas): {fe(iin)} A")
    out("b20_spice_B.txt", L)
    return I, summ, b2


# ------------------------------------------------------------------ C
def post_C():
    VAR = ["std200", "lvt200", "std1u"]
    REF = ["0.05", "0.10", "0.17", "0.25", "0.40"]
    L = ["C. Comparador: par diferencial pfet 4/1 (cuerpo a la cola), cola = 2·iref, espejo nfet 2/2, 2.ª etapa nfet 2/2 + pfet 2/2, inversor.",
         "   std200 = pfet_01v8, cola 200 nA; lvt200 = pfet_01v8_lvt, cola 200 nA; std1u = pfet_01v8, cola 1 uA. VDD = 1,8 V.",
         "   Fuente: b20_spice_raw/C_<esq>_<T>_r<ref>.dat (barrido ±20 mV, paso 10 uV) y C_<esq>_<T>_wide.dat",
         "   Vos = (Vin − Vref) a la que la 2.ª etapa cruza 0,9 V. G2 = max|dVo2/dVin| (V/V). G1 = max|dVn2/dVin|.", ""]
    R = {}
    for va in VAR:
        L.append(f"Variante {va}: Vos (mV) por modo común (Vref); '----' = no cruza en ±20 mV")
        L.append("  esq  T    " + "".join(f"  ref={r} " for r in REF) + "   G1(ref .17)  G2(ref .17)  G2 mín (5 ref)   Sal(0,05) Sal(0,10) Sal(0,25) Sal(0,40) [ref 0,17]")
        for c, t in PTS:
            row = f"  {c}  {t:>3s}  "
            g2min = 1e99
            g1 = g2 = float("nan")
            for r in REF:
                d = load(f"C_{c}_{t}_r{r}.dat")
                if d is None:
                    row += "   FALTA  "
                    continue
                x = d["v-sweep"]
                vos = cross(x, d[f"v(o2_{va})"], 0.9)
                gg = maxgain(x, d[f"v(o2_{va})"], 1)
                R[(va, r, c, t)] = (vos, gg)
                g2min = min(g2min, gg if vos == vos else 0.0)
                if r == "0.17":
                    g2 = gg
                    g1 = maxgain(x, d[f"v(n2_{va})"], 1)
                row += ("  %7.3f " % (1e3 * vos)) if vos == vos else "    ----  "
            w = load(f"C_{c}_{t}_wide.dat")
            if w is not None:
                xs = w["v-sweep"]
                s = [at(xs, w[f"v(out_{va})"], v - 0.17) for v in (0.05, 0.10, 0.25, 0.40)]
                R[(va, "wide", c, t)] = s
                sw = "".join(f"   {v:6.3f} " for v in s)
            else:
                sw = "  FALTA"
            row += f"   {g1:9.1f}    {g2:9.1f}     {g2min:9.1f}     " + sw
            L.append(row)
        vv = [R[k][0] for k in R if k[0] == va and k[1] != "wide"]
        ok = [v for v in vv if v == v]
        if ok:
            L.append(f"  Vos sistemático: {1e3*min(ok):.3f} … {1e3*max(ok):.3f} mV sobre {len(ok)} de {len(vv)} (esquina,T,ref); sin cruce: {len(vv)-len(ok)}")
        nok = sum(1 for k in R if k[0] == va and k[1] == "wide" and R[k][0] < 0.18 and R[k][1] < 0.18 and R[k][2] > 1.62 and R[k][3] > 1.62)
        L.append(f"  Salida lógica correcta en 0,05/0,10 (baja) y 0,25/0,40 (alta) con ref 0,17: {nok}/15 puntos")
        L.append("")
    # Monte Carlo
    L.append("Cmm. Monte Carlo de mismatch (sección tt_mm, mc_mm_switch=1, 27 °C), 150 copias. Fuente: b20_spice_raw/Cmm_a.dat, Cmm_b.dat")
    mm = {}
    for tag, desc in (("a", "par 4/1 m=1, espejo y 2.ª etapa nfet 2/2 m=1"), ("b", "par 4/1 m=4, espejo y 2.ª etapa nfet 2/2 m=4")):
        d = load(f"Cmm_{tag}.dat")
        if d is None:
            L.append(f"  {tag}: FALTA")
            continue
        x = d["v-sweep"]
        vos = [cross(x, d[k], 0.9) for k in d if k != "v-sweep"]
        good = [v for v in vos if v == v]
        n = len(good)
        m = sum(good) / n
        sd = math.sqrt(sum((v - m) ** 2 for v in good) / (n - 1))
        mm[tag] = (m, sd, min(good), max(good), n, len(vos))
        L.append(f"  {tag} ({desc}): n = {n} de {len(vos)}; media = {1e3*m:.3f} mV; sigma = {1e3*sd:.3f} mV; mín = {1e3*min(good):.2f}; máx = {1e3*max(good):.2f} mV; "
                 f"valores distintos: {len(set(round(v, 7) for v in good))}")
    if "a" in mm and "b" in mm:
        L.append(f"  Escalado de Pelgrom: sigma(a)/sigma(b) = {mm['a'][1]/mm['b'][1]:.2f} (esperado 2,00 si todo el área se multiplica por 4)")
    out("b20_spice_C.txt", L)
    return R, mm


# ------------------------------------------------------------------ D
def post_D():
    VAR = ["std", "lvt", "hvt"]
    L = ["D. Seguidor pfet 2/0,5 (cuerpo a fuente, 100 nA) + inversor 1,8 V (nfet 0,65/0,15, pfet 1/0,15).",
         "   Fuente: b20_spice_raw/D_<esq>_<T>.dat y D_<esq>_<T>_inv.dat",
         "   Vsf(x) = salida del seguidor con Vin = x. Vm_inv = umbral del inversor suelto. Vtrip = Vin a la que la salida del inversor cruza 0,9 V ('----' = no cruza en 0–0,6 V).", ""]
    R = {}
    for va in VAR:
        L.append(f"Seguidor pfet_01v8{'' if va == 'std' else '_' + va}")
        L.append("  esq  T    Vsf(0,10) Vsf(0,25) Vsf(0,30)  gan_seg  Vm_inv   Vtrip    Vsf(0,10)-Vm  Vsf(0,25)-Vm  ¿separa 0,10|0,25?")
        for c, t in PTS:
            d = load(f"D_{c}_{t}.dat")
            di = load(f"D_{c}_{t}_inv.dat")
            if d is None or di is None:
                L.append(f"  {c}  {t:>3s}  FALTA")
                continue
            x = d["v-sweep"]
            sf = d[f"v(sf_{va})"]
            o = d[f"v(o_{va})"]
            vm = cross(di["v-sweep"], di["v(ox)"], ref=di["v-sweep"])
            a, b, e = at(x, sf, 0.10), at(x, sf, 0.25), at(x, sf, 0.30)
            vt = cross(x, o, 0.9)
            sep = (a < vm < b)
            R[(va, c, t)] = (a, b, vm, vt, sep)
            L.append(f"  {c}  {t:>3s}    {a:6.3f}    {b:6.3f}    {e:6.3f}    {(e-a)/0.2:5.3f}   {vm:6.3f}  " +
                     (f"{vt:6.4f}" if vt == vt else " ---- ") + f"     {a-vm:+7.3f}       {b-vm:+7.3f}      {'SI' if sep else 'NO'}")
        k = [q for q in R if q[0] == va]
        if len(k) == 15:
            vts = [R[q][3] for q in k if R[q][3] == R[q][3]]
            nsep = sum(1 for q in k if R[q][4])
            L.append(f"  Separa en {nsep}/15 puntos. Vtrip referido a la entrada: " +
                     (f"{min(vts):.3f}–{max(vts):.3f} V ({len(vts)} con cruce)" if vts else "sin cruce en ningún punto") +
                     f". (Vsf(0,10)−Vm) va de {min(R[q][0]-R[q][2] for q in k):+.3f} a {max(R[q][0]-R[q][2] for q in k):+.3f} V")
        L.append("")
    out("b20_spice_D.txt", L)
    return R


# ------------------------------------------------------------------ E
def post_E():
    DEV = [("n_015", "nfet_01v8 0,42/0,15 a masa"), ("n_05", "nfet_01v8 0,42/0,5 a masa"), ("n_1", "nfet_01v8 0,42/1 a masa"),
           ("nlvt_015", "nfet_01v8_lvt 0,42/0,15 a masa"), ("p015", "pfet_01v8 0,42/0,15, puerta y pozo a 1,8 V"),
           ("nst", "nfet_01v8 0,42/0,15 con fuente a 0,10 V")]
    L = ["E. Fuga que un interruptor apagado inyecta/extrae del nodo. Fuente: b20_spice_raw/E_<esq>_<T>.dat (gmin = 1e-21)",
         "   I = corriente que sale del nodo hacia el dispositivo (A; negativa = el dispositivo carga el nodo). Ib = corriente por el terminal de cuerpo",
         "   (unión + GIDL hacia el cuerpo). Vgs = 0 en los nfet. Se dan los valores con el nodo a 0,10 y a 0,30 V.", ""]
    R = {}
    for dv, desc in DEV:
        L.append(f"{dv}: {desc}")
        L.append("  esq  T     I(nodo=0,10)   I(nodo=0,30)" + ("   Ib(0,30)" if dv != "nst" else ""))
        for c, t in PTS:
            d = load(f"E_{c}_{t}.dat")
            if d is None:
                L.append(f"  {c}  {t:>3s}  FALTA")
                continue
            x = d["v-sweep"]
            i1, i3 = at(x, d[f"i(Vd_{dv})"], 0.10), at(x, d[f"i(Vd_{dv})"], 0.30)
            ib = at(x, d[f"i(Vb_{dv})"], 0.30) if dv != "nst" else float("nan")
            R[(dv, c, t)] = (i1, i3, ib)
            L.append(f"  {c}  {t:>3s}   {i1:+.3e}     {i3:+.3e}" + (f"   {ib:+.3e}" if dv != "nst" else ""))
        k = [q for q in R if q[0] == dv]
        if k:
            w = max((abs(R[q][1]), q[1], q[2]) for q in k)
            w85 = max((abs(R[q][1]), q[1], q[2]) for q in k if q[2] == "85")
            L.append(f"  Peor |I(0,30)| = {fe(w[0])} A ({w[1]}/{w[2]}); a 85 °C: {fe(w85[0])} A ({w85[1]}).  "
                     f"Frente a pico de diodo: {100*w[0]/10e-12:.3g} % de 10 pA; {100*w[0]/1e-9:.3g} % de 1 nA; {100*w[0]/10e-9:.3g} % de 10 nA")
        L.append("")
    out("b20_spice_E.txt", L)
    return R


if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "ABCDE"
    if "A" in which: post_A()
    if "B" in which: post_B()
    if "C" in which: post_C()
    if "D" in which: post_D()
    if "E" in which: post_E()
