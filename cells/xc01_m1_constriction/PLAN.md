# XC-01 · Constricción de met1

**Instrumento o control (2026-11-12, rol).** Ver su fila en el catálogo. La carpeta se conserva.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-01 de [catálogo](../../README.md#catalogue) (Metal-1 constriction).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-01 · Constricción de met1.** Electromigración → línea de met1 con cuello (familia A/B/C/D) → corriente DC sobre régimen durante
horas → resistencia antes y después, retención, dispersión → resistencia programable, estado en la región kΩ → celda de memoria de
una escritura o peso fijo, leída por retardo → EFLD-01: formar una, leer contra gemela virgen. **Mantener:** es lo único con
infraestructura verificada (DRC 0, LVS 17/17, cada vía bajo régimen: `NIGHT_SPRINT_2026-11-05.md`). Abierto: el tiempo de formación
no tiene modelo, y hace falta permiso de estrés.

**Configuraciones añadidas por la búsqueda del 2026-11-12:**

- **XC-01/02:** barrer el largo del cuello. Producto de Blech 1260 A/cm en Al puro a 350 °C, rango 900–9000 según estructura
  (**leído por agente**, arXiv 1908.01170); sin valor para la aleación de SKY130 `[?]`. El PDK trae una regla de fusible metálico
  (0,8 × 7,2 µm, **leído por agente**): es el componente convencional contra el que comparar.

## 2. Lectura y piso

Anillo con la línea en serie (EFLD-00/01), leído como cociente contra el gemelo virgen. Todo es modelo (ngspice de esquemático) o
flujo físico; nada es silicio. «lab» = laboratorio de trabajo, sin publicar.

| Cantidad | Valor | De dónde |
|---|---|---|
| Estado virgen, línea de 0,14 × 10 µm | 71 □ → 10,4 Ω (**cálculo** con 0,145 Ω/□ del LEF; el PDK local da 0,125 Ω/□) | `macros/constriccion/LEEME.md`, lab |
| Respuesta del anillo | período 2,99 ns con 10 Ω; +1,7 % con 1 kΩ; +32 % con 10 kΩ; ×2,2 con 100 kΩ; satura hacia 1 MΩ (×3,1); muere abierto | `local_flow/efld_00/LEEME.md`, **corrida** de modelo, lab |
| Rango útil | ~1 kΩ a ~300 kΩ; 83 ps/kΩ en torno a 12,9 kΩ | `NIGHT_SPRINT_2026-11-05.md`, lab |
| Cambios pequeños | 10 % de 89 Ω con 200 fF son 1,8 ps: ciego | `macros/constriccion/LEEME.md`, **cálculo**, lab |
| Señal esperada si el liner conduce | 0,18 a 0,9 kΩ por hueco de 1 µm (liner de 50 a 10 nm; espesor real `[?]`) | `FRONTERAS_FISICAS_1105.md` ficha 1, **cálculo** sobre hipótesis, lab |
| Carga de los drivers de formación | añaden 26 % al período; parásitos nB 22 fF frente a rB 8 fF | `NIGHT_SPRINT_2026-11-05.md`, modelo y SPEF, lab |
| Contador | ventana de 2¹⁶ o 2²⁰ ciclos; ~10⁻⁵ con 2²⁰ a 10 MHz | `efld_00/LEEME.md`, `EFLG00_TRAMPA.md`, lab |

Señal/piso: el estado virgen y cualquier cambio de pocos ohmios quedan bajo el piso. El estado de liner previsto cae en el borde
inferior del rango: a 1 kΩ supera el 1 % por poco, y por debajo de 1 kΩ no hay número `[?]`. El abierto se ve, pero es un fusible.
Falta un segundo régimen de lectura para 0,1 a 1 kΩ (resistencia a tiempo con carga grande): sin diseñar. Piso en silicio `[?]`.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Se formó un contacto o una vía, no la línea | Camino de EFLD-01: cada vía a 0,71× y 0,89× de su régimen, la línea a 5,3× (lab). Variantes con toma intermedia. XC-03 como sitio declarado aparte |
| Envejecieron los drivers (pesan 26 % del período) | Referencia con los mismos drivers siempre apagados (EFLD-01b, pendiente); lectura por los pines A8/B8, sin corriente de formación |
| Calor residual de la formación | Leer tras enfriar y repetir; fantasma vecino sin dispositivo; canal de temperatura (XC-31) |
| Gradiente del dado y asimetría de parásitos | Gemelo virgen contiguo; se compara cada canal consigo mismo antes y después, no en absoluto |
| Fusión por calor, no electromigración | Ficticio: línea ancha sin cuello con la misma corriente. La electromigración depende del sentido y del largo (Blech); la fusión no |
| Caída de alimentación durante el estrés | Canal de alimentación (XC-32); vigilante que corta el pulso |
| El cambio es del anillo, no de la línea | Canales de calibración con resistencia conocida en el mismo tipo de anillo |

## 4. Referencia convencional (control científico, no filtro)

El fusible del PDK. La ficha cita una regla de fusible metálico de 0,8 × 7,2 µm (**leído por agente**); en la instalación del
laboratorio solo aparece `sky130_fd_pr__fuse_m4` en el tech de Magic, sin regla ni celda de met1 (`macros/constriccion/LEEME.md`,
lab). Queda por resolver cuál de los dos es la referencia `[?]`. Para el estado kΩ, la referencia es una resistencia de poly
(`res_high_po`, 300 Ω/□, **leído por agente**) elegida por máscara.

La constricción gana solo si da lo que esos no: un estado intermedio estable y elegible después de fabricar (resultado B del
laboratorio), o vuelta atrás al invertir la corriente (D). Si solo abre, es un fusible y gana el del PDK.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (lab): M1, M2 y la familia A/B/C/D dibujadas por script, 0 violaciones en Magic y en el deck de fabricación de KLayout,
   extraídas como `res_generic_m1`.
2. Hecho (lab): revisión del 11-nov con `drc(full)` y con el deck completo de KLayout con FEOL encendido; las celdas de met1
   siguen limpias (`DECISIONES.md`).
3. Hecho (lab): EFLD-00 y EFLD-01 pasan el flujo (DRC 0, antena 0, LVS 17/17, cocotb 2/2) y el lector está simulado.
4. Pendiente: traer el generador y las corridas a este repositorio; hoy ningún número de esta familia es público.
5. Pendiente: leer nosotros arXiv 1908.01170 y buscar el producto de Blech de la pila real de met1 (composición y liner `[?]`).
6. Pendiente: buscar la regla de fusible en el PDK local y resolver la discrepancia de la sección 4.
7. Pendiente: simulación a nivel de compuertas con SDF, parásitos del macro, referencia con drivers apagados.
8. Pendiente: lector de segundo régimen para 0,1 a 1 kΩ, con predicción escrita antes.
9. Pendiente: vigilante con dominio propio; hoy comparte reloj y alimentación.
10. Pendiente: prerregistro del algoritmo de formación (escalones, lectura entre escalones, parada a resistencia objetivo).
11. Pendiente: precheck de Tiny Tapeout con `MACROS`, `MAGIC_EXT_USE_GDS` y `ERROR_ON_SYNTH_CHECKS: false`.

### 5.2 Configuraciones a dibujar

Valores nuevos: **propuesta**. El mínimo legal de met1 es 0,140 µm ([`drc_edge`](../../residual/drc_edge/README.md)).

| Barrido | Valores | Pregunta |
|---|---|---|
| Familia A/B/C/D (dibujada, lab) | uniforme 0,14; un cuello; dos iguales; dos de 0,14 y 0,17 | ¿El cuello concentra la formación? ¿Entre dos iguales elige al azar? ¿Un 20 % fija la preferencia? |
| Largo del cuello | 0,5; 1; 2; 5; 10; 20 µm a 0,14 de ancho | Blech: si existe un largo bajo el cual no se forma, es electromigración y no fusión. Umbral en SKY130 `[?]` |
| Ancho del cuello | 0,14; 0,17; 0,21; 0,28 µm | A igual corriente cambia la densidad: ¿cómo escala el tiempo de formación? |
| Relación línea:cuello | línea de 0,28; 0,50 (dibujada, 3,6:1); 1,0 µm | ¿Nuclea en la transición (divergencia de flujo) o en el centro del cuello (temperatura)? |
| Forma de la transición | escalón recto frente a trapecio (borde legal por buscar) | Concentración de corriente en la esquina frente a gradiente suave |
| Orientación | horizontal y vertical | Anisotropía de litografía; separa geometría de gradiente del dado |
| Capa | met1, met2, met3 (anchos mínimos de met2 y met3: borde legal por buscar) | Espesor, liner y distancia al sustrato distintos: ¿el estado kΩ es del liner? |
| Sumidero térmico | sobre óxido de campo; sobre placa de poly o difusión; con placa de met2 encima | Cambia la temperatura sin cambiar la densidad de corriente: separa lo térmico de lo migratorio |
| Toma intermedia | con y sin toma en C y D | Localiza qué cuello cambió; la toma altera el reparto de corriente y eso se mide |
| Reserva de metal en la cabeza | cabeza al ras del cuello frente a cabeza con metal sobrante | ¿El metal sobrante alimenta el hueco y retrasa la formación? |
| Pines por cabeza | 8 (dibujado, lab); 16 | Más corriente sin que ninguna vía supere su régimen |

Primero un canal completo: B con su gemelo, sus drivers y el lector. La matriz después.

### 5.3 En silicio

1. **Virgen:** cuentas de dispositivo y gemelo en todos los canales; cociente frente a alimentación y temperatura ambiente.
2. **Calibrar:** canales con resistencia conocida en serie y un abierto deliberado; fijan sensibilidad y piso en silicio.
3. **Caracterizar:** estabilidad del cociente durante horas sin formar. Es el piso contra el que se juzga todo cambio.
4. **Transformar** (con permiso y llave): primero N = 1, que deja la línea a 0,66× de su régimen y no debe cambiar nada (control
   de procedimiento). Luego N = 2, 4, 8 (2,06 mA, 5,3×). Pulsos de duración creciente en escala logarítmica, lectura en frío entre
   pulsos, parada al alcanzar una resistencia objetivo.
5. **Observar:** trayectoria R(t) por canal: ¿meseta en kΩ o salto directo a abierto?
6. **Retener y repetir:** el mismo canal a horas y días, y tras un ciclo térmico; invertir el sentido como variable (resultado D).
7. **Clasificar:** abierto (A), estado estable (B), mesetas (C, solo candidata), reversible (D), no transformado (dato censurado,
   con su corriente y su tiempo).

Se barre en la mesa: número de drivers, duración, sentido, temperatura de la placa. El tiempo de formación a temperatura ambiente
no tiene modelo `[?]`: es la primera pregunta, no una predicción.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** estado estable dentro del rango del lector, repetido en réplicas (cuántas `[?]`), retenido horas, con gemelo y
  fantasma sin cambio y con dependencia de la geometría.
- **Negativo informativo:** ninguna línea cambia tras un tiempo fijado antes `[?]` a 5,3× de régimen, con la calibración vista. O
  todas saltan a abierto sin meseta: el liner no da estado útil, y entonces sube XC-04.
- **Inconcluso:** el cambio aparece también en la referencia con drivers, o desaparece al enfriar, o solo en un canal.
- **Fallo instrumental:** el canal de calibración de 1 kΩ no se distingue del virgen, o el anillo virgen no oscila.
- **Muere como celda** (queda como fusible comparado) si en todas las geometrías solo abre y no mejora al fusible del PDK.

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

- Permiso de Tiny Tapeout para estrés intencional, y aceptación de la configuración del flujo (sección 5.1, paso 11). Sin permiso,
  la familia se envía virgen y solo da los pasos 1 a 3 de la mesa.
- Vehículo: digital a 1,8 V. La identificación del mecanismo (I–V, temperatura fina, microscopía) espera al híbrido o al dado.
- Su plataforma (llave, drivers por pin, gemelo, lector) sirve a XC-02, XC-03, XC-04, XC-05 y XC-51.
- Necesita XC-31 y XC-32 como canales de control, y un fantasma por zona de formación.
- La formación es irreversible: cada línea es una muestra. Con un solo chip, las réplicas van dentro del dado.
- 2,06 mA por canal en formación: declarar la caída en la alimentación común.

## 8. Abierto y fuentes

- Tiempo de formación a 4,2·10⁶ A/cm² y temperatura ambiente `[?]`. Composición de met1 y espesor del liner `[?]`.
- Qué fusible trae de verdad el PDK (sección 4).
- Cómo leer entre 0,1 y 1 kΩ.
- Fuentes: producto de Blech y fusible en la [pesca](../notas/PESCA_2026-11-12.md). Laboratorio, sin publicar:
  `macros/constriccion/LEEME.md`, `local_flow/efld_00/LEEME.md`, `local_flow/efld_01/LEEME.md`, `NIGHT_SPRINT_2026-11-05.md`,
  `FRONTERAS_FISICAS_1105.md`, `DECISIONES.md`.
