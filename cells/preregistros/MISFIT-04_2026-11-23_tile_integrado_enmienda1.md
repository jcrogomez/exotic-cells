# MISFIT-04 · etapa 1 · enmienda 1

Cita [`MISFIT-04_2026-11-23_tile_integrado.md`](MISFIT-04_2026-11-23_tile_integrado.md) (SHA-256 `c7a0eca8…bb51`, sellado a las
18:19:25). Escrita el 2026-11-23 a partir de las 18:32 EST (`date`). Se escribió después de endurecer el núcleo, cuyas métricas
de flujo no son predicciones de esta etapa. Se escribió **antes** de correr I2. El original no se edita.

| # | Cambio | Por qué |
|---|---|---|
| A1 | I2 se divide en dos partes. **I2a:** el netlist final del núcleo, manejado por los pines con el protocolo, reproduce la tabla E7 escrita a mano en el banco de pruebas (no importada del RTL). Se prueban las **9** combinaciones de (en, pre, s1, s0) alcanzables desde los pines: 0 discrepancias. **I2b:** el módulo `e7_decoder` reproduce esa misma tabla en las 16 combinaciones: 0 discrepancias | Leyendo `misfit_core.v` se ve que con en = 0 el núcleo fuerza src = 00 y pre = 0. Las otras 7 combinaciones no se alcanzan desde ningún pin, así que en el netlist final no se pueden probar sin forzar nodos internos |
| A2 | Observación previa, sin predicción: con el slot armado y el núcleo en reposo, el decodificador apaga la precarga y X queda flotando hasta la siguiente adquisición, que precarga de nuevo. Se mide en I3 (deriva de X en reposo) y se reporta | Encontrado leyendo el RTL; no estaba en el prerregistro |

Sin otros cambios.
