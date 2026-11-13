# XC-02 · Constricción de li1

**Fusionada en XC-01 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-02 de [catálogo](../../README.md#catalogue) (Local-interconnect constriction).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-02 · Constricción de li1.** Calentamiento Joule en TiN `[?]` → línea de li1 de 0,29 o 0,17 µm → fusión o cambio de fase local →
igual que XC-01 → igual, a menor corriente → igual → integrar `efld01c_L1` en el camino de formación de EFLD-01. **Mantener:** a
igual corriente disipa ~100× más que una vía (argumento térmico del sprint), así que la línea falla antes que la infraestructura.

**Configuraciones añadidas por la búsqueda del 2026-11-12:**

- **XC-01/02:** barrer el largo del cuello. Producto de Blech 1260 A/cm en Al puro a 350 °C, rango 900–9000 según estructura
  (**leído por agente**, arXiv 1908.01170); sin valor para la aleación de SKY130 `[?]`. El PDK trae una regla de fusible metálico
  (0,8 × 7,2 µm, **leído por agente**): es el componente convencional contra el que comparar.
- **XC-02/03:** estado virgen como dato: serpentín de li con cadenas de contactos. En el PDK local: li 12,8 Ω/□, mcon 9,3 Ω,
  contacto a poly 152 Ω, contacto a difusión 185 Ω (típicos, `sky130A.tech`).

## 2. Lectura y piso

El mismo anillo con resistencia en serie de XC-01, contra un gemelo virgen. «lab» = laboratorio de trabajo, sin publicar.

| Cantidad | Valor | De dónde |
|---|---|---|
| Estado virgen, 0,17 × 10 µm | 59 □ → 1.000 Ω (**cálculo** con 17 Ω/□ del LEF) | `macros/constriccion/LEEME.md`, lab |
| Estado virgen, 0,29 × 10 µm | ≈ 590 Ω | mismo |
| Línea de 0,50 con cuello de 0,17 × 1 µm | 410 Ω | mismo |
| Resistencia de hoja | 12,8 Ω/□ | `sky130A.tech`, **PDK local**, [pesca](../notas/PESCA_2026-11-12.md) |
| Respuesta del anillo | +1,7 % con 1 kΩ; +32 % con 10 kΩ; rango ~1 kΩ a ~300 kΩ | `local_flow/efld_00/LEEME.md`, **corrida** de modelo, lab |
| Corriente con `buf_16` | 1,38 a 1,75 mA en 1.000 Ω; 2,5 a 3 mW en ~1,7 µm² | `macros/constriccion/LEEME.md`, **corrida** de modelo; que funda es estimación |
| Corriente con los `ebufn_4` de EFLD-01 sobre li1 | `[?]`, sin simular | — |

Señal/piso: es la única constricción cuyo estado virgen ya roza el rango del lector. Un cambio de 1 a 10 kΩ sería +32 % del
período; un cambio del 10 % de 1 kΩ queda bajo el 1 % `[?]` (no hay punto simulado entre 10 Ω y 1 kΩ, ni la pendiente local). El
LEF y el PDK local no dan la misma resistencia de hoja (17 frente a 12,8 Ω/□): el serpentín virgen la mide.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Falló el contacto `mcon` de la cabeza, no la línea | La línea disipa ~100× más que una vía a igual corriente (argumento del laboratorio, sin medir); cabezas en cadena; XC-03 aparte |
| Se lee caliente: coeficiente térmico de li1 `[?]` | Lectura en frío; gemelo; curva de enfriamiento registrada |
| Dispersión de ancho de fabricación a 0,17 µm | Cada canal contra sí mismo antes y después; serpentín virgen para la dispersión |
| Envejecieron los drivers | Referencia con drivers apagados; lectura por pines propios |
| El calor de la línea cambió al vecino | Fantasma contiguo; canal XC-31 |
| No es la línea sino la interfaz li1/contacto | Variantes con distinto número de `mcon` por cabeza a igual línea |

## 4. Referencia convencional (control científico, no filtro)

El mismo fusible del PDK que en XC-01, con la misma duda sobre cuál existe en la instalación. Como resistencia fija:
`res_generic_l1` (la línea misma, dibujada con `rli`) y el poly resistivo (`res_high_po` 300 Ω/□, `res_xhigh_po` 2000 Ω/□, **leído
por agente**). Como fusible programado por calor, el precedente es el de poly silicidado: 10 mA, 3,3 V, 200 µs, de 120 Ω a más de
7 MΩ en 0,12 µm (**leído por agente**, pesca); eso es XC-51.

Tendría que mostrar: formación a 1,8 V con la corriente de celdas estándar, sin que falle antes la infraestructura, y un estado
final distinto de abierto.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (lab): L1 y L2 (0,17 µm) dibujadas; `efld01c_L1` (0,29 µm, capa `rli`) dibujada, 0 violaciones, sin integrar.
2. Hecho (lab), y es una corrección: con `drc(full)`, `efld_consR_L1` y `efld_consR_L2` violan li.7 (resistencia de li1 bajo 0,29
   µm). El li1 normal es legal desde 0,170 ([`drc_edge`](../../residual/drc_edge/README.md)); con capa de resistencia, desde 0,29.
3. Pendiente, decide Juan: 0,29 µm con `rli` (LVS directo) o 0,17 µm sin capa de resistencia (LVS por otra vía).
4. Pendiente: integrar `efld01c_L1` en el camino de formación de EFLD-01 y repetir DRC, antena y LVS.
5. Pendiente: simular la corriente de los `ebufn_4` sobre 590 y 1.000 Ω; la formación está limitada por tensión, no por corriente.
6. Pendiente: buscar en el PDK el coeficiente térmico de li1 y confirmar que es TiN (hoy `[?]`; ρ = 128 µΩ·cm es **cálculo**, lab).
7. Pendiente: modelo térmico de primer orden de la línea (potencia, resistencia térmica al sustrato a través de 0,5 µm de óxido)
   con la predicción escrita antes. Ningún número hasta entonces.
8. Pendiente: simular el lector entre 300 Ω y 3 kΩ para tener la pendiente local.

### 5.2 Configuraciones a dibujar

Valores nuevos: **propuesta**. Bordes: 0,170 µm sin capa de resistencia, 0,29 µm con ella.

| Barrido | Valores | Pregunta |
|---|---|---|
| Ancho | 0,17; 0,29; 0,50 µm, uniforme | Potencia por unidad de largo a igual tensión: ¿hay un ancho bajo el cual se forma a 1,8 V? |
| Largo | 2; 5; 10; 20; 50 µm | A tensión fija, el largo fija corriente y potencia; el centro de una línea larga está más aislado de las cabezas |
| Cuello | 0,17 × 0,5; × 1 (dibujado); × 2 µm en línea de 0,50 | ¿El punto caliente queda en el cuello, o las cabezas lo enfrían si es corto? |
| Perímetro frente a área | una línea de 0,34 frente a dos de 0,17 en paralelo | Misma sección, doble perímetro: ¿el cambio es de volumen o de superficie e interfaz? |
| Sumidero térmico | sobre óxido de campo; sobre difusión; sobre poly; con met1 flotante encima | Cambia la temperatura sin cambiar la corriente: prueba de que el mecanismo es térmico |
| Contactos por cabeza | 1; 3; 9 `mcon` | ¿Se forma la línea o la interfaz? (frontera con XC-03) |
| Orientación | horizontal y vertical | Anisotropía de fabricación |
| Serpentín virgen | largo, de ancho mínimo, con y sin cadenas de contactos intercaladas | Resistencia de hoja real y su dispersión; el estado virgen como dato |
| Capa de comparación | misma forma en met1 | A igual geometría, ¿li1 se forma y met1 no? |

Primero un canal: `efld01c_L1` con gemelo y lector.

### 5.3 En silicio

1. **Virgen:** cuentas de todos los canales y del serpentín; resistencia de hoja real por cociente con los canales de calibración.
2. **Calibrar:** resistencias conocidas en serie alrededor de 1 kΩ; abierto deliberado.
3. **Caracterizar:** cociente frente a temperatura de placa: da el coeficiente térmico de li1, que no tenemos.
4. **Transformar** (con permiso y llave): N = 1 primero; pulsos de duración creciente desde el más corto que permita el reloj,
   porque un mecanismo térmico puede ser rápido `[?]`; lectura en frío entre pulsos.
5. **Observar:** R tras cada pulso; registrar si el cambio es gradual o de un salto.
6. **Retener y repetir:** horas, días, ciclo térmico; segundo pulso sobre un estado intermedio.
7. **Clasificar:** abierto, estado estable, sin cambio (censurado), fallo de contacto (lo dice la variante de contactos).

Se barre: número de drivers, duración del pulso, temperatura de placa, alimentación dentro de lo permitido.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** cambio de resistencia retenido y dependiente del sumidero térmico y del ancho, con gemelo y fantasma quietos.
- **Negativo informativo:** nada cambia con la potencia máxima disponible a 1,8 V y la calibración vista: límite de potencia del
  vehículo digital, con su número.
- **Inconcluso:** cambia igual con uno y con nueve contactos sin poder localizarlo, o desaparece al enfriar.
- **Fallo instrumental:** el canal de calibración no se distingue; el virgen queda fuera del rango del lector.
- **Muere como celda** si solo abre: es un fusible térmico, y se compara con el del PDK y con XC-51.

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

- Permiso de estrés, igual que XC-01. Decisión pendiente de Juan sobre el ancho (sección 5.1, paso 3).
- Vehículo: digital a 1,8 V. Depende de la plataforma de XC-01 (EFLD-01).
- Comparte serpentín y cadenas con XC-03; es el control de material de XC-05; su estado abierto alimenta XC-04.
- Necesita XC-31 (la formación calienta) y fantasma.
- Irreversible: réplicas dentro del dado.

## 8. Abierto y fuentes

- ¿li1 es TiN? Coeficiente térmico, temperatura de transformación y qué transformación (fusión, oxidación, cambio de fase): todo
  `[?]`.
- Por qué el LEF da 17 Ω/□ y el tech 12,8.
- Corriente real de los drivers triestado sobre una carga de kΩ.
- Fuentes: [pesca](../notas/PESCA_2026-11-12.md). Laboratorio, sin publicar: `macros/constriccion/LEEME.md`,
  `local_flow/efld_01/LEEME.md`, `NIGHT_SPRINT_2026-11-05.md`, `DECISIONES.md` (entrada del 11-nov sobre li.7).
