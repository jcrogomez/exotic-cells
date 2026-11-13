# EFLG-00 · La Trampa como defecto individual (frente C del sprint, 2026-11-05)

**Pregunta:** ¿puede el chip distinguir el estado de un defecto individual (RTN de dos niveles) de la variación convencional de un
transistor, con lectura digital?

**Verificado (ngspice, esquemático, `macros/constriccion/sim/rtn_presupuesto.sp`):** un desplazamiento de umbral de 0,3 mV en una
etapa de un anillo de `inv_1` cambia el período en 6·10⁻⁶; 3 mV, 1·10⁻⁴; 30 mV, 8,6·10⁻⁴. La amplitud de una trampa en un MOS mínimo
(0,42 × 0,15 µm) es ΔVth = q/(C_ox·W·L) = 0,305 mV con C_ox = 8,32 fF/µm² del modelo del PDK (`docs/FRONTERAS_FISICAS_1105.md` §6).
El contador del Cronista resuelve ~10⁻⁵ con ventana de 2^20 a 10 MHz, pero la deriva térmica de un anillo es órdenes de magnitud mayor.
**Conclusión: un anillo de celdas estándar es ciego a una trampa individual.**

**Modelado:** en una etapa cuya corriente la fija un solo MOS en inversión débil, ΔI/I ≈ ΔVth/(n·kT/q) ≈ 0,3 mV / (1,3 × 26 mV) ≈ 0,8 %
por salto; con dos niveles y tiempos de residencia de ms–s, una lectura diferencial contra un anillo gemelo y ventanas cortas lo
vería como saltos discretos, no como deriva. Esa etapa no existe en la biblioteca: exige un macro con el MOS mínimo polarizado en
inversión débil (puerta a un divisor o a un espejo) y, en flujo digital, una polarización derivada de fugas o de un DAC de resistencias
de poly `[?]`. Alternativa: rama analógica con pin `ua` de polarización.

**Hipótesis:** la densidad de defectos de sky130 hace probable que al menos un MOS mínimo de N muestre RTN a 300 K; N necesario `[?]`.

**Bloqueado:** no se dibuja el macro esta noche. Hace falta decidir la polarización (digital por fugas vs. pin analógico) y simular la
etapa en inversión débil con el modelo del PDK; esa simulación es la siguiente tarea.

**Dispositivo de prueba y referencia (propuesta):** nfet_01v8 0,42/0,15 (DUT) y nfet_01v8 4,2/1,5 (misma corriente, 100× área: ΔVth
100× menor) en etapas idénticas; variantes de polarización; lectura diferencial; placa caliente para los tiempos de residencia.

**Separación de RTN frente a artefactos:** jitter (no es bimodal ni con residencias ms–s), telemetría (se repite con el gemelo),
alimentación (afecta a los dos anillos a la vez), 1/f (continuo, no dos niveles). Criterio mínimo: histograma de frecuencia bimodal
con separación > 5 σ del piso y residencias que cambien con polarización y temperatura.
