# xc62_incremental · prerregistro

Escrito el 2026-11-22, empezado a las 09:27:44 EST (`date`), antes de escribir código. Origen: revisión de los papers de diseño
inverso (Karahan et al., Nat. Commun. 15, 10734, 2024; Sun/Zheng et al., arXiv:2501.18054v4, PNGF) y una propuesta externa
pegada por Juan. Esta ronda solo responde la primera mitad de su pregunta: **¿podemos evaluar más geometrías con exactamente el
mismo modelo físico de `c62_litho.py`?** La segunda mitad (elegir un conjunto que separe hipótesis) es la etapa 2, con su propio
prerregistro.

## Qué es y qué no es

- El modelo es el de `../attack_xc60_62_63/c62_litho.py`: Abbe, máscara binaria, 29 puntos de fuente (rejilla 7×7 dentro del
  disco), N = 1024, dx = 5 nm, umbral constante calibrado a línea aislada de 0,15. **Óptica supuesta, sin resina, sin grabado,
  sin OPC.**
- Los cuatro ajustes (NA 0,60/0,70 × σ 0,5/0,8) son **escenarios de iluminación**, no escenarios de OPC. Los escenarios A/B/C de
  OPC de `c62_INFORME.md` no están implementados en ningún código; aquí no se tocan.
- Un evaluador incremental exacto reproduce el modelo; no añade nada sobre el silicio.

## Deducción antes de correr (tautología declarada)

Para cada punto de fuente s, E_s = IFFT[P_s · FFT(1 − M)] es lineal en M, y la FFT es circular. Cambiar la máscara en ΔM cambia
el campo en −(h_s ⊛ ΔM), con h_s = IFFT(P_s). Para una forma fija R colocada en la posición p, la respuesta es la de R en el
origen desplazada circularmente por p. Por tanto la actualización es **exacta en aritmética exacta**; lo único que se mide es
(1) que mi código la implementa bien, (2) el error de redondeo acumulado, (3) el coste. Si T2/T3 fallan, es un bug mío, no
física.

Los observables (L(y) en x = 0 para 43 valores de y en la difusión, retroceso de punta, I/I0, dVeq) solo leen la intensidad
cerca de la puerta. El evaluador calcula E_s solo en una ventana (ROI) alrededor de la puerta. Si un cruce de umbral cae fuera
de la ROI, el evaluador debe **marcarlo y recurrir a la FFT completa**, nunca extrapolar.

## Pruebas y predicciones

| | Prueba | Predicción | Tolerancia (fallo si se excede) |
|---|---|---|---|
| T1 | Mi copia del modelo reproduce `c62_litho.txt` (14 casos × 4 ajustes, mismas columnas, 3 decimales) | idéntica | cualquier diferencia de texto en las filas numéricas |
| T2 | 300 cambios de píxel al azar dentro de una región de diseño, aplicados de uno en uno, contra la FFT completa de la máscara final | error de redondeo | máx. abs(ΔI) en la ROI ≤ 1e-10 (I del orden de 1) |
| T3a | Los 14 casos de `c62_litho.py` construidos por formas desde una base, contra la FFT completa | igual | L ≤ 1e-9 µm; dVeq ≤ 1e-6 mV |
| T3b | 60 geometrías al azar (vecinas, poly de campo, barras a posiciones aleatorias, con o sin legalidad), encadenando movimientos | igual | igual que T3a |
| T4 | Tiempo por evaluación (imagen + observables), completa contra incremental, un ajuste | incremental entre 30× y 300× más rápida | — (medida) |
| T5 | Memoria pico y precálculo por forma | ~0,5 GB por forma a complex128 (29 × 1024² × 16 B); precálculo ≈ una imagen completa | — (medida) |
| T6 | Escala con N (512, 1024) y con el tamaño de la ROI | completa ∝ N² log N; incremental ∝ ROI × 29, independiente de N | — (medida) |

Las formas que se solapan no se suman (la máscara original hace `clip(·, 0, 1)`). Si un movimiento produce solapamiento, el
evaluador aplica ΔM píxel a píxel o recurre a la FFT completa, y lo cuenta.

## Criterios de muerte

- T1 falla → mi copia no es el mismo modelo: me detengo y no reporto nada más.
- T2 o T3 fallan tras descartar un bug → el evaluador incremental queda rechazado. Se sigue con la FFT completa.
- T4 < 3× → no vale la complejidad. Se sigue con la FFT completa y se conserva el resultado negativo.

## Fuera de alcance de esta ronda

Búsqueda de geometrías, objetivo de información, observables de MISFIT con ruido, desajuste y réplicas, y PNGF completo
(AGPL-3.0, ~50 GB de pico en su ejemplo; para XC-27/28 y calor, en otra línea). Nada de esto cambia el ranking ni cierra líneas.
