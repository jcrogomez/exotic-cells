# Propuesta de chip EFL-D (estado al 2026-11-04, noche). Propuesta, no decisión.

Un chip de Tiny Tapeout en sky130, flujo digital más macros pasivos, cuya carga son **precursores físicos** y cuyo propósito es
**gobernar una transformación** (dónde nace, cómo conduce, qué estados conserva), no medir el proceso ni ejecutar una función.
Pregunta: ¿qué componentes físicos podemos hacer emerger de sky130 que su biblioteca no sabe describir, y con qué control?

## Configuración candidata

1×2 (161 × 225 µm), núcleo a 1,8 V, sin pines `ua`. El tamaño se confirma con OpenLane, no con sumas. Nada de aquí se congela antes de
EFLD-00 (plataforma) y del permiso de Tiny Tapeout para estrés intencional.

## Qué lleva y por qué

### 1. Banco de formación: La Constricción (EFLD-01) — el experimento principal
- **Precursores (met1 con `rm1`, DRC limpio, extraídos):** A uniforme (control), B un cuello, C dos cuellos iguales, D dos cuellos con 20 %
  de asimetría. Cada uno con y sin toma intermedia (la toma localiza, pero altera la corriente: se mide su efecto). li1 a 0,29 µm con `rli`
  y a 0,17 µm sin capa de resistencia como segundo material. Réplicas y cantidad: las fija el presupuesto de área de EFLD-00.
- **Circuito de formación por precursor:** drivers `buf_16` en **los dos extremos** (corriente en ambos sentidos), activables por escalones
  (1, 2, 4), ruta de alimentación con ≥ 3× la corriente de formación en contactos y vías, el precursor como único tramo débil, nunca
  entre raíles. Enclavamiento por llave y máquina de estados irreversible (VIRGEN → ARMADA → FORMANDO → APAGADA → CARACTERIZADA →
  ARCHIVADA).
- **Algoritmo de formación (hipótesis a preregistrar):** escalones de corriente con lectura entre escalones y parada a R objetivo
  (electromigración realimentada); inversión del sentido como variable, no como reparación (puede redistribuir el daño, agravarlo o no
  recuperar nada: corrección externa de la noche); recocido a corriente cero con la placa caliente.
- **Qué esperamos distinguir, como hipótesis separadas:**
  | Resultado | Qué es | Cómo se reconoce | Valor |
  |---|---|---|---|
  | A | circuito abierto | el anillo RC se detiene; lectura resistencia-a-tiempo satura | fusible; fiabilidad |
  | B | resistencia programable estable | escalones de R reproducibles que se mantienen horas; región del liner de TiN | ajuste o memoria |
  | C | constricción atómica | mesetas de R antes de abrirse; **candidata** hasta I–V, temperatura y ruido en el chip analógico | física nueva en este proceso |
  | D | reconfigurable | vuelta a un estado anterior al invertir la corriente o recocer | memoria o conmutación |
  Y las preguntas de geometría: ¿B concentra la formación? ¿C la elige al azar? ¿D fija la preferencia?

### 2. Banco de uniones: La Chispa fría
- Uniones p+/n+ en nwell a d ∈ {0; 0,27; 0,54; 1,08} µm (las legales; comprobado), diodo del PDK de referencia, celda sin unión como control
  del lector. Inversa a 1,8 V. Familia de curvas tensión/temperatura, no dos puntos.
- Lectura fuga-a-tiempo (descarga por `ebufn`, liberación, umbral, contador). Hipótesis sin modelo: la abutida fuga ≥ 100× la de referencia.
- Por qué: es ruta A (nace en fabricación), no destructiva, barata, y es el dato que la rama analógica necesita antes de cualquier bomba.

### 3. Banco de estados: La Trampa
- Anillos gemelos (estresado / guardado) y, si hay macro con transistores, geometrías de interfaz propias. Objetivo distinto de caracterizar:
  ¿se obtienen **dos estados persistentes y distinguibles** por estrés, y se recuperan con control? Si solo envejece, es un límite.

### 4. Referencias
- Cuatro anillos de referencia en las esquinas (gradiente), una capacidad de referencia conocida para calibrar el lector (lo que queda
  del Parásito), estructuras vírgenes idénticas a cada precursor, y un monitor de perturbación (El Fantasma) junto a cada zona de formación.

### 5. Herramienta: El Cronista
- Mux, prescaler, dos contadores de 24 bits con desbordamiento, captura DUT/referencia simultánea, conversor tiempo-a-digital, lectura serie
  con banco, configuración, ventana y error, autodiagnóstico, llave de la Fragua. Un anillo elegido sale dividido a `uio` para contraste
  externo.
- **Dos regímenes de lectura por precursor:** retardo diferencial para ΔR pequeñas (etapa RC que domine el período; la capacidad se elige
  por observabilidad, t ≈ (R_driver + R_precursor)·C) y resistencia-a-tiempo para cambios de órdenes de magnitud hasta el abierto. No
  depende de que un anillo siga oscilando.
- Lo que no hace: identificar mecanismo. Túnel y cuantización exigen I–V, temperatura y ruido: chip analógico.

## Floorplan conceptual (sin proporciones verificadas)

```
┌──────────────────────────────────────────────────────────────┐
│ FORMACIÓN · precursores A/B/C/D (met1) y li1, con drivers en │
│ ambos extremos, Fantasma vecino y virgen gemelo por celda    │
├──────────────────────────────────────────────────────────────┤
│ CHISPA FRÍA · uniones d = 0 / 0,27 / 0,54 / 1,08 + referencia│
│ TRAMPA · anillos gemelos y geometrías de interfaz            │
├──────────────────────────────────────────────────────────────┤
│ REFERENCIAS · 4 anillos en esquinas · capacidad conocida     │
├──────────────────────────────────────────────────────────────┤
│ CRONISTA · lectura diferencial · R-a-tiempo · fuga-a-tiempo  │
│ · conteos · diagnóstico · llave                              │
└──────────────────────────────────────────────────────────────┘
```

## Compuertas antes de decidir el envío

1. **EFLD-00 (plataforma):** M1 como macro en OpenLane, drivers, anillo RC, referencia, contador mínimo; LVS y extracción limpios; lectura
   que responda a ΔR simulada desde +10 % hasta abierto; corriente por todos los contactos y la PDN.
2. **Permiso de Tiny Tapeout** para estrés intencional.
3. **Preregistro de EFLD-01** con A/B/C/D como hipótesis, controles, umbrales y criterios de muerte.
4. **Presupuesto real** de área, potencia, contactos y tiempo de banco (horas por precursor). Solo entonces, cantidad de estructuras y 1×2
   frente a otro tamaño.

## Lo que se optimiza y cómo

Observabilidad por precursor antes que física (cada cambio esperado ≥ 1 % del observable o no entra); formación una a la vez y por
escalones; referencia junto a cada DUT; vírgenes como datos censurados; más de un chip para hablar del proceso; tiempo de mesa planeado.

## Fuera de este chip

Óxido asimétrico, avalancha, fotodiodos, bomba, SPAD, y cualquier identificación de mecanismo (I–V, ruido, temperatura fina): rama
analógica (`EQUIPO.md`, `pesca/PESCA_OPTO_1104.md`). Arquitecturas con celdas estándar: biblioteca secundaria.

## Layout v0.2 (2026-11-04, noche): cómo lo dejaría y por qué

```
┌──────────────────────── 161 µm ───────────────────────────┐
│ ZONA DE FORMACIÓN (ruta B)                                │
│ fila met1:  [drvA][A][drvB]·[virgen A]·[Fantasma]         │
│             [drvA][B][drvB]·[virgen B]  …  C, D, B+toma   │
│ fila li1:   [drvA][L 0,29 rli][drvB]·[L 0,17]·[virgen]    │
│ banda de decap: reservorio local (no aísla térmicamente)  │
├───────────────────────────────────────────────────────────┤
│ CHISPA FRÍA (ruta A)        │ TRAMPA (estados)            │
│ d=0 ·0,27 ·0,54 ·1,08 ·ref  │ gemelos estresado/guardado  │
│ · sin unión; fuga-a-tiempo  │ · geometrías de interfaz    │
├───────────────────────────────────────────────────────────┤
│ REFERENCIAS: anillo en cada esquina · capacidad conocida  │
├───────────────────────────────────────────────────────────┤
│ CRONISTA: mux · prescaler · 2 contadores · RC-anillo y    │
│ R-a-tiempo · fuga-a-tiempo · llave y máquina de estados   │
│ · autodiagnóstico · ui/uo/uio                             │
└───────────────────────────────────────────────────────────┘
```

Por qué así:
- **Formación arriba, lejos del Cronista, con una banda de decap entre medias:** los `decap` son el reservorio de carga local para los
  escalones de corriente. **No** son barrera térmica (corrección externa): la separación térmica y de sustrato se decide con análisis.
- **Cada precursor es un canal completo**: driver en los dos extremos (corriente bidireccional, candidato a reconfigurable), virgen gemelo
  al lado (misma posición en el gradiente), Fantasma (un anillo sin precursor que mide perturbación por alimentación y calor).
- **Las tomas intermedias van en variantes aparte** (B con toma y B sin toma): la toma localiza y a la vez altera la corriente.
- **Chispa y Trampa en el centro**, no destructivas, con sus referencias del PDK y sus controles sin dispositivo.
- **Referencias en las esquinas**: el gradiente del dado es la explicación aburrida de cualquier Δf entre bancos.
- **Cronista abajo, junto a los pines**: la lectura tiene tres regímenes (RC-anillo para ΔR pequeñas, R-a-tiempo hasta el abierto,
  fuga-a-tiempo para uniones) y una ruta de lectura que nunca pasa por un driver de formación.
- **Lo que no se dibuja**: cantidades, capacidades y tamaño final. Los fija EFLD-00 con área colocada, no con sumas.

## Nota del 2026-11-04 (noche, síntesis externa)

- **Un dado o dos:** no se impone. La plantilla analógica de TT trae los pines digitales, así que EFLD-00 se valida en el curso digital y
  después se decide si el envío es digital (EFL-D) o híbrido (EFL01). La decisión es de capacidad instrumental, no de secuencia pedagógica.
- **Cartera (propuesta externa, adoptada como tal):** EFL01 = formación metálica, interfaces de contactos y vías, uniones laterales,
  fotodiodos, variantes de antena dentro de DRC, estados de carga. EFL02 = guías ópticas por posprocesado, memoria por ruptura de óxido,
  emisores por avalancha, nanoestructuras de túnel. Infraestructura, no bancos: osciladores convencionales, PUF, Ising, capacidades sin
  función nueva, matrices de caracterización que SkyWater hace mejor.

## Resumen ejecutivo (2026-11-04, cierre del día). Propuesta; decide Juan.

**Programa:** Exotic Foundry Lab (EFL). **Chip:** EFL01, nombre propuesto **"Yunque"** (`tt_um_jcrogomez_yunque`): la fundición entrega
la pieza, el yunque la termina. Nombre a confirmar por Juan; los nombres técnicos no cambian después.

**Qué buscamos (una frase):** gobernar qué estructura nace en sky130 fuera de su biblioteca, cómo conduce y qué estados conserva, con
precursores legales que la fundición (ruta A) o la mesa (ruta B) terminan de fabricar.

**Layout v0.3 (conceptual; base digital, franja híbrida opcional):**
```
┌─────────────────────────────────────────────┬──────────────┐
│ FORMACIÓN (ruta B)  met1 A/B/C/D ± toma,    │ FRANJA       │
│ li1 0,29/0,17 · drivers en ambos extremos · │ HÍBRIDA      │
│ virgen y Fantasma por canal · decap local   │ (opcional)   │
├─────────────────────────────────────────────┤ 2 pines ua:  │
│ GRABADO (ruta A)  antena dentro de DRC ±    │ I–V del      │
│ diodo · proximidad · orientación · esfuerzo │ precursor o  │
├──────────────────────┬──────────────────────┤ unión        │
│ UNIONES (ruta A)     │ ESTADOS (Trampa)     │ seleccionada,│
│ d = 0/0,27/0,54/1,08 │ gemelos estresado /  │ ruta aparte  │
│ · ref PDK · sin unión│ guardado · interfaz  │ de la lectura│
├──────────────────────┴──────────────────────┤ digital      │
│ REFERENCIAS: anillo por esquina · C conocida│              │
├─────────────────────────────────────────────┴──────────────┤
│ CRONISTA: RC-anillo · R-a-tiempo · fuga-a-tiempo · llave y │
│ máquina de estados · autodiagnóstico · ui/uo/uio           │
└────────────────────────────────────────────────────────────┘
```
Sin la franja es EFL-D (1×2 digital). Con la franja es el híbrido (plantilla analógica, dos tiles de alto). Se decide tras EFLD-00.

**Qué sería éxito, por niveles (y qué no lo es):**
1. **Instrumento caracterizado:** sensibilidad, piso, deriva y desbordamiento del Cronista medidos en silicio con las referencias. Sin esto
   nada de abajo cuenta.
2. **Atlas:** cada precursor con layout, netlist extraído, simulación, condiciones, datos crudos, controles y conclusión; inconclusos
   separados de negativos; vírgenes como censurados.
3. **Al menos una hipótesis discriminada:** p. ej. "el cuello concentra la formación" confirmada o refutada por encima del límite de
   detección; o "la unión abutida conduce distinto a 1,8 V" con curvas, no con dos puntos.
4. **Excepcional:** una propiedad reproducible, gobernada por geometría o polarización, con estados estables o reconfigurables y ventaja
   cuantificada frente al componente de biblioteca que hace lo mismo. Eso es una Exotic Cell candidata con contrato funcional.

No es éxito: una tabla de frecuencias sin pregunta; una línea que se abre (fusible); un Δf atribuido a cuántica; una señal en un
fotodiodo sin descartar portadores. Fallo instrumental y resultado negativo se declaran distintos.

**Compuertas, sin cambios:** EFLD-00 → permiso de Tiny Tapeout → preregistros → presupuesto real → decisión digital/híbrido y tamaño.

---

# Yunque v0.4 (2026-11-04, noche; revisión externa aplicada). v0.3 queda como historia en el commit `64695e4`.

**Lema:** el GDS define el precursor; la física determina el estado; la ingeniería convierte el resultado en una primitiva.

**Identidad:** no una Fragua metálica con experimentos secundarios, sino un **atlas de cuatro mecanismos independientes** por los que un
proceso CMOS podría ofrecer funciones nuevas, con posibilidad de cruzarlos después.

## Dos configuraciones versionadas, no una franja opcional

|  | EFLD-00 | Yunque EFL01 |
|---|---|---|
| Propósito | validar la plataforma (macro físico integrado, leído, con conectividad conservada) | descubrir dispositivos físicos |
| Flujo | digital + macro | híbrido físico/digital (plantilla analógica, que conserva los pines digitales) |
| Tamaño candidato | 1×2 | 2×2 |
| Pines analógicos | 0 | 2, con opción a 4 (Kelvin) |
| Experimentos | una Constricción y una referencia | Forge, Photon, Grabado, Junction |
| Estado | primera integración pendiente | arquitectura candidata |

La franja híbrida cambia plantilla, pinout, posiciones de acceso, instrumentación y ruteo: no se añade al final porque sobre espacio.

## Layout funcional v0.4 (2×2 híbrido; sin áreas ni posiciones validadas)

```
┌──────────────────────────────┬──────────────────────────────┐
│ A · FORGE (transformación    │ B · PHOTON (conversión       │
│ post-fabricación)            │ electroóptica)               │
│ met1 A/B/C/D ± toma · li1    │ emisor de unión en directa · │
│ · contactos e interfaces     │ carga ficticia de igual      │
│ (mcon único, cadena de vías) │ potencia · PD somero y       │
│ · formación aislada de la    │ profundo a 3 distancias ·    │
│ lectura · vírgenes           │ guardas ± · acceso ua        │
├──────────────────────────────┼──────────────────────────────┤
│ C · GRABADO (defectos de     │ D · JUNCTION (transporte)    │
│ manufactura)                 │ p+/n+ a d legales · uniones  │
│ antena factorial 2×2         │ laterales multi-terminal     │
│ (exposición × protección)    │ (inyección y recolección) ·  │
│ + control del efecto del     │ referencias PDP (diodos,     │
│ diodo · proximidad ·         │ pnp/npn) · acceso ua         │
│ orientación · Trampa reducida│                              │
├──────────────────────────────┴──────────────────────────────┤
│ CRONISTA + FORMACIÓN + AUTODIAGNÓSTICO                      │
│ lectura diferencial · integración de carga · R-a-tiempo ·   │
│ conteo temporal · monitor de perturbaciones · llave ·       │
│ referencias locales junto a cada región, no en bloque       │
└─────────────────────────────────────────────────────────────┘
```

## Controles por fenómeno (diseño causal)

- **Forge:** formación eléctricamente aislable de la lectura (los drivers no son fuentes de corriente controladas ni referencia; si
  envejecen, no se confunde con la Constricción); variantes con y sin toma; vírgenes; contactos como precursor propio (un `mcon`
  único como sitio de transformación deliberado, cadena de vías) además del metal. El decap cercano **agrava** el sobreimpulso en
  eventos rápidos: ubicación, capacidad y retornos se analizan eléctricamente.
- **Photon:** emisor real frente a carga ficticia de igual potencia; detectores iguales a distintas distancias; guardas distintas para
  modular el transporte por sustrato; referencia iluminable desde fuera si el encapsulado lo permite. Reglas `areaid.po` y deep nwell del
  PDK a comprobar en el shuttle. **Predicción escrita del agente:** en directa a 1,8–3,3 V en bulk, la señal del detector la explicará el
  transporte de portadores; el valor de la región es la plataforma de detección y el conjunto de controles, y una señal sería *candidato*
  optoelectrónico, nunca demostración. La avalancha sigue en EFL02.
- **Grabado:** factorial 2×2 (exposición geométrica efectiva baja/alta × protección sin/con diodo) con control que estime el efecto
  eléctrico del propio diodo (capacidad, fuga). Topología efectiva de capas por paso de grabado, no solo área final. "Sin daño detectable
  dentro de las reglas" es resultado previsto, no sorpresa.
- **Junction:** referencias del PDK (diodos, pnp, npn) medidas con el mismo lector; guardas contra latch-up; nada fuera de polarización
  autorizada.

## Éxito, versión v0.4

1. **Instrumentación demostrada:** variables medibles, piso conocido, fallos del Cronista descartados.
2. **Fenómeno físicamente discriminado:** una hipótesis confirmada o refutada con controles suficientes e incertidumbre cuantificada.
3. **Función gobernable:** una geometría, polarización o procedimiento produce un estado o comportamiento seleccionado, con reproducibilidad.
4. **Exotic Cell candidata a biblioteca:** interfaz definida, modelo funcional, límites de operación y ventaja demostrada en una aplicación
   concreta frente a una alternativa convencional.

Estadística: los nunca estresados son **controles vírgenes**; los estresados sin transformación en la ventana son **datos censurados**
del tiempo hasta evento. No se mezclan.

## Compuertas v0.4

EFLD-00 (integración) → piloto de lectura del fotodiodo (EFLO-00: emisor y PD legales, extracción, fuga, acceso) → auditoría del acceso
analógico (pines, protección, tensiones, fuga de interruptores) → permiso de Tiny Tapeout para la Fragua → preregistros por región →
cierre físico con la plantilla exacta. Sin porcentajes ni cantidades hasta entonces.

## Congelación de v0.4 (2026-11-04, noche, 6): no hay v0.5 sin un resultado medido

La revisión externa de la noche pidió dejar de rediseñar y exigir pruebas físicas a cada decisión. Se acepta. v0.4 queda como
arquitectura candidata; la siguiente modificación la provoca un hecho: un macro que no integra, un fotodiodo que no se puede leer, una
geometría que no pasa DRC, un límite de corriente o un presupuesto de silicio incompatible. Cuatro precisiones que no cambian la
arquitectura y sí los contratos:

- **PHOTON no es un fotodiodo.** Su pregunta sigue siendo si una unión de sky130 emite fotones que otra estructura del mismo dado
  detecta. Tres observaciones separadas: (a) respuesta del detector a luz externa (sensibilidad); (b) respuesta al emisor interno
  (acoplamiento); (c) evidencia que separe transporte óptico de difusión de portadores, acoplamiento eléctrico y calor. La predicción
  escrita del agente (ganará la difusión) no descarta el experimento: lo obliga a tener (c).
- **GRABADO documenta la topología por etapa de fabricación**, no solo el GDS final: qué metal cuelga de qué puerta en cada paso de
  grabado, con y sin diodo, porque la relación "geometría de fabricación → estado eléctrico final" es la primitiva candidata.
- **FORGE pregunta si se puede escribir un estado físico y leerlo**, no si una línea se abre. Medidas obligatorias: conductancia antes y
  después, retención, dispersión entre réplicas y posibilidad de elegir un estado objetivo. El `mcon` único como sitio de
  transformación lleva auditoría propia de corriente, disipación y fallos de alimentación, y queda separado de los contactos que
  deben sobrevivir.
- **El floorplan 2×2 sale de un esquema eléctrico y un análisis metrológico**, no de la superficie: fotodiodos, pozos, guardas,
  retornos de corriente de formación, aislamiento frente a ruido de alimentación y sustrato, acceso analógico y calibración de sus
  interruptores, referencias junto a cada precursor. Dos o cuatro pines se deciden ahí.

Secuencia: (1) cerrar EFLD-00 (macro M1, referencia, lector, LVS, extracción, respuesta a ΔR y a circuito abierto); (2) EFLO-00
(emisor candidato, fotodiodo legal, cadena de lectura, sensibilidad y fugas); (3) contratos físicos por región (estímulo, observable,
controles, hipótesis alternativa, función buscada); (4) primer floorplan 2×2 con cuenta de precursores completos.

Una sola Exotic Cell con función gobernable y reproducible ya sería éxito de Yunque; el diseño debe permitir aprender de las cuatro
regiones aunque ninguna la produzca.
