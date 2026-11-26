# MISFIT-19 · XC-14: qué carga de puerta flotante cae dentro de los lectores · resultados

Prerregistro: [`MISFIT-19`](../../cells/preregistros/MISFIT-19_2026-11-26_xc14_ventana_de_lectura.md), sellado y subido antes
de escribir los decks. Tabla completa: `m19.txt`. Modelo (ngspice, PDK sky130A), en esquemático; nada es silicio.

## Lo aburrido primero

- **La puerta no flota en la simulación:** es una fuente que se barre. La prueba dice qué tensión de puerta sería legible,
  no qué tensión deja el plasma ni si queda alguna.
- **Dos pasadas.** En la primera escribí mal la orden de salida y el archivo traía la suma de las tres corrientes; vi una
  fila (2 pA a V_fg = 0, tt 27) antes de corregirlo. Está en `pasada1/`. Solo cambié columnas y signo.
- **Sin acoplo del drenador ni de la antena a la puerta, sin desajuste, sin layout.** El desajuste de umbral del transistor
  mínimo (17,3 mV) mueve la ventana, y con la pendiente medida (99 mV por década) es un factor 1,5 en corriente.
- **El rango 0–1,3 V es de una cuenta al orden,** no una medida.
- La dirección de G1, G4 y G5 se deducía. Lo que no sabía, y fallé, es el transistor de óxido grueso.

## Resultado (X = 1,35 V; con X = 0,9 y 1,8 V los extremos se mueven menos de 30 mV)

Ventana de tensión de puerta con la corriente del puesto entre 100 pA y 10 µA:

| Transistor | tt 27 | ff −40 | ss 85 | ff 85 |
|---|---|---|---|---|
| T1, 1,8 V, 0,42/0,15 | 0,309 – 0,855 V | 0,329 – 0,763 | 0,307 – 0,975 | 0,092 – 0,712 |
| T2, 1,8 V, 1,0/0,5 | 0,263 – 0,839 | 0,349 – 0,815 | 0,194 – 0,880 | 0,132 – 0,780 |
| T3, óxido grueso, 0,42/0,5 | 0,248 – 1,147 | 0,306 – 0,991 | 0,226 – 1,368 | 0 – 0,962 |

| # | Predicción | Veredicto |
|---|---|---|
| G1 | T1 a tt 27: V_lo 0,22–0,40; V_hi 0,70–0,95 | **cumplida**: 0,309 y 0,855 V |
| G2 | T3 a tt 27: V_lo 0,45–0,80; V_hi ≥ 1,15 | **falsa**: V_lo 0,248 V (empieza **antes** que T1, no después) y V_hi 1,147 V |
| G3 | T1 y T3 juntos cubren ≥ 0,75 V seguidos en cada esquina | **falsa**: 0,685 V a ff −40 (0,90 / 1,14 / 0,96 en las otras) |
| G4 | T1 solo no cubre 0–1,3 V en ninguna esquina | **cumplida** |
| G5 | V_lo de T1 se mueve < 0,25 V entre esquinas | **cumplida**, justa: 0,237 V (ff 85 se va a 0,092 V) |
| G6 (testigo) | +10 mV suben la corriente 20–40 % | **cumplida**: 26,2 % (98,9 mV por década) |

**Criterio de muerte: no cumplido.** En la peor esquina (ff −40) se cubren 0,685 V de los 1,3.

**Qué dice:**

1. **Hay ventana.** Una puerta que nazca entre unos 0,3 y 1,0 V da una corriente que el lector 2 lee, en las 4 esquinas.
2. **Me equivoqué con el óxido grueso:** supuse un umbral más alto y la ventana desplazada hacia arriba. Su ventana empieza
   a la misma altura o antes y acaba más arriba, porque su corriente crece más despacio: **contiene a la de T1 en las 4
   esquinas**. T1 no añade rango.
3. **Queda sin cubrir** por abajo hasta 0,23–0,31 V (salvo a ff 85) y por arriba desde 0,96–1,15 V hasta 1,3 V en tres
   esquinas. Por abajo sirve una placa de acoplo, que solo suma tensión. Por arriba la corriente pasa de 10 µA: el lector
   satura y solo dice "más de".
4. **La temperatura mueve la ventana** unos 0,2 V entre −40 y 85 °C: sin el gemelo conectado al lado no se interpreta.

## Decisiones (por delegación)

- **El transistor de lectura de XC-14 es el de óxido grueso.** G3 falsa deja sin aplicar la regla escrita ("los dos
  óxidos"), así que decido: su ventana contiene a la del fino y es el que no pierde la carga por túnel. El de óxido fino
  entra como contraste (es el que se descarga, y eso también es un dato), no para ganar rango. *La revertiría* que el
  transistor de 5 V no sea legal en la matriz sin su pozo o sus capas propias, o que su puesto no quepa.
- **Placa de acoplo en cada puesto,** para el tramo de abajo. Tamaño por decidir con el dibujo (hace falta sumar ~0,3 V).
- **Tramo de arriba:** probar un canal más largo en el óxido grueso (menos corriente a igual tensión). Sin correr.

## Qué explicación aburrida no descarté

- Que el modelo del transistor de óxido grueso no valga a 0,42/0,5 en subumbral (está en el borde de sus tamaños).
- Que el acoplo del drenador a la puerta (X baja de 1,8 a 0,9 V en cada lectura) mueva V_fg tanto como la ventana: depende
  del cociente de capacidades, que saldrá del dibujo.
- La otra mitad de C3: si algo polariza la puerta antes de la primera lectura. Sin mirar.
