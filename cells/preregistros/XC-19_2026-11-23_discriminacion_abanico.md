# XC-19 · simulador de discriminación con RTN y abanico de configuraciones · prerregistro

Escrito el 2026-11-23 desde las 17:45 EST (`date`), a pedido de Juan ("mete el abanico de configuraciones al prerregistro, estamos
diseñando en serio"). Sin código del simulador escrito. La hora de congelado es la de su SHA-256 en
`experiments/xc19_discrim/PREREG_SHA256.txt`. Todo es modelo; no hay silicio. Las enmiendas van en un archivo nuevo.

Cálculo previo, que no es evidencia: [`prereg_calc.py`](../../experiments/xc19_discrim/prereg_calc.py) →
[`prereg_calc.txt`](../../experiments/xc19_discrim/prereg_calc.txt) (17:44), con dos entradas:
- el macro extraído de MISFIT-03, en `experiments/xc19_slot/contrato_temporizacion.txt` (17:05–17:35; sus veredictos van aparte);
- el ruido de puerta del DUT según el modelo del PDK, en [`calc_ruido/`](../../experiments/xc19_discrim/calc_ruido/) (`integra.txt`, 17:27).

## 1. Pregunta

¿Cuánto aprende el slot XC-19, leído por su lector real, sobre las trampas que deja la fabricación? La medida es en bits, por
configuración del DUT y por µm². ¿Qué abanico de configuraciones y réplicas conviene dibujar en un slot para convertir "no vimos
nada" en un resultado informativo?

## 2. Lo que ya sé y qué se deduce (tautología declarada, `prereg_calc.txt`)

- **Contra ruido blanco, detectar el salto es trivial a tt.** En el macro extraído, una trampa del DUT mínimo son 11,3 cuentas;
  el ruido de disparo por conversión, 1,5 cuentas: 7,5 σ en una conversión. A ff −40 son 21,1 cuentas y a ss 85, 9,6.
- **ff 85 está limitado por la cuantización, no por el ruido.** Una trampa son 0,72 cuentas y el ruido de disparo 0,12, así que
  la cuantización no se promedia. Como `pre` es síncrono con el reloj, la lectura es determinista salvo en el borde de una cuenta.
- **El 1/f del modelo, leído como trampas (McWhorter), da menos de una trampa en banda en el DUT mínimo.**
  - Supuesto: amplitudes exponenciales de media η·q/(C_ox·W·L), con q/(C_ox·W·L) = 0,306 mV.
  - tt 27, 1 kHz durante 1 s: N = 0,36 (η = 1) o 0,09 (η = 2). En el resto de esquinas y bandas, 0,28–0,89 (η = 1).
  - Por tanto P(≥ 1 trampa en banda) = 0,30 (η = 1). **Un slot de un solo DUT no ve ninguna trampa el 70 % de las veces**,
    aunque la física sea la del modelo. Esto es una deducción, no un experimento: el diseño de un DUT único queda descartado
    como el experimento XC-19, y el abanico con réplicas pasa a ser necesario.
  - A ese tamaño, "1/f gaussiano continuo" no es una hipótesis física. La pregunta es 0, 1 o 2 trampas por dispositivo.
- **Techo de Poisson** para distinguir una densidad ×3 de una ×1, contando sin error las trampas en banda. Depende solo de R·A
  (réplicas × área relativa): 0,12 bits con R·A = 1, 0,40 con 4, 0,85 con 16, 1,00 con 64.
  - El instrumento no puede superar el techo; decide qué fracción alcanza.
  - El área grande diluye el salto (1/A): A = 8 da 1,4 cuentas a tt frente a 1,5 de disparo.

## 3. Explicaciones aburridas y su chequeo

| # | Aburrida | Chequeo |
|---|---|---|
| b1 | El simulador mide su propio estimador y no el instrumento | dos estimadores independientes (§6); ambos ≤ techo de Poisson + 0,02 bits |
| b2 | "Bits" que vienen de etiquetas filtradas a las variables (fuga de datos) | mutante M2, etiquetas barajadas → ≤ 0,02 bits; validación en chips simulados no vistos |
| b3 | El 1/f del PDK no es de número de portadores (Hooge, movilidad), y el modelo de trampas exagera los saltos | η = 1 y η = 2 en todas las filas; resultado reportado por separado; la parte de movilidad queda como franja no atribuida (§8) |
| b4 | La cuantización o el sincronizador no están cableados | mutante M3: sin cuantización a ff 85, los bits tienen que subir |
| b5 | El gemelo B y la polarización común se cancelan en el simulador por construcción, no por el instrumento | la polarización común entra con un desajuste de sensibilidad A/B del 5 %; el gemelo tiene sus propias trampas |
| b6 | La densidad de trampas que alimenta las configuraciones decide el resultado | λ0 con prior log-uniforme en [λ_PDK/10, 10·λ_PDK]; el factor de configuración f es la incógnita que se estima, nunca un dato |

## 4. El abanico (lo que se dibujaría en el slot)

Cada pata lleva un DUT con su propio interruptor de fuente 0,84/0,15 hacia X, el mismo esquema ya dibujado en `xc19_slot_core`.
Se leen de una en una contra el gemelo B.

| Clase | Configuración | Área relativa A | Qué ataca de la fabricación |
|---|---|---|---|
| C0 | 0,42/0,15, sa = sb = 0,30 (el DUT actual) | 1 | referencia: fija λ0 en el mismo chip |
| C1 | 0,42/0,15, sa = sb mínimos | 1 | estrés de STI y LOD |
| C2 | 0,42/0,15, sa = sb = 1,0 | 1 | el otro extremo de LOD |
| C3 | puerta que cruza una esquina de STI (difusión en L) | 1 | campo y defectos de esquina |
| C4 | poly vecino a la distancia mínima (densa frente a aislada) | 1 | proximidad y residuo de OPC (XC-62) |
| C5 | antena grande de metal en la puerta, dentro de lo que acepte el precheck (`precheck_map`) | 1 | daño de plasma escrito por la fábrica (XC-14) |
| C6 | unión p+/n+ a tope junto al canal | 1 | defectos de la unión (XC-20) |
| C7 | 0,84/0,15 | 2 | escala de área |
| C8 | 0,42/0,60 | 4 | escala de área a lo largo |
| C9 | 1,68/0,30 | 8 | escala de área |

**El modelo no tiene física de trampas por geometría.** En el simulador cada configuración k es solo su área A_k más un factor
desconocido f_k sobre la densidad de C0. El simulador no predice f_k: mide cuántos bits sobre f_k entrega el instrumento. Dibujar
C1–C6 se decide por esos bits; lo que la geometría hace de verdad lo dirá el silicio.

## 5. Modelo del simulador (fijado ahora)

- **Por lectura:** t_A = t_c·(1 + s_c·ΔV_A/0,305 mV)·(1 + ε_A). Igual para B con su propio DUT, del tipo C0.
  - t_c y s_c: macro extraído, por esquina.
  - ε: ruido de disparo gaussiano de 0,108 % por lado.
- **ΔV = Σ a_i·x_i(t)**, una suma de telegramas:
  - amplitud a_i exponencial de media η·q/(C_ox·W·L);
  - τ log-uniforme en [1 µs, 10⁴ s];
  - ocupación p = 1/2;
  - número de trampas Poisson con media f_k·A_k·λ0 por década;
  - una trampa más rápida que la conversión entra promediada sobre la conversión.
- **Polarización común:** 0,1 mV rms blanca por conversión, con un desajuste de sensibilidad A/B del 5 %.
- **Contador:** cuenta = ⌊t·50 MHz + φ⌋ + 2.
  - Variante S (síncrona, la de hoy): φ fijo.
  - Variante D (dither): φ uniforme por conversión. Es la propuesta de diseño que se evalúa.
- **Adquisición:** lectura dual A y B en la misma ventana; fa ∈ {1 kHz, 10 kHz}; T ∈ {1 s, 100 s} por pata.
- **Esquinas:** las 4 del macro extraído. Chips simulados: ≥ 2000 por celda de la tabla, con IC por bootstrap.

## 6. Qué se estima, y con qué

- **D1, detección por dispositivo:** "≥ 1 trampa discreta en banda" frente a "ninguna".
- **D2, configuración:** f_k = 3 frente a f_k = 1, con λ0 desconocido y estimado a la vez desde las patas C0 del mismo chip.
  - Presupuesto de un slot: R·A = 16 unidades por clase, repartidas como (A, R) = (1, 16), (2, 8), (4, 4) y (8, 2).
- **D3, forma:** dos niveles frente a gaussiano de igual varianza, en A = 8. Exploratorio, sin predicción binaria.
- **Estimador E_A (autor):** detector de niveles con histéresis sobre la serie de cuentas A − B, seguido de una verosimilitud de
  Poisson para f. Los bits se calculan de la matriz de confusión en chips no vistos.
- **Estimador E_B (independiente, escrito por un agente sin ver E_A):** regresión logística validada en chips no vistos. Usa
  resúmenes de la serie: varianza, curtosis, desviación de Allan en 3 tiempos y número de cruces de nivel.
- **Regla de consolidación** (lección de XC-20, ronda 3): una fila que decide cuenta solo si se cumplen las dos condiciones:
  - |E_A − E_B| ≤ 0,05 bits;
  - ambos ≤ techo + 0,02.

  Si no, se reporta el desacuerdo y la fila no decide.

## 7. Predicciones

Todas con η = 1, salvo que se diga otra cosa; con η = 2 se reporta sin predicción binaria.

| # | Predicción | De dónde |
|---|---|---|
| PD1 | tt 27, ss 85 y ff −40, C0, variante S: E_A detecta ≥ 85 % de los dispositivos con al menos una trampa en banda de permanencia ≥ 10 conversiones, con ≤ 2 % de falsos positivos en dispositivos sin trampa | 7,5 σ por conversión (§2) |
| PD2 | ff 85, variante S: esa detección queda ≤ 75 %; con la variante D, ≥ 85 % | 0,72 cuentas sin dither (§2) |
| PD3 | tt 27, D2, variante S: el instrumento alcanza ≥ 80 % del techo con A = 1 y A = 2, y ≤ 50 % con A = 8 | salto por trampa 11,3 / 5,6 / 1,4 cuentas frente a 1,5 de disparo |
| PD4 | ff 85, D2: ≤ 60 % del techo con la variante S en todas las A; ≥ 80 % con D en A = 1 | §2 |
| PD5 | La mejor asignación de área en tt, ss 85 y ff −40 es A = 1 con muchas réplicas (A = 1 o 2 gana en bits por µm² a A = 4 y 8, contando el interruptor de cada pata) | PD3 + coste fijo por pata |

## 8. Controles negativos completos

| Objeto | Qué |
|---|---|
| Testigo T1 | Una sola trampa de 0,305 mV, τ = 1 ms, tt, C0, 1 kHz, 1 s: E_A la detecta en ≥ 95 % con ≤ 1 % de falsos (análogo de N8c en `xc19_noise`). Comprobado a mano antes de correr que mueve la lectura (11,3 cuentas) |
| Testigo T2 | f = 10 frente a 1, A = 1, R = 16, tt: ambos estimadores ≥ 80 % de su techo |
| M1 | Amplitudes ×0: D1 y D2 ≤ 0,02 bits |
| M2 | Etiquetas barajadas: ≤ 0,02 bits |
| M3 | Sin cuantización a ff 85: los bits suben respecto a la variante S |
| M4 | Las mismas trampas en A y en B (gemelo correlacionado): D1 cae |

## 9. Separación de incertidumbre

- **Epistémica:** λ0, η, la distribución de τ, los f_k reales y si el 1/f del PDK es de número o de movilidad. Esto último es la
  franja no atribuida principal: si el 1/f es de movilidad, las trampas del modelo son menos y más pequeñas, y se reporta.
- **Computacional:** tamaño de la muestra de Monte Carlo (IC por bootstrap) y desacuerdo E_A–E_B.
- **Anti-invariante:** los bits deciden **cómo repartir el área** (recurso). No se reportan como evidencia de que las trampas
  existan, ni de que una geometría tenga más defectos.

## 10. Criterios

- **Sigue (el abanico entra al diseño del slot):** T1, T2, M1–M4 pasan y PD3 o PD5 se cumple. Con eso se dibuja el abanico
  C0–C9 con la asignación ganadora y se enmienda MISFIT-03.
- **Muere el abanico tal como está:** si en tt el instrumento alcanza < 50 % del techo para todas las A. El cuello sería el
  lector, no la física; se vuelve al lector antes de dibujar patas.
- **Muere la variante S como lectura de ff 85** si PD2 se cumple. El dither (φ aleatorio entre `pre` y reloj) pasa a requisito
  del núcleo y de la etapa b.
- **Benchmark inválido:** un testigo falla, un mutante sobrevive, algún estimador supera el techo + 0,02, o E_A y E_B difieren
  > 0,05 en una fila que decide.

## 11. Presupuestos

- **Resolución:** simulador y E_A, ≤ 1 sesión.
- **Auditoría:** E_B escrito por un agente independiente con este prerregistro y sin el código de E_A, ≤ media sesión, aparte.

## 12. Enmiendas

Ninguna.
