# XC-19 · anexo de la enmienda 4: qué dice la literatura de C1–C6

Escrito el 2026-11-24 (`date`, tarde de la mañana). La búsqueda la hizo un agente aparte. Los 7 DOI se comprobaron después en
Crossref (título y primer autor coinciden), y las cifras de [2] se cotejaron con el texto del artículo. **Este anexo no decide
nada** en la enmienda 4 (A4.8): da los priors de f_k (densidad de trampas frente a C0) y de g_k (amplitud por trampa). Lo que sí
mide el simulador es D4, el factor f mínimo que el slot distingue.

## Tabla

| Clase | Prior de f_k | Prior de g_k | Base | Nodo | Confianza |
|---|---|---|---|---|---|
| C1, sa = sb mínimos | ≥ 1, magnitud `[?]` | `[?]` | NMOS: entre SA 0,6 y 10 µm, la media de S_ID/I² cae más de un orden de magnitud y σ_dB baja de 5,95 a 1,79 dB [1, 2]. **C0 (sa = 0,30) ya está por debajo del mínimo medido (0,6 µm)**: C1 frente a C0 cae fuera de rango | 130 nm, W/L = 10/0,13 | baja |
| C2, sa = sb = 1,0 | < 1; entre ~0,1 y 1, extrapolado | `[?]` | σ_dB 5,95 / 1,79 / 1,83 dB a SA 0,6 / 1,2 / 10 µm: el salto está entre 0,6 y 1,2 µm [2]. A 90 nm, misma dirección, solo en figuras [3] | 130 y 90 nm | media |
| C3, esquina de STI | > 1 (dirección) | `[?]` | El ruido RTS de borde domina en dispositivos estrechos; redondear la esquina lo reduce [4]; solo el resumen | flash, `[?]` | media en dirección, sin número |
| C4, poly denso | `[?]` | `[?]` | no se encontró medida | — | — |
| C5, antena | ≥ 1, con cola hacia arriba; `[?]` si la antena pasa el DRC | `[?]` | A más antena, más 1/f y una trampa RTS nueva [5]. La polaridad del daño importa [6]. Daño por plasma y RTN [7]. Solo resúmenes | `[?]` | baja |
| C6, unión a tope | `[?]` | `[?]` | no se encontró medida | — | — |

## Lo que se infiere, y no se midió

- [1, 2] miden la PSD de 1/f en dispositivos anchos, no cuentan trampas RTN. Pasar de "S_ID ×10" a "N_t ×10" supone el modelo de
  fluctuación de número. [1] lo favorece, pero con dispersión de movilidad correlacionada a SA pequeño.
- Con sa ≠ sb, el lado fuente pesa más [2].
- Lectura para el diseño (conjetura): **C2 es la única clase con una predicción de dirección y orden de magnitud citables**, f_C2
  entre 0,1 y 1. Si D4 dice que el slot distingue f = 3 y no f = 1,5, un f_C2 ≈ 1/3 sería visible y uno de 0,7 no.

## Referencias (DOI comprobados en Crossref)

1. C.-Y. Chan et al., IEEE TED 54(12):3383, 2007. doi:10.1109/TED.2007.908895
2. C.-Y. Chan et al., Solid-State Electronics 52:1182, 2008. doi:10.1016/j.sse.2008.05.001
3. K.-L. Yeh, J.-C. Guo, IEEE TED 58(9):3140, 2011. doi:10.1109/TED.2011.2159223
4. R.-V. Wang et al., IEEE TED 56(9):2107, 2009. doi:10.1109/TED.2009.2026116
5. Z. J. Ma et al., IEEE EDL 15(6):224, 1994. doi:10.1109/55.286699
6. K. P. Cheung et al., IEDM 1997, p. 437. doi:10.1109/IEDM.1997.650418
7. M. Kamei et al., JJAP 53:03DF02, 2014. doi:10.7567/JJAP.53.03DF02

**Sin leer, pueden tener números:**
- Fantini y Ferrari, Microelectronics Reliability 47:1218 (2007), doi:10.1016/j.microrel.2006.09.024.
- Kamei et al., ICICDT 2014, doi:10.1109/ICICDT.2014.6838598.
