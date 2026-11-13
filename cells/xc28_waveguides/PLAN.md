# XC-28 · Guías en el dieléctrico

**Fuera del catálogo de celdas (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-28 de [catálogo](../../README.md#catalogue) (Waveguides in the dielectric).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-28 · Guías en el dieléctrico.** Guiado en el BEOL → precursor dieléctrico → posproceso → transmisión → distribución óptica →
— → acceso al dado. **Mantener en E:** precedente en 180 nm verificado parcialmente (`PESCA_OPTO_1104.md` §4b).

## 2. Lectura y piso

La ficha pide posproceso y acceso al dado. Hay una variante que no los pide y se puede leer hoy: el óxido entre dos metales
como guía, alimentada por el emisor interno de XC-26 y leída por su fotodiodo con el lector de precarga y descarga.

| Cantidad | Valor | De dónde |
|---|---|---|
| Piso del lector | ≈ 150 fA a 27 °C (modelo) | `macros/photon/LEEME.md`, laboratorio, sin publicar |
| Precedente | Reloj óptico distribuido por guías en viga doble T en CMOS de volumen de 180 nm sin modificar; 780 nm | Sarkar 2025, resumen leído en el laboratorio |
| ¿Fuente externa o interna en el precedente? | `[?]`: no confirmado; externa es lo probable | `PESCA_OPTO_1104.md` §4b |
| ¿Hubo grabado posterior en el precedente? | `[?]`: el resumen dice «sin modificaciones de proceso» | idem |
| Pila disponible | Óxido bajo li1 0,5 µm; li1 0,1 µm; met1 y met2 0,35 µm; óxidos entre metales `[?]` | `FRONTERAS_FISICAS_1105.md`, laboratorio |
| Pérdida de una guía óxido–metal por unidad de longitud | `[?]` | — |
| Acoplo del emisor en el silicio a la guía | `[?]`; es el mismo problema que la tapa de XC-27 | — |

Señal/piso: `[?]`. La cadena multiplica tres incógnitas: emisión (XC-26), acoplo y pérdida. Señal esperada, pequeña.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| La señal llega por el sustrato (portadores o luz directa), no por la guía | Guía con un codo: el fotodiodo al final del codo está a la misma distancia en línea recta que otro sin guía |
| Los metales de la guía acoplan eléctricamente emisor y lector | Guía cortada: los mismos metales con una pared de vías que cierra el óxido a mitad de camino |
| Los metales cambian la capacidad del nodo | Guía cortada (misma capacidad); corriente de prueba por canal |
| Los metales conducen calor del emisor al fotodiodo | Guía cortada (conduce igual o mejor); fondo térmico leído tras apagar el emisor |
| El metal sobre el fotodiodo cambia su corriente oscura | Fondo con el emisor apagado en cada variante |
| La luz va por el óxido, pero sin guiar: se esparce por toda la pila | Guía ancha frente a estrecha a igual metal total; fotodiodo lateral fuera del eje |

## 4. Referencia convencional (control científico, no filtro)

Para llevar una señal de un punto a otro del chip: un hilo de metal con un inversor, que es insuperable en este nodo. La guía
no compite como interconexión. Solo se sostiene como componente si aísla (dos dominios sin camino eléctrico, cosa que el
sustrato común ya compromete) o como sensor (algo en el óxido o encima cambia la transmisión). Contra XC-27 se compara
directamente: una tapa lisa sobre el camino ya es una guía entre silicio y metal; la guía entre dos metales tiene que ser mejor.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (laboratorio, sin publicar): resumen de Sarkar 2025 leído; lo que afirma y lo que no.
2. Pendiente, lo primero: leer el artículo entero (`Sarkar_VLSI2025.pdf`): sección de la guía, capas usadas, pérdida medida,
   fuente, acoplo de entrada. Sin eso no hay ni una cifra de pérdida.
3. Pendiente: espesores de óxido entre metales y sus índices, del PDK o de su documentación `[?]`.
4. Pendiente: cuenta de modos: con qué separación de metales cabe un modo a 1100 nm en el óxido (media longitud de onda en
   el óxido es del orden de la mitad de 0,76 µm, **cálculo** de la ficha de XC-27). Comparar con los espesores del paso 3.
5. Pendiente: simulación electromagnética de la sección de la guía y de la entrada desde un emisor bajo la superficie.
6. Pendiente: dibujar por script guía recta, con codo y cortada sobre el par de XC-26; DRC en los dos decks. Anchos mínimos
   y reglas de ancho máximo de metal (ranurado), borde legal por buscar.
7. Pendiente: saber si el relleno y el trazador respetan el interior de la guía `[?]`.

### 5.2 Configuraciones a dibujar

Valores de barrido: **propuesta**.

| Barrido | Valores | Pregunta |
|---|---|---|
| Longitud de la guía | 5; 10; 20; 40 µm | Pérdida por longitud: una recta en escala logarítmica |
| Par de capas (suelo y techo) | Silicio–met1; li1–met2; met1–met3; met2–met4 | Altura del núcleo de óxido: qué par deja pasar un modo |
| Ancho de la guía | 1; 3; 10 µm | Confinamiento lateral frente a pérdida en las paredes |
| Paredes laterales | Abiertas; filas de vías; vías continuas hasta donde la regla deje | ¿Hace falta cerrar los lados o basta suelo y techo? |
| Trazado | Recta; un codo de 90°; dos codos | La luz guiada dobla; lo que va por el sustrato, no. Es el control central |
| Guía cortada | Pared de vías a mitad; hueco en el techo a mitad | Gemelo eléctrico y térmico sin camino óptico; el hueco mide cuánta luz se escapa |
| Entrada | Emisor bajo techo liso; bajo una red de XC-27; bajo un techo inclinado en escalera de capas | Cómo se mete en la guía la luz que sale hacia arriba |
| Salida | Fotodiodo bajo el final; final con red; final con pared de vías | Cómo se devuelve al silicio |
| Posproceso (otro vehículo) | Óxido expuesto sin metal encima; con ventana de pasivación | Precursor para grabado o para depositar algo encima; solo con acceso al dado |

Primero un canal: guía recta de 10 µm y su gemela cortada, sobre dos pares iguales de XC-26.

### 5.3 En silicio

Variante interna, en el flujo digital, después de que XC-26 haya mostrado luz y XC-27 haya mostrado que una tapa la cambia:

1. **Virgen:** fondo de cada fotodiodo con todo apagado.
2. **Calibrar:** corriente de prueba y capacidad de cada nodo.
3. **Caracterizar:** tríos intercalados en guía recta, guía cortada y par sin guía; cociente recta/cortada.
4. **Barrer:** longitud (pérdida), corriente del emisor, temperatura.
5. **Codo:** la variante con codo frente al fotodiodo sin guía a igual distancia en línea recta.
6. **Clasificar:** guiado (recta > cortada, con ley de longitud y paso por el codo), sin guiado, bajo el piso, fallo.

Variante con posproceso o fuente externa: espera acceso al dado; la secuencia se escribe cuando exista el vehículo.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** la guía recta entrega más que la cortada, la diferencia cae con la longitud con una sola constante y aparece
  también tras el codo.
- **Negativo informativo:** XC-26 y XC-27 ven luz, y recta y cortada son iguales: con esta pila no hay guiado útil a 1100 nm.
- **Inconcluso:** XC-26 no separa luz de portadores: familia no probada.
- **Fallo instrumental:** copias iguales difieren tanto como recta y cortada.
- **Muere** la variante interna si la cuenta de modos del paso 4 dice que ningún par de capas admite un modo y la simulación
  lo confirma; aun así la variante de posproceso queda abierta en su vehículo.

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

- Depende, en cadena, de XC-26 (luz), XC-23 (portadores) y XC-27 (acoplo de entrada). Es la última de la fila óptica.
- Bloqueo de relleno y trazado dentro de la guía `[?]`. Metal 5 reservado: el techo más alto disponible es met4.
- Vehículo: D para la variante interna; especializado (acceso al dado, posproceso, fuente externa) para la de la ficha.
- Área: cada variante es un par de XC-26 más la guía; decidir cuántas caben tras ver XC-27.

## 8. Abierto y fuentes

- Si el precedente usa fuente externa y si graba después: `[?]` hasta leer el artículo entero.
- Espesores e índices de los óxidos entre metales: `[?]`.
- A 780 nm (precedente) el silicio absorbe y un fotodiodo responde bien; a 1100 nm (nuestro emisor probable) responde mal.
  No tenemos emisor a 780 nm sin avalancha (XC-21).
- Fuentes: `docs/pesca/PESCA_OPTO_1104.md` §4b y `docs/FRONTERAS_FISICAS_1105.md` (laboratorio, sin publicar); Sarkar, Baum,
  Hajimiri, VLSI 2025 (solo resumen).
