# Preregistros

Un preregistro por experimento, escrito y fechado **antes** de correrlo. Nombre: `XC-nn_AAAA-MM-DD_tema.md`. Contiene: hipótesis,
predicción numérica, controles, sensibilidad del instrumento, criterio de abandono y qué resultado sería positivo, negativo
informativo, inconcluso o fallo instrumental. El commit que lo añade debe ser anterior al commit de los resultados.

Un preregistro no se edita después de correr. Las correcciones van en un archivo nuevo que cita al anterior. Lo que se corre
después de ver un resultado, sin predicción previa, se rotula exploratorio y cuenta como pista, no como prueba.

| Archivo | Familia | Estado |
|---|---|---|
| [`XC-19_2026-11-11_etapa_inversion_debil.md`](XC-19_2026-11-11_etapa_inversion_debil.md) | XC-19 | Corrido el 2026-11-11: [`experiments/xc19_weak_inversion`](../../experiments/xc19_weak_inversion/README.md). 4 predicciones cumplidas, 2 falladas, 1 abierta |
| [`XC-19_2026-11-11_etapa_completa_y_polarizacion.md`](XC-19_2026-11-11_etapa_completa_y_polarizacion.md) | XC-19 | Corrido el 2026-11-11: [parte 2](../../experiments/xc19_weak_inversion/README.md). 6 predicciones cumplidas, 3 falladas; el criterio 4 se alcanzó con el gemelo preregistrado |
| [`PLAN_2026-11-11_noche.md`](PLAN_2026-11-11_noche.md) | XC-12, XC-16, XC-19 y herramienta de borde | Corrido la noche del 11 al 12: N1 [celdas estándar](../../experiments/stdcell_lod/README.md), N2 [borde DRC](../../residual/drc_edge/README.md), N3–N5 [parte 3](../../experiments/xc19_weak_inversion/README.md), N6 [celda](../xc19_read/README.md). N7 no corrido. Fallaron: el signo de N1, el acuerdo entre decks de N2, el retroceso y el cascodo de N3, el cociente de N4 y la capacidad de N6 |
| [`XC-19_2026-11-11_ruido_y_deteccion.md`](XC-19_2026-11-11_ruido_y_deteccion.md) | XC-19 | Corrido la noche del 11 al 12: [ruido y detección](../../experiments/xc19_noise/README.md). Se alcanzó el criterio de abandono del punto de trabajo de 81 pA; el punto revisado cumple sus predicciones |
| [`XC-19_2026-11-17_transferencia_alimentacion.md`](XC-19_2026-11-17_transferencia_alimentacion.md) | XC-19, instrumento | Corrido el 2026-11-17: [`experiments/supply_transfer`](../../experiments/supply_transfer/README.md). 6 predicciones cumplidas. Sin commit previo al de los resultados: escrito 12:11, corrido 12:12 del mismo día, en la misma sesión |
| [`MISFIT-01_2026-11-17_integracion_fisica.md`](MISFIT-01_2026-11-17_integracion_fisica.md) | Instrumento | En curso: [`instrument/misfit01`](../../instrument/misfit01/README.md). Corridos los tres brazos: A1 falla, como se predijo; A2 y B pasan los seis criterios y sus controles negativos (A2 al segundo intento, B al tercero). Dos enmiendas, cada una antes de correr el brazo al que toca. N2 cumplido solo en subida. Fase 2 sin correr |
| [`MISFIT-02_2026-11-17_celda_de_tiempo.md`](MISFIT-02_2026-11-17_celda_de_tiempo.md) | Instrumento | Corrido el 2026-11-17: [`instrument/misfit02`](../../instrument/misfit02/README.md). 6 de 7 predicciones cumplidas; P3 falla por abajo (las capacidades añaden 1 %, no 2–15 %); P5 cumple en tt y falla en la esquina más rápida. Etapa 2 corrida. Sin commit previo al de los resultados |

La auditoría de `experiments/lod_audit/` tenía su predicción escrita antes de correr, pero en notas de trabajo sin commit público
previo: no cuenta como preregistro bajo esta regla.
