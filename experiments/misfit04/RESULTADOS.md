# MISFIT-04 · etapa 1 · resultados: tile sano limpio, benchmark inválido en dos puntos

Escrito el 2026-11-24 a partir de las 00:30 EST (`date`). Prerregistro:
[`MISFIT-04_2026-11-23_tile_integrado.md`](../../cells/preregistros/MISFIT-04_2026-11-23_tile_integrado.md) y sus enmiendas 1 y 2.
Los SHA-256 están en `PREREG_SHA256.txt`; las tres se commitearon antes que este archivo. Todo es simulación y extracción.
Nada de esto es silicio.

## 1. Veredictos, con las palabras del prerregistro

| # | Veredicto | Número | Archivo |
|---|---|---|---|
| I1 | **cumplida** (al segundo intento del precheck, ver §3) | DRC 0, LVS "match uniquely", precheck 15/15 | `i1/` |
| I2 | **cumplida** (I2a e I2b, enmienda 1) | 0 discrepancias en 9/9 alcanzables y en 16/16 del módulo | `i2/` |
| I3 | **cumplida** | 0 cambios en las 13 líneas del decodificador, en las tres ventanas (src 01, 10, 11) | `i3/i3.txt` |
| I4, tile sano | **cumplida**, sin veredicto formal: el benchmark de I4 es inválido en lectura estricta (§2) | máx Δ(tA/tB) 0,01288 % (tt 27), 0,01352 % (ff −40), 0,01354 % (ss 85), 0 (ff 85) | `i4/i4.txt` |
| I4, mi apuesta "margen ≥ 10×" | **falsa** | margen 6×, 7×, 5× e ∞ | `i4/i4.txt` |
| I5, estándar en S1–S5 (5/5) | **falsa: 4/5**. S2 pasa DRC, LVS y precheck | | `i5/estandar.tsv` |
| I5, estándar en S7–S10 (0/4) | **cumplida: 0/4** | | `i5/estandar.tsv` |
| I5, medida en S7–S10 (4/4) | **cumplida: 4/4** | S7 por I4 (5,7×), S8 por I4 (5,0×), S9 por I2 (4 discrepancias), S10 por I3 (8388 cambios) | `i4/`, `i5/medida_*` |
| Muere si I4 falla en sano a tt 27 | **no se cumple** | | |

## 2. Benchmark inválido: por qué, en dos puntos

1. **El testigo S7 no llega a su tamaño.**
   - §6 exige que S7 dé > 10× el umbral de I4 a tt. Da **5,7×** (0,46176 % frente a 0,0807 %). A ff 85 da 7,1×.
   - El prerregistro se contradice. §6 dice "si S7 no supera el umbral, I4 es ciego". §7 pone como condición de invalidez que "S7
     no se detecta". S7 sí se detecta: es 5,7 veces el umbral.
   - No elijo la lectura favorable. **Lo demostrado:** I4 ve un reloj acoplado con 663,6 aF a XA. **Lo no demostrado:** que I4
     vea un agresor diez veces más débil, cerca de su propio umbral. Eso es lo que el requisito de 10× pretendía asegurar.
   - `analiza_i4.py` aplica §6 al pie de la letra e imprime "I4 CIEGO: benchmark invalido". Lo dejo tal cual.
2. **S2 no lo detecta nada.** §7 pone como condición de invalidez que algún sabotaje de S1–S5 no lo detecte nada. S2 (la tira
   de VGND del macro sin unir) pasa DRC, LVS y precheck. No hay chequeo de medida que corra sobre S2, y la extracción tampoco lo ve
   (§4.1).

Lo que **no** invalida: los controles de deck de I4 valen en las cuatro esquinas (c frente al contrato: 0,0000 / 0,0002 / 0,0000
/ 0,0004 %, límite 0,01 %), y b1 queda resuelto con la extracción plana.

## 3. Lo aburrido primero

1. **El efecto de I4 en el tile sano es un solo flanco, no el reloj del núcleo.**
   - Ablación a tt 27, un agresor por corrida, fase 0:

     | Agresor | Efecto |
     |---|---|
     | `_0685_.Y` (174 cambios, 6,92 aF a XB_OUT) | 0,00000 % |
     | `input2.X` | 0,00000 % |
     | `input3.X` (búfer de xb, 61,4 aF a XA_OUT) | **0,01288 %**, el total |

   - Mecanismo: en SPICE **B cruza antes que A**, 4,1 ns antes a tt (tA 28,9582 µs, tB 28,9541 µs en la corrida quieta). El flanco
     de `input3.X` llega 0,5 ns después del cruce de B, así que cae antes del de A y empuja XA_OUT.
   - A ff 85 la diferencia es de 0,3 ns: el flanco cae después de los dos cruces y el efecto es 0. Eso explica la columna ∞.
   - Por eso las fases k = 0–3 dan lo mismo: el agresor que importa no depende de la fase del reloj. La fase 4 da 0,01073 %
     `[?]`: no está atribuido.
   - **Corrección a la enmienda 2, A3.4.** Allí se escribió que "XA cruza unos 17 ns antes". Ese dato es de la simulación de
     puertas con retardo unitario de I3, donde xa y xb llegan del modelo del banco y no de la física. En la SPICE el orden es el
     contrario. La enmienda no se edita.
2. **El S7 es casi todo carga estática más reloj, y el signo depende de la fase.** Δ(tA/tB) con signo a tt 27, frente al sano
   quieto:

   | Fase | s70 | s71 | s72 | s73 | s74 | S8 (placa pasiva, 843 aF) |
   |---|---|---|---|---|---|---|
   | Δ | −0,00393 % | +0,06438 % | −0,12268 % | **−0,46176 %** | −0,36519 % | +0,40704 % |

   - La placa pasiva frena a A y sube tA/tB. El reloj, según dónde caiga respecto al cruce, cancela esa carga (s70) o la supera
     con el signo contrario (s73).
   - Con 5 fases el máximo real sobre la fase continua es ≥ 5,7×. Puede ser mayor. **No lo uso para rescatar el testigo:**
     sería decidir el método después de ver el número.

## 4. Observado (no decide nada)

1. **Punto ciego de la extracción por sustrato (S2).**
   - Las nfet del macro llevan tomas de sustrato a su GND. El tile también toca el sustrato con su VGND.
   - Magic funde las dos redes a través del sustrato. Con la tira cortada, el LVS sigue dando "match".
   - En silicio la unión existe, pero pasa por la resistencia del sustrato. Si eso importa a la medida es `[?]`: Magic no extrae
     esa resistencia.
   - **Para llenar el chip:** el corte de una tira de tierra de un macro con tomas propias es invisible a DRC, LVS y precheck. Hace
     falta otro chequeo, por ejemplo un LVS con las tomas del macro separadas, o una extracción sin fundir el sustrato.
2. **Margen real del tile sano.** El 0,0129 % es el 16 % del umbral a tt y lo pone un solo búfer (`input3`) al lado de XA_OUT.
   En la ablación (fase 0) los otros dos agresores dan 0 a la resolución de la corrida. Es conjetura que separar `input3.X` de
   XA_OUT deje el tile en 0: no se corrió.
3. **A2 de la enmienda 1 (deriva de X en reposo armado): no medida.** I3 es lógica de puertas y no ve la deriva. Queda para la
   SPICE de la etapa 2, con fugas `[?]`.

## 5. Desviaciones, todas declaradas

| Qué | Dónde se declaró |
|---|---|
| El precheck falló en el primer intento (pines de alimentación a 127,4 µm > 10 µm del borde inferior). Se arregló antes de I1 | enmienda 2, A3.1; `i1/README.md` |
| S7 es una tira **flotante**; su reloj se aplica en SPICE a través del acoplo extraído | enmienda 2, A4 |
| S6, tal como se generó (`sideways`), es un fallo de conectividad y no de simetría | enmienda 2, A5 |
| S10 con un biestable que conmuta (k) en lugar de un contador de 10 bits. La versión k[9] no se endureció (DPL-0036) | aquí; `local_flow/misfit04_core_S10/` |
| S5 en el primer intento era solo m1 y no tocaba la línea de XA, que es m2. Su testigo (XA fundida con GND) lo atrapó. Segundo intento con via1 y pad de m2: XA queda fundida con VGND y el LVS da MISMATCH | `i5/estandar.tsv`, filas 6 y 10 |
| S7 y S8 en el primer intento violaban met3.2 contra la pista DUTA (x 19,16). Se recortaron a x = 18,6 local. Las filas 8 y 9 de `estandar.tsv` son de esa versión y no cuentan | `gen_assemble.py` |
| **I3: error de conteo.** `cuenta.py` buscaba las redes sin el prefijo `dut.` y contaba 0 sin mirar nada. El "0 cambios" de la enmienda 2, A3.2, estaba **vacío** cuando se escribió. Arreglado con un assert que exige cada línea en el VCD. El recuento bueno también da 0, y el mismo script da 8388 en S10 | `i3/cuenta.py` |
| Pasada 3 de I4: la primera corrida murió por memoria (OOM) en tres esquinas. En ff −40 dio "timestep too small": meas devolvía formas de onda y el parser las leía como 0. Arreglo: guardar solo las salidas medidas, resistencia de la placa S8 a 1 TΩ y dos esquinas a la vez. Se reportan solo las corridas completas (44 líneas RES) | `i4/p3.txt` |

## 6. Qué sigue

- Para que I4 valga: un testigo nuevo que se pueda identificar cerca del umbral. Por ejemplo, el mismo S7 con la tira más corta
  hasta dar ~1–2× el umbral, más un barrido fino de fase **prerregistrado** (enmienda 3). Así se mide la sensibilidad de I4 donde
  importa, que era la intención de los 10×.
- Para S2: definir un chequeo que lo vea (§4.1) y meterlo en la campaña.
- Etapa 2 (ruido, Monte Carlo, caída de alimentación) sobre este mismo tile, en el orden de Juan.

**¿Qué explicación aburrida no descarté?** Que el efecto de `input3.X` dependa de los 0,5 ns que elegí en A4 para su flanco
después del cruce de B. Con el retardo real del búfer, el flanco podría caer después del cruce de A también a tt, y el efecto sería
0. O podría caer antes y crecer. No corrí la celda real (b4).
