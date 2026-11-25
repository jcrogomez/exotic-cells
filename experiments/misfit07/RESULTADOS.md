# MISFIT-07 · resultados: la lectura no necesita el filtro de 10 pF

Escrito el 2026-11-25 12:42 EST (`date`). Prerregistro: [`MISFIT-07_2026-11-25_filtro_de_polarizacion.md`](../../cells/preregistros/MISFIT-07_2026-11-25_filtro_de_polarizacion.md)
y su [enmienda 1](../../cells/preregistros/MISFIT-07_2026-11-25_filtro_de_polarizacion_enmienda1.md); sellos en `PREREG_SHA256.txt`.
Números: [`m7.txt`](m7.txt) (primera corrida) y [`m7b.txt`](m7b.txt) (enmienda 1); los dos análisis se escribieron antes de ver
salidas. Macro extraído v_hm, 4 esquinas, ningún deck abortó. Todo es modelo, nada es silicio.

## Lo aburrido primero

1. **La primera corrida es inválida por un testigo mal diseñado (mío).** Pedía que la lectura viera el filtro, que es lo que la
   hipótesis niega. Falló (la diafonía sin filtro es ~1,3× la de 33 dedos) y por la regla escrita no cuenta. Sus números quedan
   como exploración.
2. **"0 dedos" no es "0 capacidad".** Se borran los 33 condensadores MOS, pero el cableado extraído de VB y las puertas de la
   cadena y de los espejos siguen ahí. Cuánta capacidad queda no se midió `[?]`.
3. **El golpe sobre VB no escala como 1/C y no sé por qué** `[?]`. De 33 a 2 dedos (de ~10 a ~0,6 pF) el golpe solo sube de
   0,065 a 0,089 mV a tt; el salto grande es de 2 a 0 dedos (0,247 mV). Una explicación sin comprobar: los dedos son de canal
   largo (10 µm) y a los flancos rápidos solo responde parte de su capacidad. El testigo pasa, pero por poco (3,4–4,9 veces).
4. **Sin ruido, sin desajuste real y con un solo lector en VB.** La asincronía se forzó bajando 50 mV la puerta de A.

## Veredictos de la enmienda 1, con sus palabras

Benchmark válido: el control repite el contrato en los 4 decks (+0,0000 %), A cruza en las 4 esquinas, y G1 se cumple.

| # | Resultado | Veredicto |
|---|---|---|
| G1 (testigo) | golpe sobre VB sin filtro frente a 33 dedos: ×3,8 (tt 27), ×4,9 (ff −40), ×4,0 (ss 85), ×3,4 (ff 85) | cumplida |
| G2 | salto de una carga en lectura asíncrona: cambia como mucho 0,08 % relativo, con cualquier k | cumplida |
| G3 | desplazamiento de tA: como mucho +0,011 % (ff 85), con cualquier k (límite 0,08 %) | cumplida |

Lectura asíncrona conseguida: A tarda 2,85 a 5,24 veces más que B según la esquina.

**Corte: 0 dedos. Sigue:** el lector cabe en la franja de un tile.

## Qué se lleva el diseño

- El filtro de 4743 µm² **no lo exige la lectura**. Lo que sujeta es una tensión interna (el golpe pasa de 0,06 a 0,25 mV al
  quitarlo, frente a un salto de 0,305 mV) que no llega al tiempo medido: la lectura integra durante decenas de µs.
- **Recomendación del agente, no veredicto:** no ir a 0. Dejar 4 dedos (220 µm² de puerta) como margen para lo que esta prueba
  no cubre: ruido (R5), dos lectores en el mismo VB (R3) y muchas ramas (R6). Si alguna de esas pide más, hay sitio para crecer.
- Con 4 dedos, el lector baja de ~5570 µm² a unos 815 + 220 µm² de puerta más su cableado: del orden de 1100 µm² (aritmética,
  sin dibujar).

## ¿Qué explicación aburrida no descarté?

Las del punto 2 y 3: no sé cuánta capacidad queda con 0 dedos ni por qué el golpe no sigue a 1/C. Antes de dibujar el lector
pequeño hay que medir la capacidad de VB en cada variante (un análisis AC, como `xc19_caps/vb_ac.sp`).
