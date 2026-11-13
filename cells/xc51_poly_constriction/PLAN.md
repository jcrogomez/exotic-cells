# XC-51 · Constricción de poly

**Fusionada en XC-01 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-51 de [catálogo](../../README.md#catalogue) (Polysilicon constriction).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-51 · Constricción de poly.** Ruptura térmica o migración en un enlace de poly → enlace mínimo con cabezas anchas → corriente de
formación → resistencia antes y después → memoria de una escritura → igual que XC-01 → enlace ancho con la misma corriente. Un
fusible de poly silicidado en 0,12 µm usó 10 mA a 3,3 V durante 200 µs y pasó de 120 Ω a más de 7 MΩ (**fuente leída por agente**,
Kothandaraman 2002). A 1,8 V, marginal. El poly de SKY130, a 48,2 Ω/□ (**PDK local**), quizá no esté silicidado `[?]`. Regla 11: un
fusible es un fusible; lo exótico sería un estado intermedio estable.

## 2. Lectura y piso

Anillo con resistencia en serie (EFLD-00/01), el mismo lector de XC-01: el enlace va en serie en un anillo y se cuenta la
frecuencia contra un gemelo virgen. Todo modelo; nada en silicio.

| Cantidad | Valor | De dónde |
|---|---|---|
| Respuesta del anillo | +1,7 % con 1 kΩ, +32 % con 10 kΩ, ×2,2 con 100 kΩ; satura hacia 1 MΩ y muere abierto | `local_flow/efld_00/LEEME.md`, **corrida**, laboratorio, sin publicar |
| Rango útil del lector | 1 kΩ a 300 kΩ | `FRONTERAS_FISICAS_1105.md`, laboratorio, sin publicar |
| Poly | 48,2 Ω/□; ancho mínimo 0,150 µm (poly.1a); contacto a poly 152 Ω | **PDK local**, `libs.tech/magic/sky130A.tech`, líneas 5104–5138 y 4338 |
| Enlace virgen de 10 cuadros | 482 Ω más dos cabezas (**cálculo**: cuadros × 48,2; sin corrección de ancho) | — |
| Corriente de formación disponible | 0,51 mA por pareja de `ebufn_8`, 4,1 mA con 8; con `buf_16` sobre 410 Ω, 2,02 mA con uno y 4,09 mA con 8 | `local_flow/efld_00/LEEME.md` y `macros/constriccion/LEEME.md`, **corrida**, laboratorio, sin publicar |
| Fusible publicado | 10 mA, 3,3 V, 200 µs; 120 Ω → > 7 MΩ, poly con siliciuro en 0,12 µm | [pesca](../notas/PESCA_2026-11-12.md), **leído por agente** |
| Corriente y tiempo de ruptura en SKY130 | `[?]` | — |

Señal/piso: un enlace virgen de cientos de ohmios queda bajo el rango cómodo del lector (+1,7 % a 1 kΩ); un enlace roto (MΩ) lo
satura. El lector distingue bien "intacto" de "abierto" y mal los extremos; el estado intermedio, que es lo único exótico, caería
en su rango útil. La corriente disponible es menos de la mitad de la del fusible publicado y a menor tensión: marginal.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Se rompe el contacto, no el enlace (contacto antes que cuello) | Cabezas con muchos contactos frente a pocas; enlace ancho con la misma corriente (control de la ficha): si también cambia, no es el cuello |
| Se degrada una vía o el enrutado de formación (ya visto: el eslabón débil estaba en el enrutador, laboratorio) | Cadena sin enlace (cabezas unidas por poly ancho) con el mismo camino de formación |
| Se degradan los drivers que forman | La ruta de formación no es la de lectura: el anillo se lee con los drivers en alta impedancia; gemelo con drivers nunca activados |
| Deriva térmica durante la formación, que se recupera | Leer tras enfriar; la resistencia del poly cambia con la temperatura (tc1 = +8,916·10⁻⁴ /K, **PDK local**) |
| Es un fusible: pasa de intacto a abierto y nada más | Es el resultado convencional; se busca un estado intermedio estable y repetible |
| Gradiente del dado | Gemelo virgen adyacente; el mismo enlace antes y después |

## 4. Referencia convencional (control científico, no filtro)

El PDK trae un fusible metálico con regla propia (0,8 × 7,2 µm, **leído por agente**) y la celda de XC-01/XC-02 hace lo mismo en
metal 1 y en interconexión local. Un fusible de poly que solo abre es un fusible: no entra. Tendría que mostrar una de tres cosas:
que rompe con menos corriente o menos área que el de metal a 1,8 V; un estado intermedio estable en la región de kΩ (resistencia
programable); o un cambio reversible. Si nada de eso aparece, gana el fusible del PDK y se anota.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer: Kothandaraman 2002 entero (**leído por agente**, no por nosotros): mecanismo (migración del siliciuro frente a ruptura
   del poly), dependencia con el ancho y el largo, y si describe estados intermedios. Leer en la documentación del proceso si el
   poly de SKY130 lleva siliciuro `[?]`.
2. Buscar en el PDK (hecho en parte): el tech nombra `silicide_block` en los estilos de `npolyres`, `ppolyres` y `xhrpoly`
   (**PDK local**, `sky130A.tech`, líneas 493–494 y 563): indicio de que el poly corriente sí lleva siliciuro y de que hay
   variantes sin él. No es prueba. Pendiente: capa GDS del bloqueo de siliciuro, si `npolyres` es dibujable en sky130A y sus
   reglas (`xhrpoly` desde 0,35 µm de ancho; `mrp1` desde 0,33, poly.3): borde legal por buscar.
3. Buscar el límite de corriente del poly y del contacto a poly en la documentación (para resistores, 500 µA/µm, **leído por
   agente**): fija cuántas veces sobre régimen se forma.
4. `residual/drc_edge`: ancho mínimo del enlace (se espera 0,150), transición de cabeza ancha a cuello, y separación del enlace a
   difusión y a contactos.
5. Reutilizar el generador de `macros/constriccion` (laboratorio) cambiando la capa a poly; pintar el enlace en la capa de
   resistencia de poly para que extraiga como dispositivo de dos terminales y no como corto.
6. Simular los drivers contra la resistencia del enlace virgen: corriente y potencia disponibles. Predicción escrita antes. ngspice
   no modela fusión ni migración: no hay simulación de la transformación.
7. Dimensionar cabezas y vías para que cada contacto quede bajo su régimen con la corriente de formación (lección del
   laboratorio: 9 contactos no bastaron).

### 5.2 Configuraciones a dibujar

Dimensiones propuestas, sin evaluar; ancho de poly desde 0,150 µm (**PDK local**), lo demás es borde legal por buscar.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Largo del cuello a ancho mínimo | 0,3; 1; 3; 10 µm | La potencia crece con el largo a igual corriente; el calor escapa por las cabezas en los cortos. ¿Hay un largo óptimo? |
| Ancho del cuello | 0,150; 0,30; 0,60 µm (el último es el control ancho) | La densidad de corriente manda: el ancho debe fijar el umbral de ruptura |
| Relación cabeza/cuello | Cabeza 3×, 10× y 30× el ancho del cuello | Gradiente térmico y de corriente en la transición: ¿rompe en el centro o en el hombro? |
| Forma de la transición | Escalón recto frente a cuña a 45° | Concentración de corriente en la esquina |
| Capa | Poly corriente; poly sin siliciuro (`xhrpoly`, P+); variante n si es dibujable | Si el mecanismo es la migración del siliciuro, sin siliciuro no ocurre: separa los dos mecanismos de la ficha |
| Qué hay debajo | Sobre aislamiento de campo; sobre difusión (óxido de puerta, es un transistor: solo como comparación) | Camino del calor hacia el sustrato |
| Número de contactos por cabeza | 1, 4, 16, 36 | Contacto antes que cuello: con uno solo debe fallar el contacto |
| Metal encima | Con y sin metal 1 cubriendo el cuello | Disipador: ¿sube la corriente de ruptura? |
| Orientación | Horizontal y vertical | Control: el poly se graba distinto según orientación (liga con XC-16) |

Primero un canal: un cuello mínimo de 1 µm con cabezas de 36 contactos, su gemelo virgen y el enlace ancho, en la plataforma EFLD.

### 5.3 En silicio

1. **Virgen:** frecuencia del anillo con cada enlace y con su gemelo. Dispersión entre enlaces iguales.
2. **Calibrar:** canales de la plataforma con resistencia conocida; el cociente contra el gemelo da ohmios.
3. **Caracterizar sin formar:** corriente de lectura mínima; coeficiente térmico del enlace calentando el dado.
4. **Transformar** (con permiso, llave y límite en hardware): pulsos de formación crecientes en número de drivers y en duración,
   leyendo entre pulsos por la ruta de lectura. El enlace ancho y la cadena sin enlace reciben los mismos pulsos.
5. **Observar:** trayectoria de la resistencia pulso a pulso. ¿Salta de intacto a abierto o pasa por valores intermedios?
6. **Retener y repetir:** leer a la hora, al día y tras calentar. Un estado intermedio solo cuenta si se queda.
7. **Clasificar** cada enlace: sin cambio (dato censurado, no se descarta), abierto, intermedio estable, intermedio que deriva,
   fallo de cabeza o de driver.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** un estado intermedio en la región de kΩ, estable en el tiempo y tras calentar, que aparece en el cuello mínimo y no
  en el enlace ancho ni en la cadena sin enlace, y que se repite en varios enlaces.
- **Negativo informativo:** con toda la corriente disponible ningún enlace cambia y el control de contactos tampoco: el poly
  aguanta los drivers de 1,8 V. Cota inferior de la corriente de ruptura por ancho.
- **Convencional:** abre de golpe. Es un fusible; se compara en área y corriente con XC-01, XC-02 y el fusible del PDK.
- **Inconcluso:** cambia también el enlace ancho o la cadena sin enlace.
- **Fallo instrumental:** la resistencia virgen leída no coincide con la extraída.
- **Muere como celda** si solo abre y no mejora al fusible de metal en corriente ni en área.

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

- Permiso de Tiny Tapeout para estrés en mesa, igual que XC-01; llave y límite de energía en hardware.
- Usa la plataforma EFLD-00/01 (drivers, anillo, gemelo) y hereda su punto débil: vías y contactos del camino de formación.
- Comparte generador, lector y controles con XC-01 y XC-02; se dibuja como una variante más de capa.
- Liga con XC-39: un resistor de poly que cambia de forma permanente tras un pulso es un caso de esta familia.
- Vehículo: flujo digital a 1,8 V; la corriente es marginal frente al fusible publicado a 3,3 V. El chip con 3,3 V opcional
  (plantilla analógica) sería el vehículo siguiente si a 1,8 V no rompe.
- La transformación es destructiva: con un solo chip, cada enlace se forma una vez. Réplicas dentro del chip.

## 8. Abierto y fuentes

- ¿Lleva siliciuro el poly corriente de SKY130? `[?]` Con 48,2 Ω/□ la ficha duda; el tech sugiere que sí. Sin resolver.
- Corriente y tiempo de ruptura de un cuello de 0,150 µm `[?]`. Límite de régimen del poly y de su contacto `[?]`.
- ¿Existe un estado intermedio estable en un fusible de poly? La fuente leída por agente no lo dice `[?]`.
- ¿Acepta Tiny Tapeout la formación por estrés? Pendiente desde XC-01.
- PDK local: ciel, versión `8afc8346a57fe1ab7934ba5a6056ea8b43078e71`, carpeta `sky130A/` (en `local_flow/pdk_host`).
- Fuentes: [pesca](../notas/PESCA_2026-11-12.md), sección 1. Plataforma: `local_flow/efld_00/LEEME.md`; generador:
  `macros/constriccion/LEEME.md` (laboratorio, sin publicar).
