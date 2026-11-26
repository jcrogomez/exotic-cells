# MISFIT-11 · enmienda 1 · las tomas de sustrato se colocan por distancia

Escrita el 2026-11-26 08:29 EST (`date`), **después** de la primera pasada de la etapa 1 y antes de repetirla.

**Qué pasó (se queda como está, en `experiments/misfit11/m11_v1.txt` y `v1/lod12`):** M1, M3, M4 y M5 cumplidas; **M2 falsa**.
`u16` y `u64` salen limpias, pero `lod12` da un error de Magic: *N-diff distance to P-tap must be < 15.0um (LU.2)*. El
generador ponía una toma cada N puestos; con puestos de 12 µm de difusión, cuatro puestos dejan difusión a más de 15 µm de una toma.
Nadie tocó la salida a mano: el fallo es de una regla del generador, no del dibujo.

**Cambio:** el generador pone una toma antes de un puesto cuando, sin ella, la difusión de ese puesto quedaría a más de
`tap_max` (10 µm por defecto) de la última toma; `tap_every` sigue valiendo como tope por número. Nada más cambia.

**Prueba repetida:** las cuatro tablas, los dos mutantes y el testigo, con los mismos criterios. Predicción: M2 cumplida;
`u16` y `u64` salen idénticas a la primera pasada (misma caja); M5 no cambia. Si `lod12` vuelve a fallar por otra regla,
se reporta y G2 no se da por cerrada ni con esta tabla.
