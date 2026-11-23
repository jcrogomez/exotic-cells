# MISFIT · arquitectura mínima para fabricar, atlas y de respuesta a celda

2026-11-23 (`date`: 07:40 al empezar). Respuesta a una revisión externa pegada por Juan ("de investigar anomalías a descubrir
funciones"). **No congela nada.** Es una propuesta con su evidencia; lo que decide Juan está marcado. Todo es modelo o aritmética.

## 0. Qué verifiqué de la revisión

| Afirmación | Veredicto |
|---|---|
| El núcleo ocupa ~10 800 µm² con relleno, en un 1×1 de ~17 950 µm², y deja una franja de 24 µm | correcta (`instrument/misfit02/README.md`; 1×1 = 161,00 × 111,52 µm en `tile_sizes.yaml`) |
| 1×2 de ~160 × 225 µm y 2×2 de ~334 × 225 µm | correcta: 161,00 × 225,76 y 334,88 × 225,76 (`local_flow/tt-support-tools/tech/sky130A/tile_sizes.yaml`) |
| El 0,8 % de ~30 µs son ~240 ns, unos 12 periodos a 50 MHz; la cuantización no es el obstáculo principal | **cierta solo a tt 27 °C.** Con la polarización fija, en ff 85 °C la descarga dura 2,57 µs y el salto de una carga son **0,8 cuentas**: ahí la cuantización sí es el obstáculo ([`diseno_slot_analisis.txt`](../xc19_slot/diseno_slot_analisis.txt)) |
| Restar gemelos no da una placa limpia | correcta, y peor de lo que dice. Ninguna calibración capacitiva equivale a una carga entre esquinas: el cociente calibración/trampa va de 0,72 a 1,28 (un interruptor) y de 0,34 a 0,58 (gemelos). La trampa es ΔV/(n·kT/q); el condensador es ΔC/C. Esto corrige `xc19_caps` §4.2 (anotado) |
| Escalera de 0, 1 y 2 unidades para probar linealidad | adoptada. Diseño: la 2.ª unidad pesa 1,002–1,039 veces la 1.ª en las cuatro esquinas |
| ABBA y orden aleatorio | adoptado como protocolo de adquisición (software del host). No cancela diferencias estructurales; sí estima la deriva lenta |
| Separar canales lógicos de experimentos físicos | apoyada por el cálculo: cada interruptor abierto colgado del nodo añade un 0,08–0,18 % de tiempo, constante hasta N = 32. El salto de trampa es un cociente de corrientes y no se diluye. **Pero:** la fuga real de 32 interruptores abiertos no está en el modelo (`[?]`). Y multiplexar el **DUT** (un interruptor en serie con la descarga) no es lo que se simuló |

## 1. Área (aritmética sobre números del repo)

| Tile | Área | Libre tras el núcleo | Canales XC-19 de 3244 µm² que caben **en bruto** |
|---|---|---|---|
| 1×1 | 17 955 µm² | 7155 µm² (pero en una franja de 24 µm de alto) | 0 en la práctica: la celda mide 34,5 × 94 µm |
| 1×2 | 36 347 µm² | 25 547 µm² | 7 |
| 2×2 | 75 603 µm² | 64 803 µm² | 19 |

"En bruto" no cuenta el rutado, la red de alimentación de met4 (franjas cada 38,87 µm) ni las obstrucciones. El factor real es `[?]`
hasta que MISFIT-04 coloque un canal.

## 2. Decisión técnica propuesta: la arquitectura mínima que merece fabricarse

**MISFIT-min, en un 1×2** (2×2 solo si se cumple la condición de abajo):

1. **El núcleo del instrumento** (ya existe, 13 pruebas cocotb) con el canal 7 de referencia digital interna: prueba la captura y el
   rango sin física desconocida.
2. **Un slot XC-19 completo** (MISFIT-03): A/B gemelos, escalera diferencial de referencia, `en` que lo vuelve inerte y ajuste de
   polarización (etapa b).
3. **Un slot de metrología pasiva** con el **mismo diseño de lector**, multiplexando estructuras que no necesitan física nueva: la
   matriz LOD (el único resultado que ya es un hecho), las tiras Kelvin de n+, p+, poly y li (la comprobación de A1), los pares de
   poly densos/aislados de XC-62 (R1) y la escalera de capacidades. Aunque XC-19 no muestre ninguna trampa, este slot devuelve datos
   sobre el proceso.
4. **XC-14**, solo si su prerregistro existe antes del cierre y su integración garantiza que el reset y la calibración no
   polarizan sus nodos antes de la primera lectura (fila 4 de RISKS).
5. **Fuera de MISFIT-min:** XC-20 (le falta un lector de rango amplio, fila 14 de RISKS) y XC-01 (pulsos de mA: alimentación y
   protección aparte, y siempre al final). Pasan a 2×2 o a un segundo vehículo.

**Condición para 2×2:** que exista el lector de rango amplio de XC-20 con su prerregistro cumplido. XC-20 sigue siendo el primero
del ranking; dejarlo fuera de la versión mínima es una decisión de **orden**, no de valor. **Decide Juan.**

Por qué así: el primer silicio tiene dos misiones, metrología y descubrimiento. El punto 3 garantiza la primera aunque fallen
todas las apuestas exóticas.

## 3. Pruebas que faltan antes del silicio (posibles)

| Prueba | Dónde |
|---|---|
| Slot XC-19 extraído contra el contrato, con fallos inyectados | MISFIT-03 etapa a (prerregistrado) |
| Ajuste de polarización entre esquinas, con Monte Carlo de desajuste del paso de unidad | MISFIT-03 etapa b (por escribir) |
| Multiplexar DUT en serie: cuánto cambia la corriente y el salto | por prerregistrar, antes del slot de metrología |
| Fuga de N interruptores abiertos según el modelo, a 85 °C | junto a lo anterior |
| Canal colocado y rutado en el tile, con la red de met4 | MISFIT-04 |
| Ruido en el macro extraído con sus capacidades reales (fila 10 de RISKS) | MISFIT-04 |
| Lector de rango amplio para XC-20 | aparte |

## 4. Pruebas imposibles antes del silicio

- Si existen trampas visibles en SKY130 (XC-19). El modelo no tiene trampas: el salto se inyecta a mano.
- La magnitud del túnel en p+/n+ pegados (XC-20). El perfil de dopaje no es público.
- Si la carga del plasma queda escrita y sobrevive al recocido (XC-14). Nadie la modela.
- El valor absoluto de la placa de referencia y de las uniones de los interruptores, la fuga real de los interruptores abiertos y
  la distribución de desajuste entre chips.
- La temperatura real del dado y la deriva a lo largo de una campaña (filas 7 y 8 de RISKS).
- Si la OPC de la fábrica deja residuo (XC-62). El modelo óptico es supuesto y no converge al nanómetro.

## 5. Formato del atlas: la unidad es una respuesta, no una geometría

Un registro por adquisición agregada, en JSON. Propuesta v0:

```json
{
  "id": "misfit1/chip07/slot1/lod_sa030/2027-..",
  "geometria": {"familia": "LOD", "celda": "lod_pair_v1", "gds_sha256": "...", "parametros": {"sa": 0.30, "sb": 0.30}},
  "estimulo": {"src": 1, "polarizacion": "trim=2", "vdd": 1.80, "temp_c": 27.0, "orden": "ABBA", "repeticiones": 64},
  "lectura": {"magnitud": "cuentas_A_menos_B", "valor": 12.4, "unidad": "cuentas"},
  "incertidumbre": {"aleatoria": 0.6, "sistematica": {"desajuste_linea_base": 0.3}, "franja_no_atribuida": 0.2},
  "controles": ["misfit1/chip07/slot1/ref_ladder/...", "misfit1/chip07/ch7/..."],
  "calibracion": {"ruta": "slot1", "escalera": "u1-u0", "valor": 7.1},
  "instrumento": {"rtl_sha": "...", "lector": "xc19_slot_v1"},
  "prerregistro": "cells/preregistros/....md",
  "evidencia": "medido | simulado | calculado | verificado",
  "hipotesis": [{"id": "H_lod_bsim", "compatible": true, "log_verosimilitud": -3.2}]
}
```

Reglas: el atlas guarda también los **nulos y los fallos del instrumento**, con su estado (positivo, negativo informativo,
inconcluso, fallo del instrumento). Un registro sin calibración por la misma ruta es inconcluso por definición. Esto es la
D = (G, E, Y, Σ, H) de la revisión, más el instrumento y la procedencia.

## 6. De respuesta reproducible a Exotic Cell utilizable

Una respuesta pasa a ser **celda** cuando tiene estas seis cosas, todas medidas:

1. **Condiciones de operación:** rango de VDD, temperatura y polarización donde la respuesta existe, y dónde deja de existir.
2. **Modelo:** el más simple que la reproduce (ecuación o subcircuito), con su región de validez. Va ligado a datos y no a la
   hipótesis que la motivó.
3. **Tolerancias:** dispersión dentro del chip (réplicas), entre chips y deriva en el tiempo. Sin entre chips no hay celda.
4. **Interfaz:** cómo se excita y se lee con pines digitales, a través de un slot que cumple el contrato. Incluye su calibración.
5. **Pruebas de regresión:** una lectura dorada con banda (la autoprueba en silicio), sus controles negativos y la detección de
   sus modos de fallo.
6. **Ficha de función:** qué primitiva es (temporizador, fuente de entropía, memoria, sensor) y **contra qué se compara**. Juan
   rechazó exigir que gane al componente de biblioteca: la comparación se informa, no filtra.

Las seis aplican a una respuesta que **ya** está demostrada. La tabla de "comportamiento → función" de la revisión sirve para
buscar, no para afirmar.

## 7. Lo que no adopto, o adopto con cuidado

- **"Explorar qué funciones son realizables, incluidas las no anticipadas."** Sí, con una condición del método: toda exploración
  abierta separa **conjunto de descubrimiento** de **conjunto de confirmación** (otra réplica u otro chip). Una respuesta
  "inesperada" encontrada mirando 1000 lecturas se confirma en lecturas que no se miraron. Sin eso, el atlas fabrica hallazgos.
- **IA fuera del chip.** De acuerdo. El modelo del host aprende del silicio, pero **lo latente juzga y lo determinista
  demuestra**: un ajuste no es un mecanismo.
