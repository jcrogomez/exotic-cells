# MISFIT-18 · el abanico de XC-19 dibujado por el generador, y qué ve el modelo de cada clase · resultados

Prerregistro: [`MISFIT-18`](../../cells/preregistros/MISFIT-18_2026-11-26_xc19_abanico_generado.md) y
[enmienda 1](../../cells/preregistros/MISFIT-18_2026-11-26_xc19_abanico_generado_enmienda1.md), sellados y subidos antes de
cada pasada. Tabla: [`generator/tables/xc19fan.json`](../../generator/tables/xc19fan.json). Salida: `xc19fan/`; primera
pasada en `pasada1/`; testigo en `testigo/`; listado de F5 en `f5.txt`. Dibujo y verificación; ninguna simulación.

## Lo aburrido primero

- **Casi todo se deducía antes de correr** y está declarado en el prerregistro: C1 es C0; C3 como estaba escrita es ilegal;
  C5 no cabe en una matriz con las puertas en un bus común; el modelo no tiene términos para C4 ni C6. La corrida añade que
  las clases que quedan **son dibujables y legales en matriz**, y el listado de lo que la extracción entrega.
- **F1 fue falsa a la primera:** C6 sin contacto en el p+ viola `licon.16` en el deck completo de KLayout (Magic y el deck
  de fabricación no lo ven). Corregido con la enmienda 1; lo que se juzga es la segunda pasada.
- **La extracción no da `sa`/`sb`** (ya sabido); salen de la tabla. Para el modelo, C2 se distingue de C0 solo por eso.
- **Nada de trampas.** El modelo no las tiene, así que nada de aquí dice si C3′, C4 o C6 cambian lo que XC-19 busca.
- **C3′ no es la C3 original.** Es un escalón de la difusión a 0,075 µm de la puerta, no una puerta sobre la esquina.
- **El testigo de las tiras solo lo ven Magic y el deck completo;** el deck de fabricación de KLayout da 0 con las tiras a
  0,05 µm.

## Resultado

Tabla `xc19fan`, 18 puestos: C0 ×4, y dos copias de C2, C3′, C4, C6, C7, C8 y C9.

| # | Predicción | Veredicto |
|---|---|---|
| F1 | Limpia en Magic `drc(full)` y en los dos decks de KLayout | **falsa a la primera** (C6, `licon.16`, 2 errores); **cumplida tras la enmienda 1**: 0 / 0 / 0 |
| F2 (testigo) | Tiras de C4 a 0,05 µm dan error | **cumplida**: `poly.4` en Magic, 4 en el deck completo |
| F3 | LVS match: un transistor y un interruptor por puesto, nada más | **cumplida**: "Circuits match uniquely", 36 dispositivos |
| F4 (mutante) | Un transistor de menos no da match | **cumplida** ("Top level cell failed pin matching") |
| F5 | C3′, C4 y C6 con el mismo W y L que C0 | **cumplida** (tabla abajo) |
| F6 | Entre 4,5 y 9 µm² por puesto de media | **cumplida**: 26,59 × 5,55 µm = 147,6 µm², **8,2 µm² por puesto** |

Lo que la extracción entrega (`f5.txt`; áreas en µm², perímetros en µm):

| Clase | W / L | Área y perímetro de drenador | Área y perímetro de fuente | ¿Distinta de C0 para el modelo? |
|---|---|---|---|---|
| C0 | 0,42 / 0,15 | 0,126 · 1,44 | 0,126 · 1,44 | — |
| C2 | 0,42 / 0,15 | 0,42 · 2,84 | 0,42 · 2,84 | sí: difusión larga (`sa`, `sb` de la tabla) y uniones mayores |
| C3′ | 0,42 / 0,15 | **0,2205 · 2,28** | 0,126 · 1,44 | solo la unión de drenador |
| C4 | 0,42 / 0,15 | 0,126 · 1,44 | 0,126 · 1,44 | **no, en nada** |
| C6 | 0,42 / 0,15 | 0,126 · 1,44 | 0,126 · 1,44 | **no, en nada** (el p+ pegado no cambia ni el perímetro de fuente) |
| C7, C8, C9 | 0,84/0,15 · 0,42/0,60 · 1,68/0,30 | — | — | sí: área |

## Decisión (por la regla escrita, y por delegación)

**Como experimento con predicción, el abanico queda en área (C7–C9) y difusión (C2, y la matriz de XC-12).** C4 y C6 son
idénticas a C0 para el modelo y C3′ casi: ninguna cuenta puede decir qué mostrarían.

**C3′, C4 y C6 se quedan en el chip como puestos exploratorios,** dos copias cada una con C0 al lado. No llevan hipótesis
ni se cuentan como resultado si no aparece nada. Cuestan 8 µm² cada una. *La revertiría:* que Juan prefiera esos puestos
para más copias de C0 (más estadística de trampas), o que falte sitio.

**C1 se funde con C0. C5 (antena) pasa a XC-14,** donde se diseña el puente a metal alto que una antena por puesto necesita.

## Qué explicación aburrida no descarté

- Que el contacto añadido al p+ de C6 cambie lo que se quería ver (una unión pegada sin metal cerca).
- Que las tiras de C4, sin conectar, cojan carga y hagan de puerta parásita: en el modelo no hay nada; en silicio, no sé.
- Que 0,375 µm entre la tira y la puerta sea demasiado para cualquier efecto de proximidad: la regla no deja menos con
  contactos en la difusión.
