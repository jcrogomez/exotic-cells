# Tabla de experimentos

Escrita el 2026-11-12 13:57 (hora de `date`). Nota de trabajo. Un experimento por fila: qué se predice, qué se observa, con qué control,
cuánta señal frente al piso, y qué resultado separaría la tercera región de lo convencional y del fallo. **Ninguno está medido en
silicio.** Grado de cada presupuesto: **V** verificado por dos cálculos, **C** cálculo o corrida de una sola mano, **?** sin número.
Las predicciones firmes se escriben en un prerregistro antes de correr; esto es el mapa de qué prerregistrar.

| Familia | Parámetro que cruza las regiones | Predicción | Observable | Control | Señal frente al piso | Convencional / tercera región / fallo |
|---|---|---|---|---|---|---|
| XC-58 celda kT/C | Capacidad del nodo de puerta, 1 a 300 fF | La varianza del tiempo sigue 1/C hasta ~30 fF (5,4 % a 1 fF, 1,75 % a 10 fF) y baja como T^(−1/2) | Histograma de tiempos por canal | Mismo nodo retenido sin remuestrear; tres capacidades; canal sin interruptor | **V**: 1,75 % a 10 fF contra 0,57 % de piso; cruce a ~94 fF | La varianza no depende de C (manda el lector) / sigue 1/C sin autocorrelación / el interruptor o la fuga la dominan |
| XC-20 unión túnel | Separación p+/n+ (0 o ≥ 0,27 µm); temperatura; tensión en los dos sentidos | A separación 0, corriente inversa miles de veces mayor que a 0,27 µm y casi independiente de la temperatura (×1,2–1,8 entre 233 y 358 K) | Curvas en inversa y en directa, a varias temperaturas | Misma unión a 0,27 µm; pozo sin p+; par en espejo | **V** en orden: decenas de nA a decenas de µA a 1,8 V contra 150 fA de piso; el lector actual se satura | Fuga activada térmicamente / túnel inverso, y quizá resistencia negativa a 0,1–0,3 V (abierta) / corto por puente en la frontera |
| XC-52 pares de espín | Campo de −2 a +2 mT; densidad de trampas | La corriente de recombinación cambia de forma par y satura a ~1 mT | Término cruzado de la secuencia de cuatro estados, frente al campo | Devanados sin retorno común; dispositivo sin trampas añadidas; forma ×4 contra aplanamiento | **C**: 3·10⁻⁵ a 4·10⁻⁴ en dispositivos dañados (estimado sobre una figura); en vírgenes **?** | Sin respuesta, o parábola (clásico) / respuesta saturante que crece con las trampas / el acoplo de la bobina tapa la señal |
| XC-25 placa Hall con bobina | Corriente de la bobina, en los dos sentidos | Tensión impar con el campo, lineal | Diferencia entre sentidos | Bobina en modo cancelado | **V** (rango): 0,017 a 0,66 mV por mA a 2,65 mT, contra un paso de 0,305 mV | Es física conocida: sirve para calibrar el campo de XC-52 y XC-60 |
| XC-05 estructura transformada | Temperatura pico: número de drivers y largo del tramo, en met1, li y contacto sobre poly | li: cambio de resistencia al pasar de ~1000 K en un cuello de ≤ 2 µm; met1: escalones de pocos Ω por vacío puenteado | Resistencia leída con ≤ 48 mV, y su histograma en el tiempo | Gemela virgen; tramo largo que no llega a temperatura | **V**: 20–240 Ω/µm de barrera; cuello a ~500–1800 K; lector 3–4 % de 1 kΩ a 1 MΩ (un agente) | Resistencia que no cambia / estados intermedios estables y discretos / abierto |
| XC-62 impresión por proximidad | Vecindad de poly a distancias legales | El umbral cambia con la vecindad más que el desajuste (17,3 mV) si la fábrica no corrige del todo | Corriente en inversión débil contra la gemela aislada | Misma difusión, distinta vecindad; ≥ 16 réplicas | **V**: −1,2 a −1,8 mV/nm; 19–45 nm en el borde sin corrección (óptica supuesta) | Igual que la aislada / corrimiento repetible fijado por el dibujo / puente o corte de la puerta |
| XC-57 Peltier | Sentido y magnitud de la corriente, 10 a 300 µA | Parte de la temperatura cambia de signo con la corriente; enfriamiento neto de décimas de K a decenas de µA | Diferencia de temperatura entre sentidos, síncrona | Cadena con las uniones intercaladas; patas de igual resistencia | **V** en intervalo: 0,2–7 K en la unión a 100 µA; el lector en el silicio ve ~1 % | Solo calor par / componente impar lineal y ventana de enfriamiento / el poly se daña a mA |
| XC-59 escritura y borrado térmico | Estrés aplicado; temperatura y duración del calor | En un elemento de poly entre calefactores, el estado escrito vuelve con calor | Resistencia o umbral tras cada paso del ciclo | Estresado sin calentar; calentado sin estresar | **V**: el poly entre calefactores recibe 70–77 %; un transistor en silicio, 1–16 % (no se recuece en chip) | No se mueve / ciclo repetible / daño que no vuelve |
| XC-60 magnetodiodo | Campo en el plano de una tira de met1; largo del diodo | Respuesta impar con el campo en un diodo corto en pozo | Corriente de sustrato o tensión del diodo frente al campo | Placa Hall del mismo tamaño; tira sin corriente | **V**: ~1 mT con 14 mA; señal 0,05–3 pasos del lector (un agente) | Como una placa Hall / respuesta amplificada por la unión pozo–sustrato / no aplica |
| XC-27 red de hoyos en reflexión | Paso de la red, 0,8 a 1,5 µm; tipo de tapa | La fotocorriente difiere entre tapas a igual distancia | Fotocorriente por precarga | Cinco tapas sobre el mismo par | **?**: depende de que XC-26 emita | Todas las tapas iguales / diferencia que sigue el paso / sin luz detectable |

Las filas de XC-20, XC-05 y XC-52 recogen la ronda 2 ([resumen](../experiments/RONDA_2_2026-11-12.md)).

## XC-58 junto a XC-19: un mismo registro temporal para dos físicas

| | XC-58 | XC-19 |
|---|---|---|
| Origen | Ruido térmico congelado al muestrear | Captura y emisión de carga en un defecto |
| Estadística esperada | Continua, aproximadamente gaussiana, varianza ∝ 1/C | Dos o más niveles discretos, residencias exponenciales |
| Mando | Capacidad, temperatura, periodo de muestreo | Geometría, polarización, temperatura |
| Papel | Control: qué aspecto tiene lo que no es una trampa | La señal buscada |

Las dos usan el lector en inversión débil y el mismo contador. Se diseñan juntas.

## Atlas de regímenes (propuesta para Residual)

Para cada precursor, registrar dónde cambia cualitativamente el comportamiento en el espacio de estímulos y condiciones
(polarización, temperatura, tiempo, campo, frecuencia), no solo un valor: aparición o desaparición de estados estables, saltos
discretos, relajación. Sería el tercer módulo de Residual, después del anotador de esfuerzo y del borde legal.
