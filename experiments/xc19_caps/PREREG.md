# XC-19 · Condensadores reales y calibración independiente — prerregistro

Escrito el **2026-11-13 21:36:16 EST** (`date`), antes de correr ninguna simulación ni de dibujar nada de esta etapa.
Todo es modelo (ngspice de `hpretl/iic-osic-tools:2025.07`, sky130A `8afc8346`, tt, 27 °C). Ninguna trampa: el salto se inyecta.

## Lo ya sabido (de lo que se deduce la predicción)

- Canal extraído y anotado, tres en serie, 133 fF ideales por nodo: 29,2975 µs (A) y 29,2972 µs (B)
  (`cells/xc19_channel/channel_sim.txt`). Salto 0,80 % por 0,305 mV (`cells/xc19_bias/README.md`).
- nfet 4 × 4 µm como condensador en A: 27,2434 µs (`cells/xc19_channel/explore_moscap.txt`). Con el nodo propio de ~2,3 fF
  (`cells/xc19_read/README.md`), eso equivale a 0,930 × 135,3 − 2,3 ≈ **123,5 fF efectivos**, 7,7 fF/µm² promediado sobre la
  excursión 1,8 → 0,9 V. C_ox de la tarjeta: `toxe = 4,148 nm` → 8,32 fF/µm² (aritmética).
- La tarjeta `nfet_01v8` tt tiene `igcmod = 0` e `igbmod = 0`: **la fuga por la puerta no está en el modelo**. Toda fuga del
  condensador MOS que salga en simulación es cero por construcción.
- MiM `cap_mim_m3_1`, tt: 2,00 fF/µm² de área y 0,19 fF/µm de perímetro, lado eficaz = dibujado − 0,025 µm (tarjetas del PDK).
  El modelo es un condensador lineal más resistencias: tampoco tiene fuga.
- Tiny Tapeout (`tt-support-tools` 01d5d28, el del precheck local): `met5` es capa prohibida; `capm.drawing` y
  `capm2.drawing` están en la lista de capas válidas; la capa superior de proyecto es `met4`; los proyectos digitales llevan
  la red de alimentación en franjas verticales de met4 cada 38,87 µm (`FP_PDN_VPITCH` de nuestros `config.json`).
  Consecuencia: `cap_mim_m3_2` (placa superior en met5) queda fuera; `cap_mim_m3_1` (met3/capm/met4) pasa el filtro de capas,
  pero choca con las franjas de met4 si el macro va dentro del flujo digital `[?]`.
- Baldosa 1×2: 161,00 × 225,76 µm = 36 347 µm² (`tech/sky130A/tile_sizes.yaml`).
- Retroceso del lector sobre VB: 0,076 mV a 1 pF, 0,016 mV a 10 pF, 0,006 mV a 30 pF (N3, cuatro en serie, sin
  condensador añadido); 0,005 mV a 10 pF con tres en serie y 133 fF (`experiments/xc19_noise`, N8c).

## Predicciones

| # | Cantidad | Predicción | Razón |
|---|---|---|---|
| C1 | Área de MOS cap para que el tiempo iguale al de 133 fF ideales | 17 a 18 µm² (p. ej. 4,3 × 4,0 µm) | 133/7,7 = 17,3 µm² |
| C2 | Tiempo post-layout del canal con los dos MOS cap dibujados | 29,3 µs ± 3 % | dimensionado por C1; el cableado añade < 1 fF |
| C3 | Acuerdo A/B post-layout, sin desajuste | < 0,1 % | celda simétrica |
| C4 | Salto por 0,305 mV con el MOS cap frente al ideal | 0,80 % ± 0,02 puntos | t = ∫C(V)dV / I: con I casi constante la no linealidad de C cancela en ΔI/I |
| C5 | Fuga del condensador | 0 en simulación por construcción; el salto pierde un 10 % si la fuga real supera 0,6 nA, es decir 3,5·10⁻³ A/cm² sobre 17 µm² | dilución I/(I + I_fuga) con I = 5,5 nA; densidad real a 4,1 nm y 1,8 V `[?]` |
| C6 | MiM equivalente a 133 fF | 8,0 × 8,0 µm dibujado (64 µm²), unas 3,7 veces el área del MOS cap | densidad 2,0 frente a 7,7 fF/µm² |
| C7 | 10 pF como MiM | 70,6 × 70,6 µm, 4977 µm², 13,7 % de una baldosa 1×2, y cruzaría al menos una franja de met4 | aritmética |
| C8 | 10 pF como nfet con la puerta en VB ≈ 0,48 V | capacidad por área entre 20 y 50 % de C_ox → 2400 a 6000 µm² | 0,48 V está cerca del umbral: depleción, no inversión |
| C9 | 10 pF como varactor `cap_var_lvt` (acumulación) a 0,48 V | al menos 60 % de C_ox | acumulación con V_puerta − V_pozo = +0,48 V |
| C10 | Hundimiento de VB cuando dispara una etapa (canal de tres en serie, 133 fF), filtro ideal | 1 pF: 0,02 a 0,08 mV; 10 pF: 0,002 a 0,01 mV; sin filtro: > 0,2 mV | escala ~1/C desde N3 y N8c |
| C11 | Interacción: cambio del tiempo de A entre "B dispara a la vez" y "B quieto" | 10 pF: < 0,01 %; 1 pF: < 0,05 % | ídem |
| C12 | Filtro mínimo que cumple interacción < 0,08 % (una décima de salto) y hundimiento < 0,03 mV | ≤ 2 pF | C10 y C11 |
| C13 | Calibración por inyección de carga: Cc entre X y una línea CAL que conmuta 1,8 V durante la descarga | Δt/t = Cc·1,8 V / Q_nodo; para 0,8 % hace falta Cc ≈ 0,53 fF con 135 fF lineales. Simulado: dentro de ± 10 % de 2·Cc/C_ef con la Cc extraída | carga conocida por cociente de capacidades, sin pasar por la trampa ni por la corriente |
| C14 | Dependencia de C13 con el instante del flanco (entre 2 y 20 µs tras soltar) y con su sentido | < 10 % entre instantes; flanco de subida y de bajada simétricos dentro de 10 % | la carga inyectada no depende de cuándo, mientras sea antes del cruce |

## Qué mata cada parte

- **Condensador MOS (C1–C4):** si con el área de C1 el tiempo post-layout cae fuera de ± 5 % del ideal o A/B difieren más de
  0,1 %, el componente dibujado no es el que se modela. Si el salto se sale de 0,78–0,82 %, la no linealidad importa y se
  pasa a MiM.
- **Filtro (C8–C12):** si ninguna realización cumple el criterio de C12 en menos del 25 % de una baldosa 1×2, el filtro no es
  la solución y hace falta un seguidor o lectores que no conmuten a la vez.
- **Calibración (C13–C14):** si Δt/t se aparta más de un 20 % de 2·Cc/C_ef, o cambia más de un 10 % con el instante del
  flanco, la inyección no es un escalón conocido y no sirve como calibración.
- **Layout:** cualquier violación en Magic (`drc(full)`) o en el deck completo de KLayout con front-end deja la celda sin
  terminar, aunque simule.

## Controles

- El canal con 133 fF ideales (`channel_sim.sp`) en el mismo deck que cada variante.
- Calibración: la misma celda con la línea CAL quieta (sin flanco), para separar la carga añadida por Cc de la inyectada.
- Interacción: B mantenido en precarga frente a B disparando.

## Lo que no se prueba aquí

Salida digital (inversor y contador dibujados), pines, LEF, alimentación del macro, integración en el flujo, hilo real de X al
inversor, Monte Carlo de desajuste con los condensadores, ruido con los condensadores. Fuga real de los condensadores en silicio.
