# c57 — Prerregistro del ataque a XC-57 (unión Peltier)

Hora: Thu Nov 12 19:04:20 EST 2026 (de `date`). Escrito ANTES de buscar literatura, de grepear el PDK para esto y de correr nada.
Todo lo de abajo es **de memoria** o **cálculo a mano**; son predicciones, no datos.

## Qué voy a hacer
(a) Leer Seebeck de capas CMOS (termopilas). (b) Modelo 1D de aleta (diferencias finitas) de una unión y de una cadena: pata de
poly sobre óxido de campo, fuga al sustrato por unidad de longitud G', Joule distribuido, Joule del contacto, Peltier en la unión.
(c) Tiempo a 5 sigma con el lector en inversión débil. (d) Grep del PDK: tipos de poly y uniones n/p dibujables.

## Tautologías (se deducen sin correr)
- T1. En una aleta 1D con fuga distribuida, el enfriamiento máximo de una unión aislada es
  ΔT_max = (Π·R_th)²/(4·R'/G') con R_th = 1/(2·sqrt(k·A·G')) por pata ⇒ ΔT_max ∝ S²T²σ/k = Z·T²·(factor ~1/8–1/2).
  **No depende de G' ni de la sección**: el óxido no lo mata ni lo salva; lo decide Z del poly y la resistencia de contacto.
- T2. Si el poly llevara siliciuro (S de pocos µV/K) no hay nada. La hoja de 48,2 Ω/□ dice que no lo lleva (ver R3: inferencia).
- T3. Thomson es impar en I solo a orden I³ (necesita el gradiente creado por Joule): no imita una señal lineal en I.

## Predicciones
| # | Cosa | Predicción |
|---|---|---|
| P1 | Seebeck poly n+ / poly p+ (sin siliciuro, 130–350 nm) | −80…−200 / +100…+250 µV/K; par 200–450 µV/K |
| P2 | Difusiones n+/p+ | ±(50…200) µV/K; pozo n ~1e17: −300…−1000 µV/K |
| P3 | Origen de 750 µV/K | No es un par poly n+/poly p+ de puerta: es un par con pozo o con poly poco dopado, o suma mal atribuida |
| P4 | Longitud térmica de curación de una pata de poly 0,5 µm | 0,7–2 µm |
| P5 | Componente impar en la unión, pata 0,5 µm, 100 µA | 0,1–2 K (según S y k del poly) |
| P6 | Enfriamiento neto máximo bajo sustrato, unión ideal (sin R de contacto) | 0,1–2 K a 50–300 µA |
| P7 | Con contactos reales (2×152 Ω + li) | Se reduce ≥ 3×; puede quedar en 10–300 mK; **puede** desaparecer si la unión exige metal ancho |
| P8 | Cadena de N uniones frías agrupadas | No mejora ΔT (es por unión); solo área. ΔT en un transistor a 1 µm: 5–30 % del de la unión |
| P9 | Tiempo a 5σ de la componente impar con el lector (5 %/K, 0,55 %/conversión) | < 1 s; típico ms |
| P10 | Poly en SKY130 | [?] 50/50: o todo el poly de puerta es n+ y el p+ solo existe en resistores, o es dual (nsdm/psdm). Si es dual sin siliciuro, hay un diodo p+/n+ de poly en cada inversor |
| P11 | Unión poly p+/poly n+ directa | Es un diodo (Zener/túnel con fugas), no óhmica; el Peltier "limpio" necesita puente de li |

## Qué la mata / qué la deja viva
- Muere (escenario): si en todo el barrido razonable (S par 100–600 µV/K, k_poly 10–40 W/m·K, R contacto del PDK) la componente
  impar en el termómetro queda < 1 mK **o** el tiempo a 5σ supera 10⁴ s. Muere "refrigeración" (no la familia) si no hay ningún
  punto con ΔT neto < 0.
- Vive si la impar ≥ 10 mK en el termómetro con corrientes ≤ 1 mA.
- Abandono: si tras modelo 1D el resultado depende >10× de un parámetro sin dato, no refino a 2D/FEM: doy escenarios.
