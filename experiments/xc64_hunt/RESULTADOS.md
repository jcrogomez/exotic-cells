# XC-64 · caza de islas legales: resultados

## 1. Cuatro sondas elegidas a mano (2026-11-25 13:25 EST)

Prerregistro: [`XC-64_2026-11-25_caza_de_islas.md`](../../cells/preregistros/XC-64_2026-11-25_caza_de_islas.md). Números:
`analiza.py` → [`islas.txt`](islas.txt). Sondas en `probes/`. Solo comprobaciones de reglas; nada eléctrico, nada de silicio.

**Controles (K0): cumplidos.** `pn_space` repite la isla de XC-20 (legal en 0 y desde 0,270 µm) y `m1_width` un borde único en
0,140 µm, sin islas.

| Sonda | Enviable (Magic y KLayout de fabricación) | Predicción | Veredicto |
|---|---|---|---|
| `tfet_n`: puerta entre n+ y p+ | solo d ≥ 0,300 µm | un intervalo, sin isla en 0 | cumplida |
| `tfet_p`: lo mismo en pozo n | solo d ≥ 0,300 µm | ídem | cumplida |
| `vt_edge`: canal mitad lvt | solo los extremos (todo lvt o todo estándar) | ídem | cumplida |
| `well_edge`: n+ que cruza el borde del pozo | solo fuera del pozo, a ≥ 0,340 µm | ídem | cumplida |

**Ninguna isla nueva.** Reglas que cierran cada camino: `tfet`, "el nFET no puede tocar difusión P" (diff/tap.3), poly.6 (toma
pegada a menos de 0,30 µm de la puerta) y poly.7; `vt_edge`, lvtn.3a (FET a menos de 0,36 µm de LVTN); `well_edge`, diff/tap.9.

**Lo que sí se ve, y no es nuevo:** en las cuatro, el deck de fabricación de KLayout no reporta nada en los puntos que Magic
rechaza (muestreo de 1 de cada 8). Es el hueco ya anotado en `residual/drc_edge`: ese deck no trae esas reglas. No hace enviable
nada: el precheck corre también Magic.

**Límite:** cuatro geometrías elegidas por mí no son una caza. Por eso la parte 2.

## 2. Caza sistemática por parejas (2026-11-25 13:32 EST)

Prerregistro: [`XC-64_2026-11-25_caza_sistematica.md`](../../cells/preregistros/XC-64_2026-11-25_caza_sistematica.md). `pares.tcl` →
`pares.csv` (156 escaneos, 12 792 comprobaciones de Magic, 2 min) → `analiza_pares.py` → [`pares.txt`](pares.txt).

- **Testigo:** la isla de XC-20, (pdiff, nsubdiff) en pozo a separación 0, aparece. Benchmark válido.
- **Predicción ("exactamente cuatro islas"): FALSA por el criterio escrito.** Salen las cuatro esperadas y 16 más.
- **Lo aburrido, comprobado:** las 16 están en un contexto que ya es ilegal por sí solo (difusión en el pozo equivocado). Mi
  criterio ("limpio si no añade reglas a las del punto lejano") las deja pasar. Con el criterio corregido de la
  [enmienda 1](../../cells/preregistros/XC-64_2026-11-25_caza_sistematica_enmienda1.md) (solo se toleran reglas de presencia de toma),
  aplicado **después** y declarado así, quedan **exactamente las cuatro** (`cruces.txt`, primera sección):

| Contexto | Pareja | Qué es |
|---|---|---|
| pozo n | pdiff + nsubdiff | la unión de XC-20: p+ pegado a n+ (toma) |
| sustrato | ndiff + psubdiff | la misma, polaridad opuesta: n+ pegado a p+ |
| pozo n | mvpdiff + mvnsubdiff | la misma en dispositivos de alta tensión |
| sustrato | mvndiff + mvpsubdiff | ídem, polaridad opuesta |

Las cuatro son legales solo a separación exactamente 0.

## 3. Caza por cruce de bordes (2026-11-25 13:32 EST)

`cruces.tcl` → `cruces.csv` (264 escaneos, 13 728 comprobaciones) → `analiza_cruces.py` → [`cruces.txt`](cruces.txt).

- **Testigo:** metal 1 a caballo del borde de una difusión queda limpio en los 49 puntos. La caza vale.
- **Predicción ("ninguna pareja fuera de las de metal, li y poly/pozo"): FALSA por la letra**: 8 parejas no esperadas.
- **Lo aburrido:** las 8 son un artefacto de mi diseño. Todas llevan `nwell` como una de las dos formas y están en el contexto
  "dentro de un pozo": un pozo pintado dentro de otro pozo no tiene borde. No hay nada a caballo.
- **Lo que sí dice:** ninguna forma de difusión, toma o poly queda limpia a caballo del borde de otra. En particular, una puerta
  que no cruza del todo la difusión no es legal.

## Lectura de las tres cazas

1. **Con formas rectangulares de dos capas, las reglas de Magic no dejan más islas que la familia de XC-20**, que resulta tener
   cuatro miembros y no uno. Es un resultado negativo con un positivo dentro: el Túnel se puede dibujar en cuatro variantes.
2. **"Más allá de la regla" no es enviable por el precheck** en nada de lo probado. El paseo por la regla, en silicio y por esta
   vía, llega hasta la regla y a las islas, no más lejos.
3. **Lo que queda sin cazar**, y es donde seguiría: (a) **formas**, no separaciones: puertas en anillo, puertas con codo,
   difusión con muesca bajo la puerta, esquinas; (b) lo legal que **se imprime distinto** de como se dibuja, justo en el valor
   de la regla; (c) estructuras de tres capas con contactos; (d) las reglas que **ninguna** herramienta comprueba.

## Fallos míos en estas cazas

- Dos criterios de "limpio" mal pensados (uno relativo, que tolera contextos ilegales; un contexto degenerado en la tercera).
  Los dos se vieron en los datos antes de creer ningún hallazgo.
- La columna de tipos de `cruces.csv` salió vacía (la orden de Magic no devuelve nada en modo por lotes).

## ¿Qué explicación aburrida no descarté?

Que Magic y el deck de KLayout no sean lo que decide en la fábrica. Todo esto mide qué aceptan dos programas, no qué se fabrica.

## 4. Caza de formas (2026-11-25 21:33 EST)

Prerregistro: [`XC-64_2026-11-25_caza_de_formas.md`](../../cells/preregistros/XC-64_2026-11-25_caza_de_formas.md). Sondas en `formas/`;
`analiza_formas.py` → [`formas.txt`](formas.txt). Los tres controles pasan (el transistor corriente de cada sonda es enviable).

| Sonda | Enviable | Predicción | Veredicto |
|---|---|---|---|
| `step_gate`: escalón de la difusión caminando a través de la puerta | solo con el escalón fuera: ≥ 0,250 µm antes de la puerta o ≥ 0,075 µm después | nunca debajo | cumplida |
| `hole_gate`: isla de óxido dentro del canal | solo sin hueco | **enviable desde 0,27 µm** | **FALSA** |
| `bent_gate`: puerta en L | solo con el codo sobre el campo | ídem | cumplida |
| `ring_gate`: puerta en anillo | nunca | nunca | cumplida (sin control propio) |

**Una sola regla cierra las cuatro:** poly.11, "No bends in transistors". Magic la aplica a cualquier canal que no sea un
rectángulo: un escalón de la difusión bajo la puerta, un hueco, un codo, un anillo. Al hueco lo cierra además diff/tap.2 (cada
camino alrededor de la isla es un transistor de menos de 0,42 µm de ancho).

**Mi apuesta fallida:** creí que un hueco de óxido bajo la puerta era solo "poly sobre campo" y que bastaba respetar la
separación de difusión. No conté con que el canal deja de ser un rectángulo.

## Lectura de las cuatro cazas

Por la vía del precheck de Tiny Tapeout, en SKY130:

- **El espacio de formas legales de un transistor es el rectángulo.**
- **La única isla es la unión pegada**, en cuatro variantes (dos polaridades, baja y alta tensión).
- Lo exótico enviable está en: las islas; lo que ninguna herramienta comprueba (antenas, XC-14); y lo legal que se imprime
  distinto de como se dibuja. Lo demás pide una exención de la fundición u otro vehículo.

Es un mapa negativo, y es un mapa: dice dónde no gastar área y dónde preguntar. **Pregunta nueva para Tiny Tapeout:** si un macro
puede llevar una violación de DRC de Magic declarada y aceptada (por ejemplo poly.11) cuando el deck de fabricación no la marca.
