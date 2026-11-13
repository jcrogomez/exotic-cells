# El equipo de EFL-D (reescrito el 2026-11-04, tarde)

**Definición que rige.** Una Exotic Cell es una **estructura física** que aprovecha deliberadamente una propiedad del proceso que la
biblioteca no ofrece como primitiva, y que se puede caracterizar y usar con un propósito físico definido. El GDS dibuja un
**precursor**; la fabricación (ruta A) o la formación en la mesa (ruta B) lo convierten en el dispositivo. Las celdas estándar son
herramientas: estimulan, forman, miden. La novedad frente a la literatura se evalúa después, no se exige antes.

**Qué significa "digital" aquí.** Flujo digital de Tiny Tapeout (OpenLane, celdas estándar, cocotb) **más macros pasivos dibujados en
Magic** (metal, difusión, poly, sin diseño analógico). Excluye: tensión por encima de 1,8 V y pines `ua`. Todo tamaño y toda
corriente son `[est]` hasta que lo mida el flujo o ngspice.

## Los precursores (la carga del chip)

### La Constricción — metal con geometría de nucleación · ruta B · principal
- **Precursor:** líneas de li1 (TiN, ~0,1 µm de espesor) y met1 (Al con liner, ~0,35 µm) en 3 anchos desde el mínimo (0,17 y 0,14 µm),
  con y sin muesca dibujada, 4 réplicas. Cada línea tiene su grupo de drivers (`buf_16` en paralelo) y está en serie dentro de un anillo
  del Cronista. Ruta de alimentación de cada línea con ≥ 3× su corriente de formación en contactos y vías (`mcon` 0,36 mA, `via` 0,29,
  `via2/3` 0,48 mA, LEF a 90 °C); la línea es el único tramo débil. **Nunca entre raíles.**
- **Formación:** corriente DC durante horas, fijada por `ui`; met1 mínimo está en 0,39 mA de régimen (2,8 mA/µm), cuatro `buf_16` dan del
  orden de 10× `[est]`. li1 no electromigra como el aluminio: se funde por calor; son dos mecanismos, y así se escribe la hipótesis.
- **Dispositivo candidato:** resistencia programable, nanoestrechamiento, unión túnel si el hueco queda en nanómetros (poco probable con el
  liner de TiN: lo esperable es un salto a kΩ, no circuito abierto).
- **Observable:** Δretardo del anillo (∝ ΔR·C). Un escalón de conductancia de 12,9 kΩ con 10 fF son ~130 ps `[est]`, resolubles.
- **Lo mata:** que falle antes un contacto; que el flujo no acepte el macro; que la deriva térmica tape la señal. Control: línea gemela sin
  corriente en el mismo anillo gemelo.

### La Chispa fría — uniones dopadas próximas · ruta A · sin avalancha
- **Precursor:** p+ y n+ abutidos y a separaciones crecientes dentro de un nwell (geometría de Dutta 2017, `docs/pesca/PESCA_OPTO_1104.md`
  §3), más un diodo p+/nwell del PDK como referencia.
- **Mecanismo:** campo intenso a 1,8 V en inversa: fuga y túnel banda a banda. Nada de ruptura (bv ≈ 12 V).
- **Observable:** celda fuga-a-tiempo (precarga a 1,8 V, liberación, umbral de un inversor, contador). A dos temperaturas: la fuga por
  túnel casi no depende de T; la térmica, sí.
- **Dispositivo candidato:** conducción no lineal de baja tensión; y el dato que la rama analógica necesita antes de la bomba.
- **Lo mata:** que la fuga a 1,8 V esté por debajo de la del propio transistor de precarga. Control: la misma celda sin unión.

### La Trampa — interfaces, cargas y envejecimiento · ruta B lenta
- **Precursor:** transistores de geometría propia (mínimos, estrechos, largos, con esquinas) dibujados en el macro, dentro de anillos gemelos.
- **Formación:** BTI (puertas retenidas horas, placa caliente) y HCI (conmutación máxima). Recuperación medida.
- **Observable:** Δf permanente y su recuperación; en reposo, saltos discretos (RTN candidato).
- **Lo mata:** que a 1,8 V la deriva no supere el piso del lector; entonces es un límite y se registra. Control: anillo gemelo guardado.

### El Parásito — electrodos y esfuerzos · ruta A · no destructivo
- **Precursor:** placas y líneas en met2–met4 como carga de anillos (el patrón del sombrero, su espejo y un control periódico, según
  `01_hat87/docs/research/ESPEC_CAPACITIVO.md`), y transistores idénticos rodeados de densidades distintas de relleno y de STI.
- **Mecanismo:** el parasitismo como dispositivo (capacidad por diseño) y el esfuerzo del proceso sobre la movilidad.
- **Observable:** Δf del anillo cargado (lector de PHY-02: ≈ 2 %/fF, piso 0,4 fF a 1σ por desapareamiento).
- **Lo mata:** que met5 y el relleno de la integración, que no controlamos, dominen la capacidad. Control: estructuras con el mismo
  presupuesto de metal.

### El Grabado — lo que la fabricación provoca · ruta A · recuperado (noche del 4-nov)
- **Precursor:** transistores idénticos cuya puerta cuelga de metales de distinta superficie expuesta al plasma, **dentro** de las
  reglas de antena del PDK (relaciones crecientes hasta el límite, sin diodo y con diodo), más variantes de proximidad, orientación y
  esfuerzo (distancia a STI y a pozo, densidad de relleno). Requiere macro con transistores o colocación controlada; se decide en EFLD-00.
- **Mecanismo:** carga atrapada y daño de óxido durante el grabado; esfuerzos y efectos de proximidad de la fabricación.
- **Observable:** Δf entre anillos gemelos que solo difieren en la antena o el entorno; estados de carga por histéresis de umbral.
- **Función candidata:** un parámetro eléctrico fijado por la fabricación y gobernado por geometría, sin estrés posterior.
- **Lo mata:** que el efecto dentro de las reglas sea menor que el piso del lector; entonces es un límite, y el test tile de SkyWater ya
  tiene `sa`/`sb` como referencia.

## Herramientas (no son experimentos)

- **El Cronista:** mux por `ui`, prescaler /1 a /64, dos contadores de 24 bits con desbordamiento, captura DUT/referencia en la misma
  ventana, conversor tiempo-a-digital, lectura serie por `uo` con banco, configuración, ventana y error, anillo propio de autodiagnóstico.
- **Cuatro anillos de referencia** de celda estándar, repartidos por el macro, para gradiente y deriva.
- **Enclavamiento de la Fragua:** ninguna formación arranca sin una secuencia de llave en `ui`; máquina de estados VIRGEN → ARMADA →
  FORMANDO → APAGADA → CARACTERIZADA → ARCHIVADA, sin vuelta a VIRGEN.

## Retirado a biblioteca secundaria (arquitecturas, no estructuras)

p-bits, redes de osciladores acoplados (Ising, reservorio), memoria circulante, lógica de carrera, PUF, canal térmico, canal por PDN,
celdas de contienda, autómata del sombrero sin reloj. Podrán usar Exotic Cells futuras; no son Exotic Cells.

## Espera al analógico (más de 1,8 V o pines `ua`) o a otro vehículo

- **Fotónica posprocesada (EFL02):** Sarkar, Baum y Hajimiri (Caltech, VLSI 2025): distribución óptica de reloj en bulk CMOS de 180 nm
  sin modificar el proceso, guías "I-beam" en los dieléctricos y fotodiodos de avalancha a 780 nm (`docs/pesca/PESCA_OPTO_1104.md` §4b).
  Encaja con la regla 1 (precursor dieléctrico, función óptica después). Requiere acceso al dado `[?]`; no para Tiny Tapeout encapsulado.

- **Óxido asimétrico** (filamentos, conductancia cuantizada candidata): necesita > 3 V. Se puede dibujar y enviar virgen. Opción de
  riesgo declarado: bomba apilada con celdas de 1,8 V, que es ella misma una Fragua `[?]`.
- **La Chispa** con avalancha, **los Vigías**, **la Muralla**, **el Fantasma**, **el Relámpago**, **el Centinela**: `PESCA_OPTO_1104.md`.

## Habilidad que hay que adquirir ahora

Dibujar un macro pasivo en Magic, pasar DRC y LVS, e integrarlo en OpenLane con su LEF. Es lo único nuevo; lo demás es RTL y cocotb.
