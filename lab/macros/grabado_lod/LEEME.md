# G-LOD · auditoría del esfuerzo STI (XC-12) — corrida del 2026-11-11 20:44–20:47 EST (hora de `date`)

Ejecuta los pasos 1, 2 y 4 de `docs/AUDITORIA_LOD_1111_BORRADOR.md`. La predicción y los criterios estaban escritos ahí antes de
correr. PDK: `local_flow/pdk_host/.../8afc8346.../sky130A` montado en `/pdk`. Herramientas: ngspice 44.2 y Magic 8.3.530 de la imagen
`hpretl/iic-osic-tools:2025.07`. Todo es **modelo y extracción**; nada es silicio.

## Resultado

**Paso 1 (ngspice, esquemático, tt, 27 °C, Vgs = 0,9 V, Vds = 0,05 V; `sim/lod_paso1.sp`, `sim/lod_paso1.log`).**

| W/L (µm) | `sa = sb` (µm) | Vth (V) | ΔVth frente a 1,04 | Predicho | Id lineal | Id saturación (1,8/1,8 V) |
|---|---|---|---|---|---|---|
| 0,42/0,15 | 0 (por defecto) | 0,774446 | 0 | — | igual | igual |
| 0,42/0,15 | 0,30 | 0,797944 | +23,50 mV | +23,5 mV | −18,1 % | −4,2 % |
| 0,42/0,15 | 1,04 (`saref`) | 0,774446 | 0 | 0 | ref. | ref. |
| 0,42/0,15 | 3,0 | 0,766855 | −7,59 mV | −7,6 mV | +6,1 % | +1,4 % |
| 5/0,15 | 0 (por defecto) | 0,707852 | 0 | — | igual | igual |
| 5/0,15 | 0,30 | 0,741206 | +33,35 mV | — | −20,3 % | −5,1 % |
| 5/0,15 | 3,0 | 0,697078 | −10,77 mV | — | +6,6 % | +1,7 % |

- La fórmula de la auditoría acierta al 0,1 mV. Rango entre 0,30 y 3,0 µm: **31,1 mV** (W = 0,42) y **44,1 mV** (W = 5); la auditoría
  anticipaba "~31 mV" y "hacia ~46 mV" con W grande.
- **`sa = sb = 0` da exactamente lo mismo que `sa = sb = saref`**, en Vth y en corriente. Que 0 es un apagado y no una distancia
  física lo muestra la instancia de control con `sa = 0,3e-6` µm (casi cero): Vth = 0,9396 V, +165 mV.
- Unidad: `sa`/`sb` van en µm, como `w` y `l` (`.option scale=1.0u`).
- No medido: la movilidad por separado (ngspice no expone `ueff` para este modelo). La corriente lineal mezcla umbral y movilidad.

**Paso 2 (Magic, `lod.tcl`, `lod.log`).** Dos `nfet_01v8` 0,42/0,15 con difusión de 0,30 y 3,0 µm a cada lado, contactos a la misma
distancia del poly. DRC de Magic: 0 en los dos. Netlists extraídos:

```
lod_sa030: X0 D G S VSUBS sky130_fd_pr__nfet_01v8 ad=0.126 pd=1.44 as=0.126 ps=1.44 w=0.42 l=0.15
lod_sa300: X0 D G S VSUBS sky130_fd_pr__nfet_01v8 ad=1.26 pd=6.84 as=1.26 ps=6.84 w=0.42 l=0.15
```

Solo difieren en `as/ad/ps/pd`. **Brecha confirmada:** el flujo abierto simula los dos con el mismo umbral, y el modelo del propio
PDK dice que difieren en 31,1 mV.

**Paso 3.** No se corrió: se deduce de 1 y 2 (anotar `sa/sb` a mano en estos netlists reproduce las filas del paso 1).

**Paso 4 (desajuste, `tt_mm`, 300 sorteos; `sim/lod_paso4_mm.sp`, `sim/lod_paso4_mm.log`).** σ(Vth) de un dispositivo:
**17,3 mV** (0,42/0,15) y **5,13 mV** (5/0,15).

| W/L | Efecto (0,30 ↔ 3,0) | σ de una pareja (√2·σ) | Efecto / σ de pareja | Parejas por nivel para 5 σ |
|---|---|---|---|---|
| 0,42/0,15 | 31,1 mV | 24,5 mV | 1,3 | 16 |
| 5/0,15 | 44,1 mV | 7,25 mV | 6,1 | 1 |

La matriz G-LOD debe usar transistores anchos, como anticipó la auditoría. Supuestos: el modelo de desajuste del PDK vale, y no hay
gradiente del dado (no incluido).

## Qué queda demostrado, modelado y abierto

- **Demostrado (corrida reproducible):** el extractor de Magic con este PDK no emite `sa/sb`; el modelo trata ese caso como la
  geometría de referencia; el modelo predice hasta 44 mV de umbral por longitud de difusión.
- **Modelado:** el tamaño del efecto y el número de réplicas.
- **Abierto:** si el silicio sigue al modelo (el test tile de SkyWater barre `sa/sb`: `docs/pesca/PESCA_OPTO_1104.md` §5, datos sin
  cotejar); `sd` y dispositivos de varios dedos; pfet y variantes lvt/hvt; si las celdas estándar se caracterizaron con o sin
  `sa/sb` `[?]`; qué `sa/sb` reales tienen las celdas estándar.

## Qué define

Primer módulo de Residual: leer el layout, calcular `sa/sb/sd` por instancia y anotarlos en el netlist extraído. Caso de prueba:
estos dos GDS, con resultado esperado 31,1 mV.

## Reproducir

```
P=<ZTASIC>/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A
cd macros/grabado_lod
docker run --rm -v "$PWD":/work -v "$P":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c \
  'cd /work && magic -dnull -noconsole -rcfile /pdk/libs.tech/magic/sky130A.magicrc lod.tcl'
cd sim
docker run --rm -v "$PWD":/work -v "$P":/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c \
  'cd /work && ngspice -b lod_paso1.sp && ngspice -b lod_paso4_mm.sp'
```
