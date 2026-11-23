# MISFIT-04 · etapa 1 · el instrumento dentro de su propio tile

Escrito el 2026-11-23 a partir de las 18:18 EST (`date`), antes de escribir RTL, scripts o layout de esta etapa. Números de
diseño: [`experiments/misfit04/prereg_calc.py`](../../experiments/misfit04/prereg_calc.py) → `prereg_calc.txt`. El nombre
definitivo del chip lo pone Juan; aquí se llama MISFIT-04.

## 1. Pregunta

¿El núcleo endurecido, con el decodificador E7 sintetizado, y el slot XC-19 dibujado conservan, ensamblados en un tile 1×2 con
su rutado, su red de met4 y la actividad del propio núcleo, el contrato que el slot cumplía aislado? ¿Y qué parte de lo que puede
romper una medida ve de verdad la verificación estándar (DRC, LVS, precheck)?

**Por qué 1×2 y no 1×1** (aritmética de `prereg_calc.txt`): núcleo de 14 013 µm² y slot de 5 569 µm² dejan −1 628 µm² en un 1×1
de 17 955 µm², y bajo el núcleo quedan solo 24,48 µm de alto, frente a los 95,7 µm del slot. En un 1×2 sobran 16 764 µm² en
bruto tras núcleo y slot, para el abanico y la metrología de etapas posteriores. Esta etapa deja ese espacio vacío a propósito: se
valida el método antes de llenarlo.

## 2. Lo que se deduce sin correr nada

- t1. El LVS compara el layout con una referencia. Si la referencia sale del mismo RTL mutado, el LVS **no puede** ver un error
  lógico del decodificador. Por eso la tabla de verdad E7 se escribe a mano, aparte del RTL.
- t2. Ni el DRC, ni el LVS, ni el precheck saben qué nodo es sensible. Una pista legal sobre XA es invisible para los tres por
  construcción. La afirmación interesante no es esa, sino **cuánto pesa en cuentas**.
- t3. Un flanco acoplado con C_c inyecta ΔV = C_c · 1,8 V / C_X en X, con C_X ≈ 149 fF (`INFORME_etapa_a.md` §2). Con
  C_c = 0,1 fF son 1,2 mV, unas 4 trampas. Es una cota por flanco, no por medida: flancos de subida y bajada se cancelan salvo cerca
  del cruce. Esto fija el tamaño del testigo S7.

## 3. Explicaciones aburridas y su chequeo

| # | Explicación | Chequeo |
|---|---|---|
| b1 | La extracción jerárquica pierde el acoplo entre pistas del padre y nodos del macro | Extraer XA y XB en plano y en jerárquico; deben coincidir dentro de 5 % o se usa el plano |
| b2 | El acoplo sale ~0 solo porque el router no entra en el macro | Es diseño, no hallazgo. Por eso existe el testigo S7, que obliga a que haya acoplo |
| b3 | La simulación lógica sin tiempos oculta glitches | I3 se juzga en las **entradas registradas** del decodificador (`slot_en`, `slot_src`, `slot_pre`). Un glitch combinacional exige que cambie una entrada |
| b4 | Reproducir los agresores con fuentes ideales exagera el acoplo | Es conservador: si pasa así, pasa con drivers reales. Si falla, se repite con la celda que maneja la red |
| b5 | Un mutante pasa el LVS porque la referencia se regeneró con él | Las referencias (`top_ref.v` y la tabla E7) se fijan del diseño original y no se tocan en la campaña |
| b6 | El contrato de etapa a cambia por el ensamblaje, no por el acoplo (otra alimentación, otro decodificador) | I4 compara siempre el **mismo** netlist con agresores activos frente a quietos. Solo cambia el agresor |

## 4. Diseño

- `misfit04_core`: `misfit_core` con N = 4 y sin cambios. El slot 0 pasa por `e7_decoder` (RTL nuevo, la lógica de E7), con 13
  salidas al macro y 2 entradas (XA_OUT, XB_OUT). Los slots 1–3 quedan atados, como en MISFIT-02.
- Tile 1×2: el núcleo arriba (161 × 87,04 µm, con la configuración de `misfit02_core_r2` y el pinout inferior nuevo), el macro
  debajo, con risers de metal2 bajo los pines del núcleo y la alimentación en met4, como en MISFIT-02.
- CALA y CALB a GND. VB, XA y XB quedan como nodos internos, sin pin.

## 5. Predicciones (juicio en el modelo; ninguna es de silicio)

| # | Predicción | Forma |
|---|---|---|
| I1 | DRC 0 en el GDS releído (Magic `drc(full)`), LVS "match uniquely" contra `top_ref.v` + núcleo + `ref.spice` del slot, y precheck 1×2 que pasa | binaria |
| I2 | El decodificador del netlist final reproduce la tabla E7 en las 16 combinaciones de (en, pre, s1, s0) | 0 discrepancias |
| I3 | En una adquisición simulada a nivel de puertas, de un ciclo después del flanco de `pre` hasta la captura del último de xa/xb, las entradas del decodificador no cambian | 0 cambios en el slot 0 |
| I4 | Con los agresores reales (cada red con acoplo extraído ≥ 1 aF a XA, XB, XA_OUT o XB_OUT, reproducida con su forma de onda de I3 y flancos de 100 ps), el cociente tA/tB del macro cambia menos del 10 % del salto de una trampa | máx sobre 5 fases del reloj de abs(Δ(tA/tB)) < 0,0807 % (tt 27) · 0,1001 % (ff −40) · 0,0684 % (ss 85) · 0,0631 % (ff 85). Mi apuesta: pasa con un margen ≥ 10× |
| I5 | **Campaña de sabotaje** (tabla de §6): DRC + LVS + precheck detectan S1–S5 (5/5) y **ninguno** de S7–S10 (0/4). I2–I4 detectan S7–S10 (4/4). S6 sin predicción | conteo por clase |

## 6. Sabotajes (mutantes del tile, generados por script desde el ensamblaje sano)

| # | Sabotaje | Clase |
|---|---|---|
| S1 | Tira VPWR del macro sin unir | conectividad |
| S2 | Tira VGND del macro sin unir | conectividad |
| S3 | Falta el riser de SA1B | conectividad |
| S4 | Risers de XA_OUT y XB_OUT cruzados | conectividad |
| S5 | XA en corto con GND (un rectángulo de metal1) | conectividad |
| S6 | Macro espejado en x: A en las posiciones de B | simetría |
| S7 | **Testigo:** pista de metal3 con la red `clk`, sobre la línea de XA y no sobre la de XB | acoplo |
| S8 | Placa flotante de metal3 sobre XA solamente (capacidad pasiva asimétrica) | acoplo |
| S9 | Decodificador mutado: SA2B usa s0 en vez de s0n (en RTL, endurecido de nuevo) | lógica |
| S10 | Núcleo mutado: `slot_src` se actualiza durante la ventana | temporización |

Testigo identificable (regla 5 de la skill): S7 debe dar > 10 × el umbral de I4 a tt. La cuenta de t3 da ~mV por flanco, frente a
0,305 mV por trampa. Si S7 no supera el umbral, **I4 es un instrumento ciego** y el benchmark queda inválido.

## 7. Criterios

- **Sigue si:** I1–I4 se cumplen en el tile sano, los testigos se detectan y la clasificación de I5 queda medida, coincida o no
  con la predicción.
- **Muere** (este estilo de integración, sin blindaje) **si:** I4 falla en el tile sano a tt 27. Entonces hace falta un blindaje
  o una distancia mínima entre el rutado y el macro, y eso es una etapa nueva.
- **Benchmark inválido si:** S7 no se detecta (I4 ciego), algún sabotaje de S1–S5 no lo detecta nada, o b1 da una diferencia
  > 5 % y no se puede extraer en plano.
- El resultado negativo se publica igual. "La verificación estándar no ve 4 de 4 sabotajes de medida" es un resultado. "Los
  ve" también lo es, y mata mi predicción.

## 8. Incertidumbre

- **Epistémica:** el acoplo real depende de cómo rutee LibreLane; la forma de los flancos del núcleo; la extracción de Magic sin
  capacidades laterales finas (`[?]` heredado de `xc19_caps`).
- **Computacional:** 5 fases × 4 esquinas en I4, en lugar de un barrido continuo de fase.
- **Franja no atribuida:** lo que separa una fuente ideal de un driver real (b4), y todo acoplo por sustrato, que Magic no extrae.

Ruido, Monte Carlo y caída de alimentación dinámica (RISKS 2, 9 y 10) **no** entran en esta etapa: son la etapa 2.

## 9. Presupuestos

- **Resolución:** endurecer el núcleo (×2 contando S9 y S10), ensamblar, DRC, LVS y precheck. Unas horas de máquina; el tiempo
  del endurecimiento de MISFIT-02 no está registrado (`[?]`).
- **Auditoría, separada:** 10 sabotajes × (DRC + LVS + precheck), la comprobación plano/jerárquico de b1 y la SPICE de I4 con el
  testigo. No se recorta la auditoría para cumplir la resolución.

Estado: **congelado** al sellar el SHA-256 en `experiments/misfit04/PREREG_SHA256.txt`. Las enmiendas van en un archivo nuevo.
