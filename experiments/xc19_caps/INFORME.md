# XC-19 · Condensadores reales y calibración independiente — informe

Corrido el 2026-11-13 entre las 21:37 y las 21:57 EST (mtimes de los `.log`), contra [`PREREG.md`](PREREG.md) (escrito a las
21:36:16 por `date`, antes de la primera corrida). Informe cerrado a las 21:58 EST. Todo es **modelo**: ngspice 44.2 de
`hpretl/iic-osic-tools:2025.07`, sky130A `8afc8346`, tt, 27 °C. Ninguna trampa: el salto se inyecta en la puerta.

Celda nueva: [`cells/xc19_channel_caps`](../../cells/xc19_channel_caps/README.md). No se tocó ningún archivo existente.

## 1. Qué se eligió y por qué

| Nodo | Realización | Razón |
|---|---|---|
| XA, XB (133 fF) | `nfet_01v8` 4,30 × 4,00 µm, puerta en X, fuente/drenador/cuerpo en GND | 7,7 fF/µm² sobre la excursión 1,8 → 0,9 V (inversión fuerte: C casi plana, 748 a 787 fF por 100 µm² entre 0,9 y 1,8 V, `cv.txt`). Solo usa FEOL, li y met1/met2: no depende de met3/met4 ni de capm. El salto no cambia (abajo). |
| VB (filtro) | 33 dedos `nfet_01v8` de 5,5 × 10 µm, puerta en VB | A 0,48 V el nfet da 5,52 fF/µm² (66 % de C_ox). 10 pF caben en 1815 µm², un 5 % de una baldosa 1×2. Referido a GND, no a VDD: un condensador a VDD pasaría el ruido de alimentación 1:1 a la puerta. |
| Calibración | placa met2 de X sobre placa met1 de CALA/CALB (inyección) — dibujada; condensador de referencia conmutado — solo simulado | ver §4 |

**MiM.** Comprobado en `tt-support-tools` 01d5d28 (`precheck/tech_data.py`, `tech.py`): `met5` es capa prohibida, `capm` y
`capm2` están en la lista de capas válidas, la capa superior de proyecto es `met4`. Luego `cap_mim_m3_2` (placa en met5) queda
fuera y `cap_mim_m3_1` pasa el filtro de capas; el deck `sky130A_mr.drc` del precheck sí tiene reglas capm (capm.1, capm.2a…).
**No se pasó ninguna MiM por el precheck** `[?]`. Además los proyectos digitales llevan franjas de met4 cada 38,87 µm
(`FP_PDN_VPITCH`): una MiM ocupa met4 y obliga a obstruir o cortar la red `[?]`. Por eso se eligió una opción que no depende de ello.
Densidad tt: 2,00 fF/µm² + 0,19 fF/µm. Una MiM de 8 × 8 µm en XA da 29,354 µs (+0,19 % sobre el ideal, `moscap.txt`): 3,7 veces el
área del MOS. Varactor `cap_var_lvt` a 0,48 V: 7,33 fF/µm² (88 % de C_ox), mejor que el nfet en VB, pero no se usó: añade un pozo
a GND y otra familia de dispositivo sin ganancia que haga falta.

**Baldosa.** 1×2 = 161,00 × 225,76 µm (`tech/sky130A/tile_sizes.yaml`), 36 347 µm². La celda completa ocupa 34,5 × 94,0 µm =
3244 µm², un 8,9 %; el filtro es más de la mitad.

## 2. Predicción frente a resultado

| # | Predicho | Obtenido | Fuente | |
|---|---|---|---|---|
| C1 | 17–18 µm² de MOS cap para igualar 133 fF | 4,3 × 4,0 = 17,2 µm²: 29,224 µs frente a 29,2975 µs (−0,25 %), con el canal extraído y el condensador en esquemático | `moscap.txt` | se cumple |
| C2 | post-layout 29,3 µs ± 3 % (cableado < 1 fF) | **29,963 µs, +2,27 %**. Dentro de la banda, pero el supuesto falla: el cableado nuevo de X (met2, placas, pad) añade unos 3 fF a GND, CAL y VB | `post.txt` | se cumple por poco; supuesto fallido |
| C3 | A/B < 0,1 % | 0,055 % | `post.txt` | se cumple |
| C4 | salto 0,80 ± 0,02 % | 0,8013 % (ideal 0,8014 %; post-layout 0,8013 %) | `moscap.txt`, `post.txt` | se cumple |
| C5 | fuga del condensador: 0 en simulación | 0 por construcción (`igcmod = igbmod = 0`). Umbral de daño: 0,6 nA ≈ 3,5·10⁻³ A/cm² sobre 17 µm² quita un 10 % del salto. Fuga real `[?]` | aritmética | abierto |
| C6 | MiM 8 × 8 µm equivale | 29,354 µs (+0,19 %) | `moscap.txt` | se cumple |
| C7 | 10 pF MiM: 70,6 µm de lado, 13,7 % de baldosa | aritmética; no dibujado | | — |
| C8 | nfet a 0,48 V: 20–50 % de C_ox | **66 %** (5,52 fF/µm²) | `cv.txt` | falla, a favor |
| C9 | varactor a 0,48 V ≥ 60 % de C_ox | 88 % | `cv.txt` | se cumple |
| C10 | hundimiento de VB (filtro ideal): 1 pF 0,02–0,08 mV; 10 pF 0,002–0,01 mV; sin filtro > 0,2 mV | 0,137 mV; 0,010 mV; 6,6 mV | `filt.txt` | falla a 1 pF (más alto); se cumple en el borde a 10 pF; se cumple sin filtro |
| C11 | interacción asíncrona: 10 pF < 0,01 %; 1 pF < 0,05 % | 0,0034 %; 0,0058 % | `filt.txt` | se cumple |
| C12 | filtro mínimo que cumple ambos criterios ≤ 2 pF | **falla**: hundimiento < 0,03 mV exige unos 5 pF (0,025 mV a 5 pF, 0,069 a 2 pF); la interacción se cumple incluso sin filtro (0,0058 %) | `filt.txt` | falla |
| C13 | inyección: Δt/t a ± 10 % de 2·Cc/C_ef = 0,88 % | 0,538 % (flanco a 2 µs), 0,675 % (10 µs), 0,879 % (20 µs) | `cal.txt` | solo a 20 µs |
| C14 | Δt/t cambia < 10 % con el instante; subida y bajada simétricas | **cambia un 63 %** entre 2 y 20 µs; simetría dentro de 0,7 % | `cal.txt` | falla (simetría se cumple) |

**Criterios de muerte.** Condensador MOS: no se alcanza (±5 % y A/B < 0,1 % cumplidos; salto dentro de 0,78–0,82 %). Filtro: no
se alcanza (10 pF en un 5 % de baldosa). **Calibración por inyección como escalón equivalente: muere** por C13 (−39 % y −23 % a
2 y 10 µs, más del 20 % fijado) y C14. Layout: 0 en Magic y en los dos decks de KLayout.

## 3. Post-layout de la celda dibujada

Extraída y anotada (`post.sp`, control en el mismo deck: el canal viejo con 133 fF ideales reproduce 29,2975 µs):

| | Ideal 133 fF | Dibujado |
|---|---|---|
| Descarga A / B | 29,2975 / 29,2972 µs | 29,9628 / 29,9793 µs |
| Salto por 0,305 mV | 0,8014 % | 0,8013 % |
| Una etapa, 10 mV de alimentación | −6,52 % | −6,47 % |
| Cociente A/B, 10 mV | 0,0001 % | 0,0001 % (sin desajuste) |
| Filtro en VB | ninguno | 10,17 pF (AC, `vb_ac.txt`); R de salida de la cadena 656 kΩ, τ ≈ 6,7 µs |
| B se reprecarga a los 12 µs de la conversión de A | — | A cambia −0,0018 %; VB se mueve 0,011 mV (`async.txt`) |

Si se quiere el tiempo del ideal, el generador admite `XC19_WC`: con 6,6 µs por µm de W (`moscap.txt`), W ≈ 4,20 µm. No se
redibujó para no ajustar después de ver el resultado.

Hallazgo de layout: sin blindaje, Magic extrae **0,21 fF entre XA y XB** (las dos líneas de met2 a 2,7 µm). Con eso, una
reprecarga de B en mitad de la conversión de A metería unos 0,38 fC en A: aritmética, ~0,3 % de su tiempo, un tercio de salto.
Una línea de GND en met2 entre ambas lo baja a 0,023 fF. La validez del modelo de pared lateral de Magic a esa distancia es `[?]`.

## 4. Calibración independiente del fenómeno

### 4.1 Inyección de carga (dibujada: CALA, CALB)

Cc extraída 0,595 fF (A) y 0,607 fF (B), con B en espejo de A (antes del espejo: 0,60 frente a 0,44). CALA fija en 0 o en 1,8 V
da el mismo tiempo (diferencia 0,00 ns: condensador lineal a un potencial fijo). Un flanco de 1,8 V durante la descarga:

| Flanco a | Sube | Baja | Diafonía en B | I implícita = Cc·1,8 V / Δt |
|---|---|---|---|---|
| 2 µs | +161,3 ns (+0,538 %) | −162,0 ns | −0,4 ns | 6,64 nA |
| 10 µs | +202,2 ns (+0,675 %) | −203,2 ns | −0,3 ns | 5,30 nA |
| 20 µs | +263,5 ns (+0,879 %) | −265,3 ns | −0,3 ns | 4,07 nA |

Δt = Q/I(V_X en el flanco): la corriente del DUT cae mientras baja su drenaje, así que el mismo Q pesa más tarde. Por eso **no es
equivalente a un salto ΔI/I** (que da Δt/t constante) y muere como calibración de "una carga". Lo que sí da, y por eso se deja
dibujada: una **carga absoluta** conocida por cociente de capacidades (1,07 fC = 6700 e, con Cc de la extracción), luego la
corriente absoluta I = Q/Δt y su dependencia con V_X barriendo el instante del flanco. La I implícita es aproximada: ignora el
reparto de Cc con el resto del nodo.

### 4.2 Condensador de referencia conmutado, estático durante la conversión (simulado, no dibujado)

Exploratorio, escrito después de ver 4.1; la predicción va en la cabecera de `sw.sp`. Interruptor + Cref ideal de 1,0 fF en XA
(`sw.sp`, `sw_current.sp`):

| | Δt/t con Cref conectado | Carga en apagado |
|---|---|---|
| pfet 0,42/0,15 solo (pozo a VDD) | 1,117 % | +0,11 % |
| Puerta de transmisión | 1,324 % | +0,22 % |

Predicho 0,8–0,95 % para la puerta de transmisión: **falla, alto**; las parásitas del interruptor pesan ~0,5 fF y no ~0,2. El pfet
solo da más que Cref/C (0,73 %), así que conduce en casi toda la excursión; no se miró hasta qué tensión.

La prueba que importa: moviendo la puerta del DUT −20, 0, +20 mV (la corriente cambia un factor 2,9):

| Puerta | t₀ | Conmutado | Salto 0,305 mV | Inyección a 10 µs |
|---|---|---|---|---|
| −20 mV | 50,96 µs | 1,109 % | 0,808 % | 0,600 % |
| 0 | 30,00 µs | 1,117 % | 0,801 % | 0,674 % |
| +20 mV | 17,75 µs | 1,124 % | 0,792 % | 0,807 % |

El conmutado se mueve un 1,3 % relativo para un factor 2,9 de corriente, como el salto (2,0 %); la inyección, un 34 %. **El
condensador conmutado se comporta como un ΔI/I fijo: es la calibración equivalente a una carga.** Para 0,8 %: Cref ≈ 0,57 fF
con el pfet de 0,42/0,15 (aritmética lineal desde 1,0 fF a 0,73 %/fF, sin simular). Coste: un pfet, que cabe en el pozo de la
precarga, una placa de metal y una línea digital estática por nodo. Su valor depende de las capacidades de unión del modelo;
la exactitud en silicio es `[?]`. Es interna: la comprueba el propio lector, no un instrumento externo.

### 4.3 Escalón en la puerta (en papel, no simulado)

- Acoplo capacitivo de una línea digital a VB: 0,305 mV pide Cg = 0,305 mV × 10,17 pF / 1,8 V = 1,7 fF. Pero decae con
  τ ≈ 6,7 µs, menos que una conversión, y es común a A y B: mide la sensibilidad de una etapa a su puerta, no la del cociente.
- Corriente continua en VB: 0,305 mV × 656 kΩ → 0,47 nA, una corriente que no se conoce mejor que el propio salto.
- Puerta propia del DUT tras un interruptor o una resistencia: es una puerta muestreada, que el PLAN prohíbe (kT/C de ~2 mV).
- La pendiente de puerta (n·kT/q) se puede leer sin escalón: las dos posiciones de C1 (K = 3, K = 4) cambian VB de 0,472 a
  0,317 V en el esquemático de `xc19_weak_inversion` (en este canal extraído solo se corrió K = 3), y el cociente de tiempos da el
  de corrientes. Sin VB medido no da n.

Ninguna es barata y estática a la vez. **Propuesta: condensador conmutado como calibración primaria; inyección como sonda de
carga absoluta y de I(V); el acoplo a VB como prueba común de sensibilidad de puerta.**

### 4.4 Entradas genéricas para otras familias

El mismo lector (descarga de un nodo integrador medida en tiempo) sirve a quien entregue una corriente al nodo o un desplazamiento
a la puerta. Entradas que debería exponer cada canal:

1. **Excitación controlable:** inyección de carga en X (Cc + línea digital): carga absoluta, corriente absoluta, perfil I(V).
   Para XC-58 (kT/C) es la escala en electrones (6700 e por flanco); para XC-37 (fuga de unión) y XC-40 (termopila convertida a
   corriente), la escala de corriente.
2. **Referencia:** condensador conmutado (ΔC/C conocido, independiente de la corriente) y gemelo B; poder intercambiar DUT y gemelo
   entre lectores (PLAN §3).
3. **Conversión a tiempo:** umbral del inversor + contador con reloj conocido; el mismo para todos.
4. **Ranura de DUT:** el DUT como "cualquier cosa que descargue X a GND con la puerta en VB". XC-12 (par LOD, con el lado largo en la
   fuente, `xc19_weak_inversion` N4) y XC-13 entran sin cambiar nada; XC-37 entra como diodo inverso en X. Un voltaje pequeño (XC-40)
   en serie con la puerta da 1/(n·kT/q) ≈ 2,7 %/mV: 1 µV serían 0,0027 %, por debajo del piso de una conversión.
5. **Selección de polarización por canal** (C1: K = 3 o 4) y, por el Monte Carlo (factor 50 entre DUT y gemelo), un ajuste fino
   por canal `[?]`.

## 5. Errores y límites declarados

- **Convergencia:** `post.sp` corre con `abstol = 1e-15` y no 1e-18; con 1e-18 la fuente del salto no converge en el primer
  paso. El control en el mismo deck reproduce 29,2975 µs. Se quitaron las fuentes de comportamiento de la precarga por lo mismo
  (pulsos equivalentes).
- **Residual:** `lod_annotate.py` no lee dispositivos con fuente = drenador; `annotate.py` anota los 23 activos y deja los 35
  condensadores con el estrés de referencia del modelo.
- **Fuga de puerta** fuera del modelo, en el nodo y en el filtro `[?]`.
- **No se corrió LVS** con netgen: solo inspección del netlist (58 dispositivos, los previstos).
- Copias de los netlists con puertos añadidos (`channel_vb.inc`, `channel_ga.inc`, `caps_ga.inc`), hechas por reemplazo de texto; el
  salto emulado cambia solo la conexión de la puerta del DUT A.
- Un solo corner (tt) y 27 °C; sin desajuste ni ruido con los condensadores reales.
- `sw.sp`/`sw_current.sp`, la celda espejada y el blindaje vienen después de ver resultados: exploratorios, no prerregistrados.

## 6. Qué falta para el macro

1. **Dibujar el condensador conmutado** (pfet en el pozo de la precarga + Cref ≈ 0,57 fF) y sus líneas CALSWA/CALSWB; simular la
   celda extraída con él.
2. **Pines** en rejilla de rutado (hoy met1/met2/li, fuera de rejilla) y decidir si VB sale como pin de prueba o queda interno.
3. **LEF** con obstrucciones: li, met1 y met2 ocupan toda la celda; met3/met4 libres.
4. **Alimentación:** VDD/GND como pines de alimentación conectados a las franjas de met4 (cada 38,87 µm), o por señales ordinarias
   como los macros pasivos anteriores. Sin decidir.
5. **Inversor de umbral y contador**, y el **hilo real de X al inversor**: hoy X sale en met2 y el inversor es ideal de biblioteca en
   el testbench. La capacidad de ese hilo entra en el nodo (cada fF es un 0,7 % del tiempo).
6. **Drivers de CAL** en el flujo digital: el flanco debe ir a un instante fijo tras soltar (Δt depende de él).
7. Monte Carlo y corners con los condensadores; ruido de disparo con el nodo dibujado; LVS formal.
8. Si el filtro se repite por canal en la matriz: 5 pF bastan para < 0,03 mV de hundimiento (0,025 mV con filtro ideal), unos
   900 µm² en vez de 1815. La interacción no lo pide; el hundimiento por sí solo apenas mueve el tiempo (§3).

## Archivos

`cv.sp` C(V) de candidatos · `moscap.sp` dimensionado y salto · `filt.sp` barrido del filtro ideal · `vb_ac.sp` filtro dibujado ·
`post.sp` post-layout · `cal.sp` inyección · `sw.sp`, `sw_current.sp` condensador conmutado · `async.sp` interacción en la celda
dibujada · `summary.txt` cifras derivadas de `post.txt` y `cal.txt`. Correr: `SKY130A=<ruta> ./run.sh <deck>.sp`.
