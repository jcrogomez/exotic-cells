# MISFIT-16 · XC-20: la variante en pozo n con el interruptor abajo, dibujada por el generador

Escrito el 2026-11-26 (hora de sellado en `experiments/misfit16/PREREG_SHA256.txt`), **antes** de escribir el tercer tipo de
dispositivo del generador. Sale de la decisión 10 del plan ([MISFIT-15](../../experiments/misfit15/RESULTADOS.md)): con el
interruptor entre el nodo del lector y la isla, la unión recibe una tensión que depende de su propia corriente.

## Qué se dibuja

Variante **p+ pegado a n+ dentro de un pozo n**. Un solo pozo para toda la tabla, conectado al nodo X del lector por las
tomas n+. Cada puesto: una isla p+ de 1,0 × 1,4 µm pintada como diodo (`pdiode`), una toma n+ de pozo de 1,0 × 1,4 µm a
separación d (frontera de 1,4 µm), y un interruptor nfet 0,84/0,15 fuera del pozo, **entre la isla p+ y GND**. Una toma p+
de sustrato por puesto junto al interruptor. Si `pdiode` no admite el pegado, se dibuja como difusión simple y se dice.

Tabla `xc20w`: la misma matriz aprobada, d = 0 (×2), 0,27 (×2), 0,54, 1,08 µm y una celda sin unión (toma a 3 µm). 7 puestos.

## Explicaciones aburridas

| Explicación | Chequeo |
|---|---|
| Sale limpia porque las reglas no miran esa capa | Testigo W2: d = 0,13 µm debe dar error |
| El LVS da igual porque no cuenta el diodo | Mutante W4: un diodo de menos |
| El pozo carga X y no se ve en la extracción (Magic no extrae el diodo pozo–sustrato como dispositivo) | W6 se calcula aparte con el modelo `ps2nw` del PDK y el área y perímetro del pozo dibujado, con el área en µm² como número (lección de MISFIT-15) y la capacidad del diodo de isla como control (0,5–3 fF) |

## Predicciones

| # | Predicción |
|---|---|
| W1 | La tabla sale limpia en Magic `drc(full)` y en los dos decks de KLayout, sin editar a mano |
| W2 (testigo) | La misma tabla con un puesto a d = 0,13 µm da error en Magic |
| W3 | LVS "match" contra la referencia generada, con un diodo `pd2nw` y un interruptor por puesto |
| W4 (mutante) | Con un diodo de menos en la referencia, el LVS no da match |
| W5 | Área por puesto entre 15 y 28 µm² |
| W6 | Capacidad del pozo contra el sustrato, modelo `ps2nw`, a 1,8 V en inversa y tt 27: entre 0,5 y 4 fF **por puesto** (total del pozo dividido entre 7) |

**Muere** esta forma si W1 falla por una regla que no se arregla moviendo piezas del generador. **Inválido** si fallan W2 o
W4, o el control de capacidad de W6.

**Qué se hace con W6:** el nodo del rango bajo del lector 2 es de 200 fF. Si 64 puestos de pozo pasan de 200 fF (más de
3,1 fF por puesto), el número de puestos de XC-20 por lector se fija en 200 fF dividido por la capacidad por puesto, y se
dice. No mata nada.

**Lo que esta prueba no dice:** nada de la corriente de la unión, ni si la frontera lleva siliciuro. Tampoco trata el
latch-up: una isla p+ en un pozo que baja de 1,8 V hacia 0,9 V mientras el sustrato está a 0 V no inyecta (el pozo sigue en
inversa contra el sustrato), pero no hay anillos de guarda y eso queda abierto.
