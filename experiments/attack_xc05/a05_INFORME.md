# a05 — Informe del ataque a XC-05 (contacto de pocos canales por electromigración con lazo en el chip)

Hora de cierre (`date`): Thu Nov 12 12:46:03 EST 2026. Prerregistro: `a05_PREREG.md` (escrito antes de buscar la pila y de correr). Nada de esto es silicio.
Grados: **PDK** (ruta y línea), **corrida** (script), **leído** (abrí el texto), **no leído** (fragmento de búsqueda), **memoria**, **cálculo**.
PDK = `local_flow/pdk_host/ciel/sky130/versions/8afc8346…/sky130A`.

## Veredicto en una línea
La afirmación tal como está escrita **muere en met1 por tres causas independientes**: (a) si hay barrera, deriva 0,2–143 Ω sobre el
vacío y el contacto de 12,9 kΩ lleva < 1,2 % de la corriente; (d) con 2,06 mA la línea no se calienta (1,2 K) y no migra en tiempo
útil (≥ 10–134 años con la regla del propio PDK como ancla; los cuellos cortos y el puente quedan bajo el umbral de Blech); (e)+(f)
lo que decide el final no es el retardo del lazo sino la tensión sobre el contacto, y tanto el driver (1,79 V sobre 12,9 kΩ) como
el anillo lector (flancos de 1,8 V) superan lo que aguanta un contacto de un átomo de Al (~0,8–1 V). Sobrevive, transformada, otra
cosa: **el vacío puenteado por la barrera** como estado de Ω estable, con un lazo rápido cuyo papel real es salvar la barrera.

## Resultado contra cada predicción

| | Predicción | Resultado | |
|---|---|---|---|
| a | Pila Ti/TiN + TiN, 30–100 nm; el PDK local no la trae | **No encontré la barrera en ninguna fuente leída.** PDK: `libs.tech/magic/sky130A.tech` l. 5058 `height allm1 1.3761 0.36`, l. 5123 `resist (allm1)/metal1 125`; `metal_stack.svg` de SkyWater (leído, 119 rótulos): solo 0,36 µm y alturas; diapositivas de T. Edwards 2021 (PDF leído): "5 layers of aluminum metal", "Titanium Nitride (TiN) aka Local interconnect". Material y espesor de la barrera de met1: `[?]` | **fallada en lo documental** (ni confirmo ni desmiento la barrera) |
| a | Derivación 1–100 Ω para vacíos de 10–100 nm | 0,24–143 Ω en todo el barrido (ρ 50–400 µΩ·cm, 20–150 nm); con ρ = 128 µΩ·cm (li1 del PDK, l. 5122 × 0,10 µm) y 50 nm: 1,8 / 5,5 / 18 Ω (`a05_a_barrera.txt`) | cumplida |
| b | Vacíos que cruzan la línea con corriente por la barrera; contacto de 1 átomo de Al < 1 V; no hallaré contacto atómico en línea enterrada | Ver "Qué leí". Coincide, pero la parte de vacíos solo con fragmentos | cumplida con grado bajo |
| c | Línea: τ63 = 0,1–1 µs, ΔT(2,06 mA) = 1–5 K | τ63 = 0,47–1,25 µs (2D; t50 0,19–0,61 µs; a 10 ns va el 10 % del salto); ΔT = 1,1–1,8 K (`a05_c_termica.txt`) | cumplida (τ algo por encima con k_ox = 1,0) |
| c | Cuello corto y puente: τ < 1 ns, ΔT < 20 K | ΔT = 0,2–1,3 K; τ63 = 35–69 ns (solo capacidad del Al) a ~0,5 µs: el cuello no se calienta él, se calienta la línea entera | **fallada** (τ); ΔT cumplida |
| d | Años a nunca; línea de 10 µm marginal por Blech; cuellos y puente inmortales | Blech: línea A 89–888 MPa (Z* 1–10) frente a σ_crit 100–600: marginal, cumplida. Cuello B 31–312, cuello corto 27–268, puente entre 0,50: 26–260 MPa: **no** son inmortales en todo el barrido (la línea ancha de 0,50 aporta el 70–97 % del jL): **fallada** a medias. Tiempo: Korhonen sin calibrar da de 5·10⁻⁹ años a nunca (14 órdenes: no decide); con la regla del PDK como ancla, ≥ 10–134 años: cumplida solo con el ancla | mixta |
| e | Manda la tensión, no el retardo; R serie no protege; shunt sí pero tapa | Con umbral en kΩ y driver de 2,06 mA: abierto con los cuatro retardos. Con umbral en 30 Ω: 1 ns–10 µs paran en 30–38 Ω, 1 ms acaba abierto. **Fallada en parte:** una R serie ≥ 10 kΩ sí protege (es una fuente de corriente pequeña: V = I·R_c < 0,28 V hasta R_c = 0,28/I) | mixta |
| f | +14 / +21 / +40 %, pasos > 5 % | +16,3 / +23,6 / +38,0 %; pasos 6,2 % y 11,7 %; 1,0→0,8 G0: 4,8 % | cumplida |
| g | 0,9 aF / 92 meV salen con radio 2 nm | 0,868 aF, 92,3 meV, 13,9 kT a 77 K. XC-06 ya dice "2 nm de radio": la cuenta está bien | cumplida |

## Veredicto por sub-afirmación

**(a) Pila y derivación — MUERE la lectura de escalones en met1 con barrera; la existencia de la barrera queda `[?]`.**
R_b = ρL/(w·t_b): 0,24–143 Ω para L = 10–100 nm (corrida). Un canal (12,9 kΩ) en paralelo cambia R_total un 0,008–1,15 % y lleva esa
misma fracción de la corriente. Para que la barrera no tape haría falta R_□ ≥ 18 kΩ/□ (0,07 nm de TiN: imposible). Corrección al
PLAN y a FRONTERAS ficha 1: no es "kΩ"; un vacío hace falta de 5,5 µm para llegar a 1 kΩ (piso del lector) y de 71 µm para 12,9 kΩ
(128 µΩ·cm, 50 nm). Indicio indirecto de que hay algo que no es Al: ρ efectiva de met1 = 0,125 Ω/□ × 0,36 µm = 4,5 µΩ·cm (PDK, cálculo)
frente a ~3,0–3,3 del Al(Cu) (memoria) → ~100 nm de los 360 no conducen como aluminio. No es prueba.

**(b) ¿Contacto atómico en línea enterrada? — MUERE como mecanismo esperado; no hay antecedente.** Los contactos atómicos de Al
existen a 300 K (leído), pero hechos con rotura mecánica, en ultra-alto vacío o aire, a 20–50 mV. En una línea pasivada el vacío
crece a v = 3·10⁻¹⁰–1 nm/s a 300 K (corrida, barrido): el "paso por un átomo" dura de 0,2 s a 40 años, pero con la corriente ya
desviada por la barrera no hay nada que parar ni que leer.

**(c) Térmica — "~10 ns" MUERE; "más rápido que la mesa" SOBREVIVE.** Hay 1,376 µm de óxido hasta el sustrato (PDK), no 100 nm:
τ63 = 0,47–1,25 µs; C_Al/G' = 17–175 ns es solo el arranque. G' = 1,8–3,4 W/m·K (corrida 2D). A 2,06 mA: ΔT = 1,2 K (línea A), 0,36 K
(cuello B), 0,25 K (cuello corto), 0,23 K (puente entre líneas de 0,50). Para ΔT = 100 K hacen falta 16 mA (A) a 38 mA (puente); fusión
28–66 mA. **El puente sublitográfico no "arranca con menos corriente"**: sube j ×2,8 (1,2·10⁷ A/cm²) pero las líneas anchas lo
enfrían y su jL propio son 57 A/cm.

**(d) Electromigración — MUERE a 2,06 mA; SOBREVIVE a ≥ ~16–18 mA en línea larga.** Ancla: `sky130_fd_sc_hd__nom.tlef` l. 123
`DCCURRENTDENSITY AVERAGE 2.8 ; # mA/um Iavg_max at Tj = 90oC` → 7,8·10⁵ A/cm². Si esa regla garantiza ≥ 10 años (**memoria**,
`[?]`), Black con n = 2: a 301 K y 4,2·10⁶ A/cm², ≥ 10 / 19 / 36 / 134 años (E_a 0,5 / 0,6 / 0,7 / 0,9 eV). Con 18,5 mA (los
`buf_16` ×8 de EFLD-00, 437 K por autocalentamiento, corrida c): cota ≥ 0,3–2,6 h, y Korhonen de ms a horas. jL de la línea A a
2,06 mA = 4087 A/cm (cálculo) frente a umbrales de ~2600 y ~10⁴ A/cm (**no leído**).

**(e) El lazo — TRANSFORMADA.** Constricción difusiva: T² = T0² + V²/4L (Kohlrausch, **memoria**) → 439 K a 0,1 V, 707 K a 0,2 V,
fusión del Al a 0,276 V, con respuesta en ~ps. Con fuente de 2,06 mA eso ocurre en R_c = 134 Ω (~96 canales). El retardo decide solo
en el régimen de decenas de Ω (≤ 10 µs para; 1 ms no). Para llegar a kΩ lo que hace falta es **bajar la corriente como 1/R**
(tensión ≤ 0,1–0,3 V sobre el contacto); con tensión baja el lazo de ms basta (así lo hace Strachan en mesa), con tensión alta ni
el de 1 ns. Sobre 12,9 kΩ quedan: 1,79 V (driver solo), 1,66 / 1,01 / 0,21 V (serie 1 / 10 / 100 kΩ), 0,04–0,3 V (con barrera de
20–150 Ω, que a la vez ciega al lazo). El modelo es un juguete: vale la estructura, no los números; las mesetas en "1e+03" de
`a05_e_lazo.txt` son artefacto del cambio de régimen a 1 kΩ. Una iteración tras ver la v1 (guardada en `a05_e_lazo_v1.txt`).

**(f) Lectura — SOBREVIVE el instrumento, MUERE su uso directo.** 4,3 / 6,5 / 12,9 kΩ → períodos ×1,163 / ×1,236 / ×1,380
(interpolación PCHIP de los cinco puntos del LEEME; supuesto mío). Pero (i) con barrera la diferencia entre un canal y abierto es
0,00–0,15 ps; (ii) en cada flanco el anillo pone ~1,8 V sobre la resistencia en serie (cálculo, sin SPICE): destruye un contacto de
un átomo. Con 100 kΩ en serie: 0,21 V sobre el contacto y el paso 2→1 canal aún da 1,0 % de período; con 30 kΩ: 0,54 V y 4,1 %.

**(g) Isla de Coulomb — la cuenta SOBREVIVE, el pasajero MUERE con (a).** 0,868 aF y 92,3 meV para radio 2 nm en SiO₂ (cota
inferior de C). Con dos electrodos a 1 nm: ~1,7 aF, 46 meV, 7 kT a 77 K (cálculo de placas, grueso). En Al₂O₃ (ε≈9, memoria): 40 meV.
Con barrera en paralelo la isla lleva < 10⁻⁷ de la corriente; sin barrera, sus uniones son de GΩ y el anillo no las ve (ficha 1).

## Qué leí
- **Leído:** Mares et al., Nanotechnology 18, 265403 (2007), DOI 10.1088/0957-4484/18/26/265403 (PDF): histogramas de Al a temperatura
  ambiente en ultra-alto vacío con unión de rotura mecánica, a 20 y 50 mV, 1000–7000 trazas; también en aire. Para un átomo: tres modos
  que suman cerca de un cuanto.
- **Leído (resumen e introducción):** Yang, Chshiev, Zwolak, Chen, Di Ventra, PRB 71, 041402 (2005): las fuerzas de la corriente
  "reach bond-breaking values at about 1 V"; calentamiento local "less than about 50 K for all wires at 1 V" con buen contacto térmico;
  cita a Mizobata: la probabilidad de formar contacto de un átomo se anula hacia 1 V, y varias muestras rompen a ≤ 100 mV.
- **No leído (fragmentos):** Mizobata et al., PRB 68, 155428 (2003) (0,1–0,8 V, V crítico ≈ 0,8 V); Bell Labs, Al(Cu)/TiN in situ (el TiN
  deriva y los vacíos no migran; 403); umbral de Blech ~10⁴ A/cm en AlCu encapsulado; vacíos de rendija intragranulares en líneas "casi bambú".
- **Leído, sin el dato buscado:** `metal_stack.svg` y `rules/assumptions` de SkyWater; diapositivas de Edwards.

## Mapa de tres regiones (parámetros: corriente de formación y jL; después, tensión sobre el vacío)
1. **Cable (convencional):** I ≲ 10 mA en línea de 10 µm, o jL bajo el umbral de Blech (~2,6·10³–10⁴ A/cm, no leído): nada cambia en la vida del chip.
2. **Tercera región candidata — vacío puenteado por la barrera:** I ≈ 16–28 mA (ΔT 100–600 K), jL ≥ 10⁴ A/cm; R sube 0,2–150 Ω por vacío
   y queda estable mientras V = I·R_b sobre el puente no lo queme (18,5 mA × 50 Ω = 0,9 V, 17 mW: lo quema). Frontera superior: I·R_b ≈ 0,1–0,3 V.
3. **Lo que falla:** barrera fundida, hueco sin control (Strachan: > 100 nm), abierto.
El contacto de pocos canales solo cabría entre 2 y 3 si no hay barrera, con corriente ∝ 1/R y lectura a ≤ 0,2–0,5 V.

## Lo nuevo
- El lazo rápido tiene trabajo, pero es otro: detectar el salto de +10–150 Ω (a 18,5 mA son +0,2–2,8 V, lo ve un inversor) y cortar
  antes de que arda el puente de barrera. Ahí los ns sí pueden importar `[?]` (térmica del puente no simulada).
- La parada pasiva correcta no es "una resistencia" sino una escalera: drivers con resistencias de poly de 1 / 10 / 100 kΩ que
  bajan la corriente por décadas. Es digital puro.
- El anillo es destructivo para lo que pretende leer; con R serie de 30–100 kΩ deja de serlo.
- En los cuellos de EFLD-01 B/C/D la tensión mecánica la pone sobre todo la línea ancha de 0,50, no el cuello.

## Configuraciones de layout que más información darían
1. **Línea de 0,14 µm con extremos bloqueantes, largos 5 / 10 / 20 / 40 µm, a ≥ 18 mA** (cabezas multi-pin), cada una con y sin
   corte por inversor que vigila la tensión de la línea. Mide el umbral de Blech y si el estado final es "+Ω" (hay barrera) o abierto.
   Necesita un lector de ΔR de ohmios, no el anillo de kΩ.
2. **La misma línea en li1** (TiN solo) y, si cabe, en met2: control de material y respuesta directa a "¿hay barrera en met1?".
3. **Puntas enfrentadas a 0,05 µm con formación por escalera de corriente (1 / 10 / 100 kΩ) y anillo con 30–100 kΩ en serie**: único
   sitio donde la continuidad de la barrera es dudosa `[?]`; solo tiene sentido si (1) muestra abiertos sin escalón de Ω.

## Límites de este ataque
Sin SPICE propio del anillo ni del driver; cuello y puente en aleta 1D (no 3D), con espesor completo de 0,35 µm; Korhonen de
memoria (el artículo no se abrió); Kohlrausch y propiedades térmicas de memoria; la vida que garantiza la regla del LEF es supuesta.

## Archivos
`a05_PREREG.md`, `a05_a_barrera.py/.txt`, `a05_c_termica.py/.txt`, `a05_d_korhonen.py/.txt`, `a05_e_lazo.py/.txt` (+ `a05_e_lazo_v1.txt`),
`a05_fg_lectura_isla.py/.txt`. Descargas (fuera del proyecto): scratchpad `a05dl/`.
