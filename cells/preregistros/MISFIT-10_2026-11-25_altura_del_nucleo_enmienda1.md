# MISFIT-10 · enmienda 1 · rejilla fina: 31, 30 y 29 filas

Escrita el 2026-11-25 hacia las 13:00 EST (la hora exacta de sellado, de `date`, está en `experiments/misfit10/PREREG_SHA256.txt`),
**después** de la primera tanda y **antes** de lanzar la segunda.

## Qué pasó (se queda como está)

Las 8 corridas (lean a 28, 26, 24, 22 y 20 filas; original a 26, 24 y 22) fallaron en menos de un minuto, en la colocación
(`experiments/misfit10/m10.txt`). A 28 filas con el lean: región de 10 996 µm², instancias móviles 9943 µm², ocupación 93,7 %, y
falla la colocación detallada. A 26 filas, 101,6 %; a 20 filas, 135 %. Veredictos: H1, H2 y H4 **falsas**; H3 cumplida; H5 no
decidible. Por la regla escrita ("inválido si el lean a 28 filas no cierra") el **benchmark es inválido**, aunque la causa no es
ajena a la altura: el bloque está más lleno de lo que supuse.

**Mis errores de partida:**
1. Leí "área de celdas 8238 µm² en un bloque de 14 013" como holgura. El área útil del bloque es 12 687 µm² (márgenes), y el
   colocador trabaja con ~9900 µm² (área inflada para poder rutar).
2. Fijé `PL_TARGET_DENSITY_PCT` por tabla; a 28 y 26 filas el flujo avisa de que es demasiado bajo para el hueco disponible.
3. **Di por hecho que el lean ocupa menos al colocar. Es al revés:** a 24 filas el lean da 110,8 % de ocupación y el original
   107,2 %. El lean sale de síntesis un 2,8 % mayor; su ahorro del 9 % aparece después, porque necesita menos buffers de
   reparación (MISFIT-08). Para caber en menos filas, lo que cuenta es el tamaño al colocar.

## Prueba nueva

Lean y original a **31, 30 y 29 filas** (84,32 / 81,60 / 78,88 µm), con la obstrucción de metal 4 escalada como antes y
`PL_TARGET_DENSITY_PCT` **sin fijar** (que lo calcule el flujo). Referencia: 32 filas cierra limpio con los dos (MISFIT-06 `obs`
con el original; MISFIT-08 con el lean, sin obstrucción).

Cuenta previa, poco fiable (el área que ve el colocador está inflada y no sé cuánto): a 29, 30 y 31 filas la región mide
11 418, 11 841 y 12 264 µm²; con 9943 µm² del lean son 87, 84 y 81 %, y con ~9620 del original, 84, 81 y 78 %.

| # | Predicción (apuestas de baja confianza) |
|---|---|
| J1 | Los dos cierran limpio a 31 filas |
| J2 | El lean cierra limpio a 30 filas |
| J3 | El original cierra limpio a 30 filas |
| J4 (testigo) | A 29 filas falla al menos uno de los dos: la rejilla aprieta |

- **Qué se adopta:** la regla de antes, mínimo que cierra limpio más 2 filas de margen.
- **Lectura ya fijada:** con esa regla el bloque suelta como mucho 1 fila. El criterio "sigue" de la prueba original (≥ 4 filas)
  **no se puede cumplir**. Esta tanda solo mide dónde está el borde y cuál de las dos versiones llega más abajo.
- **Inválido si:** falla J4 y los dos cierran en los tres puntos (la rejilla no separa nada; habría que bajar a 28 con densidad
  libre).

Tope: 20 min por corrida, con parada del contenedor.
