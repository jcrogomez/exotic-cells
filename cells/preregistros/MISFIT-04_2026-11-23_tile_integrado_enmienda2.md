# MISFIT-04 · enmienda 2 · cómo corren I4 e I5, y qué se vio antes de escribirla

Escrita el 2026-11-23 a partir de las 21:23 EST (`date`). Antes de correr la SPICE de I4 y antes de la campaña I5. No cambia
ninguna predicción ni ningún umbral del prerregistro (SHA `c7a0eca8…bb51`) ni de la enmienda 1.

## A3. Observado antes de escribir esto (no son veredictos de I4)

1. **I1 en el primer intento.** El precheck falló en la prueba de pines: los pines de alimentación tienen que llegar a menos de
   10 µm del borde inferior, y las tiras se cortaban a 127,4 µm. Arreglo: dos tiras del núcleo (x = 96,02 y 99,32) recorren toda la
   altura fuera de la columna del slot. Las que alimentan el macro siguen cortadas sobre él. Con eso, precheck 15/15
   (`experiments/misfit04/i1/`).
2. **I3** corrió sobre el netlist final, con una adquisición por cada `src` (01, 10, 11): **0 cambios** en las 13 líneas del
   decodificador dentro de la ventana (`i3/i3.txt`).
3. **b1.** XA y XB coinciden entre la extracción plana y la jerárquica (0,40 y 0,29 %). XA_OUT y XB_OUT no (6,52 y 5,60 %). Como
   dice el prerregistro, **se usa la extracción plana**; no invalida.
4. **Lista de agresores** (acoplo de la extracción plana cruzado con el VCD de I3, `i4/acoplo.txt`). Ninguna red de reloj tiene
   ≥ 1 aF a un nodo medido. Las únicas redes con ≥ 1 aF que cambian dentro de la ventana son:

   | Red | Nodo medido | Acoplo | Cambios en la ventana |
   |---|---|---|---|
   | `_0685_.Y` | XB_OUT | 6,92 aF | 174 |
   | `input3.X` (búfer de xb) | XA_OUT | 61,4 aF | 1 |
   | `input3.X` | XB_OUT | 55,9 aF | 1 |
   | `input2.X` (búfer de xa) | XA_OUT | 4,1 aF | 1 |
   | XA_OUT ↔ XA, XB_OUT ↔ XB | — | ~34 aF | 1, la propia salida |

   Los búferes `input2`/`input3` cambian **después** del cruce de su propio lado. `input3.X` cambia después del cruce de B, y XA
   cruza unos 17 ns antes.

## A4. I4, cómo se corre

- **Deck.** El de temporización de MISFIT-03 (`gen_contrato.py`: macro extraído con LOD y decodificador en celdas), con la
  instancia `h01` (`src = 01`). Se le añaden, como condensadores, todos los acoplos de A3.4 entre una red del núcleo y XA, XB,
  XA_OUT o XB_OUT. También el acoplo XA–XB (23,4 aF), que es simétrico y está en los dos casos.
- **Fuentes.** Cada agresor es una fuente ideal con la forma de onda del VCD de I3 relativa a la suelta de la precarga (b4:
  conservador), con flancos de 100 ps. Los que dependen de xa/xb (`input2.X`, `input3.X`) se modelan como un flanco 0,5 ns
  después del cruce de su lado, medido en la misma corrida (dos pasadas: la segunda usa los cruces de la primera).
- **Medida.** Igual que en el prerregistro: el mismo netlist con agresores **activos** frente a **quietos** (fuente a DC en su
  valor inicial). Δ(tA/tB) es el máximo sobre 5 fases: la forma de onda desplazada k · 4 ns, k = 0…4, en un ciclo de 20 ns. Las 4
  esquinas, con los umbrales del prerregistro.
- **Paso de tiempo.** `tran 10n 80u` no resuelve 100 ps. Se usa un paso máximo de 50 ps en la ventana del cruce, ±200 ns
  alrededor del tiempo de la corrida quieta, y `reltol = 1e-5` como en el contrato. **Control del deck:** la corrida quieta debe
  reproducir el tA de `contrato.txt` (27,943 µs a tt) dentro de 0,01 %. Si no, el deck no vale.
- **Testigo S7.** Se extrae el tile S7: una tira de m3 sobre la línea de XA, local x −3,0…19,0, y −1,62…−1,32. Su acoplo a XA se
  conduce con un reloj ideal de 50 MHz y flancos de 100 ps. **Desviación declarada:** la tira no se conecta físicamente a `clk`
  en el layout, porque haría falta una ruta a través del núcleo. Para DRC, LVS y precheck, una pista añadida a una red existente
  no cambia la conectividad de dispositivos, así que la tira flotante es la geometría que esos chequeos ven. Lo que sí cambia es
  que S7 deja de ser idéntico a S8 solo por la fuente; se dice así.
- **S8.** La placa flotante no es un agresor activo. Se detecta si el tA/tB del tile S8, con la capacidad de la placa extraída
  sobre XA, se separa del sano más que el umbral de I4. Es la única fila de I4 que compara dos netlists, y se marca.

## A5. I5, cómo se genera cada sabotaje y qué cuenta como detectado

- **Chequeos estándar** = Magic `drc(full)` sobre el GDS releído + LVS contra `top_ref.v` y `ref.spice`, fijos (b5) + precheck
  de Tiny Tapeout. Para S9 y S10 la referencia del núcleo es el netlist de **su propio** endurecimiento: así funciona un flujo
  real, y es la tautología t1. Se corre igual, para medirlo y no suponerlo.
- **Chequeos de medida** = I2 (sobre el netlist final del mutante), I3 (ídem), I4 (S7, S8).
- **Cómo se genera cada uno:**

  | # | Generación |
  |---|---|
  | S1, S2 | `gen_assemble.py` sin el tramo de m4 de VDD o de GND del macro |
  | S3 | `gen_wrap.py S3`: falta el tramo de m2 que entra en el pin SA1B del núcleo, y la pista de m3 sigue. DRC del wrapper 0 |
  | S4 | `gen_wrap.py S4`: XA sube hasta y = 7 y cruza en m2 a la columna de XB. XB baja a m1 en y = 5,5, cruza y sube por x = −10,0 hasta la columna de XA. DRC del wrapper 0 |
  | S5 | rectángulo de m1 de la línea de XA al bus de GND. **Testigo del sabotaje:** la extracción del mutante debe fundir XA con GND. Si no lo hace, S5 no es un sabotaje y no cuenta como "no detectado" |
  | S6 | el wrapper entero con `sideways`. **Así implementado no es un sabotaje de simetría:** los pines dejan de caer bajo el núcleo, y es un fallo de conectividad. La versión de simetría pura (A en el sitio de B con la misma conexión) queda fuera `[?]`. S6 sigue sin predicción |
  | S7, S8 | `gen_assemble.py`, la geometría de A4 |
  | S9 | `e7_decoder.v` con SA2B = ~(en & s1 & s0), endurecido de nuevo |
  | S10 | `misfit04_core.v`: src[0] del decodificador XOR k[9] (contador libre de 10 bits) mientras `busy & slot_en & ~slot_pre`; endurecido de nuevo |

- Los veredictos de I5 se cuentan por clase, en las palabras del prerregistro: estándar 5/5 en S1–S5 y 0/4 en S7–S10; medida
  4/4 en S7–S10.
