# d26 — Informe del ataque a XC-26 (enlace óptico interno: unión p+/pozo n en directa → fotodiodo)

Escrito el 2026-11-13 (cierre: `date` = Fri Nov 13 07:38:53 EST 2026 al terminar la última corrida; texto escrito después).
Prerregistro: `d26_PREREG.md` (2026-11-12 22:35). La sesión se cortó el 12-nov a las ~23:00 por falta de créditos y se reanudó el
13-nov a las 07:15; los dos subagentes de literatura (emisión en directa, avalancha) murieron sin informe; las lecturas que hay
las hice yo. **Todo es cálculo, simulación y lectura: nada medido.** Grado de todo lo de este informe: **un agente**.

## 0. Archivos

| Script | Salida | Qué |
|---|---|---|
| `d26_fd.py` | `d26_fd.txt`, `d26_fd_recogida.json` | (1) recogida u(r) por difusión, geometría de `photon_e05/e10/e20` — **válida**. (2) potencial de sustrato — **inválida**: el anillo de taps del fotodiodo quedaba dentro del margen de vaciamiento y los taps de borde dentro del anillo de dnwell; sin guarda no había referencia (valores de 10¹⁰ V, cg = 20000). Sustituida por `d26_sub.py`. No se borra |
| `d26_fd2.py` | `d26_fd2.txt/.json` | recogida separada en luz directa / reflexión total / cono de escape; u en el borde del pozo del emisor (portadores); guardas de pozo n y de pozo n profundo |
| `d26_sub.py` | `d26_sub.txt/.json` | potencial de sustrato corregido, h = 1 µm, 240×180×120 µm, tres escenarios de referencia y ρ = 1/10/20 Ω·cm |
| `d26_budget.py` | `d26_budget.txt/.json` | F(α, d), espectros, eficiencia interna, β del PNP, luz atrapada, calor |
| `d26_scen.py` | `d26_scen.txt` | corriente máxima sin saturar el PNP y fotocorriente por escenario |

## 1. Columnas: dato / evidencia / supuesto / simulación / conclusión

| Dato del PDK local | Evidencia publicada leída | Parámetro supuesto (barrido) | Resultado de simulación | Conclusión física |
|---|---|---|---|---|
| PNP vertical tt: `bf` 19,35·0,9515 = 18,4 (`pnp_05v5_W0p68L0p68.model.spice` l. 45; `corners/tt/nonfet.spice` l. 38), `ikf` 33 µA; W3p40: 16,6·1,129 = 18,7, `ikf` 386 µA (l. 50–51) | Green y Keevers 1995 (PVEducation, **leída**): α = 3,5 cm⁻¹ a 1100 nm, 1,0 a 1140, 0,022 a 1200; n = 3,54 | Pozos: z_nw 1–2 µm, z_dnw 1,5–4 µm, vaciamiento 0,5–2 µm; L_n 20–1000 µm; fondo absorbente o reflectante | β(I_C): 17 a 1 µA; 6–15 a 0,1 mA; 3–8,5 a 1 mA (Gummel-Poon con los parámetros del PDK) | 85–95 % de la corriente del emisor entra al sustrato como huecos a I ≤ 0,2 mA |
| Pila: met1 a 1,376 µm (`sky130A.tech` l. 5058) | B(300 K) = 4,68·10⁻¹⁵ cm³/s (Nguyen et al. 2014, tabla, **leída**; dicen coincidir con Trupke 2003) | B_rel 0,3–1 (de memoria); N_D 10¹⁷–5·10¹⁷; ancho de base 0,5–1,5 µm; D_p 5–10 cm²/s | Espectro de van Roosbroeck–Shockley: pico 1120 nm, FWHM 1035–1168 nm; α efectivo ponderado = **12,4 cm⁻¹** | La luz de la directa no es "casi transparente": la parte azul del espectro (1030–1080 nm) se absorbe en ~1 mm y domina la recogida |
| Hoja del pozo p 4400 Ω/□ (`sky130A.tech` l. 5100) | Dutta et al., Opt. Express 25, 5440 (2017), **leída**: enlace en SOI 140 nm, emisión directa 1000–1270 nm, I_SC del fotodiodo "del orden de 10 pA" en continua a 10–60 µm; la caída con la distancia es menor que 1/D² (guía en el SOI) | ρ del sustrato 1/10/20 Ω·cm (no público); referencia: taps de lógica densos / solo taps dibujados / oblea epitaxial | R_sub bajo el pozo del emisor: **0,8–0,9 / 6,9–7,4 / 13–14 kΩ** (ρ = 1/10/20); casi igual en los tres escenarios de referencia: manda la dispersión bajo el fondo del pozo de 4 × 3 µm | El sustrato no puede tragar 1 mA bajo un pozo pequeño: sube voltios y el PNP se satura. **La corriente máxima útil la fija ρ** |
| Parásito pozo n/sustrato `ps2nw`: js 4,21e-18, jsw 4,94e-18, n 1,079 (`parasitics/...ps2nw.model.spice` l. 32–34; unidades A/µm², A/µm inferidas del escalado) | Xie et al. 2015, 0,18 µm CMOS en directa: EQE 8,3·10⁻⁶ a 20–200 mA (**fragmento, no leído**) | V_EB 0,8 V; R serie 0,3–0,7 kΩ (contactos 585/185 Ω, l. 5132/5130; número de licon supuesto) | Electrones del pozo al fotodiodo con 0,30 V de directa pozo/sustrato: 0,17 pA a 5 µm | Criterio usado: V_sub − V_nw ≤ 0,3 V; con 0,2 V la vía cae ×30 |

## 2. Resultados contra predicción

| # | Predicción | Resultado | Estado |
|---|---|---|---|
| P1 | η en esta celda 10⁻⁷–10⁻⁵ (tránsito corto de la base) | η = B·n·τ_t: 6·10⁻⁸–7·10⁻⁵; a la corriente máxima de cada escenario: 2·10⁻⁸–2·10⁻⁴, central ~10⁻⁶ (ρ = 10) y ~5·10⁻⁶ (ρ = 1). Sube con la corriente (alta inyección), como observa Dutta 2017 | cumplida, más ancha por arriba |
| P2 | α ponderado 1–5 cm⁻¹ | **12,4 cm⁻¹** (el espectro interno pondera por α dos veces) | **fallada** (×3–10) |
| P3 | F = 10⁻⁴–10⁻³ a 5 µm; ~1/d–1/d²; 40 µm 5–20× menos | F = **2,3·10⁻³** (5 µm), 1,5·10⁻³ (10), 7,5·10⁻⁴ (20), **2,3·10⁻⁴ (control a 44 µm)**. Dos métodos (analítico S y F(α) numérico) coinciden al 1 % | fallada por arriba (×2–20); ley de distancia cumplida (≈ 1/d) |
| P4 | 0,1–100 fA a 5 µm y 1 mA; casi siempre bajo el piso | A 1 mA (ρ = 1): **8–15 pA central** (0,1–230 pA). A la corriente máxima con ρ = 10: **0,34–0,42 pA central** (0,004–5 pA). ρ = 20: 0,10–0,12 pA | **fallada:** sobre el piso en el escenario central salvo ρ ≥ 20 Ω·cm |
| P5 | 90–95 % al sustrato | 85–95 % a ≤ 0,2 mA; 75–90 % a 1 mA (β cae por `ikf`) | cumplida |
| P6 | 10 mV–1 V a 1 mA | Bajo el pozo del emisor: **0,8–14 V por mA**; bajo el fotodiodo 0,015–0,30 V/mA; fuera del anillo 0–0,35 V/mA | **fallada por arriba**: no es un rebote pequeño, es saturación del PNP |
| P7 | Inyección de electrones con cátodo a masa por encima de 0,3–1 mA | Con ánodo a 1,8 V el pozo queda a ≤ 1 V; el PNP se satura por encima de **0,09 / 0,17 / 0,8–1,1 mA** (ρ = 20 / 10 / 1). Con cátodo a masa, 6–8× menos | cumplida en lo cualitativo; umbral más bajo |
| P8 | Rebote de sustrato sobre el lector: 1–30 fA por 10–100 mV | Fuera del anillo (donde iría el lector): 0–22 mV a la corriente máxima (ρ = 10). Efecto sobre fugas: sin simular (no hay ngspice local y no monté el contenedor) `[?]`; orden 3–16 fA por argumento | sin verificar |
| P9 | Calor 0,1–0,3 K | 0,25 / 0,15 / 0,09 K a 5/10/20 µm con 1,8 mW (k de memoria) → ~4 % del fondo térmico del modelo (≈ 0,3 fA) | cumplida |
| P10 | Ley exponencial no sirve; tiempo no sirve; separan la guarda y los ficticios | Ver §4: la guarda de pozo n profundo separa ×25 en portadores frente a ×0,54 en luz; la distancia separa solo si el fondo absorbe; el tiempo no se ve con este lector | cumplida |

Luz atrapada en el dado (cota): F_fondo ≤ 9·10⁻⁷, 2500× menos que la directa a 5 µm. Despreciable.

## 3. Mapa de regímenes (parámetro: corriente del emisor I, frente a I_sat = (V_ánodo − 0,5 V)/(R_sub + R_s))

| Región | Condición | Qué domina en el fotodiodo |
|---|---|---|
| Convencional | I ≪ 10 µA | η ~10⁻⁷ y F ~2·10⁻³: < 1 fA. Diodo en directa sin nada que leer |
| **Tercera región** | 10 µA < I < I_sat | Luz de 1100 nm: I_ph ≈ I·η(I)·F(d), superlineal en I. Huecos al sustrato sin consecuencia (mayoritarios) salvo un desplazamiento estático de 15–300 mV/mA bajo el fotodiodo |
| Fallo (saturación) | I > I_sat | El pozo n/sustrato entra en directa: electrones al sustrato que el fotodiodo recoge con u ≈ 0,03 (5 µm). Crece ×10 cada 64 mV: tapa la luz en decenas de mV |

Fronteras: I_sat = **0,09 mA (ρ = 20), 0,17 mA (ρ = 10), 0,8–1,2 mA (ρ = 1)** con ánodo a 1,8 V; ×2,2 con 3,3 V. Geometrías
enviables que la mueven: emisor más grande o en tira (R_sub ∝ 1/tamaño), varios emisores en arco, ánodo al raíl de 3,3 V.

## 4. Discriminantes (d) y secuencia mínima

| Control | Luz | Portadores (electrones del pozo) | Potencial de sustrato |
|---|---|---|---|
| Polarización del pozo (cátodo) a corriente fija, ±0,3 V | constante | ×10 cada 64 mV | cambia poco |
| Anillo de pozo n profundo alrededor del emisor, en el net DNW (para no romper nwell.7) | ×0,54 (5 µm), ×0,91 (20) | ×0,04 (5 µm), ×0,2 (20) | — |
| Anillo de pozo n somero | ×0,77 | ×0,15 | — |
| Distancia 5 → 20 µm | ×0,33 | ×0,06 (fondo absorbente) a ×0,4 (fondo reflectante, L larga) | — |
| Control a 44 µm | **ve el 10 % de la luz** del de 5 µm | ve 2–10 % | — |
| Tapa de met1 lisa | +3–4 % (`d27`) | 0 | 0 |
| Ficticio óhmico (tap p+ que mete la misma corriente de huecos) | 0 | solo si satura | igual |
| Tiempo | instantáneo | ~10–20 ns de difusión | ns (RC) |

El tiempo no separa nada con un lector que integra 100 ms. **Secuencia mínima:** (1) barrer la tensión del pozo a corriente fija:
si la señal cambia, hay inyección eléctrica y se baja la corriente; (2) a una corriente donde (1) es plano, guarda de pozo
profundo conectada/desconectada: la luz pierde ≤ 46 %, los portadores ≥ 96 %; (3) ficticio óhmico y calefactor de poly de igual
potencia para restar rebote y calor. La distancia y la tapa solo confirman.

## 5. Veredicto por sub-afirmación

| Sub-afirmación | Veredicto |
|---|---|
| "Emite cerca de 1100 nm" | **SOBREVIVE:** pico 1120 nm calculado; 1000–1270 nm medido en SOI (Dutta 2017, leída) |
| "Un fotodiodo a 5–20 µm la detecta sobre 150 fA" | **SOBREVIVE por escenarios:** con ρ ≤ 10 Ω·cm, central 0,34–15 pA a 5 µm (2–100× el piso); a 20 µm solo con ρ ≈ 1 o ánodo a 3,3 V. **MUERE** con ρ ≥ 20 Ω·cm y 1,8 V (0,1 pA a 5 µm). Decide la resistividad del sustrato (no pública) y η (sin medir en SKY130) |
| "Los huecos acaban en el sustrato y no difunden: la explicación aburrida se debilita" | **TRANSFORMADA:** cierto mientras el PNP no se sature; pero el sustrato sube 0,8–14 V por mA bajo el pozo, así que la vía aburrida no es el rebote sino la **saturación del PNP** (electrones inyectados por el propio pozo), que aparece a 0,09–1,1 mA. Es la frontera superior de la tercera región |
| "Gana la difusión" (predicción del plan) | **Depende de la corriente**, no es un hecho: bajo I_sat gana la luz; sobre I_sat, los electrones |
| Instrumento de corrientes pequeñas | sin cambios (no atacado) |

## 6. Qué dibujar (2–3 configuraciones)

1. `photon_e05g` con el anillo cambiado por un **pozo n profundo en el net DNW** alrededor del emisor (discriminante ×25/×0,54),
   y un emisor gemelo sin anillo.
2. **Emisor en tira** (pozo 4 × 20 µm, p+ 1 × 18) frente al cuadrado actual: baja R_sub, sube I_sat y la señal; su ánodo y su
   pozo en pines separados para barrer la tensión del pozo.
3. Ficticio óhmico (tap p+ a la misma distancia, alimentado por la misma fuente) y calefactor de poly de igual potencia.

## 7. Lo que falta del proceso

Resistividad y tipo de oblea (`[?]`, decide I_sat ×15); dopado y profundidad del pozo n (`[?]`, decide η ×10); eficiencia de
emisión en directa medida en SKY130 (`[?]`); corriente oscura real del fotodiodo (`[?]`). Lo nuevo que apareció: el control a
40 µm **no es un nulo óptico** (ve el 10 %), y la eficiencia de la directa en esta celda está limitada por el mismo PNP que
quita los portadores: una base más ancha (pozo sobre pozo profundo) subiría η y R_sub a la vez.
