# XC-64 · Paseo por la regla

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-64 de [catálogo](../../README.md#catalogue) (Rule walk).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

Alta del 2026-11-25 11:45 EST (`date`), propuesta por el agente dentro del [plan del primer tile](../../docs/MISFIT_PLAN.md), por encargo de
Juan ("tú decide, añade valor"). Sin atacar ni verificar todavía.

## 1. Ficha

**XC-64 · Paseo por la regla.** Cada regla de diseño es una frontera que la fundición ya dibujó, sin decir por qué está ahí ni
cuánto margen tiene → una misma estructura repetida con **una sola dimensión** que avanza en pasos de la rejilla (5 nm) desde
lo cómodamente legal, pasando por el valor de la regla, hasta donde las comprobaciones del vehículo la dejen pasar → ninguna
formación: lo decide la litografía → la magnitud eléctrica que la regla protege (fuga entre vecinos, corriente de un contacto,
umbral) frente a la dimensión → **dónde está la frontera de verdad, y qué hay al otro lado**: margen de la regla, transición
suave o abrupta, y a veces un comportamiento nuevo (XC-20 nació así: p+ y n+ son legales a 0 y a ≥ 0,27 µm, nada en medio) →
el gemelo es el punto más holgado de la misma escalera.

No es una celda: es una **familia de escaleras**, una por regla, generadas por la misma herramienta que ya mide el borde legal
([`residual/drc_edge`](../../residual/drc_edge/README.md)).

## 2. Lectura y piso

| Cantidad | Valor | De dónde |
|---|---|---|
| Paso de la escalera | 5 nm, la rejilla de fabricación | `residual/drc_edge`, **corrida** |
| Borde legal de "difusión junto a una puerta, sin contacto" | Magic: desde 0,250 µm (poly.7). El deck de fabricación de KLayout no reporta nada hasta 0,050 µm | `residual/drc_edge`, **corrida** |
| Borde legal de p+ a n+ en pozo n | exactamente 0, y desde 0,270 µm | ídem |
| Qué comprueba el precheck de Tiny Tapeout en cada una | `[?]` por regla; hay un mapa parcial | [`experiments/precheck_map`](../../experiments/precheck_map/README.md) |
| Efecto eléctrico esperado al cruzar cada regla | `[?]`: el modelo del PDK no describe geometrías fuera de regla | — |
| Lector | lector 1 (pA) para fugas y umbrales; lector 2 (rango ancho) para contactos | [plan del tile](../../docs/MISFIT_PLAN.md) |
| Piso: desajuste entre vecinos | σ = 17,3 mV (0,42/0,15) | `experiments/lod_audit`, **corrida** |

Señal/piso: `[?]`. Es justo lo que no se puede simular con el modelo del PDK. Para algunas reglas sí hay simulación física
posible (imagen aérea de la litografía, `experiments/litho_explore`).

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| El cambio a lo largo de la escalera es desajuste | Una frontera tiene posición: es un escalón o un codo en un punto de la escalera. Escalera repetida en espejo; ≥ 2 réplicas |
| Es gradiente del dado | Escaleras en orden alterno (ida y vuelta) |
| La dimensión fabricada no es la dibujada (corrección óptica, sesgo de grabado) | No es un fallo: es parte de lo que se mide. Se reporta contra la dimensión dibujada |
| El efecto es de un vecino que cambia a la vez (LOD, proximidad de pozo) | Solo cambia una dimensión; `sa`/`sb` y distancia al pozo fijos y anotados |
| La regla existe por rendimiento (defectos por millón), no por comportamiento: en decenas de dispositivos no se ve nada | Es el resultado nulo informativo: "sin cambio medible hasta X nm más allá de la regla, en N dispositivos" |

## 4. Referencia convencional (control científico, no filtro)

El punto legal más holgado de cada escalera. No se compara con ningún componente de biblioteca.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Lista de reglas candidatas: las que tienen una magnitud eléctrica legible por los lectores y un tramo fuera de regla que el
   precheck deja pasar (cruce de `residual/drc_edge` con `experiments/precheck_map`). Primera candidata, ya medida en el borde:
   difusión junto a una puerta (poly.7).
2. Por regla: escalera generada por script, DRC en Magic y en los dos decks de KLayout punto por punto, precheck del tile.
3. Donde exista física simulable (litografía), predicción prerregistrada de en qué punto cambia la forma impresa.
4. **Qué se envía y qué no:** un punto fuera de regla solo entra al tile si el vehículo lo permite de forma explícita; que una
   comprobación no lo vea no es permiso. Lo que no pueda enviarse se queda en la escalera hasta el borde y se anota.

### 5.2 Con silicio

Lectura de cada escalera con el lector que le toque, en frío de fábrica y tras estrés (eje de tiempo del plan del tile).

### 5.3 Hecho (2026-11-25): tres cazas de islas legales

[`experiments/xc64_hunt/RESULTADOS.md`](../../experiments/xc64_hunt/RESULTADOS.md). Cuatro sondas a mano, 156 parejas de capas
caminando la separación, y 264 parejas con una forma a caballo del borde de otra. **Ninguna isla nueva** con formas
rectangulares de dos capas: solo la familia de XC-20, que tiene cuatro miembros (dos polaridades, baja y alta tensión). Lo de
"más allá de la regla" no pasa el precheck en nada de lo probado. Una cuarta caza, de formas (escalón, hueco, codo, anillo), tampoco
encontró ninguna legal: poly.11 ("no bends in transistors") las cierra todas. Siguiente: lo legal que se imprime distinto justo
en la regla, y preguntar a Tiny Tapeout si un macro puede llevar una violación de Magic declarada.

## 6. Qué la mataría

Que ninguna regla candidata tenga a la vez magnitud legible y tramo enviable más allá del valor de la regla. Entonces queda
como herramienta (ya lo es) y no como familia en silicio.
