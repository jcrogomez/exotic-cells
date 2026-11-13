# XC-52 · Magnetorresistencia por pares de espín

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-52 de [catálogo](../../README.md#catalogue) (Spin-pair magnetoresistance).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Alta del 2026-11-12. Los números de este archivo son
**cálculo** con constantes de memoria salvo donde se cita otra cosa; ninguno está verificado contra fuente ni simulado.

## 0. Primeros principios

| Escala | Valor | Supuesto |
|---|---|---|
| Energía de Zeeman a 3 mT | 0,35 µeV, frente a 26 meV térmicos | g = 2 |
| Campo de una espira de 5 vueltas, 10 µm de radio, 10 mA | ~3 mT en el centro | µ₀NI/2r |
| Corriente de bombeo de carga, transistor de 10 × 10 µm a 10 MHz | ~16 nA | 10¹⁰ trampas/cm² `[?]` |
| Tiempo para resolver un cambio de 10⁻⁴ | milisegundos | solo ruido de disparo; el ruido 1/f manda en la práctica |

La polarización térmica de espín es despreciable (10⁻⁵). El efecto no la necesita: la recombinación a través de una trampa pasa por
un par de espines, y un campo comparable al hiperfino (décimas de mT a mT, **de memoria**) cambia cuánto se mezclan singlete y
triplete. Es un efecto de espín a temperatura ambiente sin material magnético.

**Tres regiones.** Convencional: la corriente no depende del campo. Tercera región: cambia de forma par con el campo, a escala de
mT. Fallo: el acoplo de la bobina tapa la señal.

## 1. Ficha

**XC-52 · Magnetorresistencia por pares de espín.** Recombinación dependiente de espín en trampas de interfaz → transistor con
fuente y drenaje unidos (el de XC-19 por bombeo de carga) bajo una microbobina (XC-56) → campo de mT modulado → cambio relativo de
la corriente de bombeo o de recombinación → magnetómetro sin material magnético, lectura del estado de espín de defectos → bobina +
bombeo + conteo síncrono → bobina real frente a bobina bifilar.

**[corregido 2026-11-12 13:06] Ronda de ataque 1** ([resumen](../../experiments/RONDA_1_2026-11-12.md)): en transistores vírgenes no hay respuesta publicada; hace falta crear trampas por estrés (XC-10) (un agente, fuente leída). «Milisegundos» era un error: 0,11 s en el límite de ruido de disparo a 14 nA (verificado). La paridad solo quita la inducción; calor y acoplo rectificado son pares como la señal: modular sobre 100 kHz y usar una bobina de dos devanados a potencia constante (un agente). El diodo con puerta da más señal que el bombeo, y el bombeo solo funciona en pfet con pozo propio (un agente).

**[corregido 2026-11-12 13:57]** Ronda 2 ([`attack2_xc52`](../../experiments/attack2_xc52/b52_INFORME.md), un agente, sin verificar) y prueba del demodulador ([`xc52_demod_test`](../../experiments/xc52_demod_test/demod.txt), **corrida**, pura aritmética). La secuencia de cuatro estados selecciona el término cruzado entre devanados. **No elimina lo clásico par en el campo:** una respuesta a·B² sale como 2·a·B₁·B₂; también sobreviven el calor si los devanados comparten retorno y cualquier producto eléctrico rectificado. Se anulan lo lineal (Hall, inducción, acoplo lineal), el calor de devanados independientes y el offset. Quedan **retiradas** dos afirmaciones del agente: «residuo ≤ 10⁻⁶» y «la frecuencia de corte dependiente de la polarización es una firma que ningún artefacto imita». Lo que distingue es la forma frente al campo: al duplicar el campo lo cuadrático se multiplica por 4 y lo saturante se aplana (×1,6; ×1,9; ×2,0). Pendiente antes de dibujar: auditar los 5,4 mA de la bobina con drivers, vías, retorno y caída en la alimentación (los 0,6 mW son solo de los devanados), y devanados sin retorno compartido. La modulación va entre 5 Hz y 5 kHz, no sobre 100 kHz. No se le asignan todavía sus ~8 100 µm².

## 2. Lectura y piso

Integrador de corriente (el de XC-26, piso modelado 150 fA, laboratorio sin publicar) con conteo síncrono a la modulación de la
bobina. Señal esperada: cambio relativo de 10⁻⁴ a 10⁻³ (**de memoria**, fuente por leer). Está muy por debajo del 1 % del
observable: solo se ve promediando, y hay que demostrar en simulación de ruido que el promedio converge.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control |
|---|---|
| Tensión inducida por la bobina en el nodo de lectura | El efecto de espín es par con el campo; la inducción es impar: invertir la corriente |
| Calentamiento por la bobina | Bobina bifilar: misma potencia, campo nulo |
| Acoplo capacitivo de la bobina | Blindaje a tierra entre bobina y dispositivo; bobina alimentada sin retorno (tensión sin corriente) |
| Magnetorresistencia ordinaria del canal | Escala con B² y es 10⁻⁸ a mT: despreciable (**cálculo**, µB ≪ 1) |

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer las fuentes de recombinación dependiente de espín a campo casi nulo en MOS de silicio; anotar campo y amplitud.
2. Campo de la bobina por Biot–Savart numérico para espiras dibujables en met3/met4, y su calentamiento.
3. Acoplo inductivo y capacitivo bobina–dispositivo, por cálculo y con openEMS: es la explicación aburrida, cuantificada.
4. Simulación de ruido y detección síncrona, como `experiments/xc19_noise`: ¿en cuánto tiempo se ve 10⁻⁴?
5. Depende de que el bombeo de carga funcione (XC-19, ventana de interfaz): cuerpo accesible con toma propia.

### 5.2 Configuraciones a dibujar

Propuesta.

| Barrido | Valores | Pregunta |
|---|---|---|
| Área del transistor | 1 × 1, 3 × 3, 10 × 10 µm | La señal relativa no debe depender del área; la absoluta sí |
| Bobina | 1, 3, 5 vueltas; con y sin bifilar | Linealidad con el campo; control térmico |
| Distancia vertical | Bobina en met2, met3, met4 | Campo frente a acoplo capacitivo |
| Tipo | nfet y pfet; con y sin estrés previo (XC-10) | Más trampas, más señal: debe escalar con el número de trampas |
| Orientación del campo | Bobina centrada (campo vertical) y desplazada (campo con componente en el plano) | Anisotropía del defecto |

### 5.3 En silicio

Virgen → calibrar el integrador → corriente de bombeo frente a frecuencia (debe ser lineal) → barrer la corriente de bobina en
los dos sentidos → repetir con la bifilar → repetir con un imán externo como comprobación independiente → tras estrés.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** cambio par con el campo, que satura a pocos mT, ausente con la bifilar, y que crece tras crear trampas.
- **Negativo informativo:** nada por encima de 10⁻⁵ con el promedio convergido y el bombeo funcionando.
- **Inconcluso:** señal impar con el campo (inducción).
- **Muere** si el acoplo calculado en 5.1 supera la señal esperada sin forma de separarlo.

## 6. Documentación para graduarse

- [ ] Hoja de primeros principios revisada por un ataque independiente
- [ ] Mapa de tres regiones por simulación física, con sus barridos
- [ ] Prerregistro con predicción numérica y criterio de abandono
- [ ] Generador de layout por script, parametrizado
- [ ] DRC en Magic y KLayout, y resultado del precheck (qué pasa y qué no)
- [ ] Extracción y LVS dispositivo a dispositivo
- [ ] Simulación contra la predicción, con su control
- [ ] Macro: pines en metal, LEF con obstrucciones, alimentación
- [ ] Datos de silicio, crudos y con su control
- [ ] Contrato: modelo, interfaz, límites, variabilidad, retención, modos de fallo, condiciones de formación
- [ ] README en inglés

## 7. Compuertas y dependencias

Depende de XC-56 (bobina) y del bombeo de carga de XC-19. Sin permisos especiales. Un chip basta para un primer resultado.

## 8. Abierto y fuentes

- Amplitud y escala de campo reales en silicio `[?]`: lectura pendiente (ver `docs/READING.md`).
- Si la corriente de 10 mA en la bobina perturba la alimentación de la tesela (20 mA ≈ 0,1 V en la red, **leído por agente**).
- **Comprobación de citas del 2026-11-12** ([`docs/READING.md`](../../docs/READING.md)): el efecto a campo casi nulo existe en transistores de silicio (Moxim 2022, **sin leer**), pero su tamaño en silicio a temperatura ambiente es `[?]`. El ~1 % publicado es de carburo de silicio. La cifra de 10⁻⁴ a 10⁻³ de la sección 2 queda como suposición.
