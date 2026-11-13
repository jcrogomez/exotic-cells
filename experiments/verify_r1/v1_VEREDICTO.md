# v1_VEREDICTO — verificador independiente, ronda 1 (escrito Thu Nov 12 13:05:56 EST 2026)

Mis números: `v1_NUMEROS.md` (escrito 13:04:10 EST, antes de abrir nada de los agentes). Código: `v1_calc.py` → `v1_salida.txt`; cruce posterior: `v1_c1_cruce.py` → `v1_c1_cruce.txt`.

## Qué leí de los agentes y cuándo (horas de `date`, 2026-11-12 EST)
- 13:04:10 listado de las tres carpetas (solo nombres).
- 13:04:13 `attack_xc20/a20_INFORME.md` (cabecera, §1–3 y §7–11; el centro quedó truncado en mi lectura).
- 13:04:19 `attack_xc05/a05_INFORME.md` y `attack_xc52/a52_INFORME.md` enteros; grep de "4e19/umbral" en a20_INFORME.
- 13:04:45–13:05:22 fragmentos de `a20_lib.py` (constantes, fd_half, depletion), `a20_abrupta.py` (l.10–24, 44–69), `a20_abrupta.txt` (l.1–25), y grep de `a52_coil.py` (definición del semilado).
- No abrí los PREREG ni el resto de scripts/salidas.

## Tabla
| | Predicción | Mi número | Veredicto |
|---|---|---|---|
| A1 | 5,7 nm / 4,4 MV/cm (1e20); 16,6 nm / 1,3 (1e19) | 5,55–5,85 nm / 4,29–4,52; 16,1–16,9 nm / 1,25–1,31 (Boltzmann, FD, FD+BGN 0,1 eV) | **verificada** |
| A2 | umbral ~4e19 (1e19–1e20) | 2,1–2,5e19 (EF = Ec con Nc 2,8–3,2e19; el lado p entra antes o a la vez: 0,8–2,4e19) | **verificada en el margen; el valor 4e19 no se reproduce** (ver D1) |
| A3 | 4,5–8,5 décadas con B 2e7–4e7 | 4,7–9,4 (Emax); 5,0–9,9 con BGN | **no verificada tal como está escrita** (tope 9,4, no 8,5); los números del agente sí se reproducen (ver D2) |
| A4 | 120 / 197 / 48,2 Ω/□, l.~5106–5107 | 120000 (l.5106), 197000 (l.5107), 48200 (l.5119) mΩ/□; ngspice rdn/rdp/rp1 iguales | **verificada**. Siliciuro 2–15 Ω/□: de memoria, **no leído** |
| B1 | ~1,4 µm bajo met1; met1 ~0,36 | 1,3761 µm y 0,36 µm (tech l.5058); tlef l.115 da 0,35; sobre difusión activa 1,05 µm | **verificada** |
| B2 | 0,3–2 µs | τ63 = 0,52–0,92 µs (k_ox 1,4–0,8; DF 2D); t90 = 4–7 µs (no exponencial) | **verificada** |
| B3 | ~1 K (0,3–5) | 1,3–2,3 K sin extremos; 0,84–1,2 K de media con extremos fríos | **verificada** |
| B4 | 2,8 mA/µm (l.~123); 6,8 (l.~207) | idénticos, l.123 y l.207; "mA/um Iavg_max at Tj = 90oC" | **verificada** |
| B5 | 1,16; 1,24; 1,38 (±0,06) | 3 puntos del LEEME: 1,11–1,21; 1,19–1,26; 1,35–1,42 según método. Tabla ngspice: 1,12; 1,20; 1,403 | **verificada dentro del margen**, con sesgo (ver D3) |
| C1 | 0,26 mT/mA ±25 % (compacta) | 0,227 (cuadrada) / 0,247 (circular) con borde interior a 10 µm, z = 3,21 µm; con w = 1,5: 0,190 / 0,208 | **verificada** la compacta; la de 1,5 µm depende de la definición de "radio" (ver D4) |
| C2 | 1,47 µm | 1,47 µm | **verificada** |
| C3 | 0,05–0,24 mV/mA | 0,0165–0,66 mV/mA (barrido literal n·t, r_H = 1, G = 1) | **no verificada** como barrido literal (ver D5) |
| C4 | 950 (Magic) y ~1700 (ngspice) | 950000 mΩ/□ (tech l.5104); rnw=1700 (`ngspice/r+c/res_typical__cap_typical.spice` l.22) | **verificada** |
| C5 | 0,11 s (0,03–0,3) | T = 100·q/(d²·I) = 0,114 s; 0,141 s con demodulación senoidal | **verificada** |

## Lo distinto
- **D1 (A2).** El "~4e19" de a20 sale de leer la degeneración en el borde donde el campo cae al 10 % de Emax (`a20_lib.py` l.149–150), que todavía está ~20 meV dentro de la curvatura de bandas. Su propia columna Vbi implica xi_n + xi_p = +19 meV a 3e19 y su columna de camino de túnel ya es finita a 3e19 (nan a 2e19). Con sus constantes (Nc 2,86e19, Nv 3,1e19) el umbral de volumen es 2,2–2,4e19; con las mías 2,1e19. Factor ~2 a favor de la idea. A 300 K el umbral además no es abrupto (cola de ~kT).
- **D2 (A3).** 4,5 es con F0 = 1,9e7 (fuera del intervalo "2e7–4e7" de la afirmación; lo reproduzco: 4,49); 7,2 es con 3e7 (reproduzco 7,1); 8,5 no es exponente de Kane sino corriente completa a 0,1 V. Con B = 4e7 el exponente da 9,4. La afirmación mezcla dos cosas.
- **D3 (B5).** a05 dice "PCHIP de los cinco puntos del LEEME"; el LEEME trae tres. La tabla de ngspice (`05_exotic_lab/macros/constriccion/sim/efld00_lector_drivers.txt`) tiene 5 kΩ → ×1,144 y 12,9 kΩ → ×1,403 simulados: el 1,163 a 4,3 kΩ queda por encima del valor simulado a 5 kΩ. Mejor: 1,12 / 1,20 / 1,40.
- **D4 (C1).** Reproduzco los 0,257 y 0,265 de a52 con su geometría (semilado MEDIO 10 µm, z = 2,88 µm). Con w = 1,5 µm eso es un borde interior de 5,65 µm, no ~10. Si el interior libre es de 10 µm, w = 1,5 da 0,19 mT/mA y al límite CC (10,2 mA) 1,9–2,0 mT, no 2,70; para 2,5 mT hace falta w ≈ 2,1 µm (14,3 mA). La compacta de 0,3 µm admite 2,04 mA → 0,46–0,52 mT (coincide con a52).
- **D5 (C3).** El rango 0,05–0,24 de a52 no es un barrido de dopado × espesor con r_H = 1: es G·r_H·mu·Rs·I·B con G = 0,7, r_H = 1,1, N = 1e16–1e18 y Rs fijada en 950/1700. El barrido literal da 0,017–0,66 (40×); por la vía de Rs sin G: 0,10–0,45. El orden (décimas de mV/mA) coincide; el rango declarado no.
- **Laterales.** 2,06 mA en 0,14 µm de met1 son 14,7 mA/µm, 5,3× el límite CC de B4 (dato, no objeción: es estrés intencional). tlef y Magic discrepan en espesores (0,35/0,36; 0,8/0,845).

## Límites míos
Constantes de Si y térmicas de memoria; aproximación de vaciamiento a W ~ 5 nm; térmica 2D sin capas de nitruro ni metal vecino; espiral como lazos concéntricos filamentarios; nada leído de literatura hoy.
