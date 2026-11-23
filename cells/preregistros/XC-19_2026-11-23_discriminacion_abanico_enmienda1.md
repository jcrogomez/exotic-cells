# XC-19 · simulador de discriminación · enmienda 1

Cita [`XC-19_2026-11-23_discriminacion_abanico.md`](XC-19_2026-11-23_discriminacion_abanico.md) (SHA-256 `3d830f1e…87ca`,
sellado a las 17:45:59). Escrita a partir de las 17:47 EST (`date`), **antes de escribir el simulador** y sin ningún número
producido. Hueco detectado al repasar la lista de la skill (punto 4: cada umbral con su forma): las predicciones no decían en qué
celda de adquisición se juzgan. El original no se edita.

| # | Cambio | Por qué |
|---|---|---|
| A1 | PD1–PD5, T1 y T2 se juzgan en **fa = 1 kHz, T = 1 s**, con ≥ 2000 chips simulados por celda. Las celdas (10 kHz, 1 s), (1 kHz, 100 s) y (10 kHz, 100 s) se reportan sin veredicto, con ≥ 200 chips (una serie de 10⁵–10⁶ conversiones por pata no cabe a 2000 chips en el presupuesto de §11) | forma del umbral |
| A2 | "En banda" es τ ∈ [1/(π·fa), T/(2π)]: la esquina de la lorentziana de cada trampa, 1/(2πτ), cae en [1/T, fa/2], la banda que integró `prereg_calc.py`. "Permanencia ≥ 10 conversiones" (PD1) es τ ≥ 10/fa | definir la verdad del simulador con la misma banda que el cálculo |
| A3 | La densidad por década de τ en C0 es N_banda / log10(T·fa/2), con N_banda de `prereg_calc.txt` para esa esquina, celda y η. Fuera de la banda se extiende con la misma densidad por década sobre [1 µs, 10⁴ s] | §5 decía "λ0 por década" sin decir de dónde sale |
| A4 | Bits = I(H; Ĥ), calculada de la matriz de confusión 2×2 en chips no vistos. Los IC al 95 % salen de 1000 remuestreos bootstrap. "≥ 80 % del techo" se juzga sobre el valor central | forma de la cantidad |
| A5 | En D2, el techo de Poisson se calcula con λ0 conocido. Es una cota superior también con λ0 estimado desde las patas C0 (desconocer λ0 solo puede quitar información) | que el techo siga siendo techo |

Sin otros cambios.
