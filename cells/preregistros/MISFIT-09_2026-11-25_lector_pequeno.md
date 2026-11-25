# MISFIT-09 · el lector pequeño dibujado: una fila de filtro (3 dedos) en vez de once

Escrito el 2026-11-25 12:48 EST (`date`), **antes** de tocar el generador o de dibujar la variante. Plan:
[`docs/MISFIT_PLAN.md`](../../docs/MISFIT_PLAN.md). Sigue a [MISFIT-07](../../experiments/misfit07/RESULTADOS.md) (la lectura no
necesita el filtro de 10 pF, probado **borrando dedos del netlist**). Aquí el macro se **dibuja** de verdad con menos filtro.

## Lo ya comprobado antes de escribir esto (control del generador)

`dibuja.sh` con `INVHVT=1 MOSU=1` reproduce el macro v_hm: los mismos 100 dispositivos y las mismas 187 capacidades extraídas,
con los mismos valores (solo cambia el orden de las líneas). Carpeta `cells/xc19_slot_core_a2/v_ctlhm`.

## Cambio

En `xc19_slot_core.tcl`, el número de filas del filtro pasa a leerse del entorno (`NROW`, por defecto 11: nada cambia sin la
variable). Variante `f3`: `NROW=1` (una fila de 3 dedos de 5,5 × 10 µm, ~1 pF), con `INVHVT=1 MOSU=1` como v_hm.
Se elige 3 y no 4 porque el generador dibuja filas de 3 dedos; MISFIT-07 probó 2 y 4 dedos, que lo acotan.

## Predicciones

| # | Predicción |
|---|---|
| S1 | DRC de Magic (estilo completo): 0 violaciones |
| S2 | Alto de la caja del macro: 20,6 ± 0,5 µm, y en todo caso ≤ 24,48 µm (la franja libre de un tile 1×1 junto al núcleo de hoy). Ancho: 58,2 µm, sin cambio |
| S3 | LVS (netgen) contra la referencia de v_hm con 30 dedos de filtro menos: "match" |
| S4 | KLayout, deck de fabricación y deck completo: 0 errores, como v_hm |
| S5 | Contrato sobre el macro extraído y anotado, 4 esquinas, frente a v_hm en el mismo deck: tA de `h01` dentro de 0,5 %; salto de una carga dentro de 2 % relativo; paso de calibración dentro de 2 % relativo; ln(tA/tB) dentro de 0,02 puntos de % |

## Controles

- **Control del deck:** la instancia con v_hm repite `h01` del contrato dentro de 0,01 % (A y B).
- **Testigo:** 1 fF ideal añadido en XA de una instancia del macro pequeño debe mover tA entre +0,4 % y +0,9 %: la comparación de
  S5 vería un cambio de layout de ese tamaño.
- **Mutante del LVS:** la referencia con 29 dedos menos (uno de más) debe dar "mismatch".

## Sigue / muere / inválido

- **Sigue** (hay lector para un tile): S1 a S5.
- **Muere:** el alto pasa de 24,48 µm, o S5 falla en alguna esquina. Un DRC o LVS con errores se arregla en el generador y se
  repite, anotándolo; no cuenta como muerte salvo que no tenga arreglo.
- **Inválido si:** falla el control del deck, el testigo o el mutante del LVS.

**Límites:** el macro pequeño conserva los dos condensadores de nodo y los bloques A/B tal cual; no se reordena nada para que
quepan dos lectores ni las ramas extra. Sin ruido. La capacidad real de VB con 3 dedos se reporta (análisis AC), sin predicción.

Tope: 40 min por deck (`timeout` dentro del contenedor). SHA en `experiments/misfit09/PREREG_SHA256.txt`.
