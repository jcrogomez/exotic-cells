# XC-58 · Celda kT/C

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-58 de [catálogo](../../README.md#catalogue) (kT/C cell).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Alta del 2026-11-12, salida del mapa del espacio de diseño
([`../notas/MAPA_ESPACIO.md`](../notas/MAPA_ESPACIO.md)). Sin atacar todavía: ningún número de aquí está verificado.

## 0. Primeros principios

Celda vacía del mapa: térmico → eléctrico como azar. Al abrir un interruptor sobre un condensador C queda congelada una tensión aleatoria de varianza kT/C, sin importar la resistencia. Con C = 2,3 fF (el nodo de `xc19_read`, **corrida**) a 300 K: 1,34 mV eficaces (**cálculo**), unos cuatro pasos del lector de XC-19 (0,305 mV → 0,83 %): cerca del 3,6 % de dispersión del tiempo por muestra. Con 10 pF: 20 µV. La escala la pone la constante de Boltzmann.

**Regiones.** Convencional: nodo grande, el ruido de muestreo es despreciable y se ignora. Tercera: nodo de pocos fF, donde cada muestreo es un número aleatorio gaussiano de varianza conocida y proporcional a T. Fallo: la inyección de carga del interruptor domina y deja de ser aleatorio.

## 1. Ficha

**XC-58 · Celda kT/C.** Ruido térmico congelado al muestrear → puerta de un transistor en inversión débil aislada por un interruptor mínimo → muestreo repetido → dispersión del tiempo de descarga → fuente de azar con varianza fijada por kT/C, y termómetro primario (la varianza es proporcional a T si se conoce C) → el lector de XC-19 con un interruptor en la puerta → mismo lector con la puerta sin muestrear (ruido propio del lector) y con condensador 10 y 100 veces mayor (la varianza debe caer como 1/C).

**[corregido 2026-11-12 13:57]** Lo que cuenta es la capacidad total del nodo de **puerta** (transistor, interruptor, hilo), no los 2,3 fF del nodo de descarga que cité. Presupuesto en [`experiments/xc58_ktc_budget`](../../experiments/xc58_ktc_budget/budget.txt) (**cálculo**, con el piso del lector de las corridas): con 1 fF en la puerta, 2,0 mV y 5,5 % de dispersión; con 10 fF, 1,75 %; con 100 fF iguala al piso del lector (0,57 %). La ley 1/C se puede barrer de 1 a 300 fF. Conocer la varianza al 1 % pide 20 000 conversiones (~0,6 s), y un 1 % de varianza son 3 K. Es ruido clásico de muestreo: no se presenta como fenómeno cuántico. Si se sacan bits, la entropía se estima con la metodología NIST SP 800-90B (ya en `docs/READING.md`), no mirando si salen equilibrados. Diseño mínimo: tres capacidades, un canal sin muestrear (ruido del lector) y un canal con señal determinista (offset e inyección del interruptor). Consecuencia para XC-19: su puerta no debe muestrearse nunca; su nodo de descarga ya lleva 0,15 % de este ruido en cada precarga, bajo el de disparo.

**[corregido 2026-11-12 19:54] Ronda de ataque 3** ([resumen](../../experiments/RONDA_3_2026-11-12.md)): vive como fuente de azar y como medidor de capacidades de 1–30 fF; **muere como termómetro primario**. La tensión congelada sí es proporcional a T, pero el observable (dispersión relativa del tiempo) va como T^(−1/2) porque la ganancia en inversión débil baja con T (verificado). Nodo mínimo ~0,9 fF; varianza ~0,9 de kT/C por el solape del interruptor (verificado). El interruptor desplaza el punto de trabajo y alarga la conversión; control en el mismo nodo: retener sin remuestrear frente a remuestrear (un agente). Como generador de azar ya hay antecedentes publicados (un agente).

**[corregido 2026-11-12 22:31]** «Muere como termómetro» era demasiado fuerte. Lo que no está demostrado es un termómetro **primario** (independiente de calibración: exigiría conocer C, y el observable va como T^(−1/2), no como T). Una sensibilidad térmica **secundaria**, calibrada, sigue por evaluar: −0,17 %/K en la dispersión relativa (verificado). **Referencia para XC-19:** las dos celdas comparten lector y registro temporal y dan estadísticas distintas a propósito: aquí, ruido continuo y aproximadamente gaussiano que escala con 1/C; allí, niveles discretos con tiempos de residencia. Con la misma instrumentación, XC-58 es el control que dice qué aspecto tiene una fluctuación que **no** es una trampa.

**[corregido 2026-11-12 22:34] Análisis de las simulaciones terminadas** ([`c58b_ANALISIS.md`](../../experiments/attack_xc58/c58b_ANALISIS.md), un agente, sin verificar salvo donde se dice).

| Estado | Evidencia |
|---|---|
| Fenómeno simulado | Sí, con reservas: dos Monte Carlo de la misma clase dan 0,90 de kT/C **en varianza** en el nodo mínimo (coinciden con el verificador a ±0,01). La simulación de ruido en ngspice **no es fiable**: su fuente inyecta ruido espurio tras el corte y, corregida, da ~0,50, sin explicación |
| Señal detectable | Solo en simulación: 5,4 % de dispersión a 1 fF y 1,75 % a 10 fF contra un piso de 0,57 % |
| Función posible | Fuente de azar; medidor de capacidades de 1–30 fF; sensibilidad térmica secundaria (−0,29 a −0,34 %/K en varianza; 1 K en ~10 s a 10 fF); control de ruido continuo para XC-19 |
| Función demostrada | Ninguna |

Temperatura, 27 → 85 °C, contra la predicción ideal escrita antes: la tensión eficaz sube ×1,09 (se cumple, casi por construcción); la dispersión relativa del tiempo baja ×0,92 a 3 fF y ×0,91 a 10 fF (se cumple), pero **sube ×1,02 en el nodo mínimo**, donde la ganancia cae menos de lo previsto y la fuga añade un 4 %: sin explicar. Las corridas de ngspice a 85 °C son deterministas, sin ruido. Correlación: «antes» y «después» son del mismo ciclo; sale ≈ 0 porque el interruptor sigue conduciendo ~200 ps tras empezar el flanco y el nodo se reequilibra; la autocorrelación entre muestras sucesivas es +0,006 ± 0,023. Entropía: los «6–11 bits» eran min-entropía ideal de la cuenta de un contador supuesto a 50 MHz; con 256 símbolos el tope es 8, y con un comparador binario, 1. Sin hacer: ruido en ngspice a 85 °C, ruido del lector con la puerta flotante, variantes con compensador y ficticio, y el control retener frente a remuestrear.

## 2. Lectura y piso

El lector de XC-19: 0,83 % por 0,305 mV, con ruido de disparo propio de 0,55 % por conversión (**corrida**). Señal esperada: ~3,6 % eficaz por muestra con 2,3 fF (**cálculo**): por encima del 1 % y del ruido del lector.

## 3. Explicación aburrida y controles

Inyección de carga y acoplo del reloj del interruptor: son deterministas (desplazan la media, no la varianza). Ruido de alimentación: gemelo muestreado a la vez. Ruido de disparo del lector: canal sin muestrear. La prueba es la ley 1/C y la proporcionalidad con T.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Simulación de ruido transitorio del muestreo (S10), como `experiments/xc19_noise`: ¿sale la varianza kT/C y cuánto añade el interruptor?
2. Capacidad real del nodo con el interruptor, extraída.
3. Es una extensión mínima de `xc19_read`: un interruptor más.

### 5.2 Configuraciones a dibujar

Propuesta: condensador de nodo de ~2, 20 y 200 fF (ley 1/C); interruptor nfet mínimo, pfet y puerta de paso; con y sin transistor ficticio de compensación de inyección.

### 5.3 En silicio

Histograma de tiempos por canal; varianza frente a C; varianza frente a temperatura (calefactor en chip); autocorrelación entre muestras (debe ser nula); pruebas de aleatoriedad sobre los bits.

### 5.4 Criterio de muerte (borrador)

Muere si la varianza no sigue 1/C o si las muestras sucesivas están correlacionadas más allá de lo que explique el lector.

## 6. Documentación para graduarse

- [ ] Hoja de primeros principios revisada por un ataque independiente
- [ ] Mapa de regiones por simulación física, con sus barridos
- [ ] Prerregistro con predicción numérica y criterio de abandono
- [ ] Generador de layout por script, parametrizado
- [ ] DRC en Magic y KLayout, y resultado del precheck (qué pasa y qué no)
- [ ] Extracción y LVS dispositivo a dispositivo
- [ ] Simulación contra la predicción, con su control
- [ ] Macro: pines en metal, LEF con obstrucciones, alimentación
- [ ] Datos de silicio, crudos y con su control
- [ ] Contrato: modelo, interfaz, límites, variabilidad, retención, modos de fallo, condiciones de formación
- [ ] Referencia convencional, donde ayude a identificar el mecanismo
- [ ] README en inglés

## 7. Compuertas y dependencias

Usa el lector de XC-19 tal cual. Referencia convencional: el biestable metaestable (XC-33) como otra fuente de azar.

## 8. Abierto y fuentes

- Capacidad parásita real del nodo con interruptor `[?]`.
