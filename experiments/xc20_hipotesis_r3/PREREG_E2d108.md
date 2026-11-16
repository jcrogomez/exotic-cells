# Prerregistro corto · diseño E2 + d108 (1,08 µm sin 0,54 µm)

Escrito el 2026-11-16 09:30 (`date`), **antes de correr**. Se commitea antes de la primera corrida. No es la ronda 4: es una
fila que faltaba en la tabla de aportes de la ronda 3 (`INFORME.md` §7, «1,08 µm sin 0,54 µm: `[?]`»). Origen: revisión externa
pegada por Juan el 2026-11-16; la corrida es barata (~1 min por fila) y no decide nada por sí sola.

## Pregunta

¿Cuánto aporta 1,08 µm sobre K cuando no hay 0,54 µm? Es decir, I(K; Y_108 | Y_E2), que hoy no conocemos. Con ella se puede
repartir el valor de las dos separaciones en los dos órdenes (Shapley de dos componentes):

- φ(0,54) = ½ · [(E3 − E2) + (E4 − E2d108)]
- φ(1,08) = ½ · [(E2d108 − E2) + (E4 − E3)]

## Estimador y condiciones (sin cambios respecto de la ronda 3)

- Verificador de la ronda 3, `verificacion/ver3_correr.py`, mismos mundos (entrenamiento semilla 1001, prueba 2000), H = 128,
  8 épocas, semilla de red 1, C3b. Nuevo diseño `E2d108` = E2 + `d108`, definido en `ver3_correr.py` igual que `E2sin27`.
- Filas: W1 A2, W1 S10, W2 A2, W2 S10. Etiqueta `d108`.
- Advertencia que se mantiene: cada aporte es resta de dos cotas inferiores de Barber-Agakov y no certifica la ganancia
  verdadera. El ± es error de Monte Carlo pareado.

## Predicción (de papel, con lo que ya sabemos)

La hipótesis del verificador (§6 de su informe, conjetura): d054 vale porque lee G + B sin túnel; cualquier celda de unión sin
túnel daría lo mismo. Con q en 0,5–1,5, el túnel en 1,08 µm es aún menor que en 0,54 µm, así que d108 también lee G + B.

- **H1 (sustitución):** en W1 A2, E2d108 − E2 en I(Kbin|túnel) queda dentro de ±0,02 bits de E3 − E2 (+0,093). Predicción
  puntual: +0,09.
- **H2 (F con decaimiento):** en W2, donde la fuga convencional cae con d (λF), d108 sola lee menos F que d054. Predicción:
  E2d108 − E2 en I(s_F) **menor** que E3 − E2 (+0,047 en A2), y en I(Kbin) algo menor que +0,094 (entre +0,06 y +0,094).
- **H3 (orden):** φ(0,54) > φ(1,08) en W1 y en W2, con A2.

## Criterios

- **H1 muere** si |(E2d108 − E2) − (E3 − E2)| > 0,03 bits en W1 A2. Si muere, «cualquier celda sin túnel sirve» es falsa
  dentro del modelo, y la elección entre 0,54 y 1,08 importa por sí misma.
- **H2 muere** si en W2 A2 d108 sola da ≥ +0,047 en I(s_F).
- **H3 muere** si φ(1,08) ≥ φ(0,54) en W1 A2 o en W2 A2.
- **Fila inválida** si E2d108 − E2 < −2σ − 0,005 en cualquier cantidad (viola monotonía: E2 ⊂ E2d108), o si E4 − E2d108 lo hace.
- Ningún resultado cambia la decisión de dibujar 0,54 y 1,08 (ya tomada) ni consolida la ronda 3.

## Resultados · 2026-11-16 09:34 (`date`)

Corridas: `verificacion/ver3_log_W1_d108p.txt` (W1, pareada: 300 000 / 100 000 por clase, como las filas base) y
`verificacion/ver3_log_W2_d108.txt` (W2). Tabla completa: `incremento_separaciones_salida.txt`, sección «E2 + d108».

**Incidencia antes del resultado.** La primera corrida de W1 (`ver3_log_W1_d108.txt`) usó los valores por defecto de
`ver3_correr.py` para 5 clases (240 000 / 60 000), no los 300 000 / 100 000 que las corridas originales fijaron por entorno.
Su mundo de prueba es otro y no está pareada con E2, E3 y E4: **no se usa**. Se conserva. El error venía de `REGENERAR.md`,
que no fijaba esas variables; corregido.

| Cantidad, A2 | E3 − E2 (0,54 sola) | E2d108 − E2 (1,08 sola) | φ(0,54) | φ(1,08) |
|---|---|---|---|---|
| W1, I(Kbin \| túnel) | +0,093 | **+0,090** ± 0,001 | +0,052 ± 0,001 | +0,048 ± 0,001 |
| W1, I(M) | +0,037 | +0,046 | +0,019 | +0,028 |
| W2, I(Kbin \| túnel) | +0,094 | **+0,038** ± 0,001 | +0,090 ± 0,001 | +0,033 ± 0,001 |
| W2, I(s_F) | +0,047 | +0,044 | +0,042 | +0,039 |

Ninguna fila viola la monotonía.

**Veredictos, con las palabras de arriba:**
- **H1 (sustitución) se cumple.** En W1 A2, 1,08 µm sola da +0,090 frente a +0,093 de 0,54 µm sola: diferencia 0,004 (≤ 0,03).
- **H2: no muere por su criterio** (I(s_F) de 1,08 sola = +0,044 < +0,047), **pero su predicción sobre K falla:** predije
  +0,06 a +0,094 y salió +0,038.
- **H3 se cumple en los dos, pero en W1 es casi un empate:** φ(0,54) − φ(1,08) = +0,004 en W1 y +0,056 en W2.

**Lectura (modelo, no silicio; restas de cotas inferiores, no certificadas):**
- **Con mecanismos exclusivos (W1), las dos separaciones son intercambiables.** Cualquiera de las dos sola da ~0,09 bits sobre
  K, y juntas apenas suman (+0,100). Lo que importa es tener *una* celda de unión sin túnel, no cuál.
- **Con fuga convencional que coexiste con el túnel y decae con d (W2), 0,54 µm no es intercambiable.** (En W1 la fuga F
  también decae con d, pero nunca coexiste con el túnel.) 1,08 µm sola da menos de la mitad sobre K
  (+0,038 frente a +0,094). Conjetura: lejos, la fuga convencional ya cayó, y 1,08 µm no sirve de referencia para lo que hay en
  0,27 µm; 0,54 µm está más cerca y sí.
- Esto da a «0,54 µm prioritaria» una razón más precisa que la que tenía: es prioritaria **si la fuga convencional coexiste con el túnel
  y depende de la separación**. Si no, cualquiera de las dos sirve.
- 1,08 µm conserva su papel de referencia lejana: su Shapley en I(s_F) en W2 es casi igual al de 0,54 µm (+0,039 frente a
  +0,042).

Nada de esto cambia la decisión de dibujar las dos, ni consolida la ronda 3.

## Añadido exploratorio · 2026-11-16 10:17 · solapamiento entre separaciones (no prerregistrado)

Propuesto por una revisión externa pegada por Juan, después de ver los resultados. Se calcula, no se juzga contra nada.

R = I(K;A|Y0) + I(K;B|Y0) − I(K;A,B|Y0), con A = 0,54 µm, B = 1,08 µm, Y0 = E2. R > 0 es redundancia (las dos dicen lo mismo);
R < 0 sería sinergia. Pareado sobre los mismos chips (`incremento_separaciones_salida.txt`, sección «Solapamiento»):

| A2 | R sobre K | R sobre el mecanismo | R sobre s_F |
|---|---|---|---|
| W1 (exclusivos) | +0,083 ± 0,001 | +0,036 | — |
| W2 (simultáneos) | +0,008 ± 0,001 | +0,012 | +0,009 |

- En W1 casi todo lo que aporta una separación lo aporta también la otra: son referencias redundantes.
- En W2 los aportes son casi aditivos (R ≈ 0): cada distancia dice algo distinto sobre una mezcla con forma espacial.
- **Ningún R es negativo:** en este modelo no hay sinergia entre las dos separaciones.
- Mismas reservas que todo §7: combinación de cuatro cotas inferiores; no certifica información verdadera.
