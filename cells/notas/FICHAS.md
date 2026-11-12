# Notas por familia (exploratorias)

Notas de trabajo en español de las 36 familias de [`../CATALOGUE.md`](../CATALOGUE.md), con el mismo `XC-nn`. Abiertas el
2026-11-11.

**Cómo leerlas.**

- Son **exploratorias**. Salvo donde se cita una corrida de este repositorio, nada aquí está medido ni simulado por nosotros.
- Cada ficha da la cadena: mecanismo físico → precursor fabricable → transformación o interacción → observable → función potencial
  → circuito CMOS que lo aprovecha → experimento que lo verifica. Después, la razón para mantenerla y lo que sigue abierto.
- Grados de una afirmación: **corrida** (reproducible en `experiments/`), **fuente** (publicación o PDK leídos), **cálculo**
  (a mano, con sus supuestos), **hipótesis**. Lo desconocido va como `[?]`.
- Las rutas entre comillas que no existen en este repositorio (por ejemplo `FRONTERAS_FISICAS_1105.md`, `macros/photon/`)
  son notas del laboratorio de trabajo, todavía no publicadas. Los números que dependen de ellas cuentan aquí como **cálculo** o
  **fuente sin adjuntar** hasta que se publiquen.
- Ninguna familia se borra. Se fusiona o se descarta con evidencia, y la línea queda.
- Un preregistro es otra cosa: vive en [`../preregistros/`](../preregistros/README.md), fechado antes de correr.

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
transistores anchos, 0,30 frente a 3,0 µm. **Mantener, prioridad 1.** Corrida del 2026-11-11 (`experiments/lod_audit/`): el modelo del
PDK predice 31,1 mV (W = 0,42) y 44,1 mV (W = 5); Magic no emite `sa/sb` y el flujo simula ambos iguales; una pareja ancha por nivel
da 6 σ según el modelo de desajuste. El primer módulo de Residual ya recupera esa diferencia desde el layout (`residual/`). Límite honesto: es programación por layout, no después de
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

