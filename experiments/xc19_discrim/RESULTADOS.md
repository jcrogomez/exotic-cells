# Simulador de discriminación de XC-19 · resultados: benchmark inválido

Escrito el 2026-11-23 a partir de las 18:55 EST. Prerregistro:
[`XC-19_2026-11-23_discriminacion_abanico.md`](../../cells/preregistros/XC-19_2026-11-23_discriminacion_abanico.md) y sus
enmiendas 1–3; los SHA-256 están en `PREREG_SHA256.txt`.

Corridas:
- **E_A** (autor, `run_ea.py` v2): 17:52:37 → 18:52, 3568 s. Salida en `ea.txt` y `ea.json`.
- **E_B** (agente independiente que no vio E_A, `e_b.py`): 17:56:27 → 18:01:45. Salida en `eb.txt` y `eb.json`.

Mismo generador (`sim.py`), NCHIP = 2000, fa = 1 kHz, T = 1 s. Todo es simulación de un modelo; nada aquí dice que las trampas
existan (anti-invariante, §9).

## 1. Veredicto, con las palabras del prerregistro (§10)

**Benchmark inválido.** No se emite veredicto sobre PD1–PD5, y el abanico no entra al diseño por esta corrida.

Se cumplen tres de las cuatro condiciones de invalidez de §10 (no se mira solo una):

| Condición de §10 | E_A | E_B |
|---|---|---|
| Un testigo falla | T1 pasa (detección 1,000, falsos 0,000). **T2 falla: 0,132 del techo** (umbral ≥ 0,80) | T1 pasa (1,000 / 0,000). **T2 falla con el prior de b6: 0,780** del techo (0,795 del techo con λ0 conocido). Con λ0 fijo pasa (1,000), pero D2 del prerregistro es con λ0 desconocido |
| Un mutante sobrevive | M1, M2 y M4 caen como deben. **M3 sobrevive:** sin cuantización los bits bajan, 0,0055 frente a 0,0169 de S, y debían subir | M1, M2 y M4 caen. M3: D2 sube (0,331 frente a 0,300, con IC solapados); **D1 no sube** (0,095 frente a 0,098) |
| Supera el techo + 0,02 | no | no |
| E_A y E_B difieren > 0,05 en una fila que decide | **sí, en casi todas**: D2 tt S A1 0,020 (E_A) frente a 0,270 (E_B, prior); D1 tt S 0,020 frente a 0,142 | |

## 2. Lo aburrido primero: qué falla es del instrumento, no del modelo

1. **E_A no sirve para D2.**
   - Su estadístico de chip es la mezcla de dos gaussianas sobre el histograma de y, agregada por pata. Con 16 patas y R·A fijo
     tira casi toda la información: T2 da el 13 % del techo cuando hay 10 veces más trampas.
   - Esto se vio **después** de correr. La enmienda 3 rehízo E_A para pasar T1, que es un testigo de un solo dispositivo, y nadie
     probó un testigo de chip antes de la corrida larga.
   - Hueco de método: el humo cubrió T1 y no T2.
2. **Los dos estimadores dan ~30 % de falsos positivos en D1.**
   - Explicación aburrida, medida por E_B (T1b): **el gemelo B también es un dispositivo C0 con sus propias trampas.** La lectura
     y = A − B contiene las trampas de los dos.
   - Rasgos que ignoran el signo del salto, como la varianza, la curtosis o Allan, no distinguen una trampa de A de una de B.
     Con B sin trampas, los falsos caen de 12 % a 0 %.
   - **No es un fallo del simulador: es una propiedad del diseño del slot.**
3. **El T2 de E_B se queda a 0,02 del umbral** con el prior de b6. Es un hecho, no un casi: el prerregistro fija 0,80.

## 3. Observado (exploratorio, no decide nada)

Esto no es un veredicto; queda como pista para la próxima ronda.

- **Cota inferior.** Los bits de la matriz de confusión en chips no vistos son una cota inferior de I(H; Y), por la desigualdad de
  procesamiento de datos. Las filas de E_B son cotas inferiores válidas aunque el benchmark sea inválido como prueba de
  predicciones.
- **D2 de E_B** a tt, variante S, λ0 fijo, en bits por µm² con el área por pata de `run_ea.py`:

  | Clase | Bits | Área por pata | Bits por µm² |
  |---|---|---|---|
  | A1 | 0,587 | 96,6 µm² | 6,1 mbit/µm² |
  | A2 | 0,333 | 53,9 µm² | 6,2 mbit/µm² |
  | **A4 (0,42/0,60)** | **0,516** | **27,1 µm²** | **19,0 mbit/µm²** |
  | A8 | 0,163 | 17,1 µm² | 9,5 mbit/µm² |

  Si se confirma, **PD5 sería falsa**: gana el dispositivo largo, no la réplica mínima. Por qué: el coste fijo por pata (el
  interruptor y los márgenes) domina con área mínima. Es conjetura hasta una corrida válida.
- **Lección de diseño que no depende del estimador.** El gemelo de referencia lleva trampas propias. Para atribuir un salto a A o a
  B hace falta su signo, o una referencia que no sea un dispositivo del mismo tipo (por ejemplo, la descarga de referencia E2
  como B).

## 4. Qué sigue (sin correr)

Enmienda 4, antes de cualquier corrida nueva:
1. Estadístico de chip para E_A: verosimilitud de Poisson sobre conteos de saltos por pata.
2. Rasgos con signo en E_B.
3. **Testigo T2 en el humo**, y no solo T1.
4. Una variante de diseño con B = referencia E2 en vez de gemelo, para medir cuánto de los falsos positivos es del gemelo.
5. Semillas nuevas, distintas de estas. Esta corrida queda como exploración.

**¿Qué explicación aburrida no descarté?** Que el área por pata de `run_ea.py`, (W + 1,2)(L + 1,5) más el interruptor, no sea el
área real dibujada. Eso decide el ranking de bits por µm², y sale del layout del abanico, que aún no existe.
