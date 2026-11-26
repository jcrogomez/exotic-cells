# MISFIT-20 · enmienda 1 (de dos admitidas) · tres reglas en la primera pasada

Escrita el 2026-11-26 (hora de sellado en `experiments/misfit20/PREREG_SHA256.txt`), **después** de la primera pasada y
**antes** de la segunda.

## Qué pasó (se queda en `experiments/misfit20/pasada1/`)

LVS "match" a la primera. **H1 falsa a la primera:** Magic 2 tipos de error, deck de fabricación de KLayout 11, deck completo 24.

| Regla | Qué es | Quién la ve |
|---|---|---|
| `diff/tap.15a` / `hvdifftap.15a` | difusiones de óxido grueso a menos de 0,30 µm (yo separaba 0,27) | Magic, deck completo |
| `met1.3b` / `m1.3ab` | metal 1 de más de 3 µm de ancho a menos de 0,28 µm de otro metal 1 (placa–bus X y placa–placa) | los tres |
| `hvpoly.14` | "poly must not straddle hvi": el poly de la puerta sale de la zona de óxido grueso al subir a la placa (y al bajar al bus VB en el gemelo conectado) | **solo el deck completo de KLayout**; Magic no tiene esa regla |

## Qué cambia

- Paso entre puestos de óxido grueso: 0,32 µm entre difusiones.
- Placa a 0,30 µm del bus X y de la placa vecina.
- La zona de óxido grueso se extiende sobre todo el recorrido del poly de la puerta con una indicación de máscara
  (`MASKHINTS_HVI`, el mecanismo del propio archivo de tecnología de Magic), una franja por puesto de óxido grueso, de
  0,10 µm a cada lado del poly. El diodo del gemelo queda a 0,20 µm de esa franja (la regla pide 0,18).

**Consecuencia que se anota:** el tramo de poly sobre campo queda bajo óxido grueso también. No cambia el transistor.
Si la segunda pasada trae otra regla, queda una enmienda; después la forma muere.
