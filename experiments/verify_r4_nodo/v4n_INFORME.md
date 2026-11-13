# v4n — Verificación independiente de la ronda 4 (nodo flotante: túnel, antena, TDDB, bomba)

Verificador independiente, 2026-11-13. Cronología (hora de `date`):
- 09:43 inicio; leídos solo `DATOS_PROCESO.md`, los tres `e*_PREREG.md` y modelos del PDK local.
- 10:40:19 escrito `v4n_NUMEROS.md` con todos mis números.
- 10:40:22 empecé a leer `e14_INFORME.md`, `e07_INFORME.md`, `e53_INFORME.md` (y a las 10:41 un grep de `attack_xc58/c58_INFORME.md`).
  No he leído los scripts ni las salidas del agente (`e*.py`, `e*.txt`, `e53_sp/`).

Código propio (todo en esta carpeta): `v4n_tunel.py` (Tsu–Esaki/WKB y Schuegraf–Hu), `v4n_igc.sp` (BSIM4 igc en ngspice),
`v4n_descarga.py`, `v4n_tddb.py`, `v4n_dickson.py` (+ `v4n_dk_*.sp/.log`), `v4n_interruptor.sp`, `v4n_cruce.py`, `v4n_area.py`.
ngspice 44.2 en `hpretl/iic-osic-tools:2025.07`, montando solo esta carpeta y el PDK local en solo lectura.
Literatura: **no leí ninguna fuente en esta sesión**. Los rangos φ_B 3,0–3,2 eV, m_ox 0,40–0,50, QBD 1–1000 C/cm², n = 40–48,
β 1,2–2,5 y la especificación de calificación «10 años / 0,1 % / 0,1 cm² / 1,1·VDD / 125 °C» son **de memoria**.

## Tabla

| # | Afirmación del agente | Mi valor | Veredicto | Causa / explicación aburrida |
|---|---|---|---|---|
| 1 | J(1 V; 4,15 nm) = 6e-14–4e-11 A/cm² (WKB ajustado a Gupta 1997) | Tsu–Esaki: 5,4e-14–5,6e-11. Schuegraf–Hu, mismos φ y m_ox: 1,1e-15–1,1e-12 (≈ 50× menos). BSIM4 igc por defecto: 1,8e-9; con aigc/bigc/cigc de la tarjeta nfet_01v8: 2,5e-9 | **reproducido** con WKB; los otros modelos difieren −1,7 déc (SH) y +1,5 a +4,5 déc (BSIM4) | El intervalo lo pone m_ox (3 déc entre 0,40 y 0,50). El agente ajustó m_ox = 0,27–0,33 con prefactor libre; yo uso 0,40–0,50 con el prefactor físico, y caemos en el mismo intervalo. BSIM4 por defecto está pensado para ~3 nm (toxref) y su V es de puerta, no de óxido: no es un contraste calibrado. «1 V» es V_ox; el nodo puede estar 0–1 V más arriba (banda plana, agotamiento) |
| 2a | Antena 3,3–7 V «cae por túnel en ~1 s» | V(1 s) = 2,53–3,42 V (agente en su informe: 2,7–3,3 V); bajar a 2 V tarda 24 s–1,7e5 s | **reproducido** (con la precisión del informe, no con la del resumen) | Lo que se va en ≤ 1 s es el exceso sobre ~3 V (régimen FN). «Cae en 1 s» sin más sería falso |
| 2b | A 6 meses quedan 0,06–0,74 V, igual a 4 decimales para cualquier V inicial | TE: ≤ 0,005 (descargada)–0,66 V; SH: 0,31–1,31 V. Diferencia entre V0 = 3,3 y 7 V: ≤ 3,2e-8 V | Independencia: **reproducida**. Valor: **al orden**; el extremo inferior no | La independencia no es una casualidad ni requiere cola logarítmica: dV/dt = −J(V)/C es autónoma y unidimensional, así que toda trayectoria es la misma curva desplazada en el tiempo, V(t; V0) = U(t + T(V0)), con T(V0) ≤ ~1 s para V0 ≥ 3,3 V. Δ = |dV/dt|·ΔT ≈ 1e-8 V/s · 1 s. La cola casi logarítmica (0,4–0,5 V por década de t, mío) solo hace que |dV/dt| sea pequeño. El suelo de 0,06 V del agente sale de su supuesto V0 = 0–0,5 V (tensión del nodo que no cae en el óxido): con V0 = 0 y m_ox ≤ 0,45 mi TE vacía el nodo (a baja V el túnel neto es óhmico y la caída es exponencial, τ ≈ 1 mes). El valor depende de la física a < 0,5 V, la menos fiable, y la SILC del propio daño de plasma solo puede acelerarlo |
| 2c | Deriva 0,2–0,9 mV/día | TE 0–1,2; SH 0,60–0,85 mV/día | **al orden** | Es V1/t en la cola; con el nodo ya vacío (algunos TE) la deriva es 0 |
| 2d | Sensibilidad al espesor 0,64–1,53 V/nm; σ = 9–87 mV | r = 1: TE 0–2,63, SH 1,23–1,79 V/nm. σ_tox del PDK = 14 pm (1 µm²)–57 pm (0,063 µm², nfet); σ_V 0–38 mV (1 µm²) y 0–150 mV (0,063 µm²) | **al orden**, intervalo mío más ancho | Supuesto escondido: 0,64 es r = 1 y 1,53 es r = 100, y 87 mV es r = 100 en 0,063 µm². Para r = 1 el agente da 9–36 mV; yo hasta 150 mV en la misma área. Unidades de `toxe_slope` (l, w en µm): las comprobé igual; que sea espesor físico y no un parámetro de ajuste del desajuste de V_T es `[?]` (el agente lo marca) |
| 3 | Puerta 5 V (11,6 nm): J < 1e-15 A/cm² a 5 V, retiene | TE 2,0e-20–2,5e-15; SH 1,2e-21–2,3e-16 (V_ox = 5 V). Con el peor, τ = C·V/J ≈ 6e8 s | **reproducido** en la conclusión; la cota 1e-15 la supera mi esquina φ = 3,0 / m_ox = 0,40 | El modelo del pfet_g5v0d10v5 da toxe = 11,75 nm (casi igual). A 5,5 V mi TE llega a 2,6e-13. «Retiene» frente a túnel: sí; frente a recocido, luz y uniones: no verificado |
| 4a | TDDB a 3,3 V en 4,15 nm ≥ 1e10 s | Ancla QBD (memoria): 7,4e5–2,9e13 s en 1 µm². Ancla de calificación (cota inferior): ≥ 1,2e3 a ≥ 9e16 s según modelo | **no verificable** con lo que tengo; no contradicho | Mis dos anclas son de memoria y dan intervalos de 7–14 décadas. El agente usó un ancla leída a ojo (Samadder & Mahapatra, SISPAD 2023, 4,2 nm, 140 °C, 4,6–5,2 V) extrapolada 1,3 V: la cifra es tan buena como esa figura, que no leí. Su ancla está en V de puerta en inversión, no en V_ox |
| 4b | Ruptura en 1 h con 5,7–7,4 V (1 µm², 27 °C, Ea 0,3–0,8 eV) | V_ox para t63 = 1 h: 4,0 a > 9 V (ancla QBD) | **no verificable**; su intervalo cae dentro del mío | Mi ancla QBD no acota; la del agente sí, pero no la reproduje. Ea 0,3–0,8 eV de 140 a 27 °C son 1,4–3,7 décadas: el factor que más mueve después del ancla |
| 4c | Antifusible rompe en minutos o segundos a 6,5–8 V | Ancla QBD, 1 µm²: 6,5 V 0,39 s–6,6e5 s; 8 V 0,02 s–2e4 s | **no verificable**; además el propio informe del agente da 0,07 s–2e4 s a 7 V en 1 µm² | «Segundos a minutos» solo vale para áreas de 100–1e4 µm² en su tabla; en 1 µm² son hasta horas |
| 5a | Dickson pfet 5 V, pozo a la salida, desde 1,8 V: 8,4 V (N = 6), 10,6 V (N = 8) | Vacío: 8,01 V (N = 6), 10,10 V (N = 8); con 1 µA: 6,73 / 8,58 V (agente 7,20 / 9,22) | **reproducido** (−5 %) | Mi parásita es 10 % (agente 5 %), W = 5 frente a 4 µm, MIM del PDK en vez de C ideal. Elegí: 10 MHz, 2 fases de 45 ns, 1 pF/etapa, C_out 2 pF, carga 0–2 µA, 80 µs, tt 27 °C |
| 5b | Ningún dispositivo pasa de 2,9 V entre terminales | 2,57–2,77 V | **reproducido** | Salvo el pozo contra el sustrato, que ve V_out (10,1 V). Modelo `diode_ps2nw` del PDK: bv = 16,85 V (el agente no encontró la ruptura pozo–sustrato; está en `parasitics/…diode_ps2nw.model.spice`) |
| 5c | 0,7–1,6 µA de salida | R_salida 1,0–1,5 MΩ (N = 4–8), o sea 0,65–1,0 µA por voltio | **al orden** | Supuesto escondido: el informe dice «por voltio de margen bajo el vacío», no µA absolutos. Escala con f·C |
| 5d | ~15 % de una tesela 1×2 | 11–14 % (N = 6), 15–18 % (N = 8), sin trazado | **al orden** | Estimación de ambos, sin layout |
| 5e | Desde 3,3 V: V_GS 5,8 V > 5,5 V | 5,28–5,48 V (con 10 % de parásita) | **no reproducido** como violación: es marginal | Con 5 % de parásita el agente da 5,66–5,79. El margen depende de α = C/(C+C_par): la conclusión «sin margen desde 3,3 V» se mantiene, «viola» no. Desde 3,3 V además el pozo final ve 12,8–17,6 V (N = 4–6), por encima de 11 V: esa razón sí es robusta |
| 5f | (no afirmado) | Fuente p+ en directa sobre su pozo hasta 0,54 V (vacío) y 0,78 V (1 µA) | **hallazgo nuevo** | Con «pozo a la salida» cada fuente p+ queda en directa respecto del pozo en cada impulso: PNP vertical p+/pozo/sustrato activo, que ningún mazo (ni el mío) modela. Puede robar corriente al sustrato y bajar V_out; hay que añadir el PNP del PDK o simular la variante de pozo al máximo |
| 6 | Por debajo de ~1,5 V con interruptor se mide la fuga del interruptor | V_ox de cruce (túnel = interruptor): con 0,66 fA, 2,4–3,3 V en 1 µm², 1,6–2,7 V en 100 µm², 1,0–2,4 V en 1000 µm²; con mi fuga simulada (12–45 fA) 1,8–3,7 V | **reproducido** y conservador | El umbral depende del área de óxido, que la frase omite: para áreas ≤ 100 µm² el interruptor domina hasta 2–3 V. Mi nfet_01v8 0,42/0,15 apagado fuga 12–45 fA (gmin = 1e-20), 20–70× más que los 0,66 fA de c58 (otra polarización, `[?]`); con gmin por defecto (1e-12 S) ngspice da ~1 pA/V, un artefacto que conviene descartar en cualquier medida de fuga simulada |

## Errores míos declarados
- La columna «eficiencia» de `v4n_dickson.txt` sale > 1: mi suma de corrientes de reloj está mal. No se usa nada de ella.
- En `v4n_descarga.txt`, 0,005 V es el límite inferior de la rejilla: significa «descargada», no 5 mV.
- En la bomba, sin carga, V_out aún subía 25–50 mV en los últimos 10 µs (no del todo asentada); con carga, asentada.

## Resumen (≤ 12 líneas)
1. Túnel a 1 V: el intervalo 6e-14–4e-11 A/cm² se reproduce con WKB propio; Schuegraf–Hu da ~50× menos y BSIM4 por defecto 1,5–4,5 déc más. Lo domina m_ox.
2. Antena: «olvida la tensión inicial» se reproduce, pero es trivial (ecuación autónoma 1-D: misma curva desplazada ≤ 1 s), no una propiedad de la cola logarítmica.
3. Residual a 6 meses: al orden (mío ~0–1,3 V); su suelo de 0,06 V depende del supuesto V0; con V0 = 0 el nodo puede vaciarse.
4. Deriva y sensibilidad al espesor: al orden; el rango 9–87 mV mezcla r = 1 y r = 100.
5. 11,6 nm a 5 V: retiene; la cota < 1e-15 la supera una esquina mía (2,5e-15), sin cambiar la conclusión.
6. TDDB (3,3 V ≥ 1e10 s; 1 h a 5,7–7,4 V; antifusible a 6,5–8 V): no verificable sin su figura; no contradicho; mis anclas de memoria son demasiado anchas.
7. Bomba desde 1,8 V: reproducida al 5 % (8,0 / 10,1 V) y ≤ 2,8 V por dispositivo. Pozo–sustrato con bv 16,85 V en el PDK.
8. Desde 3,3 V: V_GS 5,3–5,5 V en mi mazo; «5,8 > 5,5» es marginal y depende de la parásita; el veto robusto es el pozo a 12–18 V.
9. Nuevo: la fuente p+ va 0,5–0,8 V en directa sobre su pozo en cada impulso; PNP vertical sin modelar en ambos mazos.
10. Interruptor: la frase vale y se queda corta; el umbral depende del área y para ≤ 100 µm² es 2–3 V.
11. Ojo con gmin: con el valor por defecto ngspice da ~1 pA/V de fuga ficticia.
