# XC-39 · Resistor de poly electrotérmico

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-39 de [catálogo](../../README.md#catalogue) (Electrothermal polysilicon resistor).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-39 · Resistor de poly electrotérmico.** El poly de alta resistencia baja su resistencia al calentarse (tc1 = −4,3·10⁻⁴ /K en la
tarjeta del modelo, **fuente leída por agente**) → resistor mínimo en serie en un anillo, gemelo solo MOS → se calienta con su propia
corriente → cociente de anillos antes, durante y después de un pulso → termómetro, memoria térmica de ms, quizá oscilador → anillo +
contador → resistor ficticio que disipa igual lejos del anillo. Aburrida: constante RC térmica sin realimentación. La oscilación
pediría cientos de K (**juicio**); la deriva sí es legible. Nota: ngspice puede ignorar el coeficiente (issue 169 del PDK,
**leído por agente**), así que simulación y silicio divergirán: también es dato para XC-47.

**Corrección del 2026-11-12 (revisión de los planes, verificada en el PDK local donde se cita):** El coeficiente −4,3·10⁻⁴ /K de la ficha es el de las cabezas del resistor. En el PDK local el cuerpo de `res_xhigh_po` tiene tc1 = −1,47·10⁻³ /K (`sky130_fd_pr__res_xhigh_po.model.spice`, línea 65); el cuerpo de `res_high_po` usa un parámetro aparte (`tc1rpolybody`). La familia se plantea con el poly de muy alta resistencia.

## 2. Lectura y piso

Anillo con resistencia en serie (EFLD-00/01), leído como cociente contra un anillo gemelo solo MOS. Todo es modelo; nada en silicio.

| Cantidad | Valor | De dónde |
|---|---|---|
| Sensibilidad del anillo a la resistencia en serie | +1,7 % con 1 kΩ, +32 % con 10 kΩ, ×2,2 con 100 kΩ (esquemático, tt, 27 °C) | `local_flow/efld_00/LEEME.md`, **corrida**, laboratorio, sin publicar |
| Resolución del contador | ~10⁻⁵ con ventana de 2²⁰ a 10 MHz; la deriva térmica de un anillo es órdenes de magnitud mayor | `EFLG00_TRAMPA.md`, laboratorio, sin publicar |
| `res_xhigh_po`, cuerpo | tc1 = −1,47·10⁻³ /K, tc2 = 2,7·10⁻⁶; cabezas tc1 = −4,3·10⁻⁴ | **PDK local**, `libs.ref/sky130_fd_pr/spice/sky130_fd_pr__res_xhigh_po.model.spice` |
| `res_high_po`, cuerpo | tc1 = **+**0,514·10⁻³ /K (`tc1rpolybody`); solo las cabezas llevan −4,3·10⁻⁴; tnom 30 °C | **PDK local**, `…__res_high_po.model.spice` y `libs.tech/ngspice/sky130_fd_pr__model__r+c.model.spice` |
| Poly común (`res_generic_po`) | tc1 = +8,916·10⁻⁴ /K (`tc1rsgpu`) | **PDK local**, mismo `r+c.model.spice` |
| Resistencia de hoja | `xhrpoly` 319,8 Ω/□; `uhrpoly` 2000 Ω/□; poly 48,2 Ω/□ | **PDK local**, `libs.tech/magic/sky130A.tech`, líneas 5104–5138 |
| Corriente máxima del resistor | 500 µA/µm (**leído por agente**) → 175 µA en el ancho de 0,35 µm (**cálculo**) | [pesca](../notas/PESCA_2026-11-12.md) |
| Calentamiento ΔT por mW | `[?]`: el PDK no trae resistencia térmica | — |

Señal = tc1 · ΔT · (sensibilidad del anillo a R). Con ΔT `[?]`, la razón señal/piso es `[?]`. El piso no lo pone el contador sino la
deriva térmica del propio anillo MOS: solo cuenta lo que queda en el cociente contra el gemelo. Según el modelo local, el coeficiente
negativo grande es el del cuerpo de `res_xhigh_po`; el de −4,3·10⁻⁴ de la ficha corresponde a las cabezas (ver sección 8).

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Constante RC térmica sin realimentación: el resistor se calienta y se enfría, nada más | Es el resultado por defecto; lo exótico exigiría histéresis u oscilación. Forma del transitorio frente a potencia |
| Se calientan los inversores del anillo, no el resistor | Gemelo solo MOS a la misma distancia del calefactor; resistor ficticio que disipa igual lejos del anillo |
| Coeficiente de tensión del resistor (el modelo de `res_xhigh_po` lo incluye; `res_high_po` no lineal 30 %, **leído por agente**) | Es instantáneo; lo térmico tarda. Mirar el cociente después del pulso, con la tensión ya retirada |
| Caída de alimentación durante el pulso (XC-32) | Fantasma: anillo vecino sin resistor; canal de alimentación |
| Deriva de los drivers que calientan | La ruta de calentamiento no es la de lectura; el anillo se lee con los drivers en alta impedancia |
| Cualquier deriva común de signo fijo | **Control de signo:** misma geometría en poly común (tc1 positivo) y en `res_xhigh_po` (tc1 negativo): el cociente debe invertirse |

## 4. Referencia convencional (control científico, no filtro)

Como termómetro: un anillo de celdas estándar (su frecuencia ya deriva con la temperatura) y el PNP vertical del PDK (β ≈ 14,3,
**leído por agente**), que es la base de un sensor convencional. Como oscilador lento: anillo con divisor. Como memoria de ms: un
biestable. El resistor solo gana si da algo que esos no: un punto de medida más pequeño que un anillo, un coeficiente de signo
elegible por capa, o una memoria térmica que no gaste celdas. Si el gemelo MOS mide la temperatura igual de bien, gana el anillo.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer: la tarjeta completa de `res_xhigh_po` y `res_high_po` (hecho en parte, sección 2), el issue 169 del PDK y la página
   device-details (límite de corriente, "TBD" de `res_xhigh_po`); y Makinwa (filtros electrotérmicos, **sin leer**) por la
   difusividad térmica y las escalas de tiempo, que hoy son `[?]`.
2. Buscar en el PDK: qué capa de Magic extrae a qué modelo (`xhrpoly` 319,8 Ω/□ coincide con el `rsheet` 317,39 de `res_high_po` y
   `uhrpoly` 2000 con `res_xhigh_po`; confirmarlo extrayendo), anchos discretos permitidos (el tech dice 0,35; 0,69; … hasta 1,27,
   **PDK local**), largo mínimo y reglas de cabeza: borde legal por buscar con `residual/drc_edge`.
3. Comprobar el issue 169 aquí: simular un resistor de cada tipo a 27 y 85 °C en ngspice y ver si R cambia. Predicción escrita antes.
   En `res_xhigh_po` el cuerpo es una ecuación (`r = {…}`), el caso que el issue describe; en `res_high_po` es un `.model` con `rsh`.
4. Si ngspice ignora el coeficiente, anotarlo a mano (R(T) con tc1 y tc2 del modelo) y repetir. La diferencia es dato para XC-47.
5. Simular el anillo con el resistor a varias temperaturas y obtener la sensibilidad del cociente a R en el punto elegido.
6. Modelo térmico de un nodo (potencia, resistencia térmica `[?]`, capacidad `[?]`): sirve para escribir la predicción con sus
   incógnitas a la vista, no para dar una cifra.
7. Dibujar por script resistor, gemelo y ficticio; DRC en los dos decks; extraer; LVS dispositivo a dispositivo.

### 5.2 Configuraciones a dibujar

Dimensiones propuestas, sin evaluar; los bordes legales del resistor están por buscar salvo el ancho mínimo.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Capa | `res_xhigh_po`, `res_high_po`, poly común | ¿El signo y el tamaño del efecto siguen al coeficiente de cada capa? Es el control de signo |
| Largo a ancho fijo (0,35 µm) | 1, 2, 5, 10 y 20 cuadros | A igual corriente, la potencia por área es la misma: ¿el ΔT depende del largo? Separa cuerpo de cabezas |
| Ancho a igual número de cuadros | 0,35; 0,69; 1,27 µm | Misma R, distinta área y perímetro: ¿el calor sale por el perímetro o hacia abajo? |
| Relación cabezas/cuerpo | Resistor corto (dominan cabezas y contactos) frente a largo | Las cabezas tienen otro coeficiente en el modelo; ¿se ve en silicio? |
| Forma | Recto frente a serpentín de igual largo | El serpentín se calienta a sí mismo: ¿sube ΔT a igual potencia? |
| Qué hay debajo | Sobre aislamiento de campo; sobre pozo n; con metal 1 encima como disipador | Camino del calor hacia el sustrato y hacia el metal |
| Distancia al anillo gemelo | Pegado, 5 µm, 20 µm | Cuánto calor del resistor llega al gemelo: fija la validez del cociente |
| Orientación | Horizontal y vertical | Control: no se espera diferencia; si la hay, es litografía o gradiente |

Primero un canal: un `res_xhigh_po` mínimo en un anillo, su gemelo MOS y el ficticio. La matriz, después.

### 5.3 En silicio

1. **Virgen:** cociente anillo con resistor / gemelo, todos los canales, sin pulso de calentamiento.
2. **Calibrar:** calentar el dado entero (mesa o XC-31) y medir el cociente frente a temperatura: da el coeficiente real de cada
   capa, que es por sí solo un resultado (modelo frente a silicio, XC-47).
3. **Caracterizar:** pulso de corriente por el resistor con los drivers de la plataforma (0,51 mA por pareja de `ebufn_8`,
   laboratorio, sin publicar); cociente antes, durante y después. Barrer duración y amplitud del pulso.
4. **Barrer:** alimentación, temperatura de base, frecuencia de repetición del pulso (¿acumula?).
5. **Buscar lo no trivial:** histéresis del cociente frente a potencia subiendo y bajando; oscilación espontánea con el resistor
   polarizado en continua. Superar 500 µA/µm es estrés de mesa y necesita permiso.
6. **Repetir** otro día y **clasificar** cada canal.

No hay transformación prevista; si un resistor cambia de forma permanente tras un pulso, pasa a ser un caso de XC-51.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** el cociente cambia durante el pulso y se recupera con una constante de tiempo medible, el signo se invierte entre
  capas de coeficiente opuesto, y el ficticio lejano no lo produce.
- **Positivo fuerte (improbable, juicio de la pesca):** histéresis u oscilación electrotérmica.
- **Negativo informativo:** la calibración por temperatura del dado da el coeficiente, pero el pulso no produce ΔT legible: el
  autocalentamiento a 1,8 V queda acotado por arriba.
- **Inconcluso:** el gemelo MOS cambia tanto como el anillo con resistor.
- **Fallo instrumental:** el anillo no responde a la resistencia en serie como en simulación.
- **Muere como celda** si el efecto es solo un RC térmico que el gemelo MOS mide igual; queda como dato de XC-47.

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

- Vehículo: flujo digital a 1,8 V; no pide pines analógicos. Usa la plataforma de anillo con resistencia en serie de EFLD-00/01.
- Depende de XC-31 (calor como canal) para calibrar y de XC-32 (alimentación) como canal de control.
- Sirve a XC-47 (coeficiente térmico del modelo frente a silicio) y a XC-40 y XC-31 como calefactor caracterizado.
- Permiso de estrés en mesa solo si se supera el límite de corriente del resistor.
- Comprobar que el resistor de poly es admisible dentro de un macro propio en la tesela digital: sin regla pública hallada `[?]`.
- Un solo chip basta para el efecto; el coeficiente entre dados pediría más.

## 8. Abierto y fuentes

- **Discrepancia con la ficha:** la ficha da tc1 = −4,3·10⁻⁴ /K para "el poly de alta resistencia". En el PDK local ese valor es el de
  las cabezas; el cuerpo de `res_high_po` es positivo (+0,514·10⁻³) y el de `res_xhigh_po` es −1,47·10⁻³, que la pesca traía como
  "otra revisión, sin leer". La ficha no se toca aquí; hay que corregirla.
- ¿Ignora ngspice el coeficiente en nuestra versión? (issue 169, **leído por agente**; paso 3 de 5.1).
- Resistencia y capacidad térmicas de un resistor de poly sobre el aislamiento de campo `[?]`.
- ¿Qué se obtuvo en silicio para `res_xhigh_po`, cuya especificación dice "TBD"? `[?]`
- PDK local: ciel, versión `8afc8346a57fe1ab7934ba5a6056ea8b43078e71`, carpeta `sky130A/` (en `local_flow/pdk_host`).
- Fuentes: [pesca](../notas/PESCA_2026-11-12.md), sección 2. Plataforma: `local_flow/efld_00/LEEME.md` (laboratorio).
