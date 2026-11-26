# MISFIT-15 · enmienda 3 · el área del diodo entraba un billón de veces de más

Escrita el 2026-11-26 (hora de sellado en `experiments/misfit15/PREREG_SHA256.txt`), **después** de la tercera pasada y
**antes** de la cuarta.

## Qué pasó (se queda en `experiments/misfit15/pasada3/`)

El barrido forzado corrió entero y sin errores, pero **el testigo K7 falló**: con 100 nA inyectados, el banco leyó 21,7 µA,
y el mutante sin inyección 21,6 µA. **Inválida**, como manda la regla. El diodo suelto daba 2,8 mA a 27 °C y 0,59 A a 85 °C.

Diagnóstico (`experiments/misfit15/diag/`, corrida): el netlist extraído escribe el diodo como `area=1.4e+12 perim=4.8e+06`
y el contenedor (ngspice 44.2 con el `spinit` del PDK, `scale = 1e-6`) usa ese número **tal cual**: corriente inversa
3,85 mA y capacidad 1,09 mF a 30 °C. Con `area=1.4 pj=4.8` da 6,73 fA y 1,26 fF. La tarjeta del modelo lleva `js = 2,75e-15`
y `cj = 0,0013459·1e-12`: son valores por µm², así que el área correcta en número es 1,4. Por qué el escalado no se aplica
al área del diodo en esta combinación de versión y modo: `[?]`.

## Qué vi de la pasada inválida

Vi la tabla entera antes de diagnosticar. Casi todo está dominado por el diodo de mA y no dice nada. Dos filas sí dicen algo
y **no las puedo desver**: a ff −40, donde el diodo falso fuga menos, A dio V_j entre 0,98 y 1,10 V y B entre 1,795 y 1,800 V.
Van en la dirección de K2 y K4. Las predicciones no se tocan; se dice aquí que esas dos ya no son a ciegas en esa esquina.

## Qué cambia

- Los tres diodos se instancian **directamente con el modelo** y con el área en µm² como número: `area=1.4 pj=4.8` para la
  isla, `area=112 pj=64` para el pozo supuesto. Nada más.
- Control añadido a cada deck: la capacidad del diodo suelto a 1,8 V en inversa debe quedar entre 0,5 y 3 fF. Si no, inválida.
- En esa pasada B no seleccionado con n = 3 dio `nan` a ff −40 (sin cruce único). Si se repite, se mira el barrido y se dice.

**Consecuencia fuera de esta prueba (pendiente de revisar, no es veredicto):** cualquier simulación del repo que haya usado
un diodo del PDK escrito con la convención de la extracción está afectada. Se busca después de esta pasada.

Predicciones K1–K8 y reglas de decisión: las del prerregistro, sin tocar.
