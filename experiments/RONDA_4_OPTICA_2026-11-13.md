# Ronda 4 — óptica interna (XC-26, XC-27, XC-21/22), 2026-11-13

Ataque: `attack_xc26_27_21/` (d26, d27, d21; un agente, cerrado 07:40). Verificador independiente:
`verify_r4_optica/` (números fijados 08:15:07, leyó los informes 08:15:11, no abrió scripts). Consolidado 08:17.
Todo es cálculo y simulación; nada medido. Grado máximo: **verificado al orden** (dos agentes, código propio).
La resistividad del sustrato no es pública: todo lo que depende de ella es escenario, no número.

| Afirmación | Agente | Verificador | Grado |
|---|---|---|---|
| Fracción recogida F a 5/10/20 µm | 2,3e-3 / 1,5e-3 / 7,5e-4 | 2,45e-3 / 1,70e-3 / 9,7e-4 (dos métodos, 1 %) | verificado |
| α ponderado por espectro | 12,4 cm⁻¹ | 16,2 cm⁻¹ | verificado al orden (×1,3) |
| Si la luz sale del p+ con banda estrechada | — | F ×0,31 | un agente (verificador) |
| R sustrato bajo el pozo, ρ=10 | 7,3 kΩ | 12,6–15,6 kΩ (homogéneo) | verificado al orden; depende de taps de referencia y capa p superficial |
| Umbral de saturación del PNP | 0,09/0,17/0,8–1,1 mA (ρ=20/10/1) | igual **solo con el pozo del emisor a ~1 V**; con cátodo a masa ×4–8 menor | verificado con condición |
| η de emisión | ~1e-6 (2e-8 a 2e-4) | ~1e-7 a 2e-5 (TF 0,615 ns del PDK) | verificado al orden; techo ×10 menor |
| Fotocorriente a 5 µm, ρ=10 | 0,34–0,42 pA | 0,21–0,28 pA con pozo a +1 V; 0,04–0,06 pA con cátodo a masa (bajo el piso 0,15 pA) | verificado con condición |
| ρ ≥ 20 a 1,8 V | ≈0,1 pA, muere | ≤0,1 pA, muere | verificado |
| XC-27 cono de escape | 4,9 % de lo recogido | 3,7 % | verificado al orden |
| XC-27 tapa lisa | +3–4 % | +1,2–2,8 % (Fresnel a salida y reentrada) | verificado al orden |
| XC-27 redes | +0,2–3 % | ≲3–4 % (sin RCWA) | un agente |
| XC-21 ruptura plana sin hueco, 1e17 | 14,8 V | 14,8 V | verificado |
| XC-21 hueco 0,27 µm | baja ≤15 %, solo si pozo ≤1e17 | −17 % a 1e17; con pozo ≤5e16 baja 41–78 % relativo pero el absoluto queda ≈12,4 V | **[corregido] "como mucho −15 %" mal dicho**; conclusión (el hueco legal no es perilla útil) se mantiene |
| XC-21 esquina dibujada | 5,6–9,7 V | 6,6–9,6 V | verificado al orden |
| Control a 44 µm | ve ~10 % de la luz | 3–25 % (18 % central) | verificado: no es nulo óptico |
| Anillo DNW alrededor del emisor | luz ×0,54, portadores ×0,04 | no verificable (geometría fuera del prereg); anillo del marco: luz ×0,40, portadores ×0,55 | un agente |
| XC-21 con bomba, 100 µA, 5–20 µm | 3–37 pA (eficiencia de 65 nm) | no verificado | un agente |

## Qué cambia

- **XC-26 vive con condición explícita**: el pozo del emisor polarizado a ~+1 V (donde va el limitador) y ρ ≤ 10 Ω·cm.
  Con el cátodo a masa la señal cae bajo el piso. η entra lineal con intervalo ×100: el diseño necesita la
  tensión del pozo como perilla de la celda, no como detalle. Frontera superior: saturación del PNP vertical
  (inyección de electrones que tapa la luz). El control lejano no es nulo óptico: el control de "sin luz" tiene
  que ser otro (emisor apagado o tapado), no la distancia.
- **XC-27 transformada**: efecto del metal de pocos %; pide ≥5 pA de señal y apareamiento <1 % entre copias.
  Solo tiene sentido si XC-26 da del orden de pA (ρ ≈ 1).
- **XC-21**: separación legal como perilla, muerta. Esquina dibujada (6,6–9,7 V) sí. Con bomba, viva a nivel
  de un agente. Sin bomba a 1,8 V, abierta y probablemente bajo el piso.
- **XC-22 (SPAD)**: necesita 9–18 V. El agente propone otro vehículo; **no se decide aquí** (decisión de Juan;
  regla: catálogo abierto, filtrar al final).

## Errores declarados
- Agente: parte (2) de `d26_fd.py` errónea, la sustituye `d26_sub.py`.
- Verificador: leyó `js` de `ps2nw` en A/m² (comentario del archivo) → Is ≈ 7e-23 A; corregido a A/µm² en
  `v4o_presupuesto_v2.py`, original conservado. Solo mueve umbrales con pozo a 0 V.

## Abierto `[?]`
Resistividad real del sustrato; efecto del potencial de sustrato sobre el lector (sin simular); redes de XC-27
con RCWA (grcwa instalado); geometría del anillo DNW; eficiencia de emisión en avalancha de SKY130.
