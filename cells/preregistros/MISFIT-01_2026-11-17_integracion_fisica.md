# Prerregistro · MISFIT-01 · integración física mínima: un inversor dibujado a mano dentro de un tile digital

Escrito el 2026-11-17 12:37 EST (hora de `date`), antes de dibujar o endurecer nada. Origen: propuesta de un asistente externo pegada por Juan
(no es decisión de Juan hasta que él la confirme); coincide con la prueba que ya estaba diseñada en
[`instrument/INTEGRATION.md`](../../instrument/INTEGRATION.md), a la que añade los controles negativos.

## Pregunta

¿Qué ruta permite meter un dispositivo MOS dibujado a mano en un tile de Tiny Tapeout con solo pines digitales, conectado a lógica
sintetizada y a la alimentación, **sin apagar ninguna comprobación** y con el dispositivo visible para LVS?

Nada exótico todavía: el circuito es un inversor. Es el control positivo de la integración.

## Lo que ya se sabe (no es hallazgo si sale)

- `local_flow/efld_01` (2026-11-05): una macro **pasiva** (resistencias de met1, sin pines de alimentación) pasó DRC y LVS con
  `MAGIC_EXT_USE_GDS` (LVS compara los dispositivos de dentro). Queda sin probar: transistores y alimentación.
- Leído hoy en `pdn_cfg.tcl` de LibreLane 3.0.14: a las macros solo se las conecta entre la capa vertical y la horizontal de la
  red (met4 y met5). La plantilla de Tiny Tapeout fija `FP_PDN_MULTILAYER: 0`: no hay met5.
- El precheck usa la plantilla digital para un GDS a mano con cero pines analógicos, y hay un 1×1 aceptado sin lógica sintetizada.

## Circuito

`ui_in[0]` → registro → **inversor a mano** (nfet_01v8 1,0/0,5 y pfet_01v8 2,0/0,5: geometría que no existe en la librería) →
registro → `uo_out[0]`; además `uo_out[1]` saca la salida del inversor sin registrar. El resto de pines, a constantes.

## Brazos

| Brazo | Cómo entra el inversor | Predicción (probabilidad mía) |
|---|---|---|
| A1 | Macro GDS + LEF con pines de alimentación en met4 y `PDN_MACRO_CONNECTIONS`; configuración de la plantilla | **Falla**: la alimentación no llega a la macro (error de red de alimentación, de pines desconectados o de LVS). 80 % |
| A2 | La misma geometría con forma de celda de fila (alto 2,72 µm, rieles de met1 arriba y abajo), añadida como celda extra y colocada por el flujo | **Pasa** DRC y LVS desde GDS. 65 %. Si falla, espero que sea por pozos o tomas, no por alimentación |
| B | Núcleo endurecido aparte hasta met4; tile ensamblado en Magic sobre `tt_block_1x1_pg.def`, franjas de met4 dibujadas, LVS propio con netgen | **Pasa** con LVS propio. 70 %. Coste esperado: rutas a mano |

A3 (red de alimentación propia con `FP_PDN_CFG`) solo si A1 y A2 fallan; sería exploratorio.

## Criterios, iguales para todo brazo

Un brazo **pasa** solo si cumple los seis:

1. Termina sin apagar ninguna comprobación que la plantilla trae encendida. Toda clave añadida se lista y se justifica.
2. DRC de Magic sobre el GDS final: 0.
3. LVS extrayendo del GDS final: coincide, y la extracción contiene los dos transistores del inversor con su W/L (1,0/0,5 y 2,0/0,5).
4. En el netlist extraído, la fuente del pfet está en la red de alimentación del tile y la del nfet en la de tierra.
5. Precheck de Tiny Tapeout: pasa sin cambios.
6. Simulación en ngspice del netlist **extraído del GDS final** (no del Verilog): con un escalón en la entrada del inversor, su salida
   invierte.

## Controles negativos

| Control | Qué se hace | Debe ocurrir |
|---|---|---|
| N1 estructural | Mismo brazo con la alimentación del inversor sin conectar | El flujo o LVS **falla**. Si pasa, el brazo no demuestra nada y se anota como tal |
| N2 funcional | Inversor con L = 1,0 en vez de 0,5, mismo RTL | El retardo del inversor en la simulación extraída cambia más de 20 %, y LVS contra el netlist viejo falla |
| N3 verificador | GDS del brazo con el inversor borrado | LVS falla |

## Qué se mide para comparar

Área ocupada por el inversor y su entorno, número de claves de configuración fuera de la plantilla, número de pasos manuales, qué
comprobaciones corren solas y cuáles hay que escribir, número de intentos hasta pasar, y qué impediría poner cuatro ranuras.

## Fuera de alcance

Silicio. Temporización a través del inversor (no tendrá modelo `.lib`: se documenta lo que STA no ve). Metaestabilidad real: la
prueba de captura asíncrona va aparte, como barrido de fase en simulación, y no demuestra una tasa de fallos.
La fase 2 (celda de descarga hasta el conteo del instrumento) tendrá su propia predicción cuando un brazo pase.

## Criterio de abandono

Cuatro intentos de endurecido por brazo. Si un brazo solo pasa apagando una comprobación, **falla**. No se cambia el criterio
después de ver un resultado.

## Enmienda 1 (2026-11-17 12:38 EST, antes de correr ningún brazo)

Los anchos 1,0 y 2,0 µm escritos arriba no caben en una fila de 2,72 µm con sus rieles. El inversor dibujado es nfet 0,65/0,5 y
pfet 1,00/0,5, con sus propias tomas de pozo y sustrato (DRC 0 y extracción correcta de la celda sola, único resultado visto al
escribir esto). El criterio 3 se lee con estos valores. N2 sigue siendo L = 1,0. Nada más cambia.

## Enmienda 2 (2026-11-17 13:34 EST, antes de correr el brazo B; A1 y A2 ya corridos)

Cómo se construye B, fijado antes de endurecer:

- El núcleo (los dos registros y todos los pines del tile) se endurece aparte con la configuración de la plantilla, en un dado de
  161 × 70,72 µm cuyos pines superiores están en las mismas x que los de `tt_block_1x1_pg.def`, más dos pines abajo
  (`inv_a`, `inv_y`). Colocado arriba del tile, sus pines **son** los del tile: no hay rutas a mano hacia los pines.
- El inversor es la macro de 12 × 9 µm con alimentación en met4 que falló en A1 (geometría libre, sin forma de fila), en la franja
  libre de abajo. Se dibujan a mano dos señales en met2 y la unión de alimentación en met4.
- LVS propio con netgen: extracción del GDS final contra núcleo (netlist de compuertas con alimentación) + inversor.

Predicciones nuevas, además del 70 % de que pase:

- El primer LVS no coincidirá a la primera (60 %): espero un error mío de dibujo en la alimentación o en un pin.
- El precheck pasará sin cambios si el DRC de Magic y el deck de KLayout pasan (75 %); si falla, será por algo del dibujo a mano.

Niveles de extracción que se reportarán por separado, para A2 y B: solo dispositivos; dispositivos + capacidades
(`ext2spice cthresh 0`); resistencias de interconexión. Los retardos se dan en cada nivel alcanzado y se dice cuál no se alcanzó.

Corrección de lectura sobre N2 (no cambia el criterio): N2 pide que el retardo **cambie más de 20 %** al alargar el canal. En A2 el
camino completo cambió +19 % en bajada y +35 % en subida; la bajada del camino completo no llega al umbral y el inversor aislado no
se midió. Queda como criterio cumplido solo en subida.
