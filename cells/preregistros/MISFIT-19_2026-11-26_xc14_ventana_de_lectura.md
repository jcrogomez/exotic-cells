# MISFIT-19 · XC-14: qué carga de puerta flotante cae dentro de los lectores

Escrito el 2026-11-26 (hora de sellado en `experiments/misfit19/PREREG_SHA256.txt`), **antes** de escribir los decks. Tercer
candidato del orden. Es la primera mitad de C3 del plan ("para el rango plausible de carga, ¿la corriente cae en algún
lector?"). Plan de la familia: [`cells/xc14_antenna_write/PLAN.md`](../xc14_antenna_write/PLAN.md).

## Qué se simula

Un puesto como los de XC-19 (transistor entre el nodo X y un interruptor nfet 0,84/0,15 a GND), con la **puerta flotante
sustituida por una fuente de tensión V_fg** que se barre de 0 a 1,8 V en pasos de 5 mV. Así no flota nada (lección de
MISFIT-15) y se lee la corriente del puesto para cada tensión de puerta. X = 1,35 V (mitad del barrido del nodo), y 0,9 y
1,8 V como comprobación. 4 esquinas.

Tres transistores: **T1** nfet de 1,8 V 0,42/0,15; **T2** nfet de 1,8 V 1,0/0,5; **T3** nfet de óxido grueso
(`nfet_g5v0d10v5`) 0,42/0,5.

**Ventana** de un transistor en una esquina: el tramo de V_fg en que la corriente está entre 100 pA y 10 µA (los dos rangos
del lector 2). V_lo y V_hi son sus extremos, por interpolación en la malla de 5 mV.

Rango plausible de la tensión que queda en la puerta: 0 a 1,3 V (residuo a 6 meses en óxido fino, ronda de ataque 4,
verificado al orden; no es una medida).

## Explicaciones aburridas

| Explicación | Chequeo |
|---|---|
| La ventana se deduce de la pendiente de subumbral y del umbral: no hace falta correr | Cierto para la dirección; la corrida da los extremos en 4 esquinas y con el transistor de óxido grueso, que no sé de memoria |
| El banco no ve cambios pequeños de V_fg | Testigo G6 |
| La puerta real no es una fuente: el drenador la mueve por acoplo | No se simula aquí (no hay layout). Se dice en "qué no dice" y se da la pendiente para hacer la cuenta |

## Predicciones

| # | Predicción |
|---|---|
| G1 | T1 a tt 27: V_lo entre 0,22 y 0,40 V; V_hi entre 0,70 y 0,95 V |
| G2 | T3 a tt 27: V_lo entre 0,45 y 0,80 V; V_hi ≥ 1,15 V (o no llega a 10 µA en el barrido) |
| G3 | En cada esquina, T1 y T3 juntos cubren un tramo continuo de al menos 0,75 V |
| G4 | En ninguna esquina T1 solo cubre el rango 0–1,3 V entero (deducido) |
| G5 | V_lo de T1 se mueve menos de 0,25 V entre las 4 esquinas |
| G6 (testigo) | A tt 27, +10 mV en V_fg en el centro de la ventana de T1 (media de V_lo y V_hi, al punto de malla más cercano) sube la corriente entre un 20 y un 40 % |

## Qué se hace con cada resultado

- **Muere la lectura de XC-14 con estos lectores** si en alguna esquina T1 y T3 juntos cubren menos de 0,40 V del rango
  0–1,3 V (criterio del plan: "corriente fuera de los dos rangos").
- **G3 cumplida:** el puesto de XC-14 lleva los dos óxidos, y la parte del rango que quede fuera se cubre con una placa de
  acoplo que solo puede **sumar** tensión (pines digitales): sirve para lo que quede por debajo de V_lo, no por encima de
  V_hi. Se anota qué tramo queda sin cubrir.
- **Inválido** si falla G6 o si algún barrido no da corriente monótona en V_fg.

## Qué no dice

Si el plasma deja carga, cuánta, ni si sobrevive: eso es silicio. Tampoco el acoplo del drenador y de la antena a la puerta,
que desplaza V_fg durante la lectura y depende del dibujo; ni si algo polariza la puerta antes de la primera lectura (la
otra mitad de C3, que se mira sobre el dibujo). Sin desajuste: el piso de 17,3 mV del plan de la familia no entra aquí.
