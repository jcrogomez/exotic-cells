# MISFIT-04 · I1 · el tile 1×2 limpio

| Comprobación | Resultado | Archivo |
|---|---|---|
| Magic `drc(full)` sobre el GDS releído | 0 violaciones | `tile_drc.txt` |
| LVS del tile (netgen): núcleo + celdas estándar + wrapper + macro de 96 dispositivos, contra `top_ref.v` y `ref.spice` escritos a mano | "Circuits match uniquely", 0 errores de propiedades | `tile_lvs.rpt` |
| Precheck de Tiny Tapeout (tt-support-tools 01d5d28, PDK 0536d02d, contenedor `tt-precheck-local:ttsky26d`) | 15 de 15 | `precheck_results.md` |

**Hallazgo en el primer intento del precheck:** falla la prueba de pines. Tiny Tapeout exige que cada pin de alimentación llegue a
menos de 10 µm del borde inferior, y las tiras de met4 se cortaban a 127,4 µm para no pasar sobre el macro. La regla obliga a que
al menos una tira por alimentación recorra toda la altura del tile.

Arreglo: los pines son las tiras del núcleo en x = 96,02 (VPWR) y 99,32 (VGND), fuera de la columna del slot (x 6,4–64,6). Las
tiras que alimentan el macro bajan solo hasta encima de él.

**Consecuencia para llenar el chip:** las tiras van cada 38,87 µm y al menos un par debe recorrer el tile entero. Cada columna de
slots tiene que caer entre tiras de altura completa, o aceptar una tira encima con el mismo acoplo en A y en B.
