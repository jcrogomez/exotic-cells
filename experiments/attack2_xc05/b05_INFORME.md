# b05 — Informe del ataque de materiales a XC-05 (ronda 2)

Cierre: Thu Nov 12 17:32 EST 2026 (hora de `date`). Prerregistro: `b05_PREREG.md` (13:30, antes de la literatura y de correr).
**Nada es silicio: todo es modelo, cálculo y lectura.** La sesión se interrumpió entre las 14:17 y las 17:31 por el límite de uso; las
corridas de ngspice terminaron solas a las 15:17 y se analizaron al volver.

Grados: **PDK** (ruta y línea; PDK local `local_flow/pdk_host/ciel/sky130/versions/8afc8346…/sky130A`), **corrida** (script),
**leído-directo** (un agente de búsqueda abrió el PDF), **leído-resumen** (abrió la página o el resumen, pero el texto le llegó por
el resumidor de la herramienta: citas no cotejadas), **no leído** (fragmento), **memoria**, **cálculo**. Yo no abrí ninguna fuente
personalmente: toda la literatura es "leída por agente".

## 0. Veredicto en una línea (por escenarios)

"El contacto atómico muere en met1" se sustituye por: **los tres sistemas tienen fronteras distintas y el parámetro que las ordena es
la temperatura pico del sitio, no la densidad de corriente.** met1 tiene una tercera región documentada (vacío puenteado por la
barrera: resistencia que sube por pasos de ohmios) pero estrecha a corriente alta; el li es el único que cruza las dos fronteras a
1,8 V con geometría enviable, y solo si el tramo es corto (≤ 2 µm); el contacto sobre poly es el punto caliente más barato y cae en
un fenómeno con antecedente (recorte de poly por pulsos). **El transporte de pocos canales no tiene antecedente en ninguno de los
tres** y no hay mecanismo conocido que lo produzca de forma controlada; lo que sí queda es que **se puede leer sin destruirlo**: el
lector de baja tensión cumple < 52 mV en todos los transitorios simulados salvo uno, que se arregla frenando un flanco.

## 1. Resultado contra cada predicción

| # | Predicción | Resultado | |
|---|---|---|---|
| P1a | Ti/AlCu/TiW: 60–400 Ω/µm, nominal ~130 | 84–357, nominal 129 (`b05_1_met1.txt`) | cumplida |
| P1b | Ti/TiN/AlCu/Ti/TiN: 30–250, nominal ~70 | 34–381, nominal 81 | cumplida en nominal; **fallada arriba** (381 con TiN de 400 µΩ·cm y Ti consumido) |
| P1c | Vacío 10/100/1000 nm: ~1/10/100 Ω | 1,3/12,9/129 (A) y 0,8/8,1/81 (B) | cumplida |
| P1d | Puente a 2,06 mA: < 20 K hasta 100 nm; 100–400 K a 1 µm | nominal 9–18 K y 117–210 K; extremos 4–112 K y 39–896 K | cumplida en nominal |
| P1e | A 18,5 mA aguanta ≲ 30–50 nm | 24–39 nm bajo 681 K (nominal); 8–97 nm en todo el barrido | cumplida |
| P1f | Subida gradual documentada; nada sobre grieta no óhmica | Documentada (ver §2.1); nada sobre no óhmico | cumplida |
| P2a | li: G' 2–3,5 W/m·K; τ63 0,1–0,5 µs | 1,91–2,66; 0,21–0,30 µs | cumplida (G' roza por abajo) |
| P2b | li largo a 2,06 mA: 80–200 K | 129–184 K | cumplida |
| P2c | Cuello 0,17 × 1 µm: 30–100 K | 86–162 K | **fallada** (los tramos anchos de li enfrían menos de lo que supuse) |
| P2d | ΔT = 1000 K a 5–8 mA; con 8 no se rompe | ~5–6 mA; con 8 `ebufn_4` 359–483 K | cumplida |
| P2e | TiN > 10⁷ A/cm²; falla por calor; sin nanohueco por electromigración | Ver §2.2. Lo de "calefactores de cambio de fase" no lo sostiene lo leído; el número viene de otra fuente | cumplida en el fondo, **fallada en la fuente que anuncié** |
| P3a | 0,04 / 0,65 / 0,79 mW | 0,04 / 0,64 / 0,78 mW | cumplida |
| P3b | < 5 / 5–30 / 100–400 K | 3–4 / 14–20 / 82–247 K | cumplida (poly algo por debajo) |
| P3c | W no migra; vacío en el Al; poly se recorta a la baja | Los tres, leídos. "Corto de unión" **no encontrado** | cumplida salvo el corto |
| P4 | Ventana 100 Ω–1 MΩ = 0,3–1,0 nm de abertura | 0,24–1,30 nm; ancho de la ventana 0,38–0,80 nm | cumplida |
| P5a | ≤ 55 mV en continua; picos < 10 mV con 100 fF | 48,7 mV; cambio de rango con flanco crudo: 72 mV con 50 fF, **118 mV sin condensador** | continua cumplida; **picos fallada** |
| P5b | Arranque < 5 mV con rampa ≥ 1 µs; puede fallar con ≤ 10 ns | −0,5 mV a 1 µs; a 10 ns: +52 / −46 mV (no pasa de 100) | cumplida; el fallo temido no ocurrió |
| P5c | 100 Ω → abierto: monótono, sin rebase | 0,02 → 48,74 mV, máximo = valor final | cumplida |
| P5d | El anillo no cumple | 191 mV sobre 12,9 kΩ con 100 kΩ en serie; 896 mV sobre 1 MΩ con 1 MΩ | cumplida |
| P5e | ≤ 5 % en R con tres rangos | 3,0–4,2 % de 1 kΩ a 1 MΩ; **12,6 % a 100 Ω** y 5,7 % a 300 Ω | **fallada bajo 1 kΩ** (por conversión única) |
| P6 | Valor, saltos y temperatura sí; no linealidad y ruido de disparo no | §6 | cumplida (es cálculo) |

## 2. Los tres sistemas, con las cinco columnas

### 2.1 met1 (los dos apilamientos)

| Dato del PDK | Evidencia leída | Parámetro supuesto | Simulación | Conclusión física |
|---|---|---|---|---|
| 0,14 µm mín (tlef l. 107); 0,125 Ω/□ (tech l. 5123); `tc1rm1` 3,179·10⁻³; a 1,376 µm del silicio (l. 5058) | TiW 50–80 µΩ·cm (página divulgativa, leído-resumen). Ti reacciona con Al a TiAl₃ a ~430 °C (Besser, MRS 355, 631, leído-resumen). Con capa redundante "the resistance changed very rapidly once initiated, and tended to saturate" (US6448173, leído-resumen). Fallo de TiN y TiW: no electromigración sino proceso activado, E_a ≈ 1,5 eV; 10 años si el TiN queda bajo ~408 °C, ~2,4·10⁷ A/cm² (Tao, Cheung, Hu, IEEE TED 43, 1819, 1996, leído-resumen) | ρ de TiN 50–400 y de Ti 40–200 µΩ·cm (**no leídas**: la de Ti no apareció); si el Ti sobrevive o se consumió; k de la barrera por Wiedemann-Franz; TCR de la barrera = el del li | R' 84–357 Ω/µm (A) y 34–381 (B). A 18,5 mA el puente pasa de 681 K con un vacío de 24–39 nm (nominal). A 2,06 mA no llega a 681 K ni con 3 µm (nominal) | La barrera puentea el vacío en los dos apilamientos. Lo que la mata es su propia temperatura |

Estados finales:
- **(a) Vacío puenteado estable.** Es el estado genérico y está documentado. ΔR = 0,8–3,8 Ω por cada 10 nm de vacío. Es estable
  mientras el puente no pase de ~680 K: a 18,5 mA eso limita a ΔR ≲ 3–5 Ω (nominal); a 4,1 mA a ~290–570 nm (37–46 Ω); a 2,06 mA no
  hay límite en el nominal. **Función:** resistencia programable de una sola dirección, analógica, con paso de ~1 Ω. Tao et al.
  mencionan oscilación de resistencia y "damage healing" en TiN/Al/TiN: si invertir la corriente rellena el vacío sería memoria
  reescribible; **conjetura**, no se leyó en qué condiciones.
- **(b) Barrera rota = abierto.** A 18,5 mA, vacío > 24–107 nm en el nominal y 8–282 nm en todo el barrido (según qué temperatura la rompe: 681, 933 o 1941 K). Con 2,06 mA solo
  en el escenario de barrera más resistiva (vacío > 230–440 nm).
- **(c) Intermedio no óhmico.** Sin antecedente (buscado, no encontrado). Por cálculo, una grieta que cruce la barrera cae en la
  ventana de lectura solo con 0,24–1,3 nm de abertura (`b05_4_tunel.txt`); la contracción térmica de un tramo de 30–300 nm que
  estuvo 400–1600 K más caliente da 0,1–4 nm: mismo orden, sin control. No se puede afirmar ni negar.

Cómo se distingue (a) de una resistencia normal: el coeficiente térmico de la línea baja de 3,18·10⁻³ a 1,8·10⁻³ /K con ΔR = 10 Ω y
a 0,8·10⁻³ con 100 Ω (cálculo; supone el TCR de la barrera). Una resistencia de aluminio más larga no hace eso.

**Corrección a la ronda 1:** su "lazo que salva la barrera" tiene que ver +3–5 Ω × 18,5 mA ≈ 55–90 mV, no los 0,2–2,8 V que decía.
Un inversor no lo ve.

Qué dato decide entre escenarios: (i) cuál de los dos apilamientos lleva SKY130; (ii) ρ real de las barreras; (iii) si a 2–4 mA el
aluminio migra en tiempo útil (sigue sin calibrar; no lo repito).

### 2.2 Interconexión local (TiN)

| Dato del PDK | Evidencia leída | Parámetro supuesto | Simulación | Conclusión física |
|---|---|---|---|---|
| 12,8 Ω/□ (tech l. 5122; ngspice `rl1` = 12,2); 0,10 µm a 0,936 µm del silicio (l. 5056); 0,17 mín (tlef l. 71); `tc1rl1` 6,045·10⁻⁴, `tc2rl1` −3,693·10⁻⁷ | Calefactor de TiN sobre membrana: falla a 5·10⁵ A/cm² y ~720 °C por rotura mecánica de la membrana, no por electromigración; TCR 1,4·10⁻³ /°C en TiN denso; "TiN should work up to 800 °C"; no calentar sobre 200 °C con oxígeno (Creemer 2008, **leído-directo**). En una celda simulada, lo que falla es el SiO₂ vecino al llegar a ~1900 K (Yin 2006, leído-directo; es simulación). Tira de TiN rota eléctricamente sobre SiO₂: conmutación con escritura +4 V, borrado +7 V, lectura +1 V, en vacío; el efecto es del SiO₂, no del electrodo (Yao 2009, arXiv 0906.5100, leído-resumen) | k del TiN 5,7–30 W/m·K; k del óxido 1,0–1,4; validez de `tc1/tc2` fuera de su rango | G' 1,9–2,7 W/m·K; τ63 0,21–0,30 µs. Con 8 `ebufn_4`: 359–483 K. 1073 K a 4,0–5,7 mA; 1900 K a 6,3–11,3 mA | El TiN no migra: se calienta. A 1,2·10⁷ A/cm² y < 500 K está en régimen convencional |

Hallazgo de esta sección (**corrida**, `b05_2_li.txt`): **la tensión manda.** Una línea de li de 5 o 10 µm no pasa de 437–929 K por
muchos drivers que se pongan (64 dan lo mismo que 32: se agota 1,8 V). Un tramo de 2 µm o un cuello de 0,17 × 0,34–1,0 µm entre
tramos de 0,51 µm sí llega: 1073 K con 16–30 `ebufn_4` y 1900 K con 25–45.

Ruta a pocos canales o nanohueco: **no encontrada** en la literatura (ni constricción, ni contacto atómico, ni hueco electromigrado
de TiN). Lo que hay es otra cosa: si el li se rompe dentro del óxido, el hueco resultante es el dispositivo de Yao (filamento en
SiOx). Pide 4–7 V, que no hay en el dominio de 1,8 V. A favor: enterrado está sellado (Yao necesitaba vacío). Es memoria, no
transporte de pocos canales.

Lo que no se sabe y decide: temperatura a la que el TiN reacciona con el SiO₂ que lo rodea (no encontrado) y si antes de romperse
cambia de resistividad de forma estable (un fragmento no leído dice que el primer calentamiento la baja de modo irreversible).

### 2.3 Contactos

| Dato del PDK | Evidencia leída | Parámetro supuesto | Simulación / cálculo | Conclusión física |
|---|---|---|---|---|
| mcon 9,3 Ω; licon a poly 152 Ω, a n+ 185 Ω, a p+ 585 Ω (tech l. 5126–5134); 0,17 × 0,17 (tlef l. 89); régimen del mcon 0,36 mA (tlef l. 96) | "there is no electromigration in tungsten at temperatures less than approximately 1800 °C"; el fallo es un vacío en el Al junto al tapón; con capas refractarias sube ~20 % en vez de abrir (Zhao 2009, J. Semicond. 30, 056001, **leído-directo**; proceso de 0,5 µm). En descarga electrostática Ti y W migran por un filamento de silicio fundido (Walker 2003, leído-resumen). Recorte de poly por pulsos: R baja, umbral = superar la temperatura máxima de fabricación, reversible en parte en tipo n (Feldbaumer 1995, leído-resumen). Memoria en contacto: exige una capa TiN/TiON/SiO₂ de 9 nm puesta a propósito (Kao 2018, leído-resumen) | Resistencias térmicas: 1,7–2,6·10⁴ K/W sobre difusión, 1,3–3,9·10⁵ sobre poly, 0,8–1,1·10⁵ en mcon (fórmulas de esparcimiento y de aleta; k de memoria) | A 2,06 mA: 7,1·10⁶ A/cm² (1,7× la línea de met1). ΔT: mcon 3–4 K, n+ 14–20 K, p+ 39–58 K, poly 82–247 K | El contacto sobre poly disipa 0,64 mW en un disco: ~100× lo que una línea de met1 con la misma corriente |

Estados: **mcon** → el mismo vacío puenteado de §2.1, localizado junto al tapón (pasos de resistencia; un fragmento no leído
habla de "step like degradation"). **licon sobre difusión** → con los drivers disponibles no pasa de ~320 K de subida ni con 72:
convencional; el corto de unión no se alcanza y tampoco lo encontré descrito. **licon sobre poly** → 1100 K o más con 32 drivers
(modelo grueso): entra en el régimen de recorte de poly. Es una resistencia programable multinivel con antecedente; no es de pocos
canales.

Sin hacer: no simulé el contacto en 3D ni con sus modelos de ngspice; las resistencias térmicas son de fórmula.

## 3. Tabla comparativa (escenarios, no veredictos)

Corrientes para llegar al inicio de la transformación en el escenario más favorable y en el menos favorable de cada barrido.

| | met1 0,14 µm | li 0,17 µm, tramo ≤ 2 µm | Contacto (mcon / licon-poly) | Poly bajo el licon |
|---|---|---|---|---|
| Inicio de la transformación | Migración del Al: sin calibrar. Por calor (ΔT 100 K): ~16 mA (ronda 1) | 673 K: 2,8–5,4 mA. 1073 K: 4,0–7,5 mA | mcon: ~18 mA para 260–350 K. licon-poly: ~3,5–6 mA para ~1000 K (cálculo desde R_th) | El mismo sitio que el licon-poly |
| ¿Con 1,8 V y `ebufn_4`? | Sí con ~72 drivers | Sí con 16–45, solo en tramos cortos | Sí con 16–32 (poly); 72 (mcon) | Sí |
| Mecanismo | Electromigración del Al; después, calor en la barrera | Calor; reacción con el óxido `[?]` | Vacío en el Al junto al W; fusión local del poly | Fusión de fronteras de grano, segregación de dopante |
| Estados finales | +1–50 Ω puenteado; abierto; grieta `[?]` | Cambio de ρ `[?]`; rotura con hueco en óxido dañado | Pasos de resistencia; abierto | R más baja, por niveles |
| Resistencia de esos estados | 10–60 Ω (línea de 10 µm); o > GΩ | 75 Ω/µm ± `[?]`; o > GΩ; con formación a 4–7 V, kΩ–MΩ (Yao) | 9–30 Ω (mcon); 100–200 Ω (poly) | decenas de % menos |
| Estable a 300 K | Sí el puente (Tao: 10 años bajo 408 °C). El contacto de Al de un átomo, no | Sí lo cerámico; el filamento en SiOx sí, sellado | Sí | Sí, con recuperación de 1–2 % (no leído) |
| ¿En la ventana 100 Ω–1 MΩ? | **No**: 10–60 Ω, hace falta un lector de ohmios | Sí si el tramo mide ≥ 1,5 µm | Poly sí; mcon no | Sí |
| ¿Pocos canales? | Solo si barrera y Al se interrumpen a < 1,3 nm: sin antecedente | Sin antecedente | Sin antecedente | No |

## 4. Mapa de tres regiones

Parámetro: temperatura pico del sitio, T = 300 K + I²R'/G' (línea) o I²R·R_th (contacto). Segundo parámetro, solo para el después:
tensión sobre lo que quede.

| Sistema | Convencional | Tercera región candidata | Fallo |
|---|---|---|---|
| met1 | Puente o línea < ~680 K | Vacío puenteado con ΔR ≤ el que mantiene el puente bajo ~680–930 K | Puente > 930–1940 K: abierto |
| li | < ~680 K (8 `ebufn_4`: 360–480 K) | 680–1100 K `[?]`: deriva de ρ. Rota y con 4–7 V: filamento en SiOx | > 1100–1900 K: rotura, óxido fundido |
| licon-poly | Bajo la temperatura máxima de fabricación `[?]` | Entre esa y la fusión del silicio: recorte | Poly fundido, abierto |

Geometrías enviables que cruzan las fronteras (todas legales según `precheck_map`): cuello de li a 0,17; línea de met1 a 0,14;
contacto aislado. El mando no es la geometría sublitográfica sino **el número de drivers (8 → 64) y el largo del tramo**.

## 5. Lector de baja tensión (hecho en ngspice)

`b05_5_gen.py` → `b05_5_sp/*.sp` y `*.log`; resumen en `b05_5_post.txt`; figura `b05_5_transitorios.png`. ngspice 44.2 en Docker,
modelos tt a 27 °C del PDK de la imagen (open_pdks 8afc8346, el mismo commit que el local; el local montado tardaba > 5 min por
mazo). Esquemático: sin parásitos de layout salvo 5 fF puestos a mano en el nodo.

**Circuito.** Riel de 48 mV hecho con un divisor de poly `res_high_po` (l = 56 y l = 0,5 µm). Del riel al nodo A, tres caminos: uno
permanente de ~300 kΩ (`res_xhigh_po`), uno de ~10 kΩ con interruptor nfet, y uno directo con un nfet de 5 µm. El dispositivo va de
A a masa. Se lee con un nfet de 0,42/0,15 cuya **fuente** es A y cuya puerta es el nodo de polarización de XC-19; descarga un nodo
precargado y un `inv_1` marca el cruce. Como la tensión en vacío del riel es 48 mV, el dispositivo no puede ver más en continua,
valga lo que valga. Consumo: 1,1 mA para 39 canales en la corrida de continua (~28 µA por canal).

| Caso | Peor V sobre el dispositivo | |
|---|---|---|
| Continua, 30 Ω a abierto, tres rangos | 48,7 mV | cumple |
| Arranque y apagado, rampa de VDD ≥ 100 ns | +48,7 / −5,9 mV | cumple |
| Arranque con rampa de 10 ns, selectores siguiendo a VDD | +52,1 / −46,4 mV sin condensador; −4,8 mV con 50 fF | cumple 100 mV; roza 50 |
| Dispositivo 100 Ω → abierto en 1 ns (y al revés), tres rangos | sube monótono a 48,7 mV; sin rebase | cumple |
| Cambio de rango, flanco de puerta de 1 ns | **+118 / −57 mV** sin condensador; +72 mV con 50 fF | **no cumple** |
| Cambio de rango, flanco frenado (1 MΩ × 200 fF) | 51,5 mV | cumple |
| Conversión del lector (precarga y descarga) | retroceso < 0,8 mV | cumple |
| Escalón de ±0,2 V en VDD en 1 ns | 55,5 mV (sigue al riel) | cumple 100; no 50 |

Candidatos descartados por corrida: **fuente de corriente de 50 nA en inversión débil sin limitar**: 5 µV sobre 100 Ω (ilegible) y
al abrirse el dispositivo pasa de 50 mV en 5 ns y acaba en 1,8 V. **Anillo con resistencia serie**: 191 mV sobre 12,9 kΩ con
100 kΩ; 1,6 V sobre 1 MΩ; solo cumple con 1 MΩ en serie y dispositivo ≤ 12,9 kΩ (23 mV).

**Resolución** (con el 0,55 % de ruido por conversión de `xc19_noise`, **supuesto** que vale igual leyendo por la fuente): 3,0–4,2 %
en R de 1 kΩ a 1 MΩ por conversión única; 5,7 % a 300 Ω y 12,6 % a 100 Ω. Conversión de 1,3–2,9 µs. El paso de 1 a 2 cuantos son 17 σ
por conversión; de 1 a 0,8, 8 σ; de 10 a 11, 3 σ. La sensibilidad medida es un e-pliegue cada 64 mV de media (más floja cerca
de 0 V), no los ~26 mV que esperaba: no lo investigué.

Límites: sin layout ni parásitos extraídos; sin esquinas ni temperatura; sin desajuste; el condensador de 50 fF y el RC de puerta son
ideales; la corriente de lectura (~2 nA) sube A 0,6 mV con el dispositivo abierto.

## 6. Qué medidas distinguirían pocos canales, y cuáles caben en este lector

| Medida | Qué diría | ¿Con este lector? |
|---|---|---|
| Valor en reposo | R > 12,9 kΩ en un puente metálico no puede ser un contacto metálico limpio (menos de un canal): es túnel u óxido. Solo acota | Sí, 3–4 % |
| Histograma de conductancia | Picos en múltiplos o medios del cuanto sobre muchos sucesos (Li 2015, leído-resumen: 100 ciclos en HfO₂; lecturas a 0,07–0,1 V). Con formación irreversible sale de muchas réplicas, no de ciclos. En aluminio los picos no son enteros (ronda 1) | Sí en resolución; depende de tener réplicas |
| Saltos discretos en el tiempo | Reordenamientos atómicos: dos o más niveles separados por fracciones del cuanto. Una resistencia difusiva no salta | **Sí**: conversión de ~µs, saltos de 25–50 % a 8–17 σ. Es la medida más fuerte disponible |
| No linealidad a baja tensión | Túnel: término cúbico de 0,01–0,9 % a 50 mV (`b05_4_tunel.txt`); metálico: ~0 | **No**: está bajo el piso y el límite de tensión la impide por diseño |
| Dependencia con temperatura | Balístico y túnel: casi plana. Barrera de TiN: +0,6·10⁻³ /K; Al: +3,2·10⁻³ /K; óxido con trampas: activada | Sí, con un calefactor de poly vecino o barriendo la mesa; 3 % de resolución pide ΔT ≳ 50 K para ver el TCR del TiN |
| Ruido de disparo | Factor de Fano por canal | No |

Lo que ninguna separa con este lector: un contacto de pocos canales de un óxido de titanio conductor del mismo valor. En los
sistemas con TiN ese confusor no se quita sin la curva I-V.

## 7. Veredicto por sub-afirmación

1. **Barrera de met1 como función:** SOBREVIVE como resistencia programable de ohmios (estado documentado); **no cae en la ventana
   del lector** y pide otro instrumento. Como camino a pocos canales: sin antecedente; vive solo en el escenario "grieta < 1,3 nm".
2. **li:** TRANSFORMADA. No hay ruta conocida a pocos canales. Es el mejor sitio para cruzar fronteras a 1,8 V (tramo corto, 16–45
   drivers) y su estado roto tiene un antecedente de memoria en SiOx que pide más tensión.
3. **Contactos:** el mcon repite a met1; el licon sobre difusión se queda en convencional con estos drivers; el licon sobre poly
   SOBREVIVE como sitio de recorte de poly.
4. **Lectura de baja tensión:** SOBREVIVE. Se puede mantener ≤ 52 mV en todo salvo el cambio de rango con flanco rápido.
5. **"Pocos canales" como afirmación:** ni muere ni vive. No hay física que lo prohíba ni fuente que lo muestre en estos
   materiales; lo único nuevo es que ahora hay con qué mirarlo sin romperlo.

## 8. Configuraciones de layout que más información darían

1. **Cuello de li de 0,17 × 0,34 y × 1,0 µm entre tramos de 0,51 µm, con 8/16/32/64 `ebufn_4` seleccionables y el lector de §5.**
   Único sistema que cruza las dos fronteras a 1,8 V. Gemelo sin drivers.
2. **Un licon solo sobre una tira de poly (0,27 y 0,5 µm de ancho), mismos drivers; control con cuatro licon en paralelo.** Separa
   lo que hace el contacto de lo que hace el poly.
3. **Línea de met1 de 0,14 × 10 µm con tapones de W en los extremos, ~72 drivers, y lector de ohmios** (rango bajo de §5 con el
   riel más rígido). Responde qué apilamiento hay por el Ω/nm del primer paso y por el cambio de TCR.

## 9. Sin hacer

- No abrí ninguna fuente yo mismo; varias citas son de resumen automático y están marcadas.
- Resistividad de Ti en película delgada, de TiAl₃ y de TiN de 25–50 nm: no encontradas. Corriente de fusión de un contacto de W
  aislado y corto de unión: no encontrados.
- Contactos: solo fórmulas, sin simulación 2D/3D.
- Lector: sin esquinas, temperatura, desajuste, parásitos ni layout; el rango bajo no llega al 5 % bajo 1 kΩ.
- Térmica con propiedades constantes: las temperaturas por encima de ~1500 K de las tablas solo significan "destruido".
- No se recalibró el tiempo de electromigración del aluminio (era la crítica a la ronda 1): sigue sin dato.

## 10. Archivos

`b05_PREREG.md`, `b05_lib.py`, `b05_1_met1.py/.txt`, `b05_2_li.py/.txt`, `b05_3_contactos.py/.txt`, `b05_4_tunel.py/.txt`,
`b05_5_gen.py`, `b05_5_post.py/.txt`, `b05_5_plot.py`, `b05_5_transitorios.png`, `b05_5_sp/` (mazos, registros y trazas),
`b05_5_lector.txt`. Primera versión del lector (divisor a 137 mV por las cabezas del resistor corto): `b05_5_v1_*`.
