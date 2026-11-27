# MISFIT-26 · etapa B: el bloque colocado del lector 2, extraído, con la parte analógica y la matriz

Escrito el 2026-11-27 (hora de sellado en `experiments/misfit26/PREREG_SHA256.txt`), **antes** de la tanda. Pedido por
Juan ("haz lo que sigue", tras la lista de lo que falta del chip). Es la etapa B que dejó abierta
[MISFIT-25](MISFIT-25_2026-11-27_lector2_sintesis_y_colocacion.md).

## Pregunta

¿El bloque digital colocado (`experiments/misfit25/bloque`, 93 celdas: lazo, contador de 13 biestables y salidas `xa`,
`xb`) lee como el lazo de esquemático de MISFIT-24 cuando se simula extraído de su GDS, con `reader2fe` extraída y la
matriz `xc20w`? Y si no lee igual, ¿sigue calibrando y contando bien?

## Lo que ya vi antes de sellar (humo; no es predicción a ciegas)

Para probar el banco corrí cuatro decks **fuera de la lista**, a tt 27 (`experiments/misfit26/humo/`): 20 nA en rango
bajo y 2 µA en rango alto, bloque extraído y control. Una primera tanda de humo quedó muda por un fallo mío (caso sin
fuente de corriente); está en `humo/fallido_sin_fuente/`.

- Control (netlist final + celdas de la librería): periodo 2,561 µs y 94,30 ns; el ajuste de MISFIT-24 da 2,555 µs y 93,84 ns (+0,2 y +0,5 %).
- Extraído: 4,222 µs y 100,17 ns: **+64,9 % en rango bajo y +6,2 % en rango alto**.
- Causa más aburrida, comprobada en el archivo: `sky130_fd_sc_hd.spice` de la librería no tiene **ningún** condensador
  ni áreas de difusión (0 líneas `C`; los transistores solo llevan `w` y `l`). Todo lo simulado hasta hoy con celdas de
  librería (MISFIT-17 a 24 y la noche del 26) llevaba el retardo de la cadena sin parásitos. En rango bajo la carga por
  ciclo la fija la anchura del pulso de precarga, que es ese retardo.
- `xa` y `xb` subieron donde tocaba en el deck de rango bajo.

Por eso B3 no cuenta como predicción a ciegas a tt 27; en las otras esquinas sí.

## Qué se corre (`experiments/misfit26/gen26.py`, 91 decks)

Los decks de MISFIT-24 con las 17 celdas del lazo cambiadas por el bloque entero, en línea. `en` sube tras un reposo
(el contador necesita su puesta a cero), `pre` = 0, `src` = 1 en rango bajo (`xa` a los 4 flancos, `xb` a los 16) y 2
en rango alto (256 y 4096). El cerrojo arranca con `.ic` (q = 0, qb = 1,8 V): el arranque desde el punto metaestable
es otro riesgo abierto y **no** se prueba aquí.

| Grupo | Nivel | Decks | Qué es |
|---|---|---|---|
| `d` | `m`: extracción plana de Magic del GDS, todos los condensadores (1262 transistores, 3630 C) | 48 | 4 esquinas × 2 rangos × (3 de calibración + 3 fuera de muestra) |
| `ctl` (control) | `n`: netlist final del flujo + celdas de la librería, sin cables | 24 | tt 27 y ss 85, los mismos 6 puntos por rango |
| `w20` (testigo) | `m` + 20 fF en el nodo | 3 | rango alto, tt 27, calibración |
| `dev` (reparto) | `v`: la misma extracción sin condensadores (solo difusiones) | 6 | tt 27, calibración, dos rangos |
| `zero` | `m`, sin corriente | 2 | ff 85, 20 ms, dos rangos |
| `largo` | `m`, rango alto, 10 µA, hasta pasar los 256 flancos | 2 | tt 27 y ss 85 |
| `libre` (mutante) | extracción del bloque `libre` de MISFIT-25 (búferes en `x`, `prenh`, `prenl` y dentro del lazo) | 6 | tt 27, calibración, dos rangos |

Periodo = media de los diez intervalos entre los flancos 2 y 12 de `q`. Modelo y ajuste de MISFIT-24:
T = Q/(I − I_L) + t_d con las tres corrientes de calibración.

## Explicaciones aburridas y su chequeo

| Explicación | Chequeo |
|---|---|
| El banco nuevo (bloque en línea, `en` con escalón, `.ic`) cambia el resultado por sí solo | Control `ctl`: debe dar la Q de MISFIT-24 dentro de ±5 % |
| El cambio es de las difusiones de las celdas y no de los cables | Grupo `dev`: reparto del cambio entre difusiones y condensadores |
| La extracción no ve la capacidad del nodo | Testigo `w20`: +20 fF en el nodo deben subir la Q del rango alto (noche del 26: +9 a +10 % en esquemático) |
| El paso de simulación | El de MISFIT-17/24 sin tocar (la enmienda 1 de MISFIT-17 no vio cambio con paso fino) |
| Magic cuenta mal la capacidad del nodo | Cotejo ya hecho: red `x`, 1,65 fF en Magic y 1,24 fF en el SPEF de OpenRCX |

## Predicciones

| # | Predicción |
|---|---|
| B1 | Los 48 decks de `d` oscilan: 18 flancos y salida 0 |
| B2 | Las 24 lecturas fuera de muestra quedan dentro de ±3 % con la calibración del propio bloque extraído |
| B3 | Q frente a MISFIT-24, las 8 combinaciones: rango bajo entre +30 y +100 %; rango alto entre +2 y +15 % |
| B4 | Contador, los 24 decks de rango bajo: `xa` sube entre los flancos 4 y 5, `xb` entre 16 y 17, y (t_xb − t_xa) = e16 − e4 dentro de 0,1 % |
| B5 | Reposo, los 48: antes de `en`, q ≤ 0,2 V y nodo ≥ 1,7 V; el primer flanco llega después de `en` |
| B6 | Sin corriente a ff 85: ningún flanco en 20 ms, en los dos rangos |
| B7 | Contador a ritmo máximo (10 µA, rango alto, tt 27 y ss 85): `xa` sube entre los flancos 256 y 257 |
| B8 (mutante, confianza baja) | El bloque `libre` **oscila** en los 6 decks y su Q difiere más de 2 % de la del bloque protegido en algún rango |

B8 pone a prueba una frase mía de MISFIT-25 ("sin protección el flujo rompe el lector"). Si se cumple, la frase se
corrige a "lo cambia sin avisar"; si no oscila, la frase se queda.

## Reglas

- **Sigue si** B1, B2, B4, B5, B6 y B7 se cumplen: el bloque colocado queda aceptado en función y se pasa al ensamblado
  con `reader2fe`. La Q nueva (B3) sustituye a la de MISFIT-24 como referencia.
- **Se rehace el bloque si** falla B4 o B7 (el contador cuenta mal con las pendientes sin reparar) o B1.
- **Si falla B2**, el modelo de tres puntos no vale con el pulso real: se reporta el error y no se ensambla hasta entenderlo.
- **Tanda inválida si:** algún deck no acaba en `salida 0`; el control se sale de ±5 % de MISFIT-24; o el testigo de
  +20 fF sube la Q menos de +4 %.
- Tope: 7200 s por deck dentro del contenedor (`corre.sh`), cuatro a la vez.

## Incertidumbre, separada

- **Epistémica:** la extracción es de Magic, solo capacidades (sin resistencia de cables); un solo extractor para el
  interior de las celdas. El cotejo con el SPEF cubre solo los cables entre celdas.
- **De cálculo:** una corrida por punto; `xb` a 4096 flancos no se simula (solo hasta 256); `src` = 3 no se simula.
- **Sin atribuir:** cuánto del +65 % es real en silicio. Depende de la exactitud de las difusiones y capacidades
  internas de las celdas, que aquí no tienen segundo instrumento.

## Qué no decide

Ni el arranque del cerrojo sin `.ic`, ni la sensibilidad a la alimentación, ni el ensamblado. Tampoco revisa los
resultados anteriores: si B3 se cumple, queda anotado que las Q y los retardos de MISFIT-17 a 24 y de la noche del 26
son de celdas sin parásitos, y qué conclusiones dependen de eso se revisa aparte.
