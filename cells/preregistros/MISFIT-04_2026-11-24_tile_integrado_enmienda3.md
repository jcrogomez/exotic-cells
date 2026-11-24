# MISFIT-04 · enmienda 3 · tres pruebas nuevas tras un benchmark inválido

Escrita el 2026-11-24 a partir de las 07:35 EST (`date`), **después** de `experiments/misfit04/RESULTADOS.md` (commit 9adcaea).
Antes de escribir código o de correr nada de lo que sigue.

**No rescata nada.** El veredicto de la corrida anterior queda como está: benchmark inválido, por S7 a 5,7× (se pedían > 10×) y
por S2, que nada detectó. Esto son tres pruebas nuevas, cada una con su predicción, su control y su testigo. Ataca los tres
huecos que dejó aquella corrida.

## E1. El agresor que importa, con su celda real (la b4 del prerregistro)

- **Qué cambia.** En I4, `input2.X` e `input3.X` eran escalones ideales 0,5 ns después del cruce de su lado. Se sustituyen por la
  celda que hay en el netlist final, `sky130_fd_sc_hd__clkdlybuf4s25_1`, con la entrada en XA_OUT o XB_OUT del deck.
- **Carga de la salida.** Es la capacidad extraída de la red a tierra (sin los acoplos a XA_OUT y XB_OUT, que ya están aparte),
  más la capacidad de entrada en liberty (tt 25 °C 1,80 V) de cada pin del abanico en el netlist. Valores de la extracción plana:
  14,346 fF en `input3.X` y 5,012 fF en `input2.X`, incluidos sus acoplos.
- **Quieto frente a activo.** La instancia quieta lleva las mismas celdas con la misma carga. Lo único que cambia es que sus
  condensadores de acoplo van a un nodo de DC y no a la salida de la celda. Así se mantiene el "mismo netlist, solo cambia el
  agresor" de b6.
- **Esquinas:** las cuatro, con los umbrales de I4.
- **Control del deck:** la instancia `c` reproduce el contrato dentro de 0,01 %, como en la enmienda 2.
- **Predicción E1a:** max |Δ(tA/tB)| < umbral en las 4 esquinas.
- **Predicción E1b** (dirección de b4, "la fuente ideal es conservadora"): en cada esquina donde el escalón ideal dio un efecto
  distinto de 0 (tt, ff −40, ss 85), la celda real da un efecto **menor o igual**. Si da más en alguna, b4 era falsa y se dice.

## E2. La sensibilidad de I4 cerca de su umbral

- **Geometría.** Tres tiras S7 de m3 sobre la línea de XA, que empiezan en x = −3,0 local y miden ℓ = 4,0 µm, 8,0 µm y 21,6 µm.
  La última es la S7 de la enmienda 2. Cada una se genera con `gen_assemble.py` y se extrae en plano igual que S7. El acoplo
  C_ℓ a XA sale de la extracción, no de una regla de tres.
- **Fases.** Se barre la fase del reloj de 50 MHz solo a tt 27: 20 fases (paso de 1 ns) para ℓ = 21,6, y 10 fases (paso de
  2 ns) para ℓ = 4 y 8.
- **Control del deck:** las fases 0, 4, 8, 12 y 16 ns de ℓ = 21,6 reproducen los valores con signo de `p3.txt` (s70–s74)
  dentro de 0,001 puntos de %. Si no, el deck no vale.
- **Predicción E2a, linealidad.** El cociente entre el máximo de cada tira y el de ℓ = 21,6 queda dentro de ±30 % del cociente
  C_ℓ / C_21,6. El acoplo de 663,6 aF frente a ~149 fF en X es pequeña señal, así que la carga estática y la inyección escalan las
  dos con C.
- **Predicción E2b, testigo cerca del umbral.** Al menos una de ℓ = 4 y ℓ = 8 da un máximo entre 1× y 3× el umbral y lo
  supera. La cuenta con el 5,7× de 5 fases da ~1,1× y ~2,1×, suponiendo C ∝ ℓ. El barrido fino puede subir los dos.
- **Qué se reporta.** La pendiente de I4: % de Δ(tA/tB) por aF de reloj sobre XA, como máximo sobre la fase. Y el acoplo
  mínimo detectable, umbral / pendiente.
- **Benchmark inválido si:** falla el control del deck, o **ninguna** tira cae entre 1× y 3×. En ese caso hace falta otra
  longitud y se dice, sin ajustar después de ver.

## E3. Un chequeo que vea S2: LVS sin las tomas de sustrato del macro

- **El chequeo.** Igual que el LVS de I1, pero antes de extraer se borran, en una copia aplanada, las capas `psd` y `psc` (difusión
  y contacto de toma de sustrato) dentro de la caja del macro (tile x 0–161, y 0–128, por debajo del núcleo). Sin ellas, la tierra
  del macro solo llega a VGND por metal. Las referencias son las de b5, sin tocar.
- **Por qué no es trampa.** El chequeo no mira el sabotaje. Pregunta, para cualquier tile, si las tierras están unidas por metal.
- **Se corre sobre:** ok, S1, S2, S5, S7, S8, S9 y S10. S3, S4 y S6 ya son MISMATCH, y S9 y S10 usan su propio núcleo, como en
  I5.
- **Predicción E3a, control:** el tile sano da "match".
- **Predicción E3b, testigo:** S2 da MISMATCH, y en la extracción la tierra del macro queda como una red distinta de VGND.
- **Predicción E3c:** S7, S8, S9 y S10 dan "match"; S1 y S5 siguen en MISMATCH.
- **Benchmark inválido si:** el sano no da "match". Entonces el chequeo pierde algo más que las tomas (por ejemplo, los cuerpos
  de las nfet) y no sirve.

## Orden, presupuestos y lo que no entra

- **Orden:** E3 (minutos), E1 (4 esquinas, una corrida por esquina), E2 (tt, varias corridas de ≤ 11 instancias, de dos en dos,
  por la memoria).
- **Presupuestos.** Resolución: las tres pruebas. Auditoría, aparte: los controles de deck y el testigo S2.
- **Fuera:** ruido, Monte Carlo y caída de alimentación, que son la etapa 2 (XC-19 enmienda 2). Tampoco entra la resistencia del
  sustrato en S2 `[?]`.

Estado: **congelado** al sellar su SHA-256 en `experiments/misfit04/PREREG_SHA256.txt`.
