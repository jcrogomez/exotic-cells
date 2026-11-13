# XC-26 · Enlace óptico interno

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-26 de [catálogo](../../README.md#catalogue) (On-chip optical link).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-26 · Enlace óptico interno.** Recombinación radiativa en una unión en directa → emisor p+/pozo n y fotodiodo legal 3×3 µm a 5,
10 y 20 µm, control a 40 µm, guarda → ninguna → fotocorriente por precarga y descarga → aislamiento óptico, sensor → integrador de
carga del lector → emisor frente a carga ficticia de igual potencia, guarda conectada y desconectada. **Mantener:** seis celdas con
DRC 0 y piso modelado de 150 fA (`macros/photon/`). Predicción escrita: gana la difusión de portadores. El valor seguro es el
instrumento de corrientes pequeñas, que sirve a XC-20 y XC-23.

**Replanteo del 2026-11-12 (razonamiento, sin simular).** Si el emisor es p+ en pozo n, los huecos que inyecta acaban en el
sustrato como mayoritarios (es el PNP vertical del PDK) y no difunden hasta el fotodiodo, que recoge electrones. La explicación
aburrida pasa de "difusión de portadores" a "rebote del potencial del sustrato", que es instantáneo y se separa por tiempo.
Con supuestos gruesos (1 mA, eficiencia 10⁻⁵, 5 µm, absorción del 1 %) la fotocorriente sale del orden de pA, sobre el piso de
150 fA. Todo `[?]` hasta simular. Absorbe XC-50.

**[corregido 2026-11-13 08:17] Ronda de ataque 4 (optica)** Verificado al orden por dos agentes: fraccion recogida F 2,3-2,45e-3 a 5 um; eta de emision ~1e-7 a 2e-5. Vive con condicion: pozo del emisor a ~+1 V y rho del sustrato <= 10 Ohm cm (no publica): 0,21-0,42 pA a 5 um frente a piso 0,15 pA; con catodo a masa 0,04-0,06 pA, bajo el piso; rho >= 20 muere. Frontera superior: saturacion del PNP vertical (0,09-1,1 mA segun rho). El control a 44 um ve 3-25 % de la luz: no es nulo optico; el control sin luz debe ser emisor apagado o tapado. Ver `experiments/RONDA_4_OPTICA_2026-11-13.md`.

## 2. Lectura y piso

Lector de precarga y descarga: un excitador de tres estados precarga el cátodo del fotodiodo a 1,8 V y lo suelta; la corriente
lo descarga hasta el umbral de un inversor y se cuentan ciclos. Todo es modelo del laboratorio (`macros/photon/`), **sin publicar**.

| Cantidad | Valor | De dónde |
|---|---|---|
| Nodo de lectura | 12,4 fF; carga hasta el umbral 12,5 fC | `sim/lectura.sp`, laboratorio, **corrida** |
| Piso a 27 °C | ≈ 150 fA con 2²⁰ ciclos a 10 MHz; ≈ 10 fA con 2²⁴ si la fuga del excitador es la del modelo `[?]` | idem |
| Piso a 85 °C | Lo fija la deriva del fondo (≈ 9,5 pA): ≈ 0,1 pA si deriva 1 % (hipótesis) | idem |
| Fuga del `ebufn_1` en Z | 32 fA (27 °C), 0,41 pA (85 °C); con el nodo a 0,9 V cambia de signo (−17 fA) | `sim/fuga_ebufn.sp` |
| Fondo a 27 °C | No cruza: el nodo se estanca en 1,36 V | `sim/lectura.sp` |
| Artefacto del simulador | Con el gmin por defecto aparecen 1,8–7,7 pA ficticios; se usa 1e-18 | idem |
| Corriente oscura, responsividad y capacidad reales del fotodiodo | `[?]`: ni el PDK ni su documentación las dan | `PESCA_PHOTON_1105.md` |
| Señal óptica | `[?]`. Con la eficiencia de avalancha de 65 nm: ≈ 6–60 pA a 100 µA. En directa a 1,8 V nadie la cuantifica | `PESCA_OPTO_1104.md` §6 |
| Señal de portadores | Una fuga de 10⁻⁵ de la corriente del emisor ya es 1 nA (supuesto de orden de magnitud) | idem |

Señal/piso: `[?]` para la luz. Para los portadores, grande. La predicción escrita en la ficha es que gana la difusión.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Portadores que difunden del emisor al fotodiodo | Guarda conectada y desconectada; distancia; curva de XC-23; lectura retardada tras apagar el emisor |
| El emisor sube el potencial local del sustrato (PNP vertical parásito) | Anillo p+ junto al emisor (`photon_e05g`); ficticio óhmico que mete la misma corriente sin unión |
| Calor: el fondo térmico del fotodiodo crece mucho con la temperatura (6,5 fA a 27 °C, 11,5 pA a 85 °C en el modelo) | Resistencia de poly de igual potencia en el lugar del emisor (aún sin dibujar) |
| Caída de alimentación o rebote de masa al encender el emisor | Emisor de control idéntico a 40 µm: mismo excitador y corriente, otra distancia |
| El excitador de precarga recarga o descarga el nodo según su tensión | Canal fantasma con el mismo lector y un condensador; tríos intercalados (emisor, control, nada) |
| Lo que cambia es la capacidad del nodo, no la corriente | Corriente de prueba conocida en cada canal |
| La luz llega, pero por reflexión en metal o relleno, no directa | No es aburrida: es XC-27. Tapas distintas sobre el mismo par |

## 4. Referencia convencional (control científico, no filtro)

Como enlace aislado: un condensador de acoplo o un desplazador de nivel de la biblioteca, que pasan un bit con picosegundos y
sin corriente continua. El enlace óptico solo gana si aísla de verdad (el sustrato común lo impide en principio) o si sirve de
sensor. Como instrumento de corrientes pequeñas compite con el lector en inversión débil de XC-19 y con un pin analógico y un
electrómetro externo, que es lo convencional y cuya fuga de interruptor no se conoce `[?]`. El instrumento sobrevive aunque
no haya un fotón.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (laboratorio, sin publicar): fotodiodo canónico de 3 × 3 µm con sus dos anillos; seis celdas (`photon_fd`, `_fd_l10`,
   `_e05`, `_e10`, `_e20`, `_e05g`) con 0 en Magic y 0 en el deck de fabricación de KLayout; extraídas; reglas photo.5–11 y
   nwell.7 cumplidas a mano porque ninguna herramienta las comprueba.
2. Hecho: presupuesto del lector con modelos del PDK a 27 y 85 °C.
3. Pendiente: pasar las seis celdas por el deck completo de KLayout con el front-end activo, como exige la lista de la sección 6.
4. Pendiente: traer los generadores a esta carpeta; pines en metal; símbolo de referencia para LVS (los contactos de sustrato
   se funden en la extracción).
5. Pendiente: sustituir la precarga por la de canal largo y umbral alto (0,010 pA, `docs/CLAIMS.md`, exploratoria) y repetir el
   presupuesto: quita el estancamiento a 1,36 V o lo mueve.
6. Pendiente: excitador del emisor a 1,8 V con corriente fijada por resistencia; corriente alcanzable `[?]`.
7. Pendiente: dibujar el ficticio térmico (poly) y el ficticio óhmico.
8. Pendiente: canal completo extraído y simulado, con predicción escrita antes. La luz no está en ningún modelo: la
   simulación fija fondo, rango y acoplos eléctricos.
9. Pendiente: leer enteros van Drieënhuizen y Wolffenbuttel (1992) y Zhou (1994); buscar el espectro y la eficiencia de una
   unión de silicio en directa `[?]`.

### 5.2 Configuraciones a dibujar

Lo ya dibujado en el laboratorio se marca; el resto es **propuesta**.

| Barrido | Valores | Pregunta |
|---|---|---|
| Distancia emisor–fotodiodo | 5; 10; 20 µm y control a 40 µm (dibujado) | Ley de caída: la absorción y la difusión tienen longitudes distintas |
| Guarda p+ junto al emisor | Con y sin (dibujado: `e05g`) | ¿Cuánta señal es potencial de sustrato? |
| Guarda de pozo n en inversa entre ambos | Sin; un anillo; dos | Recoge portadores y es transparente a la luz: el control que más discrimina |
| Perímetro frente a área del emisor | 1,4 µm² con 4,8 µm (dibujado); tira e igual área; cuadrado mayor | La inyección lateral y la emisión no escalan igual con el borde |
| Tamaño del fotodiodo | 3 × 3 (dibujado); 3 × 10 (dibujado, legalidad `[?]`); varios 3 × 3 en paralelo | Captación frente a capacidad y corriente oscura |
| Fotodiodo en arco | 1, 2 y 4 fotodiodos a la misma distancia alrededor | Ángulo sólido: la luz es isótropa; los portadores siguen el campo y los pozos |
| Tipo de detector | Profundo (el del PDK); somero p+/pozo n | El infrarrojo se absorbe hondo y los portadores viajan hondo; el somero ve menos de ambos, en otra proporción |
| Tipo de emisor | p+/pozo n; n+/sustrato si se puede polarizar; unión abutida (XC-20); nfet saturado (XC-50) | Mecanismo de emisión a igual potencia |
| Tapa sobre el par | Sin metal; metal continuo (enlace con XC-27) | Si la señal cambia con la tapa, parte de ella es luz |
| Orientación | Eje del par a 0° y 90° | Gradiente del dado y anisotropía de los pozos vecinos |

El primer canal completo es `photon_e05g` con su lector, su control a 40 µm y los dos ficticios.

### 5.3 En silicio

1. **Virgen:** fondo de cada fotodiodo con todo apagado; es la primera corriente oscura medida del fotodiodo de SKY130.
2. **Calibrar:** corriente de prueba en cada nodo; capacidad del nodo con un condensador conmutado; corriente del emisor.
3. **Caracterizar:** tríos intercalados (emisor cercano, emisor de control, nada) y resta, a cada distancia.
4. **Barrer:** corriente del emisor (lineal o no), temperatura (el fondo crece; la recombinación radiativa cambia poco `[?]`),
   alimentación, y cada guarda conectada y desconectada.
5. **Tiempo:** apagar el emisor y abrir la ventana de lectura con retardo creciente. Los fotones cesan al instante; los
   portadores duran un tiempo de vida `[?]`. Es el único control temporal posible con un lector que integra.
6. **Retener y repetir:** otro día; ¿el fondo deriva tras horas de emisor encendido?
7. **Clasificar** cada par: luz separada de portadores, solo portadores, solo acoplo eléctrico o térmico, bajo el piso, fallo.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** una componente que sigue al emisor, no la reproducen los ficticios, sobrevive a la guarda de pozo en inversa,
  cesa sin retardo al apagar el emisor y cambia con la tapa metálica.
- **Negativo informativo:** toda la señal desaparece con la guarda o la reproduce el ficticio, con el piso calibrado: es la
  predicción escrita. Deja medida la difusión (XC-23) y caracterizado el lector.
- **Inconcluso:** residuo tras la guarda del tamaño de la incertidumbre de la resta.
- **Fallo instrumental:** la corriente de prueba no se ve, o el fondo a temperatura ambiente no es estable entre tríos.
- **Muere** el enlace si no queda residuo óptico sobre el piso con el emisor al máximo de corriente permitido. El instrumento
  muere solo si su piso en silicio no baja de lo que piden XC-20 y XC-23.

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

- Vehículo D para todo lo descrito; H para curvas del fotodiodo por pin analógico.
- Bloqueo de relleno y de trazado sobre el par: sin regla pública hallada `[?]`. Las celdas no tienen aún obstrucciones en el LEF.
- Corriente del emisor: unión en directa entre raíles con limitador en hardware; contarla frente a la red de alimentación.
- Riesgo de enganche por el p+ en directa: contactos de sustrato a menos de 15 µm y guarda (liga con XC-24).
- Depende de XC-23 como control. Su lector sirve a XC-20, XC-23, XC-27, XC-37 y XC-50; su fotodiodo, a XC-21 y XC-22.

## 8. Abierto y fuentes

- Emisión de una unión p+/pozo n en directa a 1,8 V en SKY130: `[?]`, ninguna fuente la cuantifica.
- Corriente oscura real del fotodiodo: `[?]`. El modelo solo tiene el término de saturación del parásito.
- ¿photo.2/8/10 fijan solo el lado corto? De eso depende que `photon_fd_l10` sea legal.
- La guarda dibujada es un anillo p+ al sustrato; la pesca del 4-nov pedía un anillo n+/pozo n en inversa. Son controles
  distintos y hacen falta los dos.
- Fuentes: `macros/photon/LEEME.md`, `docs/pesca/PESCA_OPTO_1104.md`, `docs/pesca/PESCA_PHOTON_1105.md` (laboratorio, sin
  publicar); [pesca del 12-nov](../notas/PESCA_2026-11-12.md); [`docs/CLAIMS.md`](../../docs/CLAIMS.md).
