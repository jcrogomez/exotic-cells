# MISFIT-26 · etapa B: el bloque colocado del lector 2, extraído · resultados

Prerregistro: [`MISFIT-26`](../../cells/preregistros/MISFIT-26_2026-11-27_lector2_bloque_extraido.md), sellado y subido
antes de la tanda (después de un humo de cuatro decks fuera de lista, declarado allí). ngspice 44.2, PDK 8afc8346,
91 decks. Veredictos tal como salen del análisis sellado: [`m26.txt`](m26.txt), subidos antes de diagnosticar nada.
Diagnóstico posterior (exploratorio): [`diag/diag.txt`](diag/diag.txt).

## Lo aburrido primero

- **El bloque simulado ya no es el que iría al chip.** Es el de MISFIT-25; mientras corría esta tanda el bloque se
  recolocó y se unió a la celda analógica (MISFIT-27). Lo que aquí se aprende es del circuito, no de esa colocación.
- **La tanda se paró dos veces** porque el portátil entró en reposo (14:57–19:34 y 20:11–21:49). Los decks a medias
  siguieron al despertar; los 91 acaban en `salida 0`. Los tiempos de `corre.out` no sirven para estimar duración.
- **Extracción solo de capacidades, con Magic**, sin resistencia de cables y sin segundo extractor para el interior de
  las celdas. Cuánto del cambio de carga es real en silicio queda sin atribuir.
- **Una corrida por punto, sin ruido.** El fallo que aparece (abajo) es de un circuito que pasa despacio por un punto
  de equilibrio; una simulación sin ruido puede quedarse en él más de lo que lo haría el silicio, o menos.
- El cerrojo arranca con `.ic`. El arranque sin ella no se prueba.
- **Mi medida de B4 era mala** en dos sentidos: tiempos impresos con seis cifras (a periodos de 0,3–0,9 ms `xa` y su
  flanco empatan) y un tope relativo de 0,1 % que no contaba el retardo del propio contador.

## Resultado

Tanda **válida**: el control (netlist final + celdas de librería) da la Q de MISFIT-24 dentro de 0,2 % en los cuatro
casos, y el testigo de +20 fF sube la Q del rango alto un 10,6 %.

| # | Predicción | Veredicto |
|---|---|---|
| B1 | Los 48 decks oscilan: 18 flancos | **falsa**: 47 de 48. A ff −40 y 100 pA hay 16 flancos y el oscilador se queda parado |
| B2 | 24 fuera de muestra dentro de ±3 % | **cumplida**: entre −0,89 y +1,21 % |
| B3 | Q frente a MISFIT-24: bajo +30..+100 %, alto +2..+15 % | **cumplida**: bajo +57,2 a +65,8 %; alto +2,8 a +3,5 % (a tt 27 no era a ciegas) |
| B4 | Contador en rango bajo | **falsa**: 15 de 24 (desglose abajo) |
| B5 | Reposo quieto antes de `en` | **falsa**: 44 de 48. A 10 µA el nodo baja a 1,48–1,57 V en reposo; q sigue en 0 |
| B6 | Sin corriente a ff 85, ningún flanco | **cumplida** |
| B7 | A ritmo máximo, `xa` entre los flancos 256 y 257 | **cumplida** a tt 27 (periodo 24,4 ns) y ss 85 (26,0 ns) |
| B8 | El bloque `libre` oscila y su Q difiere > 2 % en algún rango | **cumplida**: 6 de 6 oscilan; Q −0,23 % (bajo), −3,32 % (alto) |

**La carga por ciclo cambia, y la lectura sigue valiendo.** Con el bloque extraído, Q pasa de 51–58 fC a 82–96 fC en
rango bajo y de 171–195 a 176–201 fC en rango alto; el retardo ajustado sube de 2,4–4,6 a 4,1–8,4 ns. Calibrado
consigo mismo, lee las corrientes fuera de muestra igual de bien que antes. De ese cambio, las difusiones de las celdas
explican el 15 % (bajo) y el 25 % (alto); el resto son capacidades de cableado dentro y entre celdas.

**Los nueve fallos de B4:**

- Siete (todos a 100 y 316 pA) son empates de impresión: `xa` o `xb` caen dentro de los 10 ns que resuelve el número
  impreso y la comparación estricta falla. El contador está donde debe dentro de esa resolución.
- Uno (ss 85, 1 µA): `xb` sale 1,46 ns más tarde que `xa` respecto de su flanco (tiene dos biestables más de rizado);
  son 0,124 % de doce periodos de 98 ns. Retardo fijo; lo absorbe la calibración. Criterio mal puesto.
- **Uno es real (ff 85, 316 pA): `xb` sube en el flanco 15.** El primer biestable del contador cambia una vez de más.

## Diagnóstico de los dos fallos serios (exploratorio)

Repetidos guardando todas las ondas; son deterministas (mismos tiempos).

- **ff 85, 316 pA:** a los 4,0278 ms el nodo está en 0,779 V, justo en el umbral del comparador, bajando muy despacio. La
  cadena del comparador queda en su zona lineal (s = 0,68 V) y el cerrojo, en vez de saltar, **se pasea por tensiones
  intermedias**: q llega a 0,645 V y qb a 0,76 V. Eso no cruza 0,9 V, pero sí dispara el primer biestable del contador,
  que vuelve a cambiar cuando q por fin sube. Una cuenta de más.
- **ff −40, 100 pA:** tras el flanco 16, el siguiente disparo deja el cerrojo en q = qb = 0,725 V con la precarga a
  medio encender (0,83 V en su puerta), que sujeta el nodo en 1,80 V. Sin entrada (s = 0, y el retardo lee 0,725 V como
  cero), el cerrojo se queda en su equilibrio hasta el final de la simulación (15,8 ms más).

**Lectura:** no es un fallo de la colocación ni del contador. El lazo no tiene histéresis: con una rampa lenta el
comparador entrega al cerrojo un nivel analógico durante cientos de microsegundos, y todo lo que cuelga de q (contador
y puertas de precarga) ve ese nivel. En esquemático (MISFIT-17 a 24, y el control de esta tanda) no apareció en
ningún punto; con los parásitos, en 2 de 24 decks de rango bajo, los dos a las corrientes más bajas y en esquinas
rápidas. **Conjetura:** en silicio el ruido sacaría al cerrojo del equilibrio del segundo caso, pero el primero (cuentas
de más) puede ser peor con ruido, no mejor.

## Decisión, por la regla escrita

B1 y B4 falsas: **el bloque de MISFIT-25 no queda aceptado**, y el motivo es del circuito, así que tampoco la unidad
de MISFIT-27 tal cual (lleva el mismo lazo). B2 se cumple: el modelo de tres puntos sirve con el pulso real. Sigue
MISFIT-28: dar histéresis al comparador y repetir esta etapa sobre la unidad, con la medida corregida (12 cifras,
cada flanco medido a tres alturas para ver pulsos a medias, y más puntos entre 100 pA y 1 nA).

**Correcciones a lo ya escrito:**

- MISFIT-25 decía que sin protección el flujo "rompe el lector". No lo rompe: oscila y calibra, y cambia la carga un
  3,3 % en rango alto. Lo cambia sin avisar. Corregido allí.
- Las Q y los retardos absolutos de MISFIT-17 a 24 y de la noche del 26 son de celdas sin parásitos (el SPICE de la
  librería no trae ninguno). Sus conclusiones relativas (linealidad, esquinas, desajuste) no se han repetido con
  parásitos; la ausencia de pulsos a medias en ellas no vale como prueba.

## Qué explicación aburrida no descarté

- Que los dos fallos dependan del paso de simulación (máximo de 1 µs en esos decks): no repetí con paso fino.
- Que haya más pulsos a medias que no llegaron a mover el contador: solo medí los que cruzan 0,9 V y el efecto en `xb`.
- Que el reparto 15 %/25 % cambie con otro extractor.
- Que a 10 µA el nodo caído en reposo (B5) altere el primer intervalo; la lectura por diferencia lo quita, sin comprobar.
