# b20 · Prerregistro del ataque 2 a XC-20 (perfiles y transporte)

Hora (`date`): Thu Nov 12 13:29:18 EST 2026. Escrito antes de correr nada y antes de lanzar búsquedas de literatura de esta ronda.
Leído hasta aquí: encargo, PLAN.md, a20_INFORME.md, v1_VEREDICTO.md, RONDA_1, DATOS_PROCESO, precheck_map/README, a20_lib.py,
a20_perfil.py. Nada más.

## Qué voy a calcular

M. **Modelo** (`b20_lib.py`, a partir de a20_lib): Poisson 1D con Fermi-Dirac; túnel banda a banda por camino no local (WKB
   de dos bandas sobre el perfil autoconsistente), prefactor tipo Hurkx **calibrado contra un punto publicado** (tarea 3) en vez
   de dejado de memoria; estrechamiento de banda por dopado como opción (escenario); corriente de exceso como túnel asistido
   por estados en la banda prohibida (WKB con barrera reducida, estilo Chynoweth) con constante **paramétrica** (escenarios
   "limpio", ×10, ×100); difusión/recombinación con el diodo del PDK (jss, njs) como cota; multiplicación por avalancha con
   integral de ionización local (para la ruptura). NO incluye: fonones explícitos (el túnel indirecto entra solo por el
   prefactor empírico y F0), 2D (curvatura en profundidad), trampas con dinámica, resistencia serie (se añade aparte).
1. Curvas I–V de −1,8 a +0,8 V para todas las celdas.
2. Barrido: Np, Nn ∈ {2e19, 5e19, 1e20, 2e20, 3e20} (25 pares), G ∈ {3, 5, 10, 20, 30, 50} nm/década, d ∈ {−100, −30, 0, +30,
   +100, +240, +270, +300} nm, pozo Nw ∈ {6e16, 2e17}; subconjuntos con G distinto por lado y con perfil erfc (σ).
3. Ancla Esaki: reproducir Jp publicado de al menos un diodo Esaki de silicio de dopado/anchura conocidos.
4. Ruptura inversa de cada perfil (criterios 1 nA/µm y 1 µA/µm de frontera con xj = 0,1 µm; y avalancha) contra literatura.
5. Biestable: línea de carga (resistencia, transistor), par en serie, márgenes; lectura con circuitos de SKY130.
6. Lista de geometrías legales (grep del PDK + sondas DRC si el contenedor del precheck está a mano).

## Tautologías (se deducen sin correr)

- T1. Con el umbral corregido (2,1–2,5e19), toda celda con las dos caras ≥ 5e19 en el borde del vaciamiento tiene solape de
  bandas en equilibrio; que haya pico ya no lo decide la degeneración sino el camino de túnel (G) y el exceso.
- T2. En d = 0 con dos bordes de máscara coincidentes la unión cae donde cada implante está a ~mitad de pico: el gradiente neto
  es ≈ (Np+Nn)·ln10/(4G). Unión lineal: W = (12 ε Vbi/(q a))^(1/3). Para 1e20/1e20, G = 14 nm/déc: W ≈ 10 nm, Emax ≈ 1,6 MV/cm.
- T3. En d ≥ 0,24 µm no hay túnel: el pozo (≤ 2e17) pone ≥ 70 nm de vaciamiento. La ruptura ahí es avalancha/alcance, ~8–13 V.
- T4. La relación pico/valle depende linealmente de la constante de exceso supuesta: sin dato de trampas del proceso, la
  fracción "PVR > x" es un intervalo por escenario, no un número.
- T5. Un biestable de dos diodos en serie exige PVR > 1 y alimentación entre ~2·Vp y Vp+Vv'; la excursión está acotada por
  Vv−Vp ≲ 0,3 V: ningún inversor a 1,8 V la lee directamente (ya dicho en ronda 1).

## Predicciones numéricas

- P1 (I–V, celda 1e20/1e20, G = 5, d = 0): Jp entre 0,1 y 30 A/cm² tras calibrar; Vp 0,05–0,10 V; con exceso "limpio" PVR 1,5–4.
  Celda 1e20/2e20, G = 20, d = 0: sin pico (PVR < 1,05) en todo escenario de exceso; es un backward: I(−0,1)/I(+0,1) > 3.
- P2 (fracciones, d = 0 y pozo 6e16, sobre 25 × 6 = 150 perfiles): PVR > 1,3: 10–25 % (limpio), < 10 % (×100);
  PVR > 2: 5–15 % (limpio), < 5 % (×100); sin pico: 70–90 %. Sobre todo el espacio con d: PVR > 1,3 en < 10 %.
- P3 (perfil mínimo para PVR > 1,3 en escenario ×10): las dos caras ≥ 1e20 y G ≤ 7 nm/déc (a mitad de pico). Con el umbral
  corregido espero que 5e19/5e19 dé pico solo con G ≤ 3.
- P4 (plausibilidad del implante): dispersión lateral a 20–50 keV: As 5–10 nm, P 10–20 nm, B 20–40 nm, BF2 (B efectivo a
  ~1/4,5 de la energía) 8–15 nm (**de memoria**); más difusión de RTA (B: √(2Dt) ~ 10–30 nm con difusión transitoria).
  G equivalente = 1,44 σ → n+ 10–20 nm/déc, p+ 20–50 nm/déc. Predicción: el perfil mínimo de P3 NO es plausible para S/D de
  130 nm; SKY130 cae en la región de túnel inverso/backward (Z o B), no en N.
- P5 (ancla Esaki): con los parámetros de Hurkx de memoria (A = 4e14, F0 = 1,9e7) el modelo queda dentro de ×30 del Jp
  publicado para un Esaki de silicio de ~1e20 efectivos (publicado: 1e2–1e4 A/cm² a anchura de túnel 5–6 nm, **memoria**);
  espero que el modelo quede POR DEBAJO (la ronda 1 dio 4,6 A/cm² para 1e20 abrupta simétrica). Tras calibrar, dentro de ×3 por
  construcción en el punto de ancla; la prueba es un segundo punto: dentro de ×10.
- P6 (ruptura, d = 0): perfiles con pico (N) tienen "ruptura" < 0,5 V a 1 µA/µm (no hay rodilla). Perfiles con Vz(1 µA/µm)
  entre 2 y 7 V (lo que espero de la literatura de 130–180 nm para p+/n+ pegados o casi) son los de G ≥ 20 con pico ≤ 1e20, o
  cualquiera con hueco ≥ 30–100 nm: todos SIN pico en directa. Es decir: si SKY130 tiene un Zener lateral de ≥ 4 V en d = 0, la
  resistencia negativa queda excluida. d = 0,27: 8–13 V (avalancha con alcance).
- P7 (biestable): par en serie biestable con desajuste de pico hasta ~(PVR−1)/(PVR+1); con PVR 1,3 tolera < 15 %; la
  desalineación ±30 nm con G ≤ 10 produce desajustes > ×3 entre réplicas en espejo → el par con réplicas en espejo NO es
  biestable salvo G ≥ 20 (donde no hay pico): contradicción práctica. Lectura: un nfet en inversión débil con puerta en el nodo
  da cociente de corriente ≥ 50 entre 0,1 y 0,3 V (pendiente ~90 mV/déc → 10^(0,2/0,09) ≈ 170).
- P8 (geometría): n+/p+ en sustrato (ndiff|ptap) pasa el DRC igual que pdiff|ntap; frontera en L (esquina) pasa; versión de
  alta tensión (dentro de hvi) pasa; frontera p+/n+ bajo una puerta de poly: rechazada [?] (apuesta 60/40).

## Qué mataría / qué deja viva

- **Resistencia negativa** muere en un escenario si: con ancla Esaki cumplida, ningún perfil con G ≥ 10 da PVR > 1,3 ni con
  exceso "limpio", Y la abruptidad plausible de la literatura de implantes es G ≥ 10. Vive si la literatura da G ≤ 7 nm/déc
  para As/BF2 de baja energía con RTA de pico, o si la ancla muestra que mi modelo subestima ≥ 2 órdenes.
- **Túnel inverso en d = 0** muere si los perfiles compatibles con las rupturas publicadas (P6) dan I(−1,8 V) bajo el piso
  del lector (150 fA) — entonces la unión pegada es un diodo ordinario a 1,8 V. Vive si I(−1,8 V) ≥ 10 × piso en esos perfiles.
- **Sin ancla**: si no consigo abrir ninguna fuente con Jp frente a dopado/anchura, lo diré y todo queda como intervalo de
  ±2 órdenes.
- Criterio de abandono de exploraciones: si el barrido completo tarda > 40 min, recorto a d ∈ {−30, 0, +30, +100, 270}.
