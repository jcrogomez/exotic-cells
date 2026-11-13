# XC-19 · Trampa (RTN)

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-19 de [catálogo](../../README.md#catalogue) (Single trap (RTN)).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-19 · Trampa (RTN).** Captura y emisión en un defecto → nfet mínimo 0,42/0,15 → ninguna, o XC-10 para crear trampas → dos
niveles con residencias exponenciales → bit probabilístico, sensor de una carga → etapa cuya corriente fija un solo MOS en inversión
débil, leída en diferencial → histograma bimodal > 5 σ, residencias que cambian con polarización y temperatura. **Mantener,
prioridad 1.** ΔVth = 0,305 mV; un anillo estándar cambia 6·10⁻⁶ y es ciego; la etapa en inversión débil daría ~0,8 % por salto
(`EFLG00_TRAMPA.md`). Estadístico: N dispositivos `[?]`.

*Estado al 2026-11-12 (corridas en `experiments/xc19_weak_inversion` y `experiments/xc19_noise`, todas modelo):* la etapa está
simulada y dibujada (`cells/xc19_read`). Polarización: cadena de diodos terminada en 16 transistores iguales al DUT. Gemelo de la
misma geometría, no uno largo. Precarga de umbral alto y canal largo. El punto de trabajo de 81 pA y 2 fF se abandona: su ruido
de disparo por conversión iguala al salto. El punto revisado usa 5,5 nA y unos 135 fF. Ninguna trampa demostrada: el salto se
inyecta. *Configuraciones propuestas por la revisión externa del 11-nov, sin evaluar:* lectura con drenaje constante y su efecto
sobre la dinámica de la trampa (el cascodo ya se simuló como circuito, no como física de la trampa); modo de espectroscopia
temporal con secuencias de polarización; matriz LOD × RTN a igual punto eléctrico; intercambio de DUT y referencia entre lectores.

**Replanteo del 2026-11-12.** Familia de defecto único con tres ventanas: trampa de óxido vista por el canal (esta ficha),
defecto de unión visto por la fuga (XC-37), trampas de interfaz contadas por bombeo de carga (XC-43). El bombeo es además la
lectura de XC-52 (espín).

**[corregido 2026-11-12 22:31]** **Control nuevo: XC-58.** Una celda kT/C con el mismo lector y el mismo registro temporal da ruido continuo y gaussiano de varianza conocida; sirve para distinguir en silicio una fluctuación continua de un evento telegráfico de dos niveles. Consecuencia de diseño: la puerta de XC-19 no debe muestrearse nunca (un nodo de 1 fF muestreado lleva 2 mV de ruido, casi siete veces el salto de una carga).

## 2. Lectura y piso

Lector en inversión débil: el dispositivo descarga un nodo y el tiempo se cuenta. Todo es **corrida** sobre modelo, sin silicio.

| Cantidad | Valor | De dónde |
|---|---|---|
| Señal: salto de una carga | 0,305 mV en la puerta (**cálculo**, q/(C_ox·W·L)) → 0,83 % del tiempo | `experiments/xc19_weak_inversion/budget.txt` |
| Ruido de disparo, punto de 81 pA y 2,3 fF | 0,55 % simulado, 0,82 % por conteo de electrones: del tamaño de la señal | `experiments/xc19_noise/shot.txt` |
| Punto revisado, 5,5 nA y 135 fF | 98 % de detección con tres conversiones, sin falsos contra una referencia (modelo de comportamiento) | `experiments/xc19_noise/detect.txt` |
| Canal dibujado y extraído | 29,2 µs, 0,80 % por salto | `cells/xc19_channel/channel_sim.txt` |
| Desajuste | El cociente dispositivo/gemelo se mueve 0,047 % (mediana) por 10 mV de alimentación; 39 de 100 sorteos | `experiments/xc19_weak_inversion/n5.txt` |

Señal/piso: del orden de 1 en una conversión; se gana promediando, a costa del tiempo de residencia más corto que se ve.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Ruido de la polarización de puerta (medio salto son 0,15 mV) | Gemelo de la misma geometría con la misma polarización; solo cuenta lo que no es común |
| Ruido de alimentación (XC-32) | Canal propio de alimentación; el cociente A/B debe ser inmune |
| Deriva térmica (0,16 %/K en el cociente, **corrida**) | Canal de temperatura (XC-31); escala de tiempo distinta |
| Ruido de disparo del propio lector | Estadística: el ruido es gaussiano, una trampa da dos niveles con residencias exponenciales |
| Trampa en el gemelo, no en el dispositivo | Intercambiar dispositivo y referencia entre lectores |
| Retroceso del lector sobre la polarización (0,076 mV a 1 pF, **corrida**) | Condensador de filtro de 10 pF; lectores que no conmutan a la vez |

## 4. Referencia convencional (control científico, no filtro)

Como fuente de bits aleatorios: el biestable metaestable y el jitter de un anillo (XC-33), que caben en celdas estándar. La trampa
solo gana si ofrece algo que esos no: una tasa gobernada por polarización o temperatura, o sensibilidad a una carga. Como sensor
de defectos no hay equivalente en la biblioteca.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho: presupuesto de la etapa, etapa completa y polarización, ruido y detección, contra cuatro prerregistros.
2. Hecho: `xc19_read`, `xc19_bias` y `xc19_channel` dibujados por script, 0 violaciones en los dos decks, extraídos y anotados.
3. Pendiente: dibujar los condensadores (2 × 133 fF y el filtro de 10 pF) y repetir la simulación extraída.
4. Pendiente: terminar el Monte Carlo de desajuste (39 de 100 sorteos).
5. Pendiente: pines en metal, LEF con obstrucciones, y decidir cómo recibe alimentación el macro.
6. Pendiente: integración en el flujo digital (N7 del plan de la noche, no corrido) con el inversor de umbral y el contador.
7. Pendiente: simular el canal con el hilo real de X al inversor, que hoy no está en ningún número.
8. Pendiente: leer una fuente con RTN medido en transistores de 130 nm para acotar amplitudes y residencias `[?]`.

### 5.2 Configuraciones a dibujar

| Barrido | Valores | Pregunta |
|---|---|---|
| Área de puerta W × L | 0,42/0,15 (mínimo); 0,42/0,50; 1,0/0,15; 5,0/0,15 | El salto debe escalar como 1/(W·L): es la prueba de que es una sola carga |
| Réplicas del mínimo | N `[?]`, tantas como quepan | Estadística: fracción de dispositivos con trampa visible (estimación del repo: 0,66 por década de residencia) |
| Tipo | nfet y pfet | Trampas de electrones frente a huecos |
| Largo de difusión | 0,30 y 3,0 µm al mismo punto eléctrico | Matriz LOD × RTN: ¿el esfuerzo cambia la trampa? (liga con XC-12) |
| Lectura | Drenaje libre frente a drenaje constante (cascodo) | Efecto del campo de drenaje sobre la dinámica |
| Vecindad | Junto a un calefactor (XC-31) y lejos | Residencias frente a temperatura sin cámara térmica |

Primero un canal completo (ya dibujado); la matriz solo después de integrarlo.

### 5.3 En silicio

1. **Virgen:** tiempos de descarga de dispositivo y gemelo, todos los canales, a temperatura ambiente.
2. **Calibrar:** escalón conocido en la puerta, condensador de referencia conmutado en el nodo, corriente de prueba. El par LOD
   es comprobación interna, no calibración.
3. **Caracterizar:** series temporales largas por canal; histograma de tiempos; buscar dos o más niveles discretos.
4. **Barrer:** polarización de puerta (0,25 a 0,45 V), temperatura, alimentación. Las residencias de una trampa cambian con las
   dos primeras de forma característica; el ruido no.
5. **Retener y repetir:** el mismo canal otro día; ¿la trampa sigue ahí con la misma amplitud?
6. **Clasificar** cada canal: trampa (bimodal > 5 σ, residencias exponenciales), sin trampa visible, inconcluso, fallo de lector.

No hay transformación. La variante con XC-10 (crear trampas por estrés) es otro plan.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** al menos un canal con dos niveles separados más de 5 σ, residencias exponenciales que cambian con polarización y
  temperatura, y amplitud que escala con 1/(W·L) entre tamaños.
- **Negativo informativo:** ningún canal muestra niveles discretos y el lector, calibrado, habría visto 0,305 mV. Informa solo
  con N conocido y suficiente.
- **Inconcluso:** niveles que no se separan del ruido de polarización o de alimentación.
- **Fallo instrumental:** el escalón de calibración no se ve.
- **Muere** si el lector en silicio no resuelve el escalón de calibración equivalente a una carga.

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

- Es estadística: con un solo chip se sabe poco. Confirmar cuántos chips se pueden pedir.
- Su lector sirve a XC-12, XC-13, XC-37, XC-40, XC-42 y XC-46; si el lector falla, caen todas.
- Necesita XC-31 (temperatura) y XC-32 (alimentación) como canales de control.
- Sin permisos especiales: no hay estrés ni reglas dudosas.

## 8. Abierto y fuentes

- Cómo recibe alimentación un macro con transistores dentro del flujo digital.
- Por qué el ruido de disparo simulado sale un tercio por debajo del conteo de electrones.
- No se encontró ninguna medida publicada de RTN en SKY130 ([pesca](../notas/PESCA_2026-11-12.md)).
- Corridas: [`experiments/xc19_weak_inversion`](../../experiments/xc19_weak_inversion/README.md),
  [`experiments/xc19_noise`](../../experiments/xc19_noise/README.md). Layout: [`xc19_read`](../xc19_read/README.md),
  [`xc19_bias`](../xc19_bias/README.md), [`xc19_channel`](../xc19_channel/README.md). Cifras: [`docs/CLAIMS.md`](../../docs/CLAIMS.md).
