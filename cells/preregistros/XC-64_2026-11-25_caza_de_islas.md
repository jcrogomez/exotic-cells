# XC-64 · caza de islas legales: cuatro paseos por reglas donde podría vivir algo no convencional

Escrito el 2026-11-25 13:13 EST (`date`), **antes** de escribir las sondas o de correr nada. Familia:
[`cells/xc64_rule_walk/PLAN.md`](../xc64_rule_walk/PLAN.md). Herramienta: [`residual/drc_edge`](../../residual/drc_edge/README.md).
Es una corrida de comprobaciones de reglas (Magic y KLayout). No dice nada eléctrico y nada es silicio.

## Por qué islas

El precheck de Tiny Tapeout rechaza el ancho y la separación por debajo de la regla en metal, li y difusión
([`experiments/precheck_map`](../../experiments/precheck_map/README.md)): "más allá de la regla" casi nunca se puede enviar.
Lo que sí existe son **islas**: valores legales aislados dentro de una zona prohibida, porque la legalidad no es monótona. XC-20
es una: p+ y n+ son legales a separación exactamente 0 y desde 0,27 µm, y nada en medio. Una isla es una geometría que la
fábrica acepta y que la biblioteca no usa: el sitio natural de la tercera región, y de lo más cuántico que este proceso puede
dar (uniones abruptas, barreras, canales con dos umbrales).

## Pregunta

¿Hay más islas como la de XC-20 en estas cuatro familias de geometría?

| Sonda | Geometría | Dimensión que camina | Qué sería si hay isla |
|---|---|---|---|
| `tfet_n` | nfet 0,42/0,15 con fuente n+ y, al otro lado, n+ de largo d seguido de p+ (toma de sustrato) contactada | d de 0,40 a 0 µm | d = 0: puerta entre n+ y p+, un diodo con puerta: la capa de inversión contra p+ es una unión túnel **controlada por puerta** |
| `tfet_p` | lo mismo en pozo n: pfet con p+ y, al otro lado, n+ (toma de pozo) | d de 0,40 a 0 µm | ídem, polaridad opuesta |
| `vt_edge` | nfet W = 1,0, L = 0,15 con la parte baja del canal en lvt y la alta estándar | borde lvt de 0 a 1,0 µm | un transistor con dos umbrales en paralelo en el mismo canal |
| `well_edge` | tira n+ contactada fuera del pozo que entra en un pozo n | lo que entra, de −0,50 a +1,00 µm | n+ que cruza el borde del pozo: unión lateral n+/pozo/sustrato de varios terminales |

Paso de 5 nm (10 nm en `vt_edge` y `well_edge`). **Enviable** = 0 violaciones en Magic `drc(full)` **y** 0 en el deck de
fabricación de KLayout, que son las dos comprobaciones de DRC del precheck (como en `precheck_map`).

## Controles

- **`pn_space`** (ya en el repo): debe repetir la isla conocida: legal en 0 y desde 0,270 µm.
- **`m1_width`** (ya en el repo): debe repetir un borde único en 0,140 µm, sin islas. Es el testigo de que el método no inventa islas.

## Predicciones (apuestas mías; una predicción falsa aquí es un hallazgo)

| # | Predicción |
|---|---|
| K0 | Los dos controles repiten sus resultados |
| K1 | `tfet_n`: un solo intervalo legal, d ≥ d_min con 0,20 ≤ d_min ≤ 0,40 µm. **Sin isla en d = 0** |
| K2 | `tfet_p`: lo mismo |
| K3 | `vt_edge`: ilegal en todo punto interior; legal solo en los extremos (todo lvt o todo estándar) |
| K4 | `well_edge`: legal solo mientras la tira queda fuera del pozo con su separación; ilegal en cuanto toca o entra |

## Qué se hace con lo que salga

- **Isla enviable encontrada** (K1–K4 falsa): entra como candidata a escalera de XC-64, con su prerregistro eléctrico aparte. Antes de
  creerla: mirar el GDS de ese punto y confirmar que la geometría es la que dice la sonda, y que Magic la extrae como un dispositivo.
- **Legal en una herramienta y no en la otra:** se anota; no es enviable por el precheck.
- **Nada:** estas cuatro geometrías no dan islas, y se dice.
- **Inválido si:** falla K0.

**Límites:** cuatro geometrías de las muchas posibles; una dimensión libre cada vez; Magic no puede representar p+ *debajo* de la
puerta, así que `tfet` se para en d = 0. Que el DRC acepte una forma no dice que el proceso la fabrique como se dibuja, ni qué hace.

SHA en `experiments/xc64_hunt/PREREG_SHA256.txt`.
