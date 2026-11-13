# XC-21 · Avalancha como emisor

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-21 de [catálogo](../../README.md#catalogue) (Avalanche junction as emitter).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-21 · Avalancha como emisor.** Ruptura en inversa → la geometría de XC-20 → polarización a VBR → luz 400–900 nm → emisor → enlace
con XC-22 o XC-26 → emisor frente a carga ficticia. **Mantener en H/E:** VBR ajustable por separación en 65 nm (Dutta 2017, en la
pesca); bv ≈ 12 V aquí; pide bomba y auditoría de alta tensión.

**[corregido 2026-11-13 08:17] Ronda de ataque 4 (optica)** Separacion legal (hueco 0,27 um) como perilla de ruptura: muerta (plano 14,8 V a 1e17, hueco -17 %; con pozo mas ligero baja mas en relativo pero queda ~12,4 V). Esquina dibujada si: 6,6-9,7 V, verificado al orden. Con bomba a 100 uA: 3-37 pA a 5-20 um, un agente. Sin bomba a 1,8 V: abierta, probablemente bajo el piso. Ver `experiments/RONDA_4_OPTICA_2026-11-13.md`.

## 2. Lectura y piso

La luz no se lee directamente: se lee la fotocorriente de un detector vecino (el fotodiodo de XC-26 o el SPAD de XC-22) con
el lector de precarga y descarga. A 1,8 V no hay ruptura: todo lo que sigue espera una tensión que el vehículo de hoy no da.

| Cantidad | Valor | De dónde |
|---|---|---|
| Tensión de ruptura de las uniones del PDK | `bv` 11,7 V (n+/pozo p) a 12,69–12,8 V (p+/pozo n); parámetro de modelo, no medida | `PESCA_OPTO_1104.md` §1, laboratorio, sin publicar, **PDK** |
| Ruptura ajustable por separación | 2 a 9 V con d de 0 a 280 nm en pasos de 20 nm, en 65 nm | Dutta 2017, leído entero en el laboratorio |
| Eficiencia de la emisión en avalancha | Potencia óptica/eléctrica ≈ 1,7·10⁻⁶; cuántica interna ≈ 6,0·10⁻⁶; 400–900 nm, pico ≈ 620 nm (65 nm) | idem |
| Fotocorriente estimada en un fotodiodo a 10 µm | ≈ 6–60 pA con 100 µA de emisor y captación del 1–10 % (orden de magnitud, otro proceso) | `PESCA_OPTO_1104.md` §6, **cálculo** del laboratorio |
| Portadores por el sustrato | Una fuga de 10⁻⁵ de la corriente del emisor ya es 1 nA | idem |
| Piso del lector | ≈ 150 fA a 27 °C (modelo) | `macros/photon/LEEME.md`, laboratorio, sin publicar |
| Ruptura de la geometría abutida en SKY130 | `[?]`: el PDK no la modela; aquí d solo puede ser 0 o ≥ 0,27 µm | `residual/drc_edge`, **corrida** |

Señal/piso: favorable sobre el papel (pA contra 150 fA), pero el fondo de portadores estimado es mayor que la señal óptica.
La cifra óptica viene de 65 nm; para SKY130 es `[?]`.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Portadores minoritarios que difunden por el sustrato hasta el detector | Guarda conectada y desconectada; distancia; XC-23 mide la difusión sin luz |
| Calor: la ruptura disipa y el fondo térmico del fotodiodo sube (11,5 pA a 85 °C en el modelo) | Ficticio: resistencia de poly que disipa la misma potencia en el mismo sitio |
| Acoplo eléctrico de la bomba de alta tensión al nodo del lector | Bomba encendida con el emisor desconectado; lectura con la bomba parada y la tensión retenida |
| La corriente pasa, pero no por avalancha (túnel, fuga de superficie) | Signo del coeficiente térmico de la ruptura; la misma unión en directa a igual corriente: máximos portadores, mínima luz visible |
| La luz llega, pero rebotada en el metal o en el relleno | Tapas de XC-27 sobre el mismo par: cambian la luz y no los portadores |

## 4. Referencia convencional (control científico, no filtro)

Como emisor no hay equivalente en la biblioteca ni en el PDK. La comparación es contra el emisor en directa de XC-26, que
funciona a 1,8 V sin bomba, y contra el transistor en saturación de XC-50. La avalancha solo gana si su luz visible, que el
silicio absorbe en poca profundidad, da en el detector más fotocorriente por miliwatio que la unión en directa, y si esa
ventaja paga la bomba. Como función (aislar dos dominios), el componente convencional es un condensador de acoplo o un
desplazador de nivel: el enlace óptico tiene que ofrecer algo que esos no den.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (laboratorio, sin publicar): tensiones de ruptura leídas en los modelos; el pin analógico de Tiny Tapeout no deja pasar
   los ≈ 12 V (interruptor con cuerpo a 3,3 V); el modelo del `nfet_01v8` no contiene la ruptura de la unión de drenador.
2. Hecho: bordes legales de p+/n+ (0 y desde 0,27 µm). Las separaciones de Dutta, de 20 a 260 nm, no son dibujables aquí.
3. Pendiente: primer cálculo de la bomba: corriente entregable a ≈ 12 V desde 1,8 V o 3,3 V con condensadores `capm` en el área
   de una tesela, y consumo frente al límite de la red de alimentación (20 mA ≈ 0,1 V de caída). Hoy `[?]`.
4. Pendiente: auditoría de alta tensión: qué dispositivos y qué reglas de pozo aguantan ≈ 12 V, y cuáles de esas reglas no
   comprueba ninguna herramienta (borde legal por buscar).
5. Pendiente: simular con los diodos del PDK en ruptura (`bv`, `ibv` = 1,06 mA) solo para dimensionar el limitador de corriente.
6. Pendiente: dibujar las variantes de 5.2 junto al fotodiodo de XC-26 y pasar DRC en los dos decks.
7. Pendiente: leer el optoacoplador en volumen de van Drieënhuizen y Wolffenbuttel (1992) y Zhou (1994), hoy solo resumen.

### 5.2 Configuraciones a dibujar

Valores de barrido: **propuesta**. La geometría base es la de XC-20.

| Barrido | Valores | Pregunta |
|---|---|---|
| Separación d entre p+ y n+ | 0; 0,27; 0,54; 1,08 µm | ¿La ruptura baja al acercar las difusiones, como en 65 nm, con solo dos escalones legales cerca? |
| Tipo de unión | p+/pozo n; n+/sustrato; pozo n/sustrato; abutida | Cada una rompe a otra tensión y a otra profundidad: luz más o menos cerca de la superficie |
| Perímetro frente a área | Cuadrado, tira larga, peine; igual área | La avalancha empieza en bordes y esquinas: ¿la emisión escala con el perímetro? |
| Esquinas | Rectángulo frente a octógono (ángulos legales por buscar) | Concentración de campo en la esquina: ruptura prematura y emisión puntual |
| Poly sobre la unión | Con y sin placa de poly polarizable | Diodo con puerta: ¿el campo de la placa baja la ruptura? El modelo no lo predice |
| Distancia al detector | 5, 10 y 20 µm; control a 40 µm | Caída con la distancia: absorción de luz frente a difusión de portadores |
| Guarda entre emisor y detector | Sin anillo; anillo p+ al sustrato; pozo n en inversa | Qué anillo corta los portadores sin cortar la luz |
| Detector | Fotodiodo profundo de XC-26; unión somera p+/pozo n | La luz visible se absorbe cerca de la superficie; los portadores del sustrato llegan mejor al profundo |

Primero un canal: una unión, su limitador, un fotodiodo a 5 µm y la carga ficticia.

### 5.3 En silicio

Espera un vehículo con alta tensión interna (bomba) o un chip híbrido con dispositivos de 5 V y 20 V; no entra en el flujo
digital de hoy. En ese vehículo:

1. **Virgen:** fondo de todos los detectores con la bomba parada; fuga de cada unión a 1,8 V (es la medida de XC-20).
2. **Calibrar:** tensión de la bomba con un divisor leído como tiempo; corriente del emisor con el limitador.
3. **Caracterizar:** tensión de ruptura de cada variante por rampa de la bomba, con corriente limitada en hardware.
4. **Observar:** fotocorriente en tríos intercalados (emisor, carga ficticia, nada) y resta; con guarda y sin ella.
5. **Barrer:** corriente del emisor (la luz de avalancha es lineal en la corriente según Dutta), temperatura, distancia.
6. **Retener y repetir:** la ruptura sostenida envejece la unión; repetir la curva tras horas de emisión.
7. **Clasificar:** emisor con señal óptica separada, solo portadores, sin ruptura alcanzable, fallo de la bomba.

La ruta que lleva alta tensión nunca es la de lectura: el detector y su lector viven a 1,8 V, separados por guarda.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** fotocorriente que sigue al emisor y no a la carga ficticia, no cambia al conectar la guarda de portadores y
  cambia con la tapa metálica de XC-27.
- **Negativo informativo:** hay ruptura con corriente conocida y el detector, con su piso calibrado, no ve nada que la guarda
  no elimine.
- **Inconcluso:** señal que la guarda reduce solo en parte y que la carga ficticia reproduce en parte.
- **Fallo instrumental:** la bomba no alcanza la ruptura, o su conmutación aparece en el lector con el emisor desconectado.
- **Muere** si la bomba no cabe en el área o el consumo disponibles, o si ninguna variante emite por encima del fondo de
  portadores con la guarda puesta.

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

- Vehículo H o especializado: bomba de carga interna y dispositivos de alta tensión. Los ≈ 12 V no entran por el pin analógico.
- Permiso del shuttle para generar alta tensión dentro de la tesela `[?]`; limitador y apagado en hardware.
- Depende de XC-20 (geometría), de XC-26 (detector y lector) y de XC-23 (control de portadores). Sirve a XC-22 y a XC-27.
- Metal 5 reservado: los condensadores de la bomba no pueden ser `cap2m`.
- Comparte bomba con XC-07, XC-08 y XC-11; una sola auditoría de alta tensión para todas.

## 8. Abierto y fuentes

- Tensión de ruptura real de las uniones de SKY130 y su dispersión: `[?]` (solo hay `bv` de modelo).
- Dopado del pozo n de SKY130 `[?]`; en Dutta el ajuste da ≈ 10¹⁷ cm⁻³ para 65 nm.
- Área y corriente de la bomba: `[?]`, sin estimar.
- No se halló ningún proyecto de Tiny Tapeout con emisor en avalancha en SKY130 (ausencia en dos búsquedas, no prueba).
- Fuentes: `docs/pesca/PESCA_OPTO_1104.md` §1–§6 y `macros/chispa/LEEME.md` (laboratorio, sin publicar);
  [pesca del 12-nov](../notas/PESCA_2026-11-12.md).
- **Comprobación de citas del 2026-11-12** ([`docs/READING.md`](../../docs/READING.md)): Dutta et al. 2017 (IEEE EDL 38, 898) describe emisores de avalancha laterales p+-n-n+ en CMOS de 65 nm con ruptura variada entre 2 y 9 V según la geometría (**sin leer el contenido**). Una ruptura cerca de 2 V pondría esta familia al alcance de 3,3 V sin bomba.
