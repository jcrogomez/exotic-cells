# XC-19 como slot del instrumento · qué falta y primer cálculo de diseño

2026-11-22, 19:58 EST (`date`). **Cálculo de diseño, no experimento**: sirve para escribir el prerregistro del slot, no es
evidencia de nada. Todo es modelo (ngspice 44.2, sky130A `8afc8346`, tt, 27 °C, modo `hsa` vía `tools/ngspice_pdk.sh`).

## Qué falta para el "canal completo" (fase 1 del ROADMAP)

El ROADMAP lo define como condensadores, alimentación, calibración independiente, salida digital, y extracción y post-layout
contra un prerregistro. El canal tiene que cumplir el contrato de slot de [`instrument/INTERFACES.md`](../../instrument/INTERFACES.md).

| Pieza | Estado | Dónde |
|---|---|---|
| Lector A/B, polarización, filtro de VB | dibujado, extraído, simulado post-layout | [`xc19_channel_caps`](../../cells/xc19_channel_caps/README.md), [`xc19_caps`](../xc19_caps/INFORME.md) |
| Alimentación: sensibilidad a la carga del tile | simulada, 6 predicciones cumplidas | [`supply_transfer`](../supply_transfer/README.md) |
| Ruta de integración | probada con un inversor (MISFIT-01) y una celda de tiempo leída por el contador (MISFIT-02). Sin decidir: celda de fila, macro de geometría libre o ambas | [`misfit01`](../../instrument/misfit01/README.md), [`misfit02`](../../instrument/misfit02/README.md) |
| **Puertos del contrato** `en`, `pre`, `src[1:0]`, `xa`, `xb` | **no existen.** El canal tiene C1, PREA, PREB, XA y XB analógicos, y ni `en` ni selector de fuente | — |
| **`src = 3`, condensador de referencia conmutado** (la calibración primaria) | **simulado con Cref ideal, sin dibujar** | `xc19_caps` §4.2 |
| **`src = 2`, corriente de calibración** | **sin diseñar** `[?]`. La inyección dibujada (CALA/CALB) murió como escalón equivalente | `xc19_caps` §4.1 |
| Inversor de umbral y el hilo real X → inversor | fuera del layout del canal: en ningún número | PLAN §5.1, punto 7 |
| `en` bajo = inerte (sin corriente estática, `xa` y `xb` bajos) | sin diseñar | INTERFACES |
| Monte Carlo de desajuste | 39 de 100 sorteos | PLAN §5.1, punto 4 |

## Cálculo: tamaño de Cref

[`diseno_cref.sp`](diseno_cref.sp) → `diseno_cref.txt` (19:58:33–19:58:53). Es el mismo montaje de `xc19_caps/sw.sp`, y
reproduce su tiempo con el interruptor abierto: 30,992 µs frente a 30,995 µs.

| Cref (fF) | 0 (solo el interruptor) | 0,3 | 0,4 | 0,5 | 0,6 | 0,7 |
|---|---|---|---|---|---|---|
| Δt/t (%) | 0,415 | 0,628 | 0,700 | 0,771 | 0,842 | 0,914 |

Se ajusta a una recta: 0,713 %/fF, con una ordenada de 0,4145 %. Para un salto de 0,80 % hace falta **Cref ≈ 0,54 fF**. La
aritmética de `xc19_caps` daba 0,57 fF.

**Hallazgo: el 52 % del paso de calibración es la unión del propio interruptor**, no Cref. Ese valor depende del modelo de las
capacidades de unión, que en silicio es `[?]`. La calibración vale lo que valga el interruptor.

Rediseño para el prerregistro, sin decidir todavía: un interruptor idéntico en cada nodo, con Cref en uno y sin Cref en el
otro. La diferencia entre los dos estados cancela la unión y deja solo Cref, que es una placa de metal de geometría conocida.
**[corregido 2026-11-23 07:42]** "Deja solo Cref" es demasiado. La diferencia puede incluir la asimetría de cableado, el desajuste
de los interruptores y su acoplo; además, la calibración capacitiva no equivale a una carga entre esquinas (cálculo 2).
Otra opción es un Cref mayor, para que la unión pese menos en el paso.

## Cálculo 2 (2026-11-23, 07:33–07:39): escalera, multiplexado y esquinas

[`diseno_slot_*.sp`](.) → [`diseno_slot.txt`](diseno_slot.txt) → [`diseno_slot_analisis.txt`](diseno_slot_analisis.txt).
Cuatro esquinas: ff −40, tt 27, ss 85, ff 85.
- **Con la polarización fija, la descarga va de 2,57 µs (ff 85) a 47,3 µs (ff −40).** En ff 85 el salto de una carga son 0,8
  cuentas: hace falta un ajuste de polarización.
- **El cociente calibración/trampa varía 0,72–1,28** con un interruptor y 0,34–0,58 con gemelos. La calibración capacitiva verifica
  la cadena de lectura, no equivale a una carga (corrección anotada en `xc19_caps` §4.2).
- La 2.ª unidad de la escalera pesa 1,002–1,039 veces la 1.ª.
- Cada interruptor abierto en el nodo añade un 0,08–0,18 % de tiempo, constante hasta N = 32.

Prerregistro que usa esto: [`MISFIT-03_2026-11-23_slot_xc19.md`](../../cells/preregistros/MISFIT-03_2026-11-23_slot_xc19.md).
