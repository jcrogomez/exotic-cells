# MISFIT-23 · el lector 2 extraído, con las dos precargas en el nodo, lee XC-20 · resultados

Prerregistro: [`MISFIT-23`](../../cells/preregistros/MISFIT-23_2026-11-26_lector2_extraido_lee.md), sellado y subido antes
de la tanda; análisis sellado en `ANALISIS_SHA256.txt` (los tres sellos verifican después de correr). 64 decks en `d/`,
todos acabaron en `salida 0` (`corre.out`); veredictos tal como los imprime el análisis en `m23.txt`. Simulación ngspice
con la celda `reader2fe` extraída (MISFIT-22) y la matriz `xc20w` extraída; el lazo sigue en esquemático.

## Lo aburrido primero

- **La parte que cambia es pequeña.** Solo el condensador y las precargas pasan de esquemático a extraído. El comparador,
  el cerrojo, el retardo y el cable de X hasta ellos siguen sin dibujar.
- **Que no oscile sola a ff 85 es una cancelación, no un margen.** En MISFIT-17 la matriz tiraba 32 pA hacia abajo y el
  rango bajo oscilaba sin corriente. Aquí las dos precargas apagadas meten unos 36 pA hacia arriba (`previa/`) y la fuga
  ajustada queda en +3,0 pA. Dos fugas de dispositivos distintos que casi se anulan en una esquina del modelo: en silicio
  puede quedar de cualquiera de los dos lados.
- **La dispersión entre periodos del rango bajo sigue ahí** (0,08–0,58 % según la esquina; rango alto 0,01–0,06 %) y sigue
  sin causa `[?]`.
- En el humo vi también los flancos 2 y 12 de un deck (anotado en `ANALISIS_SHA256.txt` antes de lanzar).
- `gen23.py` y `previa/` se subieron con MISFIT-17, antes de este prerregistro (dicho en él).

## Resultado

| # | Predicción | Veredicto |
|---|---|---|
| P1 | Las 6 corrientes fuera de muestra dentro de ±3 % en las 4 esquinas | **cumplida**, 24 de 24. Peor punto: +1,36 % (rango bajo, ss 85, 316 pA); rango alto entre −0,67 y −0,17 % |
| P2 (testigo) | +3 % de corriente da entre −3,5 y −2,3 % de periodo, 8 de 8 | **cumplida**: de −3,09 a −2,84 % (esperado −2,91 %) |
| P3 | Carga frente a MISFIT-17: rango alto +1..+6 %; rango bajo ±10 % | **cumplida**: alto +1,8 / +2,0 / +1,8 / +1,8 %; bajo +1,0 / +4,7 / −0,6 / −1,4 % |
| P4 | Sin corriente, ningún flanco en 20 ms, 8 de 8 | **cumplida**, 8 de 8 (ver la cancelación arriba) |
| P5 | Fuga ajustada del rango bajo a ff 85 entre −10 y +20 pA | **cumplida**: +3,04 pA |

Casos inválidos: ninguno. Control de capacidad: 64 valores entre 0,985 y 1,876 fF.

Carga ajustada por ciclo: rango bajo 50,4–57,6 fC; rango alto 171–195 fC. Fuga ajustada: rango bajo entre −6,2 y +3,0 pA;
rango alto entre −29 y +1,4 pA (a ss 85 es el 0,3 % de la corriente más baja del rango, 10 nA).

**Qué dice:** la celda dibujada lee igual que el esquemático. El rango alto gana un 1,8–2,0 % de carga, que es lo que
añaden las difusiones y el cable; el paquete del rango bajo cambia entre −1,4 y +4,7 % según la esquina.

## Decisión, por la regla escrita

P1 cumplida: **la parte analógica del lector 2 queda como está dibujada.** Lo siguiente es el lazo en celdas de librería
(con la selección de rango y la habilitación de verdad, no un inversor por línea) y la selección de puestos.

## Qué explicación aburrida no descarté

- Que lea bien porque el lazo sigue ideal: retardo, comparador y cable de X sin extraer.
- Que la cancelación de fugas a ff 85 no se dé en silicio. El contador debe poder distinguir "oscila sola" de "lee":
  hace falta una lectura con todos los puestos abiertos como cero del instrumento.
- Desajuste entre lectores, sensibilidad a la alimentación y ruido del paquete de carga: sin simular.
- El punto de +1,36 % a ss 85 es el de corriente más baja del rango bajo (316 pA) con −6,2 pA de fuga ajustada: si la
  fuga real es mayor, el suelo del rango sube.
