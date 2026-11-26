# MISFIT-14 · las celdas de XC-20 (el Túnel) dibujadas por el generador

Escrito el 2026-11-26 (hora de sellado en `experiments/misfit14/PREREG_SHA256.txt`), **antes** de escribir el segundo tipo de
dispositivo del generador. Primer candidato del orden que pidió Juan (candidatos antes que área). Cierra la mitad pendiente de
G2 y empieza C4. Plan de la familia: [`cells/xc20_abutted_junction/PLAN.md`](../xc20_abutted_junction/PLAN.md).

## Qué se dibuja

Variante **n+ pegado a p+ en sustrato** (una de las cuatro que encontró el paseo por la regla). Se elige esta primero porque
el p+ es la toma de sustrato (GND) y el n+ es un nodo que el lector precarga y la unión descarga: la polaridad que los dos
lectores ya leen. La variante en pozo n (p+ contra n+) pide leer una corriente que sube el nodo y queda para después.

Cada puesto: una isla n+ de 1,0 × 1,4 µm, una toma p+ de 1,0 × 1,4 µm a separación d (frontera de 1,4 µm), y un interruptor
nfet 0,84/0,15 **en serie** entre el nodo X del lector y la isla n+. La toma p+ va a GND. La isla se pinta como diodo
(`ndiode`) para que la extracción dé un dispositivo y el LVS lo compare; si esa capa no admite el pegado, se dibuja como
difusión simple y se dice.

Tabla `xc20s`: d = 0 (×2), 0,27 (×2), 0,54, 1,08 µm y una celda sin unión (n+ sola, toma lejos). 7 puestos.

## Predicciones

| # | Predicción |
|---|---|
| J1 | La tabla sale limpia en Magic `drc(full)` y en los dos decks de KLayout, sin editar a mano |
| J2 (testigo) | La misma tabla con un puesto a d = 0,13 µm da error en Magic |
| J3 | LVS "match" contra la referencia generada, con un diodo y un interruptor por puesto |
| J4 (mutante) | Con un diodo de menos en la referencia, el LVS no da match |
| J5 | Área por puesto entre 15 y 28 µm² |
| J6 | El n+ de un puesto no queda a menos de 1,08 µm del p+ del puesto vecino (ningún par no buscado) |

**Muere** esta forma si J1 falla por una regla que no se arregla moviendo piezas del generador (entonces el pegado no es
legal dentro de una matriz, aunque lo sea suelto). **Inválido** si fallan J2 o J4.

**Lo que esta prueba no dice:** nada de la corriente. El modelo del PDK no tiene túnel; la corriente esperada por celda y si
cae en el rango de algún lector es el paso siguiente (C4), con su propio prerregistro. Tampoco resuelve si la frontera lleva
siliciuro (inferido que no, `PLAN.md` de la familia, entrada del 2026-11-16).
