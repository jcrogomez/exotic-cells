# XC-34 · Celdas fuera de su uso

**Instrumento o control (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-34 de [catálogo](../../README.md#catalogue) (Cells outside their intended use).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-34 · Celdas fuera de su uso.** `dlygate` como vernier, `ebufn` en contienda, inversor como amplificador → celdas de biblioteca →
ninguna → resolución en ps → instrumento → lector → retardo conocido. **Mantener como herramienta:** candidata a etapa de lectura de
XC-12 y XC-19.

## 2. Lectura y piso

Es una herramienta: celdas de biblioteca usadas para lo que no fueron caracterizadas. Varias ya se usan así en el laboratorio; este
plan las convierte en instrumentos con contrato. Cada uso tiene su observable.

| Uso fuera de catálogo | Qué hace | Número conocido | De dónde y grado |
|---|---|---|---|
| `ebufn_1` en alta impedancia como interruptor de precarga | Suelta un nodo flotante | Fuga 32 fA (27 °C), 0,41 pA (85 °C) | `macros/photon`, laboratorio, **sin publicar**, modelo |
| `inv_1` como comparador de umbral | Convierte la descarga en un flanco | Umbral 0,791 V (27 °C), 0,811 V (85 °C) | mismo |
| `ebufn_8` / `ebufn_4` en contienda o contra una línea | Fuente de corriente, calefactor, formación | 0,51 mA y 0,26 mA por driver | `local_flow/efld_00`, `efld_01`, sin publicar, ngspice |
| 32 entradas de celda como condensador | La C de un anillo RC | `[?]` fF | `local_flow/efld_00` |
| `dfrbp_1` en cascada de rizo | Divisor en el dominio del anillo | /256 | mismo |
| `dlygate4sd1/2/3`, `dlymetal6s2s/4s/6s`, `clkdlybuf4s15…50` como vernier | Retardo → código | Paso `[?]` ps; retardos sin simular | nombres comprobados en el **PDK** local |
| Inversor realimentado como amplificador | Ganancia alrededor del umbral | `[?]` | — |

- **Piso del vernier:** lo fija el desajuste entre celdas nominalmente iguales, no el paso. Referencia de escala: los anillos
  cambian de 2,5 a 5,1 % solo por anotar el largo de difusión (`experiments/stdcell_lod`, **corrida**), y σ de umbral es 17,3 mV en
  un transistor mínimo (`experiments/lod_audit`, **corrida**). El desajuste de retardo por celda es `[?]`.
- **Contra qué se mide:** el contador con reloj resuelve un periodo; el Cronista, del orden de 10⁻⁵ con 2²⁰ ciclos a 10 MHz
  (`EFLG00_TRAMPA.md`, laboratorio, sin publicar), pero promediando. El vernier solo aporta si mide un único suceso.
- **Señal que tendría que ver:** un salto de 0,80 % sobre 29,2 µs (`cells/xc19_channel`) son unos 230 ns (**cálculo**): eso
  ya lo cuenta un reloj. Para XC-19 el vernier no hace falta hoy; sí para retardos de anillo de XC-12, de cientos de ps.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| La resolución medida es la cuantización del contador o el jitter del reloj | El control de la ficha, retardo conocido: la misma señal por las dos ramas debe dar código cero; la anchura de su histograma es el piso |
| El código refleja desajuste entre ramas, no el retardo de entrada | Intercambiar las ramas; N celdas idénticas insertadas deben dar código lineal en N |
| El paso depende de alimentación y temperatura más que la señal | Calibración en línea: un anillo de las mismas celdas da el retardo por celda en ese momento |
| La contienda calienta o tira del raíl y eso es lo que se lee | Canales XC-31 y XC-32; ficticio que conmuta sin contienda |
| La síntesis cambió o fusionó las celdas | `keep`, y recuento en el netlist final (EFLD-00: 16 `ebufn_8`, 8 `dfrbp_1`, 88 `inv_1` sobrevivieron) |

## 4. Referencia convencional (control científico, no filtro)

| Uso | Componente convencional | Qué tendría que mostrar |
|---|---|---|
| Vernier | Contador con el reloj del sistema; anillo más contador | Resolver un suceso único por debajo de un retardo de puerta, estable en T y VDD |
| Fuente de corriente o calefactor por contienda | Resistor de poly del PDK (`res_high_po`, 300 Ω/□, **leído por agente**) | Misma potencia sin macro propio, y conmutable |
| Interruptor de precarga | pfet largo de umbral alto dibujado: 0,010 pA frente a 5,3 pA del mínimo (`experiments/xc19_weak_inversion`, **corrida**) | Fuga comparable sin dibujar transistores; el `ebufn_1` del modelo ya da 32 fA |
| Condensador de entradas | MiM del PDK (2 fF/µm², **leído por agente**, usa metales altos) o MOS dibujado | Linealidad suficiente y valor conocido |
| Amplificador | Diseño analógico en otro vehículo | Ganancia útil sin polarización externa |

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (laboratorio): fuga del `ebufn_1`, umbral del `inv_1`, corriente de `ebufn_8`/`ebufn_4`, supervivencia a la síntesis.
2. Hecho: las celdas de la biblioteca están extraídas y anotadas (`experiments/stdcell_lod`, 415 de 437); las de retardo deben estar
   entre ellas. Pendiente: comprobarlo en `devices.csv` y leer su geometría (qué hace lenta a una `dlygate`).
3. Pendiente: simular el retardo de cada celda de retardo, extraída y anotada, y la diferencia entre parejas: ese es el paso.
   Predicción escrita antes.
4. Pendiente: Monte Carlo de desajuste de ese paso. Criterio de la idea original (`ideas/README.md`, laboratorio): la mata un
   desapareamiento mayor que el paso.
5. Pendiente: corriente de contienda de `ebufn_1/2/4/8` contra sí mismos y contra `einvp`/`einvn`, en cinco esquinas.
6. Pendiente: capacidad de entrada por celda desde la extracción, para que el condensador de 32 cargas deje de ser `[?]`.
7. Pendiente: inversor con realimentación por un triestado en conducción: ganancia y punto de reposo en simulación.

### 5.2 Configuraciones a dibujar

Son celdas de biblioteca: se barre qué celda, cuántas, dónde y con qué orientación. Todo es **propuesta**.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Pareja del vernier | `dlygate4sd1`/`sd2`, `sd2`/`sd3`, `dlymetal6s2s`/`dlymetal6s4s`, `clkdlybuf4s15`/`s18` | ¿Qué pareja da el paso más fino que el desajuste aún deja resolver? |
| Longitud de la cadena | 8, 16, 32, 64 etapas | Rango frente a error acumulado: ¿el error crece como √N (desajuste) o como N (sistemático)? |
| Colocación de las dos ramas | Entrelazadas en la misma fila, filas contiguas, separadas 50 µm | Cuánto del error es gradiente y cuánto local |
| Orientación | Ramas iguales frente a espejadas | Efecto de la orientación de la celda sobre el retardo (liga con XC-16) |
| Vecindad de difusión | Celda entre vecinas frente a celda junto a hueco o tap | ¿El entorno cambia el retardo de una celda idéntica? (liga con XC-12 y XC-13) |
| Tamaño en contienda | `ebufn_1`, `_2`, `_4`, `_8` contra su igual | ¿La corriente escala con el número de dedos? Da la escalera de potencia de XC-31 |
| Amplificador | `inv_1`, `inv_2`, inversor de tres etapas, con y sin realimentación | Ganancia frente a estabilidad |
| Condensador de entradas | 8, 32, 128 entradas; de `inv_1` frente a `nand2_1` | Linealidad con el número y dependencia con la tensión |

Primero un canal completo: un vernier de una pareja con su retardo conocido conmutables y su anillo de calibración.

### 5.3 En silicio

1. **Virgen:** código del vernier con la misma señal por las dos ramas; frecuencia del anillo de calibración.
2. **Calibrar:** insertar 0, 1, 2… celdas idénticas en una rama; recta de código frente a N. El retardo por celda sale del anillo.
3. **Caracterizar:** histograma del código a retardo fijo (piso); no linealidad a lo largo de la cadena.
4. **Barrer y repetir:** alimentación y temperatura (deriva del paso y del cero); otro día; intercambio de ramas.
5. **Clasificar** cada herramienta: sirve con contrato (paso, rango, deriva), sirve solo calibrada en línea, no mejora al contador,
   fallo.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** código lineal con el retardo insertado, histograma más estrecho que un paso, y paso menor que un retardo de puerta.
- **Negativo informativo:** el histograma a retardo fijo abarca varios pasos, o la recta no es monótona: el desajuste domina.
  Se informa el desajuste de retardo por celda, que es un dato que la biblioteca no da.
- **Inconcluso:** lineal pero con deriva en alimentación mayor que la señal que tendría que medir.
- **Fallo instrumental:** la síntesis alteró la cadena o el control de ramas iguales no da cero.
- **Muere el vernier** si no mejora al contador con reloj para ninguna familia. Las demás herramientas no mueren: ya están en uso.

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

- Sirve a XC-33 (línea de retardo graduada), XC-12 y XC-16 (retardos de anillo), XC-31 (calefactor por contienda), XC-26 y XC-37
  (precarga con `ebufn_1`), y a los consumidores de lógica de carrera de XC-36.
- Depende de que la síntesis y el enrutado respeten las celdas (`keep`, colocación fija), ya probado en EFLD-00/01.
- Sin permisos mientras la contienda no pase del régimen de vías (por encima: llave y permiso de XC-01). Un chip basta. Aviso:
  una celda fuera de su uso no tiene modelo validado para ese uso; el `.lib` no lo cubre.

## 8. Abierto y fuentes

- Paso y desajuste del vernier `[?]`; capacidad de entrada por celda `[?]`; ganancia del inversor realimentado `[?]`.
- Si las celdas de retardo son largas de canal o cadenas con carga interna: decide si heredan el LOD `[?]`.
- Si el precheck de Tiny Tapeout acepta lazos y nodos con varios drivers (pendiente en EFLD-00).
- Corridas: [`experiments/stdcell_lod`](../../experiments/stdcell_lod/README.md),
  [`experiments/xc19_weak_inversion`](../../experiments/xc19_weak_inversion/README.md). Laboratorio, sin publicar:
  `local_flow/efld_00`, `efld_01`, `macros/photon/LEEME.md`, `ideas/README.md`. PDK: [pesca](../notas/PESCA_2026-11-12.md).
