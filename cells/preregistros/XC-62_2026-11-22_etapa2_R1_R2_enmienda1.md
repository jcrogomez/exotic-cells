# XC-62 · etapa 2 · enmienda 1

Cita [`XC-62_2026-11-22_etapa2_R1_R2.md`](XC-62_2026-11-22_etapa2_R1_R2.md) (SHA-256 `caba8458…e2c2`, sellado a las 13:06:17 EST en
`experiments/xc62_etapa2/PREREG_SHA256.txt`). Escrita después de sellar el original y **antes de correr cualquier parte del
experimento** (no existe código de C0–C5 al escribirla). El original no se edita.

| # | Qué cambia | Por qué |
|---|---|---|
| E1 | En R1, las vecinas a más de 1,2 µm de la línea leída también se eliminan, como en R2. El chequeo a2 se aplica además a R1 (0,15; 0,42; 3) | con s = 1,0 y m = 3 las vecinas llegan a 3,75 µm y se envolverían en la caja periódica de 5,12 µm. El original solo truncaba R2: es un hueco del diseño |
| E2 | P1 se mantiene tal cual (R1 0,15; 0,21; m = 3; largo 3 µm). Se añade **P1′**: la geometría exacta de `nb2_021_longcap` (m = 1, largo 3,42 µm) debe dar 1,685 / 1,027 / 1,376 / 1,056 con tolerancia 0,001 | P1 se dedujo de `c62_litho.txt`, cuyo caso tiene una vecina por lado y otro largo. Era un error de deducción mío. P1′ es la comprobación que P1 quería ser; P1 queda como predicción (si falla, falla) |
| E3 | Mutante "objetivo al azar": 20 selecciones voraces con puntajes al azar. Pasa si como mucho 3 de 20 superan el percentil 95 del control al azar (bajo la nula se esperan 1; P(≥ 4) ≈ 1,6 %) | el original no fijaba cómo se juzga un mutante que es aleatorio |
| E4 | Tolerancia de a1 para R1, expresada sobre la lectura: abs(Δr) ≤ 1e-8 | el original la daba en L (1e-9 µm); con r ≈ 1 y w ≈ 0,1–0,25 µm, 1e-9 µm son ≤ 1e-8 en r |
| E5 | Calibración de B: sesgo por borde b ∈ {0, 5, …, 60} nm; se elige el de menor abs(w_imp − 0,150) sobre la línea de referencia, con FFT completa; en empate, el menor | el original decía "se calibra" sin la rejilla ni el desempate |
| E6 | "Señal" del top-K = máx. sobre las hipótesis A y B de abs(μ_h − μ_C) / σ | el original no la definía y las unidades de R1 y R2 difieren |
| E7 | En a9, el desajuste de LOD se mide con `residual/lod_annotate.measure()` sobre rectángulos sintéticos de difusión y puerta (extensión de difusión 0,29 µm); tolerancia abs(Δsa), abs(Δsb) ≤ 1e-9 µm | concreta cómo se aplica la herramienta |
