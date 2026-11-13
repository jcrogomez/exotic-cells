# XC-40 · Termopila

**Fusionada en XC-39 el 2026-11-12.** Esta carpeta conserva su ficha y su plan como variante de esa familia.

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-40 de [catálogo](../../README.md#catalogue) (Thermopile).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-40 · Termopila.** Seebeck entre poly n y difusión p junto a un calefactor → N pares en serie, calefactor de conmutación → ninguna
→ tensión en la puerta del lector de inversión débil → sensor de flujo de calor, recolector → lector de XC-19 → calefactor en las dos
polaridades y termopila con las uniones a la misma distancia. Señal: 750 µV/K por par (**fuente sin leer**); ΔT `[?]`. Aburrida: el
umbral del propio lector deriva más que un par (−1 a −2 mV/K, **de memoria**): sin referencia diferencial no se interpreta.

## 2. Lectura y piso

Lector en inversión débil (XC-19): la termopila va en serie entre la polarización y la puerta del dispositivo, que no consume
corriente. Se lee el cociente contra un lector gemelo sin termopila. Todo modelo; nada en silicio.

| Cantidad | Valor | De dónde |
|---|---|---|
| Paso del lector | 0,83 % del tiempo por 0,305 mV en la puerta | `experiments/xc19_weak_inversion/budget.txt`, **corrida** |
| Seebeck por par | 750 µV/K (**sin leer**); el PDK no trae ningún coeficiente Seebeck | ficha; [pesca](../notas/PESCA_2026-11-12.md) |
| Señal por par y por K entre uniones | ≈ 2 % del tiempo (**cálculo**: 750 µV / 0,305 mV × 0,83 %; supone que la cifra sin leer vale y que la tensión llega entera a la puerta) | — |
| Deriva del cociente dispositivo/gemelo | 0,16 %/K (**corrida**) | [`xc19_single_trap/PLAN.md`](../xc19_single_trap/PLAN.md), sección 3 |
| Deriva del umbral del lector | −1 a −2 mV/K (**de memoria**) | ficha |
| ΔT entre unión caliente y fría | `[?]`: el PDK no trae conductividad térmica | — |
| Retroceso del lector sobre la polarización | 0,076 mV a 1 pF; 0,016 mV a 10 pF (**corrida**) | `docs/CLAIMS.md` |

Señal/piso `[?]` porque ΔT es `[?]`. Lo que sí se sabe: la señal escala con N y con la diferencia de temperatura entre uniones; el
piso (deriva del lector) escala con la temperatura común. La medida solo se interpreta si las dos se separan por geometría.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| El lector se calienta y su umbral deriva más que un par | Lector gemelo sin termopila a la misma distancia del calefactor; solo cuenta el cociente |
| Gradiente entre lector y gemelo | Termopila fantasma: mismas patas, con las dos uniones a la misma distancia del calefactor. Debe dar cero |
| Acoplo capacitivo del calefactor de conmutación a un nodo de alta impedancia | Leer con el calefactor recién apagado: el calor persiste, el acoplo no. Blindaje a potencial fijo |
| Caída de alimentación con el calefactor encendido (XC-32) | Calefactor ficticio que consume igual lejos de la termopila |
| Resistencia de las patas que cambia con la temperatura | No importa si no circula corriente; se comprueba con la termopila gemela de un solo material (mismas patas, sin Seebeck neto) |
| Asimetría del calefactor | Calefactor a los dos lados (las "dos polaridades" de la ficha): la señal debe cambiar de signo |

## 4. Referencia convencional (control científico, no filtro)

Sensor de temperatura convencional: un anillo de celdas estándar o el PNP vertical del PDK. Ambos miden temperatura absoluta y
consumen. La termopila mide una diferencia, sin polarización y con cero en ausencia de gradiente: gana solo si el chip necesita un
flujo de calor (XC-31) y dos anillos restados no lo dan con menos área. Como recolector de energía, la comparación es contra no
hacer nada: la potencia disponible es `[?]` y casi seguro inútil; se anota, no se persigue.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Leer: la fuente de los 750 µV/K (**sin leer**; no está identificada en la pesca, hay que rehacer la búsqueda y anotar proceso,
   materiales y dopado) y una fuente de termopilas en CMOS estándar que diga qué par de capas se usó `[?]`.
2. Buscar en el PDK: no hay coeficiente Seebeck (comprobado con grep en los modelos de `libs.ref/sky130_fd_pr/spice`: los resistores
   llevan tc1 y tc2, nada termoeléctrico). Sí están las resistencias de hoja de las patas candidatas (**PDK local**, `sky130A.tech`,
   líneas 5104–5138): poly 48,2 Ω/□; n+ 120; p+ 197; pozo n 950; `xhrpoly` 319,8; `uhrpoly` 2000; li 12,8.
3. Buscar si el poly y las difusiones corrientes llevan siliciuro: el tech nombra `silicide_block` en los estilos de `npolyres`,
   `ppolyres` y `xhrpoly` (**PDK local**, líneas 493–494 y 563), indicio de que lo demás sí lo lleva. Un siliciuro es casi un metal
   y su Seebeck sería pequeño (**de memoria**): decide qué capas sirven de pata.
4. Borde legal de las patas sin siliciuro (`xhrpoly` desde 0,35 µm, **PDK local**; `npolyres`/`ppolyres`: borde legal por buscar,
   y si existen como dispositivo en sky130A) con `residual/drc_edge`.
5. Simulación: SPICE no modela Seebeck. Se simula el lector con una fuente de tensión en serie con la puerta (N · S · ΔT como
   parámetro) y la resistencia de las patas; predicción escrita en función de ΔT, que queda `[?]`.
6. Simular el acoplo del calefactor a la termopila con la capacidad extraída del layout.
7. Dibujar por script; DRC en los dos decks; extraer. LVS verá resistores en serie: comprobar que no los funde en uno.

### 5.2 Configuraciones a dibujar

Dimensiones propuestas, sin evaluar.

| Barrido | Valores (propuesta) | Pregunta |
|---|---|---|
| Número de pares N | 1, 4, 16, 64 | La señal debe ser lineal en N; la deriva del lector no depende de N. Es la prueba principal |
| Par de capas | poly p sin siliciuro (`xhrpoly`) con li; pozo n con li; difusión p con poly; un solo material (gemelo) | Qué par da Seebeck en este proceso; el de un solo material debe dar cero |
| Largo de las patas | 5, 20, 80 µm | ΔT crece con la distancia entre uniones: ¿cuánto cae la temperatura por micra? |
| Ancho de las patas | Mínimo y 4× | Patas anchas conducen calor y acortan ΔT: compromiso entre resistencia eléctrica y térmica |
| Distancia de la unión caliente al calefactor | Pegada, 2 µm, 10 µm | Perfil térmico cerca de la fuente (liga con XC-31) |
| Simetría | Termopila radial frente a fantasma tangencial (uniones equidistantes) | Separa gradiente de temperatura común |
| Orientación | Hacia el borde del dado y hacia el centro | El sustrato no es isótropo como sumidero: ¿cambia ΔT? |
| Qué hay bajo la unión fría | Sobre toma de sustrato con metal; sobre aislamiento | ¿Ancla la temperatura fría un disipador dibujado? |

Primero un canal: N = 16 de un par, su fantasma, lector y gemelo, calefactor a un lado.

### 5.3 En silicio

1. **Virgen:** cociente lector/gemelo con el calefactor apagado, todos los canales. Debe ser estable; si no, no se sigue.
2. **Calibrar:** escalón conocido en la puerta del lector (el mismo de XC-19). Temperatura del dado desde XC-31.
3. **Caracterizar:** calefactor encendido a potencia conocida; cociente en el tiempo, durante y justo después.
4. **Barrer:** potencia del calefactor (la señal debe ser lineal), lado del calefactor (cambio de signo), temperatura de base,
   alimentación.
5. **Comparar** canales por N, par de capas y largo de pata.
6. **Repetir** otro día y **clasificar** cada canal.

No hay transformación.

### 5.4 Criterio de muerte (borrador)

- **Positivo:** señal lineal en N y en potencia, que cambia de signo con el lado del calefactor, nula en el fantasma y en la
  termopila de un solo material.
- **Negativo informativo:** el lector resuelve su escalón de calibración y ninguna termopila se separa del fantasma: Seebeck × ΔT
  queda acotado por arriba para cada par de capas.
- **Inconcluso:** hay señal pero no escala con N, o el fantasma da lo mismo.
- **Fallo instrumental:** el cociente lector/gemelo no es estable con el calefactor apagado.
- **Muere** si dos anillos restados miden el mismo gradiente con menos área y menos ruido.

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

- Depende del lector de XC-19 y de su gemelo; si el lector falla, cae.
- Depende de XC-31 (calefactor y temperatura) y usa a XC-39 si el calefactor es un resistor de poly.
- Vehículo: flujo digital a 1,8 V. La termopila es pasiva; el nodo de puerta es de alta impedancia y va dentro del macro.
- Antena: una cadena larga de poly o li unida solo a una puerta puede violar las reglas de antena (poly 50, li 75, **leído por
  agente**); el precheck no las corre para sky130A, pero una comprobación omitida no es autorización.
- Sin permisos de estrés. Un solo chip basta.

## 8. Abierto y fuentes

- Fuente y condiciones de los 750 µV/K `[?]`. Seebeck de cada capa de SKY130 `[?]`.
- ¿Llevan siliciuro el poly y las difusiones corrientes? `[?]` (indicio en el tech, no prueba).
- ΔT alcanzable a 1,8 V entre dos puntos a decenas de micras `[?]`.
- ¿Admite la tesela digital resistores de pozo o de poly sin siliciuro dentro de un macro propio? `[?]`
- PDK local: ciel, versión `8afc8346a57fe1ab7934ba5a6056ea8b43078e71`, carpeta `sky130A/` (en `local_flow/pdk_host`).
- Fuentes: [pesca](../notas/PESCA_2026-11-12.md). Lector: [`experiments/xc19_weak_inversion`](../../experiments/xc19_weak_inversion/README.md).
