# XC-63 · Contacto sin implante

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-63 de [catálogo](../../README.md#catalogue) (Unimplanted contact).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Alta del 2026-11-12, salida del mapa del espacio de diseño
([`../notas/MAPA_ESPACIO.md`](../notas/MAPA_ESPACIO.md)). Sin atacar todavía: ningún número de aquí está verificado.

## 0. Primeros principios

Dimensión de materiales e interfaces del mapa. Un contacto sobre silicio poco dopado (el pozo, sin el implante n+) no es óhmico: forma una barrera rectificadora. La biblioteca siempre pone el implante para evitarlo. Altura de barrera del siliciuro de titanio sobre silicio n `[?]` (~0,6 eV, **de memoria**).

**Regiones.** Convencional: contacto con implante, óhmico. Tercera: diodo de barrera con caída directa baja, sin almacenamiento de minoritarios, y sensible a la interfaz. Fallo: contacto abierto o resistencia enorme.

## 1. Ficha

**XC-63 · Contacto sin implante.** Barrera metal–semiconductor → contacto sobre pozo n sin implante n+ → ninguna → característica rectificadora frente al contacto normal → diodo rápido de baja caída, detector, y sonda de la interfaz del contacto → lector de precarga → el mismo contacto con implante.

**[corregido 2026-11-12 13:57]** La interfaz real es desconocida: una reconstrucción no oficial infiere siliciuro de titanio solo bajo los contactos (`notas/DATOS_PROCESO.md`). «Metal sobre silicio sin implante» no es automáticamente una barrera conocida: primero hay que saber qué materiales se tocan.

**[corregido 2026-11-12 19:54] Ronda de ataque 3** ([resumen](../../experiments/RONDA_3_2026-11-12.md)): el propio PDK lo hace: siete celdas `cap_vpp…shieldl1` llevan contacto sobre toma sin implante, todas sobre sustrato p (verificado). Sobre pozo n, una toma sin implante que sea la única del pozo no pasa: Magic la borra y salta nwell.4; acompañada de una toma normal, o sobre sustrato, pasa (verificado). Corriente inversa 0,2–25 pA según se incluya el rebaje por fuerza imagen. La regla escrita que lo prohíbe es n/psd.9. Qué metal toca el silicio sigue sin conocerse.

## 2. Lectura y piso

Lector de precarga (piso modelado 150 fA) para la fuga inversa; lector de umbral para la caída directa. Sin número.

## 3. Explicación aburrida y controles

Contacto simplemente malo (resistencia alta, simétrica): la barrera rectifica, la resistencia no.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Mapa del precheck: ¿se puede dibujar un contacto sobre pozo sin implante? Probablemente lo rechaza una regla; medirlo.
2. Si no es enviable, buscar la forma legal más cercana (contacto en el borde del implante).
3. Leer la altura de barrera del siliciuro del proceso `[?]`.

### 5.2 Configuraciones a dibujar

Propuesta: contacto con implante completo, en el borde del implante, y sin implante; sobre pozo n y sobre sustrato; 1 y 9 contactos.

### 5.3 En silicio

Corriente en los dos sentidos frente a tensión y temperatura (la barrera se saca de la pendiente con la temperatura).

### 5.4 Criterio de muerte (borrador)

Muere en Tiny Tapeout si ninguna variante pasa el precheck; sigue como candidato para otro vehículo.

## 6. Documentación para graduarse

- [ ] Hoja de primeros principios revisada por un ataque independiente
- [ ] Mapa de regiones por simulación física, con sus barridos
- [ ] Prerregistro con predicción numérica y criterio de abandono
- [ ] Generador de layout por script, parametrizado
- [ ] DRC en Magic y KLayout, y resultado del precheck (qué pasa y qué no)
- [ ] Extracción y LVS dispositivo a dispositivo
- [ ] Simulación contra la predicción, con su control
- [ ] Macro: pines en metal, LEF con obstrucciones, alimentación
- [ ] Datos de silicio, crudos y con su control
- [ ] Contrato: modelo, interfaz, límites, variabilidad, retención, modos de fallo, condiciones de formación
- [ ] Referencia convencional, donde ayude a identificar el mecanismo
- [ ] README en inglés

## 7. Compuertas y dependencias

Admisibilidad por medir. Si no es enviable aquí, queda para otro vehículo.

## 8. Abierto y fuentes

- Reglas que lo bloquean y altura de barrera `[?]`.
