# XC-23 · Unión lateral multiterminal

**Instrumento o control (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-23 de [catálogo](../../README.md#catalogue) (Lateral multi-terminal junction).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-23 · Unión lateral multiterminal.** Difusión de minoritarios → inyector y colectores a varias distancias → polarización → corriente
recolectada frente a distancia y guarda → sensor de portadores, transistor lateral, magnetotransporte → — → inyección y recolección
con referencias del PDK. **Mantener en H:** es además el control obligatorio de XC-26 (portadores antes que fotones).

## 2. Lectura y piso

Lector de precarga y descarga de XC-26: el colector es una unión en inversa que recoge los portadores inyectados y mueve un
nodo. Para un colector p+ en pozo n el nodo sube en vez de bajar: hace falta la versión complementaria del lector, sin diseñar.

| Cantidad | Valor | De dónde |
|---|---|---|
| Piso del lector | ≈ 150 fA a 27 °C con 2²⁰ ciclos a 10 MHz; nodo de 12,4 fF (modelo) | `macros/photon/LEEME.md`, laboratorio, sin publicar |
| Rango del lector | De 1 nA (114 ciclos) a 100 fA (fuera de la ventana de 2²⁰): unas cuatro décadas | idem |
| Corriente recogida esperada | Una fracción de 10⁻⁵ de un emisor de 100 µA ya es 1 nA (supuesto de orden de magnitud) | `PESCA_OPTO_1104.md` §6, laboratorio |
| Longitud de difusión en el pozo n y en el sustrato | `[?]` | — |
| Ganancia de los bipolares verticales del PDK | PNP β ≈ 14,3 (7,5–21); NPN β ≈ 37,5 | [pesca](../notas/PESCA_2026-11-12.md), **leído por agente** |

Señal/piso: probablemente alta cerca del inyector (nA contra 150 fA) y el problema es el contrario, saturar el lector. La
distancia a la que la señal cruza el piso es justo la medida: es la longitud de difusión leída con una regla dibujada.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Caída óhmica: el inyector sube el potencial local y el colector lo nota sin portadores | Ficticio: contacto óhmico (n+ en pozo n) que mete la misma corriente sin inyectar minoritarios |
| Calor del inyector, que sube la fuga del colector | Resistencia de poly de igual potencia en el mismo sitio; XC-31 como termómetro |
| Luz: la unión en directa emite y el colector es un fotodiodo | Aquí la luz es lo aburrido. Tapas de XC-27 y colector tras un pozo en inversa, que para portadores y deja pasar luz |
| Fuga propia del colector | Inyector apagado, intercalado en cada lectura |
| Acoplo capacitivo del flanco del inyector | Lectura retardada: el inyector conmuta fuera de la ventana de conteo |
| Gradiente del dado | Colectores a la misma distancia a los dos lados del inyector |

## 4. Referencia convencional (control científico, no filtro)

Los bipolares del PDK (`pnp_05v5`, `npn_05v5`) y sus diodos, medidos con el mismo lector, son la referencia: transistores
verticales con ganancia documentada. La unión lateral solo gana si ofrece lo que esos no: varios colectores que reparten
la corriente según la geometría (un sensor de posición o de campo magnético por desvío de portadores), o un transistor lateral
cuya ganancia se fija por distancia dibujada. Como instrumento no compite: es el control de XC-26 y no tiene sustituto.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (laboratorio, sin publicar): las celdas de PHOTON ya contienen un inyector p+/pozo n y un colector (el fotodiodo) a 5,
   10 y 20 µm, con control a 40 µm y variante con guarda. Son, sin cambiar nada, el primer experimento de esta familia.
2. Hecho: bordes legales entre difusiones (0 y desde 0,27 µm, **corrida**) y entre pozo n ajeno y fotodiodo (4,5 µm, regla
   nwell.7 que ninguna herramienta comprueba; laboratorio).
3. Pendiente: decidir qué inyección es posible a 1,8 V con el sustrato a masa. Un p+ en pozo n se puede poner en directa; un
   n+ en el sustrato exigiría una tensión negativa, que el vehículo no tiene. Consecuencia: en D solo se inyectan huecos al
   pozo n, y al sustrato llegan como mayoritarios por el PNP vertical parásito.
4. Pendiente: simular con el PNP del PDK el reparto entre colector lateral y sustrato; predicción escrita antes. El modelo no
   contiene la distancia: la simulación da solo el orden de la corriente disponible.
5. Pendiente: lector complementario (nodo que sube) y su fondo.
6. Pendiente: buscar la longitud de difusión o el tiempo de vida en pozo n y sustrato de SKY130 `[?]`.
7. Pendiente: dibujar por script, DRC en los dos decks, extraer (Magic funde los contactos de sustrato en una red: ya visto).

### 5.2 Configuraciones a dibujar

Valores de barrido: **propuesta**.

| Barrido | Valores | Pregunta |
|---|---|---|
| Distancia inyector–colector en el mismo pozo n (p+ a p+) | 0,27; 0,54; 1,08; 2; 5; 10 µm | Caída exponencial: su pendiente es la longitud de difusión de huecos en el pozo |
| Distancia inyector–colector a través del sustrato (pozo a pozo) | 5; 10; 20; 40 µm | Lo que de verdad llega al fotodiodo de XC-26 sin luz |
| Ancho del colector | 1,4; 5; 20 µm de frente | Fracción recogida frente a ángulo subtendido: difusión isótropa o canalizada |
| Colectores a ambos lados y en anillo partido | 2 y 4 sectores | Reparto simétrico: base del sensor de desvío magnético y control del gradiente |
| Guarda intermedia | Ninguna; anillo p+ a masa; pozo n en inversa; los dos | Qué guarda corta qué portador: la tabla que XC-26 necesita |
| Ancho de la guarda | Mínimo legal; 2×; 4× | Atenuación por unidad de ancho de guarda |
| Perímetro frente a área del inyector | Cuadrado y tira de igual área | Inyección lateral (perímetro) frente a vertical hacia el sustrato (área) |
| Profundidad del colector | p+ somero; pozo n; pozo profundo | Los portadores del sustrato viajan hondo: ¿cuál los recoge mejor? |
| Orientación | Eje del par a 0° y a 90° | Anisotropía por esfuerzo o por la rejilla de pozos vecinos |

Primero un canal: inyector, un colector a la distancia mínima, su ficticio óhmico y el lector complementario.

### 5.3 En silicio

Clasificada en H porque la identificación fina (curvas I–V, ganancia frente a corriente) pide pines analógicos. La parte de
distancia y guarda cabe en D con el lector de precarga:

1. **Virgen:** fondo de cada colector con el inyector apagado.
2. **Calibrar:** corriente de prueba en el nodo del lector; corriente del inyector fijada por una resistencia de poly conocida.
3. **Caracterizar:** corriente recogida frente a distancia, en escala logarítmica; ajuste de la longitud de difusión.
4. **Barrer:** corriente del inyector (¿la fracción recogida es constante?), temperatura, cada guarda conectada y desconectada.
5. **Tiempo:** apagar el inyector y leer con retardo creciente: el decaimiento es el tiempo de vida de los minoritarios.
6. **Campo magnético** (si existe el montaje de XC-25): diferencia entre colectores gemelos con imán y sin él.
7. **Clasificar:** difusión con longitud medida, acoplo óhmico, térmico, bajo el piso, fallo de lector.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** corriente recogida que cae con la distancia con una sola longitud característica, desaparece con el ficticio
  óhmico y se reduce de forma medible con la guarda. Eso entrega a XC-26 la curva de portadores que debe restar.
- **Negativo informativo:** el colector responde igual al inyector y al ficticio óhmico: el acoplo es eléctrico, no difusión.
- **Inconcluso:** dependencia con la distancia que no es una exponencial ni una ley de potencias reconocible.
- **Fallo instrumental:** el lector satura en todas las distancias o no ve la corriente de calibración.
- **Muere** como celda si no ofrece nada que el PNP del PDK no dé. Como control de XC-26 no muere: se mantiene mientras
  viva XC-26.

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

- Vehículo: D para distancia y guarda; H para curvas completas y para el modo de transistor lateral.
- Riesgo de enganche (XC-24): un p+ en directa dentro de un pozo n es el ánodo de un tiristor parásito. Corriente limitada
  por resistencia en hardware y contactos de sustrato a menos de 15 µm (regla LU.2, vista en `residual/drc_edge`).
- Control obligatorio de XC-26, XC-21, XC-27 y XC-50: sin su curva, ninguna de esas puede afirmar fotones.
- Comparte lector con XC-20 y XC-26; comparte imán con XC-25.

## 8. Abierto y fuentes

- Longitud de difusión y tiempo de vida en SKY130: `[?]`.
- Si los huecos inyectados al pozo llegan al fotodiodo como portadores recogidos o solo como subida de potencial del sustrato
  (hipótesis del laboratorio, sin medir).
- No se halló ninguna medida publicada en silicio de volumen que separe fotones de portadores entre emisor y detector
  (laboratorio, `PESCA_OPTO_1104.md` §4; Zhou 1994, solo resumen: es difusión de minoritarios y se corta con distancia o guarda).
- Fuentes: `macros/photon/LEEME.md`, `docs/pesca/PESCA_OPTO_1104.md` (laboratorio, sin publicar);
  [pesca del 12-nov](../notas/PESCA_2026-11-12.md); [`residual/drc_edge`](../../residual/drc_edge/README.md).
