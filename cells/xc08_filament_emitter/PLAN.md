# XC-08 · LED de filamento

**Fusionada en XC-07 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-08 de [catálogo](../../README.md#catalogue) (Silicon filament emitter).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-08 · LED de filamento.** Emisión del filamento de XC-07 → mismo precursor → formación a 6 V en la fuente → luz a ~1100 nm →
emisor subonda → enlace óptico → detector externo o XC-26. **Mantener en H/E:** la fuente usa óxido < 3 nm; sky130 tiene 4,15 nm
(`PESCA_PHOTON_1105.md`). Depende de XC-07.

**[corregido 2026-11-13 10:42] Ronda de ataque 4 (nodo flotante y alta tensión)** Transformada (un agente): con bomba la ruptura sería probablemente blanda; el filamento fundido pide mA que la tesela no da. Ver `experiments/RONDA_4_NODO_2026-11-13.md`.

## 2. Lectura y piso

El detector sería el fotodiodo interno de XC-26 con precarga y descarga. «lab» = laboratorio de trabajo, sin publicar.

| Cantidad | Valor | De dónde |
|---|---|---|
| Emisión publicada | pico ~1100 nm; ~94,0 pW y eficiencia externa ~1,4·10⁻⁸ a 6 mA; área de emisión bajo 0,3 µm² | `PESCA_PHOTON_1105.md`, Li 2023, **leído por agente**, lab |
| Punto de operación publicado | 1 a 6 mA; ≈ 2,5 V a 1 mA y ≈ 6,4 V a 6 mA (leído de un gráfico) | mismo |
| Detectores de la fuente | cámara y fotodiodo de InGaAs, fuera del chip | mismo |
| Piso del lector interno | 150 fA modelados a 27 °C con 2²⁰ ciclos a 10 MHz; nodo de 12,4 fF | [`PLANTILLA.md`](../PLANTILLA.md), lab |
| Respuesta de un fotodiodo de silicio a 1100 nm | muy baja `[?]` | misma pesca |
| Fracción de la luz que llega a un detector a 5–20 µm | `[?]` | misma pesca |
| Fotocorriente esperada | `[?]`; no se puede estimar sin los dos anteriores | — |
| Emisión a 1,8 V o menos | `[?]`; el gráfico de la fuente empieza en 2 V | — |

Señal/piso: desconocida, y lo previsible es que quede bajo el piso. La cuenta que falta es corta: 94 pW por la fracción acoplada y
por la respuesta a 1100 nm. Se hace en 5.1 antes de dibujar nada propio.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Portadores que difunden por el sustrato hasta el detector | Distancia; guarda conmutable; modulación a MHz (los portadores cruzan 10 µm en ~100 ns y 40 µm en ~1,6 µs; `DECISIONES.md`, lab) |
| Calor (≈ 38 mW a 6 mA con los datos de la fuente; **cálculo**, lab) | Ficticio: resistencia que disipa lo mismo en el mismo sitio; canal XC-31 |
| Acoplo eléctrico por alimentación o sustrato | Detector tapado con metal a la misma distancia; canal XC-32 |
| La luz es de la unión, no del filamento | Gemelo sin formar a la misma corriente (si conduce); unión p+/pozo en directa a igual corriente |
| El detector responde a la corriente, no a la luz | Dos detectores, somero y profundo, con cociente distinto para luz de 1100 nm y para portadores |

## 4. Referencia convencional (control científico, no filtro)

La biblioteca no tiene emisor. Los emisores sin transformación son la unión en directa y la avalancha (XC-21; ruptura de los
diodos del PDK en 11,7 a 12,8 V, `PESCA_OPTO_1104.md`, lab). El filamento tendría que dar más señal en el mismo detector que una
unión en directa a la misma corriente, o emitir desde un área menor de forma útil. Como enlace, lo convencional es un hilo: solo
importa si aísla o si mide algo.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (lab): fuente leída (texto principal y métodos), y juicio de que la geometría es dibujable con capas estándar, sin probar
   DRC.
2. Pendiente: buscar el coeficiente de absorción del silicio a 1100 nm en una fuente y hacer la cuenta de fotocorriente; si queda
   bajo 150 fA por órdenes de magnitud, se escribe aquí.
3. Pendiente: leer la información suplementaria de la fuente (no leída): límite de corriente de formación y curva por debajo de 2 V.
4. Pendiente: pasar por los dos decks la estructura de poly n+ sobre pozo n en una apertura del óxido de campo.
5. Pendiente: las celdas PHOTON del laboratorio no pueden citarse como limpias: con el deck completo y FEOL encendido violan
   photo.9 (`DECISIONES.md`, 11-nov, lab). Hay que resolver eso antes de usar su fotodiodo como detector.
6. Pendiente: decidir con XC-07 de dónde sale la tensión de formación.

### 5.2 Configuraciones a dibujar

El precursor es el de XC-07; lo propio es la geometría óptica. Valores: **propuesta**; reglas del fotodiodo: borde legal por buscar.

| Barrido | Valores | Pregunta |
|---|---|---|
| Distancia emisor–detector | 5; 10; 20; 40 µm (las de PHOTON); además 100 y 200 µm | A 1100 nm el silicio absorbe poco: la luz llegaría lejos y los portadores no. La señal que sobrevive lejos es óptica |
| Apertura del pozo bajo el poly | 0,1; 0,3; 1; 3 µm² | ¿El filamento se localiza? ¿Cambia el área de emisión? |
| Guarda entre emisor y detector | sin guarda; anillo p+; anillo de pozo n; conmutable | Recoge portadores sin parar fotones |
| Metal sobre el camino | placa de met1 encima frente a nada | Un espejo encima cambia la luz que vuelve al silicio y no cambia la difusión |
| Metal sobre el detector | destapado frente a tapado (el tapado no ve luz que venga de arriba; la del sustrato sí) | Separa el camino por los dieléctricos del camino por el sustrato |
| Profundidad del detector | unión somera frente a profunda | Luz de 1100 nm se absorbe en profundidad; cociente distinto al de portadores |
| Orientación | detector a 0°, 90° y en diagonal | Un emisor puntual es isótropo; la difusión sigue pozos y guardas |
| Tipo de emisor | filamento; el mismo sin formar; unión p+/pozo en directa | Comparación con lo convencional a igual corriente |

Primero un canal: emisor, un detector a una distancia, el ficticio térmico y la lectura.

### 5.3 En silicio

1. **Virgen** (cabe hoy): corriente oscura de cada detector; respuesta al emisor sin formar y a la unión en directa a 1,8 V. Es la
   línea de base de portadores y calor.
2. **Calibrar:** el detector con el emisor convencional de XC-26; el ficticio térmico.
3. **Transformar:** la formación de XC-07, con su vehículo.
4. **Observar:** señal del detector frente a corriente del emisor, distancia y frecuencia de modulación.
5. **Retener y repetir:** la fuente da pérdida de potencia por encima de 7 mA; se vigila la deriva.
6. **Clasificar:** sin señal sobre el piso; señal explicada por portadores o calor; señal que sobrevive a distancia, guarda y
   modulación (candidata a óptica); fallo de lector.

Vehículo que espera: el de XC-07 para formar, más tensión de operación sobre 1,8 V (la fuente necesita ≈ 2,5 V para 1 mA). Con
acceso al dado, un detector externo de InGaAs. El chip va encapsulado: sin luz externa, pero la óptica interna vale.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** señal en el detector que no cae con la guarda, sigue la modulación a MHz, sobrevive a distancias donde los
  portadores ya no llegan, y falta en el ficticio térmico.
- **Negativo informativo:** con el filamento formado y conduciendo, ninguna señal sobre un piso medido: cota superior del
  acoplamiento a 1100 nm.
- **Inconcluso:** señal que la guarda o la distancia eliminan (portadores).
- **Fallo instrumental:** el detector no ve ni el emisor convencional.
- **Muere** si XC-07 no forma filamento, o si la cuenta de 5.1 deja la señal muy por debajo del piso y no hay detector externo.

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

- Depende de XC-07 (formación) y de XC-26 (detector y lectura). No entra antes que ellas.
- Vehículo: híbrido o especializado. En el digital solo viajan la estructura virgen y sus controles.
- Comparte la cadena de controles de XC-26 y XC-21.
- Corriente de operación de mA: declarar frente a la alimentación común.

## 8. Abierto y fuentes

- Respuesta del fotodiodo a 1100 nm y acoplamiento `[?]`. Emisión por debajo de 2 V `[?]`.
- Si un óxido de 4,15 nm forma un filamento como el de menos de 3 nm `[?]`.
- Legalidad real de las celdas de fotodiodo (photo.9).
- Laboratorio, sin publicar: `pesca/PESCA_PHOTON_1105.md`, `pesca/PESCA_OPTO_1104.md`, `macros/photon/LEEME.md`, `DECISIONES.md`.
