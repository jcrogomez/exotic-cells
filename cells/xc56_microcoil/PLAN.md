# XC-56 · Microbobina integrada

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-56 de [catálogo](../../README.md#catalogue) (On-chip microcoil).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Alta del 2026-11-12. Los números de este archivo son
**cálculo** con constantes de memoria salvo donde se cita otra cosa; ninguno está verificado contra fuente ni simulado.

## 0. Primeros principios

Campo en el centro de N espiras de radio r: B = µ₀NI/2r. Con N = 5, r = 10 µm, I = 10 mA: ~3 mT (**cálculo**). El campo
terrestre es ~0,05 mT: la bobina manda. Se modula a megahercios sin imán externo.

## 1. Ficha

**XC-56 · Microbobina.** Instrumento. Espiral en met3/met4 sobre el dispositivo → campo de mT modulable → fuente de campo para
XC-52 (espín) y XC-25 (Hall, ~0,2 mV por mA con supuestos de dopado y espesor del pozo, **cálculo**) → enlace magnético entre
celdas sin cable.

**[corregido 2026-11-12 13:06] Ronda de ataque 1** ([resumen](../../experiments/RONDA_1_2026-11-12.md)): 0,23–0,26 mT/mA en geometría compacta; con pista de 1,5 µm e interior libre de 10 µm, 0,19 mT/mA y 1,9–2,0 mT al límite de corriente continua de met3 (6,8 mA/µm), no ~3 mT (verificado).

## 2. Lectura y piso

Se caracteriza con la placa Hall de XC-25 debajo: la una calibra a la otra.

## 3. Explicación aburrida y controles

Calentamiento y acoplo eléctrico: la bobina bifilar (ida y vuelta juntas) da la misma potencia con campo nulo.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Biot–Savart numérico para espirales dibujables; mapa del campo en el plano del silicio.
2. Resistencia, calentamiento y límite de corriente de la espiral con los datos del PDK.
3. Caída en la red de alimentación de la tesela con 10 mA pulsados.

### 5.2 Configuraciones a dibujar

Propuesta: 1, 3 y 5 vueltas; radio interior 5, 10 y 20 µm; met3 frente a met4; normal y bifilar.

### 5.3 En silicio

Corriente frente a tensión; campo medido por la placa Hall de debajo; térmica por un sensor vecino.

### 5.4 Criterio de muerte (borrador)

Muere si el calentamiento o la caída de alimentación a la corriente necesaria perturban más que la señal que habilita.

## 6. Documentación para graduarse

- [ ] Hoja de primeros principios revisada por un ataque independiente
- [ ] Mapa de tres regiones por simulación física, con sus barridos
- [ ] Prerregistro con predicción numérica y criterio de abandono
- [ ] Generador de layout por script, parametrizado
- [ ] DRC en Magic y KLayout, y resultado del precheck (qué pasa y qué no)
- [ ] Extracción y LVS dispositivo a dispositivo
- [ ] Simulación contra la predicción, con su control
- [ ] Macro: pines en metal, LEF con obstrucciones, alimentación
- [ ] Datos de silicio, crudos y con su control
- [ ] Contrato: modelo, interfaz, límites, variabilidad, retención, modos de fallo, condiciones de formación
- [ ] README en inglés

## 7. Compuertas y dependencias

Sirve a XC-25 y XC-52. Metal 5 está reservado: se usa hasta met4.

## 8. Abierto y fuentes

- Precedente de bobinas de calibración en sensores Hall integrados: lectura pendiente.
- **Comprobación de citas del 2026-11-12** ([`docs/READING.md`](../../docs/READING.md)): bobina de calibración integrada sobre un sensor Hall: 0,392 mT por mA publicados (Demierre 2002, **sin leer**), del mismo orden que el cálculo de arriba (0,31 mT por mA).
