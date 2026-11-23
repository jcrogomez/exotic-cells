# MISFIT-03 · etapa a · informe

Escrito el 2026-11-23 a partir de las 18:06 EST (`date`). Prerregistro:
[`MISFIT-03_2026-11-23_slot_xc19.md`](../../cells/preregistros/MISFIT-03_2026-11-23_slot_xc19.md) y su
[enmienda 1](../../cells/preregistros/MISFIT-03_2026-11-23_slot_xc19_enmienda1.md); los SHA-256 están en `PREREG_SHA256.txt`.

Todo es modelo: ngspice 44.2 en modo hsa, sky130A `8afc8346`, macro extraído por Magic con LOD anotado por Residual. No hay
silicio. Veredictos generados por [`analiza_contrato.py`](analiza_contrato.py) → [`contrato_analisis.txt`](contrato_analisis.txt),
a partir de [`contrato.txt`](contrato.txt). Los decks salen de [`gen_contrato.py`](gen_contrato.py) y corren en `corridas/`.

## 0. Lo aburrido primero: fallos del arnés, corregidos antes de cualquier veredicto

1. **Corridas que no arrancaron.** Siete de las 8 primeras corridas no empezaron: `ngspice_pdk.sh` admite una corrida por
   carpeta. Ahora cada deck corre en su propia carpeta.
2. **Medida mal escrita.** `meas … find … at=` falla con "out of interval"; se sustituyó por un promedio justo antes del flanco.
3. **Parser engañado.** Cuando un `meas when` no encuentra cruce, ngspice sustituye `$&nombre` por la forma de onda del nodo
   homónimo, y el primer parser leyó su primer valor como si fuera un tiempo. Salían "cruces" de −0,67 µs y de 1 799 999 µs. El
   parser trata ahora esa forma como "sin cruce". Las únicas medidas fallidas son ausencias de cruce esperadas: F3, F4, F6 y
   `src = 00`.
4. **`annotate.py` rompía la cabecera.** Insertaba los condensadores dentro de una cabecera `.subckt` continuada con `+`. Este
   macro tiene cabecera de dos líneas y se corrigió en su copia; `xc19_channel_caps` tiene una sola línea y no se ve afectado.
5. **La instancia `e0` no avanza en ff −40 ni en ss 85.** Es `en = 0` con las entradas moviéndose, y se atasca ni con
   `gmin = 1e-15`. Allí la corriente estática se midió por `.op` (`corridas/diag_en0/p2op_*`). A tt, `.op` y transitorio coinciden:
   2,7142 nA en los dos.

**Control del banco de pruebas.** El canal viejo, `xc19_channel_caps_lod`, corrido dentro del deck nuevo, da 30,86 µs desde que
se suelta la precarga (`corridas/diag_p3/diag_p3b.sp`). El deck viejo `post.sp` daba 30,96 µs medidos desde t = 0, con la precarga
soltada a 0,1 µs: el mismo número. Además, `post.sp` se reproduce cifra a cifra con la cadena actual (30,9606 µs). **Benchmark
válido.** Lo que no se construyó es el "macro nuevo reducido a sus piezas viejas"; en su lugar está esta comparación directa.

## 1. Veredictos

| # | Predicción (palabras del prerregistro) | Resultado | Veredicto |
|---|---|---|---|
| P1 | DRC 0 en Magic y en los dos decks de KLayout; LVS "match uniquely" | 0 / 0 / 0; "Circuits match uniquely" | **cumplida** |
| P2 | `en = 0`: corriente estática < 1 nA a tt 27 y < 50 nA a ff 85; `xa = xb = 0` | 2,714 nA a tt; 305,9 nA a ff 85; `xa` ≤ 139 µV | **falsa** |
| P3 | tA de 30,96 a 33,4 µs a tt | 27,943 µs | **falsa** (causa en §2) |
| P4 | paso de unidad entre 0,25 y 0,60 % a tt; ≥ 0,15 % en las 4 esquinas | 0,1745 % a tt; 0,1642 / 0,1824 / 0,1294 % en ff −40 / ss 85 / ff 85 | **falsa** a tt y en ff 85; cumplida en ff −40 y ss 85 |
| K2 | muere si P4 < 0,10 % en alguna esquina | mínimo 0,129 % | **no muere** |
| P5′ | abs(tA/tB − 1) ≤ 0,15 % en `src = 11` | 0,011–0,013 % | **cumplida** (4/4) |
| P6 | trampa ≥ 10 cuentas en tt, ss 85 y ff −40; < 2 en ff 85 | 11,28 / 9,59 / 21,09; 0,72 | **falsa en ss 85** (9,59); cumplida en las demás, incluido el fallo esperado en ff 85 |
| P6′ | paso ≥ 5 cuentas en tt y ff −40; < 1 en ff 85 | 2,53 / 6,20; 0,17 (ss 85: 1,85) | **falsa a tt**; cumplida en ff −40 y ff 85 |
| P7 | A/B se mueve < 0,01 % con ±10 mV | 0,0002–0,0006 % | **cumplida** (4/4) |

**Fallos inyectados:** los siete se detectan, y ninguno cae dentro de la banda sana (mutante del criterio: no hay fallo invisible).

| Fallo | Cómo se ve |
|---|---|
| F1 | paso de 0,002–0,012 % |
| F2 | A se desplaza 0,59–0,80 % |
| F3 | `stuck` |
| F4 | `stuck` |
| F5 | VB queda en 0,42–0,50 V y aparecen 20–387 nA por VBIAS/C1. La corriente del propio macro no cambia: F5 solo se ve en la corriente total del tile |
| F6 | `timeout`; también `src = 00` da `timeout` en 1,4 ms, con X que solo baja a 1,71 V a 85 °C |
| F7 | tA/tB = 0,36–0,58 |

**Criterio "sigue":** **no se cumple**, porque fallan P2, P4 a tt y P6 en ss 85.

## 2. Por qué falla cada una (lo aburrido primero)

- **P2.** La corriente sale toda de los dos pfet 1,0/0,15 de los inversores de salida, apagados con X alto: 1,356 nA cada uno a
  tt (`corridas/diag_en0/diag.sp`). La precarga aporta 19 fA y el decodificador 9 pA. Arreglo candidato: pfet hvt o dos pfet en
  serie en el inversor. Hay que comprobar la condición de muerte del macro: hacer el slot inerte sin cambiar la lectura de
  `src = 01` más de un 1 %. Eso es una enmienda y una nueva corrida, no una edición.
- **P3.** No es el macro, es el comparador.
  - A la misma tensión de X (0,9 V), el macro tarda 27,75 µs y el canal viejo 26,03 µs: el nuevo es un 6,6 % más lento,
    coherente con su capacidad, 149 fF frente a 139 fF en pequeña señal. La corriente es la misma, 5,015 nA a X = 1,35 V
    (`corridas/diag_p3/`).
  - Los 30,96 µs que anclaban P3 eran el tiempo de un `inv_1` de la biblioteca, que conmuta con X bastante más bajo: su salida
    cruza 4,8 µs después de que X pase 0,9 V. El inversor del macro conmuta con X = 0,896 V.
  - La banda de P3 estaba atada al comparador equivocado. El error es del prerregistro, y se deja así.
- **P4 y P6′ a tt.** El paso medido, 0,17 %, es la mitad de lo que daría la placa sola: u(S2) − u(S0) = 0,51 fF sobre 149 fF
  = 0,34 %. Lo que sí es dato es que el diseño de 0,411 % usaba u = 0,6 fF y un nodo sin parásitos.
  - Conjetura, no comprobada: con S2 abierto (`src = 11`), su placa flota acoplada a X y a la placa de S1 (0,115 fF, en la
    extracción), y una parte de la unidad ya está en el nodo en los dos estados.
  - Rediseño que se prueba en la enmienda 2: placa mayor y separada de S1.
- **P6 en ss 85.** 9,59 cuentas frente a ≥ 10. Es el macro más rápido de lo previsto (P3): menos cuentas para el mismo salto
  relativo, 0,684 %. El salto relativo no cambia; lo que cambia es el tiempo total.

## 3. Qué queda demostrado (en el modelo)

- El macro dibujado es limpio (DRC y LVS) y simétrico: A/B = 1 ± 0,013 % sin desajuste.
- Rechaza la alimentación en cociente (P7) y detecta los siete fallos inyectados.
- `src = 10` da un paso diferencial de 0,13–0,18 % por encima del criterio de muerte (0,10 %).

## 4. Qué no se demostró

- Que el slot sea inerte con `en = 0` (P2).
- Que la calibración tenga el tamaño previsto (P4 a tt).
- La parte transitoria de P2 en ff −40 y ss 85, que no corrió.
- El precheck: según E10 queda **pendiente para MISFIT-04, no pasado**.
- Además, el simulador de discriminación (ver
  [`xc19_discrim`](../xc19_discrim/)) dedujo que un slot con un solo DUT no ve trampa el 70 % de las veces. El slot pasa a un
  abanico de DUT con réplicas.

## 5. Siguiente paso, sin correr

Enmienda 2 de MISFIT-03, escrita antes de tocar el dibujo:
- inversor con pfet hvt (P2);
- placa mayor y aislada de S1 (P4);
- P3 reanclado al comparador propio.

Después, el abanico de DUT según el veredicto del simulador de discriminación.

**¿Qué explicación aburrida no descarté?** Que la extracción de Magic, sin capacidades laterales finas a menos de unas µm (`[?]`
heredado de `xc19_caps`), esté contando mal el acoplo entre placas. Eso decide P4.
