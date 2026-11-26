# MISFIT-18 · enmienda 1 · C6 sin contacto viola licon.16

Escrita el 2026-11-26 (hora de sellado en `experiments/misfit18/PREREG_SHA256.txt`), **después** de la primera pasada y
**antes** de la segunda.

## Qué pasó (se queda en `experiments/misfit18/pasada1/`)

Magic `drc(full)` 0, deck de fabricación de KLayout 0, LVS "match". El deck completo de KLayout da **2 errores, los dos en
C6**: `licon.16`, "tap must enclose one licon". Dibujé el p+ pegado a la fuente sin contacto, razonando que es sustrato y no
lo necesita. **F1 es falsa en la primera pasada**, y por la regla escrita C6 muere tal como estaba dibujada.

## Qué cambia

C6 se redibuja con un contacto dentro del p+ (0,17 × 0,30 µm, a 0,17 µm del contacto de fuente) y su trozo de interconexión
local encima, sin llevarlo a ningún bus: eléctricamente sigue siendo sustrato. Las otras clases no se tocan. Es mover una
pieza del generador, que es lo que la regla permite antes de dar la clase por cerrada.

Se vuelve a correr todo: F1 a F6 se juzgan sobre la segunda pasada, con F1 anotada como "falsa a la primera".
