# Exotic Cells · catálogo v0.5 (BORRADOR, 2026-11-11)

> **Borrador histórico.** Superado por el catálogo de [`../../README.md`](../../README.md#catalogue).


Borrador escrito por un agente (chat de Claude) tras las decisiones de Juan del 2026-11-11. **Sin commit.** No sustituye a
`PROPUESTA_CHIP.md` (v0.4 queda como historia) hasta que Juan lo acepte. El catálogo original de 24 candidatos no está en el repo;
este es un catálogo nuevo que conserva el tipo de ideas (nanohoyos, carga individual, magnetismo, optoelectrónica).

## Decisiones de Juan que lo enmarcan (2026-11-11)

- La biblioteca abierta se llama **Exotic Cells**. El chip lleva otro nombre, en inglés, **sin decidir**.
- Repo **público** (open silicon). README, propuesta y filosofía en inglés; notas de trabajo en español.
- Nada a SKY26d. Objetivo: híbrido 2×2 en TTSKY27a (cierre en mayo de 2027, según tinytapeout.com/runs leído el 2026-11-08).
- Se abre v0.5 con cinco islas y cuatro instrumentos (R, I, T, X).
- **Dos zonas separadas:** FÁBRICA (lo que nace en la fundición, nada destructivo) y MESA (transformación con sobretensión o
  corriente, aislada, desmontable si Tiny Tapeout no da permiso).
- Mesa disponible: placa de Tiny Tapeout, multímetro, osciloscopio, fuente-medidor (SMU); algo más si no es difícil.

## Criterio de entrada (palabras de Juan)

Exótico de verdad; basado en un comportamiento normalmente indeseable de la fabricación; repetible; simulable, con el PDK o con
software nuestro. Clase de simulabilidad: **A** = está en los modelos del PDK; **B** = modelo añadido con parámetros de literatura;
**C** = ningún modelo abierto lo predice, solo el silicio responde.

## Zona FÁBRICA

| Id | Celda | Falla que aprovecha | Función buscada | Isla | Instr. | Clase | Estado y fuente |
|---|---|---|---|---|---|---|---|
| F1 | Transistor programado por estrés | Tensión mecánica del STI según largo de difusión | Varios umbrales sin máscara; offset por geometría | P | T | A | Tarjeta local `nfet_01v8__tt` trae `kvth0 = 9.8e-9`, `ku0 = -2.7e-8`, `saref/sbref` (grep 2026-11-11). Sin simular. Si Magic extrae `sa/sb`: `[?]` |
| F2 | Proximidad de pozo | Dopado extra junto al borde del pozo | Umbral según distancia al pozo | P | T | C | BSIM4 ≥ 4.5 lo modela; la tarjeta local no trae `kvth0we` ni `wpemod`. Dato nuevo para el PDK |
| F3 | Antena como escritura de fábrica | Carga de plasma sobre compuerta flotante | Celda que nace escrita | P | T, I | C | Precedente: monitores de carga (US5844300). ¿La borran los pasos térmicos? `[?]` |
| F4 | Antena factorial 2×2 (Grabado) | Daño de plasma en el óxido | Desplazamiento de umbral, trampas creadas | P | T | C | Contrato en v0.4. Señal del orden del desajuste: pide muchas parejas. El precheck de sky130 no revisa antena (precheck.py, 2026-11-08); la fábrica `[?]` |
| F5 | Chispa fría | Unión p+/n+ abutida, fuga y túnel | Diodo de baja tensión, fuente de ruido, emisor | J | I, X | C | d = 0 y ≥ 0,27 µm legales (`macros/chispa/`). El modelo de diodo del PDK no tiene túnel |
| F6 | Trampa (RTN) | Defecto individual en un MOS mínimo | Bit probabilístico; sensor de un defecto | Q | T | B | ΔVth = 0,305 mV; 0,8 % por salto en inversión débil (modelado, `EFLG00_TRAMPA.md`). ngspice trae fuente RTS nativa. Falta la etapa |
| F7 | Photon | Recombinación en unión en directa | Enlace óptico interno | O | I | B/C | Fotodiodo legal, piso 150 fA modelado (`macros/photon/`). Emisión sin evidencia. Predicción escrita: gana la difusión |
| F8 | Transistor de óxido de campo | Parásito bajo STI | Dosímetro, sensor de carga | Q | T | C | 4,4 mV/rad en 0,6 µm sin modificar el proceso (Lipovetzky et al.). Umbral en sky130 `[?]`, quizá > 3,3 V |
| F9 | Calor como canal | Autocalentamiento y difusión térmica | Perilla de temperatura en chip; acoplamiento sin cable | frontera | X | B | Sensor por difusividad en 0,18 µm (TU Delft). Estimación del agente sin verificar: centésimas de kelvin a 20 µm con 1 mW |
| F10 | Hall en pozo n | Pozo como lámina resistiva | Sensor magnético | J | X | B | RSNW 950 Ω/□; µ_H `[?]` (`FRONTERAS_FISICAS_1105.md`). Instrumento, no celda |
| F11 | Nanohoyos metálicos | Aperturas en metal: periódico, desordenado, aperiódico | Filtro óptico, transporte | O | I | B | Paso mínimo 0,28 µm → pico ~0,41 µm (cálculo del repo). Exige luz sobre el dado; QFN cerrado. Entra solo con método de medida |
| F12 | Bipolar parásito y PNPN | Latch-up | Neurona de relajación, NDR | J | X | C | Los bipolares del PDK solo valen en activa directa. Riesgo para el shuttle: aislamiento obligatorio |

## Zona MESA (requiere permiso; desmontable)

| Id | Celda | Falla que aprovecha | Función buscada | Isla | Instr. | Clase | Estado y fuente |
|---|---|---|---|---|---|---|---|
| M1 | Forge met1 A/B/C/D | Electromigración | Resistencia programable, estado kΩ | F | R | C | EFLD-01 verificado: único elemento sobre régimen es el precursor. Tiempo de formación sin modelo |
| M2 | Forge li1 0,29 / 0,17 | Electromigración con más disipación | Igual, a menor corriente | F | R | C | `efld01c_L1` DRC 0, no integrada |
| M3 | Contactos e interfaces | Contacto único frente a redundantes | Interfaz transformable | F | R | C | Hallazgo del repo: con 9 `mcon` el contacto se forma antes que la línea |
| M4 | Transistor de carga atrapada | Portadores calientes (envejecimiento) | Memoria sin máscara, peso analógico | Q | T | B | Precedente en nodos HKMG (tesis UCLA). En óxido de sky130 `[?]`. Pide 3,3 V sobre dispositivo de 1,8 V |

## Expedientes (documentados; sin silicio en esta generación)

| Id | Idea | Por qué espera | Fuente |
|---|---|---|---|
| E1 | Compuerta flotante de un poly | Inyección 4,0 V y túnel 8,0 V: bomba de carga | Georgia Tech, sky130 |
| E2 | Antifusible y LED de filamento | 6 V sobre óxido < 3 nm; sky130 tiene 4,15 nm | `PESCA_PHOTON_1105.md` |
| E3 | Nanogap túnel | Mediana ~10 GΩ: el lector lo ve abierto | `FRONTERAS_FISICAS_1105.md` |
| E4 | Isla de Coulomb (SET) | 22–27 aF → 3,5–4,3 K | mismo |
| E5 | SPAD y avalancha | Tensiones altas | `PESCA_OPTO_1104.md` |
| E6 | Nanoporos reales, coherencia | Posprocesado o criogenia | texto externo del 2026-11-08 |

## Fronteras (acoplamiento entre celdas)

Sin isla propia: parejas en el borde entre zonas, con control inactivo a la misma distancia. Candidatas: F9 → F6 (calor sobre tiempos
de residencia del RTN), F7 → F6 (emisor junto a trampa), M1 → Fantasma (perturbación de la formación).

## Lo que falta antes de dibujar

1. Nombre del chip (Juan).
2. Pregunta a Matt: permiso de estrés para la zona MESA y revisión de antena en fábrica.
3. Un preregistro por celda en `docs/preregistros/` (hoy vacío).
4. Primera corrida: F1 en ngspice (única clase A), con predicción escrita antes.
5. Licencia de hardware abierto y revisión del historial antes de publicar.
6. Área real de un canal por instrumento (R, I, T, X) con el DEF de la plantilla analógica 2×2.

## Correcciones de la revisión externa del 2026-11-11 (aceptadas por el agente; decide Juan)

- **F1 no es programable después de fabricar:** es programación por layout. "Clase A" describe la capacidad de simular, no que sea una
  Exotic Cell; para graduarse debe ofrecer algo que no dé cambiar W/L o de variante de transistor.
- **F1 puede no estar llegando al simulador:** ver `AUDITORIA_LOD_1111_BORRADOR.md` (Magic no emite `sa/sb/sd`).
- **F2:** que la tarjeta no traiga parámetros de pozo justifica medir, no garantiza física nueva. Hay que variar por separado distancia
  al pozo y longitud de difusión.
- **F3/F4:** que el precheck no revise antena no es autorización. Falta leer las reglas de fabricación y la secuencia de capas.
- **Trazabilidad:** 12 + 4 + 6 = 22 entradas frente a 24 de la lista maestra, que no está en el repo. Falta el mapa ID por ID; este
  catálogo no es definitivo hasta tenerlo.
- **Propuesta de la revisión:** no añadir banco; Grabado se divide en G-LOD, G-WPE y G-ANTENNA/G-TRAP. Conservar Yunque como chip y
  usar "Residual" para el motor que compara modelo y silicio. Abrir o no v0.5: lo decide Juan (el 2026-11-11 dijo abrirla).
