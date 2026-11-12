# Preregistros

Un preregistro por experimento, escrito y fechado **antes** de correrlo. Nombre: `XC-nn_AAAA-MM-DD_tema.md`. Contiene: hipótesis,
predicción numérica, controles, sensibilidad del instrumento, criterio de abandono y qué resultado sería positivo, negativo
informativo, inconcluso o fallo instrumental. El commit que lo añade debe ser anterior al commit de los resultados.

Un preregistro no se edita después de correr. Las correcciones van en un archivo nuevo que cita al anterior.

| Archivo | Familia | Estado |
|---|---|---|
| [`XC-19_2026-11-11_etapa_inversion_debil.md`](XC-19_2026-11-11_etapa_inversion_debil.md) | XC-19 | Corrido el 2026-11-11: [`experiments/xc19_weak_inversion`](../../experiments/xc19_weak_inversion/README.md). 4 predicciones cumplidas, 2 falladas, 1 abierta |

La auditoría de `experiments/lod_audit/` tenía su predicción escrita antes de correr, pero en notas de trabajo sin commit público
previo: no cuenta como preregistro bajo esta regla.
