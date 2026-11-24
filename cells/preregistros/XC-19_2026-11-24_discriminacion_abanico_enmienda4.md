# XC-19 · simulador de discriminación · enmienda 4

Escrita el 2026-11-24 desde las 09:49:51 EST (`date`), después de
[`experiments/xc19_discrim/RESULTADOS.md`](../../experiments/xc19_discrim/RESULTADOS.md), donde el benchmark salió inválido. Cita
el original y las enmiendas 1–3; los SHA-256 están en `experiments/xc19_discrim/PREREG_SHA256.txt`. No edita ninguno de ellos.
**La corrida del 2026-11-23 queda como exploración.**

## 0. Lo visto antes de escribir esto (exploración)

**Por qué falló T2 en E_A.**
- Diagnóstico a tt, A1, 16 patas, 40 chips por f, semilla 99:

  | | f = 1 | f = 10 |
  |---|---|---|
  | Patas detectadas | 6,42 | 4,62 |
  | Patas con ≥ 1 trampa en banda | 4,85 | 15,55 |

- Las detecciones **bajan** cuando hay más trampas. El detector de dos niveles (E_A v2) pierde la suma de varios telegramas, y el
  número de patas detectadas no es monótono en f. Por eso, **contar patas, con o sin Poisson, no es el arreglo** que proponía
  RESULTADOS §4.1.

**Prototipo de detector de saltos.**
- Diferencia de medias de w = 5 conversiones antes y después de cada punto. Salto si supera la mitad de la unidad de la esquina,
  con supresión de no máximos en 2w.
- A tt, A1, 16 patas, 30 chips por f, semilla 7, el número de saltos por chip es monótono en f:

  | | amplitudes ×0 | f = 1 | f = 3 | f = 10 |
  |---|---|---|---|---|
  | Saltos por chip (media ± sd) | 0,4 ± 0,7 | 308 ± 102 | 486 ± 57 | 820 ± 46 |

- Esto ya se vio. No es veredicto.

## 1. Cambios

| # | Qué | Por qué |
|---|---|---|
| A4.1 | **E_A v3, detector de saltos.** Para cada fila y: d[i] = media(y[i..i+w)) − media(y[i−w..i)), con w = 5. Hay un salto donde abs(d) > 0,5·u_c, con u_c = s_c·t_c·50 MHz (la unidad de la esquina, en cuentas), y con supresión de no máximos en 2w. J = número de saltos de la fila | monótono en f (§0); el de dos niveles no lo es |
| A4.2 | **D1 con E_A v3:** un dispositivo está "detectado" si J ≥ 2 (al menos una ida y vuelta) | un salto solo puede ser una trampa lenta que cambia una vez; también cuenta |
| A4.3 | **D2 con E_A v3:** por chip, Z = (log(1 + J_0), log(1 + J_k)), con J_0 = saltos sumados en las 16 patas C0 y J_k = saltos sumados en las R patas de la clase. Regresión logística (L2 = 1) entrenada en chips de entrenamiento y evaluada en chips de prueba con otra semilla. Bits = I(H; Ĥ) de la matriz de confusión de prueba, igual que antes | estadístico de chip monótono, con λ0 desconocido estimado desde C0 |
| A4.4 | **E_B v2 con rasgos con signo.** Los escribe un agente nuevo e independiente, con el prerregistro, estas enmiendas, `sim.py` y `e_b.py`, **sin** `run_ea*.py` ni esta sección §0. Rasgos añadidos: asimetría (tercer momento) de y y de sus diferencias de primer orden, y el número de saltos positivos y negativos por separado con el detector que él elija | RESULTADOS §2.2: los rasgos sin signo no separan una trampa de A de una de B |
| A4.5 | **Variante BR:** B es la descarga de referencia 2 × 6 de MISFIT-03 (12 dispositivos C0 en paralelo de a dos en serie), modelada como un dispositivo de área A = 12. Densidad ×12 y amplitud media ÷12: con η = 1, el salto de B a tt es ~0,94 cuentas, frente a 11,3 del DUT. Se corre junto a la variante de gemelo (BT, la de hasta ahora) en D1 y D2 a tt, variante S. `sim.simulate(..., b_area=12)` | RESULTADOS §2.2 y §3: medir cuántos falsos positivos son del gemelo |
| A4.6 | **Humo con T1 y T2**, con los dos estimadores, antes de la corrida larga: 400 chips. Si T2 da < 0,80 del techo en el humo con cualquiera de los dos estimadores, **se para**. No hay más revisiones de estimador en esta sesión | hueco de método de la corrida anterior |
| A4.7 | **Semillas nuevas.** Las semillas de cada celda se derivan con `sd('e4', …)` en E_A y con la sal `"e4"` en E_B, y no coinciden con las de la corrida del 2026-11-23 | la corrida anterior es exploración |
| A4.8 | **D4, curva de potencia para C1–C6** (nuevo, no reemplaza nada): bits de D2 para f ∈ {1,5, 2, 3} frente a 1, en A1 con R = 16, tt, variante S, BT y BR. Es lo que el simulador puede decir de C1–C6 sin física por geometría: **el factor f mínimo que el slot distingue**. La física (qué f esperar de cada geometría) queda en un anexo con bibliografía verificada, cuando llegue; esa parte no decide nada aquí | `PRUEBAS_POR_BLOQUE.md`, fila "modelo de C1–C6" |

Techos de Poisson con R·A = 16, calculados ahora con `run_ea.poisson_bits` y `prereg_calc.txt`:

| Esquina | f = 1,5 | f = 2 | f = 3 | f = 10 |
|---|---|---|---|---|
| tt 27 | 0,181 | 0,477 | 0,850 | 1,000 |
| ff −40 | 0,148 | 0,407 | 0,785 | 1,000 |
| ss 85 | 0,213 | 0,539 | 0,896 | 1,000 |
| ff 85 | 0,206 | 0,525 | 0,886 | 1,000 |

## 2. Predicciones

PD1–PD5, T1, T2 y M1–M4 siguen con las palabras del original y de las enmiendas 1–3, y se evalúan con E_A v3 y E_B v2. Además:

| # | Predicción | De dónde |
|---|---|---|
| PD6 | **BR frente a BT**, D1, tt, S: la fracción de falsos positivos (dispositivos sin trampa en banda detectados) baja al menos a la mitad con BR, con los dos estimadores | §0 de RESULTADOS: B sin trampas lleva los falsos de E_B de 12 % a 0 % |
| PD7 | **D4:** la fracción del techo crece con f, en BT y en BR. Para f = 3, tt, BR: ≥ 0,60 del techo con E_A v3 | §0: los saltos medios con f = 1 y f = 3 se separan por ~1,8 sd en 30 chips; esto es una apuesta, no un cálculo |
| PD8 | **D4:** con f = 1,5, los bits son ≤ 0,10, por debajo del techo de 0,18. Es decir, el slot de R·A = 16 **no** distingue un factor 1,5 en tt | techo de Poisson + pérdida del lector |

**Mutante nuevo, M5:** E_A v3 con el umbral del detector ×100. Todo queda en 0 saltos: D1 y D2 ≤ 0,02 bits.

## 3. Criterios

- Los del original §10 no cambian, con E_A v3 y E_B v2.
- **Fila que decide:** |E_A − E_B| ≤ 0,05 bits y los dos ≤ techo + 0,02.
- **Sobre el techo:** si E_A v3 supera el techo + 0,02 en alguna fila, la fila no decide. La explicación aburrida es que las
  trampas rápidas, fuera de banda, también escalan con f, y el techo de Poisson solo cuenta las de la banda. Se dice así y no se
  redefine el techo.
- **Presupuestos:** resolución, E_A v3 y la corrida, ≤ media sesión. Auditoría, E_B v2 por agente independiente, aparte.

Estado: **congelado** al sellar su SHA-256 en `experiments/xc19_discrim/PREREG_SHA256.txt`.
