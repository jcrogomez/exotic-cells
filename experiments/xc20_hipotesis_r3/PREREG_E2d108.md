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
