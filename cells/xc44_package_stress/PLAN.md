# XC-44 · Estrés del encapsulado

**Instrumento o control (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-44 de [catálogo](../../README.md#catalogue) (Package stress).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-44 · Estrés del encapsulado.** La resistencia y la movilidad del silicio cambian con el esfuerzo mecánico → resistores de pozo o
anillos a 0° y 90°, en el centro y en la esquina del dado → el encapsulado y la soldadura → cociente de anillos → sensor de esfuerzo,
de flexión → dos anillos y contador → flexionar la placa como control externo. Señal: 1–5 % en anillos por 100 MPa `[?]` (**sin
leer**). Aburrida: anisotropía de litografía y desajuste. Sirve además de control de XC-12.

**Corrección del 2026-11-12 (revisión de los planes, verificada en el PDK local donde se cita):** "Centro y esquina del dado" no es posible: una tesela no abarca las dos posiciones. Quedan la comparación entre orientaciones y el control de flexión externa.

## 2. Lectura y piso

Cociente de dos anillos iguales salvo en la orientación del camino de corriente, y cociente de anillos con un resistor de pozo
en serie a 0° y a 90°.

| Cantidad | Valor | De dónde |
|---|---|---|
| Señal en anillos | 1–5 % por 100 MPa `[?]` | ficha, **sin leer** |
| Esfuerzo real en este encapsulado y su variación con la flexión de la placa | `[?]` | — |
| Coeficientes piezorresistivos del pozo n y de los canales de este proceso | `[?]` | — |
| Lector de resistencia en serie | +1,7 % con 1 kΩ, +32 % con 10 kΩ, ×2,2 con 100 kΩ | laboratorio, `local_flow/efld_00`, **corrida** sobre esquemático, sin publicar |
| Resistor de pozo | 950 Ω/□ (550–1350) | **PDK local** |
| Piso del cociente de dos anillos | `[?]` sin caracterizar | [`../PLANTILLA.md`](../PLANTILLA.md) |
| Absolutos en silicio | 25–40 % más lentos que en simulación en chips ajenos | [pesca](../notas/PESCA_2026-11-12.md), **leído por agente** |

Señal/piso: desconocida por los dos lados. El esfuerzo estático del encapsulado no se puede separar de la anisotropía de dibujo
con un solo chip; lo que sí se puede medir es el cambio del cociente 0°/90° al flexionar la placa, porque la litografía no
cambia al flexionar. Esa modulación es la señal de la familia.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Anisotropía de litografía y grabado: un transistor a 90° no sale igual que a 0° | Es estática: no cambia al flexionar. Solo cuenta la parte del cociente que sigue a la flexión y vuelve al soltar |
| Desajuste entre los dos anillos | Lo mismo: es un desplazamiento fijo. Réplicas para el valor estático |
| Temperatura: la mano o la herramienta calientan el chip al flexionar | Canal de temperatura de XC-31; los dos anillos tienen el mismo coeficiente y el cociente lo cancela en primer orden |
| La flexión mueve contactos, zócalo o alimentación | Canal de alimentación de XC-32; cociente de dos anillos de la misma orientación, que no debe moverse |
| Esfuerzo del aislamiento (XC-12), que también es anisótropo | Misma difusión en los dos; anotar con Residual. Sirve de control en los dos sentidos |
| Gradiente térmico propio del chip | Anillos adyacentes y entrelazados; medir con el resto del chip parado |

Gemelo: pareja de anillos de la misma orientación (0°/0°), a la misma distancia. Ficticio: resistor de poly a 0° y 90°, con
otra sensibilidad al esfuerzo `[?]`, en el mismo lector.

## 4. Referencia convencional (control científico, no filtro)

Una galga extensométrica pegada a la placa, que cuesta poco y está calibrada. Y, dentro del chip, la referencia que no depende
del esfuerzo: un cociente de anillos de igual orientación. No hay componente de biblioteca que mida esfuerzo. La familia gana
como sensor si la modulación por flexión supera con claridad el piso y es repetible; gana como control aunque no sea sensor,
porque le pone número a cuánto mueve el encapsulado a XC-12, XC-13 y XC-16. Pierde frente a la galga en todo lo demás.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Pendiente: leer una fuente con coeficientes piezorresistivos de silicio n y p y de canales MOS por orientación, y otra con
   esfuerzos medidos en un encapsulado como el de Tiny Tapeout. La cifra de la ficha está sin leer.
2. Pendiente: averiguar el tipo de encapsulado, la orientación cristalina de la oblea respecto al dado y la posición de la tesela
   en el dado `[?]`. Sin la orientación no se sabe qué eje es cuál.
3. Pendiente: comprobar si la regla permite puertas a 90° en `nfet_01v8` (borde legal por buscar) y qué extrae Magic.
4. Pendiente: bordes legales del resistor de pozo con `residual/drc_edge` (ancho mínimo de pozo 0,840 µm, laboratorio, **leído**).
5. Pendiente: simular la pendiente del lector alrededor del valor de resistor elegido, para convertir cuentas en ΔR/R.
   Predicción escrita antes; los tres puntos de la tabla no dan la pendiente local.
6. Pendiente: diseñar el útil de flexión: tres o cuatro puntos de apoyo, flecha medida, sin tocar el chip. Es parte del experimento.
7. Pendiente: dibujar los anillos a 0° y 90° como macro (las filas estándar no admiten rotación) con hilos idénticos.

### 5.2 Configuraciones a dibujar

Valores propuestos. Una tesela no ocupa "centro y esquina del dado": se usan las esquinas y el centro de la tesela y se averigua
dónde cae la tesela.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Orientación del canal | 0°; 90°; 45° si la regla lo permite (borde legal por buscar) | La piezorresistencia cambia de signo y tamaño con el ángulo respecto al cristal |
| Tipo de portador | Anillo limitado por nfet; anillo limitado por pfet (etapas descompensadas a propósito) | Electrones y huecos responden distinto; dos cocientes dan dos componentes del esfuerzo |
| Resistor de pozo n | Tiras de 10 y 100 cuadros a 0° y 90°, ancho 2 µm | Piezorresistencia de volumen, sin transistor: el observable más limpio |
| Relación de aspecto del resistor | Mismo número de cuadros, ancho 0,84 (mínimo) frente a 4 µm | Separa esfuerzo del silicio de efectos de borde del pozo (liga con XC-48) |
| Material | Pozo n; poly; difusión n+; difusión p+ | Cada uno con su coeficiente: un patrón de signos identifica esfuerzo frente a temperatura |
| Posición en la tesela | Cuatro esquinas y centro | Gradiente de esfuerzo; el encapsulado aprieta más en esquinas del dado |
| Roseta | Cuatro resistores a 0°, 45°, 90°, 135° en el mismo punto | Tensor en el plano: dirección principal del esfuerzo |
| Bajo metal | Anillo bajo placa ancha de met4 frente a sin metal encima | Esfuerzo del propio apilado, que no cambia al flexionar |

Primero un canal completo: una pareja de anillos 0°/90° con su gemelo 0°/0° y el contador.

### 5.3 En silicio

1. **Virgen:** cocientes de todas las parejas con la placa sin carga mecánica, varias veces y en días distintos: fija el piso.
2. **Calibrar:** el lector con una resistencia conocida conmutada; la galga externa o la flecha medida como patrón de esfuerzo.
3. **Caracterizar:** flexión en pasos, ida y vuelta, en dos ejes de la placa. Cociente frente a flecha.
4. **Barrer:** temperatura con la placa libre (separa el coeficiente térmico) y alimentación.
5. **Retener y repetir:** al soltar debe volver al valor inicial; si no, hay fluencia del encapsulado o daño en la soldadura.
6. **Clasificar:** modulación lineal y reversible, sin modulación sobre el piso, histéresis, fallo de lector.

La flexión es una acción de mesa: límite de flecha fijado en el útil, no a mano. No hay transformación eléctrica.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** el cociente 0°/90° sigue a la flexión de forma lineal y reversible, cambia de signo al cambiar el eje de flexión,
  y el gemelo 0°/0° no se mueve.
- **Negativo informativo:** ningún cociente se mueve sobre el piso medido con una flecha conocida. Da una cota: el encapsulado no
  perturba a las demás familias más que ese piso.
- **Inconcluso:** el gemelo se mueve tanto como la pareja (temperatura o alimentación), o hay histéresis.
- **Fallo instrumental:** la resistencia conmutada de calibración no se ve.
- **Muere como sensor** si la modulación no supera el piso a la flecha máxima segura. Como control no muere.

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

- Permiso propio: flexionar la placa de demostración puede romper soldaduras; se hace al final y con límite mecánico.
- Los anillos a 90° piden macro con transistores (alimentación del macro, abierta en XC-19). Los resistores, macro pasivo como
  EFLD-00.
- Sirve de control a XC-12, XC-13, XC-16 y XC-48; necesita XC-31 y XC-32 como canales.
- Un chip basta: el control es la modulación externa, no la estadística.

## 8. Abierto y fuentes

- Coeficientes, orientación del cristal, tipo de encapsulado y posición de la tesela: todos `[?]`.
- Pendiente local del lector de resistencia.
- La [pesca](../notas/PESCA_2026-11-12.md) la sitúa en la mitad alta del orden de probabilidad a 1,8 V (juicio de un agente).
- Origen: alta del 2026-11-12 en `docs/CARTERA.md` del laboratorio ("exige control de flexión externa"), sin publicar.
- Lector: `local_flow/efld_00/LEEME.md`. Planes ligados: [XC-12](../xc12_lod_stress/PLAN.md), [XC-48](../xc48_pinched_well/PLAN.md).
