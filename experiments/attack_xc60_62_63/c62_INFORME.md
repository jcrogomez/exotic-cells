# c62 — Informe del ataque a XC-62 (transistor impreso por proximidad)
Cerrado: Thu Nov 12 19:16:33 EST 2026 (hora de `date`). Prerregistro: `c62_PREREG.md`. Óptica SUPUESTA y sin calibrar (248 nm; NA 0,60/0,70; σ 0,5/0,8), umbral constante, sin resina ni grabado, **sin la corrección de la fábrica**: da intervalos y cota, no predicción.

## (d) Reglas de poly (PDK local, `libs.tech/magic/sky130A.tech`)
| Regla | Valor | Línea |
|---|---|---|
| poly.1a ancho | 0,150 | 4338 |
| poly.2 separación | 0,210 | 4339 |
| poly.4 poly (no puerta) a difusión | 0,075, `corner_ok allfets` | 4341–4344 |
| poly.5 poly a toma | 0,055 | 4788–4795 |
| poly.6 toma pegada a puerta | 0,300 | 4797–4804 |
| poly.7 difusión más allá de la puerta | 0,250 | 4347–4351 |
| poly.8 extensión de la puerta sobre el borde de la difusión | 0,130 (0,110 en SRAM) | 4352–4353 |
| poly.11 sin codos sobre la difusión | `rect_only allfets` | 4354 |
| poly.1b largo mínimo pfet lvt | 0,350 | 4786 |
No hay regla de "codo a difusión": un codo fuera de la difusión solo debe cumplir poly.4 (0,075). Como poly.7 exige 0,25 de difusión y poly.4 0,075, un poly de campo paralelo no puede estar a menos de 0,325 de la puerta: **los vecinos a 0,21 tienen que ser otras puertas sobre la misma difusión**.

## (g) Legalidad (`c6x_drc_out/map.txt`)
Pasan Magic y KLayout (0/0): aislada con extensión 0,13 y larga; vecinas a 0,21 por uno y dos lados; a 0,42 y 1,0; poly de campo a 0,325; codo a 0,075 y a 0,13; T a 0,075; U a 0,075 y a 0,13. Controles ilegales rechazados solo por Magic: extensión 0,10 (poly.8), poly de campo a 0,035 y codo a 0,05 (poly.4), codo sobre difusión (poly.11, poly.7). El deck MR de KLayout no vio ninguno de los cuatro ilegales.

## (e) Imagen aérea (`c62_litho.py` → `c62_litho.txt`). Dibujado 0,150; intervalo en los cuatro ajustes
| Variante | L en el centro | L en el borde de la difusión | La punta cubre (dibujado 0,13) | I/I0 nfet inv. débil | ΔV equivalente |
|---|---|---|---|---|---|
| aislada, extensión larga (referencia) | 0,149–0,151 | 0,150–0,151 | — | 0,96–1,01 | −1,4…+0,4 mV |
| aislada, extensión 0,13 | 0,147–0,156 | **0,131–0,145** | 0,056–0,094 | 0,90–1,21 | −3,7…+6,8 |
| vecina a 0,21 por un lado | 0,127–0,148 | 0,104–0,141 | 0,042–0,095 | 1,17–2,64 | +5,7…+35 |
| vecinas a 0,21 por dos lados | **0,097–0,149** | 0,071–0,139 | 0,023–0,097 | 1,12–8,0 | +4…+76 |
| vecinas a 0,42 / a 1,0 | 0,145–0,153 / 0,148–0,154 | 0,128–0,146 / 0,130–0,147 | 0,052–0,095 | 0,94–1,30 / 0,90–1,21 | −2…+10 / −4…+7 |
| poly de campo a 0,325 | 0,132–0,149 | 0,110–0,142 | 0,050–0,091 | 1,11–2,28 | +4…+30 |
| codo a 0,075 | 0,145–0,151 | **0,169–0,195** (lado del codo) | — | 0,99–1,05 | −0,3…+1,7 |
| codo a 0,13 | 0,148–0,150 | 0,147–0,159 | — | 1,05–1,13 | +1,9…+4,5 |
| T a 0,075 | 0,137–0,153 | 0,192–0,230 | — | 0,93–1,35 | −2,8…+10,8 |
| U a 0,075 / 0,13 | 0,116–0,151 / 0,121–0,151 | 0,152–0,191 / 0,127–0,160 | — | 0,96–3,0 / 1,03–3,4 | −1,6…+41 / +1…+45 |

- **Retroceso de punta:** 36–74 nm de los 130 dibujados (aislada); la puerta **no deja de cubrir** la difusión en ningún ajuste (mínimo 23 nm, vecinas densas a NA 0,60 σ 0,5). El fallo "transistor en corto" no aparece con la extensión legal; aparecería hacia 0,10 (ilegal en Magic, invisible para KLayout MR).
- **Vecinas a 0,21:** el signo es siempre "más corta o igual", pero el tamaño lo decide la coherencia: −41…−53 nm con σ 0,5 y −1…−4 nm con σ 0,8.
- **Codo:** alarga el borde 19–45 nm a 0,075, pero casi no mueve la corriente en inversión débil: el tramo alargado deja de conducir y el resto manda (la exponencial pesa el tramo corto). El codo es la variante con señal geométrica clara y señal eléctrica pequeña en esta lectura; se vería mejor en inversión fuerte o como ancho efectivo.

## Sensibilidad al largo del modelo del PDK (`c62_dvth.sp`, ngspice 44.2, tt 27 °C → `c62_dvth.txt`)
nfet_01v8 0,42/0,15, V_GS 0,2 V: **−3,8 %/nm, equivalente a −1,39 mV/nm** de puerta (n = 1,41). A V_GS 0,3: −0,77 mV/nm. pfet_01v8: −2,9…−3,2 mV/nm (−4,3…−5,3 %/nm). Solo hacia largos mayores: el modelo no tiene bins por debajo de 0,15, así que todo L < 0,15 de la tabla está **extrapolado**. Extra: el nfet es no monótono entre L = 0,18 y 0,20 (I/I0 0,31 → 0,49): es un salto de bin del modelo, no física (candidato para XC-47).
**Frente al desajuste (17,3 mV, 0,42/0,15):** 12 nm de largo en nfet, 6 nm en pfet.

## (f) Corrección de la fábrica (`c62_lit_opc.txt`; leído por subagente en la documentación pública)
La fábrica **sí** aplica OPC automática y poly es la capa señalada: `areaid.op` 81:54 "OPC drop. Block automatic OPC"; regla x.1a "p1m.md (OPC)" con rejilla de 0,001; máscaras `cp1m` add/drop; x.9 prohíbe serifs manuales fuera del core. Tolerancias publicadas: 0,02 µm (3σ) de sesgo de proceso de poly y 0,011 de "control adicional de CD". No público: receta, longitud de onda, NA. Mi P62.7 ("no habrá declaración pública") **falló**.

Escenarios:
| Escenario | Qué queda | Tamaño |
|---|---|---|
| A. Sin OPC (no es el caso documentado) | la tabla de arriba | hasta +76 mV en vecinas densas; signo fijo, tamaño dependiente de la óptica |
| B. OPC que corrige ancho de línea (iso-denso) pero no puntas ni codos al 100 % | residuo en borde de difusión (punta) y en codo | unos nm: 5–19 nm de estrechamiento en el borde en mi cota sin corregir → fracción de eso |
| C. OPC completa, residuo dentro de la tolerancia publicada | ≤ 11–20 nm | **15–28 mV nfet, 33–60 mV pfet**: la propia tolerancia de la fábrica ya es del orden del desajuste |

## Resultado contra predicción
P62.1 cumplida. P62.2 **fallada** (el signo no cambia; cambia el tamaño, de −1 a −53 nm). P62.3 cumplida en "no descubre" y en retroceso (36–74 nm); la caída de L en el borde fue 5–19 nm, menor que los 15–60 predichos. P62.4 cumplida (19–45 nm). P62.5 cumplida aprox. P62.6 nfet cumplida (1,39 mV/nm); pfet fuera del rango por arriba (3 mV/nm). P62.7 **fallada**. P62.8 cumplida.

## Veredicto
| Sub-afirmación | Veredicto |
|---|---|
| "Formas legales de poly se imprimen distinto" | SOBREVIVE en la imagen aérea sin corregir; con la OPC documentada queda el residuo, de tamaño no público |
| "El largo efectivo depende de la vecindad dibujada" | **TRANSFORMADA**: la variante no elige un umbral por diseño; **mide el residuo de la OPC de la fábrica** (y su óptica). Es una celda de metrología de proceso leída eléctricamente, con 1,4–3 mV por nm |
| "Fallo: la puerta no cubre la difusión" | No ocurre con extensión ≥ 0,13 en ningún ajuste |
| Criterio de muerte (|ΔL| < 2 nm en todo) | No se cumple en el modelo; en silicio depende del escenario B/C |

**Mapa de tres regiones.** Parámetro: separación a la puerta vecina (1,0 → 0,42 → 0,21) y extensión de la punta (larga → 0,13 → 0,10). Convencional: vecinas ≥ 0,42 y extensión larga (|ΔV| ≤ 10 mV, bajo el desajuste). Tercera: vecinas a 0,21 por dos lados, punta a 0,13, U: corrimiento sistemático del orden o por encima del desajuste si el residuo de OPC es ≥ 5 nm. Fallo: extensión < ~0,10 (ilegal) o L impreso < ~0,10 (perforación; solo en el escenario A con σ 0,5).

## Configuraciones a dibujar
1. **Pareja pfet+nfet 0,42/0,15: aislada (vecinas a 1,0) frente a vecinas a 0,21 por los dos lados**, misma difusión y mismos sa/sb en el dedo central (para no confundir con XC-12). El pfet es el más sensible (3 mV/nm).
2. **Extensión de punta 0,13 frente a 0,50** en la misma puerta aislada: aísla el estrechamiento de borde.
3. **U a 0,075 frente a dos dedos sueltos a 0,21**: mismo paso, distinto cierre.
Varias réplicas de cada una: la señal esperada (5–30 mV) es del orden del desajuste (17,3 mV), así que hacen falta ≥ 16 réplicas para ver 5 mV.
