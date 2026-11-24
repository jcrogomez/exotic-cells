# MISFIT-03 · etapa b · cálculo de diseño: cuánto ajuste de polarización hace falta

2026-11-24. Sin prerregistro ni veredicto: son números para diseñar el ajuste.
- **Script:** `gen_vb.py`. Fuerza la puerta del DUT de A a VB + desplazamiento en el macro v_hm, variante `trap`, y comprueba
  que `XC19_INC` apunte al v_hm.
- **Corrida:** `corre.sh`.
- **Tabla:** `resumen_etapa_b.txt`.
- **Desviación de lectura, corregida antes de escribir esto:** cuando A no cruza, la línea `VB` trae solo tB y vb. La primera tabla
  tomó ese tB como tA. Ahora esas filas dicen "sin cruce en 1 ms".

## Lo que dice

- **La trampa vale casi el mismo porcentaje con cualquier puerta,** 0,60–1,01 % según la esquina, así que las cuentas
  (trampa × tA × 50 MHz) solo dependen de tA.
- **tA crece ×2,9–3,9 por cada −50 mV de puerta.** Equivale a n·Ut ≈ 37–47 mV.
- **Desplazamiento mínimo para ≥ 10 cuentas**, en la rejilla de 50 mV:

  | Esquina | Desplazamiento | tA | Cuentas |
  |---|---|---|---|
  | tt 27 | 0 | 30,9 µs | 12,4 |
  | ss 85 | 0 | 31,1 µs | 10,6 |
  | ff −40 | 0 | 46,9 µs | 23,4 |
  | ff 85 | **−150 mV** | 60,2 µs | 19,8 |

  En ff 85, −100 mV se queda en 6,7 cuentas.
- **Un VB fijo no sirve para las cuatro esquinas.** Bajarlo 150 mV en todas pondría tt y ss por encima de 1 ms, donde A no cruza
  en la ventana simulada. Hace falta **un ajuste digital de 0 a −150 mV en pasos de ≤ 50 mV (2 bits)**, elegido en el chip con
  la lectura de B: el RTL mide tB y sube o baja el código hasta que tB caiga en una ventana.
- **La toma C1 actual no basta.** Pasar de 3 a 4 diodos baja VB de 0,478 a 0,321 V a tt (`cells/xc19_bias/README.md`): un solo
  paso de ~157 mV, tres veces más grueso que lo que hace falta.

## Sobre el "~10 µs"

El origen del objetivo de ~10 µs sigue sin aclarar (pregunta abierta a Juan). Este cálculo usa el criterio de las cuentas que
ya estaba en el prerregistro: trampa ≥ 10 cuentas, es decir tA ≥ ~31 µs a ff 85.

## Siguiente (sin correr)

1. Diseñar los pasos de ~50 mV sin pines analógicos. Por ejemplo, diodos de la cadena con anchos distintos conmutados, o una
   segunda cadena en paralelo, y verificarlo en las 4 esquinas.
2. Comprobar que el paso de calibración (P4) y la trampa no cambian de forma con el código; aquí solo se movió la puerta del DUT
   de A.

## Cadena de ajuste (`cadena/`, esquemático, `.op`, conexiones ideales sin interruptores)

| Opción | Lo que da | Sirve |
|---|---|---|
| Un diodo extra 1/1 en serie, ancho W de 1 a 64 (`resumen_cadena.txt`) | −120 a −157 mV, sea cual sea W | no: es un salto, no un ajuste fino |
| Más espejos 0,42/0,15 en paralelo, M de 16 a 256 (`resumen_espejos.txt`) | −13 a −21 mV por cada duplicación; −53 a −82 mV con M = 256 | solo, no llega a −150 mV |
| 3 bits: toma C1 (2 o 3 diodos) × M (`resumen_codigos.txt`) | de 0 a −152…−157 mV en las 4 esquinas | cubre ff 85 (−152 mV); **el paso máximo es 32–80 mV**: 80 mV a ff −40 y 60 mV a tt 27, en el hueco entre "2 diodos, M = 128" y "3 diodos, M = 2" |

- El objetivo de ≤ 50 mV por paso no se cumple aún: sobra en el hueco central.
- Rellenarlo con 2 diodos y M = 256, o 3 diodos y M = 1, queda **sin correr**.
- Además, ningún interruptor está modelado: falta su caída y su fuga. Y los espejos extra tendrían que llevar el mismo LOD que el DUT,
  o dejan de copiarlo (la razón de ser de `xc19_bias`).

**v2 de los códigos** (`resumen_codigos_v2.txt`; `gen_codigos.py` reescrito, y la v1 queda en `resumen_codigos.txt`):
- Se añaden 2 diodos con M = 256 y 512, y 3 diodos con M = 1.
- Son 11 códigos (4 bits), de 0 a −152…−157 mV. **El paso máximo es 16–41 mV** en las 4 esquinas: cumple ≤ 50 mV.
- Coste: M = 512 son 512 espejos 0,42/0,15, con área `[?]` y sin dibujar.
- Antes de dibujar falta modelar los interruptores (caída y fuga) y elegir cómo comparten el LOD con el DUT.
