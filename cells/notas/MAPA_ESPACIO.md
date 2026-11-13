# Mapa del espacio de diseño: de dónde salen familias nuevas

Abierto el 2026-11-12 13:36 EST (hora de `date`). Método para explorar sin depender de la ocurrencia: el espacio es
G × M × P × U × E (geometría, materiales e interfaces, historia de fabricación y formación, excitación, entorno). Se cruza lo que
entra con lo que sale, se coloca cada familia en su casilla y se miran las casillas vacías. Una casilla vacía no es una celda:
es una pregunta. Es juicio del agente, sin verificar.

## Transducción: lo que entra (filas) frente a lo que se observa (columnas)

| Entra ↓ / Sale → | Eléctrico | Térmico | Magnético | Óptico | Mecánico | Estado (memoria) |
|---|---|---|---|---|---|---|
| **Eléctrico** | XC-20 túnel; XC-24 tiristor; XC-19 defecto único; XC-05 pocos canales | XC-39 calor Joule; **XC-57 Peltier** | XC-56 bobina | XC-26 unión; XC-21 avalancha | XC-55 fonones | XC-01 forja; XC-07 ruptura; XC-14 nodo flotante |
| **Térmico** | XC-39/40 Seebeck; **XC-58 kT/C** | XC-31 calor como canal | — | — | (dilatación → XC-44) | **XC-59 borrado térmico** |
| **Magnético** | XC-25 Hall; XC-52 espín; **XC-60 magnetodiodo** | — | — | — | — | — |
| **Óptico (interno)** | XC-26 fotodiodo; XC-14 pozo flotante | — | — | XC-27 red de hoyos | — | — |
| **Mecánico** | XC-44 piezorresistencia | — | — | — | XC-55 | — |
| **Historia de fabricación** | XC-12/13 esfuerzo y pozo; XC-14 plasma; **XC-62 impresión por proximidad** | — | — | — | — | XC-14 nace escrita |

Las casillas con raya siguen vacías: magnético → estado (no hay material magnético en la pila), óptico → estado (los fotones de
1100 nm no superan la barrera del óxido), térmico → magnético. Vacías no quiere decir imposibles.

## Las otras dimensiones

- **Materiales e interfaces (M).** Inventario: silicio de pozo y de sustrato, difusiones n+ y p+, poly, óxido de puerta de dos
  espesores, óxido de aislamiento, nitruro de los espaciadores `[?]`, siliciuro bajo los contactos (inferencia), tungsteno, TiN,
  aluminio con cobre y sus barreras, dieléctricos entre metales. Cada par en contacto es una interfaz. Sin familia todavía:
  **XC-63 contacto sin implante** (metal sobre silicio poco dopado), el nitruro del espaciador como almacén de carga (hoy dentro
  de XC-14), la interfaz aluminio/tungsteno del contacto (hoy dentro de XC-01).
- **Entorno (E).** Temperatura ambiente; calefactor en chip; 77 K; pocos kelvin: XC-54 (superconductividad),
  **XC-61 congelación de portadores**, y los puntos cuánticos por desorden en un transistor mínimo (variante de XC-06).
- **Excitación (U), en el tiempo.** Continua, pulsada, alterna síncrona, y el ruido como observable: el factor de Fano del ruido
  de disparo distingue túnel de difusión (prueba M9 de `PRUEBAS.md`).
- **Régimen.** La misma estructura cambia de región con la polarización: la unión de XC-20 es diodo en directa alta, túnel en
  inversa y quizá resistencia negativa en directa baja. Cada plan debe dar el mapa en polarización y temperatura, no solo en
  geometría.

## Altas que salieron de aquí (2026-11-12)

XC-57 unión Peltier, XC-58 celda kT/C, XC-59 escritura eléctrica y borrado térmico, XC-60 magnetodiodo, XC-61 oscilador por
congelación, XC-62 transistor impreso por proximidad, XC-63 contacto sin implante. Ninguna atacada todavía.
