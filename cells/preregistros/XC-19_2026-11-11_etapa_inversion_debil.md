# Preregistro · XC-19 · presupuesto de la etapa en inversión débil (solo modelo)

Escrito el 2026-11-11 21:23 EST (hora de `date`), antes de correr cualquier simulación de la etapa.

**Qué es y qué no es.** Es el dimensionado, con los modelos del PDK, de un lector capaz de ver un salto de umbral del tamaño
de una carga atrapada. **No es una demostración de una trampa individual.** Los modelos del PDK no contienen trampas
discretas: el salto se emula desplazando la tensión de puerta. Un resultado favorable solo dice que el instrumento podría ver
una trampa si existe; no dice que exista.

## Etapa

Un `nfet_01v8` mínimo (W/L = 0,42/0,15 µm) descarga un nodo de capacidad C desde VDD hasta el umbral de un inversor; el
tiempo de descarga t = C·ΔV/I se cuenta en digital. La puerta se polariza a Vg fijo en inversión débil (Vg = 0 incluido: fuga
pura, sin circuito de polarización). Un gemelo de gran área (4,2/1,5 µm), mismo esquema, es el control: una carga atrapada
allí desplaza el umbral 100 veces menos.

Tamaño del salto emulado: ΔVth = q/(C_ox·W·L) = 0,305 mV (cálculo de hoja de carga, cota de orden de magnitud).

## Predicciones (antes de correr)

| # | Magnitud | Predicción | De dónde sale |
|---|---|---|---|
| P1 | Factor de pendiente subumbral n | entre 1,3 y 1,6 | valor típico de bulk CMOS |
| P2 | Sensibilidad ΔI/I por salto, con Vg al menos 0,2 V bajo el umbral | entre 0,73 % y 0,90 % | ΔVth/(n·kT/q) |
| P3 | Sensibilidad por encima del umbral | menor que 0,4 % | deja de ser exponencial |
| P4 | Corriente a Vg = 0, 27 °C | entre 1 pA y 1 nA | conjetura débil |
| P5 | Coeficiente térmico de I a Vg = 0 | entre 5 y 10 %/K | fuga subumbral |
| P6 | Deriva térmica del cociente DUT/gemelo con 17 mV de desajuste de umbral | ≈ 0,16 %/K | ΔVth/(n·kT/q)/T |
| P7 | Ruido de disparo por medida con C = 10 fF, ΔV = 0,9 V | ≈ 0,42 % | 1/√(C·ΔV/q), 56 000 electrones |

Consecuencia de P2 y P7 que se comprobará: la relación señal/ruido acumulada en un tiempo τ es ≈ 0,008·√(I·τ/q) y no depende
de C. Para 5 σ hacen falta 3,9·10⁵ electrones: 6 ms a 10 pA, 63 µs a 1 nA.

## Criterios de abandono de la etapa en flujo digital

La etapa, tal como está, se da por inviable sin pines analógicos si ocurre cualquiera de estos:

1. La sensibilidad es menor que 0,4 % en toda polarización donde la corriente del DUT supere 100 veces la fuga competidora
   (3,2 pA, tomando 32 fA de fuga del nodo a 27 °C de nuestras notas de lectura por precarga).
2. La ventana de tiempos de residencia observables (entre el mínimo que da 5 σ y T_obs/20 con T_obs = 100 s) es menor que
   dos décadas.
3. El cociente DUT/gemelo deriva más de medio salto (0,4 %) con ±1 K.
4. La sensibilidad a la alimentación exige una estabilidad de VDD mejor que 0,1 mV para medio salto.

## Controles previstos en silicio (no se prueban aquí)

Gemelo de gran área en etapa idéntica; lectura diferencial; el mismo DUT a dos polarizaciones y dos temperaturas (las
residencias de una trampa cambian con ambas; el ruido de alimentación no); canal sin DUT para la fuga del nodo.
Criterio de detección ya fijado: histograma bimodal con separación mayor que 5 σ y residencias exponenciales.

## Lo que se estimará sin predicción

Probabilidad de que un dispositivo tenga una trampa con residencia dentro de la ventana. Se estimará a partir de los
parámetros de ruido 1/f de la tarjeta del modelo, con supuestos declarados. La densidad de trampas de SKY130 no está medida
por nosotros: el resultado será un cálculo, no un dato.
