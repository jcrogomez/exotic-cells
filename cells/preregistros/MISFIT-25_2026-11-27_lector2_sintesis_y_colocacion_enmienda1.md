# MISFIT-25 · enmienda 1 · sin reparación de diseño tras la colocación

Escrita el 2026-11-27 (hora de sellado en `experiments/misfit25/PREREG_SHA256.txt`), **después** de la pasada 1
(`experiments/misfit25/m25.txt`, que se queda como está) y **antes** de la pasada 2.

## Qué pasó en la pasada 1

- `prot` **no termina**: en `OpenROAD.RepairDesignPostGPL` el flujo quiere meter un búfer en una red marcada como
  intocable y sale con `[RSZ-3006] Failed to insert buffer`. H1 y H2 **falsas** en esta pasada; H3 sin dato.
- `libre` termina limpia (DRC 0, LVS 0, antenas 0, 53,4 × 64,1 µm) y **toca el lazo**: un búfer en la entrada `x`
  (`input5`), búferes en las salidas `prenh` y `prenl`, y un búfer `max_cap10` dentro del lazo, entre `q` y el primer
  retardo. H4 **cumplida**; la prueba es válida.
- Fallo de mi análisis, visto en el netlist de `libre`: la red `q` se llama `ck[0]` tras la síntesis (es el reloj del
  primer biestable) y el análisis la buscaba como `u_loop.q`. Para `libre` no cambia el veredicto (las celdas de más
  salen por otra lista), pero en `prot` habría dado un falso fallo de H2.

## Cambios

1. **Configuración** (`instrument/reader2/config.json`): `RUN_POST_GPL_DESIGN_REPAIR` = 0. Se mantienen las tres
   protecciones. Motivo: el bloque no tiene reloj; la reparación de pendientes y abanicos trabaja contra restricciones
   que aquí no significan nada, y es la que choca con la lista de no tocar.
2. **Análisis** (`analiza25.py`): `ck[0]` se trata como la red `q`. Nada más.

Variante `libre` no se repite: ya hizo de testigo.

## Predicciones (las mismas, para la pasada 2, carpeta `misfit25_r2_prot_e1`)

| # | Predicción |
|---|---|
| H1 | `prot` cierra limpio: termina, DRC de Magic 0, LVS 0, 0 redes con violación de antena |
| H2 | Las 17 celdas del lazo con su tipo y cada red del lazo con las conexiones del RTL; ningún búfer ni diodo en ellas |
| H3 | Área entre 1000 y 3000 µm² (apuesta más floja ahora: `libre` dio 3426 µm² con sus 12 búferes) |
| H5 (nuevo) | En todo el bloque no queda ningún búfer añadido por el flujo (lista vacía) |

Reglas de decisión, las del prerregistro. Queda una enmienda más.
