# XC-64 · caza de formas: cuatro transistores que no son rectángulos

Escrito el 2026-11-25 13:50 EST (`date`), **antes** de escribir las sondas. Sigue a las tres cazas de islas
([`experiments/xc64_hunt/RESULTADOS.md`](../../experiments/xc64_hunt/RESULTADOS.md)): con rectángulos de dos capas no hay más islas
que la familia de XC-20. Aquí cambia la pregunta: no la separación entre dos formas, sino **la forma del canal**. Solo reglas
(Magic y KLayout); nada eléctrico, nada de silicio.

## Sondas (cada una con contactos y toma, para que "legal" sea 0 violaciones de verdad)

| Sonda | Forma | Dimensión que camina | Qué sería si es legal |
|---|---|---|---|
| `step_gate` | nfet cuya difusión mide 0,42 µm de ancho a un lado y 1,00 al otro; el escalón de la difusión camina a través de la puerta | posición del escalón, de 0,35 µm antes de la puerta a 0,35 después (pasos de 5 nm) | con el escalón **debajo** de la puerta: un canal cuyo ancho cambia a mitad de camino |
| `hole_gate` | nfet de canal largo (L = 1,0) con un **hueco** de óxido de campo dentro del canal, entero bajo la puerta | lado del hueco, de 0 (control: transistor normal) a 0,60 µm | un canal en anillo: dos caminos en paralelo alrededor de una isla |
| `bent_gate` | puerta en L sobre una difusión de 2 × 2 µm | altura del codo, desde dentro de la difusión hasta fuera (control: codo sobre el campo) | un canal con esquina |
| `ring_gate` | puerta en anillo cuadrado, drenador en el centro | lado del hueco interior, de 0,30 a 1,20 µm | transistor sin bordes de canal contra el óxido de campo |

**Enviable** = Magic `drc(full)` 0 **y** deck de fabricación de KLayout 0.

## Controles

- `hole_gate` con hueco 0 y `bent_gate` con el codo fuera de la difusión deben ser enviables: son transistores corrientes. Si no
  lo son, esa sonda está mal dibujada y no dice nada.
- `step_gate` con el escalón a 0,35 µm de la puerta, a cualquiera de los dos lados, debe ser enviable por lo mismo.
- `ring_gate` no tiene control propio: si nunca es legal no se sabrá si es la regla o mi dibujo, y se dirá.

## Predicciones

| # | Predicción |
|---|---|
| F1 | `step_gate`: enviable solo con el escalón fuera de la puerta; **ningún** punto enviable con el escalón debajo |
| F2 | `hole_gate`: **enviable desde un hueco de 0,27 µm** (la separación mínima de difusión) hasta 0,60. Apuesto a que esta forma sí existe |
| F3 | `bent_gate`: enviable solo con el codo sobre el campo; nunca con el codo sobre la difusión |
| F4 | `ring_gate`: nunca enviable (lleva cuatro codos sobre difusión) |

Una predicción falsa en F1, F3 o F4, o cumplida en F2, es una forma legal no convencional: se mira su GDS, se extrae para ver qué
dispositivo entiende Magic, y entra como candidata con su prerregistro eléctrico aparte.

**Inválida una sonda si** falla su control. **Límites:** cuatro formas; que el DRC acepte una forma no dice que se fabrique como se
dibuja ni qué hace; el modelo del PDK no describe ninguna de ellas.

SHA en `experiments/xc64_hunt/PREREG_SHA256.txt`.
