# MISFIT · pruebas por bloque del chip: qué está hecho, qué falta, qué no se puede saber antes del silicio

2026-11-23, 18:13 EST (`date`); **puesto al día el 2026-11-25** con MISFIT-03 enmienda 2, MISFIT-04 enmiendas 3 y 4, y MISFIT-05 a 07, y **el 2026-11-26** con el plan nocturno (`experiments/noche_1125/RESULTADOS.md`) y MISFIT-14 y 15. Inventario, no plan: el orden de lo que falta está en [`docs/MISFIT_PLAN.md`](../../docs/MISFIT_PLAN.md). Cada fila apunta al archivo que tiene el número; aquí no vive
ningún número nuevo. Todo lo "hecho" es **modelo** (SPICE, DRC, aritmética), nunca silicio.

Leyenda: ✅ hecho en el modelo · 🟡 parcial o con veredicto falso pendiente de enmienda · ❌ falta · 🚫 imposible antes del silicio.

## 1. Infraestructura (lo que hace interpretable todo lo demás)

| Bloque | Hecho | Falta antes de fabricar | Imposible antes del silicio |
|---|---|---|---|
| **Núcleo digital** (contador, protocolo, flags) | ✅ 13 pruebas cocotb (solo lógica) · ✅ tile 1×1 con la celda de tiempo: DRC 0, LVS, precheck (`instrument/misfit02/`) · ✅ bloque de 161 × 87 µm en el tile 1×2 (MISFIT-04) · ✅ cierra con el metal 4 reservado encima salvo la banda de pines: 11 856 µm² libres en bruto (`experiments/misfit06/RESULTADOS.md`) · ✅ variante lean sin contador común: equivalente ciclo a ciclo en 10 millones de ciclos aleatorios, 13/13 cocotb, −9,0 % de área de celdas (`experiments/misfit08/RESULTADOS.md`) | ❌ perfil de corriente por estado (RISKS 2) · ❌ flanco lento de `xa` al sincronizador (RISKS 5) · ❌ `src = 2` en `misfit_cell_slot.v` con la definición nueva, y volver a correr cocotb · ❌ bajar la altura del bloque con el núcleo lean (plan, B3b) · ❌ celdas de fila instanciadas dentro del núcleo (B2; el relleno sobrante está en astillas) · ❌ acoplo del núcleo hacia lo que se ponga en el metal 4 (B4) | — |
| **Celda de tiempo** (referencia digital, canal 7) | ✅ extraída, dentro del 1,2 % de su esquemático; el RTL la lee dentro de 1 ciclo en todas las fases (MISFIT-02) | — | 🚫 su valor absoluto en el dado |
| **Interruptor de potencia del tile** | 🟡 solo el transistor en esquemático: 1×1 en `tt_power_gate/drops.txt`; la cifra del 1×2 es aritmética (`CANDIDATURA` W2) | ❌ con metal y extraído · ❌ corriente real del tile 1×2 sumando núcleo, slots y, si entra, la bobina | — |
| **Cadena de polarización (VB)** | ✅ usable en 5 esquinas a 27 y 85 °C (`bias_table.txt`) · ✅ ruido 1/f integrado (`xc19_discrim/calc_ruido/integra.txt`) · 🟡 **etapa b**, diseño en esquemático: 11 códigos de 0 a −155 mV, paso máximo 16–41 mV (`xc19_slot_e2/etapa_b/README.md`) · ✅ **filtro de VB** (MISFIT-07, enmienda 1): la lectura no cambia al quitar el filtro de 10 pF, ni en lectura asíncrona (A tarda 3–5 veces más que B); sin ruido y con un solo lector (`experiments/misfit07/RESULTADOS.md`) | ❌ etapa b con interruptores reales, prerregistrada, y Monte Carlo del paso (plan, R1) · ❌ dos lectores sobre un mismo VB (R3) | 🚫 deriva térmica real (RISKS 7) |
| **Decodificador E7** | ✅ simulado dentro del contrato del slot; F5 solo se ve en la corriente del tile (`INFORME_etapa_a.md`) · ✅ sintetizado en el núcleo: tabla E7 9/9 alcanzables y 16/16 en el módulo; entradas quietas en la ventana (MISFIT-04 I2, I3) | ❌ glitches con tiempos reales (I3 es retardo unitario) | — |
| **Integración del tile (MISFIT-04)** | ✅ tile 1×2: DRC 0, LVS match, precheck 15/15 · ✅ extracción plana con acoplo: agresores reales dan 0,0129 % a tt (umbral 0,0807 %) · ✅ campaña de 10 sabotajes (`experiments/misfit04/RESULTADOS.md`) · ✅ E1: `input2/3.X` con su celda real dan 0 (`i4/e1.txt`) · ✅ E2: sensibilidad cerca del umbral, 39 de 40 fases, acoplo mínimo detectable 113,7 aF (`e2/e2.txt`, enmienda 4) · ✅ E3: un LVS sin tomas de sustrato ve S2 (`e3/e3.txt`) | ❌ slot en corto que alimenta a sus vecinos (RISKS 3) · ❌ deriva de X en reposo armado (A2) · ❌ causa de los abortos de ngspice en decks grandes `[?]` · ❌ repetir todo en el tile 1×1 del plan | — |

## 2. Slot XC-19 (lector de una carga)

| Prueba | Estado | Archivo |
|---|---|---|
| DRC (Magic y dos decks de KLayout) y LVS | ✅ P1 | `cells/xc19_slot_core/` |
| Simetría A/B, rechazo de la alimentación en el cociente, 7 fallos inyectados | ✅ P5′, P7, F1–F7 | `experiments/xc19_slot/INFORME_etapa_a.md` |
| Inerte con `en = 0` | ✅ con el inversor hvt (macro v_hm): 8,31 pA a ss 85 (MISFIT-03 enmienda 2, C2). La P2 original fue falsa | `experiments/xc19_slot_e2/INFORME_enmienda2.md` |
| Tamaño del paso de calibración | ✅ 0,967 % a ff −40 con la placa rediseñada (C1b). La P4 original fue falsa a tt | ídem |
| Tiempo absoluto | 🟡 P3 falsa por el ancla del prerregistro, no por el macro | ídem |
| Transitorio de `en = 0` en ff −40 y ss 85 | ✅ corrió (C1, C2) | ídem |
| Ruido sobre el macro extraído con sus capacidades reales | 🟡 ruido de disparo ✅ (C4: σ 0,151 %, salto a 7,3σ en un disparo; las tiradas comparten semilla) · ✅ repetido en el lector pequeño con semillas independientes: σ 0,157 % en dos semillas, testigo ×2,89 (noche 1125, bloque C) · 1/f sobre el macro ❌ (plan, R5) | ídem, `ruido.txt`; `experiments/noche_1125/RESULTADOS.md` |
| Monte Carlo de desajuste del macro | 🟡 48 chips: el salto se ve en los 47 que cruzan (mediana 0,803 %) y el 40 % da < 10 cuentas, como se predijo; **falsas** las tres predicciones de dispersión (el desajuste A/B es ~2,5× el modelo) · ✅ lector pequeño, 48 chips: salto mediana 0,805 %, dispersión entre gemelos 1,11 frente a 1,20; **falsa** la banda del paso relativo por un chip de 48 (noche 1125, bloque B) | ídem, `mc.txt`; `experiments/noche_1125/RESULTADOS.md` |
| Precheck | ✅ MISFIT-04 1×2, 15/15 (`experiments/misfit04/i1/`) | — |
| Lector pequeño para un tile 1×1 (una fila de filtro) | ✅ dibujado, 58,2 × 20,7 µm; DRC 0, LVS, KLayout 0; lee igual que el grande en 4 esquinas (MISFIT-09) | `experiments/misfit09/RESULTADOS.md` |
| Varias ramas en un lector | ✅ 16 ramas iguales en 4 esquinas (MISFIT-05) · ✅ 32, 64 y 128 ramas iguales en el lector pequeño, sin cableado: dentro de los tres cortes hasta 128; **falsa** la predicción del salto (−4,27 % a 128 en ss 85); se usan 64 (noche 1125, bloque D) · ✅ matriz **generada y extraída** de 64 puestos leída por el lector pequeño: +0,33 a +0,36 % por puesto, salto −2,35 % como mucho, 4 de 4 predicciones (MISFIT-11, `experiments/misfit11/RESULTADOS.md`) · ❌ líneas de selección y decodificador, desajuste y dispositivos distintos (plan, R4, R6) | `experiments/misfit05/RESULTADOS.md`; `experiments/noche_1125/RESULTADOS.md` |
| Si existen trampas visibles | 🚫 el modelo no tiene trampas; el salto se inyecta a mano | — |

## 3. Abanico de DUT (C0–C9) y simulador de discriminación

| Prueba | Estado |
|---|---|
| Prerregistro y 3 enmiendas sellados | ✅ `cells/preregistros/XC-19_2026-11-23_discriminacion_abanico*.md` |
| Estimador independiente E_B | ✅ terminado; pasa T1 y los mutantes (`xc19_discrim/eb.txt`) |
| Estimador del autor E_A | 🟡 terminado; nunca aplicó el prior de λ0 (hueco declarado) |
| Consolidación (diferencia ≤ 0,05 bits) y veredictos | 🟡 **ninguna fila decide** (enmienda 4): con λ0 desconocido el control T2 da 0,72 del techo, por debajo de 0,80; parado (`xc19_discrim/RESULTADOS_enmienda4.md`) |
| Modelo de qué distingue a C1–C6 | ✅ contestado (MISFIT-18, `experiments/misfit18/RESULTADOS.md`): el modelo solo distingue área y largo de difusión; C4 y C6 son idénticas a C0, C3′ casi; C1 es C0; C5 pasa a XC-14 |
| Layout del abanico en la matriz | ✅ generado, 18 puestos, DRC 0 en las tres herramientas y LVS (MISFIT-18) · ❌ líneas de selección y decodificador |
| Cuánto cambian la corriente y el salto al multiplexar DUT en serie | ✅ 2026-11-25, 16 ramas iguales, sin cableado ni desajuste (`experiments/misfit05/RESULTADOS.md`) |
| Fuga de N interruptores abiertos a 85 °C | ✅ 2026-11-25: 15 ramas ≤ 0,54 % de la corriente (ídem) |
| Densidad real de trampas (λ0) | 🚫 el 1/f del PDK leído como trampas es una conjetura; por eso el prior de b6 |

## 4. Slot de metrología pasiva (devuelve datos aunque no aparezca nada exótico)

| Estructura | Hecho | Falta |
|---|---|---|
| **XC-12, matriz LOD** | ✅ la extracción omite `sa`/`sb`; el modelo separa 31,09 mV; el anotador pasa su CI; el par LOD pasa por la etapa (`docs/CLAIMS.md`) | ❌ layout de la matriz con controles de orientación y proximidad · ❌ su lectura por el mismo lector · ❌ prerregistro de silicio |
| **XC-62, pares de poly densa/aislada** | 🟡 etapa 2: **benchmark inválido** (fallan a2 y a3) · 2b de convergencia prerregistrada, sin correr (~3,8 h estimadas) | ❌ correr 2b · ❌ layout |
| **Tiras Kelvin** (n+, p+, poly, li) | ❌ nada | fuera del primer tile (decisión del 2026-11-25 en el plan: su sitio lo toma XC-14) |
| **Escalera de capacidades** | ❌ nada | ❌ ídem |
| Residuo de la OPC de la fábrica | — | 🚫 |

## 5. Apuestas exóticas

| Celda | Hecho | Falta antes de fabricar | Imposible antes del silicio |
|---|---|---|---|
| **XC-20, unión p+/n+ a separación 0** | ✅ el precheck la acepta a 0, la rechaza solapada y a 0,13 (`precheck_map`) · ✅ túnel verificado al orden de magnitud (rondas 1–2) · 🟡 motor de hipótesis r3 **no consolidado** · 🟡 **lector de rango ancho** en esquemático: lineal ±1,6 % de 100 pA a 1 µA a tt 27; a ff 85 pierde la década baja (`experiments/xc20_lector/DISENO_lector.md`) · 🟡 dos veredictos con prerregistro: ninguna precarga única (L = 0,15, 0,50, 1,00, 2,00) cumple ±3 % de 1 nA a 10 µA en 4 esquinas; **muere el lector de una precarga**, pasa a dos rangos (`experiments/xc20_lector/r2/`, `experiments/noche_1125/RESULTADOS.md`) · ✅ celdas de la variante en sustrato generadas, limpias y con LVS (MISFIT-14) · ✅ polarización real de la unión en su puesto y aislamiento de la selección: el puesto dibujado da 0,9–1,65 V según la corriente; con el interruptor abajo, la tensión del nodo (MISFIT-15, `experiments/misfit15/RESULTADOS.md`) · ✅ variante en pozo n con el interruptor abajo generada, limpia y con LVS; el pozo pone 3,81 fF por puesto en el nodo (MISFIT-16) | ❌ leerla con el lector 2 en 4 esquinas · ❌ prerregistro del lector de dos rangos y layout (plan, R2) · ❌ matriz de separación d × largo L × área A · ❌ layout · ❌ S2 (perfil de implante) y S3 (DEVSIM con túnel), por montar · ❌ anillos de guarda y latch-up (RISKS 12) | 🚫 magnitud del túnel (el perfil de dopado no es público) |
| **XC-14, antena como escritura en fábrica** | ✅ descarga verificada y residuo al orden (ronda 4) · ✅ el precheck no comprueba antena · ✅ ventana de lectura: puerta entre 0,3 y 1,0 V legible por el lector 2, mejor con óxido grueso (MISFIT-19, `experiments/misfit19/RESULTADOS.md`) · ✅ puesto de puerta flotante con antena generado, limpio y con LVS; acoplo de la placa 0,5 y del nodo 0,065 (MISFIT-20) · ✅ redibujado con pantalla y dos líneas de acoplo: acoplo del nodo 0,008 (MISFIT-21) | ❌ simulación con la puerta flotando (encendido y precarga) · ❌ antenas grandes sobre el núcleo · ❌ que el reset y la calibración no polaricen el nodo antes de la primera lectura (RISKS 4) | 🚫 si la carga del plasma queda escrita y sobrevive al recocido |
| **XC-52, espín (con XC-10 para crear trampas)** | ✅ el demodulador de 4 estados no elimina los términos pares (ronda 2) · ✅ bobina 0,373 mT/mA · ✅ candidatura W1–W5 · 🟡 **W1 leído: `[?]`, inclinado a muerte** (ninguna fuente da ΔNit ≥ 1e11 cm⁻² a ≤ 4,3 MV/cm; `attack2_xc52/W1_RESULTADO.md`) · 🟡 etapa 0, medir en el chip las trampas que crea el estrés (DCIV): nota de diseño (`cells/xc52_spin_pair/ETAPA0_DCIV.md`) | ❌ prerregistro de la etapa 0 y cómo polarizar el pozo sin pines analógicos (plan, C7) · ❌ W2–W5 | 🚫 si los centros Pb responden a ±2 mT a temperatura ambiente |
| XC-01 y XC-05 (constricciones) | ✅ rondas 1–2: puente por barrera, cuello de li | ❌ alimentación y protección aparte para pulsos de mA · ❌ S4 electrotérmica, por montar | 🚫 el estado tras la formación |
| **XC-64, paseo por la regla** (alta del 2026-11-25) | ✅ la herramienta que mide el borde legal existe y midió bordes reales (`residual/drc_edge`) | ❌ todo: lista de reglas con magnitud legible y tramo enviable, primera escalera (plan, G3) | 🚫 qué pasa eléctricamente fuera de regla |

## 6. Qué va primero

El orden vigente, con cada prueba y qué la mata, está en [`docs/MISFIT_PLAN.md`](../../docs/MISFIT_PLAN.md) (pruebas B, R, C, G, T).
La lista que había aquí el 2026-11-23 quedó resuelta o absorbida: MISFIT-04 y la enmienda 2 del slot se hicieron; el lector de rango
ancho y la etapa b tienen diseño en esquemático; el modelo para C1–C6 y el termómetro en el chip siguen sin hacer.
