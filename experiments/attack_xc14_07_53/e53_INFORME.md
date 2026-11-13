# e53 — Informe del ataque a XC-53 (bomba de carga de alta tensión) y tabla final de la familia

Abierto el 2026-11-13 09:42 EST (hora de `date`). Prerregistros: `e14_PREREG.md` (P-G1–G4, P-H1; 12-nov 22:33:58) y
`e53_PREREG.md` (P-G5–G8; 13-nov 07:16). Corridas de ngspice del 13-nov 07:27:35 a 09:40:38 (`e53_sp/inicio.txt`, `fin.txt`).
Un solo agente; sin verificar. Grados como en `e14_INFORME.md`.

## 1. Lo que se hizo

`e53_gen.py` genera 64 mazos (`e53_sp/*.sp`) y los corre en Docker `hpretl/iic-osic-tools:2025.07` con el PDK de la imagen
(`open_pdks 8afc8346…`, el mismo que el local: `e53_sp/pdk_imagen.txt`). Montaje: solo `e53_sp/` (nuestra), sin montar el PDK ni
`local_flow`. `e53_post.py` → `e53_post.txt`, `e53_post.png`. Dickson de N etapas, diodos con transistores de 5 V
(`nfet/pfet_g5v0d10v5`, W = 4 µm, L = 0,5 µm), C = 1 pF ideal por etapa con 5 % de parásito a tierra, reloj de dos fases de
amplitud VDD a 10 MHz, salida 2 pF, carga 0 o 1 µA, 60 µs (asentado a < 1 %: compárese 48–50 µs con 58–60 µs).

Cuatro conexiones del cuerpo: `n` (nfet, cuerpo a sustrato), `nb` (nfet, cuerpo a su fuente), `pa` (pfet, pozo al nodo de
entrada), `pb` (pfet, pozo al nodo de salida). **`nb` y `pa` están mal planteadas por mí**: en ambas el diodo de cuerpo queda
en directa hacia atrás en cuanto la etapa siguiente sube 0,6 V, y la bomba se vacía (salidas de −5 a +1,4 V). No son un
resultado físico de SKY130; quedan como control negativo de que la conexión del pozo decide.

## 2. Resultados (V_out en vacío / con 1 µA; `e53_post.txt`, **CORRIDA**)

| Topología | VDD | N = 2 | N = 4 | N = 6 | N = 8 | Caída por etapa | Máx. tensión inversa por dispositivo |
|---|---|---|---|---|---|---|---|
| `n` | 1,8 | 2,64 / 2,00 | 3,82 / 2,92 | 4,77 / 3,69 | 5,57 / 4,35 | 0,86–1,16 V (efecto de cuerpo) | 2,5 V |
| `n` | 3,3 | 6,24 / 5,58 | 9,54 / 8,60 | 12,52 / 11,36 | 15,25 / 13,92 | 1,1–1,5 V | 5,1 V |
| `pb` | 1,8 | 3,81 / 3,17 | 6,15 / 5,18 | **8,42 / 7,20** | **10,64 / 9,22** | 0,47–0,62 V | 2,9 V |
| `pb` | 3,3 | 8,16 / 7,51 | 13,34 / 12,38 | 18,45 / 17,24 | 23,50 / 22,10 | 0,48–0,63 V | **5,8 V** |
| ideal (V_d = 0) | 1,8 / 3,3 | 5,23 / 9,59 | 8,66 / 15,87 | 12,09 / 22,16 | 15,51 / 28,44 | — | — |

Resistencia de salida: 1 µA cuesta 0,6–1,4 V (N = 2–8); el ideal N/(f·C) da 0,2–0,8 V/µA. Corriente disponible ≈ 0,7–1,6 µA por
voltio de margen bajo el vacío con 1 pF y 10 MHz; escala con f·C.

| Id | Predicción | Resultado | Veredicto |
|---|---|---|---|
| P-G1/G5 | nfet con cuerpo a tierra desde 1,8 V: < 5 V con N ≤ 8; desde 3,3 V, N = 4: 8–11 V | 5,57 V con N = 8; 9,54 V con N = 4 desde 3,3 V | fallada por poco (5,6 > 5); cumplida |
| P-G2/G6 | pfet desde 1,8 V: 0,7–1,1 V por etapa, 6–9 V con N = 6–8 | 1,2 V por etapa; 8,4 V (N = 6), 10,6 V (N = 8) | **fallada por arriba**: rinde más |
| P-G3/G8 | 1–5 µA a 1 V bajo el vacío | 0,7–1,6 µA | fallada por abajo |
| P-G4 | límite útil 10–11 V por uniones (bvs 11,7–12,6 V) | ver §3 | cumplida |
| P-G7 | ningún dispositivo ve más de una etapa entre puerta y canal | cierto, pero desde 3,3 V una etapa es 5,8 V > 5,5 V de V_GS | **fallada** para 3,3 V |

## 3. Límites reales

- **V_GS del pfet de 5 V:** el diodo `pb` alimentado a 3,3 V ve |V_GS| = 5,66–5,79 V en inversa, por encima de 5,5 V (dato del
  PDK leído por agente, DATOS_PROCESO). Desde 1,8 V ve 2,9 V. **Conclusión: bombear desde 1,8 V**, no desde 3,3 V, con esta
  topología; desde 3,3 V harían falta dos dispositivos en serie por etapa.
- **Uniones:** `bvs = 12.636` (nfet_g5v0d10v5) y `11.7` (nfet_01v8) (**PDK**, `.pm3.spice`); `diode_pd2nw_11v0` `bv = 12.69`
  (**PDK**). La ruptura pozo n / sustrato no la encontré en los modelos `[?]`. Con la cadena `pb`, el último pozo está a V_out:
  N = 8 desde 1,8 V pone 10,6 V en el pozo, dentro del margen de esas cifras. La cadena `n` pone la fuente n+ del último
  nfet a V_out contra el sustrato: N = 6 desde 3,3 V (12,5 V, pico 14 V) ya no cabe.
- **Reglas de alta tensión del PDK** (**LEÍDO** vía resumen de skywater-pdk.readthedocs.io/en/main/rules/periphery.html):
  «High voltage rule apply for an operating voltage range of 5.5 - 12V»; pozo n a ≥ 7,2 V se marca con el texto
  `shv_nwell` (hv.X.6, no comprobado por DRC) y se separa 2,5 µm de pozos de otra red (hv.nwell.1); 12 V nominales (16 V máx.)
  piden la capa `vhvi`. En el tech de Magic local: pozo HV a pozo LV ≥ 2,0 µm (nwell.8), un pozo HV solo admite difusión HV
  (diff/tap.21) (**PDK**, `sky130A.tech` l. 4207–4214). Es decir: **el PDK prevé nodos internos de 5,5 a 12 V**.
- **Tiny Tapeout** (**LEÍDO**, tinytapeout.com/specs/analog): 1,8 V y 3,3 V opcional; pin analógico < 500 Ω, < 5 pF, 4 mA; met5
  prohibido; tesela analógica 1×2 = 160 × 225 µm. **No dice nada** de tensiones internas elevadas, bombas ni MiM `[?]`. P-H1:
  cumplida (los 4 mA y < 500 Ω que recordaba son correctos; lo de alta tensión, `[?]` como predije).
- **Interconexión flotante:** x.22 prohíbe `capm` flotante; los condensadores de la bomba no lo están.

## 4. Área (cálculo)

`pb`, N = 8, 1 pF por etapa: MiM a 2,00 fF/µm² (**PDK**, `res_typical__cap_typical__lin.spice` l. 7) → 8 × 500 µm² + salida
2 pF (1000 µm²) ≈ 5000 µm²; nueve pfets de 4 × 0,5 µm en pozos propios con 2,0–2,5 µm de separación, ~9 × 80 µm² ≈ 700 µm²;
reloj de dos fases en 1,8 V. Total ~5000–6000 µm² si el MiM no se monta sobre los dispositivos: **~15 % de una tesela 1×2
(36 000 µm²)**. Cabe.

## 5. Veredicto

| Sub-afirmación | Veredicto |
|---|---|
| «Con 3,3 V hacen falta pocas etapas para ~10 V» | **TRANSFORMADA**: cierto en tensión (N = 2 → 8,2 V), pero el diodo pfet ve 5,8 V de V_GS. Bombear desde 1,8 V |
| Bomba de Dickson con pfet de 5 V, pozo a la salida, desde 1,8 V: 6–10,6 V a µA | **SOBREVIVE**: N = 6 → 8,4 V (7,2 V a 1 µA); N = 8 → 10,6 V (9,2 V a 1 µA); ningún dispositivo pasa de 2,9 V |
| nfet con cuerpo a tierra desde 1,8 V | **MUERE** como fuente de > 6 V (efecto de cuerpo) |
| Admisible en Tiny Tapeout | PDK: sí, en su régimen de 5,5–12 V con marcas no comprobadas por DRC. Tiny Tapeout: `[?]`, hay que preguntar |

Para qué sirve (de e07 y e14): ruptura del óxido de 4,15 nm en segundos-minutos (6,5–8 V: **sí**); FN en el óxido de 11,6 nm
(8–12 V: en el borde, 9–10 V con N = 8); avalancha sostenida o filamento operado (mA): **no**.

## 6. Tabla final de la familia

| Celda | Señal | Piso | Dato de proceso que falta | Vehículo | Qué dibujar |
|---|---|---|---|---|---|
| XC-14 «nace escrita», óxido 1,8 V | Ninguna de antena: el óxido olvida Vi en ~1 s (idéntico a 4 decimales para 3,3–7 V) | — | J(V) real a 0,3–1,5 V (decide si el nodo se mueve) | TT 1,8 V | Pares con y sin diodo como control: deben coincidir |
| XC-14 reloj / medidor de espesor (nuevo) | V residual 0,06–0,74 V (r = 1) a 6 m; deriva 0,2–0,9 mV/día; σ por espesor 9–87 mV | 0,305 mV del lector; desajuste de umbral 17,3 mV | V0 y φ del óxido real; si `toxe_slope` es espesor físico | TT 1,8 V, sin bomba | Matriz con barrido de r (placa 0–60 × 60 µm) y lector XC-19 |
| XC-14 sobre óxido de 5 V | Lo que deje el plasma (≤ ~7 V según CHARM; de otra herramienta) | Túnel < 1e-15 A/cm² a 5 V | Si la carga sobrevive al recocido final `[?]` | TT 1,8 V | Puerta de `g5v0d10v5` con antena, con y sin diodo, placa de acoplamiento |
| XC-45 temporizador por túnel | 0,1–1 V por década de tiempo, legible; sigue con el chip apagado | Interruptor 0,66 fA: domina salvo > 70–6500 µm² a 1,8 V | J(V) del óxido; dependencia térmica `[?]` | TT con VAPWR 3,3 V | Celda de túnel sin interruptor, escrita desde 3,3 V, barrido de área de túnel |
| XC-11/09 memoria de puerta flotante | Carga en 11,6 nm, retención de años | Hasler: 1–100 µV en 10 años (otro proceso) | Tensión de escritura FN e inyección del 11,6 nm; Chen 2024 `[?]` | TT con bomba | pFET de 5 V con condensador de túnel y de acoplamiento |
| XC-07 antifusible | pA → µA–mA tras ruptura | Fuga virgen: túnel 1e-11–1e-9 A/cm² a 1,8 V | t_BD(V) del óxido real; R tras ruptura `[?]` | TT con bomba (6,5–8 V) | Escalera de áreas con limitador; gemelo de 11,6 nm |
| XC-08 emisor por filamento | ≈ 94 pW a 6 mA en Li 2023 (otro proceso) | — | Si la ruptura con µA y ~64 pJ deja filamento `[?]` | TT con bomba para formar; operar ≤ 1 mA a 3,3 V | Varactor pequeño estilo Li con salida a pin |
| XC-53 bomba | 8,4–10,6 V desde 1,8 V | Rizado 5–30 mV | Ruptura pozo n/sustrato `[?]`; postura de TT sobre nodos > 5,5 V `[?]` | TT 1×2 | Dickson `pb` N = 8, 1 pF/etapa, salida seleccionable y divisor de lectura |
