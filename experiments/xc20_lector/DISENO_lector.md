# XC-20 · lector de rango ancho · cálculo de diseño (esquemático, sin prerregistro ni veredicto)

2026-11-24. Son números de diseño para escribir el prerregistro del lector. No se juzga nada.

## Circuito (`diseno/gen.py`, v4)

Oscilador de relajación:
- La corriente del dispositivo (aquí, una fuente ideal I) descarga el nodo X, de capacidad C.
- `inv_1` hace de comparador, seguido de dos `inv_1` que afilan el flanco: es la entrada S.
- Un latch SR de dos `nor2_1` guarda el disparo. Q enciende la precarga a través de un `inv_4`.
- R es Q retrasado por 8 `dlygate4sd3_1`, así que el pulso de precarga tiene ancho fijo.
- Se cuentan los flancos de Q.

## Lo que falló por el camino (todo declarado)

| Versión | Fallo | Arreglo |
|---|---|---|
| v1 (`diseno_v1_sin_ic/`) | El lazo arranca en su equilibrio de DC y no oscila | `.ic` en X = VDD |
| v2 (scratchpad) | Sin histéresis, el lazo es un regulador lineal estable: X queda fijo en ~0,79 V con 10 pF | Latch SR con pulso de ancho fijo |
| v3 | Con el pfet de 64 µm, la fuga se opone a I. En 200 fF no oscila a 100 y 316 pA, y a 1 nA da un periodo ~1,9× más largo | pfet de precarga `pfet_01v8_hvt`, w = 1, m = 2, dos en pila (`precarga/`, `resumen_precarga.txt`) |

## v4, 200 fF (`diseno_v4/resumen_v4.txt`)

I·T/C es la excursión efectiva. Si es constante, f ∝ I.

| Esquina | 100 pA | 1 nA | 10 nA | 100 nA | 1 µA | 3,16 µA | 10 µA | ≥ 100 µA |
|---|---|---|---|---|---|---|---|---|
| tt 27 | 0,998 V | 0,997 | 0,998 | 0,999 | 1,014 | 1,045 | 1,138 | satura en ~163 MHz |
| ff 85 | 1,447 | 1,054 | 1,151 `[?]` | 1,025 | 1,035 | 1,060 | 1,134 | satura en ~204 MHz |

- **tt 27:** lineal dentro de ±1,6 % de 100 pA a 1 µA, cuatro décadas.
- **ff 85:** la fuga de la precarga vuelve a pesar abajo, unos ~30 pA equivalentes (inferencia, de 1,447 frente a ~1,03). Dentro
  de ±5 % solo de ~1 nA a 3 µA.
- El punto de 10 nA a ff 85 (1,151) no sigue a sus vecinos (1,033 y 1,025). Puede ser numérico; `[?]`, no se miró.
- **Por arriba,** el retardo fijo del lazo (~6 ns, pulso + comparador) limita: hace falta un segundo rango con C mayor y una precarga
  más fuerte. Con 10 pF y el pfet de 64 µm (v3, `diseno/`), es lineal dentro del 0,3 % de 100 nA a 3,2 µA.
- **El contador** tiene que contar hasta ~200 MHz, o hay que dividir la salida antes. `[?]`: falta el diseño del contador.

## Para el prerregistro del lector

- **Dos rangos:** 200 fF con precarga hvt en pila, y 10 pF con precarga fuerte.
- **Esquinas:** las cuatro.
- **Controles:**
  - I = 0, que mide la fuga de la precarga;
  - una corriente de calibración conocida.
- **Testigo:** un salto de I conocido.
