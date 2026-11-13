# XC-03 · Contacto o vía como sitio

**Fusionada en XC-01 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-03 de [catálogo](../../README.md#catalogue) (Contact or via as the transformation site).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-03 · Contacto o vía como sitio.** Fallo de interfaz → `mcon` único frente a redundantes, cadena de vías → corriente sobre
régimen → resistencia de contacto → interfaz transformable, antifusible de metal → igual que XC-01 → cadena con un solo contacto
débil declarado. **Mantener:** hallazgo propio (con 9 `mcon` el contacto se forma antes que la línea). Lleva auditoría separada de
los contactos que deben sobrevivir.

**Configuraciones añadidas por la búsqueda del 2026-11-12:**

- **XC-02/03:** estado virgen como dato: serpentín de li con cadenas de contactos. En el PDK local: li 12,8 Ω/□, mcon 9,3 Ω,
  contacto a poly 152 Ω, contacto a difusión 185 Ω (típicos, `sky130A.tech`).

## 2. Lectura y piso

El anillo con resistencia en serie de XC-01. «lab» = laboratorio de trabajo, sin publicar.

| Cantidad | Valor | De dónde |
|---|---|---|
| Resistencia virgen | `mcon` 9,3 Ω; contacto a poly 152 Ω; contacto a difusión 185 Ω | `sky130A.tech`, **PDK local**, [pesca](../notas/PESCA_2026-11-12.md) |
| Régimen de corriente | `mcon` 0,36 mA; `via` 0,29 mA; `via2/3` 0,48 mA (LEF, 90 °C) | `EQUIPO.md`, lab |
| El hallazgo | con 9 `mcon` por cabeza y 8 `buf_16`, cada contacto lleva 2 mA (5,7× su régimen): se formaría antes que la línea | `macros/constriccion/LEEME.md`, **corrida** de modelo y cálculo, lab |
| Vía del enrutador en EFLD-00 | hasta 14× su régimen con 4,1 mA | `local_flow/efld_00/LEEME.md`, lab |
| Lector | +1,7 % con 1 kΩ; rango ~1 kΩ a ~300 kΩ | mismo |
| Resistencia de un contacto transformado | `[?]` | — |

Señal/piso: un contacto virgen (9,3 a 185 Ω) está bajo el rango del lector. Se ve el abierto y, si existe, un estado de kΩ. Para
ver el estado virgen hace falta una cadena de N contactos en serie con N × R dentro del rango; N se calcula en el prerregistro. El
contacto a difusión es el que parte más cerca.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Cambió la línea o la cabeza, no el contacto | Un solo contacto débil declarado; todo lo demás redundante y bajo régimen, con auditoría escrita |
| Cambió otro contacto de la cadena | Tomas a ambos lados del contacto débil; cadena gemela con todos redundantes |
| Es calor del tramo vecino | Ficticio: el mismo tramo con contacto doble o cuádruple a igual corriente |
| Envejecieron los drivers | Referencia con drivers apagados |
| La resistencia virgen ya era distinta (un contacto mal abierto de fábrica) | Lectura virgen de la cadena larga: distribución antes de tocar nada |
| El cambio depende del sentido por asimetría del driver | Cabezas y drivers simétricos; sentido como variable |

## 4. Referencia convencional (control científico, no filtro)

La vía redundante, que es la práctica normal y la que el enrutador no ofrece por regla (sky130 en OpenROAD no da vías de varios
cortes por regla no predeterminada; `local_flow/efld_00/LEEME.md`, lab), y el fusible del PDK (misma duda que en XC-01). El PDK no
trae antifusible `[?]`.

Tendría que mostrar: un estado escrito en la huella de un solo contacto, menor que la de un fusible, o una transición a menor
resistencia (antifusible de metal) que el fusible no da. También vale lo contrario: demostrar con datos que la regla de
redundancia basta, y cuánto margen deja.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (lab): la observación (9 `mcon`, 5,7×) y el mapa de vías por red del DEF de EFLD-00 y EFLD-01.
2. Pendiente: no hay celda. Dibujar por script la cadena con un contacto débil y su gemela redundante.
3. Pendiente: bordes legales con [`drc_edge`](../../residual/drc_edge/README.md): tamaño de `mcon`, `licon` y `via`, y los
   recubrimientos mínimos de li1 y met1 alrededor. Hoy: borde legal por buscar.
4. Pendiente: extraer y comprobar que LVS ve cada contacto de la cadena como nodo (tramos con capa de resistencia, obstruidos en
   el LEF: lección de EFLD-01).
5. Pendiente: auditoría de corriente de cada contacto que debe sobrevivir, como cociente contra su régimen.
6. Pendiente: buscar en el PDK la resistencia de `via` y `via2` y sus tolerancias `[?]`.
7. Pendiente: leer una fuente sobre fallo de contactos de tungsteno o de la interfaz con li1 bajo corriente `[?]`; no hay ninguna
   en la pesca.
8. Pendiente: prerregistro con N de la cadena y la predicción de qué contacto falla.

### 5.2 Configuraciones a dibujar

Valores: **propuesta**. Dimensiones de contactos y recubrimientos: borde legal por buscar.

| Barrido | Valores | Pregunta |
|---|---|---|
| Tipo de contacto | `mcon` (li1–met1); `licon` a poly; `licon` a n+ y a p+; `via` (met1–met2); `via2` | ¿Qué interfaz es la más débil a igual corriente por contacto? |
| Redundancia | 1; 2; 4; 9 contactos en el mismo sitio | ¿La corriente se reparte, o falla uno y arrastra al resto? |
| Posición en una cadena de iguales | cadena de N idénticos, tomas cada pocos | ¿Falla el primero, el último o uno al azar? El extremo indica polaridad o amontonamiento de corriente |
| Sentido | electrones hacia arriba frente a hacia abajo | La migración en una interfaz es asimétrica; el calor no |
| Recubrimiento | metal al mínimo alrededor del contacto frente a holgado | ¿El borde del metal participa (amontonamiento, disipación)? |
| Llegada de la corriente | en línea recta frente a codo de 90° sobre el contacto | Amontonamiento de corriente en la esquina |
| Ancho de la capa de llegada | li1 de 0,17 frente a ancha | ¿Se forma el contacto o el li1 junto a él? (frontera con XC-02) |
| Apilado | `mcon` y `via` alineados frente a desplazados | Calor acumulado en la columna |
| Cadena virgen larga | N contactos en serie, sin drivers de formación | Dispersión de fábrica; el estado virgen como dato |

Primero un canal: cadena con un `mcon` débil, gemela redundante y lector.

### 5.3 En silicio

1. **Virgen:** cuentas de la cadena larga y de cada canal; distribución de fábrica.
2. **Calibrar:** resistencias conocidas y abierto deliberado, compartidos con XC-01.
3. **Caracterizar:** cociente frente a temperatura y alimentación sin formar.
4. **Transformar** (con permiso y llave): corriente por el contacto débil en escalones de N; lectura en frío entre pulsos; la
   gemela redundante recibe la misma corriente total.
5. **Observar:** resistencia tras cada pulso; qué toma localiza el cambio.
6. **Retener y repetir:** horas y días; invertir el sentido.
7. **Clasificar:** abierto, estado intermedio, resistencia menor, sin cambio (censurado), fallo en otro sitio (dato para la
   auditoría).

Se barre: corriente, duración, sentido, temperatura de placa.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** el contacto débil declarado cambia antes que cualquier otro, de forma repetida entre réplicas, y el estado se
  retiene.
- **Negativo informativo:** nada cambia a la corriente máxima disponible, con calibración vista: margen real de un contacto sobre
  su régimen, dato útil para toda la plataforma.
- **Inconcluso:** falla otro elemento, o no se puede localizar.
- **Fallo instrumental:** la cadena virgen no entra en el rango del lector.
- **Muere como celda** si solo abre y ocupa más que un fusible; queda como auditoría de la plataforma, que es su otro papel.

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

- Permiso de estrés. Vehículo: digital a 1,8 V.
- Doble papel: celda candidata y auditoría de los contactos que deben sobrevivir en XC-01, XC-02 y XC-51. La auditoría se hace
  aunque la celda no entre.
- Depende de la plataforma de EFLD-01 (un pin y una vía por driver).
- Comparte serpentín y cadenas vírgenes con XC-02.
- Irreversible: réplicas dentro del dado.

## 8. Abierto y fuentes

- Resistencia de un contacto tras la transformación y mecanismo (vaciado del tapón, interfaz, li1 bajo el contacto): `[?]`.
- Un agente dio «mcon 152 Ω, licon 15 Ω» como leído; el PDK local dice 9,3 Ω y 152 Ω para el contacto a poly. Vale el local
  ([pesca](../notas/PESCA_2026-11-12.md), «Errores»).
- La regla de electromigración del PDK (x.4) figura como no comprobada y sin límite numérico (**leído por agente**, pesca).
- Laboratorio, sin publicar: `macros/constriccion/LEEME.md`, `local_flow/efld_00/LEEME.md`, `PROPUESTA_CHIP.md`.
