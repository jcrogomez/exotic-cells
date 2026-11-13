# Precursor "La Constricción" — primera entrega: GDS de cuatro variantes con DRC limpio (2026-11-04)

Todo lo de aquí se regenera con `dibujar.tcl` (Magic) y `lef_ab.py`; nada está dibujado a mano. Herramientas: imagen Docker
`hpretl/iic-osic-tools:2025.07` (Magic con `sky130A.magicrc`, KLayout 2024.2.11 con `sky130A_mr.drc`, ngspice con `sky130.lib.spice tt`).

## Qué se dibujó

| Variante | Capa | Línea (10 µm de largo) | Cuello (1 µm, centrado) | R estimada (LEF: met1 0,145 Ω/sq, li1 17 Ω/sq) |
|---|---|---|---|---|
| M1 | met1 | 0,14 µm uniforme (mínimo) | — | 71 sq → **10,4 Ω** |
| M2 | met1 | 0,50 µm | 0,14 µm | 18 + 7 sq → **3,6 Ω** |
| L1 | li1 | 0,17 µm uniforme (mínimo) | — | 59 sq → **1.000 Ω** |
| L2 | li1 | 0,50 µm | 0,17 µm | 18 + 6 sq → **410 Ω** |

Cabezas en los extremos: 1,2 × 1,2 µm de li1 + met1 con 3 × 3 `mcon`. Pines A y B en met1. Tamaño del macro: 12,4 × 1,2 µm.
Corrección del revisor aplicada: la constricción **no** baja del ancho mínimo; es la línea la que se ensancha a 0,50 µm y el cuello queda
en el mínimo legal (0,14 / 0,17 µm). La relación de densidad de corriente línea:cuello es 3,6:1.

## Resultados

- **DRC Magic:** 0 errores en las cuatro (`Total DRC errors found: 0`).
- **DRC KLayout** (`sky130A_mr.drc`, feol+beol+offgrid): 0 ítems en las cuatro (244 categorías evaluadas). Informes `*.lyrdb`, no versionados.
- **GDS:** capas 67/20 (li1), 67/44 (mcon), 68/20 (met1), 68/5 y 68/16 (etiqueta y pin de met1). Comprobado con KLayout.
- **LEF:** Magic fusiona A y B en un solo pin porque son el mismo nodo eléctrico (una resistencia es un corto para la conectividad).
  `lef_ab.py` escribe el LEF a mano con A y B separados y el resto como obstrucción. **Abierto:** cómo trata LVS del flujo un macro cuyo
  netlist es una resistencia entre A y B; se resuelve en la integración con OpenLane (siguiente paso), no aquí.

## Corriente que meten los drivers digitales (ngspice, `sim/p{1,2,4,8}.sp`, `sim/corriente_drivers.txt`)

N copias de `sky130_fd_sc_hd__buf_16` en paralelo, entrada a 1,8 V, salida a la línea R a tierra, DC, tt, 27 °C.

| N | R = 3,6 Ω (M2) | 10,4 Ω (M1) | 410 Ω (L2) | 1.000 Ω (L1) |
|---|---|---|---|---|
| 1 | 2,38 mA | 2,37 mA | 2,02 mA | 1,38 mA |
| 2 | 4,75 | 4,72 | 3,14 | 1,60 |
| 4 | 9,47 | 9,37 | 3,78 | 1,70 |
| 8 | 18,8 | 18,5 | 4,09 | 1,75 |

Lectura:
- Para las líneas de met1 (pocos ohmios) el driver **sí se comporta como fuente de corriente**: ~2,4 mA por búfer, casi independiente de R
  hasta ~30 Ω (saturación del pfet). Cuando la línea se degrade por encima de eso la corriente cae sola: la formación es autolimitada.
  Responde en parte a la corrección 1 del revisor; no sustituye a un limitador diseñado.
- Para li1 (cientos de ohmios) la formación está limitada por tensión: 1,4–1,75 mA, es decir 2,5–3 mW en ~1,7 µm² de TiN. `[est]` que
  funde; ngspice no modela ni fusión ni electromigración.
- Densidad en met1 mínimo: 2,37 mA → 4,8·10⁶ A/cm² (6× el régimen del LEF, 0,39 mA); 18,5 mA → 3,8·10⁷ A/cm² (47×).
- **El eslabón débil hoy son las cabezas:** 9 `mcon` × 0,36 mA = 3,2 mA de régimen. Con N = 8 cada contacto lleva 2 mA (5,7× su régimen):
  se formaría primero el contacto, que es lo que el revisor advirtió. **Segunda iteración:** cabezas con ≥ 36 contactos (o formar con N ≤ 1).
- 18 mA de DC son ~0,1 V de caída en la PDN de TT; aceptable, pero se declara.

## Lo que esta entrega no demuestra

Que el macro se integre en el flujo digital de Tiny Tapeout (LEF/GDS en OpenLane, LVS con un macro resistivo, precheck); que Tiny Tapeout
acepte la formación por estrés; que lo que cambie el retardo de un anillo sea una constricción y no un contacto (corrección 3 del revisor:
el Cronista detecta transformación, no la identifica). Nada de física del proceso: solo geometría legal y corriente disponible.

## Siguiente

1. Cabezas con 6 × 6 contactos y re-DRC (misma receta).
2. Integración en OpenLane (`local_flow/efld_00`): un anillo de referencia + M1 como macro, DRC/LVS/precheck del flujo.
3. Mensaje a Matt (estrés intencional).
4. Preregistro de la Constricción.

## Segunda pasada (misma noche): la línea como resistencia extraíble (`resistor.tcl`, celdas `efld_consR_*`)

Respuesta a la corrección 2 del revisor ("no basta con escribir dos nombres en el LEF"). La línea se pinta en la capa de resistencia de
Magic (`rm1` para met1, `rli` para li1; GDS 68/13 y 67/13). Magic extrae entonces un **dispositivo de dos terminales**:

```
.subckt efld_consR_M1 A B
R0 A B sky130_fd_pr__res_generic_m1 w=0.14 l=10
.ends
```
(M2: `w=0.14 l=1.28`, equivalente colapsado del cuello; L1: `res_generic_l1 w=0.17 l=10`; L2: `w=0.17 l=1.34`.) Con esto el netlist del
macro tiene A y B distintos y LVS tiene contra qué comparar; la demostración de que el enrutador no crea atajo sigue pendiente de EFLD-00.

DRC: Magic 0 en las cuatro. KLayout 0 en M1 y M2; **L1 y L2 fallan `MR_li.WID.4`: la resistencia de li1 exige ≥ 0,29 µm de ancho**
(la li1 normal admite 0,17). Decisión pendiente de Juan: (a) li1 como resistencia a 0,29 µm (R ≈ 590 Ω por 10 µm; pierde el "mínimo"),
o (b) li1 a 0,17 sin capa de resistencia y LVS resuelto de otra forma. Para met1 no hay conflicto: `rm1` a 0,14 pasa.

## Correcciones aceptadas de la revisión de la noche
- Sensibilidad: con 89 Ω y 200 fF, un 10 % de ΔR son **1,8 ps**, no 20 ps (error del agente). Un anillo de inversores no lee ΔR pequeñas
  de met1; hace falta que la etapa RC domine el período (carga de ~2 pF: 89 Ω × 2 pF = 178 ps, 10 % → 18 ps) y un segundo régimen que no
  dependa de que el anillo siga oscilando (resistencia-a-tiempo o anillo dominado por RC que sobreviva hasta ~100 kΩ). Se diseña en EFLD-00.
- Contactos: con 8–9 mA, 36 `mcon` dan 1,6× de margen; 3× exige ~70–80 por cabeza, o formar con ≤ 2 búferes (4,7 mA → 40 contactos).
- Superar el régimen del LEF no es un modelo de tiempo a fallo; ngspice no demuestra electromigración ni fusión. Los tiempos (li1 en
  minutos, met1 en horas) se retiran como predicción y pasan a pregunta.
- Toma intermedia C: variantes con y sin C, porque la toma altera la distribución de corriente.

## EFLD-01: familia de precursores por hipótesis física (`familia.tcl`, celdas `efld01_*`, misma noche)

Pedida por la revisión: una familia que pregunte cómo la geometría gobierna la transformación, no una resistencia con anchos. Met1 con
`rm1`, línea de 0,50 µm y 10 µm, cuellos de 1 µm, cabezas de 9 `mcon` (las cabezas se redimensionan en EFLD-00).

| Celda | Geometría | Pregunta física |
|---|---|---|
| A | uniforme 0,14 µm | control: transformación sin punto de nucleación diseñado |
| B | un cuello 0,14 centrado | ¿concentra la formación? |
| C | dos cuellos iguales 0,14 en x = 1/3 y 2/3 | ¿la formación elige una al azar? |
| D | dos cuellos 0,14 y 0,17 en las mismas posiciones | ¿una asimetría del 20 % fija la preferencia? |

DRC: Magic 0 y KLayout 0 en las cuatro. Extracción: `R0 A B sky130_fd_pr__res_generic_m1` con `l` equivalente 10 / 1,28 / 2,56 / 2,24 µm
(Magic colapsa la geometría a una resistencia; para C y D no distingue los dos cuellos: la localización se hará con tomas, no con la
extracción).

**Fusible del PDK:** en el tech de Magic solo aparece `sky130_fd_pr__fuse_m4` (fusible de met4); ni el deck de KLayout ni `libs.ref` traen
reglas o celda de fusible de met1 en esta instalación de sky130A. La referencia convencional, si se usa, sería un fusible de met4 `[?]`.

## EFLD-00 (noche del 4-nov, tarde): la plataforma pasa el flujo; lo que mide el lector; lo que limita la formación

Proyecto en `local_flow/efld_00` (repo git propio). Resultados en su `LEEME.md`. Aquí solo lo que cambia lo dicho arriba:

- **Lector** (ngspice, `sim/efld00_lector_drivers.txt`): el anillo con la Constricción en serie y 32 cargas de puerta en B tiene
  período 2,99 ns con 10 Ω; **+1,7 % con 1 kΩ, +32 % con 10 kΩ, ×2,2 con 100 kΩ, satura hacia 1 MΩ (×3,1) y muere con la línea
  abierta.** Es decir: lee el estado "kΩ" (la hipótesis del liner de TiN) y el abierto; no lee ΔR de pocos ohmios en met1, como ya
  se había concluido. Rango útil: ~1 kΩ a ~300 kΩ. Con R ≥ 100 kΩ el nodo B queda cerca del umbral y las 33 entradas consumen 0,3 mA.
- **Drivers triestado** (`ebufn_8`, necesarios para aislar formación de lectura): **0,51 mA por pareja alto/bajo**, no los 2,4 mA del
  `buf_16`; 8 parejas dan 4,1 mA. Es el pfet del `ebufn_8` quien limita (en A caen 0,15 V). Corriente máxima de formación en EFLD-00:
  4,1 mA = 10,5× el régimen LEF de met1 mínimo (0,39 mA) y 1,3× el de las 9 `mcon` de una cabeza.
- **El enrutador automático pone el eslabón débil fuera del macro:** las redes nA/nB llegan al macro por vías de un solo corte (`M1M2_PR`,
  0,29 mA de régimen) y, sin regla especial, por met1 mínimo. Con N = 8 la vía del tronco va a 14× su régimen; la línea a 10,5×. Con una
  regla no por defecto (ancho ×3, aplicada y verificada en el DEF) el metal mejora, **las vías no** (sky130 en OpenROAD no ofrece vías
  multi-corte por NDR). Consecuencia: en flujo digital puro, o se forma con N ≤ 1–2 (la línea a 1,3–2,6× y la vía a 1,8–3,5×: carrera
  ambigua), o el macro ofrece **varios pines por cabeza** para que cada driver llegue por su propia vía (siguiente iteración), o la
  Constricción es de **li1** (≈1 kΩ: con la misma corriente disipa ~100× más que cualquier vía; el mecanismo térmico favorece a la línea).
  Esto último es un argumento físico a favor de li1 como primer precursor que no teníamos.
