# XC-19 · simulador de discriminación · enmienda 3

Cita el original (`3d830f1e…87ca`) y las enmiendas 1 (`83957459…df72`) y 2 (`9565e226…bf96`). Escrita a partir de las 17:50 EST
(`date`). **Ninguna celda que decide (D1, D2, PD1–PD5) se ha corrido.** Lo único corrido es la prueba de humo de T1 con 300
dispositivos ([`humo_T1_v1.txt`](../../experiments/xc19_discrim/humo_T1_v1.txt)).

## Qué pasó

Con E_A tal como estaba escrito en `run_ea.py` (media móvil de 5 conversiones y dos pasos de signo opuesto), T1 dio una detección
de 0,023, frente a ≥ 0,95. Falsos: 0,000. Según §10, ese E_A es un **benchmark inválido**, y se reporta así.

La causa es el estimador, no el testigo. A fa = 1 kHz una trampa con τ = 1 ms cambia de estado en ~43 % de las conversiones
(p = (1 − e⁻²)/2), y una media móvil de 5 la borra. Comprobado a mano: el testigo sigue siendo identificable. Cada conversión
separa los dos niveles por 11,3 cuentas, con un ruido de A − B de ~2,2 cuentas (disparo de los dos lados más cuantización), así
que el histograma tiene dos picos. El testigo se copió de N8c, que tenía conversiones seguidas cada 30 µs; el estimador no se
adaptó a 1 kHz.

## Cambio

| # | Cambio |
|---|---|
| C1 | **E_A v2:** detección por mezcla. A la serie y de cada dispositivo se ajusta, por EM, una mezcla de dos gaussianas con varianza común, frente a una sola gaussiana. "Detectada" si se cumplen las tres condiciones: ΔBIC > 10, separación de medias ≥ 3 σ y peso del componente menor ≥ 2 %. Una trampa lenta, de pocos cambios, también da dos poblaciones. El resto de E_A (D2 por tabla aprendida, bits, IC) no cambia |
| C2 | T1, T2, M1–M4 y PD1–PD5 no cambian. Antes de correr las celdas que deciden se repite la prueba de humo de T1 con E_A v2. Si falla otra vez, se para y se reporta, sin nuevas revisiones del estimador en esta sesión |
