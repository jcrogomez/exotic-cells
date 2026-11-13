# XC-17 · Electrodo por diseño

**Fuera del catálogo de celdas (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-17 de [catálogo](../../README.md#catalogue) (Electrode by design).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-17 · Electrodo por diseño.** Capacidad parásita → placas en met2–met4 como carga de anillos, patrón del sombrero, espejo y
control periódico → ninguna → Δf (lector ≈ 2 %/fF, piso 0,4 fF) → capacidad definida por geometría → carga calibrada → tres
patrones con el mismo presupuesto de metal. **Mantener, baja prioridad:** lo mata que met5 y el relleno dominen. Aquí vive lo que
queda del sombrero en esta cartera.

## 2. Lectura y piso

Anillo cargado por la placa bajo prueba, contra un anillo gemelo cargado por el patrón de control; cociente de cuentas.

| Cantidad | Valor | De dónde |
|---|---|---|
| Sensibilidad del lector | ≈ 2 % de frecuencia por fF | laboratorio, `docs/EQUIPO.md` (lector de PHY-02), sin publicar; origen de la cifra sin releer |
| Piso | 0,4 fF a 1 σ, por desapareamiento | mismo |
| Señal: diferencia de capacidad entre sombrero, espejo y periódico a igual metal | `[?]`. La extracción la predice; no se ha corrido | — |
| Referencia de biblioteca | MiM: 2 fF/µm² entre met3/met4 y met4/met5 | [pesca](../notas/PESCA_2026-11-12.md), **leído por agente** |
| Carga que ya tiene el anillo de la plataforma | 32 cargas de puerta en el nodo | `local_flow/efld_00/LEEME.md`, sin publicar |

Señal/piso: desconocida hasta extraer los tres patrones. Hay dos señales distintas y solo la segunda es de esta cartera: la
capacidad que el extractor ya calcula (geometría, convencional) y la diferencia entre lo extraído y lo medido (residuo: grabado,
pulido, relleno). La segunda es por fuerza menor que la primera; si no llega al piso de 0,4 fF, se dice.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Los tres patrones no tienen el mismo metal: la diferencia es área, no forma | Mismo presupuesto: igual área, igual perímetro total e igual número de vías, comprobados por script sobre el GDS |
| met5 y el relleno de la integración, que no dibujamos, dominan la capacidad | Placa de blindaje propia en met4 sobre los tres; variante sin blindaje para medir cuánto pesa lo de arriba |
| El hilo de conexión a la placa pesa más que la placa | Fantasma: el mismo hilo sin placa, en un tercer anillo |
| Desajuste entre anillos (es el piso declarado) | Réplicas; intercambiar qué anillo lleva qué patrón entre réplicas |
| Gradiente del dado | Patrones intercalados y especulares |
| El sustrato bajo la placa (pozo o no) cambia la capacidad a tierra | Mismo plano bajo los tres: blindaje de met1 a tierra |

Gemelo: el control periódico. El espejo del sombrero es el control interno: misma estadística de formas, orientación opuesta;
si sombrero y espejo difieren, la causa es de orientación del proceso y no del patrón.

## 4. Referencia convencional (control científico, no filtro)

Los condensadores del PDK: el MiM (2 fF/µm², **leído por agente**) y los de placas paralelas verticales, con modelo y sin sorpresa.
Y la extracción de parásitos del flujo, que ya calcula la capacidad de cualquier forma de metal. El electrodo por diseño gana
solo si (a) da una capacidad pequeña y conocida, del orden del fF, que el MiM no ofrece por su tamaño mínimo `[?]`, útil como
referencia de calibración para los demás lectores; o (b) la forma aperiódica muestra un residuo frente a la extracción que la
periódica no muestra. Si los tres patrones miden lo que el extractor dice, gana lo convencional y la celda queda como
condensador de referencia, que es el papel que la filosofía del laboratorio ya le asigna al sombrero en este chip.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Pendiente: leer la especificación del patrón en `01_hat87/docs/research/ESPEC_CAPACITIVO.md` (repositorio privado; aquí solo
   se referencia) y fijar la baldosa y la escala que respetan ancho y separación mínimos de cada metal.
2. Pendiente: bordes legales de met2 a met4 con `residual/drc_edge` (hoy solo está medido met1: 0,140 µm).
3. Pendiente: generador por script de los tres patrones con el mismo presupuesto de metal, verificado por medida sobre el GDS.
4. Pendiente: DRC en los dos decks, incluidas las reglas de densidad, que el precheck no corre (**leído por agente**).
5. Pendiente: extraer la capacidad de los tres con Magic y con el extractor del flujo; predicción escrita antes: iguales dentro
   de un margen que se fija en el prerregistro. Si la extracción ya los separa, esa diferencia es la línea base.
6. Pendiente: simular el anillo con cada carga y comprobar la sensibilidad de 2 %/fF con una corrida pública.
7. Pendiente: averiguar si se puede bloquear el relleno sobre el macro `[?]` (sin regla pública hallada, pesca).

### 5.2 Configuraciones a dibujar

Valores propuestos. Anchos y separaciones mínimos de met2 a met4: borde legal por buscar.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Patrón a igual metal | Sombrero; espejo; periódico | La pregunta de la familia: ¿la forma importa más allá de lo que el extractor ve? |
| Área de la placa | 1×, 2×, 4× la baldosa base | Linealidad: la capacidad debe escalar con el área; el corte en cero es el hilo |
| Perímetro frente a área | Placa llena frente a peine y frente a patrón, misma área | Peso del campo de borde; es donde un patrón aperiódico podría diferir |
| Separación entre placas del mismo nivel | Mínima legal; ×2; ×4 | Capacidad lateral frente a vertical; sensibilidad al sobregrabado |
| Par de capas | met2 sobre met1; met3 sobre met2; met4 sobre met3 | Espesor del dieléctrico por nivel; ¿qué nivel es más repetible? |
| Blindaje superior | Con placa de met4 a tierra; sin ella | Cuánto pesan met5 y el relleno: es lo que mata la familia |
| Plano inferior | Sobre blindaje de met1; sobre sustrato; sobre pozo n | Capacidad a tierra y su dependencia de la tensión |
| Orientación | Patrón a 0° y a 90° | Anisotropía de litografía y grabado |
| Condensador de referencia | Dos placas paralelas simples de capacidad extraída conocida, de dos tamaños | Calibra el lector en fF: es lo que queda aunque todo lo demás muera |

Primero un canal completo: el condensador de referencia en un anillo y su fantasma (hilo sin placa) en el gemelo.

### 5.3 En silicio

1. **Virgen:** cuentas de todos los anillos, con y sin carga conmutada si se añade un interruptor.
2. **Calibrar:** pendiente del lector con los dos condensadores de referencia; el piso con dos anillos de carga idéntica.
3. **Caracterizar:** capacidad equivalente de cada patrón; comparación con la extraída.
4. **Barrer:** alimentación y temperatura; una capacidad de metal no debe moverse con ninguna de las dos una vez dividida por el
   gemelo.
5. **Repetir** otro día.
6. **Clasificar:** coincide con la extracción, residuo reproducible por patrón, inconcluso, fallo de lector.

No hay transformación.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** sombrero y periódico, con el mismo metal, difieren más que el piso y más de lo que predice la extracción, y la
  diferencia se repite entre réplicas. El espejo dice si es forma u orientación.
- **Negativo informativo:** los tres coinciden con la extracción dentro del piso. La forma no importa; queda el condensador de
  referencia calibrado.
- **Inconcluso:** la variante sin blindaje muestra que lo de arriba domina y la blindada no cabe o no pasa densidad.
- **Fallo instrumental:** los dos condensadores de referencia no dan la pendiente esperada.
- **Muere** si met5 y el relleno dominan incluso con blindaje. La prueba que lo demostraría es la fila "blindaje superior".

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

- Macro pasivo de metal: es lo que la plataforma ya sabe endurecer. Sin transistores propios ni permisos.
- Depende de la respuesta sobre el relleno y de no usar met5.
- Sirve a todos los lectores por anillo como condensador de referencia (XC-16, XC-31, XC-32) y al lector de XC-19 como
  condensador conmutado de calibración.
- Es el único lugar de la cartera donde entra el tejido del sombrero; se mantiene por eso aunque su prioridad sea baja.
- Un chip basta.

## 8. Abierto y fuentes

- Origen y validez de "2 %/fF, piso 0,4 fF": vienen de otro proyecto (PHY-02) y no están reproducidos aquí.
- Tamaño mínimo del MiM `[?]`. Bloqueo de relleno `[?]`. Densidad real de metal sobre el macro tras la integración `[?]`.
- Origen: "El Parásito" y "Pasajero del Sombrero", laboratorio (`docs/EQUIPO.md`, `docs/FILOSOFIA.md` regla 13), sin publicar.
- Fuentes: [pesca](../notas/PESCA_2026-11-12.md), [`residual/drc_edge`](../../residual/drc_edge/README.md).
