# MISFIT-13 · ¿cabe en el mismo bloque el núcleo con la selección de 64 puestos y un segundo lector?

Escrito el 2026-11-26 (hora de sellado en `experiments/misfit13/PREREG_SHA256.txt`), **antes** de escribir el RTL nuevo. Es la
prueba que más decide ahora: si el núcleo crecido no cabe en 32 filas (161 × 87,04 µm), el tile 1×1 pierde franja libre o cae
(decisión 3 del plan). Dato previo: el núcleo actual cierra a 31 filas y no a 30 (MISFIT-10): su holgura está entre 3 y 6 %.

## Qué se corre

Flujo LibreLane 3.0.14 sobre el bloque de MISFIT-06 (`ROUTING_OBSTRUCTIONS met4 0 0 161 80`, misma configuración), **sin la
plantilla de pines** (los pines nuevos no están en ella; el flujo los coloca solo). Cuatro variantes:

| Variante | Qué añade al núcleo actual |
|---|---|
| `v0` (control) | Nada: el núcleo de MISFIT-04 tal cual, solo cambia la colocación de pines |
| `v1` | Registro de puesto (7 bits, dirección 0x10 con un quinto bit de dirección), segundo decodificador E7 (segundo lector) y **64 líneas de selección compartidas** por los dos lectores |
| `v2` | Igual, con **128 líneas**: 64 por lector |
| `v3` | Igual, con selección a **dos niveles: 8 filas + 8 columnas** (16 líneas) |

Con líneas compartidas (`v1`, `v3`) el puesto se cierra en los dos lectores a la vez; el lector que no mide no precarga, así
que su nodo se descarga y queda quieto. Eso no está simulado aquí.

**Límites declarados:** es una prueba de cierre físico, no funcional. El registro nuevo no pasa por cocotb; el segundo lector
se aproxima con otro decodificador E7 (el lector 2 real tendrá otra interfaz); el modo de estrés no está. Una corrida por variante.

## Predicciones (apuestas de baja confianza)

Cuenta previa: 64 puertas de selección más predecodificación ≈ 600 µm² por decodificador (sobre ~8 240 µm² de celdas); la
holgura medida es de 400–790 µm².

| # | Predicción |
|---|---|
| N0 | `v0` cierra limpio |
| N1 | `v1` (64 líneas) **no** cierra limpio |
| N2 | `v2` (128 líneas) **no** cierra limpio |
| N3 | `v3` (8 + 8) cierra limpio |

"Limpio" = el flujo termina, DRC de Magic 0, LVS 0, 0 violaciones de setup y hold, 0 µm de metal 4 de señal dentro de la
obstrucción (lo mismo que en MISFIT-10). Tope: 20 min por corrida, con parada del contenedor.

**Se adopta** la variante que cierre limpio con menos coste en la matriz: `v1` antes que `v3` (dos niveles pide un segundo
interruptor en cada puesto y hay que volver a medir área y lectura). **Si ninguna cierra,** el bloque del núcleo tiene que
crecer y se dice cuánta franja cuesta. **Inválido** si `v0` no cierra limpio.
