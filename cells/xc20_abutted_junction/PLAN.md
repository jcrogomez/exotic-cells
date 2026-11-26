# XC-20 · Chispa fría

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-20 de [catálogo](../../README.md#catalogue) (Abutted p+/n+ junction).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-20 · Chispa fría.** Túnel banda a banda → p+ y n+ abutidos o a separación creciente dentro de un pozo n → ninguna → fuga a
1,8 V frente a temperatura → diodo de baja tensión, fuente de ruido, referencia → celda fuga-a-tiempo → cuatro separaciones más
celda sin unión, a dos temperaturas. **Mantener:** geometrías legales ya dibujadas (`macros/chispa/`); el diodo del PDK no modela
túnel. Lo mata que la fuga quede bajo la del transistor de precarga.

**Replanteo del 2026-11-12 (primeros principios; cálculo con constantes de memoria, sin simular).** Esta familia es la caza de
una unión túnel de silicio. Con 10²⁰ cm⁻³ a cada lado y unión abrupta, la zona de vaciamiento mide ~5 nm y el campo ~4 MV/cm; con
10¹⁹, ~17 nm y ~1,3 MV/cm. Con el exponente de Kane (~3·10⁷ V/cm para silicio) la probabilidad de túnel cambia unos seis o siete
órdenes entre los dos casos: es un umbral, y el dopado real en la frontera no es público. **Tres regiones:** diodo ordinario
(dopado bajo o frontera difusa); unión túnel con conducción inversa anómala y, si las dos caras son degeneradas, resistencia
negativa a 0,1–0,3 V en directa; corto si algo puentea la frontera. **Observables nuevos:** un par de uniones en serie como
biestable (se queda en dos estados o no: lectura digital de un efecto cuántico a temperatura ambiente); un oscilador que solo
arranca si hay resistencia negativa; la dependencia débil con la temperatura, que separa túnel de difusión. **Configuraciones
nuevas:** solape negativo de los implantes (fuera de regla, en simulación); frontera definida por una puerta (un transistor con
fuente p+ y drenaje n+: transistor túnel; borde legal por buscar). Absorbe XC-38.

**[corregido 2026-11-12 13:06] Ronda de ataque 1** ([resumen](../../experiments/RONDA_1_2026-11-12.md)): la aritmética se sostiene (verificado: 5,6–5,9 nm y 16–17 nm). Entre 10¹⁹ y 10²⁰ el túnel cambia entre cinco y nueve órdenes. Hay un segundo umbral, entre 2 y 4·10¹⁹, bajo el cual no hay pico en directa. Sobrevive el túnel inverso a separación 0, enviable (el precheck acepta la unión pegada). La resistencia negativa es una apuesta estrecha y la excursión del par (0,1–0,3 V cerca de masa) no la lee un inversor (un agente). Configuración nueva: par en espejo como sensor de alineación entre las máscaras n+ y p+.

**[corregido 2026-11-12 19:10] Ronda de ataque 2** ([resumen](../../experiments/RONDA_2_2026-11-12.md)): túnel inverso a separación 0: entre decenas de nA y decenas de µA a 1,8 V por 1,4 µm de frontera (verificado en orden; intervalo real más ancho). Una medida publicada en 65 nm da ~21 µA/µm a ≈2 V, derivado de sus figuras: respalda el orden, no calibra. La resistencia negativa queda **abierta**: la frontera va de ≲3 a ≲20 nm/década según el pico, y el perfil de SKY130 no es público. Identificar el túnel pide directa, inversa y temperatura juntas (difusión, generación-recombinación y túnel asistido por trampas coexisten). De un agente: 16 formas de unión pegada pasan el DRC; contraste ≥ 7·10³ contra la separación de 0,27 µm; par en espejo como medidor de desalineación; lectura del biestable con comparador de par pfet.

**[corregido 2026-11-13 11:23] Revisión externa (auditoría del commit 3967d9c)** El siliciuro sobre la frontera p+/n+ pasa a ser la **primera compuerta**, antes de refinar el modelo de túnel. Según la revisión externa, Dutta et al. 2017 (DOI 10.1109/LED.2017.2701505) bloquearon el siliciuro sobre la región activa, salvo en los contactos, para no cortocircuitar la unión, y atribuyen el túnel a separaciones de 60 nm o menos por la débil dependencia con la temperatura (evidencia indirecta). **Sin leer por nosotros**: el texto no se pudo abrir el 2026-11-13 (IEEE vacío, UTwente 403). Lo que sí tenemos: difusión n+ y p+ con 120 y 197 Ω/□ (`sky130A.tech` l. 5106–5107, PDK local), valores de capa sin siliciuro; la inferencia "siliciuro solo al fondo de los contactos" sigue siendo conjetura. Falta: un corte transversal de máscaras y materiales del precursor (bloqueo de siliciuro, contactos, región activa) y, en silicio, la dependencia con la temperatura en d = 0 como prueba de unión frente a resistencia. Ver `experiments/REVISION_EXTERNA_2026-11-13.md`.

**[corregido 2026-11-13 21:48]** Matriz de capacidades ([`docs/CAPACIDADES_SKY130.md`](../../docs/CAPACIDADES_SKY130.md)): ninguna fuente de SkyWater dice si la difusión lleva siliciuro; no existe capa de bloqueo; las resistencias de capa documentadas (n+ 120, p+ 197 Ω/□) son de silicio sin siliciuro. Que d = 0 sea una unión y no un cable es **inferido**, no leído: la compuerta sigue `[?]` hasta que Tiny Tapeout responda o se mida. Con el siliciuro fuera, la explicación aburrida pasa a ser la resistencia en serie (~1 kΩ, unos 20 mV a 20 µA, aritmética). Medida barata propuesta: tiras Kelvin de n+, p+, poly y li junto a XC-20. Dutta 2017 es CMOS bulk de 65 nm (ficha indexada), sin leer.

**[corregido 2026-11-16 09:10]** Siliciuro: un colaborador de Tiny Tapeout (2026-11-16) cree que SKY130 no está siliciurado. Afirmación de tercero, sin documento; coincide con lo inferido de las resistencias de capa. La primera compuerta queda muy probablemente abierta: en d = 0 habría una unión real. La explicación aburrida principal pasa a ser la resistencia en serie (~1 kΩ). Las tiras Kelvin siguen en el chip como comprobación en silicio. Registro: [`docs/OPEN_QUESTIONS.md`](../../docs/OPEN_QUESTIONS.md) A1.

**[corregido 2026-11-14 20:19]** Prototipo del motor de hipótesis ([informe](../../experiments/xc20_hipotesis/INFORME.md), verificado por código independiente; modelo, no silicio): con el lector de precarga de XC-26 tal cual (techo calculado 1,25 nA) el primer canal de §5.2 no distingue túnel de puente óhmico: los dos saturan. Con un lector de nA a mA acierta el 90 %, y una segunda tensión inversa (−0,9 V) separa los tres mecanismos mejor que la temperatura (+0,22 frente a +0,08 bits); el peine no añade nada. Esto se deduce ya de los intervalos; el motor da el tamaño y que el orden resiste los supuestos. Propuesta, pendiente de Juan: lector de rango ancho y dos tensiones antes que dos temperaturas.

**[corregido 2026-11-15 18:10]** Ronda 2 del motor ([informe](../../experiments/xc20_hipotesis_mixto/INFORME.md); verificada con
otro estimador; modelo, no silicio), con túnel y puente a la vez, puente no lineal, excitador con límite y ganancia común. Leer
d = 0,27 con un lector sensible y d = 0 con uno de rango ancho (un lector por estructura) gana a cualquier lector único en todo lo
modelado: el túnel residual a 0,27 µm, si la supresión es ≤ 10⁹, cae en el rango del lector de XC-26 y hace de d = 0,27 el mejor
detector de túnel, no solo el control térmico. Con ganancia común, la segunda temperatura casi empata con la segunda tensión. La
incógnita que decide es cuánto se suprime el túnel a 0,27 µm (solo hay «≥ 7·10³»). Propuesta, pendiente de Juan.

## 2. Lectura y piso

Lector de precarga y descarga (el instrumento de XC-26): la unión en inversa a 1,8 V mueve un nodo y se cuenta el tiempo.
Los números del lector son del laboratorio de trabajo (`macros/photon/LEEME.md`), **sin publicar**, y son modelo, no silicio.

| Cantidad | Valor | De dónde |
|---|---|---|
| Piso del lector | ≈ 150 fA a 27 °C con 2²⁰ ciclos a 10 MHz; nodo de 12,4 fF | laboratorio, sin publicar, **corrida** (modelo) |
| Fuga del excitador de precarga (`ebufn_1` en Z) | 32 fA a 27 °C; 0,41 pA a 85 °C | idem, gmin 1e-18 |
| Fondo a 27 °C | No cruza: el nodo se estanca en 1,36 V porque el pmos de precarga lo recarga | idem |
| Precarga alternativa | 5,3 pA con pfet mínimo; 0,010 pA con canal largo y umbral alto | `docs/CLAIMS.md`, **corrida** exploratoria |
| Señal: fuga de la unión abutida a 1,8 V | `[?]`. Hipótesis sin modelo: ≥ 100 veces el diodo del PDK | `macros/chispa/LEEME.md`, laboratorio |
| Fuga del diodo p+/pozo n del PDK, mismo tamaño | `[?]`: falta extraerlo (el `pdiff` de `legal.tcl` no sale como diodo) | — |

Señal/piso: `[?]`. Si la hipótesis de 100 veces no se cumple, la fuga puede quedar bajo la del transistor de precarga, que es
lo que la ficha nombra como muerte. A 85 °C el piso no lo pone el contador sino la deriva del fondo térmico (≈ 0,1 pA si deriva
1 %, hipótesis del laboratorio).

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| El siliciuro puentea p+ y n+ en d = 0: cortocircuito óhmico, no unión (**de memoria**, sin verificar) | La celda de 0,27 µm no puede estar puenteada; en d = 0, la temperatura distingue unión de resistencia |
| Fuga de la unión pozo n/sustrato, que tiene mucha más área que la unión dibujada | Leer por el lado p+ (nodo que sube con el pozo fijo a 1,8 V), no por el pozo; celda sin unión con el mismo pozo |
| Fuga del propio transistor de precarga y del inversor | Canal fantasma: el mismo lector sin dispositivo colgado |
| Generación-recombinación térmica ordinaria en la zona de carga | Temperatura: el túnel banda a banda depende poco de ella; la generación térmica, mucho. Familia de curvas, no dos puntos |
| Fuga de superficie o de perímetro (borde del STI) | Variantes de igual área y distinto perímetro; variante con la frontera p+/n+ lejos del borde del campo |
| Desalineación de los implantes: d = 0 dibujado no es d = 0 fabricado | Réplicas en las dos orientaciones y en espejo (p+ a la izquierda y a la derecha) |

## 4. Referencia convencional (control científico, no filtro)

El diodo p+/pozo n del PDK (`sky130_fd_pr__diode_pd2nw_05v5`) y, como fuente de corriente pequeña, un transistor en inversión
débil (el de XC-19). Como fuente de ruido, el jitter de un anillo (XC-33). La unión abutida solo gana si da una corriente a
1,8 V mayor que la del diodo del PDK y con menor dependencia de la temperatura que un transistor en subumbral: eso sería una
referencia. Si la fuga es la del diodo del PDK, gana el diodo del PDK.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (laboratorio, sin publicar): `legal.tcl` demuestra que p+/n+ en pozo n es legal en d = 0 y desde 0,27 µm, en Magic y en
   el deck de fabricación de KLayout. Repetido aquí con `residual/drc_edge` (sonda `pn_space`): mismo resultado, **corrida**.
2. Hecho (laboratorio): cuatro celdas dibujadas, `chispa_d000`, `d013` (ilegal, sirve de control del DRC), `d027` y `d050`.
3. Hecho en parte (2026-11-26, [MISFIT-14](../../experiments/misfit14/RESULTADOS.md)): la variante en sustrato (n+ `ndiode` contra toma p+) se dibuja desde una tabla con `generator/matrix.py`, sale limpia y el LVS cuenta el diodo. Pendiente la variante en pozo n con `pdiode`.
4. Pendiente: averiguar si el proceso tiene bloqueo de siliciuro sobre difusión y qué pasa con el siliciuro en d = 0 `[?]`.
   Es lo primero: decide si d = 0 es una unión o un puente.
5. Pendiente: pasar el deck completo de KLayout con el front-end activo (hasta hoy solo el de fabricación).
6. Hecho (2026-11-26, [MISFIT-15](../../experiments/misfit15/RESULTADOS.md), **corrida**, modelo): el `pd2nw` de 1,4 µm² a 1,8 V en inversa da 2,5 fA a tt 27, 1,8 aA a ff −40 y 4,4 pA a 85 °C; el `pw2nd`, 4,7 fA, 2,0 aA y 2,5 pA. Ojo: el área de un diodo extraído entra sin escalar en ngspice; hay que reescribirla.
7. Hecho en parte (MISFIT-15): con el interruptor entre X y la isla la unión ve 0,9–1,65 V según su corriente; con el interruptor abajo ve la tensión de X. **La variante en pozo n pasa a ser la principal.** Pendiente: simular el canal de lectura por el lado p+ con la precarga de canal largo; predicción escrita antes. El modelo
   no contiene túnel: la simulación solo fija el fondo y el rango del lector, no la señal.
8. Pendiente: leer Dutta 2017 (ya leído entero en el laboratorio) buscando solo la corriente en inversa por debajo de la ruptura.

### 5.2 Configuraciones a dibujar

Geometría base del laboratorio: pozo n de 4 × 3 µm, p+ de 1,0 × 1,4 µm, n+ de 1,0 × 1,4 µm. Valores de barrido: **propuesta**.

| Barrido | Valores | Pregunta |
|---|---|---|
| Separación d entre p+ y n+ | 0; 0,27; 0,54; 1,08 µm (lo intermedio es ilegal) | ¿La fuga cae de golpe al abrir d, como pide el túnel, o apenas cambia? |
| Largo de la frontera abutida a área constante | 1,4; 2,8; 5,6 µm | Si la corriente es de la frontera p+/n+, escala con su largo, no con el área |
| Área a frontera constante | p+ de 1,0; 2,0; 4,0 µm de fondo | Separa la componente de área (el diodo ordinario) de la de frontera |
| Frontera al borde del campo o dentro de la difusión | Frontera que toca el STI y frontera rodeada de difusión | Fuga de esquina del STI frente a fuga de la unión plana |
| Orientación y espejo | 0° y 90°; p+ a un lado y al otro | Desalineación de implantes: el d real difiere del dibujado con signo según el lado |
| Polaridad | p+/n+ en pozo n; n+/p+ en sustrato (borde legal por buscar) | Dopado de fondo distinto: otra anchura de la zona de carga |
| Número de contactos | 1 y 3 por lado | El contacto no debe limitar; comprueba la regla «contacto antes que unión» |
| Celda sin unión | Mismo pozo y contactos, sin p+ | Fondo del pozo y del lector |

Primero un canal completo con d = 0, d = 0,27 y la celda sin unión; la matriz después.

**[corregido 2026-11-16 08:59]** Decisión de Juan tras la ronda 3 del motor (modelo, no silicio; ronda no consolidada): se
dibujan d = 0, 0,27, 0,54, 1,08 µm y la celda sin unión. 0,54 es el control prioritario de fuga convencional y fondo; 1,08, la
referencia lejana para ver si la fuga sigue cayendo o llega a un fondo; la celda sin unión es obligatoria. No se congela el
macro. Aporte de cada una: [`xc20_hipotesis_r3/INFORME.md` §7](../../experiments/xc20_hipotesis_r3/INFORME.md).

### 5.3 En silicio

1. **Virgen:** tiempos de todos los canales, incluidos fantasma y celda sin unión, a temperatura ambiente.
2. **Calibrar:** corriente de prueba conocida en el nodo (resistencia de poly alta contra una tensión, o un condensador
   conmutado) para convertir tiempo en corriente; sin esto solo hay cocientes.
3. **Caracterizar:** fuga frente a d, a largo de frontera y a área.
4. **Barrer:** temperatura en varios puntos (placa caliente y el calefactor de XC-31), alimentación entre el mínimo que deje
   funcionar al lector y 1,8 V. La pendiente con la temperatura clasifica el mecanismo.
5. **Retener y repetir:** el mismo canal otro día. Series largas para ver si la fuga tiene saltos telegráficos (liga con XC-37).
6. **Clasificar** cada variante: cortocircuito, fuga con firma de túnel, fuga ordinaria de diodo, bajo el piso, fallo de lector.

No hay transformación. La misma geometría llevada a ruptura es XC-21 y pide otro vehículo.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** la fuga en d = 0 supera a la de d = 0,27 y a la del diodo del PDK por un factor declarado en el prerregistro,
  escala con el largo de la frontera y depende de la temperatura menos que la celda de 0,27.
- **Negativo informativo:** todas las separaciones dan la fuga del diodo ordinario y el lector, calibrado, la resuelve.
- **Inconcluso:** fuga bajo el fondo del lector, o d = 0 se comporta como una resistencia (siliciuro) y no hay más variantes.
- **Fallo instrumental:** la corriente de calibración no se ve, o el fantasma descarga igual que los dispositivos.
- **Muere** si en toda la matriz la fuga queda bajo la del transistor de precarga (criterio de la ficha).

## 6. Documentación para graduarse

- [ ] Prerregistro con predicción numérica y criterio de abandono
- [ ] Generador de layout por script, parametrizado
- [ ] DRC limpio en Magic (reglas completas) y en KLayout (deck completo, comprobaciones de front-end activas)
- [ ] Extracción y LVS dispositivo a dispositivo
- [ ] Netlist anotado con Residual
- [ ] Simulación contra la predicción, con su control
- [ ] Macro: pines en metal, LEF con obstrucciones, alimentación
- [ ] Datos de silicio, crudos y con su control
- [ ] Contrato: modelo, interfaz, límites, variabilidad, retención, modos de fallo, condiciones de formación
- [ ] Referencia convencional, donde ayude a identificar el mecanismo
- [ ] README en inglés

## 7. Compuertas y dependencias

- Vehículo D: cabe en el flujo digital a 1,8 V. Sin permisos de estrés; nada se transforma.
- Depende del lector de corrientes pequeñas de XC-26; si ese lector no baja de su fondo, esta familia no se lee.
- Sirve a XC-21 y XC-22 (misma geometría, a ruptura) y a XC-26 (emisor alternativo en directa).
- Canales de control: XC-31 (temperatura) y XC-32 (alimentación).
- Un chip basta para el barrido de d; la dispersión entre dados queda `[?]`.

## 8. Abierto y fuentes

- ¿Hay siliciuro sobre la frontera p+/n+ en d = 0? `[?]` Sin respuesta, d = 0 puede ser un cable.
- Perfil real de los implantes en d = 0: el DRC no lo dice (`macros/chispa/LEEME.md`).
- Fuga inversa del diodo del PDK a 1,8 V: `[?]` hasta extraer y simular.
- Las celdas dibujadas son d = 0; 0,13; 0,27; 0,50; el texto del laboratorio propone 0; 0,27; 0,54; 1,08. Se toma lo segundo.
- Fuentes: `macros/chispa/LEEME.md` y `docs/pesca/PESCA_OPTO_1104.md` §3 (laboratorio, sin publicar);
  [`residual/drc_edge`](../../residual/drc_edge/README.md); [`docs/CLAIMS.md`](../../docs/CLAIMS.md).
- **Comprobación de citas del 2026-11-12** ([`docs/READING.md`](../../docs/READING.md)): no se encontró ningún diodo túnel medido en un flujo CMOS estándar con implantes de fuente y drenaje; los publicados usan epitaxia, dopado delta o difusión rápida. O nadie lo ha hecho, o la frontera lateral sale demasiado difusa: la simulación de perfil (E1.2) es la que distingue. El artículo de Dutta 2017 no es de túnel sino de emisores en avalancha: va con XC-21.
