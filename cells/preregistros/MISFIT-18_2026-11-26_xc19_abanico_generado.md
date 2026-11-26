# MISFIT-18 · el abanico de XC-19 dibujado por el generador, y qué ve el modelo de cada clase

Escrito el 2026-11-26 (hora de sellado en `experiments/misfit18/PREREG_SHA256.txt`), **antes** de tocar el generador.
Segundo candidato del orden (XC-19). Es la prueba C1 del plan: qué distingue a las clases del abanico en un modelo.
Definición del abanico: [prerregistro de discriminación](XC-19_2026-11-23_discriminacion_abanico.md) §4.

## Lo que se deduce sin correr nada (declarado)

- **C1 no existe aparte de C0.** "sa = sb mínimos" con contacto es 0,30 µm, que ya es C0. Se funden.
- **C3 tal como se escribió (puerta sobre una esquina de STI) es ilegal:** poly.11, "no bends in transistors"
  ([caza de formas](../../experiments/xc64_hunt/RESULTADOS.md)). Lo más cerca que deja la regla es un escalón de la difusión a
  0,075 µm del borde de la puerta. Eso es lo que se intenta dibujar (C3′).
- **C5 (antena) no cabe en esta matriz:** todas las puertas comparten el bus VB, así que una antena en una puerta es de
  todas. Una antena por puesto pide un puente a un metal alto. Se diseña con XC-14, no aquí.
- **El modelo del PDK no tiene términos de proximidad de poly ni de unión vecina.** Para C3′, C4 y C6 se espera que la
  extracción entregue el mismo transistor que C0 (mismo W y L) y que solo cambien áreas y perímetros de unión y capacidades.
  La corrida lo comprueba; la dirección no es noticia.

## Qué se dibuja

Tabla `xc19fan`, 18 puestos nfet con interruptor de fuente, en la matriz de MISFIT-11:

| Clase | Qué es | Copias |
|---|---|---|
| C0 | 0,42/0,15, sa = sb = 0,30 | 4 |
| C2 | 0,42/0,15, sa = sb = 1,0 | 2 |
| C3′ | C0 con la difusión del drenador ensanchada 0,42 µm a 0,075 µm de la puerta (esquina de STI junto al canal) | 2 |
| C4 | C0 con una tira de poly sin conectar a cada lado, a 0,075 µm de la difusión (0,375 µm de la puerta) | 2 |
| C6 | C0 con un p+ pegado al extremo de fuente de la difusión (la unión de XC-20 junto al canal) | 2 |
| C7, C8, C9 | 0,84/0,15; 0,42/0,60; 1,68/0,30 | 2 cada una |

## Predicciones

| # | Predicción |
|---|---|
| F1 | La tabla sale limpia en Magic `drc(full)` y en los dos decks de KLayout, sin editar a mano |
| F2 (testigo) | La misma tabla con las tiras de C4 a 0,05 µm de la difusión da error |
| F3 | LVS "match" contra la referencia generada: un transistor y un interruptor por puesto, nada más (ni las tiras ni el p+ añaden dispositivos) |
| F4 (mutante) | Con un transistor de menos en la referencia, el LVS no da match |
| F5 | En el netlist extraído, los puestos C3′, C4 y C6 tienen el mismo W y L que C0. Difieren, como mucho, en áreas y perímetros de fuente y drenador y en capacidades |
| F6 | Área media por puesto entre 4,5 y 9 µm² |

**Si F1 falla por una clase:** esa clase muere tal como está dibujada; se quita con una enmienda y se dice qué regla la cierra.
**Inválido** si fallan F2 o F4.

## Qué se hace con F5

La fila C1 del plan decía: "sin diferencia predicha, el abanico se redibuja como barrido de área". Si F5 se cumple, eso se
aplica así: **como experimento de discriminación con predicción, el abanico queda reducido a área (C7–C9) y difusión (C2 y la
matriz de XC-12)**. C3′, C4 y C6 no se presentan como hipótesis con predicción: se quedan como puestos exploratorios, con
dos copias y C0 al lado, porque cuestan un puesto cada uno y el modelo no puede decir nada de ellos en ningún sentido.
Es decisión por delegación y Juan la puede revertir.

## Qué no dice

Nada de trampas: el modelo no las tiene. Nada de lo que la litografía hace con las tiras o el escalón.
