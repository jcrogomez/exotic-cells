# MISFIT-11 · una matriz de puestos generada desde una tabla · resultados

Prerregistro: [`MISFIT-11`](../../cells/preregistros/MISFIT-11_2026-11-26_matriz_generada.md) (sellado y subido antes de escribir
el generador) y su [enmienda 1](../../cells/preregistros/MISFIT-11_2026-11-26_matriz_generada_enmienda1.md). Generador:
[`generator/`](../../generator/README.md). Salidas: [`m11.txt`](m11.txt) (etapa 1; primera pasada en `m11_v1.txt`),
[`w.txt`](w.txt) (etapa 2). Todo es dibujo, verificación y SPICE (ngspice 44.2, PDK 8afc8346). Nada es silicio.

## Lo aburrido primero

- **Un solo tipo de dispositivo:** nfet de 1,8 V. La unión de XC-20, las antenas y los contactos no los dibuja. La prueba G2
  del plan nombra la matriz de XC-20 y **no queda cerrada**; la segunda tabla aquí es la de XC-12.
- **Una sola fila.** 64 puestos miden 71 µm de largo. Caben en el tile (161 µm), pero no hay matriz de varias filas.
- **Las líneas de selección terminan en el borde de la matriz.** Su recorrido hasta el núcleo, el decodificador y su carga no
  están ni dibujados ni simulados.
- **Puestos iguales y sin desajuste** en la etapa 2. Dispositivos distintos en un mismo bus es la prueba R4.
- **El LOD de la matriz se anota desde la tabla** (sa, sb que el propio generador dibujó), no con Residual sobre el dibujo.
- **El precheck de Tiny Tapeout no se corrió:** se corre sobre un tile, y aún no hay tile con matriz.

## Etapa 1 · dibujo y verificación: válida

| Tabla | Puestos | Magic `drc(full)` | KLayout (fabricación / completo) | LVS | Caja (µm) | µm² por puesto |
|---|---|---|---|---|---|---|
| `u1` | 1 | 0 | 0 / 0 | match | 2,13 × 4,29 | 9,14 |
| `u16` | 16 | 0 | 0 / 0 | match | 18,12 × 4,29 | 4,86 |
| `u64` | 64 | 0 | 0 / 0 | match | 71,22 × 4,29 | **4,77** |
| `lod12` | 12 | 0 (1 en la primera pasada) | 0 / 0 | match | 57,60 × 4,29 | 20,6 |

| # | Predicción | Veredicto |
|---|---|---|
| M1 | El puesto generado extrae igual que el del lector | **cumplida**: W, L, áreas y perímetros idénticos en dispositivo e interruptor |
| M2 | `u16`, `u64` y `lod12` limpias, sin editar a mano | **falsa** en la primera pasada; **cumplida** tras la enmienda 1 |
| M3 | Dos referencias alteradas no dan match | **cumplida** (W = 0,50 en un puesto; un puesto de menos) |
| M4 | Paso 0,10 µm menor da error de DRC | **cumplida** (`diff/tap.3`) |
| M5 | Entre 4 y 7 µm² por puesto en `u64` | **cumplida**: 4,77 |

**Qué falló y qué se cambió:** `lod12` violó `LU.2` (difusión n a más de 15 µm de una toma de sustrato). El generador ponía
tomas cada N puestos, y los puestos de 6 µm de difusión a cada lado miden 12 µm. Ahora pone una toma también por distancia
(10 µm). Nadie tocó la salida; se cambió una regla del generador y se repitieron las cuatro tablas, los mutantes y el testigo.
`u16` y `u64` salieron con la misma caja que antes.

## Etapa 2 · el lector leyendo la matriz extraída: válida, todo cumplido

Lector pequeño `v_f3` con su propio puesto abierto y una matriz extraída (con capacidades) en cada lado, un puesto cerrado.

| # | Predicción | Veredicto | tt 27 | ff −40 | ss 85 | ff 85 |
|---|---|---|---|---|---|---|
| W1 | +0,26 a +0,40 % de tiempo por puesto | **cumplida** | 0,360 | 0,340 | 0,346 | 0,334 |
| W2 | Con 64 puestos, ≤ 1,5 veces el lector solo | **cumplida** | 1,230 | 1,217 | 1,221 | 1,214 |
| W3 | El salto de una carga cambia ≤ 5 % relativo | **cumplida** | −0,71 % | −0,93 % | −2,35 % | −1,12 % |
| W4 | Puesto 0 y puesto 63 leen igual dentro de 0,05 % | **cumplida** | 0,0008 % | 0,0005 % | 0,0045 % | 0,0013 % |

Controles: el lector solo repite su contrato con 0,0000 % en las 4 esquinas; el testigo de 1 fF da +0,65 a +0,70 %.

**Lectura:** el alambre añade unas 0,11 puntos por puesto a los 0,23–0,25 de la rama sin alambre. Con 64 puestos la lectura
tarda un 21–23 % más y el salto de una carga pierde como mucho un 2,35 % (esquina caliente lenta, por la fuga de los puestos
abiertos). La posición en el bus no importa.

**Decide (regla escrita):** 64 puestos por lector queda confirmado con cableado. La decisión 7 del plan se mantiene.

**Cuenta que sale de aquí (aritmética, nada colocado):** dos matrices de 64 puestos mínimos (lados A y B) son 611 µm². En la
franja libre de 1 533 µm² tras dos lectores caben, por área, dos lectores con 64 puestos cada uno solo si los dispositivos son
mínimos; los de difusión larga cuestan cuatro veces más por puesto.

## Qué explicación aburrida no descarté

- Que las líneas de selección y su decodificador ocupen más que la matriz.
- Que la capacidad extraída por Magic del bus de metal 1 se quede corta frente a un extractor con acoplo lateral.
- Que con dispositivos distintos en el bus la fuga de los abiertos ya no sea la de MISFIT-05.
