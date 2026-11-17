# Prerregistro · XC-19 · de consumo del tile a error de lectura (función de transferencia de la alimentación)

Escrito el 2026-11-17 12:12 EST (hora de `date`), antes de correr. Simulación; nada de silicio.

## Pregunta

El interruptor de alimentación del tile tiene resistencia ([`experiments/tt_power_gate`](../../experiments/tt_power_gate/README.md)).
¿Cuánto mueve una lectura un cambio de consumo del tile, según cuándo ocurre y según cómo se lee (un lado solo, A y B a la vez,
A y B en turnos)? Hasta ahora el 0,84 % por mA era aritmética: sensibilidad estática por resistencia. Falta la función de
transferencia: efecto estático, escalón a mitad de conversión, rizado a la frecuencia del reloj, y el caso en que A y B no tardan
lo mismo (que es el de una celda desconocida).

## Montaje

Canal extraído y anotado (`cells/xc19_channel/xc19_channel_lod.inc`), tres en serie, 133 fF ideales por nodo, inversores de
librería, tt, 27 °C, modo `hsa`: el de `cells/xc19_channel/channel_sim.sp`. Cambio único: la alimentación llega por una resistencia
Rs desde 1,8 V ideales y una fuente de corriente carga el nodo alimentado. Rs = 1,85 Ω (transistor de `tt_pg_1v8_ll_1`, el gate de
un tile 1×1 según `tt-multiplexer/py/tt/placer.py`) y 5 Ω (0,1 V a 20 mA de la especificación). Sin desacoplo.

Casos: `q` sin carga · `s1` 1 mA continuo · `s8` 8 mA continuo · `s1r5` 1 mA con 5 Ω · `m1` escalón 0→1 mA a los 15 µs ·
`r1` cuadrada 0/2 mA a 50 MHz (media 1 mA) · `uq` B con 266 fF, sin carga · `u1` B con 266 fF y escalón 0→1 mA a los 36 µs
(cuando A ya terminó).

## Lo que se deduce de lo ya sabido (no es hallazgo si sale)

La sensibilidad estática del canal es −6,53 % por +10 mV (`channel_sim.txt`: 30,2733 → 28,2964 µs). Por tanto `s1`, `s8` y `s1r5`
casi se deducen; se corren como control de que el montaje reproduce lo conocido. Lo no deducible es `m1`, `r1` y `u1`.

## Predicciones

| | Predicción | Falla si |
|---|---|---|
| P0 control | `q` da 30,27 µs en A y en B | se aparta más de 1 %: fallo instrumental, se detiene todo |
| P1 estático, un lado | `s1`: +1,2 % · `s8`: +9 a +12 % · `s1r5`: +3,3 % | fuera de 1,0–1,4 % · 9–12 % · 2,8–3,8 % |
| P2 A y B a la vez, iguales | el cociente A/B se mueve menos de 0,01 % en `s1`, `s8`, `m1` y `r1` | se mueve más |
| P3 escalón a mitad | `m1` mueve un lado entre 30 % y 70 % de lo que mueve `s1` | fuera de ese intervalo |
| P4 rizado | `r1` mueve un lado lo mismo que `s1` (misma media), ±10 % relativo | fuera |
| P5 A y B desiguales | en `u1`, A no cambia (< 0,01 %) y el cociente B/A se mueve entre 0,3 y 0,6 veces lo de `s1` | fuera |

Lectura en turnos (A en calma, B con carga): se mueve lo que un lado solo. Es aritmética, no se corre.

## Qué decide cada resultado

- P2 cumple y P5 cumple: leer A y B a la vez protege solo si tardan parecido. Para una celda desconocida no basta; hace falta
  además actividad igual entre lecturas, o repetir la calibración en la misma ventana.
- P2 falla: el gemelo no protege ni en el modelo; se replantea.
- P5 falla por abajo (cociente no se mueve): la lectura simultánea protege más de lo que creo; buena noticia, a entender.
- P4 falla: el rizado del reloj no se promedia; la actividad digital durante la cuenta importa por su forma y no solo por su media.

## Fuera de alcance

Desajuste entre A y B (dato previo: mediana 0,047 % por 10 mV, `n5.txt`), ruido, metal de la red de alimentación, rebote de tierra,
acoplo por sustrato, desacoplo real del tile. Nada se añade después de ver el resultado; lo que se corra luego es exploratorio.

## Criterio de abandono

P0 falla, o más de dos decks no convergen: se detiene y se reporta el fallo. No se ajusta el montaje para que salga.
