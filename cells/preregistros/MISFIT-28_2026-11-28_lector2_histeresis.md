# MISFIT-28 · lector 2 con histéresis: la unidad extraída, con la medida corregida

Escrito el 2026-11-28 (hora de sellado en `experiments/misfit28/PREREG_SHA256.txt`), **antes** de la corrida oficial del
bloque y de la tanda. Sigue a [MISFIT-26](../../experiments/misfit26/RESULTADOS.md) (el lazo sin histéresis cuenta de más
a 316 pA y se para a 100 pA) y a [MISFIT-27](../../experiments/misfit27/RESULTADOS.md) (la unidad de layout).

## Pregunta

¿Con histéresis en el comparador, la unidad del lector 2 (bloque + `reader2fe`, extraída entera de su GDS) da un pulso
limpio por ciclo en todo el rango y más abajo, cuenta bien y sigue calibrando?

## Lo que ya vi antes de sellar (exploración; no es a ciegas)

Dos variantes, cada una colocada, ensamblada, extraída y simulada en 8 puntos (`experiments/misfit28/explora/`): los
dos decks que fallaron en MISFIT-26 más 6 de calibración a tt 27.

- **Variante 1, descartada:** comparador `inv_4` con un `inv_1` de realimentación sobre su salida. Quita los pulsos a
  medias, pero la histéresis sale tan ancha (el nodo baja a 0,32 V) que en rango bajo, a tt 27, un paquete de precarga
  no la cruza y salen **dos pulsos por ciclo** (intervalos de 10 ns y 16,9 µs alternados a 10 nA).
- **Variante 2, la que se prueba aquí:** el comparador sigue siendo `inv_1`; la segunda etapa pasa a `inv_4` y un
  `inv_1` devuelve la tercera sobre la salida de la segunda. En los 8 puntos: un pulso por ciclo (intervalos dentro de
  ±0,4 % de la media), ningún pulso a medias, `xa` y `xb` en su flanco, nodo mínimo 0,68–0,78 V.

Así que C1, C2 y C4 no son a ciegas en esos 8 puntos; sí en los otros 56 decks, en el desajuste y en lo demás.

## Qué cambia en el diseño

- `instrument/reader2/reader2_loop.v`, versión 2: `u_s1` pasa de `inv_1` a `inv_4` y entra `u_k` (`inv_1`, de `s` a
  `c2`). Dos celdas empujan el nodo `c2`: es la histéresis. 18 celdas en el lazo.
- **Coste declarado:** el flujo rechaza dos conductores en un nodo; se baja esa comprobación de síntesis a aviso
  (`ERROR_ON_SYNTH_CHECKS` = 0) para todo el bloque. Se compensa comprobando que el único aviso es el de `c2` y con la
  revisión del netlist red por red (C10).

## Qué se corre

1. **Físico** (`corre_bloque.sh`): bloque con el plano de MISFIT-27, unidad, reglas y LVS, los tres mutantes de LVS,
   extracción plana con todos los condensadores.
2. **Tanda** (`gen28.py`, 90 decks sobre la unidad extraída, con la matriz `xc20w`):

| Grupo | Decks | Qué es |
|---|---|---|
| `a` | 48 | 4 esquinas × 2 rangos × (3 de calibración + 3 fuera de muestra), como MISFIT-26 |
| `lento` | 16 | rango bajo, 4 esquinas, 31,6 / 56,2 / 178 / 562 pA: dos puntos por debajo del rango (rampas más lentas) |
| `mm` | 20 | desajuste: `ff_mm` a 85 y −40 °C, 5 semillas, 100 y 316 pA (los puntos y esquinas que fallaron) |
| `zero` | 2 | sin corriente, ff 85, dos rangos |
| `largo` | 2 | 10 µA, rango alto, hasta pasar 256 flancos; tt 27 y ss 85 |
| `testigo` | 2 | los dos decks de MISFIT-26 que fallaron (bloque **sin** histéresis), con la medida nueva |

**Medida corregida:** tiempos impresos con 12 cifras; cada flanco de `q` medido a 0,3, 0,9 y 1,5 V. "Pulso a medias" =
las tres cuentas difieren o un mismo flanco tarda más de 20 ns entre 0,3 y 1,5 V. Contador: `xa` y `xb` entre −1 y
+20 ns de los flancos 4 y 16 (tope absoluto, que admite el retardo del rizado; el −1 ns es la resolución).

## Explicaciones aburridas y su chequeo

| Explicación | Chequeo |
|---|---|
| La medida nueva no ve el fallo y por eso todo sale bien | Testigos: los dos decks de MISFIT-26 deben salir marcados (C8) |
| Sale bien en una colocación y una muestra | Grupo `mm`: 10 chips con desajuste en las esquinas del fallo |
| El fallo solo se movió a corrientes más bajas | Grupo `lento`: hasta 31,6 pA, tres veces por debajo del rango |
| La histéresis hace pulsos dobles en alguna esquina (variante 1) | C2: cada intervalo dentro de ±3 % de la media |
| El cambio rompió algo del cierre físico | C10, con los mismos mutantes de MISFIT-27 |

## Predicciones

| # | Predicción |
|---|---|
| C1 | Los 64 decks de `a` y `lento`: 18 flancos a las tres alturas y ningún pulso a medias |
| C2 | Los 64: cada uno de los diez intervalos dentro de ±3 % de su media |
| C3 | Las 24 lecturas fuera de muestra dentro de ±3 % con su propia calibración |
| C4 | Contador, los 40 decks de rango bajo: `xa` y `xb` en su flanco (−1 a +20 ns) |
| C5 | Desajuste, 20 de 20: sanos, regulares y con la cuenta bien |
| C6 | Sin corriente a ff 85: ningún flanco |
| C7 | A ritmo máximo `xa` sube tras el flanco 256, a tt 27 y ss 85 |
| C8 (testigo) | La medida nueva marca los dos decks de MISFIT-26 |
| C9 | Q dentro de ±10 % de la del bloque extraído de MISFIT-26, las 8 combinaciones |
| C10 | Bloque limpio, lazo intacto (18 celdas) y sin búferes; unidad con 0 violaciones y LVS coincidente; tres mutantes distintos; doble conductor solo en `c2` |
| C11 | Reposo: q ≤ 0,2 V antes de `en` en los 64 |

Confianza baja en C5 (nunca se ha probado desajuste con parásitos) y en el extremo de 31,6 pA de C1.

## Reglas

- **Se adopta** el lazo v2 y esta unidad como lector 2 si se cumplen C1 a C8 y C10.
- **Si falla C1, C2, C4 o C5**, la histéresis de celdas de librería no basta: no se prueba una tercera variante a
  ciegas; se escribe qué falla y se decide entre una celda propia con histéresis o limitar el rango por abajo.
- **Tanda inválida si** algún deck no acaba en `salida 0` o algún testigo no sale marcado.
- Tope: 7200 s por deck, cuatro a la vez. 20 min para el flujo.

## Incertidumbre, separada

- **Epistémica:** simulación sin ruido; extracción de Magic solo de capacidades; anchura de la histéresis no medida
  directamente (se reporta el mínimo del nodo).
- **De cálculo:** una colocación; 10 chips de desajuste; `xb` a 4096 y `src` = 3 sin simular.
- **Sin atribuir:** cuánto se parece el silicio a estas capacidades internas de celda.

## Qué no decide

El arranque del cerrojo sin `.ic`, la sensibilidad a la alimentación con parásitos, la unión con la matriz.
