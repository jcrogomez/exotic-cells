# Verificación independiente, ronda 2 (XC-20, mecanismos que coexisten) · informe

Verificador independiente. Empecé a las 17:04:43 EST (`date`). Antes de fijar mis números leí **solo** `../PREREG.md`,
`../../xc20_hipotesis/{PREREG.md, INFORME.md, resultados.txt}` y `../../xc20_hipotesis/verificacion/{ver_INFORME.md, ver_xc20.py}`.
A las 17:08 vi en un `ls` que existían `../motor2.py` y `../motor2_salida.txt` (nombres y tamaños), sin abrirlos.

- **Números fijados:** `ver2_NUMEROS.txt`, con la marca `Sun Nov 15 17:40:42 EST 2026` escrita por `date` en el mismo comando.
- **Leído después:** `../motor2_salida.txt` a las 17:40:48 (`date` del mismo comando; todavía en curso, 75 filas) y `../motor2.py`
  entre ese momento y las 17:41:44 (`date`). No leí `../../xc20_hipotesis/motor.py`.
- Lo que sigue a §6 lo escribí después de leerlos. Las tablas de §3 a §5 son las de `ver2_NUMEROS.txt` y no las cambié.

Todo es modelo. Nada está medido.

## 1. Elecciones ante ambigüedades del PREREG

1. **Censura.** Se aplica a la lectura y = log10 I + g (+δ) + ε, con los umbrales nominales. Es lo que dice el texto y lo que hizo
   la ronda 1. Equivale a que el lector sature a la salida, después de la ganancia. La otra lectura posible (censura sobre la
   corriente verdadera) no la corrí `[?]`.
2. **Excitador.** Bisección de V + Rs·I(V) = Vap; después I = min(I(V*), Imax). Si el dispositivo pediría más de Imax, la fuente
   entrega Imax. Un solo Rs y un solo Imax por chip, comunes a todas sus medidas (d = 0, d = 0,27, peine, 27 y 85 °C). Rs no
   cambia con la temperatura. También se aplica con el lector XC26.
3. **Túnel en d = 0,27.** t0/K con la misma dependencia en V (exponente a) y en temperatura (tea) que en d = 0.
4. **Peine.** T y R ×4 dentro de la ecuación del excitador (más caída en Rs). G no cambia.
5. **R no lineal**, con probabilidad 1/2, en V2 y V4. V0 lo deja en 1,8 V igual que el óhmico (normalización (1,8/Rb)·sinh/sinh).
   Rb log-U 10 Ω–10 MΩ solo en V4, también para la parte R de M.
6. **G.** gsh U 1,0–1,4, b = log2 gsh (como el verificador de la ronda 1).
7. **C2.** δ se suma a las cuatro lecturas posibles a 85 °C (d = 0 y d = 0,27).
8. **Variantes intermedias**, que no estaban en el mínimo pedido, según la tabla del PREREG:
   - V1: T, R, M, G; R óhmico, Rb ≤ 100 kΩ, excitador ideal.
   - V2: T, R, G; R óhmico o no lineal, Rb ≤ 100 kΩ, excitador ideal.
   - V3: T, R, G; R óhmico, con excitador.
9. **σΔ de D1.** Doy el error **pareado**: las lecturas de prueba son las mismas en los dos diseños (mismo chip, misma g y mismas
   ε en las medidas compartidas). Además doy una cota del sesgo (§2). En §4 digo qué daría el criterio sin parear.
10. **Túnel = {T, M} frente a {R, G}**, con prior 1/2. H(M) = log2 3 en V0, V2 y V3; 2 bits en V1 y V4.

## 2. Método: dos estimadores, ninguno es Monte Carlo anidado

**B: cota variacional de Barber-Agakov** (`ver2_clasif.py`). Es el estimador principal.
- I(M;Y) ≥ H(M) + E[log2 q(m|y)], con q un perceptrón de 3 capas (128 SiLU, numpy, Adam).
- Entrenamiento: 300 000 lecturas por mecanismo. Prueba: 100 000 por mecanismo, independientes, siempre con la semilla 2000.
- Entradas: el estado de censura de cada lectura, su valor recortado a los umbrales y todas las diferencias entre lecturas.
- I(túnel;Y) ≥ 1 + E[log2 q_t], con q_t = q(T) + q(M). El acierto es el del argmax de q (también una cota inferior).
- ± es 1 error típico sobre las muestras de prueba.
- Como la semilla de prueba es la misma en todas las corridas, las diferencias entre diseños, entre lectores y entre calibraciones
  son pareadas (`ver2_pares.py`).

**A: verosimilitud por cuasi-Monte Carlo** (`ver2_qmc.py`). Es el control.
- p(y|m) = media sobre M = 2¹⁴–2¹⁷ chips Sobol aleatorizados (13 dimensiones).
- La calibración (g, o g y δ) se integra de forma **analítica** en las lecturas legibles (lineal y gaussiana).
- Cada factor censurado se evalúa con la marginal gaussiana exacta del desplazamiento posterior. Con varios censurados uso el
  producto de marginales, que es una aproximación.
- Sin ninguna lectura legible (C1 y C2), la verosimilitud solo depende del patrón de censura. Integro g en una rejilla de 1201
  puntos (±6σg) y δ con Gauss-Hermite de 7 nodos.
- A se evalúa sobre un subconjunto de las **mismas** lecturas de prueba que B, lo que permite compararlos muestra a muestra
  (`ver2_cmp.py`).

**Cómo acoté el sesgo de B.** La holgura de la cota es E_y KL(p‖q) ≥ 0. La estimé con E[log2 p_A − log2 q_B] sobre las mismas
lecturas (`ver2_cmp_C0.txt`, `ver2_cmp_C1.txt`, `ver2_cmp_resto.txt`):

| Caso | A − B (bits), por diseño |
|---|---|
| V0 C0 0,05 ancho, 5 diseños (A: N 2000, M 2¹⁶) | +0,0000 a +0,0004 (± ≤ 0,0003) |
| V4 C0 0,05 ancho, 5 diseños (N 1500, M 2¹⁶) | +0,0000 a +0,0016 (± ≤ 0,0013) |
| V4 C1 ancho, 5 diseños (N 1500, M 2¹⁶) | −0,0015 a +0,0005 (± ≤ 0,0034) |
| V4 C1 ancho, +85 °C y −0,9 V (N 1000, M 2¹⁷, otra semilla Sobol) | −0,0002 ± 0,0007 · +0,0006 ± 0,0012 |
| V4 C1 XC26, +85 °C y −0,9 V (N 1000, M 2¹⁶) | +0,0002 ± 0,0005 · +0,0002 ± 0,0001 |
| V4 C0 0,5 XC26 y ancho, −0,9 V | +0,0000 ± 0,0001 · −0,0001 ± 0,0002 |
| V4 C2 ancho, +85 °C | +0,0003 ± 0,0007 |
| V4 C2 ancho, +85 °C + −0,9 V (5 lecturas finas) | −0,0085 ± 0,0057 |

- A y B coinciden por lo general a ≤ 0,002 bits. La holgura de B es entonces ≤ ~0,003 bits (2σ) en todo lo comprobado.
- Donde A queda **por debajo** de B (5 lecturas finas), quien falla es A: B es una cota inferior, así que A no puede estar bien si
  da menos. Su interior de Sobol se queda corto. En esos diseños el número fiable es el de B.
- Capacidad: con H = 256, el doble de datos y otra semilla, V4 C1 cambia ≤ 0,0011 bits (`ver2_B_V4_C1_ancho_H256.txt`).
- Controles exactos:
  - V0 K = ∞, D0, σ 0,05: 1,3540 frente a la cuadratura de la ronda 1, 1,3534.
  - Lo mismo con σ 0,5: 1,2698 frente a 1,2692.
  - XC26 con K = ∞: 0,9186 (log2 3 − 2/3 = 0,9183).
  - Los casos de separación completa dan exactamente log2 3.
- No comprobado contra A (holgura supuesta del mismo orden, sin demostrar): V1–V3, el lector mixto, V4 XC26 C0 0,05 y C2.

## 3. Números (B, bits ± 1 error típico; holgura ≤ 0,003 donde se comprobó)

Diseños: D0 · +85 = D0 + 85 °C · −0,9 = D0 + −0,9 V · peine = D0 + peine · ambos = D0 + 85 °C + −0,9 V.

**V0 y V0 con K = ∞, lector ancho** (máximo 1,585):

| | D0 | +85 | −0,9 | peine | ambos |
|---|---|---|---|---|---|
| V0 K=∞, σ 0,05 | 1,3540 ± 0,0007 | 1,4448 ± 0,0008 | 1,5850 | 1,3553 ± 0,0007 | 1,5850 |
| V0 K=∞, σ 0,5 | 1,2698 ± 0,0011 | 1,2928 ± 0,0010 | 1,4565 ± 0,0009 | 1,2949 ± 0,0010 | 1,4679 ± 0,0008 |
| V0, σ 0,05 | 1,4376 ± 0,0007 | 1,4961 ± 0,0007 | 1,5850 | 1,4391 ± 0,0007 | 1,5850 |
| V0, σ 0,05, estimador A | 1,4305 ± 0,0052 | 1,4900 ± 0,0052 | 1,5850 | 1,4320 ± 0,0053 | 1,5850 |
| V0, σ 0,5 | 1,3719 ± 0,0010 | 1,4124 ± 0,0009 | 1,5058 ± 0,0008 | 1,3958 ± 0,0009 | 1,5210 ± 0,0007 |

El túnel residual en d = 0,27 (K finito) añade +0,084 bits a D0 con σ 0,05.

**V4, lector ancho** (máximo 2). Cada celda: I(M;Y) · I(túnel;Y) · acierto del MAP / acierto túnel.

| | D0 | +85 | −0,9 | peine | ambos |
|---|---|---|---|---|---|
| C0 0,05 | 1,1136 · 0,425 · 0,65/0,76 | 1,2219 · 0,495 · 0,71/0,79 | 1,4387 · 0,561 · 0,78/0,82 | 1,1255 · 0,429 · 0,66/0,77 | 1,4651 · 0,581 · 0,79/0,83 |
| C0 0,5 | 1,0514 · 0,406 · 0,64/0,76 | 1,0885 · 0,426 · 0,66/0,77 | 1,2254 · 0,470 · 0,71/0,78 | 1,0676 · 0,413 · 0,64/0,76 | 1,2577 · 0,493 · 0,73/0,80 |
| C1 | 1,0749 · 0,411 · 0,65/0,77 | 1,3496 · 0,570 · 0,76/0,83 | 1,4413 · 0,564 · 0,78/0,82 | 1,0985 · 0,419 · 0,66/0,77 | 1,4876 · 0,602 · 0,80/0,84 |
| C2 | 1,0749 · 0,411 | 1,2886 · 0,540 · 0,74/0,82 | 1,4413 · 0,564 | 1,0985 · 0,419 | 1,4748 · 0,592 · 0,80/0,83 |

- Errores típicos: I(M;Y) ±0,0007–0,0010; I(túnel;Y) ±0,0005–0,0007.
- En C2 los diseños sin medida a 85 °C dan lo mismo que en C1, como debe ser.
- Confusión en V4 C1, −0,9 V: T → T 0,98; R → R 0,85 / M 0,14; M → T 0,12 / R 0,57 / M 0,31; G → G 1,00.

**V4, lector XC26**:

| | D0 | +85 | −0,9 | peine | ambos |
|---|---|---|---|---|---|
| C0 0,05 | 1,2626 · 0,763 · 0,70/0,93 | 1,3408 · 0,841 · 0,73/0,96 | 1,3305 · 0,799 · 0,72/0,94 | 1,2626 · 0,763 | 1,4056 · 0,874 · 0,75/0,97 |
| C0 0,5 | 1,2183 · 0,718 | 1,2657 · 0,765 | 1,2831 · 0,750 | 1,2183 · 0,718 | 1,3274 · 0,795 |
| C1 | 1,2184 · 0,718 · 0,69/0,92 | 1,3134 · 0,813 · 0,72/0,95 | 1,3018 · 0,765 · 0,72/0,93 | 1,2184 · 0,718 | 1,3938 · 0,856 · 0,75/0,96 |
| C2 | 1,2184 | 1,3130 · 0,813 | 1,3018 | 1,2184 | 1,3934 · 0,856 |

- Errores típicos ±0,0008–0,0010.
- Con XC26, T y M no se separan: T → T 0,24–0,55, el resto a M. R sí se separa: R → R 0,88–1,00.
- Control de atribución: V0 K = ∞ con XC26 da 0,9186 / 0,9581 (la ronda 1). V0 con K finito y XC26 da, con σ 0,05, D0 1,3719,
  +85 1,4512 y −0,9 1,4444. El salto viene **entero** de K finito.

**Variantes intermedias, lector ancho** (fuera del mínimo; no comprobadas contra A):

| | D0 | +85 | −0,9 | peine | ambos |
|---|---|---|---|---|---|
| V1 C0 0,05 (máx. 2) | 1,3696 · túnel 0,507 | 1,4222 · 0,527 | 1,5510 · 0,557 | 1,3712 | 1,5559 · 0,562 |
| V1 C1 | 1,3139 · 0,491 | 1,4762 · 0,552 | 1,5593 · 0,567 | 1,3156 | 1,5643 · 0,572 |
| V2 C0 0,05 | 1,4376 | 1,4961 | 1,5674 | 1,4391 | 1,5772 |
| V2 C1 | 1,4029 | 1,5665 | 1,5666 | 1,4052 | 1,5819 |
| V3 C0 0,05 | 1,4302 | 1,4703 | 1,5849 | 1,4486 | 1,5849 |
| V3 C1 | 1,3821 | 1,5059 | 1,5826 | 1,4090 | 1,5831 |

**Exploratorio, fuera del PREREG.** Lector «mixto»: d = 0,27 con XC26, d = 0 y peine con el ancho. V4 C1:
- I(M;Y): D0 1,5330, +85 1,6815, −0,9 1,6936, peine 1,5502, ambos 1,7707.
- I(túnel;Y): 0,794 / 0,883 / 0,811 / 0,801 / 0,884.
- Es mejor que cualquier medida añadida con un solo lector.

**Diferencias pareadas** (B; `ver2_B_*.txt` líneas DIF y `ver2_pares.txt`):

| | V4 C0 0,05 | V4 C0 0,5 | V4 C1 | V4 C2 |
|---|---|---|---|---|
| Δ = I(−0,9) − I(+85), ancho | +0,2168 ± 0,0011 | +0,1369 ± 0,0010 | **+0,0917 ± 0,0010** | +0,1527 ± 0,0011 |
| Δ, XC26 | −0,0103 ± 0,0009 | +0,0174 ± 0,0008 | −0,0116 ± 0,0010 | −0,0112 ± 0,0010 |
| peine − D0, ancho | +0,0119 ± 0,0003 | +0,0161 ± 0,0004 | +0,0235 ± 0,0004 | +0,0235 ± 0,0004 |
| peine − D0, XC26 | 0,0000 | 0,0000 | 0,0000 | 0,0000 |
| ancho − XC26 en −0,9 (D3) | +0,1083 ± 0,0012 | **−0,0577 ± 0,0014** | +0,1395 ± 0,0013 | +0,1395 ± 0,0013 |
| +85 − D0, ancho | +0,1083 ± 0,0007 | +0,0371 ± 0,0005 | +0,2746 ± 0,0009 | +0,2137 ± 0,0009 |

- Δ en las otras variantes, con el ancho:
  - V0: σ 0,05 +0,0888; σ 0,5 +0,0933.
  - V0 K = ∞: +0,1402 y +0,1638.
  - V1: C0 0,05 +0,1288; C1 +0,0830.
  - V2: C0 0,05 +0,0712; **C1 +0,0001 ± 0,0005**.
  - V3: C0 0,05 +0,1146; C1 +0,0767.
- +85 − D0 en C1: V1 +0,1623, V2 +0,1635, V3 +0,1238, V4 +0,2746.
- C1 − C2 (ancho): +85 +0,0609 ± 0,0006; −0,9 0,0000.

## 4. Decisiones en V4 (lector ancho salvo que diga otra cosa)

- **D1.** Δ > 0 en las cuatro calibraciones con el ancho: **se mantiene**.
  - En C1, Δ = +0,0917 ± 0,0010 (estadístico), con sesgo acotado en ±0,003 por la comparación A–B. Con A sola (M 2¹⁷), Δ = +0,0996
    ± 0,0099.
  - **Con el lector XC26, D1 se invierte** en C0 0,05, C1 y C2 (Δ ≈ −0,011 ± 0,001, a más de 10σ). En C1 la confirma A
    (A − B ≈ 0,0002 en los dos diseños).
  - Es un efecto real pero pequeño: 0,01 bits.
  - Con el criterio sin parear y los 600 chips externos del autor (σΔ ≈ 0,016), sería «empate».
- **D2.** El peine suma 0,012–0,024 bits con el ancho y 0 con XC26: **se mantiene** (< 0,05).
- **D3.** Se mantiene en C0 0,05, C1 y C2 (+0,108; +0,140; +0,140). **Se invierte en C0 σ 0,5**: XC26 supera al ancho por 0,058 ±
  0,001 bits en −0,9 V; A lo confirma.
  - Causa: con ruido independiente de 0,5 décadas, el ancho pierde la forma.
  - XC26 conserva la firma del túnel en d = 0,27 (t0/K frente a G ≤ 2 pA), que sobrevive a ese ruido.
  - En V0 con σ 0,5 no se invierte (1,506 frente a 1,391). Lo invierten M, R no lineal y el excitador juntos.
- **D4 en V4 C1** (ancho):

| | D0 | +85 | −0,9 | peine | ambos |
|---|---|---|---|---|---|
| I(túnel;Y) | 0,411 | 0,570 | 0,564 | 0,419 | 0,602 |
| acierto | 0,767 | 0,827 | 0,819 | 0,769 | 0,836 |

  - Errores: I(túnel;Y) ±0,0006; acierto ±0,002.
  - Con XC26: 0,718 / 0,813 / 0,765 / 0,718 / 0,856, acierto 0,92–0,96.
  - Con el lector mixto: 0,79–0,88.
  - **Para la pregunta «¿hay túnel?», el lector de XC-26 en d = 0,27 vale más que el ancho.**

## 5. Predicciones 0–7

| # | Predicción | Mis números | Veredicto |
|---|---|---|---|
| 0 | V0 K=∞ reproduce la ronda 1 (3 errores típicos + 0,02) | σ 0,05: 1,354 / 1,445 / 1,585 / 1,355 / 1,585 frente a 1,362 / 1,443 / 1,585 / 1,359 / 1,585. σ 0,5: 1,270 / 1,293 / 1,457 / 1,295 / 1,468 frente a 1,280 / 1,303 / 1,468 / 1,307 / 1,479 | **Se cumple** en mi código (diferencias −0,012 a +0,002) y en el del autor (§7) |
| 1 | V1 C0 0,05: −0,9 V entre 1,5 y 1,85 | 1,551 | se cumple |
| 1 | I(túnel;Y) ≥ 0,75 | 0,557 | **falla** |
| 1 | M con puente dominante se lee como R; M con túnel dominante, como T | M → R 0,75; M → T 0,00 (el túnel domina M en < 1 % de los chips de V1) | se cumple la primera; la segunda casi no ocurre |
| 1 | D1 se mantiene | +0,129 | se cumple |
| 2 | V2: −0,9 V baja ≥ 0,05 frente a 1,585 | 1,567 (baja 0,018) | **falla** |
| 2 | D1 se mantiene | +0,071 | se cumple |
| 3 | V3: cambio ≤ 0,1 en −0,9 V | 1,5849 frente a 1,5850 | se cumple |
| 4 | C1: +85 °C suma ≥ 0,15 | V1 0,162 · V2 0,164 · **V3 0,124** · V4 0,275 | **falla en V3** |
| 4 | C1: \|Δ\| < 0,1, sin inversión | V1 0,083 · V2 0,000 (**empate**) · V3 0,077 · V4 0,092 | se cumple |
| 5 | C2: +85 °C pierde ≥ 0,03; −0,9 V ≤ 0,01 | −0,061 ± 0,001; 0,000 | se cumple |
| 6 | V4: D1 no se invierte en ninguna calibración | ancho: nunca. XC26: se invierte en C0 0,05, C1 y C2 (−0,01) | se cumple con el ancho; falla si D1 incluye XC26 |
| 6 | D3 se mantiene en todas | se invierte en C0 0,5 (−0,058) | **falla** |
| 6 | D2 se mantiene | 0,012–0,024 | se cumple |
| 7 | V4 XC26: todos los diseños entre 0,81 y 1,0 | 1,218–1,406 | **falla** |
| 7 | I(túnel;Y) ≤ 0,3 | 0,72–0,87 | **falla** |

## 6. Defectos en el modelo o en las reglas del PREREG

1. **La predicción 7 es falsa por construcción del propio modelo nuevo.**
   - Con K finito, el túnel en d = 0,27 vale t0/K, entre 1,2·10⁻¹⁴ y 7,1·10⁻⁸ A.
   - El 94 % del prior está sobre el piso de XC26 (150 fA) y el 75 % sobre el máximo de G (2 pA) (`ver2_fracciones.txt`).
   - XC26 lee el túnel en d = 0,27, y R (que en d = 0,27 es solo G) no puede imitarlo.
   - El 0,811 suponía que d = 0,27 no lleva túnel, que era el K = ∞ de la ronda 1. Lo que cambia el lector es el V0, no V4.
   - La conclusión de la ronda 1 «el lector de XC-26 no sirve» dependía de K = ∞, el punto 3 que ya señaló el verificador de la
     ronda 1.
2. **«Túnel = {T, M}» mezcla «hay túnel» con «el túnel importa».**
   - Con priors log-uniformes independientes, en M el túnel es < 10 % de la corriente de d = 0 en el 65 % de los chips (V4) y en el
     85 % (V1). Es < 1 % en el 48 % y el 68 %.
   - Por eso M se confunde sobre todo con R. I(M;Y) no puede acercarse a 2 bits e I(túnel;Y) queda en ~0,4–0,6 con el ancho.
   - Es una propiedad del prior de M, no del instrumento. Las cifras de V1 y V4 dependen de esa definición.
   - Propuesta: un prior de M con la fracción de túnel explícita, o una pregunta condicionada a que el túnel sea más del x % de la
     corriente.
3. **La regla de D1 es de significación, no de tamaño.**
   - «Δ > 2σΔ» con σΔ = error de Monte Carlo: con más muestras, cualquier Δ > 0 «mantiene» D1, y cualquier Δ < 0 la «invierte».
   - Con XC26, Δ = −0,010 es «inversión» con mi error pareado (±0,001) y «empate» con el del autor sin parear (±0,016).
   - La misma decisión cambia de categoría según el estimador y el número de muestras. Falta un umbral de efecto (p. ej.,
     |Δ| ≥ 0,05 bits para declarar algo) y decir si el error es pareado.
4. **Excitador: firmas que fabrica el instrumento.**
   - Con el límite Imax, el 21 % de los chips R de V4 lee exactamente Imax a −1,8 V y a −0,9 V (forma 1).
   - En el régimen limitado por Rs, cualquier mecanismo de corriente alta da forma ≈ 2, la del óhmico.
   - Con Rs > 1,8 kΩ el techo de 1 mA del ancho no se alcanza nunca.
   - En V3 no pesa (−0,9 V queda en 1,585). En V4 contribuye a la confusión R–M.
   - Rs e Imax son `[?]` (los pines analógicos de TT no se han leído) y deciden parte de los números de V4.
5. **σδ = 0,03 (C2) decide la predicción 5 y el margen de D1 en C2.**
   - El cociente 85/27 °C va de +0,027 a +0,092 décadas para T y de −0,048 a −0,091 para R. El hueco es de 0,075 décadas, solo 2,5 σδ.
   - Con otro σδ el resultado de C2 cambia en proporción. Es un supuesto sin fuente.
6. **Censura sobre la lectura y no sobre la corriente.**
   - Es ambiguo físicamente: depende de si el lector satura antes o después de su ganancia.
   - Con σg = 0,5 la elección mueve el umbral efectivo media década. No lo exploré `[?]`.
7. **El veredicto «muere el motor» de §Qué mata cada cosa no se puede aplicar como está escrito.**
   - Con el ancho, V4 da el mismo orden que V0 (−0,9 V primero) y las mismas D1 y D2 en todas las calibraciones.
   - Pero D3 cambia (C0 0,5) y D1 se invierte con XC26.
   - El cambio de mayor tamaño (XC26 deja de ser inútil y gana a la medida extra en la pregunta del túnel) se deduce de los
     intervalos (t0/K frente al piso) y ya estaba en V0. No hace falta V4 para verlo.
   - Lo que no se deduce a mano son los tamaños: que C1 lleve la ventaja de −0,9 V a 0,09, y el empate exacto de V2 C1.
8. **Fuera del modelo, pero decisivo** (exploratorio, no prerregistrado): el lector mixto da 1,53–1,77 bits en V4 C1, más que
   cualquier diseño con un solo lector. La decisión de lector importa más que la de la medida extra, como en la ronda 1, pero ahora
   en sentido contrario: XC26 en d = 0,27.

## 7. Comparación con el autor (escrita después de leer, 17:40:48–17:41:44)

`../motor2_salida.txt`: 600 lecturas por mecanismo y 40 000 chips internos, una sola semilla común a todos los diseños. Leí 75
filas; la corrida seguía.

- **Predicción 0 en el código del autor:** V0inf da 1,353 / 1,443 / 1,585 / 1,347 / 1,585 con σ 0,05 y 1,266 / 1,278 / 1,457 /
  1,294 / 1,469 con σ 0,5. Todas a ≤ 0,025 de `resultados.txt`, dentro de la tolerancia (3 errores típicos + 0,02). **Se cumple.**
  Coincide con mi V0 K = ∞ a ≤ 0,015.
- V0, V1, V2, V3, V4 C0 0,05 y V4 XC26 C0 0,05: coinciden con los míos dentro de 1–1,6 errores típicos del autor (±0,004–0,016).
- **Discrepancias marginales**, siempre con el autor por debajo:
  - V4 C1 D0: 1,043 ± 0,014 frente a 1,0749 ± 0,0009 (−0,032; 2,3σ).
  - V4 C0 0,5: las cinco filas entre 0,012 y 0,031 por debajo (peine −0,031; 2,4σ).
  - V4 C1 XC26 −0,9 V: 1,279 frente a 1,3018 (−0,023; 1,8σ).
  - Con una sola semilla exterior común a todos los diseños, los errores de una configuración están correlacionados: un
    desplazamiento común de las cinco filas puede ser una sola fluctuación.
  - Prueba de que es ruido: el autor da 1,043 en V4 C1 D0 y 1,059 en V4 C2 D0, que en el modelo son la misma cantidad (D0 no lleva
    lecturas a 85 °C). Mi B da 1,0749 en las dos.
  - Recomendación: ≥ 3000 lecturas exteriores por mecanismo y semillas distintas por diseño, o diferencias pareadas explícitas. Con
    ±0,012–0,016 no se resuelven efectos de 0,01 como la inversión de D1 con XC26.
- D1 en V4 C1 (autor): 1,453 − 1,349 = +0,104 (σΔ sin parear ≈ 0,016). Frente a mi +0,0917 ± 0,0010: coinciden.
- **Corridas que faltan en el autor:**
  - `CORRIDAS` no incluye V4 XC26 en C0 0,5 ni en C2. La predicción 6 («D3 en todas») no se puede juzgar con sus corridas.
  - La inversión de D3 está justamente en C0 0,5.
  - Tampoco corre V4 C0 0,5 con XC26 para D1.
- **Lectura de `motor2.py`:**
  - El modelo coincide con el mío en todas las elecciones de §1: censura sobre y, min(I, Imax) tras la bisección, túnel en
    d = 0,27 con dependencia en V y T, peine ×4 en T y R, δ en las lecturas a 85 °C.
  - El autor cambió la cuadratura de Gauss-Hermite prerregistrada por integración analítica de la latente (lo dice su docstring).
    Es razonable, pero es un cambio de método respecto al PREREG.
  - Censuradas: de varias del mismo tipo y grupo toma solo «la más restrictiva». Entre grupos distintos (bajo piso y saturado a la
    vez) multiplica marginales e ignora la correlación por g. Pesa cuando no hay ninguna lectura legible, porque entonces la
    marginal de g es el prior (σ 0,5) y no una posterior estrecha.
  - Ese patrón (d = 0 saturado y d = 0,27 bajo piso, sin legibles) es común con XC26, pero los márgenes suelen ser grandes. Mis
    números con la rejilla exacta coinciden con los suyos en XC26 C1 D0 y +85 (1,218 frente a 1,229; 1,313 frente a 1,315). No
    veo un efecto medible.
  - El error del autor (`err`) usa `std()` con ddof = 0; con 600 muestras es despreciable.

## 8. Archivos (todos en esta carpeta)

- **Código:**
  - `ver2_modelo.py`: modelo generativo.
  - `ver2_clasif.py`: estimador B.
  - `ver2_qmc.py`: estimador A.
  - `ver2_cmp.py`: A − B muestra a muestra.
  - `ver2_pares.py`: pares entre corridas.
  - `ver2_fracciones.py`: fracciones del prior.
  - `ver2_lanzar_B.sh` y `ver2_lanzar_B2.sh`: lanzadores.
- **Salidas:**
  - `ver2_B_*.txt` y `ver2_A_*.txt`: corridas.
  - `ver2_cmp_*.txt`, `ver2_pares.txt` y `ver2_fracciones.txt`.
  - `ver2_NUMEROS.txt`: el compendio fijado con su `date`.
  - `ver2_lt_*.npz` y `ver2_A_lt_*.npz`: log2 q por muestra.
- **Incidencia:** el primer lanzamiento de `ver2_lanzar_B.sh` (17:13:39) falló porque `$P` no estaba exportado. Dejó archivos
  `ver2_B_*.txt` con «command not found», que se sobrescribieron con las corridas buenas a partir de las 17:13:48
  (`ver2_lanzar_B_salida.txt` es el registro del fallo; `ver2_lanzar_B_salida2.txt`, el de la buena). Las pruebas cortas de
  arranque sobrescribieron también algún `ver2_lt_V0Kinf_*.npz`, regenerado por la corrida completa.
- Python: `.venv` de ZTASIC (numpy 2.5, scipy 1.18). Las corridas de B tardan 3–4 min cada una; las de A, de 1 a 15 min.
