# Plan nocturno del 2026-11-26 · cinco bloques sobre el lector 2 · resultados

Prerregistro: [`PLAN_2026-11-26_noche.md`](../../cells/preregistros/PLAN_2026-11-26_noche.md) (sellado 22:36 EST, antes de
la cola) y [enmienda 1](../../cells/preregistros/PLAN_2026-11-26_noche_enmienda1.md). Cola de 22:36 a 07:38 EST
(`cola.out`): los 178 decks acabaron en `salida 0`. Generador, cola y análisis sellados antes de lanzar; los sellos
verifican después. Veredictos tal como los imprime el análisis: [`noche.txt`](noche.txt) y [`enm1.txt`](enm1.txt). Todo
es SPICE (ngspice 44.2, PDK 8afc8346) sobre el lector 2 de MISFIT-24. Nada es silicio.

## Lo aburrido primero

- **El lazo sigue sin colocar.** Celdas de librería sin parásitos de ruta; el "cable" del bloque W es un condensador a
  masa, sin resistencia.
- **Tres decks del bloque S no arrancaron y la enmienda que los repite es inválida por su propia regla.** Ver bloque S.
- **Los 63 puestos son nueve copias de la matriz de 7**, cada una con su cableado extraído, sin el cable que las une, y
  todas con el mismo dispositivo (la unión de XC-20). Otros dispositivos fugarán otra cosa.
- **El desajuste es el del modelo `tt_mm`, a 27 °C y 1,80 V**, 40 chips por rango. No se cruzó con temperatura ni
  alimentación.
- **Calculé mal la duración:** cada chip del rango bajo tardó unos 80 minutos (tope 90). Ninguno lo pasó.
- La dispersión entre periodos del rango bajo sigue sin causa `[?]`; esta noche aparece otra vez (control E0).

## Bloque K · el contador de rizado sigue al lazo: cumplida

| # | Predicción | Veredicto |
|---|---|---|
| K1 | El bit 3 sube entre 0 y 3 ns tras los flancos 8 y 24 de `q`; 4 de 4 | **cumplida**: 0,76–1,68 ns |

Periodo de `q` a 10 µA: 21,2–22,0 ns en las cuatro esquinas. La decisión 15 (el lector 2 como puesto) no se revierte por
aquí. No probado: los 13 biestables enteros ni las salidas retenidas.

## Bloque S · alimentación a 1,70 y 1,90 V: falsas como están escritas

| # | Predicción | Veredicto |
|---|---|---|
| S1 | Recalibrado a la alimentación movida, dentro de ±3 %; 8 de 8 | **falsa**: 6 de 8 (entre −0,56 y +0,20 %); en 2 de 8 no hay ajuste |
| S2 | Con la calibración de 1,80 V: 3–8 % (alto), 2–20 % (bajo) por 100 mV; 8 de 8 | **falsa**: 7 de 8; alto 5,05–5,67 %, bajo 6,84–9,79 %; un caso sin periodo |

**Por qué faltan dos casos:** a tt 27 y 1,70 V tres decks no dan ningún flanco (rango bajo a 100 pA y a 3,16 nA, rango
alto a 10 nA). Diagnóstico exploratorio (`diag/s170/`): el punto de operación inicial cae en el equilibrio metaestable
del cerrojo (`q` = `qb` = 0,742 V) y el simulador, sin ruido, se queda ahí; la línea de la precarga larga queda a 0,83 V
y sujeta el nodo en 1,686 V.

**Enmienda 1: inválida por su regla.** Los tres decks con el cerrojo inicializado (`.ic`) oscilan (E1), pero el control
(E0) se mueve −0,14 % y el tope escrito era 0,1 %. Mi error: puse un tope más estrecho que la dispersión ya conocida del
rango bajo (0,05–0,58 % entre periodos). Lo observado ahí queda como **exploración, no como veredicto**: recalibrado,
+0,06 % (bajo) y −0,44 % (alto); con la calibración de 1,80 V, +11,9 % (bajo) y +5,2 % (alto).

**Qué dice lo válido:** donde hay ajuste, recalibrar absorbe la alimentación. Sin recalibrar, la lectura se mueve entre
5 y 10 % por 100 mV; el signo es el esperado (más tensión, más carga por ciclo, periodo más largo, corriente leída de
menos).

## Bloque W · cable en el nodo: cumplidas las tres

| # | Predicción | Veredicto |
|---|---|---|
| W1 | Rango bajo: la carga cambia < 2 %; 4 de 4 | **cumplida**: +0,17 a +0,31 % |
| W2 | Rango alto: +20 fF da +8..+13 %; +50 fF, +21..+31 % | **cumplida**: +9,2 y +9,8 %; +22,0 y +23,5 % |
| W3 | Fuera de muestra dentro de ±3 %; 8 de 8 | **cumplida**: entre −0,40 y +0,26 % |

## Bloque N · 63 puestos en el nodo: seis de siete

| # | Predicción | Veredicto |
|---|---|---|
| N1a | Rango bajo, ff 85, sin corriente: oscila sola, periodo 0,1–0,5 ms | **cumplida**: 0,210 ms |
| N1b | Rango bajo, ss 85, sin corriente: ≥ 2 flancos en 20 ms | **cumplida**: 11 |
| N1c | Rango bajo, tt 27, sin corriente: < 12 flancos | **cumplida**: 0 |
| N2a | Rango bajo: 3,16 nA y 100 nA dentro de ±3 % en 3 esquinas | **cumplida**, 6 de 6: entre −0,77 y +0,58 % |
| N2b | Rango bajo, 316 pA, tt 27: dentro de ±3 % | **cumplida**: −0,01 % |
| N2c | Rango bajo, 316 pA, ff 85: **fuera** de ±3 % | **falsa**: −0,42 %. La fuga ajustada es −253 pA y el modelo la absorbe |
| N3 | Rango alto, ff 85: 3 fuera de muestra dentro de ±3 % | **cumplida**: −0,08 a −0,14 % |

Sin predicción: 316 pA a ss 85, +1,76 %. Fuga ajustada del rango bajo: −0,7 pA (tt 27), −55 pA (ss 85), −253 pA (ff 85).
En el rango alto a ff 85 la carga por ciclo sube a 361 fC (188 fC con una matriz): las nueve matrices doblan la
capacidad del nodo, y sin corriente también oscila sola (1,42 ms).

## Bloque M · desajuste: válido; una predicción falsa

| # | Predicción | Veredicto |
|---|---|---|
| M0 (control) | El deck `tt` repite MISFIT-24 dentro de 0,2 % | **cumplida** en los dos rangos (0,0 %) |
| M1 | Los 40 chips de cada rango oscilan en las 4 corrientes | **cumplida**: 40 de 40 y 40 de 40 |
| M2 | Calibrado chip a chip, dentro de ±3 % en ≥ 38 de 40 | **cumplida**: 40 de 40 en los dos rangos; errores entre −0,2 y +0,3 % |
| M3 | σ de la carga: 2–10 % (bajo), 0,3–3 % (alto) | **falsa** en el bajo (1,1 %); cumplida en el alto (1,1 %) |

Carga entre chips: rango bajo 49,8–52,0 fC; rango alto 178,1–187,4 fC.

## Decisiones, por las reglas escritas

- **K1 cumplida:** el divisor del lector como puesto se queda.
- **W3 cumplida:** el cable del nodo solo cuesta tiempo de lectura en el rango alto (+9 a +10 % por cada 20 fF). El
  criterio de la decisión 14 pasa a ser un presupuesto de tiempo.
- **N:** el suelo del rango bajo con 63 puestos es 316 pA (la menor corriente probada que pasa en las 3 esquinas), así
  que **el lector 2 lleva 64 puestos**. El cero del instrumento es la lectura con todos los puestos abiertos: en caliente
  el lector oscila solo y esa lectura es la fuga.
- **M1 y M2 cumplidas:** el desajuste lo absorbe la calibración de tres corrientes.
- **S:** la regla pedía más de 10 % por 100 mV para escribir que una lectura solo vale como cociente contra la
  calibración de la misma sesión. Lo válido llega a 9,8 %; lo exploratorio, a 11,9 %. **Lo escribo igualmente**
  (decisión mía, fuera de la regla): 5–10 % por 100 mV ya basta para que una calibración antigua no valga.

## Qué explicación aburrida no descarté

- Que en silicio el cerrojo tarde en salir del equilibrio metaestable al arrancar. Lo esperable es que el ruido lo saque
  en nanosegundos; no está simulado. El contador descarta el primer intervalo, pero no un arranque que no llega.
- Que la calibración absorba el desajuste solo porque las tres corrientes de calibración son ideales. En el chip salen de
  algo que también se desajusta.
- Desajuste con 63 puestos, en caliente o con la alimentación movida.
- Que el cable real, con resistencia y acoplo a vecinos, haga algo que un condensador a masa no hace.
- Fuga de otros dispositivos exóticos en los 63 puestos.
