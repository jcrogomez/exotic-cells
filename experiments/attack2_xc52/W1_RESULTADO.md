# XC-52 · W1 · resultado de la lectura: `[?]`, inclinado a muerte

Escrito el 2026-11-24 12:29 EST (`date`). Prerregistro:
[`XC-52_2026-11-24_W1_trampas_por_estres.md`](../../cells/preregistros/XC-52_2026-11-24_W1_trampas_por_estres.md), sellado a las
12:19:29. La lectura la hizo un agente aparte.
- Comprobé en el texto de Ryan 2009 que Dit pasa de 7e9 a 5e11 cm⁻²eV⁻¹ tras el estrés, y a 9e10 con flúor, junto con las frases
  "locking-in" y "not dominated by Pb centers".
- Los 5 DOI coinciden en Crossref.

## Veredicto, con las palabras del prerregistro

**`[?]`.** Ninguna fuente aplicable da ΔNit ≥ 1e11 cm⁻² a ≤ 4,3 MV/cm, ≤ 85 °C y ≤ 10 h. Tampoco todas quedan por debajo de
3e10.

## Fuentes

| Fuente | Condiciones | ΔNit / Dit | ¿Pb por resonancia? | Grado |
|---|---|---|---|---|
| Ryan et al., IRPS 2009 (10.1109/irps.2009.5173396) | pfet, SiO2 de 7,5 nm, ~7,6 MV/cm, 140 °C, 250 000 s | Dit de 7e9 a 5e11 cm⁻²eV⁻¹ | sí, Pb0 y Pb1 | leído |
| Mahapatra, tutorial de 2012 (nanoHUB 13165), diapositiva 4 | SiON, 125 °C, 6,6–8,3 MV/cm, tiempo  | por bombeo de carga, 0,2–0,55e10; por DCIV, 1–4e10 | no | leído (figura) |
| Mismo tutorial, modelo de reacción-difusión | EOT 2,35 nm, 125 °C | ~7e10 a −1,4 V y 10 h. Es el ajuste del modelo, no una medida; la conversión a cm⁻² es inferencia | no | leído (figura, ±50 %) |
| Moxim et al., APL 2022 (10.1063/5.0077946) | 7,5 nm, temperatura ambiente, 10,7–12 MV/cm | 4e11 a 1,3e12; sin NZFMR antes del estrés | sí | leído |
| Sharov et al., TDMR 2022 (10.1109/tdmr.2022.3186232) | 12 MV/cm | señal antes del estrés por debajo del límite de detección | sí | leído |

## Lo aburrido

1. **El ΔVth a campo bajo puede ser carga de huecos y no Pb: no descartado.**
   - En la misma figura del tutorial, el bombeo de carga y el DCIV difieren ×5.
   - En óxidos nitrurados, el NBTI no está dominado por Pb (Ryan, leído). La nitruración de SKY130 es `[?]`.
2. **La recuperación tras el estrés: no descartada.** Ryan enfría bajo polarización para fijar el daño ("locking-in"). En el chip
   sería apagar el calefactor manteniendo −1,8 V (inferencia).
3. **La sensibilidad de "< 1000 defectos" no se aplica a nosotros:** se confirma. Es SNR ≈ 1 con matrices de 1800–5000 µm²
   dañadas a campo alto, imán de laboratorio de ±10 mT, amplificador lock-in y ~20 h de promediado (tesis de Allridge, OSTI 2480092,
   leído por el agente).

## Lectura (inferencia, no medida)

- El campo real del chip es ~3 MV/cm, si |VT| ~0,5 V; el VT de SKY130 es `[?]`.
- Las medidas directas, extrapoladas, dan ~1e9 cm⁻²: muerte.
- El modelo de reacción-difusión da ~5–7e10: `[?]`.
- **Con el estrés a 1,8 V, XC-52 depende de que el modelo acierte y la medida no. Es un apoyo débil.**

## Qué lo cerraría

- **Una medida:** ΔNit por DCIV (diodo con puerta) o por bombeo de carga, sin pasar por ΔVth, en un pfet SKY130 de 1,8 V, antes y
  después de −1,8 V a 85 °C durante 10 h, con enfriamiento bajo polarización. Se puede hacer en el chip como etapa previa de XC-52.
  Ese chip sería el primero.
- **En papel:** el texto completo de Mahapatra IRPS'11 o Joshi IRPS'12 (con el tiempo de estrés), o cualquier ΔNit por bombeo de
  carga o DCIV a ≤ 5 MV/cm en SiO2 de ~4 nm.
