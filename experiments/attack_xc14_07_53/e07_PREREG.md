# e07 — Prerregistro de XC-07 (ruptura de óxido, antifusible, filamento XC-08)

Hora de `date`: Fri Nov 13 07:16:20 EST 2026. Escrito al reanudar el ataque (cortado el 2026-11-12 ~22:40 por falta de créditos), ANTES de correr nada.
Las predicciones P-E1, P-E2 y P-F1 ya están fijadas en `e14_PREREG.md` (22:33:58 del 12-nov) y no se reescriben aquí.
Leído entre aquel prerregistro y este: página de specs analógicas de Tiny Tapeout; reglas de antena de SkyWater (readthedocs);
resumen de Carrère et al. (ST, ECS 203); primera página de Bersuker et al. (SEMATECH, IRW 1997); texto de las diapositivas
de EE311 Stanford (sin figuras); resultados de búsqueda sobre ley de potencia (Wu, IBM; exponentes 40–45, solo fragmento).
Esto puede haber contaminado las predicciones nuevas de abajo; las de `e14_PREREG.md` no.

## Qué se calcula
- e07_tddb.py: t_BD(63 %) del óxido de 4,15 nm a 1,8 / 2,5 / 3,3 / 4 / 5 / 6 V y áreas 0,1–1000 µm², con tres modelos
  (E, 1/E, ley de potencia) anclados a un mismo punto de referencia, escalado de área con Weibull β barrido 1,2–2,
  y la ambigüedad de V_ox (banda plana y agotamiento del poly: 0–0,9 V restados). Salida: intervalos.
- Repaso de antifusibles y filamento (sin corrida).

## Predicciones nuevas (además de P-E1/E2/F1)
- P-E3. La dispersión entre modelos a 3,3 V supera 4 décadas en t_BD; a 5 V es < 2 décadas (cerca del ancla).
- P-E4. Ventana útil para una celda de mesa (t_BD entre 1 ms y 1 h en 1–100 µm²): V_puerta entre 4,5 y 6,5 V. Sin bomba
  (≤ 3,3 V del raíl, o ~3,9 V por el pin analógico) no se alcanza en ningún escenario E; sí, quizá, en ley de potencia extrema.
- P-E5. Con una bomba que dé ≥ 6 V a µA, XC-07 se forma (ruptura blanda segura; dura solo si la corriente límite y la
  energía almacenada lo permiten): R tras ruptura blanda 10⁵–10⁸ Ω a 1 V; tras dura 1–20 kΩ.

## Qué la mata / qué la deja viva
- Muere como experimento de una tesela si a la tensión máxima alcanzable (bomba, ver e53) el t_BD mediano es > 10⁴ s en
  todos los modelos y áreas enviables. Vive si en algún escenario hay ventana [1 ms, 1 h].
- XC-08 (emisor) muere en esta plataforma si la operación pide > 4 mA o > 3,3 V sostenidos (límite del pin y del raíl).

## Tautologías
- La relación entre modelos es arbitraria lejos del ancla: el intervalo crece con la distancia en V al punto anclado; no
  es resultado.
- t_BD ∝ A^(-1/β): pasar de 1 a 100 µm² acorta 10^(2/β) veces (10–50×), con independencia del modelo.
