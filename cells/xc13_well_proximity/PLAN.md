# XC-13 · WPE

**Instrumento o control (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-13 de [catálogo](../../README.md#catalogue) (Well proximity (WPE)).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-13 · WPE.** Dopado extra junto al borde del pozo → transistor a distancia variable del pozo → ninguna → Vth → umbral por
distancia → igual que XC-12 → matriz cruzada con XC-12, variando cada una por separado. **Mantener:** la tarjeta local no trae
parámetros de pozo, así que cualquier efecto medido es dato nuevo para el PDK. Eso justifica medir; no promete física nueva.

## 2. Lectura y piso

El mismo lector que XC-12: etapa en inversión débil de XC-19 para parejas; cociente de anillos como respaldo.

| Cantidad | Valor | De dónde |
|---|---|---|
| Señal esperada | `[?]`. La tarjeta `nfet_01v8__tt` no trae `wpemod` ni `kvth0we`: el modelo predice cero | laboratorio, `docs/AUDITORIA_LOD_1111_BORRADOR.md`, lectura del **PDK**, sin publicar |
| Sensibilidad del lector | 0,83 a 0,84 % del tiempo por 0,305 mV de umbral | `experiments/xc19_weak_inversion`, **corrida**, solo modelo |
| Piso: desajuste de un dispositivo | σ = 17,3 mV (0,42/0,15) y 5,13 mV (5/0,15) | `experiments/lod_audit`, **corrida** |
| Referencia de escala: lo que hace LOD en el mismo transistor | 31,1 y 44,1 mV | `experiments/lod_audit`, **corrida** |
| Magnitud publicada del efecto en nodos de 130 nm | `[?]`, ninguna fuente leída | — |

Señal/piso: desconocida. El piso lo fija el desajuste, no el lector: con transistores anchos y N parejas por nivel el límite
de detección baja con √N. Si el efecto fuera menor que el 1 % del observable (unos 0,4 mV: 1 % entre 0,83 % por 0,305 mV,
**cálculo**), el lector no lo vería ni con desajuste nulo.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| LOD: al mover el transistor respecto al pozo cambia también su difusión o su aislamiento | `sa`/`sb` idénticos en todos los niveles, comprobados con el anotador; matriz cruzada con XC-12 |
| Distancia al contacto de cuerpo: cambia la resistencia de sustrato, no el dopado | Contacto de cuerpo a distancia fija del transistor en todos los niveles (LU.2 pide uno a menos de 15 µm, **corrida**) |
| Gradiente del dado y desajuste | Parejas especulares, niveles intercalados, transistores anchos |
| Fuga o acoplamiento de la unión pozo–sustrato cercana | Fantasma: el mismo pozo a la misma distancia sin transistor, junto a un lector vacío |
| Entorno de poly y de relleno distinto junto al borde del pozo | Poly ficticio a paso fijo; misma densidad local dibujada |
| Esfuerzo del encapsulado (XC-44) | Pareja a 0° y 90° respecto al borde del pozo |

Gemelo: el transistor lejos de cualquier borde de pozo, con la misma difusión. Ficticio: un pozo dibujado al lado pero del lado
de la fuente y no del canal, si el mecanismo es direccional `[?]`.

## 4. Referencia convencional (control científico, no filtro)

El componente convencional es el mismo transistor del PDK con su modelo, que no conoce la distancia al pozo: la comparación es
"anotar la distancia mejora la predicción" frente a "no hace falta". Como forma de fijar un umbral compite con las variantes
lvt/hvt y con LOD (XC-12), que ya tiene modelo. WPE solo gana como celda si da un desplazamiento mayor que el desajuste y que no
se obtiene con LOD; lo más probable es que su valor sea un parámetro nuevo para el modelo abierto, no una función.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho: comprobado que la tarjeta local no trae parámetros de pozo (laboratorio, sin publicar).
2. Pendiente: repetir esa búsqueda en pfet, lvt, hvt y en todas las esquinas del modelo; anotar el resultado en una corrida pública.
3. Pendiente: bordes legales con `residual/drc_edge`: difusión n+ a pozo n, difusión p+ dentro del pozo a su borde, poly a pozo.
   No están medidos; hasta entonces, "borde legal por buscar".
4. Pendiente: leer una fuente con el efecto medido en un proceso de 130 o 180 nm para acotar magnitud y alcance `[?]`.
5. Pendiente: buscar en los datos crudos del test tile de SkyWater si alguna estructura varía la distancia al pozo `[?]`.
6. Pendiente: tercer contexto de Residual: distancia de cada transistor al borde de pozo más cercano, por cada lado. Es
   geometría pura y se puede escribir y probar hoy, aunque el modelo aún no la use.
7. Pendiente: generador de la matriz cruzada con XC-12, DRC en los dos decks, extracción y anotación.
8. No hay simulación con predicción posible: el modelo dice cero. La predicción escrita es "cero" y el experimento la pone a prueba.

### 5.2 Configuraciones a dibujar

Valores propuestos. El extremo cercano de cada barrido es el borde legal, por buscar con `drc_edge`.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Distancia del canal al borde del pozo, nfet fuera | Mínimo legal; ×2; ×4; 2; 5; 10 µm | ¿Hay efecto, y con qué alcance decae? Da el parámetro que la tarjeta no tiene |
| Lo mismo, pfet dentro del pozo | Mínimo legal; ×2; ×4; 2; 5 µm al borde interior | ¿Simétrico para el implante del pozo visto desde dentro? |
| Lados con pozo cerca | Uno, dos opuestos, cuatro (transistor rodeado) | ¿Se suman los bordes? Perímetro de pozo visto frente a distancia |
| Orientación del borde | Paralelo al canal (del lado de fuente o drenaje) frente a perpendicular (del lado del ancho) | ¿Los iones dispersados llegan al canal entero o solo a un extremo? |
| Ancho W | 0,42; 1,0; 5,0 µm con el borde del lado del ancho | Si el dopado extra entra por un lateral, el efecto debe diluirse con W |
| Largo L | 0,15; 0,50; 1,0 µm con el borde del lado de la fuente | Lo mismo en la otra dirección |
| Cruce con XC-12 | 2 distancias al pozo × 2 largos de difusión, las cuatro combinaciones | ¿Son aditivos? Variar cada una por separado es la condición de la ficha |
| Ancho del propio pozo | Pozo de ancho mínimo (0,840 µm, laboratorio, **leído**) frente a pozo ancho | ¿El dopado del borde depende de cuánta resina había? |

Primero un canal completo: una pareja ancha de nfet, cerca y lejos del pozo, con `sa`/`sb` iguales, junto a la pareja de XC-12.

### 5.3 En silicio

1. **Virgen:** tiempos de descarga de cada nivel y de su gemelo lejano.
2. **Calibrar:** el escalón de puerta y el condensador de referencia de XC-19; la pareja de XC-12 como comprobación de escala.
3. **Caracterizar:** umbral equivalente frente a distancia, con intervalo entre réplicas.
4. **Barrer:** temperatura y alimentación; un desplazamiento por dopado no debe depender de ninguna de las dos en el cociente.
5. **Repetir** otro día; otro chip si lo hay.
6. **Clasificar:** efecto con ley de distancia, sin efecto por encima del límite conocido, inconcluso, fallo de lector.

No hay transformación.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** desplazamiento monótono con la distancia, reproducible entre réplicas especulares y aditivo con LOD. Es un
  parámetro nuevo para el modelo abierto.
- **Negativo informativo:** ninguna diferencia, con límite de detección conocido (desajuste medido en las réplicas). También es
  dato: justifica que la tarjeta no traiga el parámetro.
- **Inconcluso:** diferencia que no sobrevive al espejo, o del tamaño de la dispersión entre réplicas.
- **Fallo instrumental:** la pareja de XC-12 no da la diferencia esperada o el escalón de calibración no se ve.
- **Muere como celda** si el efecto queda bajo el desajuste de un transistor ancho; como medida no muere.

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

- Va en el mismo macro que XC-12 y depende del lector de XC-19 y de su alimentación.
- Depende de XC-12: sin `sa`/`sb` controlados el resultado no se interpreta.
- XC-46 comparte el barrido de W; XC-42 (pozo flotante) comparte las reglas de pozo.
- Sin permisos especiales. Las réplicas caben en un chip; la variación entre chips pide más de uno.

## 8. Abierto y fuentes

- Magnitud y alcance del efecto en este proceso `[?]`. Si el pozo de SKY130 se implanta de forma que lo produzca `[?]`.
- Bordes legales de pozo a difusión, sin medir.
- La [pesca](../notas/PESCA_2026-11-12.md) lo sitúa entre los "umbrales fijados por layout", en la mitad baja del orden de
  probabilidad a 1,8 V; es juicio de un agente.
- Fuentes: [`experiments/lod_audit`](../../experiments/lod_audit/README.md), [`residual`](../../residual/README.md) ("next context
  to recover: distance to the well edge"), [`residual/drc_edge`](../../residual/drc_edge/README.md), plan de
  [XC-12](../xc12_lod_stress/PLAN.md).
