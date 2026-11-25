# MISFIT-08 · dieta del núcleo: sin el contador común (prueba B3 del plan)

Escrito el 2026-11-25 12:29 EST (`date`), **antes** de escribir el RTL nuevo o de correr nada. Plan:
[`docs/MISFIT_PLAN.md`](../../docs/MISFIT_PLAN.md). Motivo: en un tile 1×1 cada µm² que suelte el núcleo se suma a la franja libre.

## Cambio

Hoy el motor de medida tiene un contador común `t` de 24 bits y dos capturas, `count_a` y `count_b` (72 de los 142 flip-flops
del bloque). Variante **lean**: se quita `t`; `count_a` y `count_b` cuentan ellos mismos mientras su lado corre y se paran al
cruce. En tiempo agotado o aborto, el lado que no cruzó vuelve a 0, como hoy. Mismo mapa de registros, mismos puertos.

## Pregunta

¿Es la variante indistinguible del núcleo actual desde fuera, y cuánta área ahorra?

## Explicaciones aburridas y su chequeo

| Aburrida | Chequeo |
|---|---|
| Las 13 pruebas cocotb pasan porque no ejercitan lo que cambió | **Equivalencia ciclo a ciclo:** los dos núcleos con el mismo estímulo aleatorio (escrituras, lecturas, cruces de xa/xb, abortos, desarmes, resets), comparando todas las salidas en cada ciclo |
| La equivalencia pasa porque el banco no compara de verdad | **Mutante:** una variante lean con un error de una cuenta (se para un ciclo tarde). El banco debe fallar con ella |
| El estímulo aleatorio no llega a los casos raros | Se cuentan y se exigen mínimos: medidas terminadas, tiempos agotados, abortos, lecturas de los contadores, medidas con A y B a la vez |
| El ahorro en síntesis genérica no se traslada a celdas reales | El área se mide con el flujo completo de MISFIT-06 (`ctl` como referencia), no con el conteo de Yosys |

## Predicciones

| # | Predicción |
|---|---|
| L1 | Las 13 pruebas cocotb pasan con el núcleo lean, sin tocar las pruebas |
| L2 | Equivalencia: 0 discrepancias en 5 semillas × 2 000 000 de ciclos, con al menos 1000 medidas terminadas, 100 tiempos agotados, 100 abortos y 1000 lecturas de contadores por semilla |
| L3 (mutante) | El banco de equivalencia detecta el mutante en las 5 semillas |
| L4 | Flip-flops del bloque: de 142 a 118 |
| L5 | Área de celdas tras el flujo completo (sin relleno ni tomas): baja entre 5 % y 12 % frente a `ctl`; DRC 0, LVS 0, tiempos sin violaciones |

## Sigue / muere / inválido

- **Sigue** (el lean sustituye al núcleo en el tile 1×1): L1, L2 y el flujo limpio. El ahorro medido se reporta tal cual.
- **Muere:** cualquier discrepancia en L2, o una prueba cocotb que falle.
- **Inválido si:** falla L3 (el banco no ve un error de una cuenta) o no se alcanzan los mínimos de cobertura de L2.

**Límites:** equivalencia por simulación aleatoria, no prueba formal. El RTL verificado en MISFIT-04 no se toca: el lean vive en
`instrument/misfit08/` hasta que Juan decida sustituirlo. No se reduce todavía la altura del bloque (eso es otra corrida).

Tope: 20 min por paso, con el `timeout` dentro del contenedor. SHA en `experiments/misfit08/PREREG_SHA256.txt`.
