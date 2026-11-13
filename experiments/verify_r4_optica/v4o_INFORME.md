# v4o — Verificación independiente de la ronda 4 (XC-26 enlace óptico, XC-27 tapas, XC-21 ruptura)

Escrito: `date` = **Fri Nov 13 08:17:06 EST 2026** (mismo comando). Grado: **un verificador**, cálculo y simulación propios, nada medido.

## Cronología de lectura (regla de ceguera)
- Hasta **Fri Nov 13 08:15:07 EST 2026** (`v4o_NUMEROS.md`, hora en el mismo comando): solo encargo, `d21/d26/d27_PREREG.md`,
  `DATOS_PROCESO.md`, planes XC-26/XC-27, `05_exotic_lab/macros/photon/{LEEME.md,comun.tcl,emisor.tcl}`, modelos del PDK local,
  tabla α de Green-Keevers 1995 en pveducation.org. Ningún `d*.py/.txt/.json/_INFORME.md`.
- **Fri Nov 13 08:15:11 EST 2026**: leí `d26_INFORME.md`, `d27_INFORME.md`, `d21_INFORME.md`. No he leído los scripts ni las salidas
  del agente (`d26_*.py/.txt/.json`, `d27_*`, `d21_bv.*`).
- **Corrección posterior a la lectura (declarada):** en `v4o_NUMEROS.md` §2 leí el `js` del diodo `ps2nw` en A/m² (como dice el comentario
  del archivo), lo que da I_s ≈ 7e-23 A, físicamente imposible (I_s real de una unión de ~12 µm² ≈ 1e-16 A). El informe del agente lo lee en
  A/µm² (unidades efectivas con `scale=1e-6`). Es un error mío de unidades; lo corregí en `v4o_presupuesto_v2.py` (+ `expm1` para quitar un
  artefacto a polarización nula). `v4o_presupuesto.py/.txt` se conservan. Abajo uso v2; el cambio baja ~25–50 % mis umbrales con el pozo a 0 V
  y no toca F, R, η, tapa ni ruptura.

## Método propio (resumen)
- `v4o_grid.py`: volúmenes finitos 3D no uniformes (h 0,5 µm lateral, 0,25 µm en z cerca de la superficie, hasta 600 µm). Control:
  semiesfera colectora → P(R) a 7–12 % de a/R; resistencia de dispersión +7 % sobre ρ/(2πa) (`v4o_test_grid.txt`).
- F = ∫ g·P dV: P = probabilidad de recogida del photo (DNW 3×3) con todos los demás pozos n como sumideros (emisor, control, anillo DNW
  del marco), L de difusión, fondo sumidero; g = fuente isótropa con espectro de Planck generalizado y α de Green-Keevers, superficie como
  espejo (reflexión total) salvo el cono de escape con Fresnel. Comprobado por un segundo método (trazado de rayos, `v4o_tapa.py`): 2,44e-3
  frente a 2,45e-3.
- Sustrato: conducción 3D con pozos aislantes; taps = anillo p+ del photo (± guarda, ± taps lejanos, ± capa p superficial 0,2 Ω·cm × 1 µm [?]).
- Umbral de corriente: P_e·I_inj(V) = η·F·I, con P_e = 0,13 (electrón inyectado bajo el pozo, calculado) e I_inj de dos lecturas del PDK
  (base inversa del PNP IS/BR; diodo ps2nw). V = I·R·β/(β+1) − V_K, V_K = tensión del pozo (0 o 1 V).
- Ruptura: integral de ionización local (van Overstraeten-de Man) en plano, cilindro y esfera, con n+ a 0,27 µm (`v4o_ruptura.py`).

## Tabla de veredictos

| # | Afirmación del agente | Mi valor | Veredicto | Causa de la diferencia / supuesto escondido |
|---|---|---|---|---|
| 1a | α ponderado ≈ 12,4 cm⁻¹ | **16,2 cm⁻¹** (pico 1130 nm); 4,9 si la emisión sale del p+ con BGN 0,06 eV | reproducido al orden (×1,3) | Recorte o rejilla del espectro (el agente da FWHM 1035–1168). Escondido: ⟨α⟩ lo dominan las colas (mediana 3,1); si emite el p+ degenerado (BGN), α efectivo cae ×3–8 y F ×0,31 (0,06 eV) |
| 1b | F = 2,3e-3 / 1,5e-3 / 7,5e-4 / 2,3e-4 (5/10/20/44 µm) | base (L=100 µm): **2,45e-3 / 1,70e-3 / 9,7e-4 / 4,4e-4**; escenarios: 5 µm 1,4–2,7e-3, 20 µm 2,1e-4–1,25e-3, control 3,8e-5–6,8e-4 | **reproducido** a 5–20 µm (≤ 30 %); control reproducido solo para L ≈ 30 µm | Ningún error de orden de magnitud. Factores escondidos que el agente sí parece incluir: espejo de la superficie ×1,87; anillo DNW del marco ×0,40. El control depende de L y del fondo: con oblea epitaxial sobre p+ (fondo a 10 µm) cae a 3 % |
| 2a | R_sub 0,9 / 7,3 / 14 kΩ (ρ = 1/10/20) | homogéneo, solo el anillo del photo: **1,3–1,6 / 12,6–15,6 / 25–31 kΩ**; taps lejanos a masa: 6,3–9,4 (ρ=10); capa p superficial: 0,5–0,9 / 0,8–5,7 / 0,85–10,9 | reproducido al orden (×0,5–2) | La referencia de taps (no definida en la celda) y una capa p superficial mueven R ×2. La no linealidad del agente con ρ es compatible con una capa p de hoja fija |
| 2b | Sustrato sube 0,8–14 V por mA | 1,3–31 V/mA (homogéneo); 0,5–11 V/mA (capa p) | reproducido al orden | La misma |
| 2c | PNP satura desde 0,09 / 0,17 / 0,8–1,1 mA (ρ = 20/10/1) | pozo a +1 V: **0,04–0,06 / 0,09–0,11 / 0,9–1,2 mA**; pozo a 0 V: 0,007–0,012 / 0,015–0,026 / 0,20–0,31 mA | reproducido al orden **solo con el pozo a ~1 V** | Supuesto escondido decisivo: la tensión del pozo (dónde va el limitador). El agente usa ánodo a 1,8 V y pozo a ≤ 1 V con 0,3 V de margen; con cátodo a masa el umbral cae ×4–8 (el agente lo menciona: 6–8×) |
| 3 | η ≈ 1e-6 central (2e-8 – 2e-4) | **~1e-7 – 2e-5** a baja inyección (base: TF·B·N_D con TF = 0,615 ns del PDK; emisor p+); ×3–20 en la base a 0,17–1 mA por alta inyección | reproducido al orden | Mi techo es ~10× más bajo; el del agente incluye alta inyección extrema. B (Nguyen 2014) no lo leí: usé 4,7–9,5e-15 de memoria; el agente cita 4,68e-15 leída |
| 4a | 0,34–0,42 pA a 5 µm, ρ = 10 | η=1e-6: **0,21–0,28 pA** (pozo a +1 V); **0,04–0,06 pA** (pozo a 0 V); con guarda 0,4–1,2 pA | reproducido al orden con el pozo a +1 V; **no reproducido** con cátodo a masa | Además de V_K: η entra lineal y su intervalo es ×100. Con pozo a 0 V queda bajo el piso de 0,15 pA. El "SOBREVIVE con ρ ≤ 10" del agente depende de polarizar el pozo alto y de η ≥ ~1e-6 |
| 4b | 8–15 pA con ρ = 1 | η=1e-6: 2,2–2,9 pA (pozo +1 V); con η de alta inyección a ~1 mA (3e-6–1e-5): ~7–29 pA | reproducido al orden | Lineal en η(I); con cátodo a masa 0,5–0,8 pA × η/1e-6 |
| 4c | Muere con ρ ≥ 20 a 1,8 V (≈ 0,1 pA) | 0,10–0,14 pA (pozo +1 V); 0,02–0,03 pA (pozo 0 V) | **reproducido** | — |
| 4d | Piso 0,15 pA | No recalculado (es del modelo del lector, `PLAN.md`) | no verificable aquí | — |
| 5a | Cono de escape = 4,9 % de lo recogido | 3,7 % geométrico (3,0 % con la transmitancia de salida) | reproducido al orden | Peso de las direcciones verticales en la recogida; diferencia ×1,3 |
| 5b | Tapa lisa +3–4 % | **+1,2 % (Rm 0,5) … +2,3 % (Rm 0,95)**; ~+2,8 % contando los rebotes múltiples en la cavidad del óxido | reproducido al orden (×1,3–1,7 por debajo) | Yo aplico Fresnel a la salida y a la reentrada (T² ≈ 0,67); el agente parece aplicar T una vez (0,049 × 0,8). Conclusión igual: ≤ 4 % |
| 5c | Redes +0,2–3 % | Sin RCWA: solo cota ≤ cono (≲ 3–4 %) | no verificable (cota compatible) | — |
| 6a | Hueco legal 0,27 µm: baja ~15 % solo si pozo ≤ 1e17 | plano: 14,8 → 12,3 V a 1e17 (**−17 %**); ≥ 2e17: 0 %; 5e16: −41 %; 1e16: −78 % (55 → 12,4 V) | **reproducido** el umbral y el −15 % a 1e17; **mal enunciado** "−15 % como mucho" | Por debajo de 1e17 la bajada relativa es mucho mayor, pero el valor absoluto se queda en ≈ 12,4 V (el hueco recorta a E_c·0,27 µm). La conclusión física (el hueco no da tensiones bajas) se mantiene. Plano sin hueco idéntico al del agente (14,8 V a 1e17) |
| 6b | Esquina dibujada 5,6–9,7 V | esférica r_j 0,1–0,2 µm, N 1e17–5e17: **6,6–9,6 V** (6,1 a 1e18); cilíndrica 7,0–11,5; calibrada a bv del PDK (12,69 V → N 1,4e17): 8,0–10,4 V | reproducido al orden | El agente usó Sze-Gibbons de memoria (56–70 % del plano); yo integral numérica. Mi mínimo es 6,1 V, no 5,6. Modelo local sin espacio muerto ni túnel en los dos |
| 7a | Control a 40 µm ve el 10 % de la luz | 18 % (L 100 µm); 10 % (L 30); 3–25 % según L y fondo | reproducido (en el intervalo) | No es nulo óptico en ningún escenario mío salvo oblea epitaxial (3 %) |
| 7b | Anillo de DNW: luz ×0,54, portadores ×0,04 | No calculé el anillo **alrededor del emisor** (geometría no definida en el prerregistro). El anillo del marco existente: luz ×0,40, portadores ×0,55 | no verificable | Son dos anillos distintos; mi número no lo contradice ni lo confirma |

## Explicaciones aburridas revisadas (pedido del encargo)
- **Unidades:** ningún error de unidades en el agente en lo que pude reproducir; el único error de unidades lo cometí yo (`js` en A/m²).
- **Geometría:** la reflexión total en la superficie (×1,87), el anillo DNW del marco (×0,40) y el área efectiva del photo (DNW de 1,5–3,5 µm:
  ±13 %) no cambian F en un orden de magnitud. Lo que sí cambia órdenes: la tensión del pozo del emisor (umbral ×4–8) y η (×100).
- **Supuestos escondidos con peso:** (i) V_K, la posición del limitador; (ii) ρ y el tipo de oblea (no públicos); con epitaxial sobre p+ el
  control cae a 3 % y F a 20 µm ×0,2; (iii) que la luz salga del pozo y no del p+ degenerado (BGN: F ×0,3).

## Resumen (≤ 12 líneas)
1. F a 5–20 µm se reproduce (2,45e-3 / 1,7e-3 / 9,7e-4 frente a 2,3e-3 / 1,5e-3 / 7,5e-4) con código propio y dos métodos; α ponderado ×1,3.
2. R_sub, voltios por mA y umbral de saturación se reproducen al orden (×0,5–2), pero el umbral **solo** con el pozo polarizado a ~1 V.
3. η ~1e-6 se reproduce al orden (mi intervalo 1e-7–2e-5, techo ~10× más bajo que el del agente).
4. Fotocorriente: 0,21–0,28 pA (ρ=10, pozo a +1 V) frente a 0,34–0,42; con cátodo a masa 0,04–0,06 pA, **bajo el piso**.
   El "sobrevive con ρ ≤ 10" es frágil: depende de V_K, de ρ (no pública) y de η (lineal, ×100 de incertidumbre).
5. ρ = 20 muere en los dos cálculos (≈ 0,1 pA). ρ = 1 da pA en los dos.
6. XC-27: la tapa mueve ≤ 4 % en los dos cálculos (mío +1,2–2,8 %, agente +3–4 %); redes no verificadas (sin RCWA).
7. XC-21: plano 14,8 V y −17 % con hueco 0,27 a 1e17 reproducidos; "−15 % como mucho" está mal dicho (a ≤ 5e16 baja 40–78 %), pero
   el valor absoluto se queda en ~12,4 V, así que la conclusión se mantiene. Esquina: 6,6–9,6 V frente a 5,6–9,7.
8. Control a 44 µm: 3–25 % de la luz (18 % central): confirmado que no es nulo óptico. Anillo de DNW alrededor del emisor (×0,54/×0,04): no verificable.
9. No encontré errores de un orden de magnitud en el agente. El supuesto que más pesa y que el veredicto debe nombrar: la tensión del pozo del emisor.
