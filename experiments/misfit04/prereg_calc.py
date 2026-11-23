"""Numeros del prerregistro MISFIT-04 etapa 1, calculados antes de congelar. Fuentes: tile_sizes.yaml, metricas del
endurecimiento de misfit02_core_r2, BBOX de xc19_slot_core.mag, prereg_calc.txt de xc19_discrim."""
import os, re, json
Z = "/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC"
T = {k: tuple(map(float, v.split()))[2:] for k, v in re.findall(r'(\dx\d): "([^"]+)"', open(f"{Z}/local_flow/tt-support-tools/tech/sky130A/tile_sizes.yaml").read())}
core = 161.00 * 87.04
bb = [-2720, -18308, 8920, 831]   # Magic: select top cell; box values (unidades de 0,005 um), 2026-11-23
sw, sh = (bb[2] - bb[0]) / 200, (bb[3] - bb[1]) / 200
slot = sw * sh
print(f"slot XC-19: {sw:.2f} x {sh:.2f} um = {slot:.0f} um2 ; nucleo (die endurecido de misfit02_core_r2): {core:.0f} um2")
for k in ("1x1", "1x2", "2x2"):
    A = T[k][0] * T[k][1]
    print(f"{k}: {T[k][0]:.2f} x {T[k][1]:.2f} = {A:.0f} um2 ; libre tras nucleo + 1 slot (en bruto): {A - core - slot:.0f} um2 ; alto libre bajo el nucleo: {T[k][1] - 87.04:.2f} um")
# senal que no debe contaminar la integracion: salto de una trampa (s_c) y su 10 %, por esquina, del macro extraido
V = {}
for l in open(f"{Z}/06_exotic_cells/experiments/xc19_slot/contrato_temporizacion.txt"):
    f = l.split()
    for kv in f[3:]:
        k, _, v = kv.partition("=")
        try: V[(f[1], f[2], k)] = float(v)
        except ValueError: pass
for c, t in (("tt", "27"), ("ff", "-40"), ("ss", "85"), ("ff", "85")):
    tA = V[(c, t, "h01_oa")] - 1e-6; tT = V[(c, t, "t01_oa")] - 1e-6
    sc = (tA - tT) / tA
    print(f"{c} {t}: tA = {tA*1e6:.3f} us = {tA*50e6:.1f} cuentas ; s_c = {100*sc:.4f} % ; 10 % de s_c = {10*sc:.4f} % del cociente ; = {0.1*(tA-tT)*50e6:.3f} cuentas")
