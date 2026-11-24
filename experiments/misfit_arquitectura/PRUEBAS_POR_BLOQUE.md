# MISFIT · pruebas por bloque del chip: qué está hecho, qué falta, qué no se puede saber antes del silicio

2026-11-23, 18:13 EST (`date`). Inventario, no plan congelado. Cada fila apunta al archivo que tiene el número; aquí no vive
ningún número nuevo. Todo lo "hecho" es **modelo** (SPICE, DRC, aritmética), nunca silicio.

Leyenda: ✅ hecho en el modelo · 🟡 parcial o con veredicto falso pendiente de enmienda · ❌ falta · 🚫 imposible antes del silicio.

## 1. Infraestructura (lo que hace interpretable todo lo demás)

| Bloque | Hecho | Falta antes de fabricar | Imposible antes del silicio |
|---|---|---|---|
| **Núcleo digital** (contador, protocolo, flags) | ✅ 13 pruebas cocotb (solo lógica) · ✅ tile 1×1 con la celda de tiempo: DRC 0, LVS, precheck (`instrument/misfit02/`) | ❌ perfil de corriente por estado (RISKS 2) · ❌ flanco lento de `xa` al sincronizador (RISKS 5) · ❌ `src = 2` en `misfit_cell_slot.v` con la definición nueva, y volver a correr cocotb · ❌ secuencia de 4 estados a potencia constante, si entra XC-52 (W4) | — |
| **Celda de tiempo** (referencia digital, canal 7) | ✅ extraída, dentro del 1,2 % de su esquemático; el RTL la lee dentro de 1 ciclo en todas las fases (MISFIT-02) | — | 🚫 su valor absoluto en el dado |
| **Interruptor de potencia del tile** | 🟡 solo el transistor en esquemático: 1×1 en `tt_power_gate/drops.txt`; la cifra del 1×2 es aritmética (`CANDIDATURA` W2) | ❌ con metal y extraído · ❌ corriente real del tile 1×2 sumando núcleo, slots y, si entra, la bobina | — |
| **Cadena de polarización (VB)** | ✅ usable en 5 esquinas a 27 y 85 °C (`bias_table.txt`) · ✅ ruido 1/f integrado (`xc19_discrim/calc_ruido/integra.txt`) | ❌ **etapa b**: ajuste sin pines analógicos (~10 µs), sin prerregistrar · ❌ Monte Carlo del paso de unidad con desajuste | 🚫 deriva térmica real (RISKS 7) |
| **Decodificador E7** | ✅ simulado dentro del contrato del slot; F5 solo se ve en la corriente del tile (`INFORME_etapa_a.md`) · ✅ sintetizado en el núcleo: tabla E7 9/9 alcanzables y 16/16 en el módulo; entradas quietas en la ventana (MISFIT-04 I2, I3) | ❌ glitches con tiempos reales (I3 es retardo unitario) | — |
| **Integración del tile (MISFIT-04)** | ✅ tile 1×2: DRC 0, LVS match, precheck 15/15 · ✅ extracción plana con acoplo: agresores reales dan 0,0129 % a tt (umbral 0,0807 %), todo de `input3.X` · ✅ campaña de 10 sabotajes (`experiments/misfit04/RESULTADOS.md`) | ❌ testigo S7 cerca del umbral (dio 5,7×, se pedían > 10×) · ❌ un chequeo que vea S2 (VGND del macro cortada, oculta por la fusión de sustrato) · ❌ `input3.X` con la celda real (b4) · ❌ slot en corto que alimenta a sus vecinos (RISKS 3) · ❌ deriva de X en reposo armado (A2) | — |

## 2. Slot XC-19 (lector de una carga)

| Prueba | Estado | Archivo |
|---|---|---|
| DRC (Magic y dos decks de KLayout) y LVS | ✅ P1 | `cells/xc19_slot_core/` |
| Simetría A/B, rechazo de la alimentación en el cociente, 7 fallos inyectados | ✅ P5′, P7, F1–F7 | `experiments/xc19_slot/INFORME_etapa_a.md` |
| Inerte con `en = 0` | 🟡 P2 falsa: fugan los pfet de los inversores; arreglo hvt en la enmienda 2 | ídem |
| Tamaño del paso de calibración | 🟡 P4 falsa a tt (0,17 %); se rediseña la placa | ídem |
| Tiempo absoluto | 🟡 P3 falsa por el ancla del prerregistro, no por el macro | ídem |
| Transitorio de `en = 0` en ff −40 y ss 85 | ❌ no corrió (el simulador no avanza) | ídem |
| Ruido sobre el macro extraído con sus capacidades reales | ❌ (RISKS 10). Hoy está calculado en la cadena, no en el macro | — |
| Monte Carlo de desajuste del macro | ❌ el canal viejo tiene 39 de 100 tiradas (`n5.txt`) | — |
| Precheck | ✅ MISFIT-04 1×2, 15/15 (`experiments/misfit04/i1/`) | — |
| Si existen trampas visibles | 🚫 el modelo no tiene trampas; el salto se inyecta a mano | — |

## 3. Abanico de DUT (C0–C9) y simulador de discriminación

| Prueba | Estado |
|---|---|
| Prerregistro y 3 enmiendas sellados | ✅ `cells/preregistros/XC-19_2026-11-23_discriminacion_abanico*.md` |
| Estimador independiente E_B | ✅ terminado; pasa T1 y los mutantes (`xc19_discrim/eb.txt`) |
| Estimador del autor E_A | ⏳ corriendo |
| Consolidación (diferencia ≤ 0,05 bits) y veredictos PD1–PD5 | ❌ espera a E_A |
| Modelo de qué distingue a C1–C6 (sa, esquina de STI, poly vecina, antena, butted) | ❌ **el simulador solo modela áreas (A1–A8)**; para C1–C6 no hay predicción de en qué difieren `[?]` |
| Layout de C0–C9 detrás de un multiplexor | ❌ |
| Cuánto cambian la corriente y el salto al multiplexar DUT en serie | ❌ (DECISION §3) |
| Fuga de N interruptores abiertos a 85 °C | ❌ (DECISION §3) |
| Densidad real de trampas (λ0) | 🚫 el 1/f del PDK leído como trampas es una conjetura; por eso el prior de b6 |

## 4. Slot de metrología pasiva (devuelve datos aunque no aparezca nada exótico)

| Estructura | Hecho | Falta |
|---|---|---|
| **XC-12, matriz LOD** | ✅ la extracción omite `sa`/`sb`; el modelo separa 31,09 mV; el anotador pasa su CI; el par LOD pasa por la etapa (`docs/CLAIMS.md`) | ❌ layout de la matriz con controles de orientación y proximidad · ❌ su lectura por el mismo lector · ❌ prerregistro de silicio |
| **XC-62, pares de poly densa/aislada** | 🟡 etapa 2: **benchmark inválido** (fallan a2 y a3) · 2b de convergencia prerregistrada, sin correr (~3,8 h estimadas) | ❌ correr 2b · ❌ layout |
| **Tiras Kelvin** (n+, p+, poly, li) | ❌ nada | ❌ diseño y prerregistro, aunque son convencionales |
| **Escalera de capacidades** | ❌ nada | ❌ ídem |
| Residuo de la OPC de la fábrica | — | 🚫 |

## 5. Apuestas exóticas

| Celda | Hecho | Falta antes de fabricar | Imposible antes del silicio |
|---|---|---|---|
| **XC-20, unión p+/n+ a separación 0** | ✅ el precheck la acepta a 0, la rechaza solapada y a 0,13 (`precheck_map`) · ✅ túnel verificado al orden de magnitud (rondas 1–2) · 🟡 motor de hipótesis r3 **no consolidado** | ❌ **lector de rango amplio** (el de precarga satura cerca de 1,25 nA; RISKS 14) · ❌ matriz de separación d × largo de frontera L × área A, con la descomposición área/perímetro en el prerregistro · ❌ layout · ❌ S2 (perfil de implante) y S3 (DEVSIM con túnel), por montar · ❌ anillos de guarda y latch-up (RISKS 12) | 🚫 magnitud del túnel (el perfil de dopado no es público) |
| **XC-14, antena como escritura en fábrica** | ✅ descarga verificada y residuo al orden (ronda 4) · ✅ el precheck no comprueba antena | ❌ prerregistro · ❌ que el reset y la calibración no polaricen el nodo antes de la primera lectura (RISKS 4) · ❌ layout | 🚫 si la carga del plasma queda escrita y sobrevive al recocido |
| **XC-52, espín (con XC-10 para crear trampas)** | ✅ el demodulador de 4 estados no elimina los términos pares (ronda 2) · ✅ bobina 0,373 mT/mA · ✅ candidatura W1–W5 | ❌ W1 diseño de estrés antes/después · ❌ W2 corriente de bobina contra la caída · ❌ W3 lector integrador · ❌ W4 protocolo · ❌ W5 discriminación | 🚫 si los centros Pb responden a ±2 mT a temperatura ambiente |
| XC-01 y XC-05 (constricciones) | ✅ rondas 1–2: puente por barrera, cuello de li | ❌ alimentación y protección aparte para pulsos de mA · ❌ S4 electrotérmica, por montar | 🚫 el estado tras la formación |

## 6. Lo que más información daría antes de fabricar (por bloqueo, no por gusto)

1. **MISFIT-04, integración del tile.** Sin ella no hay chip, y ataca 5 filas de RISKS a la vez (3, 6, 11, 13 y el precheck).
2. **Enmienda 2 del slot XC-19** (P2, P4) y **ruido y Monte Carlo sobre el macro extraído.** Es el lector de todo lo demás.
3. **Consolidar el simulador** y **darle un modelo a C1–C6.** Sin ese modelo, C1–C6 entran en el chip sin una predicción.
4. **Lector de rango amplio para XC-20.** Es lo único que separa a XC-20 del chip.
5. **Etapa b, polarización ajustable.** Sin ella, en ff 85 °C una carga vale menos de una cuenta.
6. **Termómetro en el chip.** No está en ninguna fila y RISKS 7 lo pide: sin él no se pueden separar temperatura y señal.
   Propuesta mía, no decidida.
