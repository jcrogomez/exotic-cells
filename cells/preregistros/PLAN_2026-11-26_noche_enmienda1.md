# Plan nocturno del 2026-11-26 · enmienda 1 · tres decks del bloque S que no arrancaron

Escrita el 2026-11-27 (hora de sellado en `experiments/noche_1126/PREREG_SHA256.txt`), **después** de ver los veredictos de
la noche (`experiments/noche_1126/noche.txt`, que se queda como está) y **antes** de correr los decks de abajo.

## Qué pasó

A tt 27 y 1,70 V, tres de los ocho decks no dan ningún flanco: rango bajo a 100 pA (calibración) y a 3,16 nA (fuera de
muestra), y rango alto a 10 nA (calibración). Los otros cinco decks de esa esquina y los 24 de las demás sí oscilan. Por
eso S1 y S2 salen **falsas tal como están escritas**: en 2 de 8 casos no hay ajuste.

Diagnóstico, exploratorio (`diag/s170/`, el deck de 3,16 nA repetido guardando los nodos del lazo): el punto de operación
inicial cae en el equilibrio metaestable del cerrojo, `q` = `qb` = 0,742 V, y se queda ahí los 2,3 ms; la línea de la
precarga larga queda a 0,83 V y sujeta el nodo en 1,686 V. Es un equilibrio inestable que el simulador, sin ruido, no
abandona. Mi cuenta de MISFIT-24 ("el reposo tiene un único estado") ignoraba esa solución.

## Prueba nueva (4 decks, `S_enm1/`)

Los tres decks mudos, idénticos salvo una línea: `.ic v(o_q)=0 v(o_qb)=1.70`. Y como control el deck del rango bajo a
10 nA de la misma esquina, que sí oscilaba, con la misma línea.

| # | Predicción |
|---|---|
| E0 (control) | El deck de 10 nA con la condición inicial repite su periodo de la noche dentro de 0,1 % |
| E1 | Los tres decks oscilan (12 flancos) |
| E2 | Con ellos, S1 en los dos casos que faltaban: recalibrado dentro de ±3 % |
| E3 | S2 en esos dos casos: rango alto entre 3 y 8 %, rango bajo entre 2 y 20 %, en valor absoluto |

**Si E1 falla:** no es el arranque del simulador; el lazo tiene un estado atascado a 1,70 V y pasa a ser el problema
principal del lector 2. **Si E0 falla:** la condición inicial cambia la medida y esta enmienda no vale.

Queda fuera, sin simular: que en silicio el cerrojo salga solo del equilibrio (lo esperable, por ruido) y cuánto tarda.
