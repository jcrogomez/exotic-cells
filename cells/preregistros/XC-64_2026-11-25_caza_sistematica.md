# XC-64 · caza sistemática de islas: todas las parejas de capas, separación de 0,40 µm a 0

Escrito el 2026-11-25 13:25 EST (`date`), **después** de la [caza de cuatro sondas](XC-64_2026-11-25_caza_de_islas.md)
(sus cuatro predicciones se cumplieron: ninguna isla nueva; `experiments/xc64_hunt/islas.txt`) y **antes** de escribir el
escáner nuevo. Motivo: cuatro geometrías elegidas a mano no son una caza. Aquí se enumeran.

## Diseño

- **Capas** (tipos de Magic): nwell, ndiff, pdiff, psubdiff, nsubdiff, mvndiff, mvpdiff, mvpsubdiff, mvnsubdiff, poly, locali, metal1.
- **Parejas:** las 78 no ordenadas (incluidas las de una capa consigo misma), en **dos contextos**: sobre sustrato y dentro de un
  pozo n que las envuelve con 1 µm de margen. Total, 156 escaneos.
- **Geometría:** dos rectángulos de 1,0 × 1,5 µm, el segundo a la derecha del primero, separados por v. Sin contactos.
- **Dimensión:** v de 0,400 a 0,000 µm en pasos de 5 nm (81 puntos), más un punto lejano a 3,0 µm.
- **Chequeo:** Magic `drc(full)` sobre la celda entera. Como los rectángulos sueltos violan reglas ajenas a la separación (tomas,
  cierre de pozo), **un punto cuenta como "limpio" si su conjunto de reglas violadas está contenido en el del punto lejano**.
- **Isla** = tramo limpio que no llega hasta el punto lejano, separado de él por al menos un punto no limpio. Las islas se pasan
  después por el deck de fabricación de KLayout, punto por punto, con el mismo criterio relativo.

## Controles

- **Testigo:** (pdiff, nsubdiff) en pozo debe dar la isla de XC-20 en v = 0; (ndiff, psubdiff) en sustrato, la suya (toma pegada).
- **Negativo:** (metal1, metal1), (locali, locali), (poly, poly): una capa consigo misma se funde a v = 0. Eso aparece como isla
  en 0 y es trivial: se listan aparte como "fusión" y no cuentan.

## Predicción (falsable por lista)

Las únicas islas no triviales que aparecen son **difusión pegada a la toma de polaridad opuesta en el pozo que le corresponde**:
(pdiff, nsubdiff) en pozo; (ndiff, psubdiff) en sustrato; y sus versiones de alta tensión (mvpdiff, mvnsubdiff) en pozo y
(mvndiff, mvpsubdiff) en sustrato. **Cuatro, todas en v = 0, y ninguna otra.**

- **Cualquier isla fuera de esa lista** es un hallazgo: se mira su GDS, se pasa por KLayout y se anota como candidata.
- **Si falta alguna de las cuatro**, mi idea de cómo están escritas las reglas es incompleta, y se dice.
- **Inválido si:** falla el testigo de XC-20.

## Límites

Rectángulos sin contactos y sin puertas: no ve islas que necesiten tres capas (una puerta sobre algo), ni solapes (Magic
sustituye un tipo por otro al pintar encima), ni dimensiones que no sean la separación lateral. Solo dice qué acepta Magic; lo
eléctrico y lo fabricable quedan fuera. Es el primer barrido de una herramienta que puede enumerar más.

Tope: 40 min (`timeout` dentro del contenedor). SHA en `experiments/xc64_hunt/PREREG_SHA256.txt`.
