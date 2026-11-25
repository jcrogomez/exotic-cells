# MISFIT-07 · enmienda 1 · el testigo estaba mal diseñado; prueba nueva con lectura asíncrona

Escrita el 2026-11-25 12:24 EST (`date`), **después** de la primera corrida y **antes** de escribir o correr la segunda.

## Qué pasó (se queda como está)

Primera corrida (`experiments/misfit07/m7.txt`): F1–F4 se cumplen para **todos** los k, incluido 0 dedos (el salto cambia ≤ 0,20 %
relativo, la diafonía es 0,003–0,007 %, el tiempo se desplaza ≤ 0,06 %). Pero el testigo F5 **falla** (la diafonía sin filtro es
~1,3 veces la de 33 dedos, no ≥ 3 veces): **benchmark inválido**, por la regla escrita. No se puede afirmar "el filtro sobra"
con una prueba que no ve el filtro.

Por qué el testigo era malo (mío): pedía que la *lectura* viera el filtro, que es justo lo que la hipótesis niega. Un testigo
tiene que mostrar que las variantes **difieren de verdad** en lo que el filtro hace (sujetar VB), con independencia de la lectura.
Y la primera corrida solo tenía lecturas casi síncronas (A y B cruzan a la vez), el caso más favorable.

## Prueba nueva

Mismas variantes (k = 33, 16, 8, 4, 2, 0). Por variante, tres instancias con src = 01:
- `h`: síncrona, como antes (control del deck contra el contrato con k = 33).
- `a`: **asíncrona**: la puerta del DUT de A va a VB − 50 mV, con lo que A tarda ~3–4 veces más que B (la etapa b midió
  ×2,9–3,9 por cada −50 mV). B dispara en mitad de la lectura de A. Es el caso que el Monte Carlo dijo que ocurre (tA y tB
  pueden diferir ×3).
- `at`: como `a`, más el salto de 0,305 mV en A.
Transitorio de 250 µs en las 4 esquinas.

## Cantidades

- **K** = golpe sobre VB: max |VB(t) − VB(0,9 µs)| entre T0 y el final, en `a`.
- **Sa** = salto de una carga en lectura asíncrona, (tA(at) − tA(a)) / tA(a).
- **Da** = desplazamiento de tA(a) frente a la variante de 33 dedos.

## Predicciones

| # | Predicción |
|---|---|
| G1 (testigo) | K(k = 0) ≥ 3 · K(k = 33) en las 4 esquinas: las variantes difieren de verdad |
| G2 | Con k ≥ 4, Sa cambia menos del 2 % relativo frente a k = 33, en las 4 esquinas |
| G3 | Con k ≥ 4, \|Da\| ≤ 0,08 % (una décima del salto: si todo el desplazamiento es menor que eso, su variación también) |

**Corte:** el k más pequeño que cumple G2 y G3 (con todos los mayores) en las 4 esquinas.

- **Sigue:** corte ≤ 8 dedos. **Muere:** corte ≥ 16.
- **Inválido si:** falla el control de un deck, falla G1, o A no cruza en 250 µs en alguna esquina (entonces esa esquina no cuenta
  y se dice).

Límites: los mismos de la prueba original (sin ruido, un solo lector en VB, cableado de los dedos quitados presente).
Tope: 60 min por deck (`timeout` dentro del contenedor, que es el que corta de verdad).
