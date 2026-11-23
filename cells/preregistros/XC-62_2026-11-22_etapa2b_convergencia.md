# XC-62 · etapa 2b: convergencia del modelo óptico · prerregistro

Escrito el 2026-11-22 desde las 19:31:38 EST (`date`); la hora de congelado es la de su SHA-256 en
`experiments/xc62_etapa2/PREREG_SHA256.txt`. Antes de escribir el código. Números citados:
[`prereg_calc_2b.py`](../../experiments/xc62_etapa2/prereg_calc_2b.py) → `prereg_calc_2b.txt` (19:31:33).
Antecedente: la etapa 2 quedó **benchmark inválido en C0** ([informe](../../experiments/xc62_etapa2/INFORME.md)).
La tabla de `explora_alcance.txt` es **exploración**, no evidencia: aquí solo sirve para la predicción, y se vuelve a medir.
Estado: **congelado** al sellarse. Las enmiendas van en un archivo nuevo.

**Alcance.** Esto no es física de SkyWater: es la pregunta numérica de si el modelo supuesto de `c62_litho.py` tiene un
límite continuo alcanzable con un coste razonable. No toca el ranking. Es una etapa de soporte de un candidato de nivel B (5.º).

## 1. Pregunta

¿Existe, en la escalera de muestreo de fuente ns ∈ {7, 13, 19, 25, 31, 37} con caja N = 2048 (dx 5 nm), un modelo cuyos
anchos impresos cambien ≤ 0,1 nm al refinarlo? Y con ese modelo, ¿pasan los chequeos a2 y a3 de la etapa 2?

## 2. Explicaciones aburridas y su chequeo

| # | Aburrida | Chequeo |
|---|---|---|
| b1 | **Muestreo de la fuente** (rejilla cartesiana ns × ns dentro del disco) | escalera de ns, §4 |
| b2 | **Caja periódica y muestreo de frecuencia.** Son lo mismo: con N = 1024 la pupila mide solo 12,4 píxeles de radio en frecuencia (24,8 con N = 2048, `prereg_calc_2b.txt`); su borde es una escalera | N 1024 frente a 2048 en cada peldaño |
| b3 | **Píxel de la máscara** dx = 5 nm | dx 2,5 nm (N = 4096, misma caja 10,24 µm) en ns\*, solo G0, G1 y G2 a NA 0,60 σ 0,8 |
| b4 | **El umbral se mueve con la discretización** (0,3279 → 0,3217 en la exploración) y absorbe parte del cambio | cada ancho se reporta con umbral recalibrado (es el procedimiento de `c62`, y es el que decide) **y** con el umbral fijo de ns = 37, N = 2048 |
| b5 | **La rejilla cartesiana converge a algo que no es el disco** (puntos en el borde con `≤ 1,0001`) | cuadratura polar independiente (Gauss-Legendre radial 12 × 48 ángulos, pesos r dr) en ns\*: debe coincidir ≤ 0,1 nm |
| b6 | No determinismo | G1 corrido dos veces en ns = 7: debe dar exactamente lo mismo |

## 3. Hipótesis

- **H (convergencia):** el error es numérico y cae con ns y N; existe ns\* ≤ 37 que cumple §6.
- **H0:** no cae por debajo de 0,1 nm en la escalera, sea por coste o porque la rejilla tiene un piso.
- **Efecto mínimo:** 0,1 nm, heredado de a2 y a3 de la etapa 2 (un hecho en un lugar). Tolerancia secundaria **reportada,
  no decisoria:** 0,5 nm, que en R2 son 0,9 mV frente a σ = 4,99 mV de la diferencia con n = 24 (`prereg_calc_2b.txt`). En R1
  no hay justificación: σ_R del resistor de poly es `[?]`.

## 4. Banco y corridas

Geometrías, todas con FFT completa (sin evaluador incremental), ancho en y = 0 con `cross()` de `xc62inc.py`:

| | Geometría | Por qué |
|---|---|---|
| G0 | línea aislada 0,15 × 4,8 µm | la del umbral |
| G1 | R1 0,15; s 0,42; m 3; largo 3; truncado 1,2 µm | peor caso de a2 en R1 |
| G2 | R1 0,15; s 0,21; m 3; largo 3 | P1 y a3 densa |
| G3 | R1 0,15 aislada, largo 3 | a3 aislada y denominador de R1 |
| G4 | `nb2_021_longcap`: 0,15; s 0,21; m 1; largo 3,42 | P1′ |
| G5 | R2 n 32, s 0,21, dedo central, truncado 1,2 µm | peor caso de a2 en R2 |

| Corrida | Qué | Presupuesto |
|---|---|---|
| K0 | b6 (determinismo) y testigo T-K (§7) | auditoría |
| K1 | escalera ns × {1024, 2048} × 6 geometrías × 4 ajustes de iluminación | resolución |
| K2 | en ns\*: cuadratura polar (b5) y su mutante (§7) | auditoría |
| K3 | en ns\*: dx 2,5 nm (b3) | auditoría |
| K4 | en el modelo congelado: a2 (G1 y G5 a 1,2 frente a 2,0 µm), a3 (G2 y G3 a 3 frente a 4,5 µm), P1, P1′ | resolución |

ns\* = el menor peldaño en que, para las 6 geometrías × 4 ajustes, abs(w(ns) − w(ns anterior)) ≤ 0,1 nm con N = 2048 **y**
abs(w(ns, 2048) − w(ns, 1024)) ≤ 0,1 nm. Si con N = 2048 converge en ns pero falla el paso 1024 → 2048, N no está
convergido y se declara así (no se sube a 4096 en esta etapa salvo para K3).

## 5. Predicciones (calculadas, no de cabeza)

- **P2b-1:** ns\* = 31 (corte: ns\* ≤ 31 frente a > 31). Sale de ajustar a2 ∝ ns^−p a los peldaños 7 y 13 de la exploración
  (p = 2,85 con N = 1024 y 2,54 con N = 2048) y extrapolar a 0,1 nm: ns ≈ 29,0 y 25,8, y el primer peldaño por encima es 31.
  Dos puntos sostienen poco: si falla, falla.
- **P2b-2:** en el modelo congelado, a2 ≤ 0,1 nm en G1 y G5 (la misma extrapolación sugiere que a2 era sobre todo numérico).
- **P2b-3:** en el modelo congelado, a3 ≤ 0,1 nm. Menos confianza: en la exploración a3 no bajó con N.
- **P1 y P1′ no se predicen aquí.** Se calculan con el modelo congelado y se fijan en el prerregistro de la repetición de la
  etapa 2, antes de correrla.

## 6. Criterios

- **Sigue (modelo convergido):** existe ns\* ≤ 37, K2 coincide ≤ 0,1 nm, K3 ≤ 0,1 nm. Se congela como **`c62c`** = (ns\*,
  N = 2048, dx 5 nm, rejilla cartesiana), un modelo nuevo y no "el mismo de `c62`". Entonces:
  - si además pasan a2 y a3 (K4), la etapa 2 se repite con una enmienda 2 que fija `c62c` y los P1 y P1′ recalculados;
  - si a2 o a3 fallan en `c62c`, el fallo ya es del modelo físico (alcance real de la proximidad), no numérico, y el
    truncado a 1,2 µm es un error de diseño. La etapa 2 necesita un prerregistro nuevo, sin truncar o con otro truncado.
- **Muere (la etapa 2 tal como está):** ningún peldaño ≤ 37 cumple, o K2 o K3 superan 0,1 nm. Se reportan los cambios máximos
  por peldaño. La etapa 2 no se repite con este modelo. Qué hacer en ese caso lo decide Juan: relajar la tolerancia con un
  prerregistro nuevo justificado por el ruido de medida, cambiar de modelo (Hopkins / SOCS) o aparcar XC-62 etapa 2.
- **Benchmark inválido si:** b6 da diferencias, T-K no se detecta, el mutante de K2 no se detecta, o se agota el presupuesto
  de resolución antes de ns = 37 con N = 2048 (eso cuenta como "no convergido dentro del presupuesto", no como H0).

## 7. Controles negativos (mutante + testigo)

| Afirmación | Mutante (debe atraparse) | Testigo (el fenómeno ocurre) |
|---|---|---|
| "el criterio de convergencia detecta lo no convergido" | — | **T-K:** en G1 y en G1 truncado a 2,0 µm, a NA 0,60 σ 0,8, N = 1024, el mayor de los dos pasos 7 → 13 debe superar 0,1 nm. Deducido: a2 bajó de 5,773 a 0,988 nm, y abs(a2₇ − a2₁₃) ≤ abs(Δw₁) + abs(Δw₂), así que el mayor paso es ≥ 2,39 nm |
| "la cuadratura polar puede ver un error de fuente" | polar con σ 0,85 en vez de 0,8: debe diferir > 0,1 nm de la cartesiana en al menos una geometría × ajuste | la cartesiana de ns = 7 frente a la polar: debe diferir > 0,1 nm |

## 8. Separación de incertidumbre

- **Computacional:** lo que mide esta etapa (cambio entre peldaños, entre cuadraturas, entre píxeles). El último paso no es
  una cota del error residual, solo una estimación: se reporta como tal.
- **Epistémica:** la óptica entera es supuesta (λ, NA, σ, sin resina ni grabado). Esta etapa no la reduce nada.
- **Franja no atribuida:** la diferencia entre los anchos con umbral recalibrado y con umbral fijo (b4) que no se explique por el
  cambio de umbral solo.
- **Anti-invariante:** ns\* decide cuánto cálculo gastar. Por eso el "≤ 0,1 nm" no se reporta como cota de error de `c62c`; la
  garantía la dan K2 y K3, que son comparaciones independientes.

## 9. Presupuestos separados

- **Resolución** (K1, K4): ≤ 4 h de CPU. La estimación es 2,76 h para K1.
- **Auditoría** (K0, K2, K3): ≤ 2 h. La estimación es 1,0 h para K2 y 0,59 h para K3. No se recorta para pagar resolución.
- **Consecuencia, no criterio:** con ns = 31 el evaluador incremental necesita ~5,4 GB por forma (7,7 GB con ns = 37). Puede
  hacer inviable repetir la etapa 2 con el evaluador incremental en esta máquina. Se dirá en el informe.

## 10. Enmiendas

Ninguna.
