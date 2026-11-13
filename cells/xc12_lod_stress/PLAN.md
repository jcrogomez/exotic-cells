# XC-12 · LOD

**Instrumento o control (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-12 de [catálogo](../../README.md#catalogue) (Diffusion-length stress (LOD)).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-12 · LOD.** Esfuerzo mecánico del STI → transistor con longitud de difusión elegida → ninguna, lo fija la litografía → Vth y
corriente → umbral por layout sin máscara, y validación del extractor → pares con desplazamiento deliberado, referencia → matriz de
transistores anchos, 0,30 frente a 3,0 µm. **Mantener, prioridad 1.** Corrida del 2026-11-11 (`experiments/lod_audit/`): el modelo del
PDK predice 31,1 mV (W = 0,42) y 44,1 mV (W = 5); Magic no emite `sa/sb` y el flujo simula ambos iguales; una pareja ancha por nivel
da 6 σ según el modelo de desajuste. El primer módulo de Residual ya recupera esa diferencia desde el layout (`residual/`). *Estado al 2026-11-12:* anotada la biblioteca
estándar entera (`experiments/stdcell_lod`): los anillos de celdas extraídas cambian entre 2,5 % y 5 % al anotar, y en sentido
contrario al que predije, porque el pfet gana más de lo que el nfet pierde. Leída por la etapa de XC-19, la pareja da un cociente
de corriente de 2,36, pero el cociente de tiempos queda en 1,64 porque la difusión larga también es más capacidad en el drenaje:
como calibración hay que dibujarla con la difusión larga del lado de la fuente o igualar la capacidad. Sirve como prueba interna
del lector y del extractor, no como calibración física independiente; esa pide perturbaciones conocidas ajenas al fenómeno
(un escalón de puerta, un condensador de referencia, una corriente de prueba). Límite honesto: es programación por layout, no después de
fabricar; su valor es metrológico antes que funcional.

## 2. Lectura y piso

Dos lectores: la etapa en inversión débil de XC-19 para parejas de transistores, y el cociente de anillos para celdas enteras.
Todo es **corrida** sobre modelo y extracción; nada es silicio.

| Cantidad | Valor | De dónde |
|---|---|---|
| Señal, difusión de 0,30 frente a 3,0 µm a cada lado | 31,1 mV (W = 0,42) y 44,1 mV (W = 5) de umbral | `experiments/lod_audit`, **corrida** |
| La misma pareja leída por la etapa de XC-19 | Cociente de corriente 2,36; de tiempos 1,64 (el drenaje largo añade capacidad) | `experiments/xc19_weak_inversion` (N4), **corrida y cálculo** |
| Difusión larga solo del lado de la fuente | 15,5 mV y cociente de corriente 1,53, con la misma unión de drenaje | mismo README, **corrida** |
| Piso: desajuste de umbral de un dispositivo | σ = 17,3 mV (0,42/0,15) y 5,13 mV (5/0,15) | `experiments/lod_audit`, **corrida** (modelo `tt_mm`, 300 sorteos) |
| Parejas necesarias | Una pareja ancha por nivel separa a 6 σ; con el mínimo, 16 parejas por nivel | mismo, **cálculo**; ignora el gradiente del dado |
| Anillos de celdas estándar, anotado frente a extraído | 2,5 a 5,1 % más rápidos | `experiments/stdcell_lod`, **corrida** |
| Piso del cociente de dos anillos | `[?]` sin caracterizar | [`../PLANTILLA.md`](../PLANTILLA.md) |

Señal/piso: unas 6 veces con transistores anchos, según el modelo de desajuste. La fila de los anillos no es una señal medible
tal cual: en silicio no existe el anillo "sin anotar"; solo se mide una celda contra otra de distinta difusión.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Desajuste entre los dos transistores de la pareja | Transistores anchos; réplicas; parejas especulares (larga a la izquierda y a la derecha) |
| Gradiente del dado | Niveles intercalados y en centroide común; un anillo de referencia en cada esquina del macro |
| Capacidad de la unión de drenaje, que crece con la difusión (ya observado: 1,64 frente a 2,36) | Difusión larga solo en la fuente; o condensador que iguale el nodo; leer los dos sentidos |
| Resistencia de fuente y drenaje: el contacto queda más lejos o más cerca | Contactos a la misma distancia del poly en todos los niveles (así se dibujó la auditoría) |
| Proximidad de pozo (XC-13), que cambia si la difusión larga se acerca al pozo | Distancia al pozo fija en todo el barrido; matriz cruzada con XC-13 |
| Entorno de poly: densidad y vecinos alteran el largo grabado | Poly ficticio a paso fijo a ambos lados en todos los niveles |
| Esfuerzo del encapsulado (XC-44) | Pareja repetida a 0° y 90°; afecta a los dos por igual si están juntos |
| El modelo acierta por construcción: Residual solo devuelve lo que el modelo ya decía | Sin control en simulación: lo decide el silicio. Es la pregunta abierta de la familia |

Gemelo: el transistor con la difusión de referencia del modelo (1,04 µm, **PDK**), para el que anotar no cambia nada.

## 4. Referencia convencional (control científico, no filtro)

Para tener varios umbrales en un mismo chip, la biblioteca ya ofrece las variantes de umbral del PDK (lvt, hvt), que cuestan
máscaras que el proceso ya incluye, y el cambio de W y L. Para ganar como función, LOD tendría que dar un desplazamiento fino y
continuo que esas variantes no dan, con dispersión menor que el propio desplazamiento. Como metrología compite con no hacer nada:
el flujo abierto tal como está. Gana si el netlist anotado predice el silicio mejor que el extraído; si predicen igual de mal,
gana lo convencional y Residual no aporta en este eje. Referencia ajena: los barridos de `sa`/`sb` del test tile de SkyWater
(laboratorio, `docs/pesca/PESCA_OPTO_1104.md` §5, **leído por agente**, datos sin cotejar).

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho: auditoría de extracción y modelo, con predicción previa cumplida al 0,1 mV (`experiments/lod_audit`).
2. Hecho: anotador `residual/lod_annotate.py`, ocho geometrías y diez rechazos; de extremo a extremo recupera 31,09 mV.
3. Hecho: biblioteca estándar anotada, 415 de 437 celdas (`experiments/stdcell_lod`); predicción de signo fallada y explicada.
4. Hecho: pareja leída por la etapa de XC-19 (N4); predicción fallada (1,64 frente a 2,4–2,9) y causa identificada.
5. Hecho: borde legal de la difusión junto a la puerta: 0,250 µm sin contacto, 0,275 µm con contacto centrado (`residual/drc_edge`).
6. Pendiente: cotejar los datos crudos del test tile de SkyWater (`sa`/`sb`) contra el modelo. Es silicio ajeno ya medido y puede
   contestar la pregunta abierta antes de fabricar nada.
7. Pendiente: pfet y variantes lvt/hvt en la auditoría (el pfet de `inv_1` se mueve 88,5 mV en sentido contrario, **corrida**).
8. Pendiente: `sd` y varios dedos en el anotador; hoy no los lee.
9. Pendiente: redibujar la pareja con la difusión larga del lado de la fuente y repetir N4 con predicción escrita antes.
10. Pendiente: averiguar si la biblioteca se caracterizó con `sa`/`sb`. Hasta saberlo no se mezclan tiempos anotados y de
    biblioteca.
11. Pendiente: generador por script de la matriz, DRC en los dos decks (con el front-end activo), extracción y anotación.

### 5.2 Configuraciones a dibujar

Valores propuestos, no medidos. Borde inferior conocido: 0,250 µm sin contacto y 0,275 µm con contacto (**corrida**).

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Largo de difusión simétrico, `sa = sb` | 0,275; 0,52; 1,04 (referencia del modelo); 3,0; 10 µm | ¿La curva sigue 1/(S + L/2) como el modelo, y dónde satura? |
| Asimetría | Larga solo en fuente; larga solo en drenaje; ambas | Separa esfuerzo de capacidad de drenaje; ¿el esfuerzo es simétrico como dice el modelo? |
| Ancho W a largo fijo | 0,42; 1,0; 5,0 µm | El modelo dice que el efecto crece con W (31,1 → 44,1 mV); ¿lo hace el silicio? |
| Largo de canal L | 0,15; 0,50; 1,0 µm | El esfuerzo se concentra en los bordes: ¿se diluye en canal largo? |
| Dedos a W total constante | 1 × 5; 2 × 2,5; 5 × 1 µm | Los dedos interiores ven difusión compartida (`sd`): prueba de lo que el anotador aún no lee |
| Forma de la difusión | Rectangular; en L; en escalón, con el mismo largo efectivo según la ec. 14.10 | ¿Vale la suma por franjas del manual, o cuenta la forma? |
| Ancho del aislamiento al otro lado | Activa vecina a la distancia mínima legal (por buscar) y lejos | El modelo solo conoce `sa`/`sb`; ¿importa cuánto óxido hay detrás del borde? |
| Orientación | Canal a 0° y a 90°, si la regla lo permite (borde legal por buscar) | Anisotropía del esfuerzo; liga con XC-44 |
| Tipo | nfet, pfet, lvt, hvt | El pfet va en sentido contrario según el modelo; ¿y en silicio? |
| En celda estándar | Anillos de `inv_1` (0,26 µm, **corrida**) frente a una celda de la biblioteca de difusión larga | La versión sin macro: liga con XC-16 |

Primero un canal completo: una pareja ancha, 0,30 frente a 3,0 µm, larga en la fuente, con su lector y su gemelo de referencia.

### 5.3 En silicio

1. **Virgen:** tiempos de descarga de todas las parejas y frecuencias de los anillos, a temperatura ambiente.
2. **Calibrar:** escalón conocido en la puerta, condensador de referencia, corriente de prueba. La pareja LOD no se calibra a sí
   misma: es el objeto medido.
3. **Caracterizar:** diferencia de umbral equivalente por nivel, con su intervalo entre réplicas; curva frente a `sa`.
4. **Barrer:** temperatura (el esfuerzo térmico del óxido cambia con ella) y alimentación (debe cancelarse en el cociente).
5. **Repetir:** otro día y, si hay más de un chip, otro chip: separa lo sistemático del desajuste.
6. **Clasificar** cada barrido: sigue al modelo, residuo reproducible, inconcluso, fallo de lector.

No hay transformación ni estrés. Sirve de comprobación interna del lector de XC-19, no de calibración.

### 5.4 Criterio de muerte (borrador)

- **Positivo (el modelo vale):** la diferencia medida entre niveles coincide con la anotada dentro del intervalo de las réplicas.
  Valida el anotador y el flujo; LOD pasa a ser herramienta de diseño.
- **Positivo (residuo):** diferencia reproducible entre réplicas y distinta de la anotada. Es dato para corregir el modelo.
- **Negativo informativo:** ninguna diferencia entre niveles, con un lector que resolvió el escalón de calibración.
- **Inconcluso:** la dispersión entre réplicas es del tamaño del efecto; o el gradiente no se separó.
- **Fallo instrumental:** el escalón de calibración no se ve.
- **Muere como celda** si el desplazamiento no supera el desajuste con transistores anchos. Como metrología no muere: un cero
  medido también corrige el modelo.

## 6. Documentación para graduarse

- [ ] Prerregistro con predicción numérica y criterio de abandono
- [ ] Generador de layout por script, parametrizado
- [ ] DRC limpio en Magic (reglas completas) y en KLayout (deck completo, comprobaciones de front-end activas)
- [ ] Extracción y LVS dispositivo a dispositivo
- [ ] Netlist anotado con Residual
- [ ] Simulación contra la predicción, con su control
- [ ] Macro: pines en metal, LEF con obstrucciones, alimentación
- [ ] Datos de silicio, crudos y con su control
- [ ] Contrato: modelo, interfaz, límites, variabilidad, retención, modos de fallo, condiciones de formación
- [ ] Referencia convencional, donde ayude a identificar el mecanismo
- [ ] README en inglés

## 7. Compuertas y dependencias

- Necesita macro propio con transistores: depende de resolver cómo recibe alimentación (abierto en XC-19).
- Depende del lector de XC-19; si el lector falla, queda solo la versión de anillos (XC-16).
- Sirve a XC-13 (matriz cruzada), XC-16 (predicción por celda), XC-19 (comprobación interna), XC-46 y XC-47 (mismo barrido de W).
- XC-44 es su control: el esfuerzo del encapsulado se suma al del aislamiento.
- Sin permisos especiales. Un chip basta para el efecto sistemático si hay réplicas dentro; el desajuste entre chips pide más.

## 8. Abierto y fuentes

- Si el silicio sigue al modelo. Es la única pregunta que importa y ninguna corrida la contesta.
- Si las celdas estándar se caracterizaron con estos parámetros.
- Movilidad y umbral por separado: la corriente lineal los mezcla (laboratorio, `macros/grabado_lod/LEEME.md`, sin publicar).
- Cuánto óxido de aislamiento hace falta alrededor para que el esfuerzo sea el del modelo `[?]`.
- Corridas: [`experiments/lod_audit`](../../experiments/lod_audit/README.md),
  [`experiments/stdcell_lod`](../../experiments/stdcell_lod/README.md),
  [`experiments/xc19_weak_inversion`](../../experiments/xc19_weak_inversion/README.md) (N4). Herramienta:
  [`residual`](../../residual/README.md), [`residual/drc_edge`](../../residual/drc_edge/README.md).
  Cifras: [`docs/CLAIMS.md`](../../docs/CLAIMS.md). Prerregistro de la noche: [`../preregistros/`](../preregistros/README.md).
