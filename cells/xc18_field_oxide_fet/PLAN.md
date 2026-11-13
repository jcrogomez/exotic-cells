# XC-18 · Transistor de óxido de campo

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-18 de [catálogo](../../README.md#catalogue) (Field-oxide transistor).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-18 · Transistor de óxido de campo.** Canal parásito bajo el STI → poly o metal sobre óxido de campo entre dos difusiones →
radiación o carga → Vth del parásito → dosímetro, sensor de carga → lectura por corriente → medir umbral. **Mantener en H:** precedente
publicado en 0,6 µm; umbral en sky130 `[?]`, quizá sobre 3,3 V.

## 2. Lectura y piso

El observable natural es el umbral del canal parásito, y para medirlo hace falta barrer la puerta hasta que conduzca: pines
analógicos y, quizá, más de 3,3 V. A 1,8 V y en digital solo se lee la corriente que pasa entre las dos difusiones con la
puerta a 1,8 V, con el lector de precarga y descarga.

| Cantidad | Valor | De dónde |
|---|---|---|
| Umbral del parásito en SKY130 | `[?]`, quizá por encima de 3,3 V | ficha |
| Precedente | 4,4 mV/rad en 0,6 µm sin modificar el proceso (Lipovetzky et al.) | laboratorio, `docs/CATALOGO_v05_BORRADOR.md`, sin publicar; grado de lectura no anotado |
| Piso del lector de precarga y descarga | 150 fA modelado a 27 °C con 2²⁰ ciclos a 10 MHz; nodo de 12,4 fF | [`../PLANTILLA.md`](../PLANTILLA.md); laboratorio, sin publicar |
| Corriente del parásito con la puerta a 1,8 V | `[?]`. El modelo del PDK no tiene este dispositivo | — |
| Dieléctrico bajo la primera interconexión | 0,5 µm antes de li | laboratorio, `docs/FRONTERAS_FISICAS_1105.md`, leído de la documentación, sin publicar |

Señal/piso: desconocida, y lo probable es que a 1,8 V el parásito esté cortado y la corriente quede bajo el piso. Eso sería un
límite inferior del umbral, no un fracaso: dice que el aislamiento aguanta con margen a esta tensión.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Fuga de las propias uniones al sustrato, sin canal alguno | Gemelo: las mismas dos difusiones a la misma distancia, sin puerta encima |
| Fuga del transistor de precarga y del lector | Fantasma: el lector con su nodo y sin estructura. Precarga de umbral alto y canal largo (0,010 pA frente a 5,3 pA, **corrida**) |
| Perforación entre difusiones cercanas, que no depende de la puerta | Barrido de separación con la puerta a 0 y a 1,8 V: lo que no cambia con la puerta no es canal |
| Conducción por el borde del aislamiento o por la superficie, no bajo la puerta | Puerta que cubre solo la mitad del hueco; ancho de puerta barrido: el canal escala con el ancho |
| Corriente fotoeléctrica o térmica | Dos temperaturas; chip encapsulado, sin luz |
| En la variante de dosímetro: deriva por temperatura y envejecimiento tomadas por dosis | Gemelo apantallado no existe en este vehículo; se usa un gemelo sin puerta y la temperatura de XC-31 |

Ficticio: la misma puerta sobre óxido de campo sin difusiones a los lados (no hay fuente ni drenaje que unir).

## 4. Referencia convencional (control científico, no filtro)

Como dosímetro o sensor de carga: el transistor de óxido grueso del PDK (los dispositivos de 5 V), que tiene modelo, y el
transistor estándar leído por su fuga. Como "transistor de umbral alto": el propio hvt. El parásito de campo solo gana si su
óxido, decenas de veces más grueso `[?]`, atrapa más carga por unidad de dosis que el de 5 V, que es lo que afirma el precedente
en otro proceso. Sin fuente de radiación no hay comparación posible, y entonces lo que queda es una medida del margen de
aislamiento del proceso, que no está en la documentación abierta.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Pendiente: leer el artículo de Lipovetzky y anotar proceso, geometría, tensión de puerta y umbral del parásito. Hoy la cifra
   está citada sin grado de lectura.
2. Pendiente: buscar en la documentación de SkyWater el umbral del transistor de campo o la tensión de aislamiento garantizada
   (las reglas de separación de alta tensión lo acotan indirectamente) `[?]`.
3. Pendiente: confirmar con `residual/drc_edge` la separación mínima entre difusiones (0,27 µm por difftap.3 según la corrida de
   p+/n+; falta la sonda n+/n+) y entre pozos (1,270 µm, laboratorio, **leído**).
4. Pendiente: comprobar que poly, li o metal sobre óxido de campo entre dos difusiones pasa DRC en los dos decks y qué extrae
   Magic: lo esperado es que no extraiga dispositivo y que LVS no lo vea. Es un dispositivo fuera del netlist: decirlo.
5. Pendiente: cálculo de orden de magnitud del umbral con el espesor de óxido de campo, si se encuentra `[?]`, rotulado cálculo.
6. Pendiente: dibujar un canal con el lector de precarga y su fantasma; simular solo el lector (el parásito no tiene modelo).
7. Pendiente: averiguar qué dosis o qué carga se puede aplicar en mesa sin fuente regulada `[?]`. Sin eso, la función de
   dosímetro espera.

### 5.2 Configuraciones a dibujar

Valores propuestos. Separación mínima entre difusiones 0,27 µm (**corrida**, por confirmar para n+/n+).

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Separación entre difusiones (largo del parásito) | 0,27; 0,54; 1,08; 2,0 µm | ¿La corriente cae con el largo como un canal, o no depende (fuga de unión)? |
| Ancho solapado por la puerta | 1; 5; 20 µm | Un canal escala con el ancho; una fuga de esquina, no |
| Capa de la puerta | poly; li; met1; met2 | Cada capa añade dieléctrico: el umbral debe subir con la altura. Con poly es donde antes conduciría |
| Tipo de difusiones | n+/n+ sobre sustrato p; p+/p+ dentro de pozo n; n+ a pozo n vecino | El tercer caso es el parásito que de verdad preocupa a un proceso: fuga entre un transistor y un pozo |
| Cobertura de la puerta | Todo el hueco; la mitad del lado de la fuente; solo el borde | ¿Hace falta invertir todo el camino? |
| Perímetro frente a área | Hueco recto frente a serpentina del mismo largo y más borde de aislamiento | ¿El canal vive en el plano o en la esquina del aislamiento? (liga con XC-46) |
| Sin puerta | Mismas difusiones, sin nada encima; y con relleno de metal permitido encima | Línea base; y si el metal flotante de la integración actúa de puerta |
| Lectura | Precarga y descarga a 1,8 V; salida a pin analógico en el vehículo híbrido | Lo que se ve hoy frente a lo que pide la curva completa |

Primero un canal completo: poly sobre n+/n+ a 0,27 µm con ancho grande, su gemelo sin puerta y el fantasma del lector.

### 5.3 En silicio

1. **Virgen:** tiempo de descarga de cada estructura con la puerta a 0 y a 1,8 V; gemelo y fantasma.
2. **Calibrar:** el lector con una corriente de prueba conocida.
3. **Caracterizar:** corriente frente a separación, ancho y capa; dos temperaturas (la fuga de unión crece con ella mucho más
   que un canal en inversión).
4. **Transformar (solo en el vehículo híbrido y con permiso):** puerta por encima de 1,8 V hasta encontrar el umbral; después,
   exposición a una fuente `[?]`. Ruta de formación separada de la de lectura, con límite de tensión en hardware.
5. **Retener y repetir:** el desplazamiento por carga atrapada en óxido grueso debe persistir; medir su recuperación.
6. **Clasificar:** canal controlado por puerta, fuga sin control de puerta, por debajo del piso, fallo de lector.

En el vehículo digital solo se hacen los pasos 1 a 3.

### 5.4 Criterio de muerte (borrador)

- **Positivo (hoy):** corriente que depende de la tensión de puerta, escala con el ancho y cae con la separación.
- **Negativo informativo:** nada sobre el piso con la puerta a 1,8 V, lector calibrado: el umbral está por encima y la familia
  espera al vehículo híbrido. Es lo más probable.
- **Inconcluso:** corriente igual en el gemelo sin puerta.
- **Fallo instrumental:** la corriente de prueba no se recupera.
- **Muere** si en el vehículo híbrido el umbral queda por encima de lo que aguantan las uniones, o si no hay forma de aplicar una
  dosis conocida. La prueba que lo demostraría es el barrido de puerta hasta la ruptura de unión en una estructura sacrificable.

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

- Vehículo: híbrido con pines analógicos y 3,3 V (40 € por pin o 280 EUR por cuatro: discrepancia sin resolver en la pesca).
  En el digital entra solo como medida de fuga con el lector de XC-26.
- Permiso para tensiones sobre 1,8 V y para cualquier exposición; llave y límite en hardware.
- Estructura que LVS no ve: avisar a Tiny Tapeout.
- Comparte lector y fantasma con XC-20, XC-37 y XC-38; comparte la pregunta de la esquina con XC-46; consumidor natural de XC-49.
- Un chip basta para el umbral; la dosimetría pide al menos uno expuesto y uno guardado.

## 8. Abierto y fuentes

- Umbral del parásito y espesor del óxido de campo en SKY130 `[?]`.
- El precedente, sin leer por nosotros. Fuente de radiación o de carga disponible `[?]`.
- Origen: F8 del catálogo del laboratorio (`docs/CATALOGO_v05_BORRADOR.md`, `docs/CARTERA.md`), sin publicar.
- Fuentes: [`residual/drc_edge`](../../residual/drc_edge/README.md), [`docs/CLAIMS.md`](../../docs/CLAIMS.md) (fuga de precarga),
  [pesca](../notas/PESCA_2026-11-12.md).
