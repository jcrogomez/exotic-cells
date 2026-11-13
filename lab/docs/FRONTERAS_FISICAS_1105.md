# Fronteras físicas de sky130 — frente D del sprint "Yunque" (escrito 2026-11-04 23:43 EST, hora de `date`)

Pregunta: de los mecanismos "exóticos" que suelen invocarse al hablar de nanogaps, contactos atómicos, SET, Hall, nanohoyos y
trampas individuales, ¿cuáles pueden existir físicamente en sky130 con las dimensiones que el PDK permite dibujar, y cuáles
podríamos además **medir** con EFL01 (híbrido, 2×2, 2–4 pines `ua`) o EFL02 (acceso al dado)?

Regla de este documento: cada número lleva (a) la fórmula y los valores con que se calculó, (b) una cita con URL abierta esta noche
de la que sale literalmente, o (c) `[?]`. Nada de aquí se corrió en silicio ni en SPICE. Los cálculos están en un script de una
sola pasada (constantes CODATA: e, h, m_e, ε0, k_B) y se pueden rehacer a mano con lo que se muestra.

Lo que ya se sabe y no se repite (ver `macros/constriccion/LEEME.md`, `PROPUESTA_CHIP.md`, `EQUIPO.md`): la formación por
electromigración en met1 la limita la vía del enrutador; el lector de anillo lee ~1 kΩ–300 kΩ; G0 = 77,5 µS (12,9 kΩ); el bloqueo
de Coulomb a 300 K exige C_Σ ≤ 3,1 aF.

## 0. Datos del proceso verificados esta noche (fuente: documentación de SkyWater y modelo SPICE del PDK)

| Dato | Valor | Fuente abierta |
|---|---|---|
| Óxido de puerta del `nfet_01v8` | `toxe = 4.148e-09` m, `epsrox = 3.9` (parámetro BSIM4, no medida) | [S1] |
| Ancho / espacio mínimos met1 | `m1.1` 0,140 µm / `m1.2` 0,140 µm | [S2] |
| Ancho / espacio mínimos li1 | `li.1` 0,170 µm / `li.3` 0,170 µm | [S2] |
| nwell ancho / espacio | 0,840 / 1,270 µm | [S2] |
| Espesor li1 / met1 / met2 (para antena) | 0,1 / 0,35 / 0,35 µm | [S3] |
| ILD previo a li1 | 0,5 µm | [S3] |
| Resistencia de hoja | nwell `RSNW` 950 Ω/□ (LSL 550, USL 1350); li `RSLI` 12,8; met1 `RSM1` 0,125; n+ 120; p+ 197; poly 48,2 | [S4] |
| Composición de metales | "5 levels of metal", "1 level of local interconnect" [S5]; "TiN local interconnect" y metales de aluminio: solo visto en resúmenes de búsqueda de diapositivas (Tim Edwards 2021), **no abierto** → aluminio con barrera de Ti/TiN `[?]`, li1 = TiN `[?]` (coherente con ρ derivada abajo, pero no es prueba) | [S5] |
| Pines `ua` de TT | 4 mA máx, < 500 Ω, < 5 pF, met5 prohibido, 1×2 o 2×2 tiles, `tt_asw_3v3` entre pin y pad; **tensión máxima no especificada en la página** → 3,3 V `[?]` | [S6] |

Dato derivado (cálculo): ρ(li1) = R_sh · t = 12,8 Ω/□ × 0,1 µm = 1,28 µΩ·m = **128 µΩ·cm**. Es el orden de magnitud de un nitruro
conductor, no de un metal (Al macroscópico: 2,73 µΩ·cm a 300 K [L5]); sostiene, sin demostrar, que li1 sea TiN.

---

## Ficha 1 — Nanogap túnel por electromigración controlada

**Mecanismo.** Una línea metálica se adelgaza por electromigración hasta romperse; si los dos extremos quedan a ~1 nm, la
conducción pasa a túnel directo.

**Hecho citado.**
- Park et al., APL 75, 301 (1999) [L1], PDF leído: hilos de Au de 10 nm de espesor sobre 3,5 nm de Cr; "The breaking process yields two
  stable metallic electrodes separated by ~1 nm"; "The whole process can be reproducibly performed as long as the thickness of a gold
  nanowire is below 20 nm"; la rotura ocurre cuando la caída en el hilo supera "a threshold of 470 mV" (26 hilos); histograma de 140
  pares: "low-bias tunnel resistances around 10 GΩ. In some instances, resistance values as small as a few hundred kΩ were observed,
  whereas for about 15% of broken nanowires resistances larger than 200 GΩ were seen"; "the tunnel resistance between two gold
  electrodes separated by ~1 nm is on the order of GΩ and that it increases exponentially as a function of distance with a
  characteristic length of ~1 Å".
- Strachan et al., APL 86, 043109 (2005) [L2], texto leído en arXiv: en aire y a temperatura ambiente, rampas de tensión con
  retroceso de ~100 mV cuando G cae un porcentaje umbral; "a controllable nanogap resistance to within a factor of about three of the
  target value in the 0.5 MΩ to 1 TΩ range"; tres regímenes: cuello masivo (G > 1 mS), pocos átomos ("jumps and plateaus near
  multiples of the conductance quantum"), túnel ("once G falls below G0", "the least controllable stage"). Oro de 8–30 nm con 3 nm de Cr.
  No mide el tamaño del hueco ("the location of closest approach between the electrodes is not resolved"); roturas sin control dan
  "gaps greater than 100 nm".
- Dubois et al., Nat. Commun. 9 (2018) [L3], texto leído: en uniones de Au de 10 nm sobre puente de TiN de 50 nm, "The gap widths ranged
  from 0.8 to 1.5 nm" por ajuste de I–V a un modelo de barrera 1D; alturas de barrera asimétricas de ejemplo "0.6 and 3.9 eV or 0.05 and
  2.8 eV"; 46 de las uniones aisladas "did not exhibit any detectable current for applied bias up to 10 V".
- Zhu, Cui, Abbasi, Natelson, arXiv 2210.02486 [L4]: uniones túnel de **aluminio** atómicas por electromigración (solo resumen abierto;
  detalles de espesor y óxido no leídos `[?]`). Prueba de existencia de nanogaps en Al, en película delgada pura, no en pila Al/TiN.

**Cálculo.**
- Decaimiento WKB de la conductancia túnel, G ∝ exp(−κ s), κ = 2·√(2 m_e Φ)/ħ:
  Φ = 0,5 eV → κ = 7,3 nm⁻¹ (3,2 décadas/nm); Φ = 1 eV → 10,2 nm⁻¹ (4,4 décadas/nm); Φ = 4 eV → 20,5 nm⁻¹ (8,9 décadas/nm).
  La "longitud característica de ~1 Å" de Park equivale a ln(10)·0,1 nm = 0,23 nm por década = 4,3 décadas/nm, es decir Φ efectiva ≈ 1 eV.
- Escala de R anclada en los dos datos de Park (1 GΩ a 1 nm; 1 Å): s = 0,5 nm → ~7 MΩ; 0,8 nm → ~0,1 GΩ; 1 nm → 1 GΩ; 1,5 nm → ~0,1 TΩ;
  2 nm → ~20 TΩ. Es extrapolación de dos números publicados, no medida.
- Consecuencia instrumental: el lector digital (1 kΩ–300 kΩ) **no ve un túnel de 1 nm**; lo registra como "abierto". A 10 GΩ y 1 V
  circulan 100 pA; por los pines `ua` pasan por un `tt_asw_3v3` cuya fuga no está especificada `[?]`, así que medir 100 pA fuera del chip
  es dudoso hasta medir esa fuga.
- Liner bajo el Al (hipótesis con un dato del PDK y un espesor desconocido): si al vaciarse el Al el liner sigue entero y es TiN con la
  ρ de li1 (128 µΩ·cm), un hueco de 1 µm en una línea de 0,14 µm son 7,1 □: con t_liner = 10 / 20 / 50 nm → R_sh = 128 / 64 / 26 Ω/□ →
  **~0,9 kΩ / 0,46 kΩ / 0,18 kΩ**. Espesor y composición del liner en sky130: `[?]`. Esto es exactamente la "región kΩ" que ya aparece
  como hipótesis B en `PROPUESTA_CHIP.md`, y cae dentro del rango del lector digital.

**Hipótesis.** (i) En met1 de sky130 la electromigración abre el Al pero **no** el liner: el estado final es una resistencia de
cientos de Ω a kΩ, estable, no un túnel. (ii) Solo si el liner también se rompe (por fusión local, no por electromigración) queda un
hueco, y entonces el tamaño del hueco no está controlado (Strachan: > 100 nm sin realimentación). (iii) En li1 (TiN, ~1 kΩ por 10 µm)
la rotura es térmica; un hueco por fusión no tiene por qué quedar en 1 nm.

**Lo que lo descarta.** Que la curva R(t) durante la formación salte de decenas de Ω directamente a > 300 kΩ (abierto para el lector)
sin meseta en la región kΩ: no hay liner conductor útil. Que una meseta en kΩ sea lineal en I–V, sin dependencia del signo y con
coeficiente térmico positivo del orden de un metal: es liner, no túnel. Firmas necesarias (no suficientes) de túnel: I–V no lineal
simétrica (I ≈ aV + bV³ a eV ≪ Φ, forma de baja tensión de Simmons 1963, DOI 10.1063/1.1702682, **no abierto esta noche**) y
dependencia térmica débil entre, p. ej., 25 °C y 85 °C; ambas firmas las imita también la conducción por un óxido delgado (TiN
oxidado, Al₂O₃ nativo), así que no distinguen "hueco" de "óxido". Resolverlo exige microscopía, no eléctrica.

**Veredicto.** EFL01: **sí como formación y lectura del estado kΩ** (ya previsto), **no como demostración de túnel**: el lector
digital no llega a GΩ y los pines `ua` necesitan antes la medida de fuga del interruptor. EFL02: sí, si hay acceso al dado
(I–V con SMU de pA, temperatura, y SEM/FIB tras la medida). Se registra como "resistencia programable con mecanismo no identificado"
hasta tener microscopía.

---

## Ficha 2 — Contacto atómico y conductancia cuantizada en metales

**Mecanismo.** Al estirar o adelgazar un contacto hasta pocos átomos, G = G0·Σ τ_i (Landauer); en metales monovalentes (Au, Ag,
alcalinos) el último átomo lleva un canal con τ ≈ 1 y el histograma de muchas roturas tiene picos cerca de múltiplos enteros de G0.

**Hecho citado.**
- Scheer, Joyez, Esteve, Urbina, Devoret, PRL 78, 3535 (1997) [L6] (registro del repositorio de Konstanz, abstract parafraseado):
  transmisiones de hasta seis canales en contactos de Al; **al menos dos canales conducen incluso cuando G < G0**.
- Notas de curso de E. Scheer (Heidelberg, PDF leído) [L5]: "For divalent metals (zinc, magnesium) and trivalent ones (aluminum) the
  first peak is rather sharp and located slightly below 1G0"; "In the last plateau of an Al contact, where G < G0, two or three channels
  contribute to the transport"; ejemplos medidos a 30 mK: T_total = 0,875 (0,80 + 0,075), 0,817 (0,682 + 0,12), 0,807 (0,399 + 0,254);
  tabla: Al, conductancia del último plateau **0,6–1,1 G0**, 3 canales (s y p).
- Hasmy et al., arXiv cond-mat/0010416 [L7] citando a Yanson y van Ruitenbeek (PRL 79, 2157, 1997): histogramas de Al "clearly show
  peaks close to G/G0 ∼ 0.8, ∼ 1.8, ∼ 3.0, and ∼ 4.0 at T = 4 K"; "It has been suggested that peaks in aluminum CH originate in favorable
  atomic configurations appearing during nanocontact stretching" (es decir: picos del histograma ≠ cuantización).
- Strachan [L2]: en Au a temperatura ambiente, "jumps and plateaus near multiples of the conductance quantum" durante la electromigración.

**Cálculo.** 1/G0 = h/(2e²) = 12.906 Ω. Para que el lector digital distinga 1 G0 (12,9 kΩ) de 0,8 G0 (16,1 kΩ) hace falta resolver
ΔR/R = 25 % en la zona donde el período sube ~32 % por década de R (dato de EFLD-00): resoluble en principio; pero distinguir
0,8 G0 de "una resistencia cualquiera de 16 kΩ" no lo es.

**Hipótesis.** Si una línea de met1 atraviesa el régimen de pocos átomos antes de abrirse (Al puro), aparecerían mesetas breves en
R entre 10 kΩ y 30 kΩ. En una pila Al/liner, el liner cortocircuita ese régimen con cientos de Ω en paralelo (Ficha 1): la meseta
atómica, si existe, queda enmascarada salvo que el liner esté ya roto.

**Lo que lo descarta.** Un solo valor de R ≈ 12,9 kΩ no demuestra nada: (a) en Al los escalones no son enteros (0,6–1,1 G0) y su
posición depende de la configuración atómica; (b) el régimen dura ms o menos sin realimentación rápida (Strachan: "the least
controllable stage"); (c) cualquier resistencia de liner, óxido o contacto puede valer 13 kΩ. La evidencia mínima publicada son
**histogramas de cientos a miles de ciclos** con picos reproducibles, y en Al ni eso prueba cuantización (Yanson). Un ciclo de
formación por línea (irreversible) no puede generar un histograma.

**Veredicto.** EFL01: **no** (una formación por precursor, sin ciclos, sin realimentación de µs, liner en paralelo). EFL02: **no
como objetivo**; si se llega a ver una meseta en la región 10–30 kΩ se anota como curiosidad y se descarta por defecto. Mecanismo
que no debe aparecer en los contratos funcionales de la Fragua.

---

## Ficha 3 — Transistor de un electrón (SET) en sky130

**Mecanismo.** Isla conductora aislada por dos barreras túnel; E_C = e²/(2 C_Σ) debe superar k_B T (y en la práctica ≈ 10 k_B T) para
ver bloqueo de Coulomb.

**Hecho citado.**
- Prati et al., arXiv 1203.4811 (CEA-LETI) [L8]: SET n-MOS en "a pre-industrial Fully Depleted Silicon On Insulator (FDSOI) technology
  on 200 mm wafers", canal nominal "20×20 nm²" por litografía electrónica, Si de 10 nm; "The Coulomb blockade stability diagram is
  precisely resolved at 4.2 K"; energía de adición medida E(2,1) = 30 meV; C_s = 1,0 aF, C_d = 1,3 aF, C_g = 4,0 aF (C_Σ = 6,3 aF).
  No afirma bloqueo a temperatura ambiente.
- Tesis de Deshpande (Grenoble, 2012) [L9]: "Room temperature operation of SET requires an island (or channel) with dimensions of 5 nm or
  less"; SET a temperatura ambiente "on state-of-the-art SOI CMOS technology (featuring high-k/metal gate)"; nodo y fundición no
  nombrados en la página `[?]`.
- Park 1999 [L1]: SET con nanocristal de CdSe entre electrodos electromigrados, I–V con bloqueo a **T = 1,5 K**.
- ε_r(SiO₂) = 3,9 [S7] (también `epsrox = 3.9` en el modelo del PDK [S1]).

**Cálculo (autocapacidad, cota inferior: isla aislada en SiO₂ infinito, disco delgado C = 8 ε0 ε_r r, con r = a/√π para un cuadrado
de lado a).**
- li1 0,17 × 0,17 µm: r = 95,9 nm → **C = 26,5 aF**; E_C = e²/2C = **3,0 meV**; E_C = k_B T a 35 K; **E_C = 10 k_B T a 3,5 K**.
- met1 0,14 × 0,14 µm: r = 79,0 nm → **C = 21,8 aF**; E_C = 3,7 meV; 10 k_B T a **4,3 K**.
- Con ε_r = 1 (cota inferior físicamente imposible aquí): 6,8 y 5,6 aF. La capacidad de placa paralela al sustrato a través de los 0,5 µm
  de ILD [S3] añade solo 2,0 / 1,35 aF; las uniones túnel y las puertas reales añaden más. Todo suma: C_Σ real > 27 aF.
- Isla que cumpliría 3,1 aF con ε_r = 3,9: r = 11 nm, **diámetro ≈ 22 nm**, 6–8 veces por debajo del mínimo de sky130 (140–170 nm) y
  comparable a lo que LETI hace con haz de electrones para operar a 4,2 K. Comprobación cruzada: e²/C_Σ(Prati) = e²/6,3 aF = 25 meV,
  coherente con sus 30 meV de adición y con k_B·300 K = 25,9 meV.

**Hipótesis.** La única vía para una isla pequeña en sky130 es accidental: un grano de Al atrapado entre dos nanogaps de una línea
rota (análogo de Park con nanocristal). Tamaño, capacidades y barreras no estarían controlados; se vería, si acaso, a ≤ 4 K.

**Lo que lo descarta.** Las dimensiones del PDK (ya calculado). Además, sky130 no ofrece barrera túnel entre conductores: el
dieléctrico más delgado dibujable es el óxido de puerta de 4,1 nm, y a 4,1 nm la Ficha 1 da ~13 décadas por encima del GΩ (Φ ≈ 1 eV:
4,4 décadas/nm × 3,1 nm sobre 1 nm) → no hay corriente medible. El SONOS del proceso [S5] no está en el PDK abierto `[?]`.

**Veredicto.** EFL01: **no**. EFL02: **no** (ni con criogenia, porque la isla no se puede dibujar). Cualquier "escalón" en I–V a
300 K en una estructura de sky130 se atribuye primero a trampas, contactos u óxido (Ficha 6), no a Coulomb.

---

## Ficha 4 — Placa Hall de cuatro terminales en nwell

**Mecanismo.** V_H = I·B/(q·n·t) para una placa larga de espesor t y densidad n (factor geométrico G ≤ 1 omitido). Con
R_sh = 1/(q·n·t·µ): **V_H = µ_H·R_sh·I·B**, S_I = V_H/(I·B) = µ_H·R_sh.

**Hecho citado.**
- `RSNW` = 950 Ω/□ (550–1350) [S4]. Movilidad Hall del nwell de sky130: **no está en la documentación abierta** → `[?]`. Espesor y
  dopado del nwell: `[?]`.
- Lee, Oh, Oh, Chae, Sensors 20, 5285 (2020) [L10]: "The prototype Hall sensor is fabricated in a 0.18-µm CMOS process"; "The Hall device
  itself is made of N-well layer on P-substrate and has a size of 100 × 100 µm optimized for offset"; "sensitivity of 110 µV/mT";
  offset residual con spinning current: 16 µT (tabla); el dispositivo conmuta sus conexiones cada período de muestreo (dos fases).
- Heidari, Bonizzoni, Gatti, Maloberti, ISCAS 2014 [L11]: "standard 0.18-µm CMOS technology", sensibilidad en modo corriente
  "I_Hall/(B·I_bias) better than 0.02 T⁻¹", spinning current para el offset; sin cifras de offset en la página.

**Cálculo.** Sin µ_H no hay sensibilidad: queda como fórmula. Para dar escala, **hipótesis** (no dato de sky130): si µ_H = 0,05 /
0,10 m²/V·s, S_I = µ_H·R_sh = 48 / 95 V/(A·T) → V_H = **48 / 95 µV a I = 1 mA y B = 1 mT**. Coste en tensión: una placa cuadrada de
nwell a 1 mA cae I·R_sh = 0,95 V (0,55–1,35 V en las esquinas), compatible con 1,8 V; placas más largas que anchas no caben en
el presupuesto de tensión. El offset de una placa sin spinning suele ser de mT equivalentes `[?]` (no cité un número), es decir ≫
1 mT de señal: el spinning current no es opcional.

**Hipótesis.** Nada que el proceso no haga: el nwell es un semiconductor dopado y produce Hall. El valor de µ_H·R_sh saldría de una
medida a B conocido (imán calibrado), no del PDK.

**Lo que lo descarta.** Nada lo descarta físicamente. Lo que lo descarta **como Exotic Cell** es la definición de `EQUIPO.md`: usa una
propiedad que la biblioteca no ofrece, sí, pero es un sensor publicado en 180 nm con décadas de literatura y sin estado, formación
ni geometría que gobierne algo nuevo.

**Veredicto.** Es un **sensor conocido, no una Exotic Cell**. EFL01: solo como **instrumento** si sobra área: calibra los pines `ua`
(µV con amplificador externo, 1 mA dentro del límite de 4 mA), y da µ_H del nwell, dato que no tenemos. Necesita 4 terminales
analógicos o conmutación interna de spinning con puertas de transmisión de 1,8 V y 2 pines. No cuenta como resultado del Yunque.

---

## Ficha 5 — Aperturas submicrométricas en metal (transmisión óptica extraordinaria)

**Mecanismo.** Una red periódica de hoyos subonda en una película metálica opaca transmite, en picos, más luz que la fracción de
área de los hoyos, por acoplamiento a plasmones de superficie; condición de los picos (orden (i,j)):
λ ≈ (a0/√(i²+j²))·√(ε_m ε_d/(ε_m+ε_d)) ≈ (a0/√(i²+j²))·n_d cuando |ε_m| ≫ ε_d.

**Hecho citado.**
- Ebbesen et al., Nature 391, 667 (1998) [L12]: "arrays of such holes display highly unusual zero-order transmission spectra";
  "the transmission efficiency can exceed unity (when normalized to the area of the holes)" (resumen de búsqueda del abstract; la
  página de Nature no se pudo abrir). Geometría del experimento según revisión de 2025 [L13] (leída): película de **plata**,
  "a₀ = 900 nm, t = 200 nm, d = 150 nm"; fórmula de la longitud de onda del plasmón en esa revisión:
  λ_spp = (p/√(i+j))·√(ε_m ε_d/(ε_m+ε_d)) (así escrita en la fuente; la forma con √(i²+j²) es la habitual `[?]`).
- Índice de refracción del SiO₂: cuarzo 1,544 (o) / 1,553 (e) [S7b]; sílice amorfa ≈ 1,46 `[?]` (no citada).

**Cálculo.**
- Paso mínimo de una red de hoyos en met1 = ancho + espacio = 0,14 + 0,14 = **0,28 µm** [S2]; fracción de área de hoyos de 0,14 × 0,14
  en paso 0,28: 25 %. Espesor de la película: 0,35 µm [S3] (Ebbesen: 0,20 µm).
- Pico (1,0) con n_d = 1,46: λ ≈ 0,28 × 1,46 = **0,41 µm**; con 1,544: 0,43 µm. Orden (1,1): 0,29–0,31 µm (UV). Es decir: violeta /
  UV cercano. Un paso de 0,40–0,45 µm (legal) movería el pico (1,0) a 0,58–0,69 µm (visible), siempre con el dieléctrico de
  SiO₂ a ambos lados.
- Aluminio como metal plasmónico en 0,4 µm: aceptable en la literatura `[?]` (no cité); interbanda del Al ≈ 0,8 µm `[?]`.

**Hipótesis.** Una red de hoyos en met1 sobre un fotodiodo (p+/nwell o nwell/psub) transmite más (o menos) que una placa de met1
sólida del mismo tamaño, y la relación depende del paso. El detector es el propio fotodiodo bajo la red; los controles son el mismo
fotodiodo bajo met1 sólido y sin metal.

**Lo que lo descarta.** (i) Luz: el encapsulado de TT no está documentado como transparente y TT "no ships bare dies" [S14] → sin
acceso óptico no hay experimento; (ii) la pila superior (met2–met5 de relleno, pasivación) sobre la red: el relleno automático de
metal lo tapa salvo que se bloquee, y met5 es de TT [S6]; (iii) resolución espectral: sin monocromador o LED de banda estrecha
solo se ve una integral; (iv) el Al de 0,35 µm sin ventana: transmisión directa ≈ 0, bien; pero la reflexión por el silicio bajo el
óxido crea una cavidad que puede imitar picos. Resultado nulo más probable: fotocorriente ∝ 25 % de área, sin resonancia.

**Veredicto.** EFL01: **no** (sin luz). EFL02: **condicional**, solo con acceso óptico al dado, fuente de banda estrecha en 0,4–0,7 µm
y bloqueo del relleno de metal sobre la red; es ruta A pura (la fundición la fabrica tal cual). Interesante como demostración de
"geometría del GDS que gobierna una propiedad óptica", pero no antes de PHOTON.

---

## Ficha 6 — Trampas individuales / RTN en MOS mínimos de sky130

**Mecanismo.** Un defecto en el óxido o la interfaz captura y emite un portador; la corriente salta entre dos niveles con tiempos
exponenciales (τ_c, τ_e). En área pequeña, un solo defecto domina.

**Hecho citado.**
- Wirth, arXiv 2001.03236 (PDF leído) [L14]: "The average VT fluctuation due to a trap <δVTi> is assumed to scale inversely with
  transistor gate area, <δVTi> = Bη/(W.L)"; "In the 28nm technology studied in [1], for the nMOSFET Bη = 0.0053 mV/µm²"; densidad de
  defectos supuesta 10¹¹ cm⁻²; "Both stochastic variability and noise scale inversely with area"; el modelo relaciona el jitter de V_T
  con el ruido 1/f de la misma población de trampas.
- Notas NII (PDF leído) [L15]: los tiempos en cada estado "are exponentially distributed"; "the standard deviation is equal to the mean
  time spent in the state. Equation (9.27) can be used as a simple test for exponential behavior"; el espectro de un RTS es lorentziano;
  el 1/f es la superposición de trampas con "a wide range of time constants" distribuidas como 1/τ.
- Celik-Butler (diapositivas, PDF leído) [L16]: ΔI_D/I_D = −(1/(W_eff·L_eff))·(1/N ± α µ)·ΔN_t (fluctuación de número ± movilidad);
  extracción de E_Cox−E_T y z_T a partir de τ_c y τ_e frente a V_GS y V_SB.
- Tiempos de residencia típicos a 300 K: **no cité ningún valor abierto** → `[?]`. Resúmenes de búsqueda (no abiertos) hablan de
  constantes que abarcan ~7 órdenes de magnitud en 40 nm (IEEE JEDS 2021) y de retención ~10 ms en un nanohilo de Si a temperatura
  ambiente (Southampton, 2019); se citan como pistas, no como datos.

**Cálculo (modelo de hoja de carga, cota de orden de magnitud).**
C_ox = ε0·3,9/4,148 nm = **8,32 fF/µm²**; W·L = 0,42 × 0,15 = 0,063 µm² → C_g = 0,524 fF → **ΔV_th ≈ q/C_g = 0,305 mV** por carga
atrapada. Con el Bη de 28 nm de Wirth/Simicic saldrían 0,084 mV de media (otra tecnología; muestra que la media es menor que q/C_g
porque muchas trampas están lejos del canal o cerca de los contactos). Efecto en un anillo: un transistor con ΔV_th = 0,3 mV cambia su
retardo ≈ ΔV_th/(V_DD−V_th) = 2–4 × 10⁻⁴ (V_DD−V_th entre 0,8 y 1,3 V; V_th de sky130 no citada `[?]`); diluido entre N etapas, 10⁻⁵:
**por debajo del 1 % de `FILOSOFIA.md`** y del piso del Cronista. Para verlo hace falta que un solo transistor domine el observable.

**Hipótesis.** En un transistor mínimo de sky130 (0,063 µm², ~63 defectos a 10¹¹ cm⁻² si esa densidad valiera aquí `[?]`) habrá
RTN visible en una fracción de dispositivos; las trampas activas dependen de V_GS y T; el estrés BTI/HCI (La Trampa) crea nuevas.

**Cómo se distingue.** RTN: dos (o 2^k) niveles discretos en el dominio del tiempo, tiempos exponenciales con σ = media, espectro
lorentziano con esquina en 1/(2π)(1/τ_c + 1/τ_e), amplitud independiente del tiempo de observación. 1/f: continuo, sin niveles,
potencia que crece como log(T_obs). Jitter de reloj/alimentación: afecta igual al anillo gemelo y a la referencia (diferencial lo
cancela), y no tiene dos niveles.

**Qué lectura basta.** Digital por frecuencia **no** basta en un anillo normal (10⁻⁵). Basta una estructura en la que el transistor
mínimo bajo prueba fije él solo la corriente de carga de la etapa RC del Cronista (R-a-tiempo con el MOS como R, en régimen de
inversión débil donde ΔI/I = ΔV_th/(n·k_B T/q) ≈ 0,3 mV/36 mV ≈ **0,8 %** por salto, con n ≈ 1,4 `[?]`), leída en diferencial contra
un gemelo, con ventanas de conteo cortas (≤ ms) repetidas miles de veces para construir el histograma de dos niveles. Sin pines
analógicos ni criogenia; temperatura con la placa caliente para τ(T).

**Lo que lo descarta.** Que ningún transistor de la matriz muestre niveles discretos por encima del piso del lector en ventanas de
0,1 ms a 10 s: entonces el piso es mayor que ~1 % o las τ caen fuera de la ventana; se declara límite, no negativo.

**Veredicto.** **EFL01: sí**, como único mecanismo de esta lista que es físico, legal, compatible con 1,8 V y leíble en digital si se
diseña la etapa dominada por un solo transistor. Encaja en La Trampa como su observable de reposo. No es "exótico" en la
literatura; sí es una primitiva que la biblioteca no da (fuente de aleatoriedad o sensor de carga individual) y se puede comparar
contra el ruido térmico de un anillo convencional (regla 11).

---

## Ficha 7 — Puntero: LED de filamento de silicio en óxido de puerta

Li, Xue, …, Ram, "A sub-wavelength Si LED integrated in a CMOS platform", Nat. Commun. 14 (2023), DOI 10.1038/s41467-023-36639-1
[L17] (resumen de búsqueda; copia abierta en PMC9935894): filamento de Si formado por ruptura dura del óxido de puerta en un nodo
CMOS de 55 nm, emisión centrada en ~1100 nm, área < 0,14 µm², sustrato a 6,0 V con poly a tierra durante la formación. Lo cubre
otro agente; aquí solo se anota que la formación necesita > 1,8 V (6 V en la fuente) y un detector de 1,1 µm, fuera de EFL01 salvo
bomba interna.

---

## Decisión

| Mecanismo | Veredicto | Qué evidencia cambiaría el veredicto | Instrumentación mínima |
|---|---|---|---|
| 1. Nanogap túnel por EM | EFL01: solo el estado kΩ (liner), no túnel · EFL02: sí | Meseta kΩ ausente y salto a abierto (liner no conduce); o I–V no lineal + T débil + SEM del hueco | EFL01: Cronista. Túnel: SMU de pA por `ua` tras medir fuga del `tt_asw`, o acceso al dado |
| 2. Contacto atómico / G0 | No (EFL01 y EFL02) | Histogramas de cientos de ciclos con picos reproducibles; en Al ni eso prueba cuantización | Realimentación de µs y ciclado reversible: no existe en la Fragua |
| 3. SET | No (EFL01 y EFL02) | Una isla ≤ 22 nm con dos barreras túnel: no dibujable en sky130 | Criogenia ≤ 4 K incluso para islas 7× menores que el mínimo |
| 4. Hall en nwell | Sensor conocido; EFL01 opcional como instrumento, no Exotic Cell | Nada: es física de libro; cambia solo su utilidad (medir µ_H del nwell) | 4 pines `ua` o spinning interno + 2 pines; amplificador externo de µV; imán calibrado |
| 5. Nanohoyos / EOT | EFL01: no · EFL02: condicional | Acceso óptico al dado, bloqueo del relleno sobre la red, fuente de banda estrecha 0,4–0,7 µm | Fotodiodo bajo la red + controles (met1 sólido, sin metal); luz externa |
| 6. RTN en MOS mínimo | **EFL01: sí** (La Trampa, reposo) | Que ninguna etapa muestre dos niveles > piso en 0,1 ms–10 s: límite instrumental | Etapa RC dominada por un MOS mínimo en inversión débil, diferencial, ventanas cortas, placa caliente |
| 7. LED de filamento | Puntero (otro agente) | — | > 1,8 V de formación; detector a 1,1 µm |

Orden de prioridad para el Yunque: 6 (entra), 1 (ya entra como estado kΩ, con contrato reescrito: "resistencia programable",
no "túnel"), 4 (si sobra área y pines), 5 (EFL02), 2 y 3 (fuera, y fuera del vocabulario de los contratos).

## Números que quedaron en `[?]`

Composición de met1–met5 (Al con Ti/TiN) y de li1 (TiN); espesor y ρ del liner de met1; tensión máxima de los pines `ua` (≈ 3,3 V) y
fuga del `tt_asw_3v3`; µ_H, espesor y dopado del nwell; offset típico de una placa Hall sin spinning; n de la sílice del BEOL
(≈ 1,46) e idoneidad plasmónica del Al en 0,4 µm; transparencia del encapsulado de TT; τ_c/τ_e típicas a 300 K; V_th y factor n de
subumbral del `nfet_01v8`; densidad de defectos de óxido de sky130; prefactor de la fórmula de Simmons (no abierta); forma exacta
del índice de orden en la condición de EOT (√(i+j) en la fuente frente a √(i²+j²) habitual); nodo/fundición del SET de Deshpande;
detalles de espesor y óxido en las uniones de Al de Zhu et al.

## Fuentes (todas abiertas esta noche salvo donde se indica)

Proceso y plataforma
- [S1] Modelo SPICE `sky130_fd_pr__nfet_01v8__tt.pm3.spice` (toxe, epsrox): https://raw.githubusercontent.com/google/skywater-pdk-libs-sky130_fd_pr/main/cells/nfet_01v8/sky130_fd_pr__nfet_01v8__tt.pm3.spice
- [S2] Reglas de periferia (li.1, li.3, m1.1, m1.2, nwell.1/2a, poly.1a) y resumen: https://skywater-pdk.readthedocs.io/en/main/rules/periphery.html · https://skywater-pdk.readthedocs.io/en/main/rules/summary.html
- [S3] Criterios y supuestos (espesores para antena, ILD): https://skywater-pdk.readthedocs.io/en/main/rules/assumptions.html
- [S4] Detalles de dispositivo (resistencias de hoja RSNW, RSLI, RSM1…): https://skywater-pdk.readthedocs.io/en/main/rules/device-details.html
- [S5] README del PDK ("5 levels of metal", "1 level of local interconnect", SONOS): https://github.com/google/skywater-pdk · diapositivas de T. Edwards 2021 (no abiertas, solo resumen): https://isn.ucsd.edu/courses/beng207/lectures/Tim_Edwards_2021_slides.pdf
- [S6] Especificación analógica de Tiny Tapeout: https://tinytapeout.com/specs/analog/
- [S7] ε_r(SiO₂) = 3,9, ε_r(Si) = 11,68: https://en.wikipedia.org/wiki/Relative_permittivity · [S7b] n del cuarzo 1,544/1,553: https://en.wikipedia.org/wiki/Silicon_dioxide
- [S14] FAQ de Tiny Tapeout (no se envían dados desnudos; dados pegados a PCB en algunos shuttles): https://tinytapeout.com/faq/

Literatura
- [L1] Park, Lim, Park, Alivisatos, McEuen, APL 75, 301 (1999), PDF: https://mceuengroup.lassp.cornell.edu/sites/mceuen/files/publications/EMPaper.pdf
- [L2] Strachan et al., APL 86, 043109 (2005), texto: https://ar5iv.labs.arxiv.org/html/cond-mat/0504112
- [L3] Dubois et al., Nat. Commun. 9 (2018): https://pmc.ncbi.nlm.nih.gov/articles/PMC6109151/
- [L4] Zhu, Cui, Abbasi, Natelson, uniones túnel de Al (solo resumen): https://arxiv.org/abs/2210.02486
- [L5] E. Scheer, notas de curso "single-atom contacts" (Heidelberg), PDF: https://gsfp.physi.uni-heidelberg.de/content/en/zubehoer/anhaenge/scheer/7-1-Chapter7_1_single-atom%20contacts_n.pdf
- [L6] Scheer, Joyez, Esteve, Urbina, Devoret, PRL 78, 3535 (1997), registro KOPS: https://kops.uni-konstanz.de/handle/123456789/4807
- [L7] Hasmy et al., cond-mat/0010416 (cita los picos de Al de Yanson y van Ruitenbeek, PRL 79, 2157): https://ar5iv.labs.arxiv.org/html/cond-mat/0010416
- [L8] Prati et al., "Few electron limit of n-type MOS SETs", arXiv 1203.4811: https://ar5iv.labs.arxiv.org/html/1203.4811
- [L9] Tesis de V. Deshpande (Grenoble/LETI): https://www.pheliqs.fr/en/Pages/Lateqs/Theses/Veeresh-Deshpande.aspx
- [L10] Lee, Oh, Oh, Chae, Sensors 20, 5285 (2020): https://pmc.ncbi.nlm.nih.gov/articles/PMC7570856
- [L11] Heidari, Bonizzoni, Gatti, Maloberti, ISCAS 2014: https://eprints.gla.ac.uk/103462
- [L12] Ebbesen et al., Nature 391, 667 (1998), DOI 10.1038/35570 (página no abierta; abstract vía resumen de búsqueda)
- [L13] Revisión 2025 de EOT (geometría de Ebbesen y λ_spp): https://arxiv.org/html/2501.12476
- [L14] G. Wirth, "Threshold Voltage Jitter due to Random Telegraph Noise", PDF: https://arxiv.org/pdf/2001.03236
- [L15] Notas NII "1/f Noise and Random Telegraph Signals", PDF: https://www.nii.ac.jp/qis/first-quantum/forStudents/lecture/pdf/noise/chapter9.pdf
- [L16] Z. Celik-Butler, "Noise and Reliability in Nanoelectronic Devices", diapositivas: https://websites.uta.edu/zcelik/files/2021/08/Noise-and-Reliability-in-Nanoelectronic-Devices.pdf
- [L17] Li et al., Nat. Commun. 14 (2023): https://www.nature.com/articles/s41467-023-36639-1 (redirige; copia abierta: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9935894/)
- No abiertas (403/405): Kirton y Uren, Adv. Phys. 38, 367 (1989); Bell Labs, EM in situ en Al(Cu)/TiN; IEEE JEDS 2021 (RTN 40 nm); Southampton 2019 (RTN en nanohilo). Se mencionan como pistas, sin números.
