# XC-01/02/03 · Qué imprime la litografía cuando el dibujo rompe la regla de ancho y de separación

Escrito el 2026-11-12 11:33 EST (hora de `date`), antes de correr `experiments/litho_explore/litho.py`. Sin commit previo: bajo la
regla de esta carpeta cuenta como exploratorio con predicción escrita, no como prerregistro pleno.

**Qué es.** Imagen aérea (Abbe, fuente circular parcialmente coherente, máscara binaria, umbral constante) de una línea de metal
con cuello y de dos puntas enfrentadas. No es un simulador de proceso: sin resina, sin grabado, sin corrección óptica de la fábrica.
Parámetros supuestos, **de memoria**: 248 nm. Barridos: apertura 0,60 y 0,70; coherencia 0,5 y 0,8. El umbral se calibra para que
una línea larga de 0,14 µm se imprima a 0,14 µm.

**Qué se deduce sin correr (tautología).** La línea larga de 0,14 sale a 0,14 por calibración. Lo más pequeño que la óptica
resuelve es del orden de 0,25·λ/NA ≈ 0,09 a 0,10 µm (**cálculo**).

**Predicciones.**
1. Cuello dibujado a 0,14 µm: si es largo (1,0 µm) imprime 0,14 ± 0,01; si es corto (0,14 µm de largo) imprime más de un 20 % más
   ancho, porque las cabezas de 0,50 µm lo rellenan. El cuello "mínimo legal" corto no es mínimo.
2. Cuello ilegal de 0,10 µm y largo 1,0: imprime por debajo de 0,08 o se abre. De 0,07 µm y largo: se abre en todos los ajustes.
3. Cuello ilegal de 0,07 µm y corto (0,14 de largo): no se abre; imprime un puente continuo de 0,06 a 0,12 µm. Sería una
   constricción por debajo del mínimo que solo existe si se dibuja corta.
4. Puntas enfrentadas: a 0,14 µm de separación quedan abiertas; a 0,05 µm se puentean en todos los ajustes; a 0,07 y 0,10 depende
   del ajuste. Un puente impreso donde el dibujo dice "abierto" sería un precursor que LVS no ve.

**Criterio de abandono.** Si el signo de 3 o de 4 cambia entre los cuatro ajustes ópticos, esta simulación no sirve para elegir
geometrías sin datos reales del escáner, y se dice así.

**Qué parte del sombrero queda:** ninguna. Es una herramienta para las constricciones; no toca la hipótesis del sombrero.
