# XC-05 · Contacto atómico

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-05 de [catálogo](../../README.md#catalogue) (Atomic contact).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-05 · Contacto atómico.** Transporte por pocos canales → cuello de XC-01 durante la rotura → paso por el régimen de pocos
átomos → mesetas entre 10 y 30 kΩ → patrón de resistencia, conmutador atómico → — → histogramas de cientos de ciclos reversibles.
**Mantener como expediente:** una formación irreversible por precursor no da histograma, y en aluminio los picos no prueban
cuantización (ficha 2). Lo cambiaría un precursor que cicle.

**Replanteo del 2026-11-12 (primeros principios; cálculo con constantes de memoria, sin simular).** Un contacto metálico de pocos
átomos conduce en escalones del cuanto 2e²/h = 77,5 µS: 12,9 kΩ divididos por el número de canales. La escala de energía es de
electronvoltios, así que existe a temperatura ambiente; el laboratorio ya tiene leído que en oro aparecen mesetas cerca de
múltiplos del cuanto durante la electromigración, y que duran milisegundos sin realimentación rápida (Strachan 2005, `FRONTERAS`).
Esa resistencia cae dentro del lector de anillo (1–300 kΩ). **Por qué en un ASIC:** el cuello se calienta en ~10 ns sobre 100 nm de
óxido (L²/α); un lazo de mesa reacciona en ms, uno en el chip en ns. **Tres regiones:** cable (cientos de átomos); contacto de
pocos canales, kΩ estables; abierto o túnel (GΩ, ilegible). **Precursor nuevo:** el puente sublitográfico de
`experiments/litho_explore` (cuello bajo el mínimo con largo entre 0,14 y 0,30 µm, o puntas enfrentadas a 0,05 µm), que arranca
con menos corriente. **En contra:** el recubrimiento de la línea puede conducir en paralelo a kΩ y tapar los escalones; en
aluminio los escalones no son enteros limpios (**de memoria**). Absorbe XC-04; la forja (XC-01) es su camino de formación; XC-06
viaja con ella a 77 K.

**[corregido 2026-11-12 13:06] Ronda de ataque 1** ([resumen](../../experiments/RONDA_1_2026-11-12.md)): el contacto atómico no sobrevive en aluminio a 1,8 V (un agente, dos fuentes leídas). Los «~10 ns» eran un error: la constante térmica es de 0,5–0,9 µs, con 1,376 µm de óxido bajo met1 (verificado). Con 2,06 mA la línea sube 1–2 K: no hay formación (verificado). El anillo distingue 4,3 / 6,5 / 12,9 kΩ, pero pone ~1,8 V sobre el contacto; con 30–100 kΩ en serie dejaría de ser destructivo (un agente). Conjetura nueva: vacío puenteado por la barrera, si met1 tiene barrera `[?]`. El puente sublitográfico no arranca con menos corriente (un agente).

**[corregido 2026-11-12 19:10] Ronda de ataque 2** ([resumen](../../experiments/RONDA_2_2026-11-12.md)): mapa por material en vez de veredicto. met1: la barrera puentea (20–240 Ω/µm, verificado), estados de decenas de Ω. li (TiN): se calienta, no migra; un cuello de 1 µm llega a ~500–1800 K con 4–8 mA (verificado, horquilla ancha). Contacto sobre poly: sitio de recorte (un agente). El mando enviable es número de drivers y largo del tramo. Lector de baja tensión: ≤ 48 mV en régimen (verificado), 3–4 % de 1 kΩ a 1 MΩ en esquemático (un agente). El anillo con resistencia serie queda descartado como lector.

## 2. Lectura y piso

Anillo con resistencia en serie, en la zona donde mejor resuelve. «lab» = laboratorio de trabajo, sin publicar.

| Cantidad | Valor | De dónde |
|---|---|---|
| Cuanto de resistencia, 1/G0 | 12.906 Ω | `FRONTERAS_FISICAS_1105.md` ficha 2, **cálculo**, lab |
| Último escalón en aluminio | 0,6 a 1,1 G0, con 3 canales; picos de histograma cerca de 0,8; 1,8; 3,0 y 4,0 G0 a 4 K | misma ficha (notas de Scheer; Yanson y van Ruitenbeek citados por Hasmy), **leído por agente** |
| Sensibilidad del lector ahí | +32 % de período por década en torno a 10 kΩ; 83 ps/kΩ en torno a 12,9 kΩ | `NIGHT_SPRINT_2026-11-05.md`, **corrida** de modelo, lab |
| Distinguir 1 G0 de 0,8 G0 | 12,9 frente a 16,1 kΩ: 25 % de ΔR, resoluble en principio | ficha 2, cálculo |
| Duración del régimen sin realimentación rápida | ms o menos | ficha 2 (Strachan: «the least controllable stage») |
| Dispersión del lector entre canales en 10 a 30 kΩ | `[?]` | — |

Señal/piso: el valor se resuelve; lo que no se resuelve es el significado. Un canal en 13 kΩ no dice nada. Y el anillo no lee
durante el pulso (la ruta de formación no es la de lectura): solo ve estados en reposo.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Cualquier resistencia de liner, óxido o contacto puede valer 13 kΩ | Histograma de muchos sucesos; un valor suelto se descarta por defecto |
| Los picos son configuraciones atómicas favorables, no cuantización | En aluminio no se separa ni con histograma (ficha 2). Se anota como límite de la conclusión |
| El pico lo pone el lector (zona de máxima pendiente) o el algoritmo de parada | Control de material: la misma geometría en li1; un pico en el mismo sitio en li1 es instrumento o algoritmo |
| El liner en paralelo tapa el régimen | Predicción previa: en met1 con liner no debe verse nada entre 10 y 30 kΩ; verlo exige explicar el liner |
| Dispersión de canal a canal | Canales de calibración con resistencias conocidas en esa zona |

## 4. Referencia convencional (control científico, no filtro)

Una resistencia de poly de 13 kΩ (`res_high_po`, 300 Ω/□, **leído por agente**): estable, con modelo y elegida por máscara. Como
patrón de resistencia el contacto atómico no gana, porque en aluminio el escalón no es entero. Solo tendría sentido como
conmutador que cicle entre dos estados con pocos átomos, y eso pide el precursor reversible que no existe. El chip puede concluir
aquí, sin coste, que lo convencional gana.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (lab): ficha con las fuentes y el veredicto.
2. Pendiente: escribir qué sería un precursor que cicle. Candidato: cabezas simétricas con corriente en los dos sentidos (EFLD-01
   ya tiene DIR), que es la hipótesis D de XC-01; sin evidencia.
3. Pendiente: contar cuántos cuellos idénticos caben; el histograma se puede construir con muchas líneas y una formación cada una,
   en vez de muchos ciclos de una. Es otro estadístico y hay que decirlo.
4. Pendiente: simular el lector entre 5 y 50 kΩ con desajuste, para saber el ancho de pico que el instrumento impone.
5. Pendiente: definir el paso mínimo de formación (un pulso del `ebufn_4` más corto que permita el reloj) `[?]`.
6. Pendiente: leer la fuente original de los histogramas de aluminio; hoy se conoce por cita de terceros.

### 5.2 Configuraciones a dibujar

No añade precursores nuevos: pide réplicas y un control de material sobre los de XC-01. Valores: **propuesta**.

| Barrido | Valores | Pregunta |
|---|---|---|
| Réplicas del cuello B | N `[?]`, tantas como quepan | Histograma de estados en reposo entre 5 y 50 kΩ sobre muchas líneas |
| Material | met1 frente a li1, misma geometría | Control: un pico común a los dos no es conductancia cuantizada del aluminio |
| Largo del cuello | 0,5 frente a 2 µm | Un cuello corto fuerza una sola constricción; uno largo puede dejar varias en serie |
| Ancho del cuello | 0,14 (mínimo legal) frente a 0,28 µm | ¿El paso por pocos átomos depende de la sección inicial? |
| Cabezas simétricas con dos sentidos | sí frente a un solo sentido | ¿Invertir la corriente devuelve un estado? Es la condición para ciclar |
| Capa sin liner conocido | met2 o met3 si su pila difiere `[?]` | Quitar el camino en paralelo que tapa el régimen |

Primero un canal: el mismo canal B de XC-01. Esta familia no justifica área propia antes de ver sus trayectorias.

### 5.3 En silicio

1. **Virgen y calibrar:** los de XC-01, más canales de calibración entre 5 y 50 kΩ.
2. **Transformar:** formación de XC-01 con el paso más fino disponible y lectura tras cada pulso.
3. **Observar:** todos los valores de resistencia en reposo de todos los canales, acumulados en un histograma; anotar cuántos
   pulsos se detuvieron entre 10 y 30 kΩ.
4. **Repetir:** en los canales con dos sentidos, invertir y volver; contar ciclos logrados.
5. **Retener:** un estado entre 10 y 30 kΩ, ¿dura minutos, horas?
6. **Clasificar:** sin sucesos en la zona; sucesos sin estructura; picos reproducibles ausentes en li1 (candidato); fallo de lector.

Vehículo que espera: uno con realimentación de microsegundos y lectura durante el pulso (híbrido con pin analógico), y frío para
estabilizar el contacto. En el digital solo se recoge el histograma de reposo.

### 5.4 Criterio de muerte (borrador)

- **Positivo (candidato, nunca prueba):** picos reproducibles en el histograma de reposo, con cientos de sucesos `[?]`, ausentes
  en el control de li1 y en los canales de calibración.
- **Negativo informativo:** ningún suceso se detiene entre 10 y 30 kΩ en N canales con el paso más fino: sin realimentación rápida
  el régimen no se atrapa.
- **Inconcluso:** pocos sucesos; picos también en li1.
- **Fallo instrumental:** los canales de calibración de esa zona no se separan.
- **Sigue como expediente** mientras no haya precursor que cicle. Lo sacaría de ahí un canal que vaya y vuelva decenas de veces.

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

- Depende de XC-01 (precursor, formación, permiso) y de XC-02 (control de material).
- No pide área propia: reutiliza los canales de XC-01 y sus datos.
- Estadística: con un solo chip, el histograma sale de las réplicas del dado.
- Palabra «cuantizada» fuera de cualquier contrato hasta tener histograma y control.

## 8. Abierto y fuentes

- Si la inversión de corriente repara un hueco en esta pila `[?]`.
- Si alguna capa de metal de SKY130 carece de liner conductor `[?]`.
- Ancho de pico que impone el lector `[?]`.
- Laboratorio, sin publicar: `FRONTERAS_FISICAS_1105.md` ficha 2 (Scheer, Hasmy, Strachan, con sus enlaces).
- **Comprobación de citas del 2026-11-12** ([`docs/READING.md`](../../docs/READING.md)): no se encontró electromigración hasta contacto atómico con el lazo integrado en CMOS ni en aluminio de un chip; solo oro con control externo. La cifra de tres canales y 0,8 cuantos para aluminio solo está confirmada en fuentes secundarias.
