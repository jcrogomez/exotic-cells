# Catálogo de pruebas

Qué pruebas existen y a qué familias activas se aplican. Una prueba que produce un número lleva su predicción escrita antes.
Estado: **hecha** (con carpeta en `experiments/`), **lista** (la herramienta está), **por montar** (hay que instalar o escribir).

## Simulación física

| Código | Prueba | Qué responde | Herramienta | Estado |
|---|---|---|---|---|
| S1 | Litografía, imagen aérea | Qué se imprime frente a lo dibujado | `experiments/litho_explore/litho.py` | hecha, primera pasada |
| S2 | Implante y difusión lateral | Perfil de dopado en una frontera | numpy, por escribir | por montar |
| S3 | Dispositivo, deriva-difusión con túnel | I–V de uniones y estructuras sin modelo en el PDK | DEVSIM (instalable) | por montar |
| S4 | Electrotérmica | Temperatura y densidad de corriente en cuellos, codos, contactos, resistores | scikit-fem (instalable) | por montar |
| S5 | Electromigración (Korhonen 1D) | Tensión mecánica y tiempo a vacío frente a corriente y largo | numpy, por escribir | por montar |
| S6 | Óptica de redes y aperturas | Reflexión y difracción frente al paso | grcwa (instalable), openEMS (imagen Docker) | por montar |
| S7 | Campo magnético (Biot–Savart) | Campo de una espiral dibujable | numpy, por escribir | por montar |
| S8 | Acústica (matriz de transferencia) | Bandas y modos de una rejilla metal/óxido | numpy, por escribir | por montar |
| S9 | Circuito con modelo añadido | La celda con su lector y su control | ngspice | lista |
| S10 | Ruido y detección | Si el evento se distingue del ruido, y en cuánto tiempo | `experiments/xc19_noise` | hecha para XC-19 |

## Layout y reglas

| Código | Prueba | Qué responde | Estado |
|---|---|---|---|
| L1 | Borde legal | Dónde está el límite de una dimensión y qué regla lo pone | hecha para seis geometrías (`residual/drc_edge`) |
| L2 | Mapa del precheck | Qué rupturas de regla acepta y cuáles rechaza el precheck del shuttle | por correr (el precheck local existe) |
| L3 | Generador paramétrico y DRC en dos decks | Que el barrido se dibuja y qué violaciones tiene | lista |
| L4 | Extracción, LVS y Residual | Que el dispositivo extraído es el dibujado, con su contexto | lista |

## Mesa

| Código | Prueba | Qué responde |
|---|---|---|
| M1 | Estado virgen | Punto de partida de cada canal |
| M2 | Calibración independiente del fenómeno | Que el lector ve lo que debe |
| M3 | Barrido de polarización | Curva de respuesta |
| M4 | Temperatura | Ambiente, calefactor en chip, nitrógeno líquido (77 K), criostato |
| M5 | Series temporales | Niveles discretos, residencias, deriva |
| M6 | Formación | Transformar con corriente o tensión, con llave |
| M7 | Campo magnético | Microbobina en chip, e imán externo como comprobación |
| M8 | Retención y repetición | Si el estado dura y se reproduce |
| M9 | Ruido como observable | Varianza frente a capacidad y temperatura; factor de Fano del ruido de disparo (túnel frente a difusión) |

## Qué prueba toca a cada familia activa

| Familia | Simulación | Layout | Mesa |
|---|---|---|---|
| XC-05 contacto de pocos canales (con la forja XC-01) | S1, S4, S5, S9 | L1–L4 | M1, M2, M5, M6, M8; M4 a 77 K |
| XC-06 isla de Coulomb autoformada | S9 | — | M3, M4 a 77 K |
| XC-07 ruptura de óxido y filamento | S3, S9 | L3, L4 | M3, M6, M8 (con XC-53) |
| XC-14 nodo flotante | S3, S9 | L2–L4 | M1, M4, M5, M8 |
| XC-18 transistor de óxido de campo | S3 | L1, L3 | M3 (con XC-53) |
| XC-19 defecto único | S9, S10 | L3, L4 | M2, M3, M4, M5 |
| XC-20 unión túnel | S2, S3, S9 | L1–L4 | M3, M4, M5 |
| XC-21 avalancha y Geiger | S3 | L3 | M3 (con XC-53) |
| XC-24 bipolar parásito | S3, S9 | L3, L4 | M3, M5 |
| XC-25 placa Hall con bobina | S7, S9 | L3, L4 | M7 |
| XC-26 enlace óptico interno | S3, S6 | L3, L4 | M3, M5 |
| XC-27 red de hoyos en reflexión | S6 | L2, L3 | M3 |
| XC-39 calor como señal | S4, S9 | L3 | M5 |
| XC-52 pares de espín | S7, S9, S10 | L3, L4 | M5, M7 |
| XC-54 interconexión superconductora | — | — | M4 en criostato |
| XC-55 fonones en la pila | S8, S9 | L3 | M3 |
