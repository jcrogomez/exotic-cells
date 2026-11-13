# XC-25 · Hall en pozo n

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-25 de [catálogo](../../README.md#catalogue) (Well Hall plate).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-25 · Hall en pozo n.** Efecto Hall → placa de pozo de cuatro terminales → campo externo → tensión Hall → sensor magnético →
corriente rotatoria → imán calibrado. **Mantener en H como instrumento:** sensor publicado en 180 nm, sin estado ni formación (ficha
4). Da µ_H del pozo, que no tenemos.

**Replanteo del 2026-11-12 (cálculo).** Con una microbobina encima (XC-56, ~3 mT por 10 mA) la placa no necesita imán externo:
~0,2 mV por mA de polarización, suponiendo 10¹⁷ cm⁻³ y 1 µm de espesor de pozo `[?]`, del tamaño de un paso del lector de XC-19.
Deja de ser solo instrumento: bobina y placa forman un enlace magnético entre celdas sin cable, y la una calibra a la otra.

**[corregido 2026-11-12 13:06] Ronda de ataque 1** ([resumen](../../experiments/RONDA_1_2026-11-12.md)): la tensión Hall queda entre 0,017 y 0,66 mV por mA a 2,65 mT según dopado y espesor del pozo (verificador): no se puede afirmar un valor. El PDK da dos resistencias de hoja del pozo: 950 y 1700 Ω/□ (verificado). Bobina más placa es lo más sólido de la ronda.

## 2. Lectura y piso

La tensión Hall es de microvoltios y continua; ningún instrumento de la plantilla la lee hoy. La ruta es convertirla en un
cambio de umbral: la tensión Hall se suma a la puerta del lector en inversión débil de XC-19, en diferencial entre los dos
terminales de sentido, con la corriente rotando.

| Cantidad | Valor | De dónde |
|---|---|---|
| Resistencia de hoja del pozo n | 950 Ω/□ (550–1350) | `sky130A.tech`, **PDK** local; rango en `FRONTERAS_FISICAS_1105.md`, laboratorio |
| Movilidad Hall, espesor y dopado del pozo n | `[?]`: no están en la documentación abierta | idem, ficha 4 |
| Señal | 48 / 95 µV a 1 mA y 1 mT **si** µ_H fuera 0,05 / 0,10 m²/V·s (hipótesis, no dato de SKY130) | idem, **cálculo** del laboratorio, sin publicar |
| Caída en una placa cuadrada a 1 mA | 0,95 V (0,55–1,35 V): cabe en 1,8 V; placas largas no caben | idem |
| Sensibilidad del lector | 0,305 mV en la puerta → 0,83 % del tiempo; ruido 0,55 % por conversión en el punto pequeño | `experiments/xc19_weak_inversion`, `xc19_noise`, **corrida** |
| Desplazamiento de una placa sin corriente rotatoria | `[?]`; se supone equivalente a mT, mucho mayor que la señal | ficha 4 del laboratorio |
| Referencia publicada | 110 µV/mT; placa de pozo n de 100 × 100 µm; residuo de 16 µT con corriente rotatoria (0,18 µm) | Lee 2020, leído en el laboratorio |

Señal/piso: a 1 mT la señal supuesta (48–95 µV) es menor que el escalón de 0,305 mV que el lector convierte en 0,83 %, y ese
0,83 % es del orden de su ruido por conversión. Hay que promediar o usar un imán más fuerte; campo del imán de mesa `[?]`.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Desplazamiento geométrico de la placa (contactos desalineados, gradiente de dopado) | Corriente rotatoria: el desplazamiento cambia de signo entre fases y la señal Hall no |
| Esfuerzo mecánico del encapsulado (piezorresistencia; es XC-44) | Mismo control; además, placas a 0° y 45° responden distinto al esfuerzo e igual al campo |
| Deriva térmica al pasar 1 mA | Ficticio: resistencia de pozo de igual potencia sin terminales de sentido; inversión del imán |
| El imán mueve otra cosa: los hilos, el lector, el reloj | Placa gemela sin corriente de polarización; imán girado 180°: la señal debe cambiar de signo |
| Magnetorresistencia, no Hall | Es par en el campo; Hall es impar: invertir el imán las separa |
| Tensión termoeléctrica en los contactos | Invertir la corriente: Hall cambia de signo, la termoeléctrica no |

## 4. Referencia convencional (control científico, no filtro)

El PDK no ofrece sensor magnético: no hay componente de biblioteca. La comparación honesta es contra un sensor Hall comercial
soldado en la placa, que mide lo mismo sin gastar silicio, y contra la literatura (110 µV/mT en 0,18 µm). La placa no compite
como función. Su valor es de instrumento: da µ_H del pozo, que no tenemos, y con él el dopado; y comprueba si el lector de
XC-19 resuelve microvoltios de una fuente conocida y reversible, que es una calibración mejor que cualquier escalón interno.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (laboratorio, sin publicar): fórmula, escala con µ_H supuesta, presupuesto de tensión y dos referencias leídas.
2. Pendiente: buscar µ_H o el dopado del pozo n de SKY130 en los modelos (resistor de pozo, parámetros de unión) `[?]`.
3. Pendiente: bordes legales del pozo n (ancho y separación mínimos) y de los contactos n+ dentro de él, con `residual/drc_edge`.
4. Pendiente: conmutación de la corriente rotatoria con puertas de transmisión de 1,8 V: simular su resistencia frente a los
   950 Ω de la placa y su inyección de carga sobre los terminales de sentido.
5. Pendiente: simular la cadena placa (red de resistencias con una fuente dependiente como tensión Hall) → lector de XC-19.
   Predicción escrita antes: cuántas conversiones hacen falta para ver 1 mT con la µ_H supuesta.
6. Pendiente: dibujar la placa por script; DRC en los dos decks; extraer (Magic da un resistor de pozo, no cuatro terminales:
   habrá que ver qué netlist sale) `[?]`.
7. Pendiente: decidir el imán y cómo se conoce su campo en la posición del dado dentro del encapsulado.

### 5.2 Configuraciones a dibujar

Valores de barrido: **propuesta**; anchos y separaciones de pozo, borde legal por buscar.

| Barrido | Valores | Pregunta |
|---|---|---|
| Lado de la placa cuadrada | 10; 30; 100 µm | La sensibilidad no depende del tamaño; el desplazamiento y el ruido sí: ¿cuánto se pierde al encoger? |
| Forma | Cuadrado con contactos en esquinas; cruz griega; octógono | Factor geométrico y simetría para la corriente rotatoria |
| Relación de aspecto | 1:1; 2:1 (límite del presupuesto de tensión) | Factor geométrico frente a caída óhmica: la ficha dice que la larga no cabe; comprobarlo |
| Tamaño del contacto frente al lado | Contacto mínimo; un tercio del lado | Contactos grandes cortocircuitan la tensión Hall; pequeños suben el ruido |
| Orientación | 0° y 45° | El campo no distingue orientación; el esfuerzo del encapsulado sí (liga con XC-44) |
| Capa activa | Pozo n; pozo profundo; pozo n bajo campo frente a bajo difusión | Espesor y dopado efectivos distintos: otra µ_H·R de hoja |
| Tapa | Sin metal; placa de metal a masa encima | Blindaje eléctrico sin blindar el campo: separa acoplo capacitivo de señal |
| Par en antiparalelo | Dos placas con corrientes opuestas | El campo da señales opuestas; la temperatura, iguales |

Primero un canal: una placa de 30 µm con sus cuatro puertas de conmutación, su gemela sin corriente y un lector.

### 5.3 En silicio

Clasificada en H: con cuatro pines analógicos y un amplificador externo es una medida de libro. En D, con el lector de XC-19:

1. **Virgen:** sin imán, las cuatro fases de la corriente rotatoria; su semisuma es el desplazamiento y su ruido es el piso.
2. **Calibrar:** escalón conocido en la puerta del lector (el de XC-19). El imán es la segunda calibración, externa.
3. **Caracterizar:** señal frente a corriente de polarización (debe ser lineal) con un imán fijo.
4. **Barrer:** campo (distancia del imán y polaridad), temperatura (µ_H baja al calentar), alimentación.
5. **Retener y repetir:** otro día y tras flexionar levemente la placa de circuito: separa esfuerzo de campo.
6. **Clasificar:** Hall (impar en campo, lineal en corriente), solo desplazamiento, bajo el piso, fallo de lector.

No hay transformación ni estado.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** señal impar en el campo, lineal en la corriente, igual en placas de distinta orientación; de ella sale
  µ_H·R de hoja con su incertidumbre.
- **Negativo informativo:** el lector, calibrado, habría visto la señal de la µ_H supuesta y no la ve: µ_H es menor que la
  hipótesis, o el factor geométrico es peor. También es un dato del pozo.
- **Inconcluso:** residuo de la corriente rotatoria mayor que la señal esperada.
- **Fallo instrumental:** el escalón de calibración no se ve, o las cuatro fases no cierran.
- **Muere** como celda por definición (sensor conocido, sin estado ni formación). Como instrumento muere si el residuo en
  silicio no baja de la señal de un imán de mesa.

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

- Vehículo: H (cuatro pines o dos con conmutación interna, amplificador externo de microvoltios). En D depende de XC-19.
- Necesita un imán calibrado en la mesa; sin él no hay medida.
- 1 mA de polarización continua por placa: contarlo en el consumo.
- Sirve a XC-23 (desvío de portadores) y XC-30 (montaje magnético); XC-44 es su explicación aburrida y su vecina.
- Un chip basta. Entra solo si sobra área, según el laboratorio.

## 8. Abierto y fuentes

- µ_H, espesor y dopado del pozo n: `[?]`. Es lo que la familia mide.
- Desplazamiento típico sin corriente rotatoria: `[?]` (la ficha del laboratorio no cita número).
- Si el lector de XC-19 admite una entrada con el modo común de la placa, lejos de su polarización de puerta (0,25–0,45 V): `[?]`.
  Puede hacer falta un desplazador capacitivo, que añade su propia inyección.
- Variante MOS de drenaje partido (el canal como placa): otra geometría, sin evaluar ni fuente.
- Fuentes: `docs/FRONTERAS_FISICAS_1105.md`, ficha 4 (laboratorio, sin publicar): Lee et al., Sensors 20, 5285 (2020);
  Heidari et al., ISCAS 2014. [`xc19_single_trap/PLAN.md`](../xc19_single_trap/PLAN.md).
