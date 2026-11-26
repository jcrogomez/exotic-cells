# MISFIT-20 · XC-14: el puesto de puerta flotante con antena, dibujado por el generador

Escrito el 2026-11-26 (hora de sellado en `experiments/misfit20/PREREG_SHA256.txt`), **antes** de tocar el generador. Sale de
las decisiones 11 y 12 del plan ([MISFIT-18](../../experiments/misfit18/RESULTADOS.md), [MISFIT-19](../../experiments/misfit19/RESULTADOS.md)).

## Qué se dibuja

Un cuarto tipo del generador. Cada puesto: un transistor de lectura entre el nodo X y un interruptor nfet 0,84/0,15 a GND
(como XC-19), cuya **puerta no va a ningún bus**: sube en poly hasta una placa de metal 1 (la antena), sin más conexión.
Encima de todas las placas pasa una tira de metal 2, `CP`, que es la placa de acoplo común. Opciones por puesto:

- tamaño de la placa (la antena);
- `diode`: un diodo n+ pequeño colgado de la puerta en interconexión local (el gemelo con camino de descarga);
- `tied`: la puerta además va al bus VB (el gemelo conectado);
- óxido: grueso (`nfet_g5v0d10v5` 0,42/0,5, el de lectura por la decisión 12) o fino (`nfet_01v8` 0,42/0,15).

Tabla `xc14fg`, 11 puestos: óxido grueso con placa mínima (×2), de 10 µm² (×2), 20 µm² (×2) y 40 µm² (×1); 20 µm² con diodo
(×2); 20 µm² conectada (×1); óxido fino con 20 µm² (×1). El límite de antena de metal 1 es 400 veces el área de puerta: 84 µm²
para el transistor grueso y 25 µm² para el fino, así que solo el fino queda cerca del límite (317). Placas mayores van sobre
el núcleo en metal alto y son cosa de la integración, no de esta prueba.

## Explicaciones aburridas

| Explicación | Chequeo |
|---|---|
| Sale limpia porque nadie mira una puerta sin excitador | Se anota qué dice cada herramienta de la puerta flotante (error, aviso o silencio). Testigo H2 para el DRC |
| El LVS da igual sin contar la antena ni el diodo | Mutante H4: referencia sin el diodo de un gemelo |
| El transistor de 5 V no es legal junto a los de 1,8 V sin más capas | Es lo que la prueba averigua (H1); si pide separaciones mayores, se mueven piezas y se dice |

## Predicciones

| # | Predicción |
|---|---|
| H1 | La tabla sale limpia en Magic `drc(full)` y en los dos decks de KLayout. Confianza baja: es la primera vez que el generador mezcla óxido grueso y fino; acepto hasta dos enmiendas de geometría antes de dar la forma por muerta |
| H2 (testigo) | Con las placas de dos puestos vecinos a 0,10 µm (menos que la separación de metal 1) da error |
| H3 | LVS "match": un transistor de lectura y un interruptor por puesto, más un diodo en los dos gemelos con diodo |
| H4 (mutante) | Sin un diodo en la referencia, no da match |
| H5 | Acoplo de la placa común a la puerta en los puestos de 20 µm² y óxido grueso, de la extracción: C(CP–puerta) / C total de la puerta entre 0,20 y 0,70 |
| H6 | Acoplo del nodo X a la puerta en esos mismos puestos: C(X–puerta) / C total entre 0,01 y 0,12 |

C total de la puerta = suma de las capacidades extraídas en su nodo más la de puerta del transistor (área × 3,1 fF/µm² para
el óxido grueso, 8,3 para el fino; valores de óxido de 11 y 4,15 nm, aritmética).

## Qué se hace con cada resultado

- **H5:** con el cociente k, la placa suma k × 1,8 V. Hacen falta unos 0,3 V (MISFIT-19): k ≥ 0,17. Si k < 0,17, la tira
  de acoplo se ensancha o baja de capa.
- **H6:** el nodo X baja 0,9 V en cada lectura. Si C(X–puerta)/C total > 0,05, la puerta se mueve más de 45 mV (media
  década de corriente): se separa la placa del bus X o se mete una tira a GND entre los dos, y se dice.
- **Muere** la forma si H1 no sale tras dos enmiendas. **Inválido** si fallan H2 o H4.

## Qué no dice

Nada de carga de plasma. Tampoco la otra mitad de C3 en su parte eléctrica (qué pasa con la puerta en el encendido): aquí
solo se ve, por construcción, que la puerta no tiene camino en continua salvo en los gemelos.
