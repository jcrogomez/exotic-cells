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
