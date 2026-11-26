# MISFIT-17 · enmienda 1 · el caso inválido (rango bajo, ff −40) con paso diez veces más fino

Escrita el 2026-11-26 (hora de sellado en `experiments/misfit17/PREREG_SHA256.txt`), **después** de la tanda de 88 decks y de
cinco decks de diagnóstico (`experiments/misfit17/diag/`, exploratorios), y **antes** de la segunda tanda.

## Qué pasó (se queda como está)

`experiments/misfit17/m17.txt`: R1 24 de 24, R5 cumplida; R2, R3, R4 y R6 falsas. El testigo del rango bajo a ff −40 dio
−1,383 % (banda −1,2 a −0,8), así que por la regla escrita ese (rango, esquina) es **inválido**.

Diagnóstico (mismos decks, imprimiendo los 12 flancos y la excursión del nodo): en el rango bajo los diez periodos de una
misma corrida se dispersan 0,3–0,5 % (desviación típica / media: 0,44 % y 0,47 % en los dos decks de ff −40 a 3 nA, 0,34 %
a tt 27 sin matriz); en el rango alto, 0,04 %. No hay ruido en el deck: la dispersión es numérica. Con diez periodos por
lectura, la diferencia entre dos lecturas tiene una incertidumbre de unos 0,2 %, y el testigo se desvió 0,38 %.

**Mi error:** el paso máximo del rango bajo quedó en 1 µs, con un pulso de precarga de pocos nanosegundos. La lección de que
el paso máximo hay que comprobarlo ya estaba escrita (corridas del lector, 2026-11-25) y no la apliqué.

## Prueba nueva

Los 12 decks del rango bajo a ff −40, idénticos salvo el paso máximo, **diez veces menor** (100 ns donde era 1 µs), y con
los 12 flancos impresos. Tope 10 800 s por deck (el de 100 pA simula 73 ms). Script `e1.py` (genera y analiza), `corre_e1.sh`.

| # | Predicción |
|---|---|
| E1 | La dispersión entre los diez periodos del deck de 3,16 nA baja de 0,44 % a menos de 0,16 % |
| E2 (testigo) | +1 % de corriente da entre −1,2 y −0,8 % de periodo |
| E3 | Las tres corrientes fuera de muestra se leen dentro de ±3 % |
| E4 | El periodo con matriz / sin matriz sigue entre 0,98 y 1,02: que el periodo no dependa de la capacidad del nodo no es numérico |

- **E2 y E3 cumplidas:** el caso deja de ser inválido y R1 vale 24 de 24 con las tres lecturas nuevas.
- **E2 falla:** el caso sigue inválido; el rango bajo a ff −40 queda **sin verificar** y R1 se cuenta sobre 21.
- **E1 falla:** la dispersión no viene del paso máximo; queda sin explicar y se dice.
- **Inválida la tanda** si algún deck llega al tope o la calibración no da periodo.

Las otras siete combinaciones no se repiten: sus testigos cayeron en banda. Sus lecturas del rango bajo llevan la misma
dispersión numérica (del orden de 0,15 % por lectura), pequeña frente a la banda de ±3 %.
