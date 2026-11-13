# e07 — Informe del ataque a XC-07 (ruptura de óxido, antifusible) y XC-08 (filamento emisor)

Abierto el 2026-11-13 07:32 EST (hora de `date`). Prerregistros: `e14_PREREG.md` (P-E1, P-E2, P-F1; 12-nov 22:33:58) y
`e07_PREREG.md` (P-E3–E5; 13-nov 07:16, escrito tras leer parte de la literatura, ver su cabecera). Un solo agente; sin verificar.
Grados como en `e14_INFORME.md`.

## 1. Lo que se hizo

`e07_tddb.py` → `e07_tddb.txt`, `e07_tddb.png`. Ancla: tiempo medio hasta la ruptura frente a V_G de un condensador NMOS de
**4,2 nm** en inversión (puerta +), área 5e-4 cm², 140 °C (**LEÍDO-FIG**: Samadder & Mahapatra, SISPAD 2023, P-5, Fig. 9a,
datos compilados de sus refs. [6], [10], [11]; https://in4.iue.tuwien.ac.at/pdfs/sispad2023/SISPAD2023_P-5.pdf). Cuatro puntos
leídos a ojo: (4,60 V; 4e4 s), (4,70; 1e4), (4,85; 1,2e3), (5,20; 2,2e2). Tres leyes ajustadas a los mismos puntos: exponencial
en V (3,65 déc/V), exponencial en 1/V, potencia (exponente **n = 41,4**, que cae dentro del 40–45 que da un resumen de la
literatura sobre ley de potencia, **NO LEÍDO**). Escalado de área con Weibull β = 1,7–2,5 (β ≈ 2 a 4 nm, **LEÍDO-FIG**, misma
fuente, Fig. 5). De 140 a 27 °C con Ea = 0,3–0,8 eV (**SUPUESTO**; factor 24–4700). Para puerta negativa (acumulación) la
Fig. 10a de la misma fuente pone la curva ~0,5 V más arriba (**LEÍDO-FIG**).

## 2. Resultados contra predicciones

| Id | Predicción | Resultado (1 µm², 27 °C, puerta +) | Veredicto |
|---|---|---|---|
| P-E1 | 1,8 V: > 10⁴ años; 2,5 V: años–milenios; 3,3 V: 10 s–10⁷ s; 5 V: 1e-4–10 s | 1,8 V: 7e17–6e40 s; 2,5 V: 2e15–1e27 s; **3,3 V: 2e12–3e18 s**; **5 V: 1,3e6–2,2e9 s** | 1,8 y 2,5 V cumplidas; **3,3 y 5 V falladas**: el óxido aguanta mucho más de lo que predije |
| P-E1 bis | 3,3 V no rompe en < 1 h con modelos conservadores; sí con potencia | No rompe en ningún modelo: ≥ 2e12 s en 1 µm²; ≥ 6e10 s en 1e4 µm² | cumplida la primera mitad; fallada la segunda |
| P-E3 | Dispersión entre modelos a 3,3 V > 4 déc; a 5 V < 2 déc | 3,3 V: ~6 déc; 5 V: ~3 déc (incluye β y Ea) | cumplida / fallada por poco |
| P-E4 | Ventana [1 ms, 1 h] entre 4,5 y 6,5 V | 1 h a 5,7–7,4 V; 1 s a 6,7–10,5 V; 1 ms a ≥ 7,5 V | **fallada**: la ventana está ~1–2 V más arriba |
| P-E2/E5 | R tras ruptura blanda 1e5–1e8 Ω; dura 1–20 kΩ; programable por la corriente límite | Sin fuente leída `[?]`. Único dato: filamento de Li et al. 2023 ≈ 2,5 V a 1 mA (leído por agente, `PESCA_PHOTON_1105.md`) | sin resolver |
| P-F1 | La bomba de una tesela no sostiene el filamento (mA); como mucho lo forma | Ver §4 | cumplida en lo que se puede decir |

## 3. Respuesta a (e)

Tiempo medio hasta la ruptura, 27 °C, puerta positiva, intervalo sobre modelo × β × Ea (`e07_tddb.txt`, **CORRIDA** sobre ancla
**LEÍDO-FIG**):

| V puerta | 0,063 µm² | 1 µm² | 100 µm² | 1e4 µm² |
|---|---|---|---|---|
| 1,8 V | > 1e18 s | > 7e17 s | > 1e17 s | > 2e16 s |
| 2,5 V | > 6e15 s | > 2e15 s | > 3e14 s | > 5e13 s |
| 3,3 V | 7e12–1e19 s | 2e12–3e18 s | 4e11–2e17 s | 6e10–1e16 s |
| 5,0 V | 4e6–1e10 s | 1e6–2e9 s | 2e5–2e8 s | 3e4–1e7 s |
| 6,0 V | 1e3–1e7 s | 3e2–2e6 s | 50–2e5 s | 8–1e4 s |
| 7,0 V | 0,2–9e4 s | 0,07–2e4 s | 0,01–1e3 s | 2e-3–80 s |
| 8,0 V | 5e-5–2e3 s | 2e-5–500 s | 3e-6–30 s | 4e-7–2 s |

**Con 3,3 V no se rompe en ninguna escala útil** (≥ 1e10 s en todos los escenarios y áreas; la puerta negativa es aún peor).
Tampoco con 5 V en tiempo de mesa salvo áreas enormes. La ruptura en minutos pide **6–7 V** en el óxido de 4,15 nm sobre áreas de
100–1e4 µm², y en un segundo, 7–8 V. Eso está dentro de lo que da la bomba (e53) y dentro del régimen de alta tensión que el PDK
define (5,5–12 V, ver e53), pero no dentro de 3,3 V. Lejos del ancla los tres modelos divergen; a 3,3 V la incertidumbre es de
seis décadas y no cambia el veredicto.

Ruptura blanda frente a dura y resistencia final: no leí fuente `[?]`. **DE MEMORIA**, sin peso: en óxidos de < 5 nm la primera
ruptura a baja tensión y con poca energía disponible suele ser blanda (conducción no óhmica, µA a 1–2 V) y progresiva; la dura
pide energía o corriente (mA) y deja kΩ. Que la resistencia final dependa de la corriente límite y sirva de antifusible
multinivel: es la práctica de los antifusibles de óxido comerciales según un resumen de proveedor (**NO LEÍDO**: Synopsys, «core
oxide» y «I/O oxide»); una patente da ~4,6 V de ruptura y programación a ~5 V en un óxido de espesor no dicho y «~1 mA» para
romper (**NO LEÍDO**, fragmentos). Nada de eso permite fijar cifras para SKY130.

## 4. Respuesta a (f): el filamento emisor (XC-08) con bomba

De `05_exotic_lab/docs/pesca/PESCA_PHOTON_1105.md` (leído por agente, Li et al., Nat. Commun. 2023): formado a 6,0 V sobre óxido
de < 3 nm, la corriente sube de pA a mA y se estabiliza en < 1 min; opera a 1–6 mA, ≈ 2,5 V a 1 mA y ≈ 6,4 V a 6 mA; EQE
1,4e-8; fiable por debajo de 7 mA. Qué cambia con la bomba:

- **Formado:** el óxido de SKY130 es más grueso (4,15 frente a < 3 nm). Según la tabla de arriba, 6 V rompe un área de 100 µm²
  en 50 s–2 días; para romper en < 1 min harían falta ~7 V. La bomba los da (e53). Lo que **no** da es corriente: entrega µA,
  así que lo esperable es una ruptura blanda o progresiva, no el filamento fundido de Li (que pasa a mA durante el formado). La
  energía de la ruptura la pondría el condensador de salida de la bomba (2 pF a 8 V = 64 pJ, cálculo), del orden de los
  ~27 pJ del sobreimpulso del pin que el plan de XC-07 ya trata como riesgo. Si eso basta para fundir silicio `[?]`.
- **Operación:** 1 mA a 2,5 V cabe en VAPWR (3,3 V) y en la PDN; 6 mA a 6,4 V no cabe en ninguna alimentación de la tesela y
  supera los 4 mA del pin analógico (tinytapeout.com/specs/analog, **LEÍDO**). La bomba no sirve para operar.
- **Geometría:** el emisor de Li es poly n+ sobre pozo n con una ventana de ~0,3 µm² de óxido delgado. En SKY130 eso es un
  varactor de 1,8 V (`cap_var_lvt/hvt` existen en el PDK) con área pequeña; área pequeña alarga t_BD (×(A_ref/A)^(1/β)).

## 5. Mapa de regímenes (óxido de 4,15 nm, 27 °C)

Parámetro: tensión de puerta sostenida y área. Fronteras en 1 µm² (en 1e4 µm² bajan ~0,5–1 V):

| Región | Tensión | Qué se ve |
|---|---|---|
| Convencional | ≤ 3,3 V | Túnel directo (e14), sin desgaste medible en años |
| Desgaste lento (tercera región, lectura por SILC y deriva de umbral) | 4–6 V | t_BD de días a siglos; la fuga inducida por estrés crece antes de romper (**DE MEMORIA**) |
| Ruptura en tiempo de mesa (antifusible) | 6,5–8 V | segundos a minutos según área |
| Ruptura inmediata | ≳ 8–10 V | < 1 ms |

El dato de proceso que mueve todas las fronteras: la curva t_BD(V) del óxido real de SKY130 (y su energía de activación). La
geometría enviable que las cruza: condensadores de 1–1e4 µm² con la bomba e53 aplicando 6–8 V con limitador de corriente; sin
bomba no se cruza ninguna.

## 6. Veredicto por sub-afirmación

| Sub-afirmación | Veredicto | Qué lo cambiaría |
|---|---|---|
| «A 3,3 V el óxido ve ~8 MV/cm: la ruptura está al alcance» (replanteo de XC-07/XC-53) | **MUERE**: el campo es cierto, el tiempo no; ≥ 1e10 s | Que el óxido real tenga una cola extrínseca (defectos) mucho peor que la intrínseca: se vería como rupturas tempranas en áreas grandes |
| XC-07 antifusible con bomba | **SOBREVIVE**, con 6,5–8 V; exige bomba y limitador | Bomba que no pase de ~6 V: entonces solo en áreas ≥ 1e4 µm² y horas |
| XC-07 estados intermedios por corriente límite | **`[?]`**: sin fuente leída | Fuente de antifusibles con R frente a corriente de programación |
| XC-08 emisor por filamento | **TRANSFORMADA**: la bomba puede formar una ruptura, probablemente blanda; el filamento fundido de Li pide mA que una tesela no da; operar a 1 mA desde 3,3 V sí cabe | Que una ruptura con µA y 64 pJ deje un filamento emisor `[?]` |

## 7. Configuraciones de layout

1. **Escalera de áreas de condensador de 4,15 nm** (0,3; 10; 100; 1e4 µm², poly sobre pozo n), cada uno con limitador de
   corriente de 5 V en serie y lectura de fuga antes y después, alimentada por la bomba e53 con salida seleccionable
   (5 / 6,5 / 8 V). Da t_BD(V, A) del óxido real: el dato que falta.
2. **Gemelo de 11,6 nm** con la misma bomba: no debe romper a ≤ 10 V; separa ruptura del óxido de ruptura de unión.
3. **Varactor pequeño estilo Li** (ventana de óxido delgado de ~0,3 µm² sobre pozo n) con salida a un pin analógico y anillo p+
   alrededor: forma con la bomba, opera desde el pin a ≤ 1 mA.
