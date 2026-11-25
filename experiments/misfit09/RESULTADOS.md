# MISFIT-09 · resultados: el lector pequeño dibujado cabe en un tile y lee igual

Escrito el 2026-11-25 12:54 EST (`date`). Prerregistro: [`MISFIT-09_2026-11-25_lector_pequeno.md`](../../cells/preregistros/MISFIT-09_2026-11-25_lector_pequeno.md);
sello en `PREREG_SHA256.txt`. Macro: [`cells/xc19_slot_core_a2/v_f3/`](../../cells/xc19_slot_core_a2/v_f3/) (`NROW=1 INVHVT=1 MOSU=1 sh dibuja.sh f3`).
Números: `analiza_m9.py` → [`m9.txt`](m9.txt), escrito antes de ver salidas. 5 decks, ninguno abortó. Todo es modelo, nada es silicio.

## Lo aburrido primero

1. **El LVS no ve un dedo de más en su línea final.** netgen funde los dispositivos en paralelo y dice "Circuits match uniquely"
   aunque la referencia tenga 4 dedos y el layout 3; el error solo sale como "Property errors were found". El mutante se
   detecta por esa línea, que el resumen de `check.sh` no mira. Ningún informe de LVS anterior del repo la tiene (revisado).
2. `annotate.py` copiado a la carpeta de la variante apunta mal a Residual (un nivel de menos); se corrió una copia con la ruta
   corregida (`annotate_v.py`). El de v_hm debió de correrse de otra forma `[?]`.
3. El macro pequeño es el de siempre con menos filas de filtro: no se reordenó nada.

## Veredictos, con las palabras del prerregistro

| # | Resultado | Veredicto |
|---|---|---|
| S1 | DRC de Magic (completo): 0 violaciones | cumplida |
| S2 | caja de 58,2 × 20,695 µm (1204 µm²; antes 58,2 × 95,7 = 5570) | cumplida (20,6 ± 0,5 y ≤ 24,48) |
| S3 | LVS contra la referencia con 3 dedos: "match uniquely", sin errores de propiedad. Mutante (4 dedos): errores de propiedad | cumplida |
| S4 | KLayout: 0 en el deck de fabricación y 0 en el completo | cumplida |
| S5 | frente a v_hm, en 4 esquinas: tA +0,030 a +0,053 %; salto de una carga +0,03 a +0,14 % relativo; paso de calibración −0,03 a −0,07 % relativo; ln(tA/tB) dentro de 0,0004 puntos | cumplida |

Benchmark válido: el control repite el contrato en los 4 decks (+0,0000 %), el testigo de 1 fF mueve tA +0,65 a +0,70 %, el
mutante del LVS se detecta, y el generador sin la variable reproduce v_hm (mismos 100 dispositivos y 187 capacidades).

**Sigue:** hay lector para un tile.

## Capacidad de VB (AC, tt 27, sin predicción)

| Macro | C en VB | R de la cadena |
|---|---|---|
| v_hm, 33 dedos | 10,156 pF | 675–679 kΩ |
| v_f3, 3 dedos | 0,958 pF | 677–679 kΩ |

El valor de v_hm repite el del canal viejo (10,14 pF, 678 kΩ, `cells/xc19_channel_caps/README.md`): sirve de control del método.
Cierra una de las dos dudas de MISFIT-07: con 3 dedos quedan 0,96 pF, de los que ~0,05 pF no son de los dedos (aritmética: 3/33
de 10,156 son 0,92).

## Qué se lleva el tile

Lector de 1204 µm² y 20,7 µm de alto. En la franja libre de hoy (161 × 24,48 µm) caben **dos lectores de lado a lado** (116,4 de
161 µm de ancho), sin contar pasillos ni las ramas extra. Es aritmética: no están colocados.

## ¿Qué explicación aburrida no descarté?

- Ruido con 1 pF de filtro en vez de 10 (R5), dos lectores en un mismo VB (R3) y muchas ramas (R6): no entran aquí.
- La otra duda de MISFIT-07 sigue abierta: por qué el golpe sobre VB no escala como 1/C.
