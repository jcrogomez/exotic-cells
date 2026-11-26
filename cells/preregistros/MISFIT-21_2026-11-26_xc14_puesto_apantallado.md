# MISFIT-21 · XC-14: el puesto redibujado, con la placa apantallada del nodo y el acoplo en dos líneas

Escrito el 2026-11-26 (hora de sellado en `experiments/misfit21/PREREG_SHA256.txt`), **antes** de tocar el generador. Es lo
que [MISFIT-20](../../experiments/misfit20/RESULTADOS.md) dejó mandado: H6 dio 0,065 (límite 0,05) y la decisión 13 parte
la placa de acoplo en dos.

## Qué cambia en el dibujo

- **Pantalla:** una tira de metal 1 a GND entre el bus X y las placas, a todo lo largo, unida al bus GND por un tramo
  vertical a la izquierda de la matriz.
- **Acoplo en dos líneas:** la tira única de metal 2 pasa a ser franjas horizontales de 0,36 µm cada 0,50 µm, alternadas
  entre `CP1` y `CP2` (un peine por cada lado). Cada placa ve las dos líneas en proporción parecida.

Misma tabla `xc14fg` de MISFIT-20. Mismos transistores, antenas y gemelos.

## Explicaciones aburridas

| Explicación | Chequeo |
|---|---|
| El acoplo al nodo baja porque la placa se aleja, no por la pantalla | No se separan: solo digo cuánto queda. La comparación es con MISFIT-20 (0,065), declarando que cambian las dos cosas |
| Las dos líneas acoplan distinto porque la primera franja cae siempre en la misma | Se mide el cociente entre las dos por puesto (S4) |
| El peine deja de cubrir la placa pequeña | Se mide: la placa mínima (0,45 µm de alto) solo puede ver una franja; se anota y no entra en S3 ni S4 |

## Predicciones (puestos de óxido grueso con placa de 20 µm², sin opción; capacidad de puerta como en MISFIT-20)

| # | Predicción |
|---|---|
| S1 | Limpia en Magic `drc(full)` y en los dos decks de KLayout; LVS "match" con la misma referencia más los pines nuevos. Acepto una enmienda de geometría |
| S2 | Acoplo del nodo X a la puerta por debajo de 0,03 |
| S3 | Acoplo de cada línea (CP1, CP2) a la puerta entre 0,12 y 0,30 |
| S4 | Las dos líneas acoplan igual dentro de un 20 % (cociente entre 0,80 y 1,25) |
| S5 (testigo) | La misma tabla **sin** la pantalla (opción de tabla) da un acoplo del nodo mayor que con ella, al menos el doble |

**Si S2 falla** con la pantalla puesta: el acoplo que queda es del poly bajo el bus X; se sube la conexión de la puerta en
interconexión local en vez de poly, o se acepta y se calibra. Se dice cuál.
**Si S3 queda por debajo de 0,12:** las franjas se ensanchan.
**Inválido** si S5 falla (la pantalla no hace nada medible).

## Qué no dice

Lo mismo que MISFIT-20: nada de carga de plasma; capacidades de la extracción de Magic, no de un resolvedor de campos.
