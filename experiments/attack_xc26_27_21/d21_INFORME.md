# d21 — Informe del ataque a XC-21 (emisor en avalancha; absorbe XC-22 SPAD)

Escrito el 2026-11-13. Prerregistro: `d21_PREREG.md` (2026-11-12 22:35). **Todo es cálculo, simulación y lectura; nada medido.**
Grado de todo lo de este informe: **un agente** (sin verificador). El subagente de literatura de avalanchas y SPAD murió sin
informe (créditos); lo sustituyó una sola búsqueda propia (resultados como fragmentos: **no leídos**).

Scripts: `d21_bv.py` → `d21_bv.txt` (ruptura 1D con la integral de ionización); el presupuesto óptico de avalancha está en
`d26_budget.py` → `d26_budget.txt` §2b (mismo campo de recogida que XC-26).

## 1. Resultados contra predicción

| # | Predicción | Resultado | Estado |
|---|---|---|---|
| A1 | Ruptura p+/pozo n publicada en 130–180 nm: 9–14 V | No leída (subagente muerto). Fragmentos **no leídos**: SPAD p+/pozo n de 8 µm "por debajo de 10 V" (HP Labs); 16,1 V en 55 nm BCD (EPFL). PDK: `bv` = 12,69 V (`diode_pd2nw_05v5.model.spice` l. 38, **PDK local**) | `[?]` en literatura; el dato del PDK es parámetro de modelo |
| A2 | Hueco ≥ 0,27 µm no baja de ~8 V; nada rompe a 1,8 ni 3,3 V | Plana: 14,8 V (N_D 10¹⁷), 11,0 (2·10¹⁷), 8,0 (5·10¹⁷), 6,8 (10¹⁸). Hueco 0,27 µm solo baja la ruptura si N_D ≤ 10¹⁷ (12,7 V con 10¹⁷; 13 V con 10¹⁶). Con radio de esquina 0,1–0,2 µm: 5,6–9,7 V. **Ninguna geometría con hueco ≥ 0,27 µm rompe por debajo de ~5,6 V en ningún N_D barrido** | cumplida |
| A3 | Pegada en inversa a 1,8 V: 10⁻⁹–10⁻⁷ fotones/e⁻, no se lee | Sin número publicado leído (`[?]`). Con la corriente de R13 (57 nA–50 µA) y F_AM ≈ 0,06 a 5 µm, se lee (≥ 150 fA) solo si η ≥ 5·10⁻⁸ a 50 µA, o ≥ 4·10⁻⁵ a 57 nA. Dutta 2017 (leído por el laboratorio): d = 0 "rompe por túnel y emite poco" | abierta; probablemente bajo el piso salvo en el extremo alto de R13 |
| A4 | Avalancha a 100 µA, 5 µm: 0,1–10 pA | Con η_int = 6·10⁻⁶ (Dutta, 65 nm, leído por el laboratorio) y F_AM de la geometría dibujada (0,062 / 0,024 / 0,0051 a 5/10/20 µm): **37 / 14 / 3 pA** a 100 µA | **fallada por arriba:** 4–10× más de lo predicho |
| A5 | Bomba ~12 V cabe; problema: dispositivo que aguante | Con la ruptura calculada (6–15 V según N_D y esquina) la bomba debe dar ≥ BV: 8–15 V. El `nfet_g5v0d10v5` aguanta 11 V de drenador (leído por agente, `DATOS_PROCESO.md`): **cubre solo la mitad baja del intervalo**. Área y corriente de la bomba: sin calcular `[?]` | parcialmente cumplida |
| A6 | SPAD SKY130 publicado | **No hallado** en una búsqueda (ausencia, no prueba) | — |

## 2. Hallazgos

1. **El hueco legal no es una perilla de ruptura en SKY130 salvo con pozo poco dopado.** A N_D ≥ 2·10¹⁷ el vaciamiento a la ruptura
   (≤ 0,27 µm) cabe entero en el hueco mínimo legal; la curva de Dutta (0–280 nm) cae justo en la zona que el DRC prohíbe. Con
   N_D = 10¹⁷, el hueco de 0,27 da 12,7 V frente a 14,8 de la plana: −15 %. El `bv` del PDK (12,69 V) es compatible con N_D ≈ 10¹⁷
   (plana) o 2–5·10¹⁷ (con esquina): **inferencia**, no dato.
2. **La geometría que sí baja la ruptura es la esquina**, no el hueco: radio de unión 0,1 µm baja la ruptura a 56–70 % de la plana
   (Sze–Gibbons, de memoria). Barrer esquinas (rectángulo, octógono, peine) es la perilla dibujable.
3. **En avalancha la vía de portadores casi desaparece.** p+ y n+ están en el mismo pozo; los pares van a p+ y n+ y el pozo/sustrato
   queda en inversa fuerte: no hay colector de huecos al sustrato ni inyección de electrones. Lo que llega al fotodiodo es luz
   (visible, absorbida en ~2–3 µm) convertida en electrones bajo el emisor, que difunden: cae ×12 de 5 a 20 µm (frente a ×3 de la
   luz de 1100 nm). La aburrida que queda: calor (1 mW → 0,14 K a 5 µm, cálculo), acoplo de la bomba y fuga pozo/sustrato.
4. **Comparado con la directa (XC-26):** a igual corriente la avalancha da ~20–100× más fotocorriente a 5 µm (F_AM/F_FM ≈ 27 y
   η_AM ≈ η_FM o más), pero a 5–10× más tensión.

## 3. Mapa de tres regiones (parámetro: tensión inversa sobre la unión)

| Región | Tensión | Qué pasa | Enviable a qué tensión |
|---|---|---|---|
| Convencional | 0 – ~5 V (hueco ≥ 0,27) | Diodo en inversa, fuga de pA | 1,8 y 3,3 V |
| Tercera región | Pegada (d = 0) a 1,8–3,3 V: túnel; hueco ≥ 0,27 a 6–15 V: avalancha controlada con limitador | Emisión débil por portadores calientes (túnel: η `[?]`); luz visible en avalancha (η ~10⁻⁶–10⁻⁵, 65 nm) | Pegada: 1,8 V hoy. Avalancha: bomba |
| Fallo | Corriente sin limitar en ruptura | Daño por calor; deriva de la ruptura | — |

## 4. SPAD (i)

Ruptura esperada del p+/pozo n: la de arriba (≈ 6–15 V, central ~10–13 V). Guarda: la unión debe romper en el centro y no en el
borde; en SKY130 las opciones son un borde de pozo n menos dopado alrededor del p+ o un anillo de pozo p ligero — qué capas del
PDK lo permiten sin regla rota: `[?]`. Tasa oscura: con N_D ≥ 2·10¹⁷ el campo pico supera 0,8 MV/cm y el túnel la domina
(argumento; números de 130 nm **no leídos**). Lo que haría falta: bomba ≥ BV + 1–3 V (≈ 9–18 V), dispositivos de 20 V o apilados
para conmutarla, resistencia de extinción de poly, y el contador. **No entra en el flujo digital de 1,8 V.**

## 5. Veredicto

| Sub-afirmación | Veredicto |
|---|---|
| "Rupturas de 2 a 9 V según la separación" trasladado a SKY130 | **MUERE la perilla de separación con huecos legales** salvo con N_D ≤ 10¹⁷ (−15 % como mucho). **TRANSFORMADA:** la perilla dibujable es la esquina y el perímetro |
| Emisión en avalancha visible y legible | **SOBREVIVE con bomba:** 3–37 pA a 100 µA a 5–20 µm, sobre el piso 20–250×, con la eficiencia de 65 nm (`[?]` en SKY130) |
| Emisión de la pegada a 1,8 V (sin bomba) | **Abierta, probablemente bajo el piso:** se lee solo si η ≥ 5·10⁻⁸ con la corriente alta de R13. Es la única variante de XC-21 que cabe en el vehículo de hoy |
| SPAD (XC-22) | **TRANSFORMADA a vehículo H/especializado:** bomba de 9–18 V; nada que decidir en el flujo digital |

## 6. Configuraciones que más informan

1. Pegada (XC-20) junto al fotodiodo de XC-26 a 5 µm, con el control a 40 µm: a 1,8 V en inversa es la única emisión de XC-21
   enviable hoy, y a la vez es el ficticio "corriente sin luz" de XC-26 si no se ve nada.
2. Emisores p+/n+ con hueco 0,27 y 1,08 µm, en rectángulo y en peine (mismo área, perímetro ×4): la ruptura por esquina frente a
   la plana, leída cuando haya bomba.
3. En el vehículo con bomba: emisor en avalancha a 5 y 20 µm del fotodiodo; la caída ×12 frente a ×3 de la directa separa la luz
   visible del infrarrojo sin espectrómetro.
