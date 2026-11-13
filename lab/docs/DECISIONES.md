# Decisiones (registro fechado)

Formato: fecha · decisión · alternativas · criterio · qué la revertiría.

## 2026-11-04 12:08 EST · Nace EFL-D con repo propio; nada decidido sobre envío
- **Decisión:** versionar desde hoy en `05_exotic_lab/` (git local, privado, sin remoto) el laboratorio digital: Cronista y bancos A, R,
  E, T, M, X, P. **No se decide qué se envía ni a qué shuttle.**
- **Alternativas:** meterlo en `project-hat` (descartado: ese repo es el sombrero y el titular de SKY26d); esperar al curso analógico
  (descartado: el instrumento y los bancos digitales no necesitan nada del analógico).
- **Criterio:** Juan, 2026-11-04: "exotic foundry digital, comencemos con el versionado sin decidir qué shippear aún".
- **Lo revertiría:** que Juan decida fusionar con otro chip o que el shuttle elegido no admita osciladores libres `[?]`.

## 2026-11-04 · Lo analógico se separa, no se borra
- La Fragua completa, la optoelectrónica monolítica, la bomba y el SPAD quedan listados en `EQUIPO.md` como "espera al analógico", con la
  pesca que los sustenta. Ninguna estructura que necesite `ua`, layout a mano o más de 1,8 V entra en EFL-D.

## 2026-11-04 · Correcciones aceptadas de revisiones externas (para no repetirlas)
- Los 500 Ω y 4 mA de la ruta `ua` de TT son cota y régimen, no protección ni límite de energía (error del agente).
- Con 7, 19, 51 y 139 etapas las razones son 2,71, 2,68, 2,73 (f ∝ 1/N), no 3, 2,83, 2,71 (error del agente, arrastrado de la nota de
  6/18/51/138).
- La difusión de minoritarios cruza 10 µm en ~100 ns y 40 µm en ~1,6 µs (L²/D, D ≈ 10 cm²/s): un control a 1 kHz no separa fotones de
  portadores; hay que modular a MHz.
- El sobreimpulso capacitivo (hasta 5 pF a 3,3 V en la ruta de TT, ~27 pJ) exige limitador 1T1R en el chip para cualquier formación.

## 2026-11-04 (tarde) · Exotic Cell = estructura física, no circuito; EFL-D lleva precursores
- **Decisión:** la carga del chip son cuatro bancos de precursores (Constricción, Chispa fría, Trampa, Parásito) y el Cronista como
  herramienta. Las arquitecturas con celdas estándar (p-bits, Ising, memoria circulante...) pasan a biblioteca secundaria.
- **Alternativas:** el equipo de la mañana (bancos de caracterización) y el de mediodía (seis arquitecturas); ambos descartados por Juan:
  medían el proceso o reinventaban circuitos, no hacían emerger estructuras.
- **Criterio:** texto externo pegado por Juan el 2026-11-04 ("¿Qué componentes físicos podemos hacer emerger de SKY130 que su biblioteca
  no sabe describir ni ofrecer?") y su "mi intención va por aquí".
- **Consecuencia:** "digital" = flujo digital + macros pasivos en Magic; se excluye > 1,8 V y `ua`. Cinco de los seis territorios caben.
- **Lo revertiría:** que Tiny Tapeout no acepte el estrés intencional (pregunta pendiente a Matt) o que ningún precursor se forme a 1,8 V
  en simulación; entonces EFL-D se reduce a ruta A (Chispa fría, Parásito) y la ruta B espera al analógico.

## 2026-11-04 (noche) · Primera entrega física: GDS del precursor Constricción, 4 variantes, DRC limpio
- **Hecho:** `macros/constriccion/` (M1, M2, L1, L2) por script en Magic; 0 errores en Magic y en KLayout `sky130A_mr.drc`; LEF a mano con A/B
  separados; ngspice de la corriente que dan N `buf_16` (2,4 mA por búfer, fuente de corriente para R < 30 Ω). Detalle en su `LEEME.md`.
- **Correcciones del revisor aplicadas:** el cuello no baja del mínimo (0,14/0,17 µm), la línea se ensancha; los drivers no son limitador
  diseñado (se anota como autolimitación parcial); el Cronista detecta, no identifica; la integración del macro en el flujo es el primer
  experimento de ingeniería, pendiente.
- **Hallazgo:** con 9 `mcon` por cabeza, el contacto se forma antes que la línea a N ≥ 2. Segunda iteración: ≥ 36 contactos.
- **Nota:** la observación del revisor sobre `EQUIPO.md` (que aún listaba Gemelos, Hambriento...) era de la versión de la mañana; la vigente
  (`cd1af12`) ya tiene la jerarquía única de cuatro precursores.

## 2026-11-04 (noche, 2) · Revisión externa de la propuesta 1×2: aceptada; EFLD-00 antes de dimensionar nada
- **Aceptado:** no fijar 12 constricciones ni el floorplan; Parásito se reduce a una capacidad de referencia; Trampa busca estados
  persistentes programables, no solo deriva; la victoria siguiente es EFLD-00 (un precursor + un lector + una referencia por OpenLane,
  con LVS, extracción y lectura ante ΔR hasta circuito abierto), no otro DRC limpio.
- **Comprobado esta noche:** (1) la unión p+/n+ abutida es legal en sky130 (Magic y KLayout 0); d = 0,13 viola `difftap.3`; d ≥ 0,27 legal
  (`macros/chispa/LEEME.md`). (2) La línea como `res_generic_m1`/`_l1` extrae un dispositivo A–B de dos terminales; li1 como resistencia
  exige 0,29 µm (`MR_li.WID.4`) (`macros/constriccion/LEEME.md`).
- **Errores del agente registrados:** 1,8 ps y no 20 ps; 36 contactos no dan 3×; tiempos de formación sin modelo.
- **Decide Juan:** li1 a 0,29 como resistencia o a 0,17 sin capa de resistencia.

## 2026-11-04 (noche, 3) · EFLD-00 = infraestructura; EFLD-01 = descubrimiento; la geometría nace de la transformación buscada
- **Aceptado del revisor:** optimizar una resistencia y su lector no es diseñar una Exotic Cell. Los resultados que importan son B
  (resistencia programable y estable), C (constricción atómica) y D (reconfigurable); A (circuito abierto) es un fusible.
- **Hecho:** familia A/B/C/D en met1 `rm1`, DRC 0 en Magic y KLayout, extraída (`macros/constriccion/LEEME.md`).
- **li1:** 0,29 µm con `rli` para EFLD-00; 0,17 µm se conserva como precursor distinto para EFLD-01, con otra representación para LVS.
- **2 pF:** no se fija; la capacidad de lectura se elige por observabilidad en EFLD-00 (t ≈ (R_driver + R_precursor)·C).
- **Qué favorece B, C y D (propuesta del agente, a preregistrar):** el algoritmo de formación más que la geometría: electromigración
  con realimentación (escalones de corriente y lectura entre escalones, parada al alcanzar una R objetivo), drivers en los **dos**
  extremos para corriente bidireccional (la inversión de flujo repara huecos: candidato a D), y recocido a corriente cero (recuperación).
  El estado "liner de TiN conduce, Al migrado" es la región de B. Nada de esto está demostrado en sky130.

## 2026-11-04 (noche, 4) · Síntesis externa: recuperar la ruta A entera; regla 15; un dado o dos sin decidir
- **Aceptado:** (1) la formación también ocurre en la fundición: antena, proximidad, esfuerzos, interfaces; entra "El Grabado" como
  familia de ruta A en `EQUIPO.md`. (2) El decap no aísla térmicamente: corregido en `PROPUESTA_CHIP.md` y anotado en `FILOSOFIA.md`.
  (3) EFL-D y EFL01 híbrido no son necesariamente dos dados: la plantilla analógica trae pines digitales; se decide tras EFLD-00 por
  capacidad instrumental. (4) Regla 15: explorar lo que el proceso provoca, no solo lo que permite.
- **Cartera adoptada como propuesta:** EFL01 / EFL02 / infraestructura, según el texto externo; cantidades por área real.
- **Verificado:** Caltech VLSI 2025 existe y es bulk 180 nm sin modificar el proceso; fuente externa y grabado posterior no confirmados en
  la página (`pesca` §4b). Va a EFL02 como fotónica posprocesada.
- **Diseño generativo:** se mantiene como etapa posterior (primero un modelo experimental con incertidumbre; después aprendizaje activo),
  como se dijo en la primera respuesta del día. Biblioteca paramétrica de precursores: sí, desde ya, porque `dibujar.tcl` y `familia.tcl`
  ya son paramétricos.
- **Error de método reconocido:** descartar líneas cada vez que llegaba una propuesta nueva. La cartera se acumula; se poda por compuertas,
  no por recencia.

## 2026-11-04 (noche, 5) · Yunque v0.4: cuatro mecanismos, PHOTON de vuelta, dos configuraciones versionadas
- **Aceptado de la revisión externa:** PHOTON vuelve como región (había quedado fuera por error del agente, contra la síntesis anterior);
  Forge amplía a contactos e interfaces y aísla formación de lectura; Grabado pasa a factorial 2×2 con control del efecto del diodo;
  Trampa se reduce y especializa dentro de Grabado; referencias locales por región; la franja híbrida deja de ser "opcional" y se
  convierte en dos configuraciones (EFLD-00 digital 1×2 / Yunque EFL01 híbrido 2×2); nivel 3 de éxito = función gobernable; vírgenes y
  censurados distintos; el decap cercano agrava el sobreimpulso.
- **Añadido por el agente:** predicción escrita para PHOTON en directa (ganará el transporte de portadores; el valor es la plataforma y los
  controles). Avalancha sigue en EFL02.
- **Nombre:** Yunque se mantiene. v0.3 conservada como historia (`64695e4`).

## 2026-11-04 (noche, 6) · v0.4 congelada; EFLD-00 arranca en el banco físico
- **Aceptado de la revisión externa:** no abrir v0.5 hasta tener un resultado medido que lo exija. Cuatro precisiones de contrato
  (PHOTON con tres observaciones; Grabado con topología por etapa; Forge como "escribir y leer un estado", `mcon` auditado aparte;
  floorplan desde esquema y metrología) anotadas en `PROPUESTA_CHIP.md`, sección "Congelación de v0.4".
- **Corregido:** "inversión del sentido para reparar" pasa a variable sin resultado asumido.
- **EFLD-00 abierto en `local_flow/efld_00`** (repo git propio, fuera de este repo): RTL `tt_um_jcrogomez_efld00` con dos instancias
  del macro `efld_consR_M1` (DUT y gemelo virgen), 8 `ebufn_8` triestado por lado con enclavamiento y vigilante de 2^20 ciclos, anillo
  de 13 inversiones con 32 cargas de puerta en B, prescaler /256 de rizo (`dfrbp_1`) y contador de ventana. Configuración: `MACROS`
  con GDS/LEF/`nl`/`spice`, `EXTRA_SPICE_MODELS` para LVS, halos de 2 µm, `ERROR_ON_SYNTH_CHECKS: false` (lazo combinacional y
  nodo con varios drivers; LibreLane aborta por defecto). **Lo que lo revertiría:** que el flujo o el precheck de TT no acepten la
  configuración; entonces la plataforma cambia de forma, no el objetivo.
- **Verificado:** con la capa `rm1`, Magic escribe LEF con pines A y B separados, y el GDS releído en un Magic limpio extrae el mismo
  `R0 A B res_generic_m1 w=0.14 l=10` (`macros/constriccion/lef_resR.tcl`).

## 2026-11-04 (noche, 7) · EFLD-00 pasa el flujo; lo que midió cambia el diseño de la formación
- **Demostrado** (`local_flow/efld_00/LEEME.md`): el macro pasivo entra en LibreLane como `MACROS` (hizo falta `prBoundary` en el GDS,
  `IGNORE_DISCONNECTED_MODULES` y extracción desde GDS); DRC 0; **LVS compara la resistencia de verdad** (con extracción desde LEF el
  macro era una caja vacía y el "LVS limpio" no decía nada: error que habría pasado desapercibido); dos instancias fijas; antena 0;
  cocotb 2/2 (referencia y DUT cuentan igual; DUT abierto da 0 y la referencia sigue; enclavamiento con flanco de ARM, llave,
  vigilante).
- **Medido en ngspice:** el lector tiene rango útil ~1 kΩ–300 kΩ y detecta abierto; no lee pocos ohmios (regla 3 ya lo decía). Los
  `ebufn_8` triestado dan 0,51 mA por pareja (4,1 mA con 8), no los 2,4 mA del `buf_16`.
- **Decisión forzada por medida:** el eslabón débil de la formación son las vías de un corte del enrutador (14× su régimen con N = 8), no
  el macro. Antes de cualquier Fragua en flujo digital: cabezas con varios pines (una vía por driver) o Constricción de li1 (argumento
  térmico: disipa ~100× más que cualquier vía con la misma corriente). Esto reabre la pregunta li1 0,29/0,17 con un argumento nuevo a
  favor de li1. **Lo que lo revertiría:** vías multi-corte disponibles en el flujo, o un precheck de TT que rechace macros/NDR.
- **Errores propios de la sesión:** salida del anillo en reposo a 1 que enmascaraba al otro anillo por el OR (lo encontró cocotb);
  modelo `tran` que daba X durante la formación (pasa a `rtranif0`); 25 min de simulación colgada por modelos del PDK con retardo cero.
- **Pendiente:** simulación GL (SDF), parásitos del macro, precheck de TT, pregunta a Matt (permiso de estrés y configuración).

## 2026-11-05 (madrugada) · EFLD-01: el camino de formación deja de depender del enrutador
- **Demostrado** (`local_flow/efld_01/LEEME.md`): macro `efld01c_M1` con cabezas en cadena (18 pines; tramos de met1 como `rm1` para que
  Magic extraiga cada pin como nodo), 8 `ebufn_4` por lado cada uno con su red y su pin; DRC 0, solapes 0, antena 0, LVS 17/17
  resistencias; cocotb 2/2. Cada vía de formación lleva 0,26 mA: 0,71× (L1M1) y 0,89× (M1M2) de su régimen LEF; la línea de met1 queda
  a 5,3× con N = 8. **Por primera vez el único elemento por encima de régimen es el precursor.**
- **Lección de flujo:** lo que Magic extrae como dispositivo debe ir obstruido en el LEF; el LEF de Magic con `-hide` no cubría los tramos
  `rm1` y el enrutador pasó met1 encima (8 DRC en la corrida 1). `lef_obs_cadena.py` lo corrige.
- **Lo que no cambia:** 2 mA en met1 mínimo no tienen tiempo de transformación conocido; el vigilante comparte reloj y alimentación con el
  resto (no es independiente); GL, parásitos, precheck y permiso siguen pendientes.
- **Decisión que abre:** con drivers por pin, subir la corriente es añadir pines y drivers (paramétrico), no ensanchar redes. Y la
  asimetría DUT/referencia en parásitos (SPEF de EFLD-00: nB 22 fF frente a rB 8 fF) se corrige dando a la referencia los mismos
  drivers (apagados siempre) en EFLD-01b.

## 2026-11-11 21:03 EST · El chip se llama MISFIT; repo público; CARTERA es la lista maestra

Decisiones de Juan en la sesión del 2026-11-11:
- **Nombre del chip: MISFIT** ("en lugar de MOSFET"). "Yunque" queda como nombre histórico de las propuestas v0.2–v0.4.
- **Repo público** `github.com/jcrogomez/exotic-cells` (carpeta `06_exotic_cells`): README y documentos en inglés; las notas de
  investigación siguen en español en este repo privado.
- **`docs/CARTERA.md` es la lista maestra** (36 familias, `XC-nn`); no se espera a la lista de 24 del chat externo.
- Hecho de la sesión: brecha `sa/sb` confirmada (`macros/grabado_lod/LEEME.md`) y primer módulo de Residual escrito y probado
  (`06_exotic_cells/residual/`).

Lo que lo revertiría: nada previsto para el nombre; la licencia del repo público sigue sin decidir.

## 2026-11-11 22:42 EST · Noche del 11 al 12 de noviembre: plan ejecutado en el repo público

Todo lo de esta noche vive en `06_exotic_cells` (repo público `exotic-cells`); aquí solo punteros, para no duplicar números.
Preregistros en `cells/preregistros/` (plan de la noche; ruido y detección), publicados antes de correr cada bloque.

Hechos que cambian decisiones (todos modelo, extracción o layout; nada silicio):
- **El DRC "limpio" de la auditoría LOD no lo era** bajo el juego completo de reglas: faltaba toma de sustrato (LU.2). El control de
  ancho de met1 del escáner de bordes destapó que Magic, con `drc(fast)` y la caja sobre la última forma, puede no reportar nada.
  Desde hoy: DRC siempre con `drc(full)` y sobre toda la celda. Revisados esa misma noche los 26 `.mag` de `macros/` (sobre
  copias, con `recheck.tcl`): 23 limpios, 3 con violación:
  - `constriccion efld_consR_L1 violations=1 Local interconnect width < 0.29um (li.7)`
  - `constriccion efld_consR_L2 violations=1 Local interconnect width < 0.29um (li.7)`
  - `chispa chispa_d013 violations=1 Diffusion spacing < 0.27um (diff/tap.3)`
- **El PDK trae dos decks de KLayout**: el de reglas de fabricación (`sky130A_mr.drc`) no tiene poly.7 ni licon.11; el completo
  (`sky130A.lydrc`) sí, pero viene con la sección FEOL apagada (`FEOL = false`) y tal cual no reporta nada. Encendida, coincide con
  Magic. Repetido esa noche sobre copias de los 39 GDS de `macros/` con el deck completo y FEOL encendido: 26 limpios; `chispa_d013`
  con difftap.3 (ya se sabía ilegal); y **las 12 celdas de `photon` con violaciones**: photo.9 (4 cada una) en todas, y además
  photo.2, photo.8 y photo.10 en `photon_fd_l10`.
  **Contradice `NIGHT_SPRINT_2026-11-05.md`**, que da las seis celdas PHOTON como "DRC Magic 0 y KLayout 0" y dice que ninguna
  herramienta comprueba photo.5–11. Sí hay una que las comprueba: el deck completo, que entonces no se corrió. No corrijo aquel
  documento en silencio: queda anotado aquí; las celdas PHOTON no pueden citarse como limpias. Si son ilegales o si la regla photo.9 está mal escrita en ese deck (su
  expresión es rara: exige bordes de exactamente 12,0 µm) no lo he comprobado contra el texto de la regla. `[pendiente; decide Juan]`
- **La biblioteca estándar anotada**: anillos entre 2,5 % y 5 % más rápidos, al revés de lo predicho (el pfet gana más de lo que el
  nfet pierde). Falta saber cómo se caracterizó la biblioteca.
- **XC-19**: gemelo de la misma geometría (el largo queda descartado, también con cascodo); precarga de umbral alto y canal largo;
  polarización por cadena con 16 espejos dibujados como el DUT; el punto de 81 pA y 2 fF se abandona por ruido de disparo y pasa a
  5,5 nA con unos 135 fF. Primer layout del proyecto: `xc19_read`, `xc19_bias`, `xc19_channel` (130 µm², DRC 0 en Magic y KLayout).
- **Revisión externa del 11-nov** (pegada por Juan): confirmados y corregidos dos fallos nuestros (el anotador no comparaba el
  cuerpo; la variante exploratoria anunciaba una precarga que no instanciaba). Su recomendación de alcance, una pregunta física y
  un instrumento para el primer dado, queda como recomendación en `docs/PROPOSAL.md`; **decide Juan**.
- **Compuerta nueva de envío**: informe de borde (reglas a un paso de rejilla, reglas que solo un deck comprueba, discrepancias).

No corrido: integración de la celda en el flujo digital (N7). Falta decidir cómo recibe alimentación un macro con transistores.
