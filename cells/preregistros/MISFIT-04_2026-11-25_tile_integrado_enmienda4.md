# MISFIT-04 · enmienda 4 · cierre de E2, escrita DESPUÉS de las corridas

Escrita el 2026-11-25 11:47 EST (`date`). **No es una predicción: es el registro, con fecha, de las desviaciones de E2 respecto de la
[enmienda 3](MISFIT-04_2026-11-24_tile_integrado_enmienda3.md) y de cómo se cierra.** Las decisiones de abajo las tomó el agente
por encargo de Juan (2026-11-25, "tú decide"); Juan puede revertirlas.

## Desviaciones (todas ya declaradas en los scripts el 2026-11-24)

| Desviación | Dónde | Por qué |
|---|---|---|
| Paso máximo del transitorio de 0,5 ns en vez de 2 ns, e `itl4 = 200`, en los decks de pocas fases | `i4/corre_p5j.sh`, `corre_p5k.sh`, `corre_p5l.sh`, `corre_p5m.sh` | con 2 ns, un deck con pocos relojes no está convergido: su fase de control se aparta de la referencia según qué más haya en el deck; a 0,5 ns la repite |
| El control se aplica **por deck**: un deck cuya fase de control se aparta de `p3.txt` más de 0,001 puntos de % no aporta ninguna fase | `e2/analiza_e2.py` (cambiado después de ver datos; es más estricto que lo sellado) | la enmienda 3 pedía el control de las fases 0, 4, 8, 12 y 16 en conjunto; no preveía decks partidos |
| Decks partidos (de 1 a 5 fases) en vez de uno | `i4/corridas/p5*` | los decks grandes abortan con "timestep too small"; la causa de fondo sigue sin identificar `[?]` |

## Decisiones de cierre

1. **Las fases 1 y 6 de ℓ = 21,6 cuentan.** Salen de `p5j1_0` y `p5j6_0`, rotulados "diagnóstico" al lanzarlos. Tienen la misma
   configuración que los decks válidos y pasan su control. El rótulo era del propósito, no de la validez. Se declara aquí para
   que quien lo lea pueda descontarlas: sin ellas son 17 de 20 fases y el máximo no cambia (está en la fase 11).
2. **La fase 10 queda sin dato.** Dos intentos con control: `p5k10_0` falló el control por 0,00107 frente a 0,001;
   `p5m10_0` (fase 10 con controles 8 y 12, predicción escrita antes en `corre_p5m.sh`) **abortó a los 2 min**. Mi apuesta de
   que terminaría fue falsa. No hay tercer intento, como estaba escrito.
3. **E2 se cierra con 39 de 40 fases** y sus veredictos tal como están en [`e2.txt`](../../experiments/misfit04/e2/e2.txt):
   E2a cumplida, E2b cumplida, control del deck válido.

## Qué deja abierto la fase que falta

- El máximo de ℓ = 21,6 (0,47213 %, fase 11) solo cambiaría si la fase 10 lo superase. Sus vecinas dan −0,2110 % (fase 9) y
  −0,4721 % (fase 11), y los tres decks que la calcularon con control fallado dieron −0,3505 %. **Es un argumento, no una
  medida.** Si la fase 10 fuese mayor, la pendiente subiría y el acoplo mínimo detectable (113,7 aF) bajaría: el número
  publicado sería conservador.
- La causa de los abortos de ngspice en estos decks.
