# PHOTON — primera macro óptica mínima para sky130 en flujo digital (frente B del sprint EFLO-00)

Hecho el 2026-11-04, 23:53 EST (hora de `date`). Herramientas: `hpretl/iic-osic-tools:2025.07` (Magic 8.3 rev 530, KLayout,
ngspice), PDK `/foss/pdks/sky130A`. Nada de esto afirma emisión óptica ni enlace interno: solo geometría legal, extracción y
presupuesto de lectura. Un número existe si sale de un archivo del PDK, de una corrida de esta carpeta o de una URL abierta;
si no, `[?]`.

## 1. Qué se dibujó

### Cómo se dibuja el fotodiodo en sky130 (verificado en archivos del PDK)

- El tipo Magic `photo` (alias `photodiode`, plano `dwell`) sale al GDS como **DNWELL 64/18 Y PHOTO 81/81** a la vez
  (`sky130A.tech` l.723 `layer DNWELL dnwell,npn,photo`; l.986-987 `layer PHOTO photo / calma 81 81`; lectura l.2425-2426
  `layer photo DNWELL and PHOTO`). 81/81 es `areaid.po`, "Photodiode device identifier"
  (https://skywater-pdk.readthedocs.io/en/main/rules/layers.html).
- Magic lo extrae como `device ndiode sky130_fd_pr__model__parasitic__diode_ps2dn photo pwell,space/w error a=area`
  (`sky130A.tech` l.6033-6034): **solo área, sin perímetro**.
- Reglas en el tech de Magic (l.4191-4194): photo.2 ancho ≥ 3,0 µm; photo.3 separación photo-photo ≥ 5,0 µm; photo.4 separación
  photo-dnwell ≥ 5,3 µm. KLayout (`sky130A_mr.drc`) solo define `areaid_po = polygons(81, 81)` (l.252) y no lo usa; trata el
  64/18 del fotodiodo como dnwell normal (dnwell.1 ancho 3,0; dnwell.2 separación 6,3 µm).
- Reglas documentadas que **ninguna de las dos herramientas comprueba** (tabla photo.-,
  https://skywater-pdk.readthedocs.io/en/main/rules/periphery.html#id19): photo.1 (exime dnwell.3 y nwell.5), photo.5 (bordes
  coincidentes con areaid.po), photo.6 (debe estar rodeado por un anillo de dnwell), photo.7 (rodeado por anillo de tap p+),
  photo.8 nwell interior de ancho **exactamente** 0,84 µm, photo.9 enclosure del nwell por el photo **exactamente** 1,08 µm,
  photo.10 tap de ancho **exactamente** 0,41 µm, photo.11 enclosure del tap por el nwell **exactamente** 0,215 µm.
  1,08 + 0,84 + 1,08 = 3,00 y 0,215 + 0,41 + 0,215 = 0,84: el fotodiodo canónico es un cuadrado de 3 × 3 µm con un tapón de
  nwell de 0,84 µm y un solo licon de 0,17 µm en el centro. Se cumplieron a mano.
- nwell.7 (https://skywater-pdk.readthedocs.io/en/main/rules/periphery.html#id7): 4,5 µm entre nwell y dnwell de redes
  distintas. Probado: Magic no la aplica contra `photo` (nwell ajeno a 2 µm del photo: 0 errores) y el deck de KLayout no
  contiene nwell.7. Por eso las distancias emisor-fotodiodo empiezan en 5 µm, no en 2.

### Celdas (todas en esta carpeta: `X.mag`, `X.gds`, `X_pr.gds` con prBoundary 235/4, `X.lef`, `X.ext`, `X.spice`, `X.lyrdb`)

| Celda | Contenido | Puertos | Caja (µm) |
|---|---|---|---|
| `photon_fd` | fotodiodo 3 × 3 canónico + anillo tap p+ (0,6 µm, a 0,5 µm) + anillo dnwell (3,0 µm, interior a 6,3 µm, con nwell 0,4 µm por fuera y por dentro y tap n+) | K, A, DNW | 22,4 × 22,4 |
| `photon_fd_l10` | igual con photo 3 × 10 (nwell 0,84 × 7,84, tap 0,41 × 7,41). Interpreta "width" de photo.2/8/10 como el lado corto; si fija también el largo, esta celda no es legal `[?]` | K, A, DNW | 22,4 × 29,4 |
| `photon_e05` | `photon_fd` (3 × 3) + emisor a d = 5 µm (borde del photo a borde del nwell del emisor) + control idéntico a 40 µm al otro lado, todo dentro de un anillo dnwell común (interior x −48,5..31,5, y −6,3..9,3) | K, A, DNW, EA, EK, CA, CK | 86,8 × 22,4 |
| `photon_e10` | idem, d = 10 µm; mismo marco | idem | 86,8 × 22,4 |
| `photon_e20` | idem, d = 20 µm; mismo marco (el anillo queda a 4,5 µm del nwell del emisor: nwell.7 justa) | idem | 86,8 × 22,4 |
| `photon_e05g` | `photon_e05` + anillo p+ de 0,6 µm a 0,5 µm alrededor del emisor, puerto GUARD | + GUARD | 86,8 × 22,4 |

- Emisor candidato: diodo p+/nwell con la geometría de `../chispa/legal.tcl` (nwell 4 × 3 µm, p+ 1,0 × 1,4 µm, n+ a 0,50 µm),
  pintado con los tipos `pdiode`/`pdiodec` para que Magic lo extraiga como `sky130_fd_pr__diode_pd2nw_05v5` (añade el marcador
  `areaid.de` 81/23). Es un diodo en directa a 1,8 V: unión emisora **candidata**, sin ninguna evidencia de emisión en este
  trabajo (lo que se sabe de emisión en directa/avalancha está en `../../docs/pesca/PESCA_OPTO_1104.md`).
- Control: segundo diodo idéntico a 40 µm (CA/CK), dentro del mismo anillo. Justificación: mismo dispositivo, misma corriente,
  mismo driver, solo cambia la distancia; si el detector responde igual al cercano y al lejano, el acoplamiento no es por
  distancia (rebote de masa, caída de alimentación, calentamiento global). No se dibujó la resistencia de poly como calefactor
  sin unión: queda como control adicional para otra ronda.
- GUARD: anillo p+ al sustrato alrededor del emisor. En extracción Magic lo funde con A ("Ports GUARD and A are electrically
  shorted"): ambos son taps del mismo sustrato; físicamente son dos contactos distintos al sustrato y en el chip pueden ir a
  pines distintos. Hipótesis de por qué sirve: el p+ en directa inyecta huecos al nwell; los que llegan a la unión nwell/psub
  pasan al sustrato (PNP vertical parásito) y suben el potencial local del sustrato; un tap p+ cercano los drena antes de que
  lleguen al fotodiodo. No es un control: es condición de existencia (misma conclusión que PESCA_OPTO §6).

Capas GDS presentes (`capas.py` sobre `*_pr.gds`): fotodiodos: 64/18, 64/20, 65/44, 66/44, 67/5, 67/16, 67/20, 81/81, 93/44,
94/20, 235/4. Celdas con emisor: las mismas más 65/20 (diff) y 81/23 (areaid.de). Sin poly ni metal: los puertos están en li1.

## 2. Resultados DRC y extracción

| Celda | DRC Magic (`drc count total`) | DRC KLayout (`sky130A_mr.drc`, feol+beol+offgrid, ítems en `.lyrdb`) | Extracción (`X.spice`) |
|---|---|---|---|
| photon_fd | 0 | 0 | `D0 A K sky130_fd_pr__model__parasitic__diode_ps2dn area=9` |
| photon_fd_l10 | 0 | 0 | `D0 A K ... ps2dn area=30` |
| photon_e05 | 0 | 0 | `D0 A K ps2dn area=9` + `X1 EA EK sky130_fd_pr__diode_pd2nw_05v5 perim=4.8e+06 area=1.4e+12` + `X0 CA CK` idem |
| photon_e10 | 0 | 0 | idem |
| photon_e20 | 0 | 0 | idem |
| photon_e05g | 0 | 0 | idem, con `D0 GUARD K` (GUARD = A = sustrato) |

(área 9 = µm²; el diodo pd2nw sale en las unidades escaladas del modelo: 1,4 µm², 4,8 µm de perímetro.)

Tropiezos que quedan documentados en `comun.tcl`: (a) una etiqueta sin capa explícita se ancla al primer plano uniforme
(nwell) y cortocircuita puertos; se usa `label N center FreeSans 0.3um 0 0 li1`; (b) un anillo pintado como
"rectángulo grande y borrar interior" convierte el nsd/pdiode del interior en psd/nsd y luego lo borra: se pintan cuatro
rectángulos; (c) el `pdiff` de `chispa/legal.tcl` no se extrae como diodo; hace falta `pdiode`.

## 3. Presupuesto de lectura digital "precarga y descarga a tiempo"

Circuito simulado (`sim/lectura.sp`): `ebufn_1` con A = 1 precarga K a 1,8 V durante 1 µs y pasa a Z (TE_B = 1); K alimenta un
`inv_1` seguido de otro; el fotodiodo es el modelo `ps2dn` con `area=9 pj=12` (cátodo K, ánodo masa); una fuente `Iph` de K a
masa representa la fotocorriente. tt, 1,8 V, 27 y 85 °C, **gmin = 1e-18**: con el gmin por defecto de ngspice (1e-12 S) cada
unión aporta 1,8 pA ficticios a 1,8 V, del orden de todo lo que se mide aquí (medido en `sim/fuga_ebufn.sp`, filas `gmin12`).

### Fuentes de los números

| Qué | Valor | Fuente |
|---|---|---|
| Fuga del `ebufn_1` en Z, A = 1, Z = 1,8 V | 32 fA (27 °C) · 0,41 pA (85 °C) | `sim/fuga_ebufn.sp`, tt, gmin 1e-18 |
| Fuga del `ebufn_1` en Z, A = 1, Z = 0,9 V | **−17 fA** (27 °C) · **−1,97 pA** (85 °C): el pmos carga el nodo | idem |
| Fuga del `ebufn_1` en Z, A = 0, Z = 1,8 V / 0,9 V | 118 fA / 56 fA (27 °C) · 3,0 pA / 1,07 pA (85 °C) | idem |
| Misma medida con gmin por defecto | 1,9–7,7 pA (artefacto) | idem, filas `gmin12` |
| Corriente de entrada del `inv_1` | 0 (el modelo no tiene fuga de compuerta) | idem |
| Umbral del `inv_1` (Vin = Vout) | 0,791 V (27 °C) · 0,811 V (85 °C) | idem |
| Capacidad del fotodiodo 3 × 3 a 1,8 V inversa, solo área (lo que Magic extrae) | 0,34 fF | `sim/cap_fd.sp`; modelo `libs.tech/ngspice/parasitics/sky130_fd_pr__model__parasitic__diode_ps2dn.model.spice` l.21-26 (cj 7,85e-5 F/m²·mult, mj 0,49, pb 0,5348; cjsw 8,17e-10 F/m·mult, mjsw 0,20); mult. tt `corners/tt/nonfet.spice` l.27-28 (0,9858 / 1,0116) |
| Idem con perímetro pj = 12 µm | 7,7 fF (1,8 V) · 8,6 fF (0,9 V) | idem: el sidewall es el 95 % |
| Corriente inversa del modelo, área 9 + pj 12 | 6,5 fA (27 °C) · 11,5 pA (85 °C) | `sim/cap_fd.sp`; modelo l.32-34 (js 6,1e-17, jsw 8,1e-16, n 1,079), l.41-43 (eg 1,17, xti 1). Es el término de saturación del modelo, **no una corriente oscura medida**. Corriente oscura real del fotodiodo de sky130: `[?]` (ni el PDK ni la documentación la dan) |
| Capacidad efectiva del nodo K (ebufn_1 + inv_1 + fotodiodo con pj) | **12,4 fF** | `sim/lectura.sp`: Δt entre 1,6 V y 1,2 V con Iph = 1 nA / 100 pA / 1 pA = 4,96 µs / 49,6 µs / 4,97 ms → C = I·Δt/0,4 V |
| Carga a extraer hasta el umbral | 12,5 fC (27 °C) · 12,3 fC (85 °C) | 12,4 fF × (1,8 − Vth) |
| Ventana de conteo | 2²⁰ ciclos × 100 ns = 104,86 ms | enunciado (10 MHz) |

### Tabla: corriente de piso frente a tiempo de descarga (C = 12,4 fF, ΔV = 1,01 V)

| Corriente neta que descarga K | t = Q/I (modelo) | t_cruce simulado (`lectura.sp`, Iph sobre el fondo del circuito) | Ciclos a 10 MHz |
|---|---|---|---|
| 0 (fondo a 27 °C) | — | **no cruza**: K se estanca en 1,36 V (el pmos del ebufn_1 carga lo que el diodo descarga) | > 2²⁰ |
| 0 (fondo a 85 °C) | — | 1,296 ms (≈ 9,5 pA netos, dominados por los 11,5 pA del modelo del diodo) | 12 960 |
| 100 fA | 125 ms | 164 ms (27 °C) · 1,296 ms (85 °C, indistinguible del fondo: −0,3 µs) | 1,64 × 10⁶ / 12 957 |
| 1 pA | 12,5 ms | 10,5 ms (27 °C) · 1,090 ms (85 °C) | 104 560 / 10 897 |
| 10 pA | 1,25 ms | 1,31 ms (27 °C) · 0,646 ms (85 °C) | 13 147 / 6 464 |
| 100 pA | 125 µs | 162 µs (27 °C) · 156 µs (85 °C) | 1 616 / 1 557 |
| 1 nA | 12,5 µs | 11,4 µs (27 °C) · 11,4 µs (85 °C) | 114 / 114 |

### Fotocorriente mínima distinguible con 2²⁰ ciclos a 10 MHz (modelado, tt, modelos del PDK)

- **27 °C: ≈ 150 fA.** El fondo no cruza nunca (el contador satura en 2²⁰); cualquier cruce dentro de la ventana es señal.
  Escalando el caso simulado (100 fA → 164 ms): I·t ≈ 16,4 fC → I_min ≈ 16,4 fC / 104,86 ms ≈ 156 fA. Con 2²⁴ ciclos
  (1,68 s) bajaría a ≈ 10 fA, siempre que la fuga del driver se mantenga como en el modelo `[?]`.
- **85 °C: el límite no lo pone el contador sino la estabilidad del fondo.** El fondo cruza en 12 960 ciclos; un ciclo es
  7,7 × 10⁻⁵ del tiempo, o sea ≈ 0,7 fA; el ruido de disparo de los ≈ 7,7 × 10⁷ electrones que pasan en 1,3 ms es
  ≈ 1,1 × 10⁻⁴ (≈ 1 fA). Pero el fondo es ≈ 9,5 pA de corriente térmica del diodo: una deriva del 1 % del fondo
  (≈ 0,1 pA) ya vale más que cien ciclos. Sin control de temperatura o sin medir el fondo intercalado (emisor apagado /
  emisor de control), el piso útil a 85 °C es ≈ 0,1 pA (hipótesis sobre la deriva; la corriente oscura real `[?]`).
- Protocolo que se deduce: medir siempre en tríos intercalados (emisor cercano, emisor de control, nada) y restar.

## 4. Verificado / modelado / hipótesis / bloqueado

| Estado | Afirmación |
|---|---|
| Verificado | Las seis celdas pasan DRC de Magic (0) y de KLayout (0 ítems, feol+beol+offgrid), con prBoundary; capas listadas arriba |
| Verificado | Magic extrae el fotodiodo como `ps2dn` con `area` (9 y 30 µm²) y sin perímetro; los emisores como `diode_pd2nw_05v5` 1,4 µm² / 4,8 µm |
| Verificado | El PDK instalado no tiene celda ni modelo propio `sky130_fd_pr__photodiode`; el único modelo aplicable es el parásito `ps2dn` |
| Verificado | Ni Magic ni KLayout comprueban photo.5–photo.11 ni nwell.7 contra el photo; KLayout exige 6,3 µm (dnwell.2) y Magic 5,3 µm (photo.4) entre photo y dnwell |
| Verificado | Con gmin por defecto ngspice inventa 1,8–7,7 pA de fuga; con gmin 1e-18 el `ebufn_1` en Z fuga 32 fA / 0,41 pA (A = 1, 1,8 V, 27 / 85 °C) |
| Modelado | C del fotodiodo 3 × 3 = 0,34 fF (área) ó 7,7 fF (área + 12 µm de perímetro); C del nodo de lectura 12,4 fF; corriente inversa del modelo 6,5 fA / 11,5 pA |
| Modelado | Piso de fotocorriente ≈ 150 fA a 27 °C con 2²⁰ ciclos a 10 MHz; a 85 °C el piso lo fija la deriva del fondo (≈ 0,1 pA si deriva 1 %) |
| Hipótesis | photo.2/8/10 fijan solo el lado corto: `photon_fd_l10` sería legal. Si fijan el cuadrado, no |
| Hipótesis | El anillo p+ GUARD reduce el acoplamiento por huecos del PNP vertical del emisor; sin medir |
| Hipótesis | El control a 40 µm separa acoplamiento por distancia de artefactos eléctricos; no separa calor local (faltaría la resistencia de poly) |
| Bloqueado | Corriente oscura real, responsividad y capacidad medida del fotodiodo de sky130: no están en el PDK ni en la documentación leída `[?]` |
| Bloqueado | Emisión del diodo p+/nwell en directa a 1,8 V: ninguna fuente la cuantifica para sky130; el presupuesto de fotones de PESCA_OPTO §6 (6–60 pA a 100 µA con IQE de 65 nm) es de otro proceso |
| Bloqueado | LVS: los puertos de sustrato (A, GUARD) se funden en extracción; el símbolo de referencia para LVS no existe. Nada se enrutó aún en metal |

## 5. Reproducción exacta

```
cd macros/photon
docker run --rm -v "$PWD":/work hpretl/iic-osic-tools:2025.07 --skip bash -c \
  'cd /work && magic -dnull -noconsole -rcfile /foss/pdks/sky130A/libs.tech/magic/sky130A.magicrc fotodiodo.tcl \
            && magic -dnull -noconsole -rcfile /foss/pdks/sky130A/libs.tech/magic/sky130A.magicrc emisor.tcl'
# DRC KLayout + prBoundary + capas (monta macros/ porque usa ../constriccion/add_prboundary.py)
docker run --rm -v "$PWD/..":/work hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /work/photon && ./drc_klayout.sh'
# Simulaciones
docker run --rm -v "$PWD":/work hpretl/iic-osic-tools:2025.07 --skip bash -c \
  'cd /work/sim && ngspice -b fuga_ebufn.sp | grep "gmin\|vth" ; ngspice -b cap_fd.sp | grep "T=" ; ngspice -b lectura.sp | grep "T="'
```

Archivos: `comun.tcl` (procedimientos y notas de los tropiezos), `fotodiodo.tcl`, `emisor.tcl`, `drc_klayout.sh`, `capas.py`,
`cuenta_lyrdb.py`, `sim/fuga_ebufn.sp`, `sim/cap_fd.sp`, `sim/lectura.sp`. Lectura de fuentes externas y del paper del LED de
silicio: `../../docs/pesca/PESCA_PHOTON_1105.md`.
