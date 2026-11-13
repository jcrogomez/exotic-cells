# b20 · Informe del ataque 2 a XC-20 (unión túnel de silicio): perfiles y transporte

Hora de cierre (`date`): Thu Nov 12 19:00:43 EST 2026. Prerregistro: `b20_PREREG.md` (13:29:18, antes de correr y de buscar literatura).
**Todo es modelo, cálculo y lectura: nada medido en silicio.** Grados: **PDK** (ruta y línea), **corrida** (script), **leída**
(un subagente abrió el texto; la cita y la URL están en `b20_lit_esaki.txt` o `b20_lit_implante_zener.txt`), **no leída**,
**memoria**, **cálculo**, **supuesto** (parámetro barrido).

## 0. Resumen en seis líneas

1. El modelo (Poisson Fermi-Dirac 1D + WKB no local + exceso TAT de Hurkx) reproduce **en inversa** dos anclas leídas: la ley de
   túnel de Solomon para diodos implantados tipo CMOS (dentro de ×3 tras calibrar) y la unión lateral p+/n+ pegada de Dutta en
   TSMC 65 nm (ruptura frente a separación dentro de ±1 V; corriente en d = 0 dentro de ×3). **En directa NO hay ancla**: el modelo
   queda 30–1000 veces por debajo del pico de los Esaki de silicio publicados; se lleva como escenario (cF = 1, 10, 100).
2. **Túnel inverso en la unión pegada (d = 0): SOBREVIVE, reforzado.** En todo perfil plausible la corriente a −1,8 V sale de
   ~10 nA a ~100 µA por 1,4 µm de frontera (piso del lector 150 fA). Dutta midió 23 µA/µm a 1,8 V en la misma geometría a 65 nm.
3. **Resistencia negativa: improbable en SKY130, no muerta.** Pide las dos caras ≥ 1–2e20 y gradiente G ≤ 3–5 nm/década (G ≤ 10
   solo con exceso de material epitaxial y cF = 100). La abruptidad lateral plausible de un implante S/D de xj = 0,1 µm es
   G ≈ 10–35. Solomon (leída) no vio pico con implantes de 2–5 keV y 5–13 nm/década verticales.
4. Fracción del espacio barrido con pico: 0–28 % en d = 0 según escenario; 0–12 % en todo el barrido (tabla §3).
5. Biestable: existe si hay pico; tolera desajuste de picos de hasta ≈ PVR; **muere por alineación** (±30 nm quita el pico).
   Lectura: comparador con par pfet, 15/15 esquinas-temperaturas; un inversor o un seguidor no sirven.
6. Geometrías: 16 sondas pegadas pasan el DRC del precheck (L, peine, isla, cuello, alta tensión, n+/p+ en sustrato, con LVTN o
   HVTP); frontera bajo puerta, solapes y huecos de 5 nm a 0,26 µm se rechazan.

## 1. Modelo: qué incluye y qué no (`b20_lib.py`)

| Pieza | Cómo | Grado de sus constantes |
|---|---|---|
| Electrostática | Poisson 1D, Fermi-Dirac, cuasi-niveles planos | Nc, Nv, Eg: memoria |
| Túnel banda a banda | No local: WKB de dos bandas por energía sobre el perfil autoconsistente; prefactor A·F^1,5 con campo medio del camino | Juego **H**: A = 4e14, F0 = 1,9e7 V/cm (Hurkx; **leída** en tres fuentes secundarias, original no abierto). Juego **S**: F0 = 2,95e7 (pendiente λ = 0,38 nm de Solomon, **leída**), A = 1,53e17 (**corrida**, ajuste a su prefactor) |
| Corriente de exceso | TAT de Hurkx (SRH con aumento por campo), ∝ 1/τ | τ **supuesto**: 1 ns, 0,1 ns, 10 ps |
| Difusión | Diodo p+/pozo n del PDK: Js = 2,15e-9 A/cm², n = 1,363 | **PDK** (a20_pdk.txt §10) |
| Avalancha | Integral de ionización con espacio muerto de umbral duro (1,2/1,5 eV) | van Overstraeten: memoria; sale 20–40 % alta en unión abrupta (`b20_valida_bv.txt`) |
| Estrechamiento de banda | Opción (0,6 × Slotboom), solo como sensibilidad | memoria |

**No incluye:** fonones explícitos (silicio indirecto: entran solo por A y F0 empíricos; sin escalones de fonón), túnel por
colas de banda o estados de impureza (que es lo que fija el valle real), 2D/3D (curvatura en profundidad, superficie, borde del
STI), resistencia serie, autocalentamiento, interacción B–As. DEVSIM no se usó: solucionador propio.

Errores encontrados al construirlo: (a) la fila de contorno de Poisson se perdía en el pivoteo (escala 1 frente a 1/dx²): con
dx = 0,05 nm daba potenciales falsos. **El `a20_lib.py` de la ronda 1 tiene la misma fila sin escalar** con dx = 0,1–0,2 nm; sus
números de túnel se reproducen aquí (`b20_valida.txt`: 75 / 4,4e4 / 4,6 A/cm² a 1e20), así que no le afectó de forma visible.
(b) La integral de ionización estaba mal apareada (no podía llegar a 1); corregida antes del barrido definitivo.

**Corrección del verificador incorporada:** degeneración de volumen desde 2,5e19 (ξp = +2, ξn = +4 meV; `b20_valida.txt`),
no 4e19. Pero el pico de túnel directo a 3e19 abrupta es nulo en la rejilla (el solape, 19 meV, es menor que la primera tensión
barrida) y a 5e19 es 0,018 A/cm²: degenerar no basta, decide el camino de túnel y el exceso.

## 2. Anclas (`b20_ancla.py` → `b20_ancla.txt`)

| Ancla (leída) | Publicado | Modelo | Veredicto |
|---|---|---|---|
| Solomon, IBM RC22916 / JAP 95, 5800: J = 5,3e7·exp(−w/0,38 nm) A/cm², uniones implantadas 2e18–7e19 | — | H: mediana J/J_Sol = 0,20 (0,07–2,5) en caminos de 3–9 nm. S calibrado: ×1 de mediana, dispersión 0,65 décadas | H subestima ×5; S reproduce dentro de ×3 |
| Dutta (tesis Twente 2017, TSMC 65 nm, p+/n+ lateral, sin siliciuro, W = 47,6 µm): VBR(1 mA) = 1,8 / 2,5 / 3,35 / 4,25 / 5,95 / 7,3 / 8,5 V en d = 0 / 20 / 40 / 60 / 100 / 140 / 200 nm | idem | S, 1e20/2e20, G = 20: 1,94 / 2,29 / 3,33 / 4,74 / 5,07 / 6,11 / 7,67. H, 2e20/2e20, G = 20: 2,65 / 3,04 / 4,07 / 5,13 / 5,05 / 5,60 / 7,62 | Reproduce dentro de ±1 V con G = 10–20 y picos 1–2e20 |
| Dutta, d = 0, 25 °C: 0,02 / 0,3 / 2,3 / 23 µA/µm a 0,2 / 0,5 / 1,0 / 1,8 V | idem | H, 2e20/2e20, G = 10: 0,017 / 0,20 / 1,8 / 13. S, 1e20/2e20, G = 20: 7e-5 / 0,006 / 0,29 / 9,1 | H da la forma; S es demasiado empinado a baja tensión |
| Esaki de silicio (tesis Zhao 2007): Jp = 26 A/cm² a Neff ≈ 2,5e19; 155 A/cm² a Neff ≈ 4e19 | idem | Abrupta, H / S: 0,02–0,10 A/cm² y 1,0–6,0 A/cm² | **Falla**: ×26–155 por debajo a 4e19, ×270–1300 a 2,5e19 |
| Solomon sobre Rivas/Dashiell: el pico medido queda ~10× sobre su ley | — | — | De aquí sale cF = 10; cF = 100 es cota generosa |

Avisos: xj de Dutta supuesto 0,15 µm (él da 100–200 nm). El Neff de Zhao lo estima él con su propia fórmula a partir de Jp
(circular: el subagente no logró reproducir su Ec. 2.5), así que el fallo en directa puede ser del modelo o del dopado atribuido.
Koga y Toriumi 2001 sigue sin abrirse: solo ~10 A/cm² y PVR ≈ 2 de segunda mano (Zhao), sin dopados. **Ancla en directa: no hay.**

## 3. Barrido de perfiles y mapa de tres regiones (`b20_barrido.py`, `b20_analiza.py`)

Barrido: Np, Nn ∈ {2e19, 5e19, 1e20, 2e20, 3e20} (25 pares), G ∈ {3, 5, 10, 20, 30, 50} nm/década, d ∈ {−100, −30, 0, +30, +100}
nm, pozo ∈ {6e16, 2e17}: 1500 celdas por juego, I–V de +0,8 a −16 V. Lejos (d = 240, 270, 300): 252 celdas, `b20_lejos.txt`.
G es la cola del perfil pico/(1 + 10^(x/G)); a media altura la pendiente local es 2G; equivale a un erfc de σ = G/1,44.

**Fracción con pico** (corrida; `b20_analisis_sol.txt` y `_base.txt` §1). Es un intervalo por escenario, no un número:

| Juego | cF / τ | d = 0 (300 celdas): PVR > 2 | PVR > 1,3 | sin pico | todo d ≤ +100 (1500): PVR > 1,3 |
|---|---|---|---|---|---|
| S | 1 / 1 ns | 6,0 % | 8,0 % | 91,3 % | 2,7 % |
| S | 10 / 1 ns | 13,3 % | 16,0 % | 82,7 % | 6,4 % |
| S | 10 / 0,1 ns (central) | 6,0 % | 8,0 % | 91,3 % | 2,7 % |
| S | 10 / 10 ps | 0 % | 2,0 % | 96,7 % | 0,4 % |
| S | 100 / 1 ns | 22,0 % | 24,3 % | 74,0 % | 10,0 % |
| H | 1 / 1 ns | 0 % | 0 % | 97,3 % | 0 % |
| H | 10 / 1 ns | 8,0 % | 12,0 % | 83,3 % | 4,5 % |
| H | 100 / 1 ns | 23,3 % | 28,0 % | 70,0 % | 12,0 % |
| H | 10 / 0,1 ns; 1 o 10 / 10 ps | 0 % | 0 % | ≥ 97,3 % | 0 % |

En d = 240–300 nm no hay túnel en ninguna celda (túnel solo ≤ 1e-19 A).

**Perfil mínimo para PVR > 1,3 en d = 0** (G máximo; `_sol.txt` §3): central (S, cF 10, τ 0,1 ns): 1e20/2e20 con G ≤ 3;
2e20/2e20 con G ≤ 5; nada con una cara ≤ 5e19. Mejor caso (cF 100, τ 1 ns, H): 1e20/2e20 con G ≤ 10; 2e20/3e20 con G ≤ 20.
Con τ = 10 ps: lo mismo que el central si cF = 100; con cF = 10, 2 % de las celdas; con cF = 1, ninguna.

**Mapa de tres regiones** (parámetro: camino de túnel en equilibrio, que en d ≤ 0 fija (Np+Nn)/G):

| Región | Dónde | Qué hace |
|---|---|---|
| Convencional | d ≥ 0,24 µm (todo lo legal separado) | Diodo de pozo: ruptura por avalancha 6,6–11,7 V (modelo), 9,0–9,3 V (Dutta ≥ 240 nm), 12,7 V (PDK, p+/pozo). Sin túnel |
| Usable no convencional A | d = 0, casi todo el espacio (camino 6–25 nm) | Zener blando sin rodilla: fuga por túnel de nA a decenas de µA a 1,8 V, casi sin dependencia térmica. **Aquí cae SKY130 en todo perfil plausible** |
| Usable no convencional B | d = 0, camino ≲ 5–6 nm, dos caras ≥ 1–2e20, G ≤ 3–5 | Pico de Esaki; biestable posible |
| Fallo | cF·A alto y G ≤ 3 con 3e20: I(−1,8 V) ≈ 6 mA por 1,4 µm (límite de corriente del contacto y de li); o siliciuro sobre la frontera (sin dato) | Cuasi-corto |

La frontera convencional → A está en 0 < d < 0,1 µm (Dutta: 0,04 V/nm de ruptura por nm de hueco), dentro de la banda que el DRC
prohíbe. Solo la desalineación de máscaras la muestrea.

**Números en d = 0 por 1,4 µm de frontera, escenario central** (corrida; S / H):

| Np / Nn / G | camino (nm) | I(−1,8 V) S / H | Vz a 1 µA/µm S / H | I(−0,1 V) |
|---|---|---|---|---|
| 5e19 / 5e19 / 50 | 42,8 | 12 nA / 13 nA | 3,7 / 4,1 V | 4,9 pA |
| 5e19 / 5e19 / 20 | 18,5 | 0,19 µA / 0,12 µA | 2,4 / 2,9 V | 82 pA |
| 1e20 / 1e20 / 30 | 14,7 | 0,72 µA / 0,28 µA | 2,0 / 2,5 V | 0,20 nA |
| 1e20 / 1e20 / 20 | 11,9 | 3,9 µA / 0,75 µA | 1,5 / 2,1 V | 0,58 nA |
| 1e20 / 2e20 / 20 | 10,3 | 12,8 µA / 1,6 µA | 1,3 / 1,8 V | 1,2 nA |
| 1e20 / 1e20 / 10 | 8,7 | 50 µA / 3,7 µA | 0,9 / 1,4 V | 2,7 nA |
| 2e20 / 2e20 / 10 | 6,3 | 0,51 mA / 17 µA | 0,5 / 0,9 V | 20 nA / 13 nA |

Sensibilidades (S, `b20_firma_T.txt`): perfil erfc en vez de logístico, ±10 %; p+ el doble de difuso que n+ (Gp = 2Gn), I(−1,8)
baja ×2–3; estrechamiento de banda, sube ×2–2,5; pozo 2e17 en vez de 6e16, sin efecto en d ≤ 0. Con picos distintos, de dos
réplicas en espejo desalineadas 30 nm una da ×1,4–8 más corriente que la otra (5e19/2e20/20: ×6,3; 1e20/2e20/20: ×4,8).
Con picos iguales el solape compensa y deja zona casi intrínseca: artefacto de la simetría exacta, ya visto en la ronda 1.

## 4. ¿Es plausible el perfil mínimo? Física del implante

| Dato del PDK | Evidencia leída | Supuesto | Simulación | Conclusión |
|---|---|---|---|---|
| Rs n+ 120 Ω/□, p+ 197 Ω/□ (`sky130A.tech` l. 5106–5107); xj = 0,1 µm (documentación) | Dispersión lateral SRIM (nm) a 20 / 50 keV: As 5,3 / 9,6; P 9,8 / 19,8; B 29,5 / 55,7. BF2: sin tabla | Especie y energía de SKY130 no públicas; As 40–60 keV y BF2 20–30 keV serían lo coherente con 0,1 µm (inferencia del subagente) | — | σ lateral solo por dispersión: n+ ≈ 8–11 nm (As 40–60 keV, interpolado); p+ `[?]` (BF2 sin tabla; ~10–15 nm extrapolado) → G ≈ 12–22 antes de difundir |
| NSDM y PSDM se generan cerrando a 0 nm en el borde pegado (`sky130A.tech` l. 837–866: `bloat-or … 0`) | SkyWater: implante S/D a 0°; sesgo 3σ de máscara 0,032 µm; resina de 1,14 µm | — | ±30 nm cambia I(−1,8) hasta ×8 y quita el pico | La frontera real no es d = 0 exacto |
| — | Solomon: suelo **vertical** con ≤ 5 keV + RTA de 5 s: As 5–7,5; B/BF2 7–13 nm/década. ITRS 2001: 7,2 nm/década es requisito de la extensión bajo puerta a 130 nm, no del S/D profundo | — | — | Lo mejor publicado a esa generación ya es ≥ 5; un S/D profundo es más difuso |
| — | Solomon: sin resistencia negativa en esas uniones (salvo un indicio en BF2 en frío); lo atribuye a la interacción B–As. PKU arXiv 2410.12390: el implante limita la abruptez de su TFET de 0,13 µm | — | Pico solo con G ≤ 3–5 | **Intervalo plausible: G ≈ 10–35 (n+ más cerca de 10, p+ de 35). El perfil mínimo (G ≤ 5, dos caras ≥ 1e20) no es plausible** |
| Dopado activo medio ≈ 5–7e19 por cara (cálculo desde Rs y xj; curva de Irvin de memoria) | Solubilidad de B a 1000 °C ≈ 2e20 (no leída) | Pico 1–2e20 | 3e20 no es alcanzable | Barrer hasta 3e20 fue generoso |

Qué dato decide: un SIMS o SSRM lateral del S/D de SKY130, o la I–V medida. Vive si G ≤ 5; no hay fuente que lo apoye.

## 5. Ruptura: qué perfiles son compatibles con lo publicado

- Publicado: Dutta 1,8 V en d = 0 a 21 µA/µm, sin rodilla, sin dependencia térmica para d ≤ 60 nm (**leída**). Patentes (**no
  leídas**, fragmento): n+/p+ ≈ 4 V en 0,18 µm (US7056761); n+/p+ adyacentes con bloqueo de siliciuro 3–6 V (US7589944).
  US6268639 no es una unión lateral pegada (corrige a la ronda 1). SKY130 tiene `areaid.zer`, sin tensión pública.
- Modelo (Vz a 1 µA/µm, d = 0): 0,1–0,5 V en los perfiles con pico; 0,5–2,2 V con G = 10; 1,3–2,5 V con G = 20–30 y 1e20;
  2,4–4,1 V con 5e19 y G ≥ 20. **Los perfiles compatibles con 2–6 V son los de G ≥ 20 o pico ≤ 5e19: ninguno tiene pico.**
  Si un Zener lateral pegado de SKY130 rompe a ≥ 2 V a 1 µA/µm, la resistencia negativa queda excluida.
- El criterio de corriente importa: las patentes no dicen a qué corriente definen sus 3–6 V.
- d = 0,27 µm: avalancha a 6,6–11,7 V (modelo, sesgado alto). I(−1,8 V) ≈ 0,5–1,7 pA en el modelo, que es cota superior
  artificial (aplica al pozo el τ de 0,1 ns del material muy dopado); con el Js del PDK serían ~3e-18 A. Contraste d = 0 frente a
  d = 0,27: ≥ 7·10³ en el peor caso (12 nA frente a 1,7 pA).

## 6. Biestable y lectura (`b20_biestable_sol.txt`, `b20_spice_*.txt`)

- **Un diodo con resistencia:** biestable si R > |r_neg| y la alimentación cae en una ventana de ~0,1–0,15 V de ancho. |r_neg| va
  de 7 kΩ (3e20/G3) a 4 MΩ (1e20/G3). Con R = 3|r_neg| la excursión es 0,10–0,30 V.
- **Un diodo con fuente de corriente (transistor):** la corriente debe caer entre valle y pico: tolerancia ±(√PVR − 1): ±28 % con
  PVR 1,65; ±3,7 % con PVR 1,08. Excursión 0,13–0,45 V; con PVR alto el estado alto sube a la rama de difusión.
- **Par en serie:** ventana de alimentación 0,10–0,30 V con PVR ≈ 1,6–2,4 (excursión 0,13–0,19 V); se ensancha a 0,1–0,9 V con
  PVR > 10. Desajuste de picos tolerado ≈ PVR (×1,68 con PVR 1,68; ×1,02 con PVR 1,03).
- **Lo que lo mata es la alineación:** en las ocho celdas probadas, a d = +30 nm no queda pico, y con picos iguales tampoco a
  −30 nm. Un par de réplicas en espejo no es biestable (sí en 2 de 16 casos, con picos distintos y τ = 10 ns).
- **Lectura** (ngspice con modelos SKY130, 5 esquinas × −40/27/85 °C; subagente, posproceso rehecho por mí):
  - Comparador con par diferencial `pfet_01v8` 4/1, cola 200 nA, referencia 0,17 V: salida correcta en 15/15 con modo común
    0,05–0,40 V; offset sistemático < 0,05 mV; offset aleatorio σ = 7,6 mV (Monte Carlo, 150 copias; el escalado con área no
    salió como Pelgrom: 0,88 en vez de 2, sin explicar). 3σ ≈ 23 mV frente a 70–80 mV de margen. **Recomendado.** La variante lvt
    falla en 2/15.
  - nfet en inversión débil: I(0,25 V)/I(0,10 V) ≥ 27 en cada punto, I(0,30)/I(0,10) ≥ 82; pero no existe una corriente de
    referencia fija para todas las temperaturas (ventana 0,02–0,07): hace falta réplica. El lector con réplica (B2) **no se corrió**.
  - Inversor a alimentación reducida (0,2–0,6 V): ninguna configuración cumple umbral 0,15–0,20 V con ganancia > 5 en los 15.
  - Seguidor pfet + inversor: separa en 4/15, 0/15 y 1/15 según variante. No sirve.
  - Fuga del interruptor de reposición sobre el nodo: ≤ 0,57 pA a 85 °C (5,7 % de un pico de 10 pA). Corriente de puerta: cero
    por construcción del modelo (`igcmod = 0`), no es un resultado.
- **Firma si NO hay pico** (central, S): (1) I(−1,8 V) en d = 0 frente a d = 0,27: ≥ 7·10³. (2) Temperatura: I(−1,8 V) cambia
  ×1,2–1,8 entre 233 y 358 K, frente a ×1,6e6 de la difusión del PDK; a ±0,1 V cambia ×0,6–6 (ahí domina el exceso). (3) Forma:
  I(−1,8)/I(−0,9) = 15–57 (exponencial en inversa, sin rodilla). (4) El cociente I(−0,1)/I(+0,1) **no** distingue: sale 0,6–1,1
  en los perfiles plausibles porque el exceso es simétrico cerca de cero; solo supera 2 con G ≤ 5. Esto corrige a la ronda 1.

## 7. Geometrías enviables (`b20_drc_out/map.txt`, `map_r2.txt`; contenedor del precheck, Magic 8.3.568 + KLayout)

La primera tanda dibujó mal las máscaras de implante en varias sondas (MR_nsdm.WID.2: ancho mínimo 0,38 µm); la segunda (`r2`)
lo corrige. El subagente murió antes de escribir sus notas: no hay `b20_drc_NOTAS.txt`.

| Forma | DRC | Qué mueve |
|---|---|---|
| pdiff\|ntap pegados en pozo n (control) | pasa | — |
| ndiff\|ptap pegados en sustrato, d = 0 y d = 0,27 | pasa | Otro fondo (pozo p ≈ 2e17) y **polaridad de máscaras invertida**: signo contrario de la desalineación |
| Frontera en L (esquina) | pasa (r2) | Esquina convexa y cóncava: redondeo de la resina, campo de esquina |
| Peine de 4 dedos de 0,5 µm | pasa (r2) | Largo de frontera por área; separa frontera de área |
| Isla n+ de 0,5 y 0,6 µm dentro de p+, y la inversa | pasa | Frontera cerrada: no toca el STI; insensible al signo de la desalineación |
| Cuello de activo de 0,15 µm con la frontera en medio | pasa (r2) | Máximo borde de STI por largo de frontera |
| Alta tensión: mvpdiff\|mvntap en pozo, mvndiff\|mvptap en sustrato | pasa (r2) | Añade la punta HVNTM, que Magic retira 0,185 µm del p+ (`sky130A.tech` l. 1027–1038): unión más graduada. SkyWater dice que HVNTM llega a 0 en el borde pegado (hvntm.6b, leída): **contradicción sin resolver** |
| Con LVTN o con HVTP sobre la unión | pasa (r2) | Implantes de ajuste de umbral, ~1e17–1e18: no cambian una unión de 1e20; control barato |
| Frontera p+/n+ bajo una puerta (6 variantes) | **rechazada** (diff/tap.3, poly.5–8) | Transistor túnel: no enviable. La toma debe quedar a ≥ 0,30 µm de la puerta (poly.6, l. 4797–4804) |
| Solape de 5 y 10 nm; hueco de 5 nm a 0,26 µm | **rechazadas** | Nada intermedio pasa; 0,27 pasa |
| Contacto solo en esquina; tramo pegado de 0,15 µm; cuello asimétrico | **rechazadas** (nsd.5a/b, diff/tap.3) | — |

Qué capas afectan a una difusión S/D (SkyWater, leída por subagente): n+ de 1,8 V recibe solo NSDM (más la punta n, capa calculada
NTM); p+ recibe PSDM; alta tensión añade HVNTM. No existe máscara de punta p ni bloqueo de siliciuro. LVTN/HVTP son de canal.
Toma frente a difusión: mismo implante; cambia solo el nombre de capa (65/44 frente a 65/20).

**Las tres que más informan:**
1. Par en espejo pdiff\|ntap y ntap\|pdiff, más el mismo par ndiff\|ptap en sustrato, a 0° y 90°, con d = 0,27 y celda sin unión,
   leyendo I–V entre −1,8 y +0,8 V por pin analógico a dos temperaturas. Decide región, signo y tamaño de la desalineación.
2. Isla n+ en p+ (frontera cerrada, sin STI, insensible a la desalineación) frente a cuello de 0,15 µm (todo STI): separa
   unión plana de borde de aislamiento.
3. Peine de frontera larga con cada dedo a su pin, y dos de ellos en serie con el nodo medio al comparador pfet: escala la
   corriente con el largo y prueba el biestable sin apostar a un solo perfil.

El lector de precarga de 12,4 fF no sirve tal cual: 1 µA lo descarga en ~10–20 ns (cálculo). Hace falta rango nA–µA.

## 8. Predicciones contra resultados

| | Predicción | Resultado |
|---|---|---|
| P1 | 1e20/1e20/G5: Jp 0,1–30 A/cm², Vp 0,05–0,10 V, PVR 1,5–4 limpio | Jp 0,05 (cF 1) a 0,5 (cF 10): cumplida solo con cF ≥ 10. Vp = 0,03 V: **fallada**. PVR = 1 en casi todo escenario: **fallada** |
| P1 | 1e20/2e20/G20 sin pico; I(−0,1)/I(+0,1) > 3 | Sin pico: cumplida. Cociente 0,69: **fallada** |
| P2 | d = 0: PVR > 1,3 en 10–25 % (limpio), < 10 % (exceso alto); sin pico 70–90 % | 8–28 % con τ = 1 ns; 0–8 % con τ ≤ 0,1 ns; sin pico 70–100 %. Cumplida, salvo H con cF = 1 (0 %) |
| P3 | PVR > 1,3 pide dos caras ≥ 1e20 y G ≤ 7; 5e19/5e19 solo con G ≤ 3 | Más estricto: G ≤ 3–5. 5e19/5e19 nunca: **fallada** la segunda parte |
| P4 | Dispersión lateral As 5–10, P 10–20, B 20–40 nm; no plausible | As y P cumplidas; B sale 30–56: **fallada** por abajo. Conclusión cumplida |
| P5 | Hurkx dentro de ×30 del Jp publicado; segundo punto dentro de ×10 | **Fallada**: ×26–1300 por debajo. En inversa sí: ×5 (H), ×3 (S) |
| P6 | Con pico, Vz < 0,5 V; 2–7 V solo con G ≥ 20 o hueco, sin pico; d = 0,27: 8–13 V | Cumplida (0,1–0,5 V; 6,6–11,7 V) |
| P7 | Desajuste tolerado (PVR−1)/(PVR+1); espejo no biestable con G ≤ 10; cociente ≥ 50 en inversión débil | Tolerancia real ≈ PVR: **fallada** (pesimista). Espejo: cumplida. Cociente ≥ 82: cumplida |
| P8 | ndiff\|ptap, L y alta tensión pasan; puerta sobre la frontera rechazada | Cumplida |

## 9. Veredicto por sub-afirmación

| Sub-afirmación | Veredicto |
|---|---|
| La unión pegada conduce por túnel en inversa a 1,8 V | **SOBREVIVE**, con ancla publicada (Dutta, 65 nm). En SKY130 depende de que no haya siliciuro sobre la frontera: sigue sin dato |
| Tiene resistencia negativa | **Improbable, no muerta.** Muere en el escenario G ≥ 10 (el plausible por implantes). Vive si G ≤ 5 con dos caras ≥ 1e20, o si el modelo subestima el pico ≥ 2 órdenes más de lo ya concedido |
| El par en serie es un biestable legible | **TRANSFORMADA**: condicionado al pico y a alineación mejor que ~30 nm; legible con comparador pfet, no con lógica |
| Firma térmica y de forma sin pico | **SOBREVIVE**; el cociente inversa/directa a 0,1 V **MUERE** como firma |
| "Nadie lo ha medido en fundición" | Dutta midió la inversa en 65 nm. La directa de una unión S/D pegada de fundición sigue sin encontrarse |

## 10. Lo nuevo

1. La unión pegada de fundición está medida en inversa (Dutta): no es conjetura que conduzca; es un Zener sin rodilla de ~2 µA/µm a 1 V.
2. La ruptura sube ~0,04 V por nm de hueco: la tensión Zener de dos réplicas en espejo mide la desalineación NSDM/PSDM con
   resolución de nanómetros, sin necesitar resistencia negativa.
3. La versión en sustrato (ndiff|ptap) invierte el papel de las máscaras: cuatro uniones dan signo y tamaño por duplicado.

## 11. Sin hacer y límites

- Lector con réplica (SPICE B2), resumen de SPICE y notas de DRC: los subagentes murieron por el límite de uso; rehíce el
  posproceso de SPICE (las tablas parciales de las 13:41 están en `b20_spice_parcial_1341/`). El texto literal de cada regla
  disparada no se extrajo.
- Barrido a 233 K con el juego H: no se repitió. Koga y Toriumi, Hurkx 1992, Fair y Wivell: sin abrir.
- Sin 2D, sin DEVSIM, sin ancla en directa, sin dato de siliciuro.
- **Archivos inválidos, no borrados:** ocho `b20_barrido_* … .pkl/.log` con espacios en el nombre son copias del barrido base
  (argumentos pasados sin separar). `b20_barrido_prueba.*` y `b20_analisis_prueba.txt` son de antes de corregir la integral de
  ionización. `b20_analisis_base_lejos.txt` quedó truncado por un fallo del script; vale `b20_lejos.txt`.
