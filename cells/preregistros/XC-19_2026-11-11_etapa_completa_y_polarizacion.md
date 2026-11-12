# Preregistro · XC-19 · etapa completa y polarización (solo modelo)

Escrito el 2026-11-11 21:36 EST (hora de `date`), antes de simular la polarización o la etapa completa. Continúa
[`XC-19_2026-11-11_etapa_inversion_debil.md`](XC-19_2026-11-11_etapa_inversion_debil.md), cuyo resultado fijó la ventana útil de
polarización en 0,25–0,45 V.

**Qué es y qué no es.** Dimensionado con modelos del PDK. El salto de una trampa se emula con 0,305 mV en la puerta. Nada de esto
demuestra una trampa.

## Circuito que se simula

- **Polarización.** Cadena de K transistores `nfet_01v8` conectados como diodo, en serie de VDD a tierra, sin pozos propios ni
  resistencias. La toma inferior (puerta-drenaje del transistor de abajo) es Vb. K se elige en digital. Dos variantes:
  **V1**, todos los transistores de 1/1 µm; **V2**, el de abajo sustituido por 16 transistores iguales al DUT en paralelo (espejo:
  el DUT llevaría 1/16 de la corriente de la cadena). Condensador de filtro de 1 pF en Vb.
- **Etapa.** Un `pfet_01v8` mínimo precarga el nodo a VDD; al soltarlo, el DUT (0,42/0,15 µm, puerta a Vb) lo descarga; un
  `inv_1` de la biblioteca marca el cruce. Se mide el tiempo desde la suelta hasta la conmutación del inversor.
- **Gemelo.** Etapa idéntica con un transistor de 4,2/1,5 µm y el mismo Vb.
- **Referencia convencional** (solo aritmética): divisor de resistencias de poly.

## Predicciones

| # | Magnitud | Predicción |
|---|---|---|
| B1 | Vb de V1 a tt, 27 °C, VDD = 1,8 V | 0,25–0,36 V con K = 5; 0,21–0,30 V con K = 6 (el transistor de abajo recibe entre 0,7 y 1,0 veces VDD/K, por el efecto de cuerpo de los de arriba) |
| B2 | dVb/dVDD con K = 5 | entre 0,10 y 0,25 |
| B3 | Ruido de Vb integrado de 1 Hz a 1 MHz, con 1 pF | entre 50 y 150 µV eficaces (orden de √(kT/C) = 64 µV) |
| B4 | Corriente del DUT entre esquinas (tt, ss, ff, sf, fs) y entre 27 y 85 °C, con K fijo | V1: varía más de 30 veces. V2: no hago predicción; se mide |
| S1 | Capacidad efectiva del nodo (de t·I/ΔV) | entre 1 y 5 fF sin cableado |
| S2 | Cambio del tiempo medido por un salto de 0,305 mV | entre 0,75 % y 0,90 % |
| S3 | Fuga del transistor de precarga apagado, 27 °C | menor que el 10 % de la corriente del DUT en toda la ventana 0,25–0,45 V |
| S4 | Sensibilidad del tiempo a VDD, etapa sola | entre 0,4 y 0,8 % por mV (domina dVb/dVDD) |
| S5 | Sensibilidad a VDD del cociente DUT/gemelo | menor que 0,03 % por mV |

## Criterios de abandono

1. Ningún K entero de 3 a 8 deja Vb dentro de 0,25–0,45 V en las cinco esquinas a 27 °C: la cadena no sirve como polarización.
2. El ruido de Vb supera 6 mV eficaces (lo tolerable con gemelo, según el resultado anterior): la polarización no sirve.
3. A 85 °C la fuga de precarga supera la corriente del DUT en toda la ventana: hace falta otra precarga.
4. El cociente DUT/gemelo cambia más de medio salto (0,4 %) por 10 mV de VDD: la lectura diferencial no rescata la etapa.
5. El inversor no conmuta limpiamente con la rampa lenta (más de una transición por descarga en la simulación): hace falta un
   comparador con histéresis.

## Qué no cubre

Desajuste entre DUT y gemelo, ruido de disparo en transitorio, cableado y parásitos de layout, y el reloj real de la placa. La
resolución del contador se dará como aritmética con un reloj de 50 MHz supuesto `[?]`.
