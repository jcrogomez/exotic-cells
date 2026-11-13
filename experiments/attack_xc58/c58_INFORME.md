# c58 · Informe del ataque a XC-58 (celda kT/C)

Cerrado: Thu Nov 12 19:36:24 EST 2026 (hora de `date`). Prerregistro: `c58_PREREG.md` (19:04, antes de correr). **Todo es modelo y cálculo; nada medido en
silicio.** Un solo agente, sin verificar por un segundo cálculo independiente salvo donde se dice. ngspice 44.2 en
`hpretl/iic-osic-tools:2025.07`, PDK local `8afc8346`, esquina tt.

## 1. Veredicto por sub-afirmación

| Sub-afirmación | Veredicto | En una línea |
|---|---|---|
| Queda congelada una varianza kT/C | **SOBREVIVE, con factor** | En el nodo mínimo (0,96 fF) la varianza congelada es 0,88–0,92 de kT/C (Monte Carlo propio); cota inferior 0,68 ± 0,04 (ngspice, subestimación conocida, ver §3). Desde 3 fF, 0,96–1,00 en los dos métodos |
| 1–10 fF → 2,0–0,64 mV → 5,5–1,75 % | **SOBREVIVE; el punto de trabajo, TRANSFORMADO** | La aritmética previa se sostiene (5,35 % y 1,75 %). Pero el nodo aislado no funciona como el lector de XC-19: pedestal de −113 a −223 mV, salto de +28 mV al soltar la precarga, y la puerta cae 132 mV durante la descarga, que pasa de 29 a 330 µs |
| La varianza sigue 1/C | **SOBREVIVE** entre 1 y ~30 fF | Tres capacidades en ngspice dentro de ±6 %; corrección conocida (1 − 0,85·Cov/C). El piso del lector la tapa a 95 fF |
| Es proporcional a T | **MUERE para el observable** | La tensión sí (tautología). El tiempo relativo, que es lo que se mide, va como ~1/T: la ganancia del lector es 1/(n·kT/q). Sensibilidad simulada −0,08 a −0,31 %/K, de signo contrario al plan |
| Cada muestra es independiente | **TRANSFORMADA** | El nodo no guarda memoria (exp(−400)). La correlación la ponen el lector (ruido lento, trampas) y la alimentación: ρ₁ entre 0,002 y 0,02 a 0,96 fF y entre 0,015 y 0,14 a 10 fF según el escenario de trampas. Hay que restar muestras sucesivas o ir por la vía no-IID |
| Fuente de azar | **SOBREVIVE** | 6–11 bits ideales por muestra (tope 8 por SP 800-90B); la validación pide 2·10⁶ conversiones: 68–660 s |
| Termómetro primario | **MUERE «primario»; queda secundario y lento** | C se conoce a ±10 % (supuesto) → ±32 K; a 85 °C la fuga del modelo falsea −29 K (−3 a −290 K para fuga ×0,1–×10). El cociente entre dos capacidades cancela también T |

## 2. Las cinco columnas

| Dato del PDK | Evidencia publicada leída | Parámetro supuesto | Resultado de simulación | Conclusión física |
|---|---|---|---|---|
| `cgso = cgdo = 2,449e-10 F/m` (`sky130_fd_pr__nfet_01v8__tt.pm3.spice` l. 187–188) → 0,103 fF por lado a W = 0,42; `cjs = 1,34e-3 F/m²`, `cjsws`, `cjswgs` (l. 241–247) → unión 0,26 fF; hilo extraído de VB 0,237 fF (`xc19_read.pex.spice` C0, C2, C4, C6) | — | Tolerancias de óxido ±5 %, solape ±20 %, unión ±15 %, hilo ±25 % (no públicas) | Nodo de puerta con interruptor nfet mínimo: **0,963 fF** (1 aC → 1,038 mV, `c58_det4.txt`); con +2 y +9 fF ideales, 2,96 y 10,0 fF | El mínimo alcanzable es ~1 fF y es todo parásito: unión del interruptor 27 %, lector ~38 %, hilo 25 %, solape del interruptor 11 %. Incertidumbre ±10 % (supuesto) |
| `toxe = 4,148 nm` (l. 62) | — | — | Ganancia respecto de la tensión congelada: **2,73 %/mV** a 0,96, 2,96 y 10 fF (27 °C); 2,28–2,45 %/mV a 85 °C | La ganancia 0,83 %/0,305 mV se conserva con la puerta flotante; cae con T como 1/(n·kT/q) |
| — | Tian, Fowler, El Gamal (preimpresión SPIE de «Analysis of temporal noise in CMOS APS», leída: ecs. 16–19): reinicio en subumbral sin equilibrio da ½·kT/C; con puerta sobreexcitada o pMOS, kT/C | Ruido 2kT(g_nodo + g_fuente); interruptor EKV ajustado a la conductancia de ngspice (error rms 0,11 en ln g) | Varianza / (kT/C), Monte Carlo: 0,90–0,92 (1 fF), 0,96–0,98 (3 fF), 0,98–1,00 (10 fF), sin dependencia del flanco entre 50 ps y 5 µs ni de T; control sin acoplo 1,01. ngspice (ruido de equilibrio): 0,68 / 0,99 / 0,94 ± 0,06 | kT/C es independiente de la resistencia y del flanco, pero **no** del acoplo del reloj: el reloj saca al nodo del equilibrio y el interruptor lo devuelve en un solo sentido. Depende de Cov/C |
| `jss = 2,75e-3 A/m²`, `jsws = 6e-10 A/m`, `xtis = 2` (l. 234–235, 268); `igcmod = 0` (l. 47), `agidl = 0` (l. 156): sin túnel de puerta ni GIDL en el modelo | — | Fuga real ×0,1–×10 del modelo | Nodo aislado: **0,66 fA** a 27 °C (deriva 0,69 V/s) y **290 fA** a 85 °C (297 V/s) (`c58_swdc_*.log`, `c58_det2`) | A 27 °C la fuga no molesta por debajo de ~3 ms. A 85 °C deriva 8 mV en una conversión de 25 µs y su ruido de disparo añade ~9 % de varianza en el nodo mínimo |
| `noia = 2,5e42` (l. 212) | README de XC-19: 0,66 trampas visibles por década por dispositivo (estimación, no dato) | Varianza lenta del lector 0,0012–0,012 mV²/década; Dit del interruptor 10¹⁰–10¹¹ cm⁻²eV⁻¹ → 0,9–2,7 e | — | Una trampa del lector vale 0,305 mV frente a σ = 1,96 mV (0,96 fF) o 0,64 mV (10 fF). Las trampas del interruptor pesan 0,5–4,7 % de kT/C a 0,96 fF y diez veces menos a 10 fF |
| — | NIST SP 800-90B (leído, §3.1.1–3.1.4, §4.4): 1 000 000 muestras crudas consecutivas; 1000 reinicios × 1000; alfabeto ≤ 256; H = mín(Hr, Hc, HI); pruebas de salud: repetición (C = 1 + ⌈20/H⌉ con α = 2⁻²⁰) y proporción adaptativa (ventana 512 si no es binaria) | Reloj del contador 50 MHz `[?]` | — | Hacen falta 2·10⁶ conversiones: 660 s a 0,96 fF, 68 s a 10 fF |

## 3. Resultado contra cada predicción

| # | Predicción | Obtenido | |
|---|---|---|---|
| A1 | Nodo 0,8–1,5 fF, no menos de 0,6 | 0,963 fF | cumplida |
| A2 | Ganancia 2,5–2,9 %/mV; tiempo ×2–×20; la puerta cae 50–120 mV | 2,73 %/mV; ×11 (330 µs); cae 132 mV | cumplida, salvo la caída (por poco) |
| A3 | La ganancia cae como 1/T (−0,3 %/K) | −0,19 a −0,31 %/K | cumplida |
| B1 | Pedestal −60 a −250 mV a 1 fF, ~1/C; < 0,1 mV por mV de VDD | −113 / −154 / −223 mV (5 ns / 500 ps / 50 ps); no escala como 1/C (−23 mV a 10 fF, no −15); 0,073 mV/mV | cumplida; la escala 1/C, **fallada** |
| B2 | < 1 fA a 27 °C; ×30–×300 a 85 °C | 0,66 fA; ×440 | cumplida a 27 °C; **fallada** a 85 °C, por abajo |
| C1 | 0,5–1,0 de kT/C; 0,85–1,0 a 1 fF, casi independiente del flanco; nunca > 1,05 | MC: 0,88–0,92 a 1 fF, independiente del flanco. ngspice: 0,68 ± 0,04 | cumplida en el MC; **fuera de banda en ngspice** (explicado abajo, no resuelto del todo) |
| C2 | Ruido transitorio en ngspice dentro de ±30 % | Se simuló la tensión congelada, no el tiempo: 1,709 / 1,179 / 0,627 mV con 600 / 600 / 520 muestras | parcial |
| D1 | ρ₁ < 10⁻³ a 1 fF, ~10⁻² a 100 fF | Polarización: 7·10⁻⁵–3,5·10⁻⁴ y 3·10⁻³–1,5·10⁻². Con el ruido lento del lector: 0,002–0,018 a 0,96 fF | cumplida para la polarización; **fallada** al incluir el lector, que no había previsto |
| D2 | 5–8 bits ideales a 1 fF | 11,1 (la conversión dura 330 µs y da más cuentas) | **fallada**, por arriba |
| E1 | −0,33 %/K; 1 K ≈ 1,8·10⁵ conversiones; ±30–60 K sin calibrar; el cociente no contiene T | −0,08 a −0,31 %/K; 2,0·10⁵; ±32 K | cumplida |
| F1 | kT/C manda de 1 a 30 fF con periodo < 1 ms; lector desde ~100 fF; fuga desde 1–100 ms | A 27 °C sí (lector desde 95 fF; fuga desde 3,8–39 ms). A 85 °C la fuga manda desde 10–100 µs | cumplida a 27 °C; a 85 °C no la había previsto |

**La discrepancia 0,68 frente a 0,90 en el nodo mínimo.** La fuente de ruido que añadí en ngspice es la de equilibrio (4kT·g medida en
una réplica del interruptor con fuente y drenaje a la tensión de polarización). Cuando el pedestal baja el nodo 150 mV, el interruptor
real conduce en un solo sentido, con más conductancia del lado del nodo y ruido de disparo que la réplica no ve: ngspice amortigua sin
el ruido que corresponde. Hipótesis y banda escritas antes de probarla (`c58_mc2.py`): el Monte Carlo con ese mismo ruido «de réplica»
debía dar 0,60–0,78; dio 0,76 (y 0,88 con el ruido completo). Queda una diferencia 0,76 → 0,68 sin explicar del todo (2 σ
estadísticas; el paso de Euler implícito tras cada punto de ruido quita ~2 %; el Monte Carlo no lleva la carga de canal).
**Intervalo honesto en el nodo mínimo: 0,68–0,92; valor más probable 0,88–0,90.** El piso teórico es 0,5 (Tian et al.).

**Errores míos corregidos en el camino.** (1) Primer lote de decks abortado por un pulso de carga de 1 ps (`c58_det_*`, conservado).
(2) Tres intentos de ruido transitorio abortados (coincidencia del flanco con la rejilla del ruido; raíz no derivable en cero).
(3) La primera versión de `c58_regimes.py` no restaba los 3 µs previos a soltar la precarga: daba ganancias de 2,51–2,71 %/mV y una
caída falsa con C; corregido a 2,73 en los tres (`c58_regimes_v1_*` conservado). (4) Estimé 1,4–1,5 fF a partir del pedestal antes de
medirlo: era 0,963.

## 4. Lo que el plan no decía

1. **El interruptor desplaza el punto de trabajo, no solo la media.** −154 mV de pedestal son 4 n·kT/q: sin subir la polarización el
   lector corre e⁴ veces más lento. Compensado, la sensibilidad de la muestra a la tensión de la fuente es 0,67 (0,96 fF), 0,93
   (3 fF), 0,98 (10 fF), no 1.
2. **La puerta flotante se mueve con el drenaje**: Cgd/C = 0,13 en el nodo mínimo. Es determinista y no cambia la ganancia relativa,
   pero alarga la conversión once veces y con ella la exposición a la fuga.
3. **Sensibilidad a la alimentación 0,45–0,52 %/mV**: 1 mV eficaz son el 0,9 % de la varianza a 0,96 fF y el 8 % a 10 fF.
4. **El pfet no conduce a 0,3 V** (hace falta V_SG > |V_T|). Una «puerta de paso» aquí es un nfet más un compensador de acoplo: baja el
   pedestal de −154 a −101 mV. El ficticio (interruptor 0,84 + ficticio 0,42) sobrecompensa: +120 mV.
5. **Control en el mismo nodo**: convertir varias veces sin volver a muestrear (solo lector, fuga y deriva) frente a remuestrear cada vez.
   La diferencia de varianzas es kT/C más lo que añada el interruptor, sin depender de un segundo dispositivo.
6. **Pista (conjetura, sin simular)**: la varianza kT/C en tiempo relativo es q²/(n²·C·kT) y la pendiente varianza/deriva de una
   corriente de disparo conocida es q²/(n·C·kT); su cociente da n sin referencia de tensión. Con un escalón de tensión conocido
   salen n·T y, de ahí, T y C. La temperatura la da el escalón, no el ruido.
7. **Leída al revés, la celda mide C**: a temperatura conocida, C = f·kT/σ² con 1 % en 2·10⁴ conversiones, para nodos de 1–30 fF
   que ningún otro instrumento del catálogo alcanza.

## 5. Mapa de regímenes (`c58_mapa.png`, `c58_regimes.txt`)

Parámetros: capacidad del nodo y tiempo de retención (= conversión), con la temperatura como tercer eje.

| Región | Dónde | Qué manda |
|---|---|---|
| Convencional | C > ~95 fF (kT/C = piso del lector); > 10 fF ya no llega a 3× el piso | El lector: el muestreo no se ve |
| Tercera | 0,96–30 fF, retención < 3 ms a 27 °C | kT/C con el factor (1 − 0,85·Cov/C); 12,5 e eficaces a 0,96 fF, 40 e a 10 fF |
| Fallo por fuga | Retención > 3,8 ms (0,96 fF) o 39 ms (10 fF) a 27 °C; > 10 µs y 106 µs a 85 °C. Escala inversa con la fuga real (×0,1–×10) | Ruido de disparo de la fuga y deriva |
| Fallo por interruptor | C < ~0,5 fF si existiera: Cov/C > 0,25, factor < 0,8, pedestal > 300 mV | No alcanzable con este lector: el mínimo es 0,96 fF |
| Fallo por alimentación | C > ~10 fF con rizado ≥ 1 mV sin gemelo | Correlado, no aleatorio |

El dato de proceso que decide dónde cae la frontera de fuga es la corriente inversa real de una unión n+ de 0,126 µm² y su
activación térmica: no es pública y la celda misma la mide (deriva en retención larga).

## 6. Configuraciones de layout que más información darían (todas legales)

1. **Escalera de capacidad en un mismo lector**: nodo mínimo (0,96 fF), +2, +9, +30 y +100 fF en condensador de metal (no MOS: que
   no dependa de la tensión ni de T), cada uno con su interruptor nfet mínimo. Cruza la frontera tercera/convencional y da la ley
   1/C con la corrección de Cov/C. Con modo «retener sin remuestrear» en todos (control del punto 5 de §4).
2. **Tres interruptores sobre el nodo mínimo**: nfet solo; nfet + pfet con reloj complementario (compensador); nfet 0,84 + ficticio
   0,42. Mismo C a ±0,3 fF, pedestales −154 / −101 / +120 mV: separa lo que depende del acoplo (el factor 0,9) de kT/C.
3. **Dos flancos de reloj** (inversor normal y inversor estrangulado, ~50 ps frente a ≥ 5 ns) sobre la variante nfet: el Monte Carlo
   predice la misma varianza y pedestales distintos; si la varianza cambia, el modelo de ruido está mal.
   Además, un canal con el interruptor siempre cerrado (piso del lector) y el gemelo para la alimentación, que ya estaban en el plan.

## 7. Antecedentes (qué leí)

- **Leído (texto)**: NIST SP 800-90B, §3.1 y §4.4 (DOI 10.6028/NIST.SP.800-90B).
- **Leído (texto)**: Tian, Fowler, El Gamal, «Analysis of temporal noise in CMOS APS», preimpresión de Stanford
  (https://stanford.edu/~wandell/data/papers/noise-aps-final.pdf): ½·kT/C en reinicio blando; 303 µV con 22 fF. La versión de JSSC
  36, 92 (2001), DOI 10.1109/4.896233, **no leída**.
- **Leído (texto)**: Okura et al., IISW 2019, P19 (https://imagesensors.org/Past%20Workshops/2019%20Workshop/2019%20Papers/P19.pdf):
  sensor de imagen de 2 Mpíxeles con modo de números aleatorios que lee el ruido kTC de la difusión flotante por doble muestreo
  (dos reinicios, resta) y XOR; dicen pasar la batería NIST SP 800-22. No dan entropía ni capacidad.
- **Leído por resumen automático de la página** (no el PDF de la oficina): solicitud US 2024/0126509, Analog Devices, «Random number
  generation»: dos eventos kTC sucesivos, comparados o restados para quitar offset y ruido lento; cita 2,03 mV a 1 fF y 644 µV a 10 fF.
- **No leído (fragmento de búsqueda)**: tesis de TU Delft «An On-Chip Noise Thermometer» (160 nm, 0,93 °C en 1 s); Ridgard et al.,
  arXiv 2502.16661 (ruido de resistencia en CMOS de 65 nm, 0,3–8 K; solo el resumen).
- **No encontrado** en cuatro búsquedas: un termómetro CMOS cuyo observable sea la varianza kT/C de muestreo, ni un generador con el
  muestreo sobre la puerta de un transistor en inversión débil. No encontrarlo no prueba que no exista.

Consecuencia: el generador por ruido kTC es técnica conocida (píxel y patente). Lo propio de esta celda sería la lectura por tiempo en
inversión débil y, sobre todo, el barrido de C y de interruptor en SKY130, que no vi publicado.

## 8. Abierto

- Las variantes con compensador y ficticio, y los casos a 85 °C de 3 y 10 fF con ventana larga, seguían corriendo al cerrar
  (`c58_det2.py`, `c58_det3.py`): sus líneas caerán en `c58_det2_pass2.txt` y `c58_det3_pass2.txt`. De ellos solo uso el pedestal de la
  primera pasada.
- El piso del lector (0,57 %) no se resimuló con la puerta flotante y la conversión de 330 µs.
- El ruido lento del lector está barrido sobre una estimación del README de XC-19, no simulado.
- El factor en el nodo mínimo (0,68–0,92) pide un modelo de ruido fuera del equilibrio dentro del simulador, o silicio.
- Esquina tt solamente; sin desajuste.

## 9. Archivos

`c58_PREREG.md` · `c58_det2.py`, `c58_det3.py`, `c58_det4.py` (+ `c58_det2_pass1.txt`, `c58_det3_pass2.txt`, `c58_det4.txt`, decks
`c58_d2_*`, `c58_d3_*`, `c58_d4_*`) · `c58_swdc_27.sp`, `c58_swdc_85.sp` · `c58_trn.py`, `c58_trn_resumen.txt` · `c58_mc.py`,
`c58_mc.txt`, `c58_mc2.py`, `c58_mc2.txt` · `c58_regimes.py`, `c58_regimes.txt`, `c58_mapa.png` · intentos fallidos conservados:
`c58_gen_det.py`, `c58_det_*`, `c58_trn_resumen_intento*_abortado.txt`, `c58_regimes_v1_*`.

## 10. Añadido tras el cierre (Thu Nov 12 19:40:26 EST 2026, hora de `date`): variantes de interruptor, segunda pasada (`c58_det3_pass2.txt`)

Llegaron después de entregar el informe. No cambian los veredictos; sí matizan el punto 4 de §4 y la configuración 2 de §6.

| Variante (nodo mínimo, 27 °C, 500 ps) | Nodo (1 aC →) | Conversión | Deriva del nodo retenido |
|---|---|---|---|
| nfet solo | 1,038 mV → 0,963 fF | 330 µs | −0,69 V/s (0,66 fA) |
| nfet + pfet compensador | 0,960 mV → 1,04 fF | 123 µs | **+78 V/s hacia arriba (~80 fA)** |
| nfet 0,84 + ficticio 0,42 | 0,464 mV → 2,15 fF | 41 µs | −0,46 V/s (~1 fA) |

- **El compensador pfet cuesta fuga**: el `pfet_01v8` mínimo apagado mete ~80 fA en el nodo a 27 °C, unas 120 veces la fuga del nfet solo
  y de signo contrario. En 123 µs la puerta sube ~10 mV. Si se dibuja, que sea `pfet_01v8_hvt` largo (el README de XC-19 da 0,010 pA
  para 0,42/0,50), y esa comparación (pfet mínimo frente a hvt largo) es en sí una variante informativa: cruza la frontera de fuga a
  temperatura ambiente.
- **El ficticio duplica la capacidad** (2,15 fF): ya no es «el mismo C a ±0,3 fF» como escribí en §6.2; se compara contra el escalón de
  +2 fF, no contra el nodo mínimo.
- 85 °C, 2,96 y 10 fF: conversiones de 6,7 y 4,7 µs; deriva del nodo retenido −98 y −29 V/s (290 fA, coherente).
