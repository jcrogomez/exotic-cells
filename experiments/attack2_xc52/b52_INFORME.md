# b52 · Informe del ataque 2 a XC-52 (+ XC-56, XC-25): presupuesto magnético completo

Hora de `date` al cerrar: Thu Nov 12 13:38:29 EST 2026. Prerregistro: `b52_PREREG.md` (13:27:36 EST, antes de releer literatura y de
escribir código). Scripts y salidas (cada `.txt` lleva su hora): `b52_bobinas.py/.txt`, `b52_dinamica_clasico.py/.txt`,
`b52_escenarios_lector.py/.txt`. Textos abiertos: los de la ronda 1 en `scratchpad/a52_dl/` y cuatro nuevos en `scratchpad/b52_dl/`.
**Nada está medido en silicio. Todo es modelo, cálculo y lectura.**

Grados: **PDK** · **leído** (abrí el texto) · **supuesto** (se barre) · **corrida** (script) · **modelo propio** (conjetura mía, no
publicada) · **memoria** · `[?]`.

## Veredicto por sub-afirmación

| | Afirmación | Veredicto |
|---|---|---|
| T1 | «Modular por encima de 100 kHz libra del calor» | **TRANSFORMADA.** En el diodo con puerta leído por el terminal lento, la banda de la señal queda en 0,16–1,6 kHz a VF = 0,30 V y 13–130 kHz a 0,50 V (calibrado con la corriente de Harmon); el calor de una sola bobina no baja de la señal hasta ~1 MHz. No hay ventana en ese escenario. Vive en otros dos: bombeo de carga (banda = frecuencia de bombeo) y si la densidad de portadores es la que escribe Harmon (×300). La salida no es la frecuencia: es una secuencia de cuatro estados a potencia constante, a 5 Hz–5 kHz |
| T2 | El efecto de espín se distingue del magnetismo clásico | **SOBREVIVE.** Todo lo clásico par en B queda en 1e-11–8e-8 a 2 mT. La forma (satura) se separa de una parábola con 3–8× el tiempo de detección si la anchura es ≤ 0,5 mT; con 1,5 mT cuesta 138× a ±2 mT: hay que llegar a ±3,8 mT |
| T3 | Dos devanados, campos sumados / cancelados | **SOBREVIVE, con otra geometría.** Entrelazar en un plano o apilar deja 5–9 % de residuo; cruzar los devanados entre met3 y met4 lo baja a 0,9–2 %, sin sensibilidad a la desalineación. El esquema de dos estados no cancela el desajuste del puente (3e-6–1e-4, del tamaño de la señal); el de cuatro estados sí (≤ 1e-6) |
| T4 | Hay trampas suficientes sin poder crearlas a voluntad | **ABIERTA; depende de dos datos que no tenemos.** Por ruido de disparo, un 10×10 µm virgen da 5σ en 8 s–5 h según Dit·σ; no muere por estadística. Muere si las trampas de un óxido pasivado no son paramagnéticas (fracción de centros P_b `[?]`), o si se lee con el lector de XC-26 tal cual (días) |
| T5 | El integrador de 150 fA sirve de lector | **MUERE tal cual para el escenario virgen; TRANSFORMADA.** Su piso equivale a 69 fA/√Hz, el disparo de 15 nA. Un integrador con ΔV ≥ 0,5 V y comparador ≤ 0,3 mV queda a 1,1–1,3× del disparo |
| T6 | Cabe un canal completo | **SOBREVIVE.** ~8 100 µm² (5 700–16 200), del orden de media tesela `[?]` |

## Las cinco columnas

| Asunto | Dato del PDK | Evidencia leída | Supuesto (barrido) | Simulación / cálculo | Conclusión física |
|---|---|---|---|---|---|
| Campo | met3/met4: 0,3/0,3 µm, 0,047 Ω/□, 6,8 mA/µm; alturas 3,21 y 4,44 µm (centros) | 0,392 mT/mA (Demierre, **no leído**) | Desalineación entre capas 0–0,5 µm | Devanado cruzado, 4+4 vueltas, pista 1,5, huella 27,8 µm: 0,373 mT/mA; ±2 mT con 5,4 mA; tope 3,8 mT a 10,2 mA | ±2 mT cabe con la mitad del límite de corriente |
| Dinámica | — | Modulación de campo publicada: 210 Hz–1 kHz (Moxim 2024), audio (Cochrane 2016, SiC), kHz (Sgrignuoli 2024, SiC), 230 Hz (LED de Si 2017). Tasas del par: 0,00125–0,16 ns⁻¹ (Harmon 2020/2023, Moxim). Captura en bombeo: 400/133/80 ns a 1/3/5 MHz. Por encima de las tasas del par la señal tiende a cero (Lee 2012) | n = p = ni·exp(qVF/2kT); σ 1,5e-17–1e-15; Dit del irradiado de Harmon 1e11–1e12 | Par: sigue hasta 0,2–25 MHz. Ciclo de la trampa: corte 0,16–10 kHz (VF 0,30), 7,6–500 kHz (0,50) | El eslabón lento no es el espín sino la recarga de la trampa. Nadie ha publicado modulación de campo por encima de ~kHz |
| Clásico | — | — | µ 0,04–0,14 m²/V·s (memoria) | (µB)² = 6e-9–8e-8; ángulo Hall 0,8–2,8e-4 rad (impar); termodinámico 1e-11–5e-11 | 2,5–7 décadas bajo la señal mínima (3e-5) |
| Trampas | Óxido 4,15 nm → 4,3 MV/cm a 1,8 V; 8,0 a 3,3 V | Virgen: ~1e9 (Hori), 1,17e10 (Sharov), ~1e10 (Starkov). Estrés: 1,1–1,8e12 en 20–60 min a 12 MV/cm sobre 7,5 nm (Sharov); ~1e11 (Hori). «Ni NZFMR ni EDMR» antes de dañar (Harmon; Sharov OSTI 1882880) | Dit y σ de SKY130; fracción P_b; ΔDit a 8 MV/cm `[?]`; borde ×1–10 `[?]` | 10×10 virgen: 0,01–9 pA (VF 0,30), 0,1–86 pA (0,40) | La estadística no mata el virgen; lo decide si responde (fracción P_b) y el lector |
| Lector | — | Cochrane mide limitado por disparo con modulación | Comparador 0,1–1 mV; fuga 1 fA–1 pA; esquina 1/f 1–100 Hz | XC-26: 69 fA/√Hz. Propuesto: F = 1,06–1,26 | Con ΔV ≫ kT/q el reinicio no cuenta; manda el disparo |

## T1 · Dinámica — `b52_dinamica_clasico.txt`

- **Lo publicado modula despacio.** 210 Hz–1 kHz en los cuatro métodos de Moxim (incluido el bombeo a 1–5 MHz: el bombeo es
  rápido, la modulación del campo no). No encontré ninguna medida de la respuesta en frecuencia de la señal a campo casi nulo
  en Si/SiO₂: `[?]`. Lee 2012 (teoría general) da señal plana a baja frecuencia y caída por encima de las tasas del par.
- **El par no limita:** con las tasas ajustadas en los artículos leídos, 6–800 ns → 0,2–25 MHz.
- **Lo que limita en el diodo con puerta es la recarga de la trampa (modelo propio).** df/dt = cn·n·(1−f) − cp·p·f. La corriente
  del terminal que aporta el *otro* portador pasa por un filtro de primer orden de tasa cn·n + cp·p. Calibrado sin σ con la
  corriente de Harmon (5 nA, 41 000 µm², VF 0,30): 0,16–1,6 kHz; ×9 a VF 0,40; ×80 a 0,50.
- **Frente al calor de una bobina sencilla** (números de a52): a 1 MHz el calor es 3e-7–3e-6 y la señal atenuada 5e-8–5e-7 (VF 0,30)
  o 2e-7–2e-6 (VF 0,50). Cociente señal/calor 0,02–8: no hay ventana limpia. A 100 kHz es peor (≤ 0,06).
- **Salvedades que lo dejan abierto:** (a) el texto de Harmon da 2e15–7e18 cm⁻³ de portadores, que corresponde a exp(qVF/kT);
  con eso el corte sube ×300 y sí habría ventana a 1 MHz; (b) en el modelo, el terminal que suministra el portador cuya
  captura depende del espín ve el salto entero sin filtro (y el doble que en continua): leyendo por ese terminal no se pierde
  señal a alta frecuencia. Es conjetura; se decide barriendo la frecuencia de modulación en silicio.
- **Bombeo de carga:** ventana a 1–5 MHz de bombeo con campo conmutado a ≤ 100 kHz, pero con la señal pequeña (1e-7–1e-5).

## T2 · Qué lo identifica como espín

| Rasgo | Espín (recombinación por pares) | Hall | Magnetorresistencia | Calor | Acoplo eléctrico |
|---|---|---|---|---|---|
| Paridad en B | par | impar | par | par (I²) | impar lineal; par si se rectifica |
| Forma | centrada en cero, satura; anchuras 0,15 y 0,5 mT, rasgo ancho hasta 2–3 mT (leído) | lineal | B², sin saturar: 6e-9–8e-8 a 2 mT | I², sin saturar | sigue a la tensión, no al campo |
| Con la puerta | ΔI sigue el pico de recombinación (solo la parte de interfaz) | — | sigue la corriente total | sigue la corriente total, con 5,8 %/K | no depende del pico |
| Con VF | ΔI/I baja de 3e-4 a 3e-5 entre 0,30 y 0,50 V y la línea se ensancha (leído, tendencia) | — | constante | constante | — |
| Con las trampas | ΔI ∝ Dit·A; ΔI/I constante | — | — | — | — |
| Con la frecuencia | corte que se mueve como exp(qVF/2kT) | plano | plano | corte fijo por la geometría (~100 kHz) | crece con f |
| En el producto de 4 estados | queda | cancela | queda (1e-8) | cancela | cancela a primer orden |

**Secuencia mínima con bobina integrada de −2 a +2 mT** (cada paso contesta una pregunta y ninguno necesita imán externo):

1. Placa Hall, (++) − (−−): mT/mA real. (+−): residuo de cancelación. No depende de ninguna física de espín.
2. Canal ficticio (misma bobina, mismo lector, corriente igual sin trampas): el producto de 4 estados debe dar cero. Es la cota
   de todo lo que no es espín.
3. Dispositivo en el pico de recombinación, |B| = 2 mT, producto de 4 estados: detección.
4. Ocho amplitudes de 0,25 a 2 mT: ¿satura? Coste 3–8 T₁ si Γ ≤ 0,5 mT; 34 T₁ si Γ = 1; 138 T₁ si Γ = 1,5 (entonces subir a 3,8 mT).
5. Barrido de puerta a campo fijo: ΔI debe dibujar el pico de recombinación y anularse fuera de él.
6. Barrido de frecuencia de la secuencia, 5 Hz–100 kHz, a dos VF: el corte debe moverse con VF. Ningún artefacto clásico lo hace.
7. Escalera de área y, si hay permiso, antes y después de estrés: ΔI con el número de trampas.

Orientación: con una bobina centrada solo hay campo vertical; a campo casi nulo no se espera anisotropía fuerte `[?]`. No la uso
como discriminante.

## T3 · Las dos bobinas — `b52_bobinas.txt`

Biot–Savart propio validado: lazo cuadrado analítico (0,056569 T/A, coincide) y el caso del verificador (0,190 mT/mA, coincide).

| Geometría (pista 1,5, borde interior a 7 µm del centro) | Suma, mT/mA | Residuo ⟨\|B\|⟩ cancelado/suma sobre 10×10 | Con 0,5 µm de desalineación | Huella | R por devanado |
|---|---|---|---|---|---|
| G1 coplanar, 3+3 vueltas alternadas en met3 | 0,265 | 7,2 % | no aplica | 35,0 µm | 8,5 / 9,9 Ω |
| G2 apilada, 3 en met3 + 3 en met4 | 0,296 | 8,5 % | 8,7 % | 24,2 µm | 7,2 Ω |
| **G3 cruzada, 4+4, cada devanado alterna de capa** | **0,373** | **1,9 %** (0,9 % con interior a 10 µm) | 1,9 % | 27,8 µm | 10,5 Ω |

- Uniformidad en suma sobre 10×10: 0,91–0,97. Tope por corriente: 10,2 mA → 3,8 mT (G3).
- El residuo no es inocuo: en G2 a la corriente de 2 mT quedan ~0,18 mT en el estado «cero», del tamaño de la hiperfina estrecha
  (0,15 mT): se pierde hasta 3/4 de ese rasgo. En G3, ~0,04 mT, como el campo terrestre.
- **Discrepancia con a52** (0,4–2,5 % para la bifilar): no la reproduzco con pista de 1,5 µm (6–9 %). Probablemente su caso era de
  pista mínima; no lo comprobé `[?]`.
- Inductancia (Neumann, ±30 %): 0,26–0,45 nH por devanado; suma 0,95–1,7 nH; cancelado 0,08–0,12 nH; L/R = 60–82 ps.
- fem en el lazo de lectura al conmutar: flujo 0,28–0,39 pWb en 10×10 (1,4 pWb en 30×30) → 0,3–1,5 mV durante 1 ns, o 3–15 µV si
  el flanco se alarga a 100 ns. Impar y transitoria.
- Acoplo eléctrico entre modos, sin blindaje: el perfil de tensión del devanado invertido se refleja; 19–44 electrones por
  transición sobre un nodo de 10×10 (equivale a 17–39 mV sobre 0,12–0,22 fF). Con blindaje (÷1e2–1e3, barrido de a52) 0,02–0,4 e.
  La señal por semiperiodo a 10 pA, 1 kHz y 1e-4 son 3 e: **sin blindaje ni borrado, el transitorio es ~10× la señal.**

**Lo que el esquema de dos estados NO cancela:**

1. Desajuste del puente: ΔP/P = 4e-4–1,6e-2 → residuo térmico par 3e-6–1,1e-4 (dc-IV). Igual que la señal en su extremo bajo.
2. El perfil de tensión reflejado (arriba). Lineal: se va con blindaje y con reinicio del integrador tras cada transición.
3. El residuo de campo en el estado «cero» (reduce el contraste, no lo falsea).
4. Cualquier efecto par real del campo (magnetorresistencia 1e-8): solo lo separa la forma.

**Lo nuevo: cuatro estados.** Cada devanado con su puente; estados (++), (+−), (−+), (−−); se demodula con el producto de los dos
signos. El calor es I_A²R_A + I_B²R_B: no tiene término cruzado. El desajuste de cada puente y el perfil de tensión de cada
devanado son lineales en su propio signo: se anulan en el producto. Queda el segundo orden (producto de dos desajustes):
6e-10–9e-7. La misma secuencia da (++) − (−−) para la placa Hall. Regla de layout que lo sostiene: ningún tramo resistivo
compartido por las dos corrientes *con signo* (los puentes en serie comparten solo corriente rectificada).

## T4 · Escenarios — `b52_escenarios_lector.txt`

Lector propuesto (F = 1,3), ΔI/I de a52 (3e-4 a VF 0,30; 1,7e-4 a 0,40; entre corchetes, tres veces menor), todas las trampas activas.

| Escenario | Dit (fuente) | 10×10 µm: I a VF 0,40 | Señal | T(5σ) | Con XC-26 tal cual |
|---|---|---|---|---|---|
| (i) virgen, bajo | 1e9 (Hori, leído) | 0,11–7,3 pA | 0,02–1,3 fA | 98 s–1,8 h [15 min–16 h] | de 42 h a inviable (años) |
| (i) virgen, medio | 1,17e10 (Sharov, leído) | 1,3–86 pA | 0,2–15 fA | 8 s–9 min [76 s–84 min] | 18 min–57 d |
| (i) virgen, techo | 1e11 (supuesto) | 11–734 pA | 1,9–125 fA | 1–65 s | 15 s–19 h |
| (ii) estrés | 1e11 (Hori) – 1e12 (Sharov, 12 MV/cm) | 11 pA–7,3 nA | 1,9 fA–1,3 pA | 0,1–65 s | 0,15 s–19 h |
| 30×30 µm o matriz de 2 000 µm² | ×9 o ×20 en corriente | | | ÷9 o ÷20 | ÷81 o ÷400 |

El intervalo dentro de cada fila es σ = 1,5e-17–1e-15 cm² (no público; Harmon da Dit·σ = 1,5e-5).

- **(ii) Cuánto crea 1,8 V o 3,3 V en 4,15 nm: `[?]`.** Tres búsquedas sin texto abierto; lo abandono como dato. Lo leído crea 1e12 en
  20 min a 12 MV/cm; aquí hay 4,3 MV/cm (1,8 V) y 8,0 MV/cm (3,3 V). A 1,8 V de puerta no espero nada en horas (memoria). Los
  portadores calientes con drenaje sobre la nominal «llegan fácilmente a 1e12» (Starkov, 0,35 µm, leído), sin tensiones ni tiempos.
  Dato que decide: una curva de corriente de recombinación frente a tiempo de estrés en el propio chip.
- **(iii) Estructuras con más defectos de nacimiento:** el borde del aislamiento solo gana si su densidad es ≥ 5× la de la cara
  plana en una franja ≥ 0,1 µm; con 11 tiras en 10×10 el equivalente va de 46 a 442 µm² de cara plana. Sin dato (`[?]`; el resumen
  encontrado era ilegible). El transistor de alta tensión no da más campo de estrés por nanómetro `[?]`. Se dibuja la pareja
  placa/tiras y se mide.
- **Lo que no está en la tabla y puede matarla:** que las trampas residuales de un óxido pasivado no sean centros P_b. Los dos
  artículos que dicen «sin respuesta antes de dañar» no dan su piso; es compatible con «no hay espín» y con «no les llegaba».
- 1/f: a 1 pA la secuencia va a ~5 Hz; si la esquina está en 10 Hz el tiempo sube ×2,6; a ≥ 100 pA no cuenta. Esquina `[?]`.

## T5 · Lector

- Necesario: I·δ² ≥ 4,4e-21 A para 5σ en 1 h (0,05 pA a 3e-4; 0,45 pA a 1e-4; 4,9 pA a 3e-5). Resolución relativa 1σ: 6e-6–6e-5.
- XC-26 tal cual: 150 fA en 0,105 s = 69 fA/√Hz si es ruido blanco (`[?]`: no sé si es ruido o cuantización). Sirve desde ~100 fA de
  señal (24 s); a 1 fA, 2,7 días.
- Propuesto: integrar en 100 fF hasta 0,5–1 V, contar con el reloj de 10 MHz, un reinicio por estado (borra el transitorio).
  Por conversión: disparo 3,1e5–6,2e5 e; kTC 127 e; comparador 62–625 e (0,1–1 mV). F = 1,06–1,22 con comparador ≤ 0,3 mV; 1,7–2,4
  con 1 mV. Cuantización ≤ 3e-5 por conversión: despreciable. Conversión: 50 ms a 1 pA, 50 µs a 1 nA.
- Deriva: 5,8 %/K pide 0,17 mK entre estados; el orden +,−,−,+ quita la lineal; un gemelo sin corriente de bobina leído a la vez
  quita la común y cuesta ×2. Puente de dos dispositivos: útil por debajo de ~10 pA, innecesario por encima.

## T6 · Geometría que sale del cálculo

- Dispositivo: diodo con puerta de 10×10 µm en pozo n propio (pfet con fuente y drenaje unidos), blindaje de met1.
- Bobina: G3, 4+4 vueltas, pista 1,5 µm, separación 0,3, met3/met4, borde interior a 7 µm, huella 27,8 µm, 12 vías via3 por salto.
- ±2 mT: 5,4 mA (3,6 mA/µm), 0,60 mW en las bobinas, 9,6 mW desde 1,8 V, 27 mV de caída en la red (5 Ω, leído por agente),
  constante en los cuatro estados. Tope: 10,2 mA → 3,8 mT, 2,2 mW, 54 mV.
- Placa Hall: bajo una bobina idéntica en serie (misma corriente), o —más barato y en el punto exacto— **el propio pozo del
  dispositivo con cuatro tomas en las esquinas**, usado como placa cuando el diodo está apagado (conjetura de layout, sin dibujar).
- Área: bobina 773 µm² × 3 (canal, gemelo, Hall) + puentes ~1 700 + integrador ~600 + contador ~1 150, +40 % → **~8 100 µm²**
  (5 700–16 200). Anchos de interruptor de memoria `[?]`: sacarlos del modelo antes de dibujar.

## Predicciones

| Pred. | Resultado |
|---|---|
| P1a modulación publicada a audio | Cumplida |
| P1b corte 0,2–15 kHz (VF 0,30–0,35), 25–300 kHz (0,50) | Cumplida en orden (0,16–10 y 7,6–500 kHz). No previsto: depende del terminal |
| P1c, P1d | Cumplida; P1d parcial (6–800 ns, no solo decenas) |
| P2a, P2b, P2d | Cumplidas |
| P2c separar forma en < 4× | **Fallada**: 3–8× solo si Γ ≤ 0,5 mT; 34–138× si 1–1,5 mT |
| P3a residuo coplanar 0,5–3 % | **Fallada**: 6–9 % |
| P3b | Residuo y desalineación cumplidas; campo 0,24–0,30, algo sobre lo predicho |
| P3c, P3d, P3e, P3f | Cumplidas |
| P4a | Cumplida. P4b, P4c: sin texto, no comprobables. P4d: solo por encima de ~10 pA |
| P5a, P5b, P5c, P6a, P6b | Cumplidas |

## Mapa de tres regiones

Parámetro: **I·δ² del dispositivo bajo la bobina** (corriente de recombinación por el cuadrado del cambio relativo), con la forma
de modular como segunda coordenada.

- Convencional: I·δ² < ~4e-21 A (menos de 5σ en una hora). Un 1×1 µm virgen; o cualquier área si las trampas no son paramagnéticas.
- Tercera región: 1 pA–10 nA, VF 0,30–0,45 V, |B| 0,3–3,8 mT, secuencia de cuatro estados a 5 Hz–5 kHz, devanado cruzado, lector
  integrador. Geometrías enviables que la cruzan: 10×10 µm (frontera si Dit ~1e9), 30×30 µm y matriz (dentro si Dit ≥ 1e10). Todo
  son transistores y metal de reglas normales.
- Fallo: bobina sencilla encendida/apagada bajo ~1 MHz (calor 3e-4–3e-2); dos estados con desajuste ≥ 2 % y δ ≤ 3e-5; VF ≥ 0,5 V
  (δ cae a 3e-5 y la línea se ensancha fuera del alcance); nodo sin blindaje sin borrado; más de 10,2 mA en pista de 1,5 µm.

La primera frontera sigue sin fijar: depende de Dit·σ y de la fracción P_b de SKY130.

## Configuraciones de layout que más información dan

1. **Canal completo:** bobina G3 sobre diodo con puerta de 10×10 µm en pozo propio con cuatro tomas (el pozo hace de placa Hall),
   dos puentes en serie, integrador de 100 fF, y su gemelo sin corriente. Contesta: mT/mA, residuo, y si el virgen responde.
2. **Canal ficticio bajo bobina idéntica:** un transistor en inversión débil con la misma corriente (sin recombinación de
   interfaz) por el mismo lector. Mide todo lo que no es espín; sin él un positivo no vale.
3. **Escalera de trampas bajo la misma bobina:** 1×1, 10×10 placa, 10×10 en tiras (borde), y 30×30 bajo bobina mayor. La señal
   absoluta debe ir con el número de trampas; lo clásico, no.
