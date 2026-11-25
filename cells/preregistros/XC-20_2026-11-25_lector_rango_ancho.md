# XC-20 · lector de rango ancho (lector 2) · veredicto en esquemático (prueba R2 del plan)

Escrito el 2026-11-25 13:14 EST (`date`), **antes** de escribir el generador de decks o de correr nada. Plan:
[`docs/MISFIT_PLAN.md`](../../docs/MISFIT_PLAN.md). Parte del cálculo de diseño ya hecho, que **no** es evidencia
([`experiments/xc20_lector/DISENO_lector.md`](../../experiments/xc20_lector/DISENO_lector.md), v4). Todo es modelo (SPICE), en
esquemático. Nada es silicio ni layout.

## Arquitectura que se juzga (decisión del agente, 2026-11-25)

Pensada para un tile 1×1 y para **no tocar el motor de medida del núcleo**:

1. **Nodo:** el mismo condensador MOS de nodo del lector 1 (nfet 4,3 × 4,0 µm, ~133 fF), ya dibujado. Cambia frente a la v4, que
   usaba 200 fF ideales.
2. **Oscilador de relajación** de la v4: la corriente del dispositivo descarga el nodo; un inversor hace de comparador; un latch
   SR con un pulso de ancho fijo (8 celdas de retardo) vuelve a precargar con dos pfet hvt en pila (w = 1, m = 2).
3. **Divisor entre 128** en cascada, puesto a cero durante la precarga inicial. Su salida entra al núcleo por la misma línea
   `xa` de hoy: el contador existente mide el tiempo hasta su primera subida, que son 128 periodos. De 100 pA (unos 0,2 s) a
   10 µA (unos 2,5 µs, ~128 cuentas a 50 MHz) sin lógica nueva en el motor. **El divisor es digital y no se simula aquí.**

## Modelo de lectura que se pone a prueba

Periodo T(I) = Q / (I − I_L) + t_d, con tres números por chip y esquina: Q (carga por ciclo), I_L (fuga de la precarga, que se
opone a la corriente) y t_d (tiempo muerto de la re-precarga). Se ajustan con **tres corrientes de calibración** (316 pA, 31,6 nA y
3,16 µA) y se predicen las demás. En el chip esas tres saldrían de puestos de calibración; cómo generarlas con valor conocido es
diseño pendiente y no entra aquí.

## Explicaciones aburridas y su chequeo

| Aburrida | Chequeo |
|---|---|
| El deck nuevo no reproduce lo ya visto | Control: con 200 fF ideales a tt 27, los periodos a 1 nA y 1 µA repiten los de `diseno_v4/resumen_v4.txt` (1,995e-4 s y 2,027e-7 s) dentro de 0,5 % |
| El ajuste de tres parámetros "acierta" porque tiene tres puntos | Solo se juzgan corrientes que **no** entran en el ajuste |
| La linealidad es de la fuente ideal, no del lector | Testigo: +1 % de corriente debe dar −1 % ± 0,2 de periodo (menos lo que el tiempo muerto le quita, que el modelo predice) |
| Oscila sin corriente (fuga propia) | Control: con I = 0 no hay ningún flanco en 20 ms |
| Paso del simulador | Se mide entre el flanco 2 y el 12; el paso máximo es ≤ 1/2000 del tiempo total (como la v4) |

## Predicciones

Corrientes juzgadas: 100 pA, 1 nA, 10 nA, 100 nA, 1 µA y 10 µA. Esquinas: tt 27, ff −40, ss 85, ff 85.

| # | Predicción |
|---|---|
| W0 | El control con 200 fF ideales repite la v4 dentro de 0,5 % |
| W1 | De 1 nA a 10 µA, el modelo ajustado predice el periodo dentro de ±3 % en las 4 esquinas |
| W2 | A 100 pA, dentro de ±3 % a tt 27 y ff −40. A 85 °C no lo predigo: ahí I_L puede ser comparable a la corriente |
| W3 (testigo) | +1 % de corriente a 10 nA y a 1 µA: el periodo cambia entre −1,2 % y −0,8 % en las 4 esquinas |
| W4 | I = 0: ningún flanco en 20 ms, en las 4 esquinas |
| W5 | I_L ajustada: |I_L| ≤ 5 pA a tt 27 y ff −40; entre 5 y 150 pA a 85 °C |
| W6 | t_d ajustado entre 2 y 8 ns |

## Sigue / muere / inválido

- **Sigue** (se dibuja el lector 2 con esta arquitectura): W1, W3 y W4.
- **Muere:** W1 falla en alguna esquina con cualquier terna de calibración razonable, u oscila con I = 0. Entonces la precarga se
  rediseña (canal más largo) antes de dibujar nada.
- **Inválido si:** falla W0 o W3.

## Límites declarados

- Fuente de corriente ideal: un dispositivo real cambia su corriente con la tensión del nodo, que aquí recorre de 1,8 V a ~0,8 V.
  Para una unión en inversa (XC-20) eso es parte de lo que se mide; el lector da la carga por ciclo, no una corriente a tensión fija.
- Sin desajuste, sin ruido, sin el divisor, sin extracción. Sin las ramas de selección (su fuga se suma a I_L).
- A 10 µA la frecuencia es de decenas de MHz: el divisor tiene que aguantarla. No se comprueba aquí.

Tope: 30 min por deck (`timeout` dentro del contenedor). SHA en `experiments/xc20_lector/r2/PREREG_SHA256.txt`.
