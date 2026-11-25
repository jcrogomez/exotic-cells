# MISFIT-06 · enmienda 1 · B1b: reservar el metal 4 con una obstrucción, dejando la banda de los pines

Escrita el 2026-11-25 12:01 EST (`date`), **después** de ver el resultado de `m3` y **antes** de lanzar `obs`.
**No rescata B1:** el veredicto de la corrida `m3` queda como salió (A2 falsa: 34 errores de área mínima en metal 3; A4 falsa:
el rutado bajó 5,9 %, fuera de mi banda de 0 a +5 %). Esto es una prueba nueva. Motivo: Juan (2026-11-25) decide apostar por el
metal 4 sobre el núcleo y bajar a un solo tile.

## Lo que se vio en `m3` (exploración)

Las 34 cajas de error están todas en y = 86,5–86,9 µm, el borde superior del bloque, donde están los 43 pines de metal 4 (los
del tile de Tiny Tapeout). Con el límite en metal 3, el enrutador llega a esos pines con parches de metal 3 menores que el área
mínima (met3.6). El resto del bloque rutea limpio. En `ctl`, 76 de los 183 puntos de metal 4 de señal caen por debajo de y = 60.

## Diseño

Copia `obs` del núcleo, con `RT_MAX_LAYER` = met4 (como `ctl`) y una obstrucción de rutado en metal 4 sobre x 0–161, y 0–80 µm
(`ROUTING_OBSTRUCTIONS`). Queda libre para el enrutador la banda y 80–87,04, la de los pines. Control: el `ctl` ya corrido.

## Predicciones

| # | Cantidad | Predicción |
|---|---|---|
| O1 | `obs` termina; DRC de Magic 0; LVS 0; holguras de setup y hold ≥ 0 | sí a todo |
| O2 | metal 4 de señal por debajo de y = 80 µm en el DEF final | 0 µm |
| O3 | rutado frente a `ctl` | entre −8 % y +5 % |

## Sigue / muere / inválido

- **Sigue:** O1 y O2. Ventana reservada: 80 µm de alto por los huecos entre franjas de alimentación (148,2 µm de ancho en total)
  = 11 856 µm² de metal 4, en bruto.
- **Muere:** no termina, o deja errores de DRC, LVS o tiempos. Entonces el metal 4 sobre el núcleo no es gratis y se dice cuánto cuesta.
- **Inválido si:** la obstrucción no se aplica (el DEF sigue teniendo metal 4 de señal por debajo de y = 80 con la opción puesta
  y sin errores): sería un fallo de configuración, no un resultado.

**Límites declarados:** que el enrutador lo deje libre no dice que sea usable. Faltan el acoplo del núcleo hacia lo de encima (B4),
las reglas de densidad de metal y que el LEF del bloque exporte la ventana como libre para el nivel del tile.

Tope: 20 min. SHA en `experiments/misfit06/PREREG_SHA256.txt`.
