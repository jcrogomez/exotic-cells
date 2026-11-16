# Verificación independiente, ronda 3 (XC-20: supresión K, fuga convencional, arquitectura del lector) · informe

Verificador independiente. Empecé a las **19:28:32 EST** (`date`). Todo es modelo; nada está medido.

**Qué leí antes de fijar mis números:**
- `../PREREG.md`, completo, con la Enmienda 1.
- `../aritmetica_priors.py` y `../aritmetica_priors_salida.txt`.
- `../../xc20_hipotesis_mixto/PREREG.md`.
- Del verificador de la ronda 2: `ver2_INFORME.md`, `ver2_modelo.py`, `ver2_clasif.py` y `ver2_pares.py`.

**Qué vi sin abrirlo:** en un `ls` de las 19:55:52 aparecieron `../motor3.py`, `../res3_rapido.jsonl` y `../res3_rapido.npz`.
Solo vi los nombres. No leí `motor2.py` ni `motor.py`.

**Cuándo fijé los números:** en `ver3_NUMEROS.txt`, con la marca `Sun Nov 15 20:24:50 EST 2026` puesta por `date` en el mismo
comando. Las secciones 1 a 7 de este informe usan solo esos números. Lo que leí después del autor, y a qué hora, está en §8.

## 1. Decisiones de implementación

Las tomé entre las 19:31 y las 19:35, al escribir `ver3_modelo.py` y `ver3_correr.py`. La 18 y la 19 son posteriores; llevan su
hora.

**Modelo**
1. **Censura** sobre la lectura y = log10 I + ganancias + ε, con el piso y el techo nominales. Es la elección de la ronda 2.
2. **Celdas.** Hay cinco, cada una con su B y su desajuste: base (d = 0), d027, d054, d108 y sin unión.
   - `base 0,9` es la celda base a 0,9 V y 27 °C.
3. **Fondo B.**
   - No depende de V y se suma después del excitador: no pasa por Rs ni por Imax.
   - A 85 °C se multiplica por U(1, 50), un factor común a todas las celdas del chip.
   - En W2 se multiplica además por 10^(0,15·z), con z independiente por celda e igual a 27 y a 85 °C.
4. **Celda sin unión:** lee solo B. No lleva G ni excitador.
5. **F.** I = f0·(V/1,8)^log2(fsh)·exp(−d/λF)·exp(fea·KT), sumada a G y dentro de la ecuación del excitador.
   - fsh es U(1, 1,4), el mismo prior que gsh pero un valor propio. Así leo «forma en V como G».
6. **Túnel en d > 0:** t0·(V/1,8)^a·exp(tea·KT)·K^(−(d/0,27)^q). R vale 0 en d > 0, como en la ronda 2.
   - En d027 el factor es K^−1 para cualquier q: q solo actúa en 0,54 y 1,08.
7. **Lector S_f.**
   - Tres rangos fijos: [piso, 1 nA), [1 nA, 1 µA) y [1 µA, 1 mA].
   - El rango se elige con log10 I + g_c, antes del error del rango y de ε.
   - Error por rango: σr = 0,05, independiente entre rangos.
   - L_sw = f·150 fA·u, con u log-U(0,1, 1). Solo entra en el rango bajo. A 85 °C se multiplica por U(1, 50), independiente del
     factor de B.
   - Aplico L_sw en W1, W1q1, W1K6 y W2. La Enmienda solo restringe a W2 el desajuste de B.
   - S_f lleva g_c más g_r y **no** lleva g_s. Sus números son, por construcción, idénticos en C1, C3a, C3b y C3c.
8. **Calibración.**
   - **C1:** una sola g (σ 0,5) para todas las lecturas, también en A2. Es el «mixto» de la ronda 2.
   - **C3:** XC26 lleva g_c + g_s y el ancho lleva g_c + g_a. En X y en A eso equivale a una sola g de σ = √(σc² + σ²).
9. **Mundos pareados (Enmienda 1, §5).** Cada variante tiene un mundo de entrenamiento (semilla 1001) y uno de prueba (semilla
   2000) con las 11 lecturas y normales estándar.
   - Todos los diseños, lectores y calibraciones de la variante son funciones del mismo mundo. Comparto también entre
     calibraciones porque las normales se escalan.
   - W1, W1q1, W1K6 y W1q1cut sacan las mismas uniformes con las mismas semillas: los chips son los mismos salvo el parámetro
     que cambia.

**Medidas**

10. **Variable «túnel».**
    - En W1 es {T, M}, con prior 2/5: H = 0,971 bits.
    - En W2 es s_T, con prior 1/2.
    - «Chips con túnel», para K y para q: s_T = 1.
11. **I(F frente a túnel residual).**
    - En W1: chips con verdad en {T, M, F}, con P(F) = 1/3 (H = 0,918). q es la del clasificador de 5 clases renormalizada en
      esas tres.
    - En W2 no está definida. Uso las clases con exactamente uno de s_T y s_F (s_R libre): es binaria, con H = 1.
12. **Kbin.** «Bins de 1 década» no divide el prior, que mide 8,155 décadas.
    - Uso 8 bins iguales de 1,019 décadas: H = 3 bits.
    - En W1K6, 2 bins de 1,078 décadas: H = 1 bit.
    - Informo los bits y los bits divididos por H(Kbin). **El umbral de 0,05 lo aplico a los bits sin normalizar.**
13. **Clases de K.**
    - El posterior sale de una cabeza de 32 bins finos de 0,255 décadas (8 bins en W1K6).
    - **Intervalo principal (HPD por bins):** el tramo contiguo más corto con masa ≥ 0,9.
      - «Toca un borde» si incluye el primer o el último bin fino.
      - **Estimada:** ancho ≤ 2 décadas (≤ 7 bins) y no toca ningún borde.
      - **Acotada:** toca un solo borde y deja fuera ≥ 2 décadas del otro lado.
      - **Nada:** lo demás.
    - **Variante central:** cuantiles del 5 y el 95 %, con densidad uniforme dentro de cada bin; «toca» si queda a menos de un bin
      fino del borde. La doy porque el PREREG no dice cuál de las dos.
    - Para cada clase doy la cobertura: la fracción de chips cuyo K verdadero cae dentro del intervalo.
14. **q y B.**
    - q en 4 bins de [0,5, 1,5].
    - log10 B (a 27 °C) en 16 bins de 0,25 décadas sobre [−16, −12].
    - La «d.t. posterior» de B es la del histograma (con la varianza dentro del bin), promediada sobre los chips de prueba de
      todas las clases. La d.t. del prior es 1,1547 décadas.
    - **Es una estimación, no una cota.**
15. **Umbral de decisión:** ≥ 0,05 bits **y** más de 2σ, con σ el error típico pareado sobre las mismas lecturas de prueba.
16. **D8** lo juzgo en I(M;Y). **D7**, en I(M;Y) e I(Kbin|túnel), en E1, E2 y E4.
17. **E2sin27** es E2 sin d027 ni d027 85: es el mutante del testigo K.
18. **(19:57) W1q1cut**, variante de control que no está en el PREREG: W1q1 con el túnel anulado en d054 y d108, que ahí leen solo
    G + B. Sirve para atribuir la subida de K con q = 1 (§7).
19. **(20:21) Tablas.** Las saco de los registros por proceso (`ver3_log_*.txt`). Los archivos `ver3_R_W1_base.txt` mezclan líneas
    de dos procesos con la misma etiqueta. Los `.npz` por fila no están afectados.

## 2. Estimador y su holgura

**Cota inferior de Barber-Agakov**, la familia del verificador de la ronda 2 (no es Monte Carlo anidado):
- I(Z;Y) ≥ H(Z) + E[log2 q(z|y)], con q de un perceptrón (3 capas de 128 SiLU, Adam, 8 épocas). El código es `ver3_red.py`, que
  extiende la red de `ver2_clasif.py`.
- **Todas las cifras de I son cotas inferiores.** La holgura E KL(p‖q) es ≥ 0.

**Cabezas.** El tronco es común y hay cuatro softmax:
- mecanismo, con todas las muestras;
- log10 K en bins finos, solo con chips con túnel;
- q, solo con chips con túnel (no en q fijo);
- log10 B, con todas las muestras.

I(túnel), I(F/túnel residual), I(s_X) e I(Kbin) salen de sumar probabilidades de esas cabezas, y cada suma es también una q
válida.

**Datos.**
- Entrenamiento: 300 000 chips por clase (W1, W1q1, W1K6, W0) y 150 000 (W2).
- Prueba, independiente: 100 000 por clase, y 40 000 en W2.
- ± es 1 error típico, con media estratificada por clase verdadera. Las diferencias son pareadas (`ver3_pares.py`).

**Entradas:** como en la ronda 2. Por lectura, el estado de censura y el valor recortado; además, todas las diferencias entre
lecturas.

**Controles** (`ver3_control.txt`). Cada uno es la cota del control menos la de la fila base, pareado:

| Control | I(M;Y) | I(Kbin\|túnel) | D5: A2 E4 − E2 en I(Kbin) | D5: S10 E4 − E2 en I(Kbin) |
|---|---|---|---|---|
| base (H 128, 300 k por clase, semilla 1) | — | — | +0,1002 ± 0,0010 | +0,0490 ± 0,0008 |
| H = 256 | +0,0026 a +0,0049 | +0,0084 a +0,0100 | +0,1014 | +0,0490 |
| doble de datos (600 k por clase) | +0,0032 a +0,0066 | +0,0106 a +0,0142 | +0,1000 | **+0,0500** |
| otra semilla (entrenamiento 1002) | −0,0013 a +0,0011 | −0,0063 a +0,0008 | +0,1006 | +0,0438 |
| una sola cabeza (solo M / solo K) | +0,0019 a +0,0050 | +0,0070 a +0,0102 | +0,0994 | +0,0471 |

- **Holgura absoluta.** Con más datos o más red la cota sube al menos 0,003–0,007 bits en I(M) y 0,010–0,014 en I(Kbin).
  - Mis valores absolutos están por debajo del verdadero en al menos esas cantidades.
  - Cuánto más falta, no lo sé `[?]`: el doble de datos todavía sube, así que no he llegado a la meseta.
- **Holgura de las diferencias:** se compensa. Las diferencias que deciden se mueven ≤ 0,006 bits entre controles.
- **Valores exactos conocidos:**
  - **Reducción W0** (abajo).
  - **I(Kbin|túnel) en E2sin27 = −0,0004.** Lo exacto es 0: no hay ninguna lectura con d > 0.
  - **I(qbin|túnel) en E1 y E2 = −0,0005 a −0,0011.** Lo exacto es 0: q no actúa en d ≤ 0,27.
  - **W1q1cut E2 = W1q1 E2 bit a bit** (1,0402), como debe ser: E2 no tiene d054.
  - Las cotas no salen optimistas en ningún caso cuyo valor exacto conozco.
- **Calibración de los posteriores de K.** La cobertura del intervalo del 90 % es 0,907–0,967 en todas las filas: está calibrado
  o un poco ancho (conservador).
- **Monotonía:** E1 ⊂ E2 ⊂ E3 ⊂ E4 ⊂ E5 en A2 y S10, para I(M), I(túnel), I(Kbin) e I(F). Ninguna bajada pasa de 2σ + 0,005
  (`ver3_pares.txt`).

**Reducción W0** × C1 × E1 frente al verificador de la ronda 2 (PREREG §4.1):

| Lector | Mío | Ronda 2 | Diferencia |
|---|---|---|---|
| A (ancho) | 1,4885 ± 0,0008 | 1,4876 | +0,0009 |
| X (XC26) | 1,3921 ± 0,0009 | 1,3938 | −0,0017 |
| A2 (mixto) | 1,7701 ± 0,0010 | 1,7707 | −0,0006 |

**Pasa:** todas las diferencias quedan dentro de 0,03 y de 0,002. No es una comprobación independiente de la familia de
estimador: los dos verificadores usamos Barber-Agakov. Sí es independiente del código, que reescribí.

## 3. Números (W1 C3b salvo indicación; cota inferior ± 1 error típico)

La tabla completa, 108 filas con la matriz de confusión en los registros, está en `ver3_tabla.md`. Las variantes y lectores
están en el PREREG §3.

Columnas: I(túnel) tiene máximo 0,971; I(F/tún.) tiene máximo 0,918; las clases de K van como estimada / acotada / nada, con el
intervalo HPD.

| | I(M;Y) | I(túnel) | I(F/tún.) | I(Kbin\|tún.) | K: est / acot / nada | I(qbin\|tún.) | d.t. log10 B |
|---|---|---|---|---|---|---|---|
| A2 E1 | 1,5773 ± 0,0008 | 0,6814 | 0,9162 | 0,9439 ± 0,0024 | 0,142 / 0,458 / 0,400 | −0,0005 | 0,981 |
| A2 E2 | 1,6330 ± 0,0009 | 0,6952 | 0,9162 | 1,0403 ± 0,0024 | **0,175 / 0,481 / 0,344** | −0,0009 | 0,547 |
| A2 E3 | 1,6699 ± 0,0009 | 0,7054 | 0,9162 | 1,1336 ± 0,0024 | 0,204 / 0,489 / 0,307 | 0,0617 | 0,546 |
| A2 E4 | 1,6803 ± 0,0009 | 0,7064 | 0,9162 | 1,1406 ± 0,0024 | 0,207 / 0,487 / 0,306 | 0,0920 | 0,545 |
| A2 E5 | 1,7381 ± 0,0009 | 0,7110 | 0,9163 | 1,1853 ± 0,0024 | 0,216 / 0,495 / 0,289 | 0,1040 | 0,545 |
| A2 E6 | 1,3398 ± 0,0010 | 0,5750 | 0,9152 | 0,9568 ± 0,0023 | 0,088 / 0,539 / 0,374 | 0,0932 | 0,838 |
| A2 E6c | 1,2273 ± 0,0009 | 0,5253 | 0,9152 | 0,7258 ± 0,0025 | 0,031 / 0,563 / 0,406 | −0,0002 | 0,843 |
| S10 E1 | 1,6044 ± 0,0008 | 0,6656 | 0,9182 | 0,8176 ± 0,0026 | 0,129 / 0,360 / 0,510 | −0,0005 | 1,137 |
| S10 E2 | 1,6309 ± 0,0008 | 0,6787 | 0,9182 | 0,9525 ± 0,0025 | 0,166 / 0,398 / 0,436 | −0,0009 | 1,123 |
| S10 E3 | 1,6348 ± 0,0008 | 0,6828 | 0,9182 | 0,9944 ± 0,0025 | 0,178 / 0,402 / 0,420 | 0,0525 | 1,123 |
| S10 E4 | 1,6394 ± 0,0008 | 0,6841 | 0,9182 | 1,0015 ± 0,0025 | 0,181 / 0,399 / 0,421 | 0,0643 | 1,123 |
| S10 E5 | 1,6583 ± 0,0008 | 0,6869 | 0,9182 | 1,0392 ± 0,0026 | 0,187 / 0,422 / 0,391 | 0,0709 | 1,123 |
| S10 E6 | 1,2767 ± 0,0009 | 0,5452 | 0,9182 | 0,8184 ± 0,0025 | 0,109 / 0,525 / 0,366 | 0,0651 | 1,143 |
| S10 E6c | 1,2499 ± 0,0009 | 0,5241 | 0,9182 | 0,7031 ± 0,0025 | 0,078 / 0,552 / 0,371 | −0,0003 | 1,143 |
| X E1 | 1,2693 ± 0,0008 | 0,5289 | 0,9182 | 0,5918 | 0,002 / 0,780 / 0,218 | — | 0,947 |
| X E4 | 1,3198 ± 0,0008 | 0,5656 | 0,9181 | 0,7290 | 0,005 / 0,776 / 0,219 | 0,0886 | 0,560 |
| A E1 | 1,4921 ± 0,0006 | 0,6335 | 0,9154 | 0,1697 | 0,021 / 0,039 / 0,940 | — | 1,154 |
| A E4 | 1,4916 ± 0,0006 | 0,6330 | 0,9153 | 0,1697 | 0,021 / 0,038 / 0,941 | 0,0002 | 1,154 |
| S1 E1 | 1,6683 ± 0,0009 | 0,6799 | 0,9182 | 1,0400 | 0,172 / 0,406 / 0,422 | — | 1,046 |
| S1 E4 | 1,7211 ± 0,0009 | 0,7107 | 0,9182 | 1,2956 | 0,250 / 0,421 / 0,329 | 0,1177 | 0,937 |
| S100 E1 | 1,5363 ± 0,0007 | 0,6482 | 0,9182 | 0,5270 | 0,073 / 0,163 / 0,764 | — | 1,154 |
| S100 E4 | 1,5622 ± 0,0007 | 0,6607 | 0,9182 | 0,6810 | 0,111 / 0,269 / 0,619 | 0,0256 | 1,153 |

**W1q1** (q = 1), C3b:

| | I(M;Y) | I(túnel) | I(Kbin\|túnel) | K: est / acot / nada |
|---|---|---|---|---|
| A2 E2 | 1,6338 | 0,6952 | 1,0402 ± 0,0024 | 0,175 / 0,476 / 0,349 |
| A2 E4 | 1,6809 | 0,7066 | 1,1521 ± 0,0024 | 0,226 / 0,470 / 0,305 |
| S10 E2 | 1,6303 | 0,6783 | 0,9517 ± 0,0025 | 0,166 / 0,399 / 0,435 |
| S10 E4 | 1,6389 | 0,6835 | 1,0009 ± 0,0025 | 0,182 / 0,407 / 0,411 |
| W1q1cut A2 E4 | 1,6810 | 0,7066 | 1,1368 ± 0,0024 | 0,206 / 0,492 / 0,302 |

**W1K6** (K ≤ 10⁶; Kbin con H = 1), C3b:

| | I(M;Y) | I(túnel) | I(Kbin\|túnel) | K: est / acot / nada | I(qbin\|túnel) |
|---|---|---|---|---|---|
| A2 E1 | 1,7421 | 0,8445 | 0,3960 | 0,163 / 0,000 / 0,837 | — |
| A2 E4 | 1,8820 | 0,9067 | 0,4283 ± 0,0016 | 0,176 / 0,000 / 0,824 | 0,3596 |
| S10 E1 | 1,7253 | 0,7844 | 0,5042 | 0,289 / 0,000 / 0,711 | — |
| S10 E4 | 1,7980 | 0,8400 | 0,5465 ± 0,0014 | 0,319 / 0,000 / 0,681 | 0,2534 |
| X E1 / E4 | 1,5590 / 1,6586 | | | | |
| A E1 / E4 | 1,5131 / 1,5128 | | | | |

**W2** (componentes simultáneos; I(clase;Y) con máximo 3 bits), C3b:

| | I(clase;Y) | I(s_T) | I(s_R) | I(s_F) | I(F/túnel, excl.) | I(Kbin\|s_T) | K: est / acot / nada | d.t. log10 B |
|---|---|---|---|---|---|---|---|---|
| A2 E1 | 1,5925 | 0,6279 | 0,8800 | 0,0825 | 0,6507 | 0,8711 | 0,122 / 0,431 / 0,447 | 1,040 |
| A2 E2 | 1,6537 | 0,6346 | 0,8800 | 0,1350 | 0,6667 | 0,9080 | 0,132 / 0,438 / 0,430 | 0,554 |
| A2 E3 | 1,7104 | 0,6450 | 0,8797 | 0,1819 | 0,6971 | 1,0017 | 0,158 / 0,484 / 0,358 | 0,552 |
| A2 E4 | 1,7469 | 0,6490 | 0,8792 | 0,2162 | 0,7170 | 1,0311 | 0,167 / 0,490 / 0,343 | 0,550 |
| A2 E6 | 1,2996 | 0,4757 | 0,5093 | 0,1813 | 0,5567 | 0,8524 | 0,063 / 0,566 / 0,371 | 0,818 |
| A2 E6c | 1,1186 | 0,4198 | 0,5006 | 0,0541 | 0,3943 | 0,6082 | 0,022 / 0,539 / 0,440 | 0,846 |
| S10 E2 | 1,6137 | 0,6224 | 0,8804 | 0,1079 | 0,6431 | 0,8676 | 0,143 / 0,376 / 0,482 | 1,079 |
| S10 E4 | 1,6552 | 0,6311 | 0,8802 | 0,1417 | 0,6692 | 0,9369 | 0,161 / 0,406 / 0,433 | 1,039 |
| X E1 / E4 | 1,0885 / 1,2472 | | | | | | | |
| A E1 / E4 | 1,4592 / 1,4595 | | | | | | | |
| S1 E4 / S100 E4 | 1,7723 / 1,5481 | | | | | | | |

- Errores típicos: I(clase) ±0,0009–0,0014; I(s_X) ±0,0005–0,0010; I(Kbin) ±0,0022–0,0029.
- **Calibración (A2; S10 no cambia con σs, por la decisión 7):**

| | C1 | C3a (0,05) | C3b (0,2) | C3c (0,5) |
|---|---|---|---|---|
| A2 E4 I(M;Y) | 1,6825 | 1,6825 | 1,6803 | 1,6636 |
| A2 E4 I(Kbin\|túnel) | 1,2753 | 1,2599 | 1,1406 | 0,9147 |
| A2 E4 K estimada | 0,232 | 0,230 | 0,207 | **0,002** |
| A2 E2 K estimada | 0,199 | 0,196 | 0,175 | 0,000 |

**Testigos** (W1 C3b):
- **K** (t0 = 10 µA, K = 10⁷, q = 1; 4000 chips T con el resto del prior):
  - A2 E2: estimada 0,763, acotada 0,007, nada 0,230. El intervalo contiene 10⁷ en el 0,919.
  - S10 E2: estimada 0,440, nada 0,526.
  - X E2: estimada 0, acotada 0,357.
  - **Mutante** sin d027 (E2sin27): nada 1,000. **Pasa.**
- **F** (f0 = 10⁻¹², λF = 0,5): en E6 con A2, P(F|y) media 0,932 (0,893 de los chips con más de 0,8) y P(túnel) 0,000. **Pasa.**
  - En E2 solo 0,811 de media (0,568 con más de 0,8).
- **B y los dos mutantes del estimador de §5:** son pruebas del estimador del autor. No los corrí `[?]`.

## 4. Diferencias pareadas que deciden (C3b; `ver3_pares.txt`)

**D5 (E2 → E4)**

| | I(túnel) | I(Kbin\|túnel) | I(F/túnel res.) | I(s_F) (W2) | d.t. B: E2 − E4 |
|---|---|---|---|---|---|
| W1 A2 | +0,0112 ± 0,0002 | **+0,1002 ± 0,0010** | +0,0000 | — | +0,002 |
| W1 S10 | +0,0054 ± 0,0002 | +0,0490 ± 0,0008 (con el doble de datos +0,0500) | +0,0000 | — | −0,000 |
| W2 A2 | +0,0144 ± 0,0003 | **+0,1231 ± 0,0013** | **+0,0503 ± 0,0008** | **+0,0812 ± 0,0007** | +0,004 |
| W2 S10 | +0,0086 ± 0,0003 | **+0,0692 ± 0,0011** | +0,0261 ± 0,0006 | +0,0338 ± 0,0005 | +0,040 |
| W1q1 A2 | +0,0114 ± 0,0002 | **+0,1119 ± 0,0011** | 0 | — | +0,002 |
| W1q1 S10 | +0,0052 ± 0,0002 | +0,0492 ± 0,0008 | 0 | — | −0,000 |
| W1q1cut A2 | | +0,0966 ± 0,0010 | | | |

- La mayor parte de la subida está ya en E3 (W1 A2: E3 − E2 = +0,0933 en I(Kbin)). d108 añade +0,0069.
- **I(qbin|túnel), E2 → E4:** W1 A2 +0,0929; W1 S10 +0,0651; W2 A2 +0,0633.

**D6 (E1 → E2)**

| | W1 A2 | W1 S10 | W2 A2 | W2 S10 |
|---|---|---|---|---|
| I(M;Y) | **+0,0557 ± 0,0005** | +0,0266 ± 0,0004 | **+0,0611 ± 0,0007** | **+0,0657 ± 0,0008** |
| I(Kbin\|túnel) | **+0,0965 ± 0,0011** | **+0,1349 ± 0,0013** | +0,0369 ± 0,0009 | **+0,0769 ± 0,0012** |

**D7 (S_f − A2, W1)**

| | E1 | E2 | E4 |
|---|---|---|---|
| S1, I(M) | +0,0910 ± 0,0007 | +0,0706 ± 0,0006 | +0,0409 ± 0,0005 |
| S10, I(M) | +0,0271 ± 0,0006 | −0,0020 ± 0,0006 | −0,0409 ± 0,0006 |
| S100, I(M) | −0,0409 ± 0,0006 | −0,0746 ± 0,0007 | −0,1181 ± 0,0007 |
| S1, I(Kbin) | +0,0961 | +0,1443 | +0,1551 |
| S10, I(Kbin) | −0,1263 | −0,0878 | −0,1390 |
| S100, I(Kbin) | −0,4168 | −0,3763 | −0,4596 |

- Los errores de I(Kbin) son ±0,0015–0,0023.
- **W2, E4:** S1 − A2 = +0,0254 en I(M) y +0,1295 en I(Kbin). S10 − A2 = −0,0918 y −0,0942. S100 − A2 = −0,1988 y −0,3692.
- **σs, W1 E4:** S10 − A2 en I(M) vale −0,0431 en C1 y C3a, −0,0409 en C3b y −0,0242 en C3c. En I(Kbin) vale −0,2738, −0,2584,
  −0,1390 y +0,0868.
  - En E1, I(M) va de +0,024 a +0,046.

**D8 (A2 − lector único, I(M;Y))**

| | A2 − X | A2 − A |
|---|---|---|
| W1 E1 | +0,3080 ± 0,0010 | **+0,0851 ± 0,0006** |
| W1 E4 | +0,3605 | **+0,1887 ± 0,0007** |
| W1K6 E1 | +0,1831 | +0,2289 |
| W1K6 E4 | +0,2234 | +0,3692 |
| W2 E1 | +0,5040 | +0,1334 ± 0,0010 |
| W2 E4 | +0,4997 | +0,2875 ± 0,0011 |
| W1 C1 E1 / E4 (contra A) | | +0,0875 / +0,1897 |

**P4, I(F frente a túnel residual)**

| | W1 A2 | W1 S10 | W2 A2 | W2 S10 |
|---|---|---|---|---|
| E2 → E3 | 0,0000 | 0,0000 | +0,0304 ± 0,0007 | +0,0167 ± 0,0005 |
| E6c → E6 | 0,0000 | 0,0000 | **+0,1623 ± 0,0011** | +0,0821 ± 0,0009 |
| E6c → E6 en I(s_F) | | | +0,1271 | +0,0507 |

**P3 (W1K6, E4):** S10 − A2 en I(Kbin|túnel) = **+0,1182 ± 0,0015**. En E1 es +0,1082.

## 5. Veredictos, con mis números

**Predicciones**

| | Predicción | Mis números | Veredicto |
|---|---|---|---|
| P1 | W1q1, E2 → E4: I(túnel) e I(Kbin\|túnel) < 0,05 | A2: túnel +0,011; **Kbin +0,112**. S10: +0,005 y +0,049 | **Falla con A2** (Kbin, por 0,06). Con S10 se cumple por 0,001. El motivo físico de P1 sí se sostiene: el túnel en 0,54 casi nunca se lee (W1q1cut quita solo 0,015 de los 0,112). Lo que la cuenta no previó es el efecto referencia (§7.1) |
| P2 | A2 E2: estimada entre 0,12 y 0,35; acotada ≥ 0,4 | 0,175 / 0,481 (central: 0,176 / 0,409) | **Se cumple** con las dos definiciones. La acotada central queda a 0,009 del umbral |
| P3 | W1K6: S10 − A2 en I(Kbin\|túnel) ≥ 0,05 | +0,118 ± 0,002 | **Se cumple** |
| P4 | E2 → E3 en I(F/túnel res.) < 0,05; E6c → E6 ≥ 0,1 | W1: 0 y 0. W2 A2: +0,030 y +0,162. W2 S10: +0,017 y +0,082 | **En W1 falla la segunda parte**: la cantidad está saturada en 0,915–0,918 de 0,918 en todos los diseños (§6.1). **En W2 se cumple con A2**; con S10 falla la segunda |
| P5 | E1 → E2 sube I(M) ≥ 0,05 | A2 +0,056; S10 +0,027. W2: +0,061 y +0,066 | **Se cumple con A2** (W1 y W2). En W1 con S10 no |
| P6 | D8 sobrevive en E1 con C3b, pero menos que en la ronda 2, porque g_s y g_a son independientes | A2 − A = +0,085 (ronda 2: +0,283). Pero C1 da +0,0875: la independencia cuesta 0,002 | **Se cumple en signo y en tamaño, pero falla el mecanismo.** La bajada la pone el modelo: con K ≤ 10⁶, +0,229 |
| P7 | S1 ≥ A2; S1 − A2 en I(M) ≤ 0,1 en E4; empate (< 0,05) en f = 100 | S1 − A2: +0,041 (E4). S100 − A2: **−0,118**. El empate está en f = 10 (−0,041) | **El tamaño se cumple; el punto de empate falla** (f = 10, no 100) |

**Decisiones**

| | Regla | Mis números | Veredicto |
|---|---|---|---|
| D5 | Se dibujan 0,54 y 1,08 si alguna de las tres sube ≥ 0,05 en E2 → E4 con A2 o S10 | W1: I(Kbin) +0,100 (A2). W2: I(Kbin) +0,123 y F/túnel +0,050 (A2); I(Kbin) +0,069 (S10) | **Se mantiene en W1 y en W2**, solo por I(Kbin\|túnel) (y en W2 también por F, en el umbral). «Depende de la exclusividad»: no; mismo veredicto en las dos |
| D5, predicción global | «Solo por I(Kbin) bajo q libre, o por F sin temperatura; bajo q = 1 con 85 °C, muere» | W1q1 A2: +0,112 | **Falla:** con q = 1 y 85 °C D5 vive. El valor no es el túnel en 0,54, sino la referencia de G + B (§7.1) |
| D5' | E2 → E4 sube I(s_F) ≥ 0,05 (W2) o estrecha la d.t. de log10 B en ≥ 0,3 décadas | I(s_F) +0,081 (A2), +0,034 (S10); B +0,004 / +0,040 | **Se mantiene, con A2, por s_F.** Por B, no |
| D6 | La celda sin unión hace falta si E1 → E2 sube I(M) o I(Kbin) ≥ 0,05 | A2: +0,056 y +0,097. S10: +0,027 y +0,135. W2: +0,061 / +0,066 en I(M) | **Sí** |
| D7 | Precio, no decisión | S_f − A2 en I(M): S1 de +0,04 a +0,09; S10 de −0,04 a +0,03; S100 de −0,04 a −0,12. Empate en I(M): f = 10 (E1, E2, E4) y f = 1 en E4. En I(Kbin) solo gana S1 (+0,10 a +0,16); S10 pierde de 0,09 a 0,14 | σs de empate: en I(M) S10 empata con A2 para todo σs de 0,05 a 0,5, así que el empate no está definido. En I(Kbin) el cruce está entre 0,2 y 0,5; interpolando, hacia σs ≈ 0,38 (conjetura) |
| D8 | A2 supera al mejor único en ≥ 0,05 en E1 y en E4, con C3b y K hasta 10¹² | +0,085 (E1) y +0,189 (E4) contra A. W1K6: +0,183 y +0,223. W2: +0,133 y +0,288 | **Sobrevive con K hasta 10¹²**, no solo con K ≤ 10⁶. Con la holgura de §2 (≤ 0,01 en diferencias), E1 queda a 0,035 del umbral |

**Criterios de §7**

| Criterio | Veredicto |
|---|---|
| «Muere D5» | No muere |
| «Muere la pregunta K» (estimada < 0,1 en todos los diseños) | **No muere**. Estimada 0,13–0,22 con A2 y S10 en E1–E5 (W1), 0,12–0,17 en W2. Solo baja de 0,1 en E6 y E6c (A2: 0,088 y 0,031), en X y A (≤ 0,021) y con C3c (≤ 0,002) |
| «Muere el motor como herramienta» | **No se cumple** con mis números: P1, P4 (W1) y P7 (empate) fallan, y P6 falla en el mecanismo. «**Vive el motor**»: la predicción global de D5 sale en contra |
| «Instrumento inválido» | Para mi instrumento: la reducción pasa, el testigo F pasa y el mutante K pasa. El testigo K da «estimada» en el 76 % de los chips (A2 E2), no en todos (§6.6). No corrí B ni los mutantes del estimador anidado `[?]` |

**Identificabilidad (Enmienda 1, §2), A2, C3b:**
- **I(qbin|túnel)**, de 2 bits: E2 −0,001 (lo exacto es 0); E4 0,092 en W1 y 0,062 en W2; W1K6 E4 0,360.
- **I(s_F;Y)**, de 1 bit: E2 0,135; E4 0,216; E6 0,181; E6c 0,054.
- **d.t. posterior de log10 B**, prior 1,155:
  - W1: E1 0,981, E2 0,547, E4 0,545.
  - W2: E1 1,040, E2 0,554, E4 0,550.
  - S10, W1: 1,123 en E2 y en E4. **S10 no ve la celda sin unión** (§7.2).

## 6. Ambigüedades y errores del PREREG

1. **En W1, «I(F frente a túnel residual)» no mide el túnel residual.**
   - Vale 0,915–0,918 de 0,918 en **todos** los diseños, también en E1 sin separaciones y con el lector A.
   - En los chips T y M el túnel en d = 0 da ≥ 12 nA; F en d = 0 da ≤ 10⁻¹¹ A con la activación. La lectura base los separa.
   - La Enmienda 1 preveía que la exclusividad inflaría esta cantidad. La infla hasta el techo: P4 (W1) y la rama F de D5 no
     pueden moverse por construcción.
   - Solo W2 hace la pregunta con sentido.
2. **El razonamiento de P1 y de la predicción global de D5 olvida que las separaciones también son celdas de referencia** de G + B
   (G no depende de d, §3). Ver §7.1.
3. **El mecanismo de P6 no es el que da el modelo.** C1 frente a C3b mueve I(M) de A2 en 0,002–0,004 bits. La caída de D8 respecto
   a la ronda 2 viene de K hasta 10¹², de B y de F (W1K6: +0,229 frente a +0,085).
4. **Kbin.** «Bins de 1 década» no divide el prior de 8,155 décadas.
   - «Se normaliza por H(Kbin)» no dice si el umbral de 0,05 se aplica antes o después de normalizar.
   - Normalizada, la subida de D5 en A2 sería +0,033: **por debajo del umbral**.
   - Con mi lectura (bits sin normalizar) D5 vive.
   - Con la otra, en W1 D5 **muere**: A2 +0,033, S10 +0,016.
   - En W2 sobrevive solo por I(F/túnel, excl.) = +0,0503 ± 0,0008, justo en el umbral. D5' (s_F +0,081) no depende de esto.
   - **Es la ambigüedad que más pesa en un veredicto.**
5. **El intervalo creíble no tiene tipo.** El PREREG no dice si es el más corto o el central.
   - Cambia la «acotada»: 0,481 frente a 0,409 en A2 E2. P2 queda a 0,009 de su umbral con la central.
   - «Acotada (solo K mínima)» no coincide con la definición de §5, que admite los dos bordes. Por la aritmética, el borde
     inferior solo lo tocan los chips que saturan, ≤ 4,1 %: la «K mínima» sería ≥ 0,44 (deducción, no la medí).
6. **«La clase debe ser estimada»** (testigo K) no dice si en todos los chips o en la mayoría.
   - Con el resto de parámetros sacados del prior, B a 85 °C (hasta 5·10⁻¹¹) tapa 1 pA en una parte.
   - Me da 0,76 con A2, 0,44 con S10 y 0 con X.
7. **D7: «el σs de empate»** no existe en I(M). S_f no tiene g_s, así que solo cambia A2, y A2 apenas se mueve con σs. Hay que
   decir en qué cantidad se busca el empate.
8. **Cosas que el PREREG no define:**
   - cómo elige rango S_f, y si L_sw aplica fuera de W2 (decisión 7);
   - si F tiene su propia forma en V (decisión 5);
   - si B depende de V o pasa por el excitador (decisión 3);
   - la versión W2 de «F frente a túnel residual» (decisión 11);
   - el lector con el que se juzgan P1, P5 y D6.
9. **El umbral de 0,05 bits frente al error de Monte Carlo pareado de 0,001.** El problema de la ronda 2 queda resuelto. Pero
   S10 en D5 cae en 0,0490–0,0500 según el control: el umbral corta dentro de la holgura del estimador. No decide nada aquí,
   porque A2 ya basta.

## 7. Lo que vi y no estaba previsto

1. **Las separaciones valen como referencia de fondo, no como lector del túnel.**
   - Con q = 1, E2 → E4 sube I(Kbin|túnel) en +0,112 con A2.
   - Con el túnel anulado en 0,54 y 1,08 (W1q1cut, mismos chips) sigue subiendo +0,097.
   - El túnel residual pone solo +0,015 ± 0,0004.
   - Lectura: d054 lee G + B, sin túnel. Restado de d027 = G + B + t0/K, deja t0/K limpio. Una sola celda basta (E3 − E2 = +0,093;
     d108 añade +0,007).
   - Depende del supuesto «G igual en todas las d» (§3). Si G escala con el perímetro o F cambia con d, la referencia se
     contamina. **Conjetura:** una celda de unión sin túnel (d grande) daría lo mismo que d054 y d108.
2. **S10 pierde la celda sin unión.**
   - Su piso (1,5 pA a 27 °C) queda sobre la mayor parte de B (≤ 1 pA).
   - La d.t. posterior de log10 B queda en 1,12 décadas, frente a 0,55 con XC26.
   - Por eso E1 → E2 sube I(M) en +0,027 con S10 y en +0,056 con A2.
   - En I(Kbin), S10 pierde frente a A2 por 0,09–0,14 bits. Solo S1 gana.
   - Para K, el piso de XC26 (150 fA) importa más que el rango.
3. **La calibración decide K, no el mecanismo.** De C1 a C3c, A2 E4 pierde 0,019 bits en I(M) y 0,36 en I(Kbin). La fracción
   «estimada» pasa de 0,232 a 0,002. Con σs = σa = 0,5 la pregunta K muere (estimada < 0,1) y la del mecanismo casi no cambia.
4. **Con K ≤ 10⁶ q se vuelve identificable:** I(qbin|túnel) = 0,36 bits (A2 E4). Con K hasta 10¹² baja a 0,09.
5. **E5** (0,54 y 1,08 también a 85 °C) suma +0,058 en I(M) con A2, más que E3 y E4. Su I(F/túnel) no cambia. **Conjetura:**
   separa G de F por su activación.
6. **El testigo F en E2 da P(F) > 0,8 solo en el 57 %; en E6, en el 89 %.** El testigo está prerregistrado en E6, y ahí pasa. Sin
   separaciones, F se confunde con G (confusión G ↔ F de 0,26 a 0,46 en E1–E2).
7. **En W2 la presencia de F casi no se ve:** I(s_F) = 0,08–0,25 bits de 1, con cualquier diseño.
8. **E6 (sin temperatura) frente a E1:** I(Kbin) parecida (0,957 frente a 0,944), pero I(M) mucho menor (1,340 frente a 1,577).

## 8. Comparación con el autor (escrita después de leer)

**Qué leí y cuándo.**
- A las **20:27:24** (`date`) listé la carpeta. Después leí `../motor3.py`, en la versión con fecha de modificación de las 20:14.
- A las **20:27:31** (`date`) leí `../res3_rapido.jsonl`.
- **Cambio posterior:** a las 20:28:01 `stat` daba a `motor3.py` la modificación de las **20:27:49**. El autor lo cambió después de que
  yo lo leyera, y no he leído esa versión.
- No abrí `../res3_rapido.npz`.
- No hay más resultados del autor en la carpeta.

**No hay números del autor que cotejar.**
- `res3_rapido.jsonl` es una prueba de humo de las 19:32, anterior a la versión que leí: 40 chips externos por clase, N1 = 2000,
  N2 = 200.
- Su W0 A2 E1 da I(M) = 1,37 ± 0,26, frente a mis 1,7701 y los 1,7707 de la ronda 2. Con ese error no dice nada.
- La regla de §9 («si difieren en más de 0,03 bits, la fila queda inválida») **no se puede aplicar todavía** `[?]`.

**Diferencias de modelo y de medida que vi en `motor3.py` (versión de las 20:14), por cuánto pueden pesar:**

1. **Kbin.**
   - El autor usa bordes cada 1 década desde log10 7·10³: 9 bins, el último de 0,155 décadas. El prior no es uniforme:
     H = 3,079 en W1 y 1,30 en W1K6, con 3 bins.
   - Yo uso 8 bins iguales (H = 3) y 2 en W1K6 (H = 1).
   - **Los valores absolutos de I(Kbin) no son comparables a 0,03.** Las diferencias E2 → E4 deberían parecerse más, pero no lo
     he comprobado `[?]`.
2. **Riesgo en su I(Kbin).**
   - Calcula log2 h(bin verdadero) con h, el histograma ponderado de los N2 chips internos, y pone un piso de 10⁻³⁰⁰.
   - Un chip cuyo bin verdadero no reciba ninguna muestra suma −997 bits.
   - Su prueba de humo da I_kbin = −27 y −47 bits: es ese efecto, con N2 = 200.
   - Con N2 = 2000 será más raro, pero cada caso pesa unos −1000/n_ext bits. **Recomiendo** suavizar el histograma o avisar del
     número de ceros.
3. **Clases de K.**
   - Su intervalo es central, del 5 al 95 %, y «toca» si queda a menos de 0,25 décadas del borde. Es mi variante central (con
     0,255).
   - Hay que compararlo con mis números «central»: A2 E2, 0,176 / 0,409 / 0,415. No con los HPD.
4. **S_f.**
   - El autor trata σr como ruido **independiente por lectura**, sumado en cuadratura a σe, y no elige rango.
   - Yo pongo un error común a las lecturas que comparten rango.
   - El autor suma L_sw a **todas** las lecturas de S_f, no solo a las del rango bajo. Por encima de 1 nA es despreciable.
   - Con su elección, los cocientes dentro de un mismo rango no se calibran, y su S_f debería salir algo peor que el mío
     (conjetura). Es el lugar más probable de una discrepancia en D7.
5. **F.** El autor usa la forma en V de G (gsh). Yo le doy un fsh propio con el mismo prior. Efecto esperado: pequeño, y solo en G
   frente a F `[?]`.
6. **d.t. de B.** El autor la calcula sin la varianza dentro del bin. Con bins de 0,05 décadas la diferencia es despreciable.
7. **Tamaño de muestra.**
   - Por defecto, n_ext = 400 chips externos por clase.
   - Con mis errores pareados (±0,0005–0,001 con 100 000 por clase), el suyo pareado sería ~16 veces mayor: ±0,01–0,02.
   - Basta para el umbral de 0,05 en D5 (A2: +0,100), D6, D8 y P3.
   - **No basta** para S10 en D5 (+0,049–0,050), para P2 a 0,009 de su umbral, ni para D8 en E1 (+0,085, a 0,035 del umbral).
8. **Coinciden con mis decisiones:** censura sobre la lectura; B tras el excitador y sin pasar por Rs; desajuste de B de 0,15
   décadas por celda en W2; la celda sin unión lee solo B; las clases, los priors, el sub-problema de F frente a túnel residual
   ({T, M, F} con 1/3 cada uno) y la variable túnel.
   - También comparten conmigo, por construcción, la saturación de I(F/túnel res.) en W1 (§6.1).
9. **Validez de su estimador.**
   - Su propuesta usa los parámetros del chip verdadero como ancla, solo para su clase (`anclas`).
   - Los pesos L·p/q siguen siendo exactos. Pero las clases falsas no tienen ancla, así que la varianza no es simétrica entre
     clases. Puede sesgar I(M) hacia arriba en muestras finitas: el log de una media insesgada está sesgado hacia abajo, y más en
     las clases con peor propuesta.
   - Que se note o no, `[?]`: lo dirá su control con 4× chips internos.

## 9. Archivos (todos en esta carpeta, con prefijo `ver3_`)

- **Código:**
  - `ver3_modelo.py`: el modelo.
  - `ver3_red.py`: la red multi-cabeza.
  - `ver3_correr.py`: el estimador y los testigos.
  - `ver3_pares.py`: diferencias pareadas.
  - `ver3_control.py`: holgura.
  - `ver3_tabla.py`: la tabla.
- **Salidas:**
  - `ver3_log_*.txt`: registros por proceso, con las matrices de confusión.
  - `ver3_R_*.txt`: copia por etiqueta. Ojo: `ver3_R_W1_base.txt` mezcla dos procesos.
  - `ver3_tabla.md`, `ver3_pares.txt`, `ver3_control.txt` y `ver3_NUMEROS.txt` (fijado a las 20:24:50).
- **Volcados (`.gitignore`):**
  - `ver3_lt_*.npz`: log q por muestra.
  - `ver3_mundo_*.npz`: los mundos simulados, de 70 a 550 MB cada uno.
- `ver3_humo/`: la prueba de humo de 3000 chips, que no se usa.
- CPU: 108 filas de 35 a 190 s cada una, con 2 a 4 hilos. En total, unas 2 h de CPU `[?]`: no lo medí con un contador.
