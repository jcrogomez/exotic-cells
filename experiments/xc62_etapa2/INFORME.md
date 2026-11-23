# XC-62 etapa 2 · informe: benchmark inválido en C0

Prerregistro: [`XC-62_2026-11-22_etapa2_R1_R2.md`](../../cells/preregistros/XC-62_2026-11-22_etapa2_R1_R2.md) + [enmienda 1](../../cells/preregistros/XC-62_2026-11-22_etapa2_R1_R2_enmienda1.md).
SHA-256 de ambos en `PREREG_SHA256.txt`: sellados a las 13:06:17 y 13:08:28 EST, verificados antes de correr. Sin commit: el
clasificador de permisos bloqueó el commit; las huellas sustituyen su función hasta que Juan los commitee.

Corrida: `etapa2.py . --humo` de 13:10:28 a 13:11:39 EST → `resultados_humo.txt`, `resultados_humo.json`. C0 es el mismo código
y no depende del tamaño del banco: sus chequeos de validez son los del prerregistro, no una exploración. **C3–C5 no se corrieron**,
porque §8 dice "Benchmark inválido si falla a1, a2, a3, a4 o T-MI, sea cual sea el resultado".

## Resultado contra el prerregistro

| | Criterio | Observado | Veredicto |
|---|---|---|---|
| T-MI | abs(estimado − exacto) ≤ 0,01 bits; el mutante se detecta | 0,4856 ± 0,0016 frente a 0,4859; mutante 1,000 | pasa |
| a9 (E7) | sa/sb igualados ≤ 1e-9 µm; mutante detectado | 0,0 µm; mutante 0,100 µm | pasa |
| T-R1 | bajo A, r ≠ 0,9375 | 0,9054 / 0,9218 / 0,9248 / 0,9316 | pasa |
| **a2** | truncar a 1,2 frente a 2,0 µm ≤ 0,1 nm | R2: 2,19 / 2,73 / 3,51 / 6,22 nm · R1 (E1): 0,70 / 5,77 / 1,01 / 0,09 nm | **falla: benchmark inválido** |
| **a3** | línea de 3 frente a 4,5 µm ≤ 0,1 nm | densa: 0,98 / 1,87 / 2,63 / 0,31 nm · aislada: 0,88 / 2,15 / 1,02 / 0,21 nm | **falla: benchmark inválido** |
| P1′ (E2) | 1,685 / 1,027 / 1,376 / 1,056 ± 0,001 | 1,676 / 1,024 / 1,378 / 1,064 | **fallada**: la predicción salió de anchos con 3 decimales (`0,089` → ±0,01 en r). El error es de mi deducción, no del modelo |
| P1 | lo mismo para m = 3, largo 3 µm | 1,590 / 1,033 / 1,381 / 1,057 | **fallada**: con 3 vecinas por lado y otro largo, el estrechamiento de la línea densa en el primer ajuste es menor |
| a4 | recurrencias ≤ 10 % | 0 en el banco de humo | — (no evaluado en el banco completo) |

Valores de los cuatro ajustes en orden: NA 0,60/σ 0,5 · 0,60/0,8 · 0,70/0,5 · 0,70/0,8. Sesgo de B calibrado (E5): 15 / 0 / 20 / 5
nm por borde.

## La explicación aburrida, explorada (no prerregistrado)

`explora_alcance.py` → `explora_alcance.txt` (13:12:17–13:13:31). NA 0,60, σ 0,8, el peor caso de a2:

| Caja | Fuente | a2, R1 s 0,42 | a3, densa |
|---|---|---|---|
| 5,12 µm (N = 1024) | 7×7 (la de `c62`) | 5,77 nm | 1,87 nm |
| 5,12 µm | 13×13 | 0,99 nm | 0,61 nm |
| 10,24 µm (N = 2048) | 7×7 | 2,75 nm | 3,45 nm |
| 10,24 µm | 13×13 | 0,57 nm | 0,84 nm |

Lectura (conjetura apoyada en esta tabla, no demostrada):
- Lo que domina es **el muestreo discreto de la fuente**. Cada punto de la fuente es una iluminación coherente con pupila de
  borde duro, cuya PSF ondula y decae despacio. La máscara es de campo claro (líneas oscuras sobre fondo brillante), así que esa
  ondulación entra **lineal** en la intensidad, al interferir con el fondo. Afinar la fuente la promedia: a2 cae de 5,8 a 1,0 nm.
- La caja periódica pesa menos y no de forma monótona (a3 sube con la caja doble y 7×7).

## Qué significa

1. **El modelo de `c62_litho.py` no converge al nanómetro.** Sus anchos llevan una incertidumbre numérica de ~1–6 nm por el
   alcance largo, con la discretización que usa. No basta para la etapa 2. Tampoco para la tabla de `c62_INFORME.md` a esa
   escala: las vecinas a 1,0 µm o la referencia aislada (0,149–0,151) caen dentro de ese ruido numérico. Las conclusiones gruesas
   de `c62` (+5…+76 mV con vecinas a 0,21 sin OPC) quedan muy por encima y no cambian.
2. **Las hipótesis B y C se separan por residuos de pocos nm**, del mismo orden que el artefacto. Sin un modelo convergido, el
   optimizador elegiría geometrías que separan **mis discretizaciones**, no clases de OPC.
3. El evaluador incremental de `xc62_incremental` sigue siendo exacto respecto al modelo. Lo que falla es el modelo, no el
   atajo.

## Rediseño preregistrable (etapa 2b, sin escribir ni correr)

- **Convergencia antes que nada:** subir ns (7 → 13 → 19 …) y N (1024 → 2048) hasta que el ancho central de las geometrías del
  banco cambie ≤ 0,1 nm entre un paso y el siguiente. El criterio se fija antes, y el modelo convergido se congela como modelo
  nuevo (`c62` deja de ser "el mismo modelo").
- Coste: ns = 13 da ~4× puntos de fuente y N = 2048 ~4× píxeles. El evaluador incremental escala con la ROI y el número de
  puntos de fuente, no con N; la memoria por forma sí crece.
- Corregir la deducción de P1/P1′ con valores calculados con el modelo convergido, no copiados de una tabla con 3 decimales.
- Lo demás del diseño (hipótesis, banco, controles, criterios) puede reusarse tal cual en una enmienda 2 o en un prerregistro
  nuevo que cite este.

## ¿Qué explicación aburrida no descarté?

Que el umbral constante calibrado a una línea de 4,8 µm, que no es la longitud de ninguna línea del banco, se mueva con la
discretización y absorba parte del efecto: el umbral pasa de 0,3279 a 0,3217 entre fuentes de 7×7 y 13×13. No lo separé del
alcance largo.
