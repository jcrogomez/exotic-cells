# XC-30 · Coherencia mesoscópica

**Fusionada en XC-54 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-30 de [catálogo](../../README.md#catalogue) (Mesoscopic coherence).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-29 · Nanoporos reales** y **XC-30 · Coherencia mesoscópica.** Solo nombradas (texto externo del 2026-11-08, que no está en el
repo). Cadena `[?]`. **Mantener como línea abierta** hasta tener el texto.

## 2. Lectura y piso

No hay lectura que planear porque no hay cadena: la familia está solo nombrada y su texto de origen (externo, 2026-11-08) no
está en el repositorio. El único dato de origen es la fila del laboratorio que la agrupa con «posprocesado o criogenia». Lo
que sigue es qué definir primero. Las interpretaciones son **conjetura** nuestra.

| Interpretación (conjetura) | Observable | Qué pide | Señal |
|---|---|---|---|
| A. Interferencia en un anillo metálico (flujo magnético) | Resistencia que oscila con el campo | Frío, imán barrido, medida de cuatro puntas | `[?]` |
| B. Localización débil en una línea o en el pozo | Magnetorresistencia pequeña cerca de campo cero | Frío, imán, cuatro puntas | `[?]` |
| C. Fluctuaciones de conductancia de una constricción | Huella reproducible frente a campo o puerta | Frío; constricción de XC-01 o XC-02 | `[?]` |
| D. Transporte por pocos canales o una isla | Escalones, bloqueo | Es XC-05 y XC-06, ya en archivo | ver abajo |

Lo que el laboratorio ya calculó para el caso D (**cálculo**, sin publicar): una isla de met1 de 0,14 × 0,14 µm tiene energía
de carga de 3,7 meV y pide 4,3 K para superar diez veces la energía térmica; a 300 K la energía térmica es 25,9 meV. Para A, B
y C la cantidad que manda es la longitud de coherencia de fase en el aluminio y en el silicio dopado frente al tamaño mínimo
dibujable (0,14 µm en met1): `[?]` a cualquier temperatura. Los instrumentos de la plantilla leen tiempo a 300 K; ninguno sirve.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control |
|---|---|
| Magnetorresistencia clásica o efecto Hall del pozo (XC-25) | Dependencia con la temperatura: lo coherente desaparece al calentar unos kelvin; lo clásico no |
| Deriva térmica de la resistencia al barrer el campo | Barrido de ida y vuelta; estructura gemela más ancha, donde el efecto coherente se promedia |
| Trampas, contactos u óxido: cualquier escalón a 300 K | Regla del laboratorio (`FRONTERAS_FISICAS_1105.md`, ficha 3): se atribuye primero a eso, no a efectos cuánticos |
| Ruido del amplificador externo que parece una huella | Reproducibilidad de la huella al repetir el barrido; cambia tras un ciclo térmico, no entre barridos |
| El modelo falla en frío y se confunde con física nueva | SKY130 a 77 K ya tiene ≈ 20 % de error RMS de modelo (pesca, **leído por agente**) |

## 4. Referencia convencional (control científico, no filtro)

No hay componente de biblioteca que haga algo parecido, y no hay función a la vista: es una familia de motor P pura, de
información y no de utilidad. La comparación exigible es otra: contra un resistor del PDK de la misma capa y tamaño medido en
las mismas condiciones, para mostrar que la estructura dibujada añade algo a lo que el material hace solo. Y contra XC-25,
que con el mismo imán y a temperatura ambiente da un dato seguro.

## 5. Plan de pruebas

### 5.1 Sin silicio

Qué definir primero, en orden:

1. Conseguir el texto externo del 2026-11-08 y copiar a la sección 1 la frase exacta. Lo tiene Juan o un chat anterior `[?]`.
2. Decidir qué coherencia: de electrones en metal, en silicio, o algo óptico (coherencia de la luz de XC-26 bajo las redes de
   XC-27). Son familias distintas; la tercera cabría en el vehículo de hoy y las otras no.
3. Escribir la cadena de la ficha y, antes que nada más, la observabilidad: instrumento, piso, señal.
4. Pesca dirigida: una fuente leída con la longitud de coherencia de fase en películas de aluminio de interconexión y en
   silicio dopado, y a qué temperatura alcanza 0,14 µm. Es el número que decide si hay familia `[?]`.
5. Pesca: precedentes de chips CMOS de fundición medidos en frío buscando interferencia, no bloqueo de Coulomb.
6. Averiguar a qué temperatura se podría enfriar un chip encapsulado de Tiny Tapeout y con qué equipo accesible `[?]`.
7. Solo entonces dibujar: los precursores (anillos y líneas de ancho mínimo) son legales y triviales; el coste no es el
   layout sino el vehículo de medida.

### 5.2 Configuraciones a dibujar

Condicionales; valores **propuesta**. Anchos mínimos conocidos: met1 0,140 y li 0,170 (`residual/drc_edge`, **corrida**).

| Barrido | Valores | Pregunta |
|---|---|---|
| Diámetro del anillo | El mínimo que deje la regla de hueco (por buscar); 2×; 4× | El periodo en campo va con el área encerrada: es la firma que no imita nada clásico |
| Ancho del brazo | 0,14 µm (mínimo de met1); 0,28; 0,56 | Al ensanchar se promedian canales y el efecto debe caer |
| Anillo frente a línea de igual longitud y ancho | Par gemelo | Lo que es del anillo y no del material |
| Longitud de la línea | Tres valores a ancho mínimo | La localización débil y las fluctuaciones dependen de la longitud frente a la de coherencia |
| Capa | met1; li1; poly silicidado; pozo n | Materiales con coherencia muy distinta; el metal más resistivo puede ser el más interesante |
| Constricción | Las de XC-01 y XC-02, tal cual | Reutiliza precursores: fluctuaciones de una región pequeña |
| Número de contactos | Dos y cuatro puntas | Sin cuatro puntas el contacto domina (regla: contacto antes que cuello) |
| Orientación respecto al campo | Anillo en el plano del dado (campo perpendicular) | Único caso útil: el flujo debe atravesar el anillo |

Primero un canal: un anillo y su línea gemela, con cuatro puntas a pines analógicos.

### 5.3 En silicio

Sin secuencia hasta tener cadena. Del vehículo se puede decir:

1. Nada de esto se lee con el flujo digital a 300 K. Espera un vehículo especializado: pines analógicos, medida de cuatro
   puntas con amplificador externo, frío y un imán barrido.
2. Si algún día hay frío: virgen a temperatura ambiente → enfriar → barrer campo → calentar unos kelvin y repetir (el efecto
   debe apagarse) → ciclo térmico completo y repetir (la huella de fluctuaciones cambia; la oscilación del anillo no).
3. Lo que sí se puede hacer en el chip de hoy, sin afirmar nada: incluir un anillo y su línea como resistores pasivos
   accesibles, para tenerlos fabricados si el vehículo de medida aparece. Decidir si esa área se justifica es del filtro final.

### 5.4 Criterio de muerte (borrador)

- **Positivo, negativo, inconcluso, fallo:** no se pueden escribir sin observable ni vehículo; van al prerregistro.
- **Muere como familia separada** si el texto resulta hablar de islas o contactos atómicos: se funde con XC-05 o XC-06.
- **Queda en archivo, sin morir,** si la fuente del paso 4 dice que la longitud de coherencia no alcanza el tamaño mínimo a
  ninguna temperatura accesible: se anota el número y la línea se conserva.

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

- Compuertas: el texto externo; después, un vehículo con frío e imán que hoy no existe.
- Vehículo especializado (catálogo). Comparte imán con XC-25 y precursores con XC-01, XC-02, XC-05 y XC-06.
- Sin permisos de estrés: nada se transforma.
- Un chip basta para la interferencia de un anillo; las fluctuaciones son, por naturaleza, distintas en cada muestra.

## 8. Abierto y fuentes

- Qué decía el texto.
- Longitud de coherencia de fase en los metales y el silicio de SKY130, a cualquier temperatura: `[?]`.
- Composición de met1 y de li1 (aluminio con barrera; ¿nitruro de titanio?): `[?]` en el laboratorio; decide el material.
- Fuentes: `docs/FRONTERAS_FISICAS_1105.md`, ficha 3, y `docs/CATALOGO_v05_BORRADOR.md`, fila E6 (laboratorio, sin publicar);
  [pesca del 12-nov](../notas/PESCA_2026-11-12.md).
