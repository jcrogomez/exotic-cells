# MISFIT-27 · el lector 2 como unidad: bloque digital recolocado + `reader2fe`, con reglas y LVS propios

Escrito el 2026-11-27 (hora de sellado en `experiments/misfit27/PREREG_SHA256.txt`), **antes** de ninguna corrida de
LibreLane o de Magic de esta prueba, y mientras corre la tanda de [MISFIT-26](MISFIT-26_2026-11-27_lector2_bloque_extraido.md)
(sin ver sus veredictos). Pedido por Juan ("¿qué podemos avanzar en paralelo?").

## Pregunta

¿Se puede cerrar el lector 2 como una sola pieza de layout: el bloque digital de MISFIT-25 con los pines donde los
necesita la celda analógica y sin los márgenes de sobra, más `reader2fe` (MISFIT-22) debajo, unidos por metal, limpia
de reglas y con LVS contra una referencia propia?

## Qué se hace (`instrument/reader2/unit`)

1. **Bloque recolocado.** Las mismas fuentes y protecciones de MISFIT-25 (enmienda 1), cambiando solo el plano:
   dado fijo de 46,92 × 46,24 µm (núcleo de 92 sitios × 15 filas, el de MISFIT-25; márgenes de 2,30 y 2,72 µm) y pines
   por plantilla: `prenh`, `prenl` y `x` en el borde inferior, en las pistas de metal 2 más cercanas a los pines de
   `reader2fe` (x = 20,93, 25,07 y 27,83 µm); `en`, `pre`, `src[1:0]`, `xa`, `xb` en el borde superior, en metal 2.
2. **Unidad `reader2_unit`.** Bloque arriba, `reader2fe` debajo con su pin X justo bajo el pin `x`. Tres bajadas de
   metal 2 con vía a los pines de metal 1 de la celda; alimentación de la celda por pila de vías hasta las tiras de
   metal 4 del bloque (VDD a la tira VPWR que le cae encima, GND por metal 3 hasta una tira VGND). El pin `x` queda
   fuera, para la matriz.
3. **Comprobación.** Se lee el GDS de la unidad en una sesión nueva de Magic: reglas (`drc(full)`) y extracción; netgen
   contra referencia = netlist final del bloque + celdas de la librería + `reader2fe_ref.spice` + un top escrito a mano.

## Explicaciones aburridas

| Explicación | Chequeo |
|---|---|
| El LVS dice que coincide porque no mira las uniones | Tres mutantes del mismo guion: sin la vía de `x`, sin la vía de `prenl`, sin la pila de VDD. Los tres deben dar distinto |
| El bloque recolocado ya no es el de MISFIT-25 (búferes, lazo tocado) | La misma revisión red por red del netlist final (H2) |
| El dado pequeño cierra porque el flujo relaja algo | Métricas del flujo tal cual: reglas, LVS y antenas en cero, sin cambiar ninguna otra variable |

## Predicciones

| # | Predicción |
|---|---|
| H1 | El bloque recolocado cierra limpio a la primera: reglas 0, LVS 0, antenas 0 |
| H2 | Las 17 celdas del lazo intactas, cada red con las conexiones del RTL y ningún búfer añadido |
| H3 | La red `x` dentro del bloque mide menos de 15 µm de cable (en MISFIT-25: 13 µm) |
| H4 | La unidad sale limpia de reglas en Magic (0 violaciones) en como mucho dos pasadas del guion de ensamblado |
| H5 | LVS de la unidad: coincide con la referencia |
| H6 (mutantes) | Los tres mutantes dan LVS distinto |

Área: el dado es 2170 µm² por construcción (frente a 3426 µm²) y la unidad, 46,92 × ~56 µm; no es predicción.

## Reglas

- **Se adopta** la unidad si H1, H2, H4, H5 y H6 se cumplen. Entonces la etapa B se repite sobre este bloque (mismo
  guion de MISFIT-26, con su propia hoja), porque es el que iría al chip.
- **Si H1 falla** hay una enmienda (más margen o menos ocupación). Si falla dos veces, se vuelve al bloque de MISFIT-25
  y la unión se hace con codos.
- **Inválido si** algún mutante da LVS coincidente: el LVS no ve las uniones y H5 no vale.
- **Depende de MISFIT-26:** si allí falla el contador (B4 o B7) o la oscilación (B1), el bloque se rehace y esta unidad
  se repite; lo aprendido del plano y de las uniones se conserva.
- Tope: 20 min por corrida de LibreLane, con parada del contenedor.

## Qué no decide

Función (es la etapa B), la unión con la matriz, ni el sitio de la unidad en el tile.
