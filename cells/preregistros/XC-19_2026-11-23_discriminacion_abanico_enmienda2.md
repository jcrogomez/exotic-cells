# XC-19 · simulador de discriminación · enmienda 2

Cita el original (SHA-256 `3d830f1e…87ca`) y la enmienda 1 (`83957459…df72`). Escrita a partir de las 17:48 EST (`date`), **antes
de escribir el simulador**, sin ningún número producido.

| # | Cambio | Por qué |
|---|---|---|
| B1 | El tiempo de cada pata es t_k = t_c · (W/L)_C0 / (W/L)_k: corriente subumbral ∝ W/L, misma VB y mismo nodo. C7 (0,84/0,15) da t_c/2; C8 (0,42/0,60), 4·t_c; C9 (1,68/0,30), t_c/2. El gemelo B es siempre C0 | el §5 daba el mismo t_c a todas las patas: cambiar W/L cambia la corriente |
| B2 | La relación señal/ruido por conversión no depende de t_k: el salto (s_c/A) y el disparo (0,108 %) son fracciones de t. **PD1–PD5 no cambian.** t_k solo entra en la cuantización (cuentas = t_k·50 MHz) y en la factibilidad: una celda con t_k > 0,8/fa no se puede adquirir y se reporta como "no adquirible", no como 0 bits | consecuencia de B1 |
| B3 | La aproximación ∝ W/L ignora el DIBL, el efecto de canal corto y el LOD. Es franja no atribuida de t_k; los veredictos no dependen de ella salvo en ff 85, donde se reporta | honestidad sobre B1 |
