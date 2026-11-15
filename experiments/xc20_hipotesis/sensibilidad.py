#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Sensibilidad del orden de diseños a los supuestos marcados en PREREG.md (cláusula de muerte). Usa las funciones de motor.py.
    python3 sensibilidad.py > sensibilidad.txt"""
import numpy as np
import motor

orig = motor.muestrea
def variante(t_hi=None, r_hi=None, g_hi=None):
    def m(mec, n, rng):
        p = orig(mec, n, rng)
        if g_hi: p["g0"] = motor.logu(rng, 3e-18, g_hi, n)
        if mec == "T" and t_hi: p["t0"] = motor.logu(rng, 12e-9, t_hi, n)
        if mec == "R" and r_hi: p["rb"] = motor.logu(rng, 10, r_hi, n)
        return p
    return m

CASOS = {
    "PREREG": ({}, None),
    "T solo plausible (12 nA-50 uA, G=10-35, b20 §4)": (dict(t_hi=50e-6), None),
    "R hasta 10 MOhm (puente parcial)": (dict(r_hi=1e7), None),
    "R hasta 1 GOhm": (dict(r_hi=1e9), None),
    "termica hasta 2e-10 A": (dict(g_hi=2e-10), None),
    "techo XC26 x10 (12,5 nA, cuantiza 10 %)": ({}, 12.5e-9),
}
DIS = ["D0 plan: d=0 y d=0,27; -1,8 V; 27 C", "D0 + 85 C", "D0 + -0,9 V", "D0 + peine"]
for nombre, (kw, techo) in CASOS.items():
    motor.muestrea = variante(**kw)
    motor.LECTORES["XC26"] = (150e-15, 0.1e-12, techo or 1.25e-9)
    for sigma in (0.05, 0.5):
        fila = []
        for lector in ("XC26", "ancho"):
            for dn in DIS:
                v, lp = motor.logverosimilitudes(motor.DISENOS[dn], lector, sigma, 400, 8000, semilla=7)
                b, e, a, c = motor.resume(v, lp, (1 / 3, 1 / 3, 1 / 3))
                fila.append("%s/%s %.3f±%.3f" % (lector, dn.split(":")[0].replace("D0 plan", "D0"), b, e))
        print("%s | sigma %.2f | %s" % (nombre, sigma, " | ".join(fila)), flush=True)
