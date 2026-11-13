# Datos del proceso SKY130 que usan las simulaciones (tarea E0.3)

Abierto el 2026-11-12 13:25 EST (hora de `date`). Un solo lugar para los datos de proceso; las simulaciones los citan de aquí. Grados:
**PDK local** (comprobado por nosotros, con línea), **verificado** (dos cálculos o lecturas independientes), **leído por agente**
(el agente abrió el documento; nosotros no), **inferencia** (de alguien, a partir de otros datos), **no público** (`[?]`: se barre).
PDK local: `local_flow/pdk_host/ciel/sky130/versions/8afc8346…/sky130A`.

| Dato | Valor | Grado y fuente |
|---|---|---|
| Hoja de difusión n+ / p+ | 120 / 197 Ω/□ | PDK local, `libs.tech/magic/sky130A.tech` l. 5106–5107; verificado |
| Hoja de poly | 48,2 Ω/□ | PDK local, l. 5119; verificado |
| Hoja de li / met1 | 12,8 Ω/□ / 0,125 Ω/□ | PDK local, l. 5122–5123 |
| Hoja de pozo n | 950 Ω/□ (Magic, l. 5104) y 1700 Ω/□ (`rnw`, ngspice) | PDK local; verificado que son dos valores distintos |
| Contactos | mcon 9,3 Ω; a poly 152 Ω; a difusión 185 Ω | PDK local, l. 5130–5137 |
| Espesor de met1; dieléctrico bajo met1 | 0,36 µm; 1,376 µm | PDK local, l. 5058; verificado |
| Límite de corriente del LEF | met1 2,8 mA/µm; met3 6,8 mA/µm (continua, 90 °C) | PDK local, `sky130_fd_sc_hd__nom.tlef` l. 123 y 207; verificado |
| Coeficiente térmico del poly resistivo | cuerpo `res_xhigh_po` −1,47·10⁻³ /K; cuerpo `res_high_po` +0,514·10⁻³ /K; cabezas −4,3·10⁻⁴ /K | PDK local, modelos `res_*_po` |
| Túnel de puerta y fuga inducida por puerta en el modelo | `igcmod = igbmod = 0`; `agidl = 0` en nfet, no nulo en pfet | PDK local |
| Apilamiento de met1 | Dos posibles, **los dos con barrera**: 100 Å Ti / 3200 Å Al-0,5%Cu / 300 Å TiW; o 150 Å Ti / 250 Å TiN / 3200 Å Al-0,5%Cu / 90 Å Ti / 500 Å TiN | Leído por agente en dos informes de calificación de Cypress (2013 y 2014). **No público** cuál lleva SKY130 |
| Interconexión local | TiN, 0,1 µm | Leído por agente (sitio no oficial, con aviso de uso de IA) |
| Siliciuro | TiSi₂ solo en el fondo de los contactos; ninguno sobre difusión ni poly | **Inferencia** de ese sitio a partir de las resistencias de hoja; no documentado |
| Implantes de fuente y drenaje | Especie, dosis, energía y recocido **no públicos**. Profundidad de unión 0,1 µm | Leído por agente |
| Transistor de alta tensión `nfet_g5v0d10v5` | V_DS hasta 11,0 V; V_GS hasta 5,5 V | Leído por agente, documentación de SkyWater |
| Óxido de 1,8 V | 4,15 nm | Laboratorio de trabajo, sin publicar |
| Reglas de antena | poly 50; li 75; met1–5 400 | Leído por agente, documentación de SkyWater |

Lo que sigue sin dato y hay que barrer: dopado pico y gradiente lateral de fuente y drenaje; dopado y profundidad del pozo n;
densidad de trampas de interfaz; conductividades térmicas de la pila; apilamiento de met4 y met5.
