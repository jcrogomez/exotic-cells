# MISFIT-23 · el lector 2 extraído, con las dos precargas en el nodo, lee XC-20

Escrito el 2026-11-26 (hora de sellado en `experiments/misfit23/PREREG_SHA256.txt`), **antes** de correr ningún deck del
lazo. Ya existían, sin veredicto alguno: un borrador del generador (`gen23.py`, subido con MISFIT-17) y una cuenta previa
de fuga (`previa/`, punto de operación, sin lazo), que se usa abajo para fijar P4 y P5.

## Qué se simula

Lo mismo que [MISFIT-17](../../experiments/misfit17/RESULTADOS.md) (mismo lazo en esquemático, misma matriz `xc20w`
extraída, mismas corrientes), cambiando el condensador y la precarga del esquemático por la celda `reader2fe` **extraída**
([MISFIT-22](../../experiments/misfit22/RESULTADOS.md)): las dos precargas cuelgan a la vez del nodo, la del otro rango
con la puerta en VDD; cuatro nodos intermedios separados; áreas de difusión y capacidades de cable reales.

Por (rango, esquina): 3 calibraciones, 3 fuera de muestra, testigo y sin corriente. 2 rangos × 4 esquinas × 8 = 64 decks.

**Tres cambios respecto de MISFIT-17, por lo aprendido allí:**
1. **Testigo de +3 %, no +1 %** (3,2572 nA y 1,03 µA): los periodos del rango bajo se dispersan 0,2–0,6 % y +1 % no
   discriminaba. Esperado: −2,91 % de periodo.
2. Paso máximo como en la primera tanda (el fino no cambió nada, enmienda 1 de MISFIT-17).
3. Se imprimen los 12 flancos; el periodo es la media de los diez intervalos del 2 al 12, y se informa su dispersión.

## Explicaciones aburridas

| Explicación | Chequeo |
|---|---|
| Lee bien porque la celda extraída es casi el esquemático | Se compara la carga ajustada con la de MISFIT-17 (P3) y la fuga (P5): si no cambian, se dice |
| El banco no ve cambios | Testigo de +3 % (P2) |
| El lazo no arranca con la celda extraída | Humo antes de lanzar: un deck (bajo, tt 27, 100 nA), solo se mira que dé 12 flancos |
| El diodo vuelve con el área mal | El control de capacidad de MISFIT-17 sigue en cada deck (0,5–3 fF) |

## Cuenta previa (`experiments/misfit23/previa/`)

Las dos precargas apagadas meten en el nodo, a 0,9 V: 10 fA (tt 27), 4 fA (ff −40), 0,5 pA (ss 85), **36 pA (ff 85)**,
hacia arriba. La matriz a ff 85 tiraba 32 pA hacia abajo (ajuste de MISFIT-17): casi se cancelan.

## Predicciones

| # | Predicción |
|---|---|
| P1 | Las 6 corrientes fuera de muestra dentro de ±3 % en las 4 esquinas (24 de 24) |
| P2 (testigo) | +3 % de corriente da entre −3,5 y −2,3 % de periodo, 8 de 8 |
| P3 | Carga ajustada frente a la de MISFIT-17, misma esquina: rango alto entre +1 y +6 %; rango bajo dentro de ±10 % |
| P4 | Sin corriente, ningún flanco en 20 ms, 8 de 8 (apuesta floja en rango bajo a ff 85) |
| P5 | Fuga ajustada del rango bajo a ff 85 entre −10 y +20 pA (era −32 pA; negativa = descarga el nodo) |

## Qué se hace con cada resultado

- **P1 cumplida:** la parte analógica queda como está dibujada; lo siguiente es el lazo en celdas de librería colocadas y
  la selección de puestos.
- **P1 falla en 1 o 2 puntos del extremo bajo:** se sube el suelo del rango y se dice.
- **P1 falla en 3 o más:** el dibujo no sigue así; se prueba primero unir los nodos intermedios y, si no basta, separar
  las precargas del nodo con un interruptor.
- **P3 o P5 falsas:** se anota el valor medido; no bloquean.
- **Inválido** un (rango, esquina) con el testigo fuera de banda o sin periodo en la calibración; inválida la tanda si
  falla el control de capacidad.

Tope 3600 s por deck. Nada de silicio, desajuste, ruido, ni del cable de X sin dibujar.
