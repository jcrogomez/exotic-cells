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

## Enmienda 1 (2026-11-28, después de los veredictos de la primera pasada; el texto de arriba no se toca)

**Qué pasó.** La primera pasada dio C1 y C4 falsas por un deck (rango bajo, ff −40, 316 pA): 13 flancos y luego parado.
Los veredictos se subieron tal cual (`da96690`) y se quedan así. El diagnóstico posterior
(`experiments/misfit28/diag/diag.txt`, exploratorio) muestra que el paro es del simulador: con el paso máximo de 1 µs
de esos decks, ngspice acepta un paso entero de 1 µs sobre el disparo y cae en q = qb = 0,725 V, el equilibrio inestable
del cerrojo, sin que q haya pasado nunca de ahí; el nodo sube 32 mV en ese mismo paso. El mismo deck con paso máximo de
0,1 µs da 26 flancos completos. Es el fallo ya anotado en la memoria del proyecto (cerrojo metaestable, paso no convergido).

**Por qué no basta con anotarlo.** Un deck que pasa con otro paso, elegido después de ver el fallo, es exploración. Y la
regla de arriba ("si falla C1… no se prueba una tercera variante a ciegas") es sobre el circuito; aquí lo que falló es
el instrumento. Lo que se enmienda es el instrumento, no el circuito: mismo netlist extraído, mismo análisis sellado.

**Qué se repite.** Los 60 decks de rango bajo de la lista (`a` bajo 24, `lento` 16, `mm` 20) con paso máximo
min(el que tenían, 0,1 µs), en `e1/` (`gen28e.py`). Rango alto, `zero`, `largo`, testigos y parte física no se repiten:
se leen de la primera pasada (sus pasos ya eran de 0,4 a 3,7 ns). `analiza28e.py` ejecuta `analiza28.py` sin cambios con
el rango bajo redirigido a `e1/`.

**Control nuevo (E0), convergencia en el paso:** 316 pA en las cuatro esquinas con paso máximo 0,03 µs (`e1/fino/`).
El periodo tiene que coincidir con el de 0,1 µs dentro de 0,1 %, con 18 flancos limpios.
**Testigo del detector:** ya existe: el deck de la primera pasada, que el análisis marcó.

**Predicciones:** las mismas C1 a C11, con los mismos criterios, más E0. Confianza: alta en que el deck que falló pasa
(ya se vio, no cuenta como prueba); media en los otros 59, que no se han corrido con este paso.

**Reglas de la enmienda.**
- Se adopta el lazo v2 y la unidad si se cumplen C1 a C8, C10 y E0 con esta lectura.
- Si algún deck vuelve a quedarse parado o a dar pulsos a medias con paso de 0,1 µs, **no hay segunda enmienda de paso**:
  se da el lazo por no demostrado en simulación y se decide entre celda propia con histéresis, o un arranque que saque
  al cerrojo del equilibrio, con ondas guardadas del deck que falle.
- Si E0 es falsa, ninguna lectura de periodo de esta tanda vale como número, pasen o no las demás.
- Tope: 14400 s por deck (los de 31,6 pA tienen diez veces más pasos), cuatro a la vez. Tanda inválida si algún deck no
  acaba en `salida 0`.

**Lo que esta enmienda no arregla.** MISFIT-24 y MISFIT-26 usaron el mismo paso de 1 µs en el rango bajo. El paro de
MISFIT-26 (ff −40, 100 pA) acabó en el mismo q = qb = 0,725 V: puede ser el mismo artefacto y no un defecto del lazo sin
histéresis. Se están repitiendo los dos testigos de MISFIT-26 con paso de 0,1 µs (`diag/testigo_*_paso`, exploratorio);
lo que salga se escribe en los resultados y no cambia estas reglas.

## Enmienda 2 (2026-11-28, con la tanda de la enmienda 1 a medias; solo toca el tope de tiempo)

**Qué pasó.** El deck `e1/lento/bajo_ff-40_oos_3.1623e-11` llegó al tope de 14400 s (`salida 124`) con la simulación en
75,7 ms de 78,3 ms. El de ff 85 a la misma corriente acabó en 3 h 58 min. Los de ss 85 y tt 27 a 31,6 pA van más lentos y
también llegarán al tope. El tope lo calculé yo mal (estimé 80 min por deck); no dice nada del circuito. No he leído
ninguna medida de los decks acabados.

**Qué se hace.** Todo deck de `e1/` que acabe en `salida 124`: su log se conserva como `lec_tope14400.log` y el mismo
`lec.sp`, sin cambios, se vuelve a correr con tope de 43200 s. El análisis sellado no cambia. Si alguno llega también a
43200 s, la tanda es inválida para ese punto y se dice así; no hay tercer tope.

**Qué no cambia:** decks, paso, criterios, reglas de la enmienda 1.
