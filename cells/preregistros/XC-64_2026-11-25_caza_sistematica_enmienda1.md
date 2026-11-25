# XC-64 · caza sistemática · enmienda 1: criterio corregido y segunda caza, por cruce de bordes

Escrita el 2026-11-25 13:28 EST (`date`), **después** de la caza por parejas y **antes** de escribir o correr la segunda.

## Qué pasó en la caza por parejas (se queda como está)

`experiments/xc64_hunt/pares.txt`: aparecen las cuatro islas esperadas y **16 no esperadas**. Por el criterio escrito, la
predicción es **FALSA**.

Lo aburrido, comprobado en los datos (`pares.csv`, reglas del punto lejano de cada pareja): las 16 están todas en un contexto
que **ya es ilegal por sí solo** (difusión n dentro del pozo, difusión p fuera de él, toma en el pozo equivocado). Su punto lejano
ya viola una regla de contexto ("N-well overlap of P-Diffusion", "N-Diffusion spacing to N-well"...), y pegar las dos formas no
añade ninguna. Mi criterio ("limpio si no añade reglas a las del punto lejano") deja pasar eso. **Fallo de diseño del criterio,
mío.** Observación que sí queda: para cualquier pareja de difusiones o tomas, pegarlas a 0 nunca añade una regla.

## Criterio corregido (para la segunda caza, y para releer la primera como análisis posterior declarado)

Un punto es **limpio** si todas sus reglas violadas son de **presencia de toma**: las de latch-up (LU.x) y "All nwells must
contain metal-connected N+ tap". Son las únicas que un rectángulo suelto sin contactos viola en un contexto correcto.

## Segunda caza: una forma que cruza el borde de otra

La caza por parejas solo camina la separación lateral. Las estructuras con tres regiones (una forma **a caballo** del borde de
otra) no las ve, y ahí están los transistores, los contactos al borde y las uniones.

- **Parejas ordenadas** (A, B) de las mismas 12 capas, A ≠ B: 132, en los dos contextos: 264 escaneos.
- **Geometría:** A es un rectángulo de 2,0 × 2,0 µm. B, de 0,5 × 0,5 µm, centrado en y, se mueve en x: su borde derecho va de
  0,50 µm dentro de A (B entero dentro) a 0,50 µm fuera (B entero fuera, pegado), en pasos de 10 nm; más un punto lejano.
- **A caballo** = B con parte dentro y parte fuera de A (0 < lo que sobresale < 0,5 µm).
- **Hallazgo** = punto a caballo limpio con el criterio corregido.

## Predicción

Hay puntos a caballo limpios **solo** cuando una de las dos capas es locali o metal1 (viven en otro plano y, sin contactos, no
tienen reglas de cierre contra lo de abajo), y en (poly, nwell) y (nwell, poly) (el poly cruza bordes de pozo sin problema).
**Ninguna otra pareja.** Cualquier otra es un hallazgo y se mira en el GDS.

- **Testigo:** (metal1, ndiff) en sustrato debe tener puntos a caballo limpios. Si no, el criterio es demasiado estricto y la caza
  no vale.
- **Límite conocido:** Magic compone tipos al pintar (poly sobre ndiff se vuelve nfet): lo que el escáner ve es lo que Magic
  entiende de la forma, no dos rectángulos. Por eso todo hallazgo se confirma mirando qué tipos quedaron.

Tope: 40 min. SHA en `experiments/xc64_hunt/PREREG_SHA256.txt`.
