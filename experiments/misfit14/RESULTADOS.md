# MISFIT-14 · las celdas de XC-20 (el Túnel) dibujadas por el generador · resultados

Prerregistro: [`MISFIT-14`](../../cells/preregistros/MISFIT-14_2026-11-26_xc20_celdas_generadas.md), sellado y subido antes de
escribir el tipo de dispositivo. Tabla: [`generator/tables/xc20s.json`](../../generator/tables/xc20s.json). Salida: `xc20s/`.
Dibujo y verificación; ninguna simulación. Nada es silicio.

## Lo aburrido primero

- **Esto no dice nada de la corriente.** El modelo del PDK no tiene túnel. Que la celda sea legal y extraíble no la hace una
  unión túnel: eso solo lo dice el silicio.
- **Si la frontera lleva siliciuro, d = 0 es un cable y no una unión.** Sigue inferido que no lo lleva (resistencias de capa
  y un tercero); no hay documento. La celda de 0,27 µm y la temperatura son las que lo separarían.
- **Una sola variante de las cuatro:** n+ contra p+ en sustrato. Falta la de pozo n y las dos de alto voltaje.
- **La primera pasada tuvo un error mío de dibujo** (regla `li.5`, tira de interconexión local 0,06 µm corta sobre el
  contacto, 14 veces en KLayout y 1 en Magic). Corregido en el generador antes de juzgar; queda en `pasada1/`.
- **La extracción deja 7 avisos sin texto,** uno por isla, sobre la franja superior de la isla. Cada diodo sale con el área y
  el perímetro correctos (1,4 µm², 4,8 µm). Causa `[?]`.
- **Sin anillos de guarda.** El riesgo de latch-up por inyectar en el sustrato ([RISKS](../../instrument/RISKS.md) fila 12)
  no está tratado.

## Resultado

Tabla `xc20s`, 7 puestos: d = 0 (×2), 0,27 (×2), 0,54, 1,08 µm y una celda sin unión. Isla n+ de 1,0 × 1,4 µm pintada como
diodo, toma p+ de 1,0 × 1,4 µm, interruptor nfet 0,84/0,15 en serie hacia el nodo del lector.

| # | Predicción | Veredicto |
|---|---|---|
| J1 | Limpia en Magic `drc(full)` y en los dos decks de KLayout | **cumplida** tras corregir el error de dibujo: 0 / 0 / 0 |
| J2 (testigo) | Un puesto a d = 0,13 µm da error | **cumplida**: `diff/tap.3` en Magic y `difftap.3` en KLayout, una vez |
| J3 | LVS match, un diodo y un interruptor por puesto | **cumplida**: "Circuits match uniquely"; 7 diodos `pw2nd` y 7 nfet |
| J4 (mutante) | Un diodo de menos en la referencia no da match | **cumplida** ("Top level cell failed pin matching") |
| J5 | Entre 15 y 28 µm² por puesto | **cumplida**: caja 28,16 × 5,27 µm = 148,4 µm², **21,2 µm² por puesto** |
| J6 | Ningún n+ a menos de 1,08 µm del p+ vecino | **cumplida** por construcción: 1,50 µm entre puestos |

**Lo nuevo:** la capa de diodo admite el pegado. La isla n+ pintada como `ndiode` puede tocar la toma p+ (d = 0) y sigue
siendo legal en las tres herramientas; así la unión deja de ser "difusión suelta" y pasa a ser un dispositivo que el LVS
cuenta. Era el punto 3 pendiente del plan de la familia.

**Qué cierra y qué no:** el generador ya dibuja dos tipos de dispositivo (transistor y unión) desde tablas, sin tocar la
salida: G2 queda cerrada en su parte de dibujo. Falta el precheck sobre un tile, y de XC-20 falta la corriente esperada por
celda frente al rango de los lectores (C4), las otras tres variantes y los anillos de guarda.
