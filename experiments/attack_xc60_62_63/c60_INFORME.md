# c60 — Informe del ataque a XC-60 (magnetodiodo)
Cerrado: Thu Nov 12 19:16:33 EST 2026 (hora de `date`). Prerregistro: `c60_PREREG.md`. Modelo propio de primer orden, sin calibrar; profundidad del pozo, velocidades de recombinación, vida media y movilidad efectiva **no son públicas y se barren**.

## (h) Literatura (`c60_lit_magnetodiodos.txt`; leído por subagente, casi todo resúmenes)
- SOS: 0,024–4,9 V/T con bases de 6–31 µm (Lutes 1980, fragmento); 30 V/T en SOS con Schottky, longitudes < 20 µm, dopado < 1e16, inyección alta imprescindible (Mohaghegh 1981, resumen).
- **CMOS:** hasta 25 V/T a 10 mA; la "superficie de alta recombinación" es **la unión pozo–sustrato en inversa** ("la recombinación se sustituye por colección"), no el óxido (Popović, Baltes, Rudolf 1984, resumen; libro de Popović §7.2.2, leído).
- Condiciones (libro §3.5.2, §7.2.1): región poco dopada **mucho más corta** que la longitud de difusión; ideal s1 ≈ 0, s2 → ∞; inyección alta (n ≈ p). Campo perpendicular a la corriente y paralelo a las dos caras.
- Por qué se abandonó: no admite corriente rotatoria para cancelar offset y 1/f; ninguno compitió con Hall (libro, cap. 8).
- s de la pared de aislamiento: solo una velocidad de generación ~1–2,6·10³ cm/s (fragmento). s de SKY130: no encontrado.

## Tautologías confirmadas (sin correr)
1. **Orientación.** Corriente a lo largo de x y campo en el plano (y) ⇒ fuerza vertical: las dos caras son **arriba (óxido) y abajo (unión pozo–sustrato)**, no los lados. La geometría del plan ("un lado pegado al aislamiento y el otro lejos") necesita campo **vertical**, el de la bobina de XC-56. Son dos dispositivos.
2. El control centrado/simétrico da cero exacto a primer orden (d(λ) ∝ ∂λ/∂s1 − ∂λ/∂s2; tabla 2 del modelo: G = 0,000 con s1 = s2).

## (i) Modelo (`c60_modelo.py` → `c60_modelo.txt`)
| Dato del PDK | Evidencia publicada leída | Parámetro supuesto | Resultado de simulación | Conclusión física |
|---|---|---|---|---|
| Alturas: met1 1,376+0,36; met2 2,006+0,36; met3 2,786+0,845 (tech l. 5058–5068). Límites: met1 y met2 2,8, met3 6,8 mA/µm (tlef l. 123, 165, 207). Pozo 950–1700 Ω/□ | 25 V/T a 10 mA en CMOS; colector = cara recombinante; base corta | d 0,5–2 µm; s_sup 10–1e5 cm/s; D 10 cm²/s; µ_ef 0,05–0,15 m²/Vs; caída en la base 0,3–1 V | Ver abajo | La amplificación es (caída de tensión en un tramo d)/(kT/q), no L/d |

**Campo en el plano** a 0,5 µm bajo la superficie: met1 de 2 / 5 / 10 µm al límite: **0,52 / 1,01 / 1,36 mT** con 5,6 / 14 / 28 mA; cota de lámina infinita 1,76 mT. met3 de 5 µm: 1,66 mT con 34 mA. Eficiencia 0,05–0,10 mT/mA (la bobina: 0,19, pero vertical). Los "2 mT" **no** se alcanzan con una línea de met1.

**Resultado analítico del modelo:** con la cara de arriba pasiva y la de abajo colectora, δτ/τ = (4/π²)·µ_ef·B·(E·d)/(kT/q). El factor G = 0,405 se mantiene (0,32–0,41) para s_sup ≤ 1e4 y cae a 0,09–0,25 con s_sup = 1e5. A corriente constante, δV = (V/2)·δτ/τ. Comprobación de cordura contra lo publicado: con 10 V, d/L = 0,3 y µ_ef = 0,18 da ~40 V/T, del orden de los 25 V/T de Popović (no es calibración).

**La unión del fondo se come los portadores en ~0,64·d** (τ_ef = 0,1–1,6 ns): un diodo largo solo modula su primer tramo.

| L/d | Caída en la base | δV a 1 mT | δV a 1,6 mT | Frente al paso (0,305 mV) |
|---|---|---|---|---|
| 2 | 1,0 V | 0,19–0,60 mV | 0,31–0,95 mV | 0,6–3 pasos |
| 2 | 0,3 V | 0,017–0,054 mV | 0,03–0,09 mV | < 0,3 |
| 5 | 1,0 V | 0,07–0,23 mV | 0,11–0,37 mV | 0,2–1,2 |
| 20 | 1,0 V | 0,002–0,005 mV | 0,003–0,008 mV | muerto |

Coste: para inyección alta en un pozo de 1e17 hacen falta 0,4–0,9 mA (W = 5 µm), y **casi toda esa corriente de huecos va al sustrato** (es un pnp vertical). Además 1 V sobre una base de 2–4 µm de pozo son 0,7–2,6 mA aun sin modulación (0,4–0,8 cuadros de 950–1700 Ω).
**Frente a la placa Hall** a la misma corriente (~2 mA) y 1 mT: Hall 0,013–0,5 mV; magnetodiodo 0,19–0,60 mV. Cociente entre 0,4 y 46: **no se puede afirmar "mucho mayor que la Hall"**; depende del dopado y espesor del pozo, los mismos datos que faltan en XC-25.
**Geometría lateral del plan** (campo vertical, pared de aislamiento frente a pozo abierto, fondo colector a 1 µm): G_lateral = 0,0007–0,11 según s_pared = 1e3–1e5: entre 4 y 600 veces más débil que la vertical, porque el fondo compite con la pared.
**Inyección baja** (transistor lateral): δI/I = 1,5·10⁻⁵–2,3·10⁻⁴ por mT, y la corriente lateral que sobrevive cae como exp(−πL/2d) (4 % a L = 2d). Legible solo promediando (10⁻⁴ en 14 nA: 0,11 s, R12).

## (j) Geometrías legales (`c6x_drc_out/map_c60.txt`, `map_c60b.txt`)
- p+ | aislamiento | n+ en pozo n, separación 0,27 / 1,0 / 3,0 µm: **pasa** Magic y KLayout (la de 3,0 falló primero por un pozo dibujado estrecho, error mío; corregida pasa). Cara superior = fondo del óxido de aislamiento.
- Diodo con puerta (p+ | poly sobre activa | n+): **rechazado por Magic** (varac.7, var.2, "pFET cannot abut N-diffusion"); KLayout 0. La cara superior con s ajustable por puerta no es enviable así.
- Lateral: la misma primera geometría con el diodo pegado a un borde de la zona activa; es legal por las mismas reglas (no corrida aparte).

## Resultado contra predicción
P60.1 cumplida. P60.2 cumplida (0,52–1,01 mT; cota 1,76). P60.3 **fallada por arriba**: predije 3 µV–0,1 mV a 1 mT; sale 0,1 µV–0,6 mV; supera un paso solo en la esquina L ≈ 2d, 1 V, movilidad alta. P60.4 cumplida (fracción modulada 5–8 % a L = 20d).

## Veredicto
| Sub-afirmación | Veredicto |
|---|---|
| "Diodo largo" | **MUERE en pozo n** en todo el barrido (la unión del fondo corta en ~0,64 d). TRANSFORMADA: diodo **corto**, L = 2–5 d |
| "Hacia la interfaz con el aislamiento, donde recombinan más" | **TRANSFORMADA**: la cara que manda es la unión pozo–sustrato (colección), como en el dispositivo publicado; el aislamiento es la cara *pasiva*. Si s del aislamiento fuera ≥ 1e5 la señal baja ×2–4 |
| "Respuesta impar mucho mayor que la Hall" | **No demostrable**: 0,4–46× según datos del pozo que no hay |
| Legible con el lector de umbral | Escenario vivo: L ≈ 2d, ~1 V en la base, B ≥ 1 mT (≥ 14 mA en la línea), ~1–2,6 mA por el diodo con ~0,5 mA al sustrato → 0,2–0,95 mV. Escenario muerto: caída ≤ 0,3 V o L ≥ 10 d → < 0,05 mV |

**Mapa de tres regiones.** Parámetro: L/d y caída en la base. Convencional: L/d ≳ 10 (resistencia de pozo + pnp; µV). Tercera: L/d 2–5 con 0,5–1 V e inyección alta. Fallo: la corriente al sustrato (mA) dispara el tiristor parásito o calienta; y no hay modelo del PDK para este régimen.

## Configuraciones a dibujar
1. **p+ | aislamiento | n+ en pozo n, separación 0,27 / 1,0 / 3,0 µm, W = 5 µm, bajo una tira de met1 de 5 µm** (cruza L/d de ~0,3 a ~3 si d ≈ 1 µm; el máximo de señal dice d). Leer también la corriente de sustrato con un anillo p+ propio: su parte impar es el observable más limpio.
2. La misma con la tira desplazada (campo vertical en el borde de la tira) o bajo la bobina de XC-56: separa el efecto lateral del vertical.
3. Gemelo en pozo sobre pozo n profundo `[?]` (el fondo deja de ser el sustrato): no explorado.
