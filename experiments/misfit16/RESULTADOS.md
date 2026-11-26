# MISFIT-16 · XC-20 en pozo n con el interruptor abajo, dibujada por el generador · resultados

Prerregistro: [`MISFIT-16`](../../cells/preregistros/MISFIT-16_2026-11-26_xc20_pozo_n.md), sellado y subido antes de escribir
el tipo de dispositivo. Tabla: [`generator/tables/xc20w.json`](../../generator/tables/xc20w.json). Salida: `xc20w/`,
testigo en `testigo/`, cuenta de capacidad en `w6/`. Dibujo, verificación y una cuenta con el modelo; nada es silicio.

## Lo aburrido primero

- **Esto no dice nada de la corriente de la unión** ni de si la frontera lleva siliciuro. Igual que MISFIT-14.
- **Una sola pasada, sin correcciones.** El tipo nuevo reutiliza la geometría de MISFIT-14 con las capas cambiadas.
- **W6 no sale de la extracción:** Magic no saca el diodo pozo–sustrato como dispositivo. Es el modelo `ps2nw` del PDK con
  el área y el perímetro del pozo dibujado. El control (diodo de isla, 0,98 fF) está en su banda.
- **El pozo es un rectángulo único** que cubre también los huecos entre puestos: su capacidad por puesto es la de esta
  tabla (separaciones de 1,5 µm y una celda con la toma a 3 µm), no un mínimo.
- **La extracción da 7 avisos** "Device has multiple lengths", uno por isla, como en MISFIT-14. Los diodos salen con el
  área y el perímetro correctos (1,4 µm², 4,8 µm). Causa `[?]`.
- **El LVS cuenta el diodo; no consta que compare su área** (misma salvedad que MISFIT-14, sin probar).
- **Sin anillos de guarda.**
- La línea de `w6/m.log` trae también una "fuga del pozo" de 1,8 pA: es el gmin por defecto (1e-12 × 1,8 V), no el diodo.
  No se usa. La fuga del modelo está en MISFIT-15.

## Resultado

Tabla `xc20w`, 7 puestos: d = 0 (×2), 0,27 (×2), 0,54, 1,08 µm y una celda sin unión. Isla p+ de 1,0 × 1,4 µm pintada como
diodo dentro de un pozo n común; toma n+ del pozo al nodo X; interruptor nfet 0,84/0,15 fuera del pozo, entre la isla y GND.

| # | Predicción | Veredicto |
|---|---|---|
| W1 | Limpia en Magic `drc(full)` y en los dos decks de KLayout | **cumplida**: 0 / 0 / 0 |
| W2 (testigo) | Un puesto a d = 0,13 µm da error | **cumplida**: `diff/tap.3` en Magic, 1 en cada deck de KLayout |
| W3 | LVS match, un diodo `pd2nw` y un interruptor por puesto | **cumplida**: "Circuits match uniquely"; 7 diodos y 7 nfet |
| W4 (mutante) | Un diodo de menos no da match | **cumplida** ("Top level cell failed pin matching") |
| W5 | Entre 15 y 28 µm² por puesto | **cumplida**: caja 28,52 × 5,27 µm = 150,3 µm², **21,5 µm² por puesto** |
| W6 | Pozo contra sustrato: 0,5 a 4 fF por puesto a 1,8 V, tt 27 | **cumplida, cerca del borde**: 26,7 fF el pozo, **3,81 fF por puesto** (4,33 fF a 0,9 V) |

**Lo nuevo:** la capa `pdiode` también admite el pegado: una isla p+ pintada como diodo puede tocar la toma n+ del pozo y
sigue siendo legal en las tres herramientas, y el LVS la cuenta. Las dos polaridades de baja tensión de la familia están
ya en el generador.

**Qué se hace con W6 (regla escrita):** 3,81 fF por puesto pasa de 3,1, así que 64 puestos de pozo serían 244 fF, más que
el nodo de 200 fF del rango bajo del lector 2. **Puestos de XC-20 por lector: 52** (200 / 3,81). Sumando el cableado y las
tomas extraídos en X (9,55 fF para 7 puestos, 1,36 fF por puesto), la cuenta baja a unos 38 (aritmética, no prerregistrada).
El pozo se puede recortar a islas y tomas; es optimización y va después de los candidatos.

## Qué explicación aburrida no descarté

- Que el modelo `ps2nw` no valga para un pozo estrecho de 1,76 µm (mucho perímetro por área).
- Que la capacidad del pozo, que cambia un 14 % entre 1,8 y 0,9 V, estropee la linealidad del lector: no simulado.
- Que la isla p+ flotante de un puesto abierto, con el pozo bajando, moleste a la lectura del vecino: no simulado.
- La causa de los 7 avisos de extracción.
