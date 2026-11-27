# MISFIT-25 · síntesis y colocación del bloque digital del lector 2 · resultados

Prerregistro: [`MISFIT-25`](../../cells/preregistros/MISFIT-25_2026-11-27_lector2_sintesis_y_colocacion.md) y
[enmienda 1](../../cells/preregistros/MISFIT-25_2026-11-27_lector2_sintesis_y_colocacion_enmienda1.md), los dos sellados y
subidos antes de su pasada. LibreLane 3.0.14, PDK 8afc8346. Veredictos tal como salen: [`m25.txt`](m25.txt) (pasada 1) y
[`m25_e1.txt`](m25_e1.txt) (pasada 2). Bloque final en [`bloque/`](bloque/) (GDS, DEF, LEF, netlist, métricas). Fuentes:
[`instrument/reader2`](../../instrument/reader2/README.md).

## Lo aburrido primero

- **Es cierre físico, no función.** El bloque colocado no se ha simulado: ni extraído, ni con la parte analógica.
- **Sin análisis de tiempos.** El bloque no tiene reloj; el flujo informa de 6 violaciones de pendiente y 1 de abanico
  contra restricciones genéricas que aquí no significan nada. Quedan sin reparar a propósito (enmienda 1) y sin evaluar.
- **La parte analógica `reader2fe` no está en el bloque.** Los pines `x`, `prenh` y `prenl` salen por el borde inferior
  en metal 2, donde el flujo quiso; no están alineados con la celda analógica.
- **LVS es el del flujo**, contra su propio netlist. Sin DRC de KLayout (apagado, como en los bloques anteriores).
- Una corrida por variante.

## Resultado

| # | Predicción | Pasada 1 | Pasada 2 (enmienda 1) |
|---|---|---|---|
| H1 | `prot` cierra limpio | **falsa**: no termina, `[RSZ-3006] Failed to insert buffer` en la reparación tras la colocación | **cumplida**: DRC 0, LVS 0, antenas 0 |
| H2 | Las 17 celdas del lazo intactas y cada red con las conexiones del RTL | **falsa** (sin bloque) | **cumplida** |
| H3 | Área entre 1000 y 3000 µm² | sin dato | **falsa**: 53,4 × 64,1 = 3426 µm² |
| H4 (testigo) | `libre` cambia algo del lazo | **cumplida** | no se repite |
| H5 (enmienda) | Ningún búfer añadido en `prot` | | **cumplida** |

**El testigo, que es lo que más enseña:** sin protección el flujo cierra limpio y **rompe el lector**. Mete un búfer en
la entrada `x` (el nodo analógico dejaría de ir al comparador), búferes en `prenh` y `prenl`, y un búfer dentro del lazo
entre `q` y el primer retardo (`libre_reader2_slot.nl.v`). DRC, LVS y antenas dan cero igual. Un bloque así pasa todas las
comprobaciones del flujo y no mide.

**Por qué falló la pasada 1:** con las redes del lazo marcadas como intocables, la reparación de pendientes y abanicos
sigue queriendo meter un búfer en una de ellas y el flujo sale con error. La enmienda apaga esa reparación
(`RUN_POST_GPL_DESIGN_REPAIR` = 0) y deja las tres protecciones.

**Por qué falla H3:** las celdas ocupan 749 µm² (394 los 15 biestables) en un núcleo de 1727 µm² al 43 %; el resto hasta
3426 µm² son los márgenes del bloque, que no conté. Reducible; no se ha intentado.

En el bloque final: 93 celdas sin relleno; la red `x` son 12 µm de metal 2 y 1 µm de metal 1 hasta el comparador.

Fallo de mi análisis, corregido en la enmienda antes de la pasada 2: buscaba la red `q` como `u_loop.q` y tras la
síntesis se llama `ck[0]`.

## Decisión, por la regla escrita

H1 y H2 cumplidas (con una enmienda): **este es el bloque digital del lector 2**, con esta configuración. Sigue la etapa
B (extraerlo con parásitos y simularlo con `reader2fe` y la matriz, prerregistrada aparte) y el ensamblado con la parte
analógica y LVS propio. Regla que queda para todo bloque que toque un nodo analógico: sin búferes en puertos, lista de no
tocar, sin reparación de diseño, y **comprobar el netlist final red por red**, porque el flujo no avisa.

## Qué explicación aburrida no descarté

- Que el bloque colocado lea distinto del esquemático (retardo real, cable de `q`, acoplos). Es la etapa B.
- Que el contador falle con las pendientes sin reparar: `q` mueve seis entradas con una `nor2_1`. En SPICE con un solo
  biestable colgado funcionó (noche del 26, bloque K); con el bloque entero extraído, sin probar.
- Que el LVS del flujo, que compara contra su propio netlist, no vea algo que un LVS contra el RTL sí.
- Que al acercar los pines a la celda analógica el flujo deje de cerrar.
