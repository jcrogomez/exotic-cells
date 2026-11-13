# XC-09 · Transistor de carga atrapada

**Fusionada en XC-14 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-09 de [catálogo](../../README.md#catalogue) (Charge-trap transistor).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-09 · Transistor de carga atrapada.** Atrapamiento por portadores calientes → nfet con polarización de estrés → pulsos de
programación → ΔVth y retención → memoria sin máscara, peso analógico → celda de un transistor → programar, leer, hornear.
**Mantener en H:** precedente en otros nodos; en el óxido de sky130 `[?]`; pide 3,3 V sobre un dispositivo de 1,8 V.

**Configuraciones añadidas por la búsqueda del 2026-11-12:**

- **XC-09:** el transistor de carga atrapada publicado depende de un dieléctrico de alta permitividad que SKY130 no tiene (**sin
  leer**). No se descarta sin leer la fuente.

## 2. Lectura y piso

El lector en inversión débil de XC-19, sobre el mismo transistor antes y después.

| Cantidad | Valor | De dónde |
|---|---|---|
| Sensibilidad del lector | 0,83 a 0,84 % de tiempo por 0,305 mV; factor de pendiente 1,41 | [`CLAIMS.md`](../../docs/CLAIMS.md), **corrida** de modelo |
| Una carga en el mínimo 0,42/0,15 | 0,305 mV | mismo, **cálculo** |
| Desajuste de umbral entre dispositivos | σ = 17,3 mV (0,42/0,15); 5,13 mV (5/0,15) | mismo, **corrida** |
| Referencia de tamaño: umbral movido por layout (LOD) | 31,09 mV a W = 0,42 µm | mismo, **corrida** |
| Anillo de celdas estándar | 3 mV en una etapa → 1·10⁻⁴ del período; 30 mV → 8,6·10⁻⁴ | `EFLG00_TRAMPA.md`, **corrida** de modelo, laboratorio, sin publicar |
| Desplazamiento esperado en el óxido de SKY130 | `[?]` | — |
| Retención | `[?]` | — |

Señal/piso: el lector resuelve fracciones de mV, así que cualquier desplazamiento útil como memoria (del orden del desajuste o
mayor) se vería. El anillo es casi ciego. Por el desajuste, la comparación válida es cada transistor consigo mismo; el gemelo
sirve para la deriva, no para el valor.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Es BTI que se recupera, no carga retenida | Seguir la recuperación desde ms hasta días; ficticio con la misma tensión de puerta y sin tensión de drenaje |
| Es daño de interfaz (cambia la pendiente, no desplaza) | Leer a dos polarizaciones de puerta: un desplazamiento rígido y un cambio de pendiente dan cocientes distintos |
| Calentamiento durante el pulso | Lectura en frío; gemelo contiguo; canal XC-31 |
| Cambió el lector o la polarización | Gemelo no programado leído por el mismo lector; intercambio de lectores |
| La carga está en el espaciador o en el óxido de campo, no en el óxido de puerta | Leer con fuente y drenaje intercambiados; barrido de ancho (borde frente a área) |
| El pulso de 3,3 V dañó la unión | Fuga de drenaje antes y después |

## 4. Referencia convencional (control científico, no filtro)

Para memoria: SONOS del proceso (+6,7 y −3,8 V, **leído por agente**, fuera de 1,8 V), la puerta flotante (XC-11), el fusible y el
biestable. Para un peso fijo sin máscara adicional: un umbral elegido por layout (XC-12, 31,09 mV, **corrida**), que no pide
programación.

Tendría que mostrar: un desplazamiento ajustable después de fabricar, retenido, a menor tensión que SONOS. Si el desplazamiento es
menor que el desajuste de fábrica o se recupera solo, gana el umbral por layout.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho: lector simulado y dibujado (XC-19); sirve tal cual para leer el desplazamiento.
2. Pendiente: leer la fuente del transistor de carga atrapada (**sin leer**; la pesca dice que depende de un dieléctrico de alta
   permitividad que SKY130 no tiene). No se descarta sin leerla.
3. Pendiente: comprobar si los modelos del PDK traen ionización por impacto para el nfet de 1,8 V y simular la corriente de
   sustrato frente a largo y tensión de drenaje, como indicador de portadores calientes. Predicción escrita antes. El PDK no
   modela envejecimiento `[?]`.
4. Pendiente: buscar una medida de portadores calientes en un óxido de unos 4 nm sin alta permitividad.
5. Pendiente: dibujar las variantes de 5.2 con el generador de XC-19; bordes con [`drc_edge`](../../residual/drc_edge/README.md).
6. Pendiente: decidir cómo llega la tensión de programación al drenaje sin pasar por el lector (ruta de formación aparte, con
   llave).
7. Pendiente: auditoría de qué más ve los 3,3 V (uniones, pozo, lector).

### 5.2 Configuraciones a dibujar

Valores: **propuesta**. Mínimos conocidos: 0,42/0,15; difusión junto a la puerta desde 0,250 µm sin contacto y 0,275 con contacto
centrado.

| Barrido | Valores | Pregunta |
|---|---|---|
| Largo de canal | 0,15; 0,18; 0,25; 0,50 µm | El campo lateral cae con el largo: ¿el desplazamiento desaparece al alargar? Firma de portadores calientes |
| Ancho | 0,42; 1,0; 5,0 µm | Carga por área frente a carga en el borde con el óxido de campo |
| Borde frente a área | un transistor ancho frente a varios estrechos en paralelo con igual ancho total | ¿El atrapamiento vive en la esquina del óxido de campo? (liga con XC-46) |
| Tipo y umbral | nfet y pfet; variantes de umbral bajo y alto si las hay a 1,8 V | Electrones frente a huecos; campo en el óxido |
| Óxido grueso | misma geometría en dispositivo de 5 V (11,6 nm) | Ficticio: mismo pulso, otro óxido |
| Simetría de lectura | lectura normal y con fuente y drenaje intercambiados | La carga junto al drenaje se ve distinta al invertir: localiza |
| Largo de difusión | 0,30 y 3,0 µm | ¿El esfuerzo mecánico cambia el atrapamiento? (matriz con XC-12) |
| Orientación | 0° y 90° | Anisotropía de fabricación |
| Contactos de drenaje | uno centrado frente a fila completa | Reparto de corriente durante el pulso |

Primero un canal: un nfet mínimo con ruta de programación, gemelo y lector.

### 5.3 En silicio

1. **Virgen:** tiempo de descarga de cada transistor y de su gemelo, a dos polarizaciones.
2. **Calibrar:** escalón conocido en la puerta (el de XC-19).
3. **Caracterizar:** deriva del cociente sin programar, horas.
4. **Transformar, a 1,8 V** (cabe hoy, con permiso): puerta y drenaje al máximo durante tiempos crecientes; es la frontera con
   XC-10.
5. **Transformar, a 3,3 V** (otro vehículo): pulsos en el drenaje, de duración creciente, con lectura entre pulsos.
6. **Observar:** desplazamiento frente a número de pulsos; lectura directa e invertida.
7. **Retener:** horas y días a temperatura ambiente; después, horneado en placa. **Clasificar:** sin cambio; cambio que se
   recupera (BTI); cambio retenido (candidato); daño (fuga de unión, pendiente degradada).

Vehículo que espera: híbrido con 3,3 V por pin analógico (4 mA máximo, **leído por agente**) o raíl de 3,3 V. Se barre: tensión,
duración, temperatura.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** desplazamiento mayor que el desajuste de fábrica, retenido tras horneado, dependiente del largo y asimétrico entre
  lectura directa e invertida.
- **Negativo informativo:** tras el estrés máximo del vehículo, desplazamiento bajo la resolución calibrada del lector.
- **Inconcluso:** desplazamiento que se recupera en horas, o igual en el ficticio sin drenaje.
- **Fallo instrumental:** el escalón de calibración no se ve.
- **Muere como memoria** si no retiene; pasa entonces a ser dato de XC-10.

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

- Permiso de estrés; para 3,3 V sobre un dispositivo de 1,8 V, vehículo híbrido y auditoría de alta tensión.
- Depende del lector de XC-19. XC-10 es su versión a 1,8 V y su control de recuperación.
- Comparte matriz con XC-12 (largo de difusión) y XC-46 (esquina).
- El estado virgen y la prueba a 1,8 V caben en el digital.

## 8. Abierto y fuentes

- Desplazamiento y retención en el óxido de SKY130 `[?]`.
- Si el modelo del PDK da corriente de sustrato creíble `[?]`.
- Fuente del precedente, **sin leer**: [pesca](../notas/PESCA_2026-11-12.md). Juicio de un agente: improbable a 1,8 V sin alta
  permitividad; sin fuente abierta entera.
- Cifras del lector: [`CLAIMS.md`](../../docs/CLAIMS.md), [`xc19_single_trap/PLAN.md`](../xc19_single_trap/PLAN.md).
