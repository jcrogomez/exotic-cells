# c63 — Prerregistro del ataque a XC-63 (contacto sin implante)
Hora (`date`): Thu Nov 12 19:03:34 EST 2026. Escrito antes de correr sondas, cálculos o búsquedas. Predicciones DE MEMORIA.

## Qué se va a hacer
(a) Sondas gdstk por el mapa del precheck: licon sobre pozo n sin diff/tap; sobre diff en pozo sin implante; sobre tap sin nsdm; licon a caballo del borde de nsdm; tap normal (control). Lectura del tech de Magic (cómo define ndiff/nsd/licon).
(b) Emisión termoiónica con barrera barrida (alturas de la literatura), contacto 0,17×0,17 µm, pozo 5e16–2e17; fuerza imagen; resistencia de dispersión.
(c) grep del PDK por schottky / contactos sobre pozo poco dopado.

## Predicciones
- P63.1 licon sobre pozo desnudo (sin diff): rechazado por al menos una herramienta (Magic no reconoce el contacto o da error de licon; KLayout MR: 50 % de que no diga nada).
- P63.2 diff/tap sin implante: Magic lo rechaza o no lo reconoce como dispositivo; KLayout MR quizá no (50 %).
- P63.3 licon a caballo del borde del implante: rechazado por Magic (cierre de nsdm sobre el contacto); KLayout MR [?].
- P63.4 control tap normal: 0 y 0.
- P63.5 "variante enviable": predigo que NINGUNA de las tres pasa limpia las dos herramientas (70 %).
- P63.6 Barreras (de memoria): TiSi2/n-Si 0,60 eV, TiSi2/p-Si ~0,5; Ti/n 0,50; W/n 0,67; TiN/n ~0,5 [?].
- P63.7 Con 0,60 eV, A*=112 A/cm²K², 300 K: J0 ≈ 8·10⁻⁴ A/cm² → I0 ≈ 0,25 pA en 2,9·10⁻¹⁰ cm²; con fuerza imagen a 1,8 V inversa 0,5–3 pA. Es decir, 2–20 veces el piso de 150 fA: legible pero marginal, y con barrera 0,50 serían ~10 pA–0,1 nA; con 0,67, ~15 fA (bajo el piso).
- P63.8 Caída directa a 1 nA: 0,15–0,25 V; a 1 µA: 0,35–0,45 V. Resistencia serie (dispersión + pozo): 2–20 kΩ; domina por encima de ~10 µA.
- P63.9 El PDK no ofrece diodo Schottky ni contacto legal de metal sobre silicio poco dopado (60 %).

## Tautologías (sin correr)
- Corriente inversa ∝ exp(−Φ/kT): 60 mV de barrera = una década. Sin conocer el metal real de la interfaz ±0,1 eV → ±1,7 décadas: el resultado será un intervalo, no un número.
- La fuga del propio pozo a sustrato (área enorme frente a 0,03 µm²) comparte nodo si se lee por el pozo: la lectura debe hacerse por el lado del contacto.
- Si el contacto lleva siliciuro formado por reacción con Ti, sobre pozo sin implante sigue habiendo siliciuro: la barrera sería de TiSi2, no de W ni TiN.

## Mata / deja viva
- Mata en TT: ninguna variante pasa el precheck (queda para otro vehículo). Mata por física: I inversa << 150 fA en todo el rango de barrera publicado Y caída directa indistinguible de un diodo p-n. Viva: alguna geometría legal o de borde con barrera en el rango legible.
