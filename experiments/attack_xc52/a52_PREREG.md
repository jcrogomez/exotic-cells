# a52 · Prerregistro del ataque a XC-52 (+XC-56, XC-25)

Hora de `date`: 2026-11-12 12:35:44 EST. Escrito ANTES de correr nada y antes de buscar la literatura. Hasta aquí solo he leído el encargo, los
PLAN.md (xc52, xc56, xc25 "Replanteo", xc43), FILOSOFIA v2, PIPELINE, PLANTILLA y READING (2026-11-12). No he abierto el PDK.
Todas las predicciones de este archivo son **DE MEMORIA** o **cálculo mental**; su único papel es poder fallar.

## Qué voy a hacer y qué predigo

### (a) Magnitud real en Si/SiO2 (lectura; ataque principal)
Buscar y leer Moxim/Ashton/Lenahan/Harmon/Flatté/Anders/Cochrane sobre NZFMR, SDR (DC-IV) y SDCP en MOSFET de silicio.
- P-a1: en silicio (no SiC) el ΔI/I a temperatura ambiente publicado está entre 1e-5 y 1e-3; no hay 1 %.
- P-a2: la escala de campo (semianchura) es 0,1–1 mT y satura por debajo de ~3 mT.
- P-a3: TODOS los dispositivos de Si con señal publicada están irradiados (gamma, Mrad) o estresados (Dit >= 1e11 cm-2 eV-1);
  no encontraré una medida en un MOSFET virgen pasivado.
- P-a4: la corriente medida es recombinación de diodo con puerta (DC-IV) o fuga por trampas (SILC); el bombeo de carga
  dependiente de espín a campo casi nulo solo estará demostrado en SiC.
- Mata: ΔI/I(Si, 300 K) < 1e-6 leído, o efecto solo a campos > 10 mT. Deja viva: >= 1e-5 a < 3 mT en algún Si MOSFET.

### (b) Bobina (Biot–Savart propio + PDK)
- P-b1: met3/met4 ancho/sep. mínimos 0,3/0,3 µm, espesor ~0,85 µm, ~47 mΩ/□; alturas sobre el silicio ~2,8 y ~4,0 µm (memoria).
- P-b2: 5 vueltas con radio medio 10 µm: 0,25–0,31 mT/mA en el plano del silicio (la fórmula de espira da 0,314). El campo
  de 3 mT a 10 mA se sostiene COMO CAMPO.
- P-b3: NO se sostiene como corriente: el límite de electromigración es ~1 mA/µm de ancho (memoria), así que 10 mA en CC
  piden ~10 µm de ancho; con ancho mínimo son ~30x el límite. Con traza conforme al límite el campo en CC queda <= 1 mT.
- P-b4: uniformidad: < 5 % sobre 1x1 y 3x3; 10–30 % sobre 10x10 con radio interior 10 µm.
- P-b5: calentamiento del silicio bajo la bobina a 10 mA: 0,1–3 K.
- Mata XC-56: B < 0,3 mT alcanzable dentro de cualquier régimen de corriente defendible. Viva: >= 1 mT pulsado.

### (c) Explicación aburrida cuantificada
- P-c1: fem en lazo de 10x10 µm a 3 mT: ~0,2 µV (100 kHz), ~2 µV (1 MHz), ~20 µV (10 MHz).
- P-c2: acoplo capacitivo sin blindaje (≈1 fF, ≈0,5 V en la bobina): ~nA a 1 MHz, es decir >= 100x una señal de 1e-4 sobre
  16 nA (1,6 pA). Con blindaje baja >= 100x.
- P-c3: el enemigo real es TÉRMICO y es PAR en la corriente, igual que la señal: la paridad no lo separa. La recombinación
  sube ~7 %/K; un ΔT síncrono de 0,1–1 K da 1e-2–1e-1, mayor que la señal. La constante térmica local (~µs) no lo filtra.
  La bifilar es imprescindible, no opcional, y debe igualar la potencia a mejor que la señal/efecto térmico.
- Mata: ningún control separa lo térmico a 1e-4. Viva: existe un esquema (potencia constante, campo conmutado) que lo hace.

### (d) Bombeo de carga a 1,8 V
- P-d1: Dit de óxido pasivado moderno: 1e9–1e11 cm-2 eV-1, típico ~1e10; Icp(10x10, 10 MHz) = 1–100 nA; (1x1, 1 MHz) = 0,1–10 pA...
  en torno a 1 pA (≈ decenas de trampas).
- P-d2: |Vfb − Vth| ≈ 1,3–1,5 V; un pulso de 1,8 V cruza de acumulación a inversión con margen <= 0,3 V por lado si el cuerpo
  está a la tensión justa; nfet sobre sustrato a 0 V NO cruza (no llega a acumulación); solo pfet en pozo propio.
- P-d3: alternativa: diodo con puerta (DC-IV); corriente de pico ~pA para 10x10 µm con Dit=1e10: 1e3–1e4 veces menor que el bombeo.

### (e) Ruido / detección síncrona (simulación propia)
- P-e1: solo disparo, 16 nA, modulación cuadrada, 5 sigma: 1e-3 en ~1 ms; 1e-4 en ~0,1 s; 1e-5 en ~10 s.
  "Milisegundos" para 1e-4 FALLA por ~100x aun sin 1/f.
- P-e2: con 1/f, si f_mod > esquina no cambia; si f_mod < esquina el tiempo deja de bajar (piso). Para 1 pA (1x1) 1e-4 pide horas.

### (f) Hall
- P-f1: V_H = G·µ_H·R_hoja·I·B: con 950 Ω/□ y µ_H 0,05–0,10 m²/Vs, G≈0,7: 33–67 µV por mA y mT; a 3 mT: 0,10–0,20 mV/mA.
  La cifra de 0,2 mV/mA es el borde alto y además depende de los 3 mT de (b).
- P-f2: offset sin corriente rotatoria 1–10 mV (0,1–1 % de la caída), 10–100x la señal; la modulación de la bobina lo evita.
- P-f3: 0,2 mV < 1 paso (0,305 mV): no se lee en una conversión; se lee promediando.

## Tautologías (se deducen sin correr)
- Si el efecto es par en B y la bobina se modula con corriente bipolar, la señal aparece a 2f y la inducción a f. Con modulación
  unipolar (0→I) ambas están a f. No hace falta simular eso.
- El calor Joule va con I², par: la inversión de corriente NO separa el calor. Solo la bifilar (o equivalente) lo hace.
- ΔI/I no depende del área; el tiempo de promediado sí (∝ 1/I ∝ 1/área).
- V_H por mA y mT = G·µ_H·R_hoja: fijada R_hoja por el PDK, el barrido de dopado/espesor solo entra por µ_H(N).
- Si las trampas vírgenes son 1e10 cm-2, un transistor de 1x1 µm tiene ~100: la señal absoluta es 1e-4 × 100 q·f = fracción de carga por ciclo.

## Criterio de abandono
Si (a) no da ninguna cifra de Si a 300 K tras leer >= 4 fuentes primarias, lo declaro `[?]` y no sigo buscando; el resto se
calcula con la señal barrida 1e-5…1e-2.
