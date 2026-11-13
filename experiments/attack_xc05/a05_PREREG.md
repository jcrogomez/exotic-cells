# a05 — Prerregistro del ataque a XC-05 (contacto de pocos canales por electromigración con lazo en el chip)

Hora (`date`): Thu Nov 12 12:35:51 EST 2026. Escrito antes de buscar la pila en la web y antes de correr ningún script. Leído hasta ahora: encargo, PLAN de
XC-05, FRONTERAS (fichas 1–2), LEEME de constricción y de efld_01, README de litho_explore, FILOSOFIA v2, READING 2026-11-12, y dos
greps del PDK (`sky130A.tech` l. 5056–5058: `height allli 0.9361 0.10`, `height allm1 1.3761 0.36`; r+c.model: `tc1rm1 = 3.179e-3`).
Todas las predicciones de abajo son DE MEMORIA o cálculo de servilleta; su único papel es poder fallar.

## Qué voy a calcular y qué predigo

| | Qué | Predicción | Mata | Deja viva |
|---|---|---|---|---|
| a | Pila de met1 (documentación SkyWater; el PDK local no trae barrera, predigo) y resistencia del camino por la barrera sobre un vacío de 10/30/100 nm en línea de 0,14 µm. ρ de barrera barrida 50–400 µΩ·cm, espesor total barrido 20–150 nm | Pila: Ti/TiN bajo el Al y TiN encima, 30–100 nm en total. Derivación: **1–100 Ω**, no kΩ (0,07–0,7 cuadrados × 20–100 Ω/□). El PLAN dice "kΩ": predigo que es peor, 2–4 órdenes por debajo de 12,9 kΩ | Derivación ≤ 1 kΩ en todo el barrido: el escalón de 12,9 kΩ queda como corrección < 10 % sobre el shunt y además el shunt lleva la corriente (no se "para" nada) | Que met1 no tenga barrera conductora continua, o que la derivación sea ≥ 50 kΩ |
| b | Literatura: morfología de vacíos en Al(Cu)/TiN pasivado; contactos atómicos de Al (tensión de rotura, vida a 300 K) | Vacíos de rendija/cuña que cruzan la línea, con la corriente por la barrera (subida de R de %–decenas de %, no abierto). Contacto de un átomo de Al: aguanta < 1 V, y a 300 K vive ms–s sin estabilización mecánica. No encontraré contacto atómico formado en línea enterrada | Fuente leída que diga que el contacto de 1 átomo de Al no aguanta 0,1 V o no vive µs a 300 K | Fuente leída de contactos atómicos de Al estables a 300 K a ≥ 0,1 V |
| c | Térmica propia (diferencias finitas 2D sección + 1D a lo largo). k_ox 1,0–1,4; k_Al 100–237 W/m·K; altura 1,376 µm (PDK) | Línea 0,14×10 µm: τ(63 %) = **0,1–1 µs** (no 10 ns; el "100 nm de óxido" del PLAN es falso: hay 1,38 µm hasta el sustrato), ΔT a 2,06 mA = **1–5 K**. Cuello corto (0,14–0,3 µm) y puente 0,05: τ < 1 ns, dominado por conducción al aluminio ancho; ΔT a 2,06 mA < 20 K | "~10 ns" muere si τ de la línea > 100 ns. No mata la idea: 1 µs sigue siendo ≪ ms | τ entre 3 y 30 ns: "~10 ns" se sostiene |
| d | Korhonen 1D propio; D_a barrido (E_a 0,5–0,9 eV, D0 barrido), Z* 1–10, B 30–100 GPa, σ_crit 100–600 MPa | A 300 K + ΔT de (c): **años a nunca**. jL = 4,2e6 A/cm² × 10 µm = 4200 A/cm, en el borde del umbral de Blech (1000–6000 A/cm de memoria): la línea de 10 µm es marginal, y los cuellos de ≤ 1 µm y el puente de 0,05 µm son **inmortales por Blech** (σ_max < σ_crit) a cualquier corriente que no los funda | t_nuc > 1 año en todo el barrido razonable a T real, o σ_sat < σ_crit: la "forja por EM" con 2,06 mA no existe; solo queda fusión | t_nuc < 1 día en una parte creíble del barrido |
| e | Lazo: R(t) con dR/dt ∝ exp(-Ea/kT_cuello), T_cuello = T0 + θ·P, fuente de 1,8 V con R_fuente; corte con retardo 1 ns/100 ns/10 µs/1 ms; parada pasiva con R serie y con shunt | La decide la **tensión**, no el retardo: con 1,8 V rígidos, al subir R la tensión sobre el contacto → 1,8 V y ningún retardo ≥ 1 ns deja < 100 kΩ si el umbral se pone en kΩ; con tensión limitada a ≲ 0,3 V sobre el contacto, hasta el lazo de ms sirve. R serie NO limita la tensión sobre el contacto cuando R_c ≫ R_s; un shunt en paralelo sí (pero es justo lo que tapa el escalón) | Si con 1,8 V el lazo de 1 ns para en kΩ y el de 1 ms no, el PLAN tiene razón | — |
| f | Lector: interpolar período(R) con los tres puntos del LEEME | 4,3 / 6,5 / 12,9 kΩ → ≈ +14 % / +21 % / +40 % de período; pasos > 5 %: **se distinguen** (sin shunt y con canal calibrado). Con shunt de 100 Ω en paralelo: diferencia < 0,02 % → no | Diferencias < 1 % entre escalones | Diferencias > 5 % |
| g | Isla de 2 nm: C = 4πε0·εr·r, E_C = e²/2C | Con diámetro 2 nm (r = 1 nm), εr 3,9: 0,43 aF y 184 meV. Los 0,9 aF / 92 meV salen con **radio** 2 nm (diámetro 4 nm). Cuenta de autocapacidad correcta salvo el factor radio/diámetro; C_Σ real mayor (electrodos a ~1 nm) | — | — |

## Qué mataría la idea completa
1. (a) derivación por barrera ≪ 12,9 kΩ **y** (b) la barrera no migra: en met1 intacto no hay régimen legible de pocos canales. Muere "en met1 con barrera"; quedaría buscar una capa sin barrera o romper la barrera (y entonces es fusión, no EM).
2. (d) sin nucleación en tiempo útil a la corriente disponible, y (c) sin calentamiento que la acelere.
3. (e)+(b) si 1,8 V sobre un contacto de un átomo lo destruye siempre, y no hay forma de limitar la tensión sin tapar la lectura.

## Qué la dejaría viva
Una región de parámetros donde: derivación ≥ 50 kΩ, nucleación en < horas, tensión sobre el contacto limitable a ≲ 0,3 V con lectura posterior sin shunt.

## Tautologías (se deducen sin correr)
- Una derivación R_b en paralelo acota R_total ≤ R_b. Si R_b < 1 kΩ, el lector (piso 1 kΩ) ni siquiera ve el suceso.
- Con fuente de corriente I y shunt R_b, la tensión sobre el contacto ≤ I·R_b: 2,06 mA × 50 Ω = 0,1 V. El shunt es a la vez el que tapa y el que protege.
- Divisor: V_c = V·R_c/(R_c+R_s) → V cuando R_c ≫ R_s. Una resistencia en serie no protege un contacto de kΩ salvo que R_s ≫ R_c (y entonces el lector lee R_s).
- La potencia en el contacto con fuente de Thévenin es máxima en R_c = R_s y vale V²/4R_s.
- Blech: σ_max = (eZ*ρ j L)/(2Ω) no depende de la difusividad; solo j·L. Para el puente de 0,05 µm, jL = 1000 A/cm exige j = 2e8 A/cm².

## Criterio de abandono
Si (a) no se puede anclar en fuente leída (pila con espesores), barro y lo declaro `[?]` sin más de 6 búsquedas. Modelos: un script por letra, sin iterar más de dos veces sobre parámetros tras ver el resultado; lo que cambie tras ver, se marca "exploratorio".
