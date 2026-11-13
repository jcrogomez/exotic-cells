# Cartera de Exotic Cells · mapa trazable (abierto el 2026-11-11 20:47 EST, hora de `date`)

> **Superada.** El registro vivo de familias es el catálogo de [`../../README.md`](../../README.md#catalogue). Esta cartera queda como historia.


**Qué es.** El registro único de familias candidatas, con identificador estable. Cada familia lleva la cadena completa:

> mecanismo físico → precursor fabricable → transformación o interacción → observable → función potencial → circuito CMOS que lo
> aprovecha → experimento que lo verifica → razón para mantenerlo o descartarlo

**Reglas de este archivo.**

1. Un `XC-nn` no se reutiliza ni se borra. Una familia se **fusiona** (queda la línea, apuntando a la que la absorbe) o se
   **descarta con evidencia** (queda la línea, con la evidencia). Que una propuesta nueva no la mencione no la saca de aquí.
2. Dos motores: **F** (función buscada, se busca el mecanismo) y **P** (física poco caracterizada, se busca qué emerge). Una familia
   puede ser las dos.
3. Dos criterios de selección separados, ambos juicio del agente (latente, no medido), escala A/M/B: **U** = utilidad funcional
   esperada; **I** = ganancia de información física aunque no salga función.
4. Vehículo: **D** = flujo digital actual más macros propios, 1,8 V, sin pines analógicos. **H** = híbrido (pines `ua`, 3,3 V, layout
   analógico). **E** = especializado (dado desnudo, luz, posproceso, criogenia o alta tensión). El vehículo clasifica; no descarta.
5. Los números salen de los documentos citados. Aquí no nace ninguno.

**Esta es la lista maestra** (decisión de Juan, 2026-11-11: no se espera a la lista de 24 del chat externo, que no está en esta
máquina). Se reconstruyó de `EQUIPO.md` (versión actual y la primera, commit `280cbb9`), `PROPUESTA_CHIP.md`,
`FRONTERAS_FISICAS_1105.md`, `CATALOGO_v05_BORRADOR.md`, las pescas e `ideas/`. Son 36 líneas y crece: una idea nueva entra con el
siguiente `XC-nn`.

## Índice

| ID | Familia | Alias anteriores | Motor | Vehículo | U | I | Estado |
|---|---|---|---|---|---|---|---|
| XC-01 | Constricción de met1 (electromigración) | M1, Forge, EFLD-01 | F | D | A | A | Infraestructura verificada; transformación sin demostrar |
| XC-02 | Constricción de li1 (térmica) | M2 | F+P | D | A | A | Geometría con DRC 0; sin integrar |
| XC-03 | Contacto o vía como sitio de transformación | M3 | P | D | M | A | Hallazgo propio; sin celda |
| XC-04 | Nanogap túnel | E3 | P | H/E | M | A | Fuera del rango del lector digital |
| XC-05 | Contacto atómico, conductancia cuantizada | Ficha 2 | P | E | B | M | **Recuperada** (v0.5 la omitió) |
| XC-06 | Isla de Coulomb (SET) | E4 | P | E | B | M | No dibujable; expediente |
| XC-07 | Ruptura de óxido: antifusible, filamento | E2, óxido asimétrico | F+P | H | A | A | Espera tensión > 1,8 V |
| XC-08 | LED de filamento de silicio | E2 | F | H/E | M | A | Espera XC-07 y detector a 1,1 µm |
| XC-09 | Transistor de carga atrapada | M4 | F | H | A | M | Sin dato en sky130 |
| XC-10 | Envejecimiento BTI/HCI a 1,8 V | Fragua digital, Trampa (ruta B) | P | D | M | M | **Recuperada**; sin diseño |
| XC-11 | Compuerta flotante de un poly | E1 | F | H | A | B | Espera bomba de carga |
| XC-12 | Esfuerzo STI por longitud de difusión (LOD) | F1, G-LOD, Parásito (esfuerzo) | P | D | M | A | **Brecha del flujo confirmada hoy** |
| XC-13 | Proximidad de pozo (WPE) | F2, G-WPE | P | D | M | A | Sin modelo en la tarjeta |
| XC-14 | Antena como escritura de fábrica | F3 | F+P | D | A | A | Falta leer reglas de fábrica |
| XC-15 | Antena factorial (daño de plasma) | F4, Grabado | P | D | M | A | Contrato en v0.4 |
| XC-16 | Entorno por colocación | Los Gemelos | P | D | B | M | **Recuperada** |
| XC-17 | Electrodo y capacidad por diseño | Parásito, Pasajero del Sombrero | P | D | B | M | **Recuperada** |
| XC-18 | Transistor de óxido de campo | F8 | F | H | M | M | Umbral en sky130 `[?]` |
| XC-19 | Trampa individual (RTN) | F6, El Hambriento, EFLG-00 | F+P | D/H | A | A | Presupuesto modelado; falta la etapa |
| XC-20 | Chispa fría (p+/n+ abutida) | F5 | P | D/H | M | A | Legal (DRC); sin lectura |
| XC-21 | Unión en avalancha como emisor | La Chispa, El Relámpago | F | H/E | M | M | Espera alta tensión |
| XC-22 | SPAD | El Centinela, E5 | F | H/E | M | M | Espera alta tensión |
| XC-23 | Unión lateral multiterminal | Junction | P | H | M | A | Solo enunciada |
| XC-24 | Bipolar parásito y PNPN | F12 | F | H | M | M | Riesgo de latch-up |
| XC-25 | Placa Hall en pozo n | F10 | F | H | M | B | Instrumento, no celda |
| XC-26 | Enlace óptico interno (emisor en directa + fotodiodo) | F7, Photon, EFLO-00, ¿Vigías? | P | D/H | M | A | Detector legal, piso modelado |
| XC-27 | Nanohoyos metálicos | F11 | P | D/E | M | A | Variante por reflexión con el emisor interno de XC-26 (alta 2026-11-12); la transmisión sigue exigiendo luz sobre el dado |
| XC-28 | Guías ópticas en el dieléctrico (posproceso) | Fotónica EFL02 | F | E | M | M | Exige acceso al dado |
| XC-29 | Nanoporos reales | E6 | P | E | `[?]` | `[?]` | Solo nombrada |
| XC-30 | Coherencia mesoscópica | E6 | P | E | `[?]` | `[?]` | Solo nombrada |
| XC-31 | Calor como canal | F9, El Termómetro | F+P | D | M | M | Estimación sin verificar |
| XC-32 | Acoplamiento por la red de alimentación | Canal PDN | P | D | B | M | **Recuperada** |
| XC-33 | Metaestabilidad y entropía | El Indeciso, p-bits | F | D | A | B | **Recuperada**; arquitectura |
| XC-34 | Celdas fuera de su uso | Banco X | F | D | M | B | **Recuperada**; herramienta |
| XC-35 | Identidad del dado | PUF | F | D | M | B | En `ideas/` |
| XC-36 | Arquitecturas consumidoras | Osciladores acoplados, memoria circulante, lógica de carrera, autómata del sombrero | F | D | — | — | No son celdas: usan celdas |
| XC-37 | Retención variable | VRT | P | D | M | A | Alta 2026-11-12; reutiliza el lector de XC-19 |
| XC-38 | Fuga de drenaje inducida por puerta | GIDL | P | D | B | M | Alta 2026-11-12; débil a 1,8 V (fuente sin leer) |
| XC-39 | Resistor de poly electrotérmico | — | F+P | D | M | M | Alta 2026-11-12; oscilación improbable, deriva legible |
| XC-40 | Termopila | Seebeck | F | D | M | M | Alta 2026-11-12; exige referencia diferencial |
| XC-41 | Relajación dieléctrica | — | P | D | B | M | Alta 2026-11-12 |
| XC-42 | Transistor de pozo flotante | — | F+P | D | M | M | Alta 2026-11-12; riesgo de latch-up y precheck |
| XC-43 | Bombeo de carga | charge pumping | P | D | M | A | Alta 2026-11-12; f·q por trampa sobre el piso modelado |
| XC-44 | Estrés del encapsulado | piezorresistencia | F | D | M | M | Alta 2026-11-12; exige control de flexión externa |
| XC-45 | Temporizador por túnel de puerta | — | F+P | D | M | A | Alta 2026-11-12; τ `[?]` |
| XC-46 | Transistor de esquina del aislamiento | joroba STI, ancho estrecho | P | D | B | M | Alta 2026-11-12; más control que celda |
| XC-47 | Discontinuidades del modelo | bins, joroba gm/ID | P | D | B | A | Alta 2026-11-12; trabajo para Residual |
| XC-48 | Resistor de pozo estrangulado por su unión | — | F+P | D | M | M | Alta 2026-11-12 |
| XC-49 | Impactos de partículas en nodos dinámicos | errores blandos | P | D | B | B | Alta 2026-11-12; tasa estimada demasiado baja |
| XC-50 | Emisor por portadores calientes | — | P | D | B | M | Alta 2026-11-12; estimado bajo el piso (de memoria) |
| XC-51 | Constricción de poly | eFuse | F | D | M | M | Alta 2026-11-12 |
| XC-52 | Magnetorresistencia por pares de espín | — | P | D | M | A | Alta 2026-11-12 |
| XC-53 | Bomba de alta tensión | Dickson | F | D/H | A | B | Alta 2026-11-12; instrumento |
| XC-54 | Interconexión local superconductora | TiN | P | E | B | A | Alta 2026-11-12; absorbe XC-30 |
| XC-55 | Fonones en la pila de metales | — | P | D | M | A | Alta 2026-11-12 |
| XC-56 | Microbobina integrada | — | F | D | M | B | Alta 2026-11-12; instrumento |
| XC-57 | Unión Peltier | — | P | D | M | M | Alta 2026-11-12, del mapa del espacio |
| XC-58 | Celda kT/C | — | F | D | A | M | Alta 2026-11-12, del mapa del espacio |
| XC-59 | Escritura eléctrica, borrado térmico | — | F+P | D | M | A | Alta 2026-11-12, del mapa del espacio |
| XC-60 | Magnetodiodo | — | F+P | D | M | M | Alta 2026-11-12, del mapa del espacio |
| XC-61 | Oscilador por congelación de portadores | — | P | E | B | A | Alta 2026-11-12, del mapa del espacio |
| XC-62 | Transistor impreso por proximidad | — | P | D | M | A | Alta 2026-11-12, del mapa del espacio |
| XC-63 | Contacto sin implante | — | F+P | D/E | M | M | Alta 2026-11-12, del mapa del espacio |

**Catálogo rehecho el 2026-11-12:** los roles (celda, instrumento, fusionada, fuera) y el mapa por física viven en
`06_exotic_cells/cells/CATALOGUE.md`; esta tabla solo conserva los identificadores.

Las fichas de XC-37 a XC-56 y las fuentes de la búsqueda del 2026-11-12 viven en el repo público
(`06_exotic_cells/cells/notas/FICHAS.md` y `PESCA_2026-11-12.md`); aquí solo se referencian.

Nombres sin descripción en el repo: **los Vigías** y **la Muralla** (`EQUIPO.md` remite a `PESCA_OPTO_1104.md`, que no los define).
Probablemente detectores y anillo de guarda de XC-26 `[?]`. **El Fantasma** es un control (vecino sin dispositivo), no una familia.

## Fichas

Formato: **cadena** en una línea; después fuente, experimento y razón.

### Transformación en la mesa

**XC-01 · Constricción de met1.** Electromigración → línea de met1 con cuello (familia A/B/C/D) → corriente DC sobre régimen durante
horas → resistencia antes y después, retención, dispersión → resistencia programable, estado en la región kΩ → celda de memoria de
una escritura o peso fijo, leída por retardo → EFLD-01: formar una, leer contra gemela virgen. **Mantener:** es lo único con
infraestructura verificada (DRC 0, LVS 17/17, cada vía bajo régimen: `NIGHT_SPRINT_2026-11-05.md`). Abierto: el tiempo de formación
no tiene modelo, y hace falta permiso de estrés.

**XC-02 · Constricción de li1.** Calentamiento Joule en TiN `[?]` → línea de li1 de 0,29 o 0,17 µm → fusión o cambio de fase local →
igual que XC-01 → igual, a menor corriente → igual → integrar `efld01c_L1` en el camino de formación de EFLD-01. **Mantener:** a
igual corriente disipa ~100× más que una vía (argumento térmico del sprint), así que la línea falla antes que la infraestructura.

**XC-03 · Contacto o vía como sitio.** Fallo de interfaz → `mcon` único frente a redundantes, cadena de vías → corriente sobre
régimen → resistencia de contacto → interfaz transformable, antifusible de metal → igual que XC-01 → cadena con un solo contacto
débil declarado. **Mantener:** hallazgo propio (con 9 `mcon` el contacto se forma antes que la línea). Lleva auditoría separada de
los contactos que deben sobrevivir.

**XC-04 · Nanogap túnel.** Túnel directo entre electrodos a ~1 nm → línea rota por XC-01/02 → electromigración con realimentación →
I–V no lineal, dependencia térmica débil → unión túnel, sensor, base de XC-06 → lectura de pA → SMU por pin `ua` tras medir la fuga
del interruptor, o acceso al dado. **Mantener en H/E:** el lector digital (1–300 kΩ) lo ve abierto; la mediana publicada es ~10 GΩ
(`FRONTERAS_FISICAS_1105.md`, ficha 1). Hipótesis del repo: el liner deja un estado kΩ, no un hueco. Si XC-01 muestra salto directo
a abierto sin meseta kΩ, esta familia sube.

**XC-05 · Contacto atómico.** Transporte por pocos canales → cuello de XC-01 durante la rotura → paso por el régimen de pocos
átomos → mesetas entre 10 y 30 kΩ → patrón de resistencia, conmutador atómico → — → histogramas de cientos de ciclos reversibles.
**Mantener como expediente:** una formación irreversible por precursor no da histograma, y en aluminio los picos no prueban
cuantización (ficha 2). Lo cambiaría un precursor que cicle.

**XC-06 · Isla de Coulomb.** Bloqueo de Coulomb → isla mínima dibujable → — → escalones en I–V → electrómetro, lógica de un
electrón → — → criogenia. **Expediente:** isla mínima 22–27 aF, 3,5–4,3 K; 300 K exigiría ~22 nm, y sky130 no ofrece barrera túnel
dibujable (ficha 3). Única vía: grano accidental entre dos nanogaps de XC-04.

**XC-07 · Ruptura de óxido.** Ruptura dieléctrica → condensador MOS de óxido delgado → sobretensión con corriente limitada →
conductancia antes y después, estados intermedios → antifusible, memoria de una escritura, filamento → celda 1T con limitador →
formar con rampa y cumplimiento. **Mantener en H:** pide más de 3 V (óxido de 4,15 nm). Se puede dibujar y enviar virgen.

**XC-08 · LED de filamento.** Emisión del filamento de XC-07 → mismo precursor → formación a 6 V en la fuente → luz a ~1100 nm →
emisor subonda → enlace óptico → detector externo o XC-26. **Mantener en H/E:** la fuente usa óxido < 3 nm; sky130 tiene 4,15 nm
(`PESCA_PHOTON_1105.md`). Depende de XC-07.

**XC-09 · Transistor de carga atrapada.** Atrapamiento por portadores calientes → nfet con polarización de estrés → pulsos de
programación → ΔVth y retención → memoria sin máscara, peso analógico → celda de un transistor → programar, leer, hornear.
**Mantener en H:** precedente en otros nodos; en el óxido de sky130 `[?]`; pide 3,3 V sobre un dispositivo de 1,8 V.

**XC-10 · Envejecimiento a 1,8 V.** BTI y HCI → transistores de geometría propia en anillos gemelos → puertas retenidas horas,
conmutación máxima, placa caliente → Δf permanente y recuperación → sensor de uso, reloj de envejecimiento, versión suave de XC-09 →
par de anillos estresado/guardado → comparar antes, durante y después. **Mantener:** es la versión de XC-09 que cabe hoy en D. Si la
deriva no supera el piso del lector, es un límite y se registra.

**XC-11 · Compuerta flotante de un poly.** Inyección y túnel hacia un poly aislado → poly flotante con condensador de control →
inyección a 4,0 V, túnel a 8,0 V (fuente del catálogo) → ΔVth → memoria no volátil reprogramable → celda EEPROM → programar y
borrar. **Mantener en H:** necesita bomba de carga. Función conocida: valor por estar abierta, no por novedad.

### Lo que la fabricación provoca

**XC-12 · LOD.** Esfuerzo mecánico del STI → transistor con longitud de difusión elegida → ninguna, lo fija la litografía → Vth y
corriente → umbral por layout sin máscara, y validación del extractor → pares con desplazamiento deliberado, referencia → matriz de
transistores anchos, 0,30 frente a 3,0 µm. **Mantener, prioridad 1.** Corrida de hoy (`macros/grabado_lod/LEEME.md`): el modelo del
PDK predice 31,1 mV (W = 0,42) y 44,1 mV (W = 5); Magic no emite `sa/sb` y el flujo simula ambos iguales; una pareja ancha por nivel
da 6 σ según el modelo de desajuste. Define el primer módulo de Residual. Límite honesto: es programación por layout, no después de
fabricar; su valor es metrológico antes que funcional.

**XC-13 · WPE.** Dopado extra junto al borde del pozo → transistor a distancia variable del pozo → ninguna → Vth → umbral por
distancia → igual que XC-12 → matriz cruzada con XC-12, variando cada una por separado. **Mantener:** la tarjeta local no trae
parámetros de pozo, así que cualquier efecto medido es dato nuevo para el PDK. Eso justifica medir; no promete física nueva.

**XC-14 · Antena como escritura.** Carga de plasma sobre una puerta flotante → puerta colgada de metal sin camino de descarga →
el grabado la carga → Vth al nacer → celda que nace escrita, identidad de fábrica → ROM sin máscara → pares con y sin diodo.
**Mantener, con compuerta:** falta leer las reglas de fabricación; que el precheck no revise antena no autoriza. Abierto: si los
pasos térmicos la borran `[?]`.

**XC-15 · Antena factorial.** Daño de plasma en el óxido → factorial 2×2 (exposición × protección) dentro de las reglas → el
grabado → ΔVth, trampas creadas → parámetro fijado por geometría de fabricación → — → factorial con control del efecto eléctrico del
diodo. **Mantener:** contrato escrito en v0.4. Señal esperada del orden del desajuste, así que el presupuesto de XC-12 se aplica.
"Sin daño dentro de las reglas" es un resultado previsto.

**XC-16 · Entorno por colocación.** Vecindad, orientación, densidad, distancia a taps → la misma celda estándar con entorno fijado
por placement → ninguna → Δf entre anillos intercalados → corrección de modelo por entorno → — → 8 variantes × 4 réplicas.
**Mantener:** es la versión de XC-12/13 que no necesita macro. Con el resultado de hoy tiene predicción: los `sa/sb` reales de cada
celda.

**XC-17 · Electrodo por diseño.** Capacidad parásita → placas en met2–met4 como carga de anillos, patrón del sombrero, espejo y
control periódico → ninguna → Δf (lector ≈ 2 %/fF, piso 0,4 fF) → capacidad definida por geometría → carga calibrada → tres
patrones con el mismo presupuesto de metal. **Mantener, baja prioridad:** lo mata que met5 y el relleno dominen. Aquí vive lo que
queda del sombrero en esta cartera.

**XC-18 · Transistor de óxido de campo.** Canal parásito bajo el STI → poly o metal sobre óxido de campo entre dos difusiones →
radiación o carga → Vth del parásito → dosímetro, sensor de carga → lectura por corriente → medir umbral. **Mantener en H:** precedente
publicado en 0,6 µm; umbral en sky130 `[?]`, quizá sobre 3,3 V.

### Defecto individual

**XC-19 · Trampa (RTN).** Captura y emisión en un defecto → nfet mínimo 0,42/0,15 → ninguna, o XC-10 para crear trampas → dos
niveles con residencias exponenciales → bit probabilístico, sensor de una carga → etapa cuya corriente fija un solo MOS en inversión
débil, leída en diferencial → histograma bimodal > 5 σ, residencias que cambian con polarización y temperatura. **Mantener,
prioridad 1.** ΔVth = 0,305 mV; un anillo estándar cambia 6·10⁻⁶ y es ciego; la etapa en inversión débil daría ~0,8 % por salto
(`EFLG00_TRAMPA.md`). Falta simular esa etapa y decidir su polarización. Estadístico: N dispositivos `[?]`.

### Uniones y transporte

**XC-20 · Chispa fría.** Túnel banda a banda → p+ y n+ abutidos o a separación creciente dentro de un pozo n → ninguna → fuga a
1,8 V frente a temperatura → diodo de baja tensión, fuente de ruido, referencia → celda fuga-a-tiempo → cuatro separaciones más
celda sin unión, a dos temperaturas. **Mantener:** geometrías legales ya dibujadas (`macros/chispa/`); el diodo del PDK no modela
túnel. Lo mata que la fuga quede bajo la del transistor de precarga.

**XC-21 · Avalancha como emisor.** Ruptura en inversa → la geometría de XC-20 → polarización a VBR → luz 400–900 nm → emisor → enlace
con XC-22 o XC-26 → emisor frente a carga ficticia. **Mantener en H/E:** VBR ajustable por separación en 65 nm (Dutta 2017, en la
pesca); bv ≈ 12 V aquí; pide bomba y auditoría de alta tensión.

**XC-22 · SPAD.** Avalancha Geiger → unión con guarda → polarización sobre ruptura → cuentas oscuras, eficiencia → detector de un
fotón → extinción y contador → tasa oscura frente a tensión. **Mantener en H/E:** misma dependencia que XC-21.

**XC-23 · Unión lateral multiterminal.** Difusión de minoritarios → inyector y colectores a varias distancias → polarización → corriente
recolectada frente a distancia y guarda → sensor de portadores, transistor lateral, magnetotransporte → — → inyección y recolección
con referencias del PDK. **Mantener en H:** es además el control obligatorio de XC-26 (portadores antes que fotones).

**XC-24 · Bipolar parásito y PNPN.** Realimentación del tiristor parásito → p+/pozo n/sustrato/n+ con separación elegida → disparo →
histéresis, resistencia diferencial negativa → oscilador de relajación, neurona → un condensador → curva I–V con corriente limitada.
**Mantener en H:** riesgo para el shuttle; aislamiento obligatorio, y los bipolares del PDK solo valen en activa directa.

**XC-25 · Hall en pozo n.** Efecto Hall → placa de pozo de cuatro terminales → campo externo → tensión Hall → sensor magnético →
corriente rotatoria → imán calibrado. **Mantener en H como instrumento:** sensor publicado en 180 nm, sin estado ni formación (ficha
4). Da µ_H del pozo, que no tenemos.

### Óptica

**XC-26 · Enlace óptico interno.** Recombinación radiativa en una unión en directa → emisor p+/pozo n y fotodiodo legal 3×3 µm a 5,
10 y 20 µm, control a 40 µm, guarda → ninguna → fotocorriente por precarga y descarga → aislamiento óptico, sensor → integrador de
carga del lector → emisor frente a carga ficticia de igual potencia, guarda conectada y desconectada. **Mantener:** seis celdas con
DRC 0 y piso modelado de 150 fA (`macros/photon/`). Predicción escrita: gana la difusión de portadores. El valor seguro es el
instrumento de corrientes pequeñas, que sirve a XC-20 y XC-23.

**XC-27 · Nanohoyos.** Transmisión por aperturas subonda → red de hoyos en met1 (periódica, desordenada, aperiódica) sobre un
fotodiodo → luz externa → fotocorriente frente a placa sólida y sin metal → filtro óptico por layout → píxel con color → tres redes
y dos controles. **Mantener en E:** paso mínimo 0,28 µm → pico ~0,41 µm (cálculo, ficha 5); el encapsulado tapa la luz y el relleno
tapa la red. Familia de motor P por excelencia: se conserva aunque no haya función a la vista. Sin método de medida no ocupa silicio.

**XC-28 · Guías en el dieléctrico.** Guiado en el BEOL → precursor dieléctrico → posproceso → transmisión → distribución óptica →
— → acceso al dado. **Mantener en E:** precedente en 180 nm verificado parcialmente (`PESCA_OPTO_1104.md` §4b).

**XC-29 · Nanoporos reales** y **XC-30 · Coherencia mesoscópica.** Solo nombradas (texto externo del 2026-11-08, que no está en el
repo). Cadena `[?]`. **Mantener como línea abierta** hasta tener el texto.

### Acoplamiento entre celdas

**XC-31 · Calor como canal.** Autocalentamiento y difusión térmica → calefactor de conmutación y sensores a distancia → ninguna →
Δf en el tiempo (ms) → perilla de temperatura en chip, acoplamiento sin cable → calefactor + sensor → calefactor con salida
desconectada como control. **Mantener:** es también la perilla que XC-19 necesita para las residencias. Estimación previa sin
verificar.

**XC-32 · Acoplamiento por alimentación.** Caída de la red → mismo montaje que XC-31 → ninguna → Δf instantáneo (ns) → canal
lateral, sincronización → — → separar por escala de tiempo de XC-31. **Mantener:** es la explicación aburrida que todo experimento
de acoplamiento debe descartar.

### Digital puro y consumidores

**XC-33 · Metaestabilidad y entropía.** Resolución de un biestable → sincronizadores con dato y reloj coincidentes → ninguna → tasa
de fallos, entropía → generador aleatorio → — → mismo par con dato estable. **Mantener como referencia convencional:** es contra lo
que XC-19 debe ganar.

**XC-34 · Celdas fuera de su uso.** `dlygate` como vernier, `ebufn` en contienda, inversor como amplificador → celdas de biblioteca →
ninguna → resolución en ps → instrumento → lector → retardo conocido. **Mantener como herramienta:** candidata a etapa de lectura de
XC-12 y XC-19.

**XC-35 · Identidad del dado.** Desajuste → pares de anillos → ninguna → bits estables por chip → identidad → — → varios chips.
**Mantener:** XC-14 es su versión exótica.

**XC-36 · Arquitecturas consumidoras.** No son celdas. Se conservan para responder "qué circuito CMOS aprovecha esto".

## Clasificación por vehículo

- **Probables hoy en D (15):** XC-01, 02, 03, 10, 12, 13, 14, 15, 16, 17, 19 (con macro de inversión débil), 20, 26 (lectura por
  precarga), 31, 32. Más las digitales puras XC-33, 34, 35.
- **Piden H (11):** XC-04, 07, 08, 09, 11, 18, 21, 22, 23, 24, 25.
- **Piden E (6):** XC-05, 06, 27, 28, 29, 30.

## Cola de ejecución (lo siguiente, en orden)

1. **Residual, módulo 1:** anotador de `sa/sb/sd` desde el layout. Caso de prueba listo: `macros/grabado_lod/`, 31,1 mV esperados.
2. **XC-19:** simular la etapa en inversión débil con el modelo del PDK y la fuente RTS nativa de ngspice; fijar polarización.
3. **XC-12, celda de medida:** cómo convierte el lector digital 44 mV de umbral en tiempo; preregistro en `docs/preregistros/`.
4. **XC-16 con predicción:** calcular los `sa/sb` reales de las celdas estándar usadas en los anillos.
5. **XC-14/15:** leer las reglas de antena de fabricación y la secuencia de capas.
