# XC-29 · Nanoporos reales

**Fuera del catálogo de celdas (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-29 de [catálogo](../../README.md#catalogue) (Physical nanopores).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-29 · Nanoporos reales** y **XC-30 · Coherencia mesoscópica.** Solo nombradas (texto externo del 2026-11-08, que no está en el
repo). Cadena `[?]`. **Mantener como línea abierta** hasta tener el texto.

## 2. Lectura y piso

No hay lectura que planear porque no hay cadena: la familia está solo nombrada y su texto de origen (externo, 2026-11-08) no
está en el repositorio. Lo que sigue es qué hay que definir primero y, para no dejarlo vacío, las lecturas posibles según cada
interpretación. Las tres interpretaciones son **conjetura** nuestra, no del texto.

| Interpretación (conjetura) | Qué sería el «poro» | Observable que se leería | Instrumento | Piso |
|---|---|---|---|---|
| A. Poro en el dieléctrico | Hueco real en el óxido o la pasivación | Fuga entre dos metales; humedad que entra | Precarga y descarga (XC-26) | ≈ 150 fA (modelo, laboratorio, sin publicar) |
| B. Vacío en el metal | Hueco que deja la electromigración en una línea (XC-01) | Resistencia de la línea | Anillo con resistencia en serie (EFLD-00) | +1,7 % con 1 kΩ (laboratorio, sin publicar) |
| C. Nanoporo para iones o moléculas | Orificio pasante en una membrana, con líquido a ambos lados | Corriente iónica y sus bloqueos | Ninguno de la plantilla; pide electrómetro y líquido | `[?]` |

«Reales» sugiere poros físicos frente a los hoyos dibujados de XC-27; no pasa de sugerencia. Señal esperada: `[?]` en las tres.

## 3. Explicación aburrida y controles

Mientras no haya mecanismo no hay explicación aburrida propia. Las que heredaría cada interpretación:

| Interpretación | Explicación aburrida | Control |
|---|---|---|
| A | Fuga de superficie o del propio lector, no del poro | Gemelo sin poro (misma pareja de metales, misma distancia); fantasma |
| A | El «poro» es una ruptura ordinaria del óxido (eso es XC-07) | Definir antes qué distingue a un poro de un filamento; si nada, se funde con XC-07 |
| B | La resistencia sube por el contacto o la vía, no por un vacío en la línea (hallazgo de XC-03) | Estructura de cuatro puntas; línea gemela sin estrés |
| C | Fuga por la pasivación o por el encapsulado, no por el poro | Membrana sin orificio |
| Todas | Lo que se ve a 300 K en una estructura de SKY130 se atribuye primero a trampas, contactos u óxido | Regla del laboratorio (`FRONTERAS_FISICAS_1105.md`, ficha 3) |

## 4. Referencia convencional (control científico, no filtro)

Depende de la interpretación. A: el antifusible o la ruptura de óxido (XC-07), que ya es un camino a través de un dieléctrico.
B: el fusible metálico del PDK, que tiene regla propia (0,8 × 7,2 µm, **leído por agente**, en la pesca). C: no hay componente
de biblioteca; se compararía con membranas de nitruro fabricadas aparte, fuera de este proyecto. En las tres el chip debe
poder concluir que lo ya catalogado (XC-01, XC-07) cubre el fenómeno y que XC-29 se funde con una de ellas.

## 5. Plan de pruebas

### 5.1 Sin silicio

Qué definir primero, en orden:

1. Conseguir el texto externo del 2026-11-08 y copiar a la sección 1 la frase exacta donde aparece «nanoporos reales».
   Es lo único que desbloquea la familia; lo tiene Juan o está en un chat anterior `[?]`.
2. Con el texto, escribir la cadena de la ficha: mecanismo → precursor → transformación → observable → función → circuito →
   experimento. Si algún eslabón no se puede escribir, se deja `[?]` y se dice cuál.
3. Decidir entre A, B, C u otra. Si es B, proponer la fusión con XC-01; si es A con ruptura, con XC-07. La línea del catálogo
   se conserva y apunta a la que absorbe.
4. Escribir la observabilidad antes que nada más: instrumento, piso y señal. Sin los tres no pasa a 5.2.
5. Pesca dirigida: una fuente leída por interpretación viva (poros en dieléctricos de la pila CMOS; vacíos de
   electromigración vistos al microscopio; nanoporos de estado sólido sobre CMOS). Hoy no hay ninguna.
6. Solo entonces: precursor por script y DRC. Para A y B ya existen piezas: la constricción de met1 del laboratorio y los
   bordes legales de `residual/drc_edge` (m1 0,140; li 0,170).

### 5.2 Configuraciones a dibujar

Condicionales a la interpretación; valores **propuesta**, sin número hasta definir el mecanismo.

| Si es… | Barrido | Pregunta |
|---|---|---|
| A | Distancia entre los dos metales que el poro uniría: mínima legal (m1 0,140) y dos mayores | ¿La fuga existe solo a la separación mínima? |
| A | Perímetro enfrentado a igual separación: corto, largo, peine | Los poros son defectos por unidad de longitud: la tasa escala con el perímetro |
| A | Capa: li1–li1; met1–met1; met1–met2 (vertical) | Qué dieléctrico de la pila es poroso, si alguno |
| A | Con y sin metal encima; cerca y lejos del borde del dado | Entrada de humedad: el borde y la pasivación importan |
| B | Ancho y largo de la línea (liga con XC-01, producto de Blech en la pesca) | Dónde nuclea el vacío y si es reproducible |
| B | Número de vías en los extremos | Separa el vacío en la línea del fallo del contacto |
| C | Diámetro del orificio y espesor de la membrana | Solo con posproceso; no dibujable como poro pasante en este flujo |

Primero, como siempre, un canal: un par de electrodos, su gemelo y el lector. No antes del paso 4 de 5.1.

### 5.3 En silicio

Sin secuencia hasta tener cadena. Lo que se puede decir del vehículo:

1. Interpretaciones A y B caben en el flujo digital como estructuras pasivas leídas por tiempo; B hereda la secuencia de
   XC-01 (virgen → formar con permiso → leer → retener), con ruta de formación separada de la de lectura y llave en hardware.
2. Interpretación C espera un vehículo especializado: dado sin encapsular, posproceso y líquido. Tiny Tapeout no entrega
   dados desnudos (pesca, **leído por agente**).
3. En cualquier caso se barrería tiempo (días: humedad, deriva) y temperatura.

### 5.4 Criterio de muerte (borrador)

- **Positivo, negativo, inconcluso, fallo:** no se pueden escribir sin observable. Se escriben en el prerregistro cuando
  exista la cadena.
- **Muere como familia separada** si, leído el texto, resulta ser XC-01, XC-03 o XC-07 con otro nombre: se funde y la línea queda.
- **Queda abierta** si el texto no aparece: una familia sin cadena no ocupa silicio ni se descarta.

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

- Compuerta única hoy: el texto externo del 2026-11-08.
- Vehículo según interpretación: D (A, B) o especializado (C). El catálogo la tiene en especializado.
- Posibles dependencias: XC-01 y XC-03 (vacíos), XC-07 (ruptura), XC-26 (lector de fugas), XC-27 (hoyos dibujados).
- Permiso de estrés en mesa si la interpretación es B o A con ruptura.

## 8. Abierto y fuentes

- Qué decía el texto. Todo lo demás cuelga de ahí.
- Si «reales» opone poros físicos a los hoyos dibujados de XC-27 o a otra cosa `[?]`.
- No hay ninguna fuente en la pesca sobre poros en la pila de SKY130.
- Origen registrado: `docs/CARTERA.md` y `docs/CATALOGO_v05_BORRADOR.md` del laboratorio (sin publicar), fila «E6: nanoporos
  reales, coherencia; posprocesado o criogenia».
