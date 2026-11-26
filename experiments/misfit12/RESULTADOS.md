# MISFIT-12 · tres pruebas rápidas · resultados

Prerregistro: [`MISFIT-12`](../../cells/preregistros/MISFIT-12_2026-11-26_pruebas_rapidas.md), sellado antes de generar los decks;
el análisis se escribió antes de correr (`PREREG_SHA256.txt`). Salida completa: [`m12.txt`](m12.txt). SPICE sobre extracciones
(ngspice 44.2, PDK 8afc8346). Nada es silicio.

## Lo aburrido primero

- **A mide el modelo del PDK, no el silicio.** El efecto de la difusión sale del modelo de estrés del PDK aplicado a sa/sb
  anotados desde la tabla. La prueba dice que el dibujo y el lector no lo tapan; no dice que el efecto exista con ese tamaño.
- **Sin desajuste.** El desajuste de umbral de un 0,42/0,15 (σ = 17,3 mV, `cells/xc12_lod_stress/PLAN.md`) es del orden del
  efecto (31 mV): en silicio hacen falta réplicas. Aquí hay dos por nivel y son idénticas por construcción.
- **B sigue sin las líneas de selección** más allá del borde de la matriz.
- **C no es una prueba:** relee datos ya vistos, con la regla fijada antes de calcular.

## A · dispositivos distintos en un mismo bus: válida

Tiempo de lectura (µs) del puesto cerrado, por difusión a cada lado de la puerta:

| Esquina | 0,30 | 0,45 | 0,75 | 1,50 | 3,00 | 6,00 µm | 0,30 / 3,00 |
|---|---|---|---|---|---|---|---|
| tt 27 | 35,03 | 26,73 | 20,94 | 17,11 | 15,36 | 14,52 | 2,28 |
| ff −40 | 52,48 | 37,69 | 27,95 | 21,83 | 19,14 | 17,88 | 2,74 |
| ss 85 | 35,44 | 28,28 | 23,05 | 19,46 | 17,77 | 16,96 | 1,99 |
| ff 85 | 2,79 | 2,26 | 1,88 | 1,61 | 1,48 | 1,42 | 1,89 |

| # | Predicción | Veredicto |
|---|---|---|
| L1 | Réplicas iguales dentro de 0,05 % | **cumplida** (peor 0,005 %) |
| L2 | Monótono en los 6 niveles, 4 esquinas | **cumplida** |
| L3 | Cociente 0,30 / 3,00 a tt 27 entre 1,5 y 1,8 | **falsa**: 2,28. Aposté con el 1,64 de una pareja anterior, que era otra geometría |
| L4 (testigo) | Sin el efecto, los 12 puestos leen igual dentro de 0,3 % | **cumplida**: 0,0006 % a tt 27, 0,08 % en el peor caso (ss 85) |

**Lectura:** en el modelo, el dibujo de la matriz aporta menos de 0,1 % y el efecto que se quiere medir es del 47 al 64 %.
Dispositivos distintos conviven en un bus: lo que lee un puesto no depende de los vecinos abiertos.

## B · 128 puestos con cableado: válida, todo cumplido

`u128` salió limpia a la primera (142,0 × 4,29 µm). Por puesto, +0,333 a +0,359 % (a menos de 2 % del valor con 64). Con 128
puestos la lectura tarda 1,43–1,46 veces y el salto de una carga pierde 1,2 a 4,5 % (peor: ss 85). **Decide:** 128 es
alcanzable con cableado; 64 queda con margen de 2. La decisión de usar 64 no cambia.

## C · lector 2 en dos rangos, relectura (exploración)

Aposté que los dos rangos quedarían dentro de ±3 %. **Fallé en los dos.** El error está siempre en el punto que queda **por
debajo** de la corriente de calibración más baja: 100 pA con calibración desde 1 nA (hasta −8,4 %, ff 85) y 10 nA con
calibración desde 31,6 nA (−7,0 %, ss 85). Dentro del tramo calibrado, el peor error es 0,4 % (bajo) y 1,0 % (alto).

**Qué enseña para diseñar la prueba de verdad:** el modelo de tres números interpola bien y extrapola mal hacia abajo, porque
ahí manda la fuga. Cada rango necesita una corriente de calibración en su extremo bajo.
