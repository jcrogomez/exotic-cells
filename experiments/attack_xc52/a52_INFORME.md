# a52 · Informe del ataque a XC-52 (+ XC-56, XC-25)

Hora de `date` al cerrar: 2026-11-12 12:47:09 EST. Prerregistro: `a52_PREREG.md` (12:35 EST, antes de abrir el PDK y la literatura).
Scripts y salidas: `a52_coil.py/.txt`, `a52_parasitos.py/.txt`, `a52_lockin_hall.py/.txt` (cada .txt lleva su hora de `date`).
PDK = `local_flow/pdk_host/ciel/sky130/versions/8afc8346…/sky130A`. Nada de esto está medido en silicio.

Grados: **PDK** (ruta:línea) · **corrida** (script) · **leído** (abrí el texto) · **estimación** (cálculo mío sobre algo leído) ·
**memoria** · `[?]`.

## Veredicto por sub-afirmación

| | Afirmación | Veredicto |
|---|---|---|
| a | La corriente por trampas de interfaz cambia de forma medible a mT, 300 K, en un transistor de SKY130 | **TRANSFORMADA.** El efecto existe en MOSFET de Si a 300 K y a escala sub-mT–mT, pero solo está publicado con 1e11–1e12 trampas/cm² (irradiación o estrés), áreas de 1,9e3–4,1e4 µm² y horas de promediado. En virgen: «ni NZFMR ni EDMR» (leído). Pasa a ser «XC-52 depende de XC-10 (estrés) o de área» |
| b | 5 vueltas, 10 µm, 10 mA → ~3 mT | **SOBREVIVE corregida.** 2,6 mT, no 3,1; y solo con traza ≥ 1,47 µm. Con ancho mínimo el límite de EM en CC son 2,04 mA → 0,52 mT |
| c | Paridad + bifilar separan lo aburrido | **TRANSFORMADA.** La paridad solo quita la inducción. Calor, acoplo capacitivo rectificado y consumo de la alimentación son pares, como la señal. Hacen falta bifilar + blindaje + (f ≥ 1 MHz o topología de potencia constante) |
| d | Bombeo de carga con pulso de 0–1,8 V | **SOBREVIVE** en pfet con pozo propio y cuerpo ≈ 1,3 V (margen ≈ 0,28 V por lado). **MUERE** en nfet sobre sustrato (nunca acumula). Alternativa real: diodo con puerta, con más señal de espín y 1e2–1e4 veces menos corriente |
| e | 1e-4 en milisegundos | **MUERE.** Límite de disparo a 14–16 nA: 0,1 s. Realista (virgen): 10 s a 30 min. Milisegundos solo para 1e-3 con 10×10 µm a 10 MHz |
| f | Placa Hall: ~0,2 mV por mA bajo la bobina | **SOBREVIVE con rango.** 0,15 mV por mA a 2,65 mT (N = 1e17); rango 0,05–0,24. Es medio paso del lector: se lee con 10–50 pares ±B |

## (a) Magnitud real en silicio — ataque principal

| Dato | Valor | Fuente y grado |
|---|---|---|
| Dispositivo con señal NZFMR en Si, 300 K, dc-IV | MOSFET plano, SiO2 7,5 nm, 41 000 µm² (420 dedos de 1×98 µm), irradiado 1 Mrad (la versión publicada dice 500 krad) | Harmon, Ashton, Lenahan, Flatté, arXiv:2008.08121; APL Mater. 14, 101108 (2026). **Leído** (PDF de arXiv; versión publicada vía resumen de WebFetch) |
| Antes de irradiar | «exhibits neither an NZFMR or EDMR response» | ídem, **leído** |
| Escala de campo | hiperfinas ajustadas 0,5 mT (P_b) y 0,15 mT (electrón); «width of one half a milliTesla»; el rasgo ancho se extiende a ±2–3 mT en su fig. 8 | ídem, **leído** |
| Corriente dc-IV en que miden | 5e-9 A (VF 0,30 V) a ~4e-7 A (0,50 V) | ídem, fig. 7a, **leído de la figura** |
| Amplitud pico a pico de la derivada | 0,2 a 1,3 pA/G (rasgo ancho), según VF | ídem, fig. 7b; unidades en el pie de la versión publicada. **Leído de la figura** |
| **ΔI/I** | **≈ 3e-4 (VF 0,30–0,33) → 1e-4 (0,45) → 3e-5 (0,50)** | **Estimación mía**: lorentziana, A = Δpp·Γ/1,30, Γ = 1,2–1,7 mT. Supone que pA/G es derivada verdadera. Incertidumbre ×3. El artículo NO da ΔI/I: solo «a very small fraction» |
| NZFMR por **bombeo de carga** en Si | Demostrado a 1, 3 y 5 MHz, en matrices de 126 MOSFET (15×1 µm cada uno según Sharov, OSTI 1899505), estresados a ~1e12 cm⁻², modulación 210 Hz–1 kHz, «signal averaging on the scale of several hours». Amplitudes normalizadas: ΔI/I `[?]` | Moxim et al., J. Appl. Phys. 135, 155703 (2024), copia NIST pub_id=957288. **Leído** |
| ΔIcp/Icp en resonancia (EDMR por bombeo, no campo nulo) | 1e-7–1e-5; ΔIcp ~pA sobre ~100 nA; a 300 K es menor que a 27 K | Hori y Ono, arXiv:2008.11857 (PR Applied 11, 064064). **Leído** |
| Por qué estresaron | densidad fresca «too low (on the order of 1e9 cm⁻² at room temperature)»; estresan a ~1e11 | ídem, **leído** |
| Dit sin estrés / con estrés | 1,17e10 / 1,1–1,8e12 cm⁻² eV⁻¹ (dc-IV) | Sharov et al., OSTI 1899505, tabla I. **Leído** |
| Sensibilidad absoluta de un espectrómetro NZFMR | «fewer than 1,000 defects» en matrices de MOSFET de Si | Allridge y Lenahan, IIRW 2023 (resumen). **Leído el resumen** |
| NZFMR en fuga por túnel (SILC) | anchuras 5–16 mT según polarización; días de promediado | Sharov, ídem. **Leído** |
| ~1 % | Solo SiC (ya en READING.md). No encontré 1 % en Si | — |

Lo que no encontré: ninguna cifra de ΔI/I escrita en texto para Si a 300 K, y ninguna medida en un MOSFET virgen pasivado.
Cuenta para SKY130 virgen, 10×10 µm: trampas activas en dc-IV ≈ Dit·A·(~0,1 eV) ≈ 1 200 (cálculo), justo en el «< 1 000
defectos» de un laboratorio con electroimán y horas. En 1×1 µm: ~12. La señal relativa no depende del área; la absoluta decide.

**Física que apareció al leer:** el bombeo saturado es casi independiente del espín a primer orden (cada trampa acaba
capturando en la media fase; Hori atribuye su ΔIcp a la competencia con la emisión). Por eso el bombeo da 1e-7–1e-5 y el diodo
con puerta ~1e-4. La ficha de XC-52 elige el observable de menor señal de espín.

## (b) La bobina — `a52_coil.py`

Proceso (**PDK**): met3/met4 ancho 0,3, separación 0,3 (0,4 si ancho ≥ 3), 0,047 Ω/□, EM 6,8 mA/µm media CC y 14,9 mA/µm
eficaz a 90 °C; via3 0,48 mA por vía — `libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd__nom.tlef` l. 195–208, 226, 236–250.
Alturas: met3 2,7861+0,845, met4 4,0211+0,845, base del poly 0,3262 — `libs.tech/magic/sky130A.tech` l. 5052, 5064, 5071.
Centro de met3 a 2,88 µm del silicio; met4 a 4,12 µm. (El tlef dice espesor 0,8; Magic 0,845.)

| Espiral cuadrada, 5 vueltas, semilado medio 10 µm | mT/mA | R | 10 mA: P, J | Límite CC → campo | ΔT Si |
|---|---|---|---|---|---|
| met3, ancho 0,3 | 0,257 | 62,7 Ω | 6,3 mW; 33 mA/µm (**4,9× el límite CC, 2,2× el eficaz**) | 2,04 mA → 0,52 mT | 0,89 K |
| met3, ancho 1,5 | 0,265 | 12,5 Ω | 1,25 mW; 6,7 mA/µm (cumple) | 10,2 mA → 2,70 mT | 0,14 K |
| met4, ancho 1,5 | 0,234 | 12,5 Ω | ídem | 10,2 mA → 2,39 mT | 0,14 K |
| met3, ancho 3,0, interior 3,2 | 0,271 | 6,3 Ω | 0,63 mW | 20,4 mA → 5,5 mT | 0,06 K |
| met3+met4 en serie, ancho 0,3, interior 5 | 0,640 | 78 Ω | — | 2,04 mA → 1,3 mT | — |

Todo **corrida**; validado contra el lazo cuadrado analítico (0,056569 T/A, coincide). Uniformidad con interior ≈ 9–10 µm:
< 0,1 % en 1×1 y 3×3; +18 % hacia las esquinas en 10×10. Con interior de 2 µm el campo cambia de signo dentro de 10×10.
Frente a 0,392 mT/mA (Demierre, **no leído**): mismo orden; se iguala con 5 vueltas de interior 2 µm (0,388) o con met3+met4.
Bifilar entrelazada: campo residual 0,4–2,5 % del de la bobina normal. ΔT es cálculo con constantes de memoria.
Faltan: la salida del extremo interior (21 vías para 10 mA) y la caída en la red de la tesela.

## (c) Lo aburrido, cuantificado — `a52_parasitos.py`

| Parásito | Tamaño | Paridad en I | Frente a 1e-4 / 1e-3 / 1e-2 |
|---|---|---|---|
| fem en lazo de 10×10 µm, 3 mT | 0,19 / 1,9 / 19 µV a 0,1 / 1 / 10 MHz | impar, en cuadratura | En dc-IV a 10 MHz: 3,6e-4 a f (mayor que 1e-4), pero su parte par (rectificada) es 3e-8. Lazo de 100×100 µm: 3,3e-4 rectificado → **hay que dibujar el lazo pequeño** |
| Capacitivo sin blindaje, nodo 10×10 (1,4 fF, placa paralela) | 0,57–2,8 nA a 1 MHz frente a 1,4 pA de señal | impar | 400–2000× la señal a f. Sobre un nodo flotante de 12,4 fF: 6–33 mV → **rectificación par 4e-3 a 1e-1** en dc-IV |
| Capacitivo con blindaje | ÷1e2–1e3 (**barrido**, sin solver) → rectificación ≤ 1e-5 | | Blindaje de met1 transparente al campo (ωL/R = 1e-2 a 10 MHz) |
| Térmico síncrono, f ≤ 10 kHz | 70 mK (ancho 1,5) a 440 mK (ancho 0,3) | **par** | dc-IV (5,8 %/K): 4e-3 a 2,6e-2. Bombeo (−0,3 %/K): 2e-4 a 1,3e-3 |
| Térmico síncrono, 100 kHz | 6–46 mK | par | dc-IV 3e-4 a 2,7e-3 |
| Térmico síncrono, 1 MHz | 6–49 µK | par | dc-IV 3e-7 a 3e-6: **por debajo de 1e-4** |
| Consumo de la bobina sobre la alimentación | 10 mA × ~5 Ω ≈ 50 mV (dato del plan, leído por agente) | **par** con puente en H | Sin cuantificar aquí; mismo signo que la señal |

El modelo térmico es 1D (calentador → 2,88 µm de óxido → silicio), acotado por el estacionario 3D; constantes de memoria.
El óxido filtra: su longitud de difusión a 2 MHz es ~0,4 µm. **Conclusión:** la inversión de corriente no separa nada de lo
que importa; la bifilar sí, pero solo si iguala potencia y tensiones al nivel de la señal (1e-2–1e-3 de igualación en dc-IV a
baja frecuencia). Por encima de 1 MHz el calor deja de llegar.

## (d) Bombeo a 1,8 V

- **PDK** (`libs.ref/sky130_fd_pr/spice/…__tt.pm3.spice`, primer bin): nfet_01v8 vth0 0,519 (l. 76), k1 0,541, ndep 1,7e17,
  toxe 4,148 nm; pfet_01v8 vth0 −1,060 (l. 94), k1 0,434, toxe 4,23 nm. No hay `vfb` en el modelo.
- Vfb implícito de BSIM4 (**cálculo**): −0,82 V (nfet), +0,18 V en el pfet. Ventana |Vth − Vfb|: 1,34 y 1,24 V. `[?]` ±0,2 V.
- Pulso de 1,8 V: margen 0,23 (nfet aislado) y 0,28 V (pfet) por lado con el cuerpo centrado (pfet: pozo a ≈ 1,3 V).
  El nfet sobre sustrato no baja de Vfb: no bombea. Los de 5 V quedan con 0,07–0,21 V.
- Corriente (dE = 0,75 eV; 0,73–0,97 según flanco y σ): 10×10 µm a 10 MHz: 1,2 nA (Dit 1e9) a 14 nA (1,17e10); 1×1 µm a
  1 MHz: 1,2–14 pA (8–88 trampas). El plan decía 16 nA: correcto para 1e10.
- Señal de 1e-4 en 10×10 a 10 MHz: 0,9 cargas por ciclo como máximo; con 1e-5 (lo que apunta Hori), 0,09.
- Diodo con puerta: 10×10 µm virgen, VF 0,3–0,4 V: 0,9–86 pA (σ 1e-16–1e-15). Comprobado contra Harmon: su corriente da
  Dit·σ = 1,5e-5.

## (e) Ruido — `a52_lockin_hall.py`

Monte Carlo (200 corridas, 2¹⁸ muestras): varianza del estimador = 2·S₀/T, y con 1/f se multiplica por ≈ 1 + 0,8·fc/f_mod
(medido 1,7–2,0 a fc = f_mod; 9–10 a 10×; 82–93 a 100×). T(5σ) = 100·q/(I·δ²):

| Corriente | 1e-3 | 1e-4 | 1e-5 |
|---|---|---|---|
| Bombeo 10×10, 10 MHz, 14 nA | 1,1 ms | 0,11 s | 11 s |
| Bombeo 1×1, 10 MHz, 140 pA | 0,11 s | 11 s | 19 min |
| dc-IV 10×10, 86 pA (mejor caso) | 0,19 s | 19 s | 31 min |
| dc-IV 10×10, 0,9 pA | 17 s | 29 min | 2 días |

Además: con 0,5 mT (ancho mínimo dentro de EM) solo se alcanza el 8–50 % de la señal; con 2,6 mT, 70–96 %. Si la esquina de
1/f queda por encima de la modulación, ×9 por década. El integrador de XC-26 (nodo de 12,4 fF) se satura con nA: no es el
lector para el bombeo de 10×10. Conjetura no probada: el bombeo es casi determinista y su ruido puede estar bajo el de disparo.

## (f) Hall

V_H = G·r_H·µ·R_hoja·I·B = G·r_H·µ·B·V (placa cuadrada): en modo tensión no depende de R_hoja ni del espesor.
R_hoja: 950 Ω/□ (550–1350) en `sky130A.tech` l. 5104, 5152, 5200; **1700 Ω/□** en
`libs.tech/ngspice/r+c/res_typical__cap_typical.spice` l. 22 (`rnw`). Los dos son **PDK** y no coinciden: `[?]` cuál vale para una placa.

| N (cm⁻³) | µ (Arora, memoria) | espesor implícito (950 / 1700) | µV por mA y mT (950 / 1700) | µV por V y mT |
|---|---|---|---|---|
| 1e16 | 1218 | 5,4 / 3,0 µm | 89 / 160 | 94 |
| 1e17 | 777 | 0,85 / 0,47 µm | 57 / 102 | 60 |
| 1e18 | 262 | 0,25 / 0,14 µm | 19 / 34 | 20 |

(G = 0,7, r_H = 1,1.) Con 1700 Ω/□, 1 mA son 1,7 V: no cabe; manda la tensión. A 1 V y 2,65 mT: 100–225 µV = 0,33–0,74
pasos de 0,305 mV; ruido del lector 0,20 mV por conversión → 10–50 pares ±B para 5σ. A 0,52 mT: 260–1270 pares.
Offset 1–10 mV (**memoria**, `[?]`), 5–200× la señal: invertir la bobina lo cancela sin rotar la corriente. fem en el lazo
de sentido: 1,7 µV a 1 MHz, 17 µV a 10 MHz: modular la placa a ≤ 1 MHz.

## Predicciones

| Pred. | Resultado |
|---|---|
| a1 ΔI/I 1e-5–1e-3, sin 1 % | Cumplida (3e-5–4e-4, estimación; bombeo 1e-7–1e-5) |
| a2 anchura 0,1–1 mT, satura < 3 mT | Parcial: hiperfinas 0,15 y 0,5 mT; rasgo ancho hasta ±2–3 mT; SILC 5–16 mT |
| a3 solo irradiados o estresados | Cumplida |
| a4 bombeo a campo nulo solo en SiC | **Fallada**: Moxim 2024 lo muestra en Si |
| b1, b2 | Cumplidas (met4 0,233, algo bajo el rango) |
| b3 EM ~1 mA/µm → ≤ 1 mT | **Fallada**: 6,8 mA/µm; 2,7 mT cumpliendo EM con 1,5 µm |
| b4, b5 | Cumplidas (+18 % en 10×10; 0,14–0,89 K) |
| c1, c2 | Cumplidas |
| c3 «la constante térmica no filtra» | **Fallada** en eso: el óxido filtra por encima de ~100 kHz. Cumplida en que el calor es par y manda a baja frecuencia |
| d1, d2, d3 | Cumplidas (ventana del pfet 1,24 V, algo bajo el rango) |
| e1, e2 | Cumplidas |
| f1, f2, f3 | Cumplidas; no previsto: 950 frente a 1700 Ω/□ |

## Mapa de tres regiones

Dos parámetros, no uno: **trampas activas bajo la bobina** (Dit·A) y **cómo se modula el campo**.

- Convencional: < ~1e3 trampas activas (1×1 a 10×10 µm virgen). El campo no cambia nada que se pueda ver en un tiempo razonable.
- Tercera región: ≥ 1e4–1e5 trampas (10×10 tras estrés a 1e11–1e12, o ≥ 30×30 µm virgen), B ≥ 1 mT (traza ≥ 0,7 µm),
  blindaje, y calor síncrono suprimido (f ≥ 1 MHz o potencia constante). Señal esperada 1e-5–3e-4 según observable.
- Fallo: modulación sí/no por debajo de 100 kHz (calor 3e-4–3e-2), nodo flotante sin blindaje (rectificación hasta 1e-1),
  lazo de cableado de 100 µm, o 10 mA en traza de 0,3 µm (EM ×4,9).

Fronteras: la primera es `[?]` (depende de Dit de SKY130, que no es público: barrido 1e9–1e11); la segunda está calculada.

## Lo nuevo

1. **Bobina de dos devanados a potencia constante.** Dos espirales entrelazadas en serie; un puente invierte solo una. Paralelo
   = campo; antiparalelo = bifilar (residuo 0,4–2,5 %). Corriente, potencia y consumo idénticos en los dos estados: la bifilar
   deja de ser un control aparte y pasa a ser la modulación. Quita calor y alimentación a cualquier frecuencia; queda la
   distribución de tensión del devanado invertido (blindaje).
2. **El observable está mal elegido:** diodo con puerta (señal ~1e-4, corriente pA) frente a bombeo (≤ 1e-5, corriente nA).
   El mismo pfet con pozo propio hace los dos: se miden ambos.
3. **Bobina + placa Hall** es lo sólido de la familia: calibra mT/mA sin depender de ninguna física de espín, y la inversión de
   la bobina sustituye a la corriente rotatoria.
4. Discrepancia interna del PDK en el pozo n: 950 (Magic) frente a 1700 Ω/□ (ngspice).

## Configuraciones de layout que más información dan

1. **Bobina de dos devanados (met3, traza 1,5 µm, 3+3 vueltas, interior ~6 µm) sobre placa Hall de pozo n de ~10 µm**, con
   blindaje de met1. Predicción: 0,2–0,27 mT/mA; 100–225 µV a 1 V y 10 mA. Mide el campo real y el residuo bifilar.
2. **La misma bobina sobre un pfet de 10×10 µm con pozo propio y toma a red propia**, leíble como bombeo y como diodo con
   puerta, antes y después de estrés (XC-10). Gemelo: mismo pfet bajo bobina solo bifilar. Ficticio: condensador conmutado de
   metal (C·V·f, sin trampas) bajo bobina idéntica, por el mismo lector: mide todo el acoplo sin espín.
3. **Barrido de trampas a campo fijo:** 1×1, 10×10 y una matriz de ~2 000 µm² (la escala de Moxim/Sharov) bajo bobinas
   iguales. La señal absoluta debe ir con el área y con el estrés; lo aburrido, no.
