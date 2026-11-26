# MISFIT-17 · XC-20 leída por el lector 2 en dos rangos, con la matriz extraída en el nodo

Escrito el 2026-11-26 (hora de sellado en `experiments/misfit17/PREREG_SHA256.txt`), **antes** de escribir los decks. Cierra
la mitad pendiente de C4 y es la prueba de dos rangos que pedía R2 (corrientes fuera de las de calibración, y una corriente
de calibración en el extremo bajo de cada rango, lección de [MISFIT-12](../../experiments/misfit12/RESULTADOS.md) C).

## Qué se simula

El lector 2 de la noche del 25 ([`noche_1125`](../../experiments/noche_1125/RESULTADOS.md) bloque A: oscilador de relajación,
nodo MOS 4,3/4,0, precarga hvt en pila), en dos rangos que solo difieren en el largo de la precarga: **bajo** L = 1,00 µm,
**alto** L = 0,15 µm. En el nodo cuelga la matriz `xc20w` de [MISFIT-16](../../experiments/misfit16/RESULTADOS.md) tal como se
extrajo con capacidades (7 puestos), con el área de los diodos reescrita en µm² (MISFIT-15) y el diodo pozo–sustrato añadido
a mano (modelo `ps2nw`, 50,195 µm², 60,56 µm), porque la extracción no lo da. gmin = 1e-15, como en las corridas del lector.

- **Calibración** (todos los puestos abiertos, fuente ideal en el nodo): bajo 100 pA, 10 nA, 1 µA; alto 10 nA, 316 nA, 10 µA.
  Modelo de tres números T = Q/(I − I_L) + t_d por rango y esquina. Lectura: I_leída = Q/(T − t_d) + I_L.
- **Fuera de muestra** (fuente ideal constante **a través del puesto 0 cerrado**, de pozo a isla): bajo 316 pA, 3,16 nA,
  100 nA; alto 31,6 nA, 1 µA, 3,16 µA.
- **Formas** (elemento I0·(V/1,8)ⁿ en el puesto 0, V = tensión pozo − isla): n = 1 y n = 3, con I0 = 10 nA (bajo) y 1 µA (alto).
- **Controles:** testigo +1 % (3,19 nA en bajo, 1,01 µA en alto); sin corriente, 20 ms; puesto 6 en vez del 0 a 3,16 nA
  (bajo); lector sin matriz a 3,16 nA (bajo).

4 esquinas (tt 27, ff −40, ss 85, ff 85) × 22 decks = 88. T = (flanco 12 − flanco 2)/10. Tope 3600 s por deck.

## Explicaciones aburridas

| Explicación | Chequeo |
|---|---|
| El lector acierta porque se juzga en las corrientes con que se calibró | Las juzgadas no son de calibración, y entran por otro camino (a través del puesto) |
| El banco no ve cambios pequeños | Testigo +1 % (R3) |
| El diodo vuelve a entrar con el área mal | Control: capacidad del diodo de isla del puesto 6 a tensión cero de polarización DC inicial entre 0,5 y 3 fF, impresa en cada deck |
| Las islas flotantes no dejan converger (MISFIT-15) | Humo antes de lanzar: un deck a tt 27. Si no arranca, enmienda antes de la tanda |
| Con una unión que no es fuente constante el lector da "otra" corriente | Se dice de antemano (R6): el nodo barre de 1,8 V al umbral y el lector devuelve un promedio sobre ese barrido |

## Predicciones

Error = I_leída / I − 1. Las bandas se aplican a cada rango y esquina por separado.

| # | Predicción |
|---|---|
| R1 | Las 6 corrientes fuera de muestra se leen dentro de ±3 % en las 4 esquinas (24 de 24). Si falla alguna, apuesto por 316 pA a ff 85 |
| R2 | Periodo con matriz / sin matriz a 3,16 nA (rango bajo): entre 1,12 y 1,30 en las 4 esquinas |
| R3 (testigo) | +1 % de corriente da entre −1,2 y −0,8 % de periodo, 8 de 8 |
| R4 | Sin corriente, ningún flanco en 20 ms, 8 de 8 |
| R5 | Puesto 6 frente a puesto 0, misma corriente: periodos dentro de 0,5 %, 4 de 4 |
| R6 | Forma óhmica: I_leída / I0 entre 0,68 y 0,78. Forma cúbica: entre 0,25 y 0,42. En los dos rangos y las 4 esquinas (16 de 16). Cuenta previa: nodo de 1,8 V a un umbral de 0,8–1,0 V con capacidad constante da 0,70–0,76 y 0,27–0,40 |

## Qué se hace con cada resultado

- **R1 cumplida:** XC-20 queda cerrada en papel con el lector 2 de dos rangos; lo siguiente del lector es su dibujo.
- **R1 falla solo en el punto más bajo del rango bajo:** el suelo del rango bajo para XC-20 sube a 1 nA y se dice. No mata:
  las celdas ordinarias ya quedaban fuera (MISFIT-15).
- **R1 falla en 3 o más de los 24:** el lector 2 con la matriz en el nodo **no sigue**; se rediseña (menos puestos por nodo,
  o el pozo fuera del nodo) antes de dibujar nada.
- **R6 falsa:** la lectura de una unión no óhmica no se interpreta con la cuenta simple; se anota el cociente medido.
- **Inválido** un (rango, esquina) cuyo testigo caiga fuera de banda o cuya calibración no dé periodo; inválida la tanda si
  el control de capacidad del diodo falla.

## Qué no dice

Nada de silicio ni de la unión real. Fuentes de calibración ideales: de dónde salen en el chip las tres corrientes de cada
rango sigue sin diseñar. Sin desajuste, sin ruido, sin divisor ni contador, una sola matriz de 7 puestos (no 52).
