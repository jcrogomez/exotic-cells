# e14 / e07 / e53 — Prerregistro del ataque a XC-14 (nodo flotante), XC-07 (ruptura de óxido) y XC-53 (bomba)

Hora de `date`: Thu Nov 12 22:33:58 EST 2026. Escrito ANTES de leer literatura nueva y antes de correr nada. Leído hasta ahora:
encargo, protocolo, DATOS_PROCESO, planes de XC-14/07/45/11/53, PLANTILLA, precheck_map, RONDA_3, c58_INFORME (grep), PESCA_PHOTON
(grep). Todas las predicciones de abajo son **DE MEMORIA** o **cálculo a mano**; su función es poder fallar.

## Qué voy a calcular o simular

| Id | Qué | Cómo |
|---|---|---|
| A | J de túnel directo de SiO2 4,15 nm, 0,1–1,8 V | WKB propio (barrera trapezoidal, masa efectiva barrida) anclado a un punto medido leído |
| A2 | τ de descarga de una puerta flotante, frente a área y C añadida; V(t) de la carga que deja la fábrica | integración de dV/dt = −J(V)·A/C |
| B | Carga de plasma: tensión durante el grabado, qué queda tras el recocido | literatura + el mismo V(t) partiendo de la tensión de plasma |
| C | Escritura: FN e inyección en 4,15 y 11,6 nm; Chen/Sonnadara/Shah 2024 | fórmula FN con constantes publicadas + lectura |
| D | Mapa (V, t_ox, t) | de A–C y E |
| E | TDDB de 4,15 nm a 1,8/2,5/3,3/5 V y área | modelos E, 1/E y potencia con parámetros leídos; intervalos |
| F | Filamento emisor con bomba | repaso de PESCA_PHOTON + presupuesto de corriente de G |
| G | Bomba de Dickson: V(N) desde 1,8 y 3,3 V, I, área, límites | cálculo + ngspice con los modelos `g5v0d10v5` del PDK |
| H | Admisibilidad en Tiny Tapeout | lectura de tinytapeout.com/specs/analog y reglas HV del PDK |

## Predicciones numéricas (antes de correr)

- **P-A1.** J(1,0 V; 4,15 nm) entre 1e-11 y 1e-9 A/cm² (central 1e-10). Pendiente ≈ 1 década por cada 0,2–0,25 nm de espesor.
  J(0,3 V) entre 10 y 300 veces menor que J(1 V).
- **P-A2.** τ = C_ox·V/J a 1 V (solo la puerta, C_ox ≈ 0,83 µF/cm²): entre 10³ y 10⁵ s (horas). A 0,3 V: días a meses.
  τ independiente del área de puerta (tautología, ver abajo); con una placa de metal añadida, τ × (C_total/C_puerta).
- **P-A3.** Lo que deja la fábrica en una puerta verdaderamente flotante: tras ~6 meses (fabricación → mesa) quedan entre 0,2 y
  0,6 V de |V_ox|, casi independiente de la tensión inicial (la curva V(t) es casi logarítmica y olvida la condición inicial).
  O sea: **legible** por el lector de XC-19 (0,305 mV de paso) con cientos de pasos de margen, pero **igual en todas** las celdas
  salvo por el espesor local del óxido → sería un medidor de espesor/tiempo, no una memoria de la carga de plasma.
- **P-A4.** El "10 s a 15 min" del plan de XC-45 es demasiado corto para 4,15 nm a ≤ 1 V con solo la puerta; solo valdría para V ≥ 1,5 V.
- **P-B1.** Literatura: durante el grabado la puerta flotante se autolimita en la tensión donde FN iguala la corriente de plasma:
  10–12 MV/cm → 4–5 V en 4,15 nm. El recocido en gas de formación pasiva estados de interfaz pero no neutraliza todas las trampas;
  para óxidos < 5 nm el corrimiento de V_T por carga atrapada es pequeño (< 10 mV) porque las trampas se vacían por túnel; queda
  daño latente (SILC, más ruido 1/f). Predicción: no encontraré una medida de "carga de plasma retenida en una puerta flotante
  lógica" → `[?]`.
- **P-C1.** FN en 11,6 nm: J = 1e-6 A/cm² a ~7,5–8 MV/cm → 9–10 V sobre el óxido; con relación de acoplo 0,7–0,9, 10–13 V en la
  puerta de control. En 4,15 nm, FN a 4–5 V pero retención de horas (P-A2) → inútil como memoria de años; útil como temporizador.
  Retención del 11,6 nm por túnel directo: > 10 años sin duda (J < 1e-20 A/cm² a 1 V).
- **P-C2.** Chen/Sonnadara/Shah 2024: predigo que usan el transistor de 5 V (óxido grueso), inyección por portadores calientes en
  pfet a ~5–6,5 V y túnel a ~10–12 V, y retención dada en mV/día o extrapolada a años. No sé si podré abrirlo (IET, acceso abierto: probable).
- **P-E1.** TDDB, 4,15 nm, área de un transistor pequeño (≤ 1 µm²), tiempo mediano: a 1,8 V > 10⁴ años; a 2,5 V años–miles de años;
  a 3,3 V entre 10 s y 10⁷ s (los modelos discrepan ≥ 5 décadas: ese es el resultado); a 5 V entre 1e-4 y 10 s.
  Predicción dura: **3,3 V solo NO da ruptura fiable en < 1 h** con los modelos conservadores (E), sí con ley de potencia.
- **P-E2.** Tras ruptura blanda: 10⁵–10⁷ Ω, no óhmica (ley de potencia I~V^a), ruidosa; tras dura: 10²–10⁴ Ω según la corriente
  límite. Resistencia programable por cumplimiento: sí en la literatura de antifusibles (R ∝ 1/I_prog).
- **P-G1.** Dickson con nfet `g5v0d10v5` conectado en diodo y cuerpo a sustrato: desde 1,8 V **se satura por debajo de 5 V** con
  cualquier número de etapas (V_T con efecto de cuerpo ≈ 1,1–1,6 V se come casi toda la ganancia por etapa de ~1,6 V). Desde 3,3 V:
  ganancia ≈ 1,5–2 V por etapa → 10 V con 5–6 etapas en vacío.
- **P-G2.** Con interruptores sin pérdida de umbral (pfet en pozo propio / cruzado) desde 1,8 V: ≈ 1,5 V por etapa → 10 V con 6–7 etapas.
- **P-G3.** Corriente: I ≈ f·C·ΔV; con 1 pF por etapa (500 µm² de MiM a 2 fF/µm²) y 10 MHz, ~1–5 µA con caída de 0,1–0,5 V por
  etapa. Área de 6 etapas de 1 pF: ~3000–4000 µm² de MiM + interruptores: cabe en una tesela (≈160 × 100 µm).
- **P-G4.** Límite duro: ruptura de unión n-pozo/sustrato y n+/sustrato ≈ 11–13 V; V_GS de 5,5 V nominal obliga a que ningún
  dispositivo vea más de una etapa entre puerta y canal. Tensión útil máxima ≈ 10–11 V.
- **P-F1.** El filamento emisor (1–6 mA a 2,5–6,4 V) no lo puede sostener una bomba de una tesela (µA): la bomba solo sirve para
  **formar** (y ni eso si el formado pide mA: daría ruptura blanda, no filamento fundido). Operación desde el raíl de 3,3 V.
- **P-H1.** Tiny Tapeout analógico: VAPWR 3,3 V opcional, pines analógicos con límite de tensión/corriente (recuerdo ~4 mA y
  resistencia serie de ~500 Ω), met5 prohibido, sin regla explícita sobre tensiones generadas internamente → `[?]`.

## Qué mataría cada idea

- XC-14 muere si J(≤ 1 V; 4,15 nm) anclado a medidas da τ < 1 s con cualquier C enviable (no se podría leer antes de que se vaya),
  o si la literatura muestra que el recocido final descarga toda puerta flotante y que además no hay forma de reescribir.
  XC-14 «nace escrita» (identidad de fábrica) muere si P-A3 se cumple: la carga residual es universal, no por celda.
- XC-45 (temporizador) muere si τ a tensiones legibles cae fuera de 1 s–1 semana con cualquier relación de capacidades enviable,
  o si la fuga del interruptor (0,66 fA, c58) domina siempre sobre el túnel.
- XC-11 (memoria) sobre 4,15 nm muere si τ(0,3–1 V) < 1 día. Sobre 11,6 nm muere si la tensión de escritura supera lo que la
  cadena de dispositivos aguanta (> 11 V).
- XC-07 muere (como experimento de una tesela) si a la tensión máxima alcanzable (bomba ≤ 10–11 V, o 3,3 V sin bomba) el tiempo
  hasta ruptura mediano es > 10⁴ s en todos los modelos. Vive si hay una ventana V donde t_BD ∈ [1 ms, 1 h].
- XC-53 muere si las reglas del PDK o de Tiny Tapeout prohíben nodos internos > 5,5 V, o si la simulación no pasa de ~5,5 V con
  los dispositivos permitidos desde ninguna de las dos alimentaciones.

## Qué las dejaría vivas

Lo contrario, con el dato de proceso que decide señalado. Nada de esto usa silicio: todo veredicto será «en el escenario X».

## Tautologías (se deducen sin correr)

1. τ de túnel independiente del área de puerta: J·A y C_ox·A escalan igual. No es resultado, es definición. Lo que SÍ informa es
   el barrido de C añadida (metal) y el perímetro (bordes poly/difusión), que no escalan con el área.
2. Con `igcmod = 0` el modelo del PDK da retención infinita salvo uniones: ninguna simulación con el PDK dice nada del túnel.
3. Una puerta totalmente flotante (sin interruptor) no tiene fuga de unión: su única vía es el óxido (y la superficie/dieléctrico
   entre metales, que supongo despreciable y no sé demostrar: `[?]`).
4. Vout ideal de Dickson = Vdd + N·(Vdd·C/(C+Cs) − V_caída) − N·I/(f·(C+Cs)): la simulación solo aporta V_caída real (efecto de
   cuerpo) y las fugas.
5. A 3,3 V el campo en 4,15 nm es 8 MV/cm nominal, pero la tensión sobre el óxido no es la aplicada: hay que restar banda plana
   y agotamiento del poly (~0,3–1 V según polaridad). Cualquier t_BD «a 3,3 V» lleva esa ambigüedad de polaridad.

## Criterio de abandono

Si tras ~6 fuentes no encuentro curva medida de J(V, t_ox) en 3,5–4,5 nm, anclo al punto más cercano publicado y ensancho el
intervalo en ±1 década. Si ngspice no arranca en 3 intentos, la bomba queda en cálculo y lo digo.
