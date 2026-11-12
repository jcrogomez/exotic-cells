# Preregistro · plan de la noche del 11 al 12 de noviembre de 2026

Escrito el 2026-11-11 22:09 EST (hora de `date`), antes de correr ninguno de los bloques. Todo es modelo, extracción o layout; nada es silicio.
Cada bloque lleva predicción y criterio. Lo que no llegue a correrse queda como "no corrido", no como resultado.

## N1 · XC-12/XC-16 · ¿cuánto se equivoca el flujo con las celdas estándar reales?

Se extraen celdas de `sky130_fd_sc_hd` desde sus layouts del PDK, se anotan con `residual/lod_annotate.py` y se simula un
anillo de `inv_1` con y sin anotación.

- Predicción: los nfet de celdas de un dedo tienen `sa`/`sb` entre 0,2 y 0,5 µm, por debajo de la referencia (1,04 µm).
- Predicción: el anillo de `inv_1` anotado es entre 2 % y 10 % más lento que sin anotar.
- Sin predicción para los pfet: no he leído sus coeficientes de esfuerzo.
- Cobertura: si el anotador falla en más del 20 % de las celdas probadas, se reporta como límite de la herramienta.
- Lo que este bloque no decide: cómo se caracterizó la biblioteca. Si se caracterizó sobre silicio medido, el efecto ya está
  dentro de sus tiempos y la anotación lo contaría dos veces.

## N2 · Borde legal: el DRC como instrumento

Herramienta que, dada una geometría paramétrica, busca por bisección el valor donde el DRC cambia de limpio a violación, en
Magic y en KLayout, y dice qué regla salta.

- Control (respuestas conocidas): ancho mínimo de met1 0,14 µm; de li1 0,17 µm. La herramienta debe recuperarlos a ±0,005 µm.
- Predicción: separación p+/n+ dentro de pozo n: legal en 0, ilegal entre 0 y 0,27 µm, legal desde 0,27 µm (dos de esos puntos
  ya se conocían de notas de trabajo; el borde exacto no).
- Predicción: longitud mínima de difusión junto a una puerta con contacto, entre 0,26 y 0,30 µm; sin contacto, entre 0,13 y 0,30 µm.
- Predicción: Magic y KLayout coinciden en esos bordes. Una discrepancia es un hallazgo, no un fallo.

## N3 · XC-19 · retroceso sobre la polarización

- Predicción: el retroceso escala como 1/C. Con 10 pF, entre 0,15 y 0,33 mV; con 30 pF, entre 0,05 y 0,11 mV.
- Predicción: un transistor en cascodo sobre el DUT (puerta a la toma siguiente de la cadena) reduce el retroceso a menos de
  0,5 mV con 1 pF, conserva el salto entre 0,75 % y 0,90 %, y baja la sensibilidad a VDD del cociente con el gemelo largo
  (4,2/1,5 µm) por debajo de 0,4 % por 10 mV, porque fija la tensión de drenaje del DUT.
- Criterio: si el cascodo deja el salto por debajo de 0,6 %, se descarta.

## N4 · Cruce XC-12 × XC-19

Los dos transistores de la auditoría LOD (difusión de 0,30 y 3,0 µm, anotados) leídos por la etapa de XC-19.

- Predicción: cociente de tiempos entre 2,4 y 2,9 (2,34 por umbral, por 1,15 de movilidad).
- Criterio: fuera de 2,0–3,3, la aritmética de la parte 1 estaba mal y se corrige antes de usar XC-12 como calibración.

## N5 · XC-19 · desajuste como Monte Carlo

Cociente DUT/gemelo idéntico frente a 10 mV de VDD, 100 sorteos de desajuste.

- Predicción: entre el 5 % y el 25 % de las parejas supera el límite de 0,4 %.

## N6 · XC-19 · layout de la celda de lectura

DUT, precarga de umbral alto y cadena de polarización dibujados en Magic.

- Predicción: DRC 0. Capacidad del nodo extraída entre 3 y 8 fF (2,0 fF en esquemático).
- Predicción: el salto por 0,305 mV sigue entre 0,75 % y 0,90 % con el netlist extraído.
- Criterio: si el salto extraído baja de 0,6 %, hay un camino parásito y la celda se rediseña.

## N7 · Integración en el flujo digital (si alcanza la noche)

La celda de N6 como macro dentro de un diseño endurecido con LibreLane. Sin números predichos: DRC 0 y LVS desde GDS
comparando los dispositivos reales, o no cuenta.
