# v3_VEREDICTO — verificador independiente, ronda 3

Cerrado: Thu Nov 12 19:53:26 EST 2026. Números propios en `v3_NUMEROS.md` (escrito 19:51:52 EST, antes de abrir nada de los agentes).

**Qué leí de los agentes y cuándo** (después de escribir mis números): `attack_xc58/c58_INFORME.md` entero (19:51:58);
`attack_xc57_59_61/c57_INFORME.md`, `c59_INFORME.md`, `c61_INFORME.md`, líneas 1–45 de cada uno (19:52:07);
`attack_xc60_62_63/c60_INFORME.md`, `c62_INFORME.md`, `c63_INFORME.md`, solo las líneas con las cifras de E, F y G (19:52:26). Además vi el listado de
nombres de archivo de las tres carpetas (19:51:52). No abrí sus scripts, salidas ni prerregistros. `v3_post.py` (19:52:54) es posterior a la lectura y lo digo donde lo uso.

| Af. | Predicción | Mi resultado | Veredicto |
|---|---|---|---|
| A1 | 0,963 fF (0,5–2) | 0,82–0,97 fF (lector 0,36; unión 0,22–0,28; solape del interruptor 0,10; hilo 0,14–0,23) | verificada |
| A2 | 1 − 0,85·Cov/C (coef. 0,5–1,2) | 1 − 0,69·n·Cov/C: coef. 0,83–1,04 para n = 1,2–1,5; límite ½ si n·Cov/C ≥ 1; EDO y Monte Carlo coinciden | verificada (el coeficiente es ∝ n, no universal) |
| A3 | T^(−1/2), −0,17 %/K | −0,167 %/K (−0,14 a −0,20 con deriva de n) | verificada |
| A4 | 10 % en C ↔ ±32 K; el cociente cancela T | −27/+33 K (±30 lineal); el cociente da C₂/C₁ | verificada |
| A5 | 10⁶ + 1000×1000 | SP 800-90B §3.1.1 puntos 1 y 3 (y §3.1.4.1), leído | verificada |
| B1 | 0,3–2,2 K | 0,22–6,9 K (w 0,15–1 µm; G' 2,9–8,3 W/mK) | verificada (solapa; mi techo es más alto con poly de 0,15) |
| B2 | 0,3–0,5 K a 60–90 µA; cruce 45–290 µA | Con dos patas n+ (mi supuesto ciego): 0,7–2,4 K a 92–217 µA, cruce 184–435. Con pata p+ de 320 Ω/□ (tras leer): 0,25–0,76 K a 28–88 µA, cruce 56–175 | verificada en existencia y orden; mi cifra ciega era 2–5× mayor por suponer la pata p tan conductora como la n |
| B3 | 0,7–3,4 % | 2D (cota superior) 1,6–11,6 %; unión puntual en 3D 0,2–1,0 % | verificada en orden |
| C1 | 3–8 % (1–15) | 2D 1,1–15,6 %; largo finito 0,2–6 % | verificada |
| C2 | ~74 % (40–95) | 70–77 % (57–66 % si el elemento mide 0,5 µm) | verificada |
| D1 | 10⁻³ a 21–47 K; 4–32 % a 77 K | 45 meV: 37 K y 5,7–6,9 %; con energía rebajada a 20 meV: 18 K y 31–37 % | verificada; estadística dudosa a ese dopado (banda de impurezas, saltos) |
| D2 | 125–240 V/cm, 18–37 K, 5·10¹³ | Lawaetz y Proctor 1980, leído: 10 V ↔ 125 V/cm, figura hasta 19 V; muestra 5·10¹³ | verificada para Si; son campos aplicados, no umbral medido. Ge: no pude (sin fuente primaria) |
| E1 | 1,0 mT; cota 1,76 | 1,25 mT en superficie, 0,99 a 0,5 µm, 0,69 a 2 µm; cota 1,759 | verificada |
| F1 | 0,15 / 0,21 / 0,13 / 0,075 | l. 4338 / 4339 / 4352 / 4341–4344 | verificada |
| F2 | −1,39 mV/nm | −1,81 (vth del modelo) y −1,20 (corriente constante) mV/nm | verificada |
| F3 | la documentación dice OPC en poly | x.1a "p1m.md (OPC)", areaid.op "Block automatic OPC", x.9 serifs; SRAM con OPC. No hay frase literal "se aplica OPC a poly" | verificada como inferencia de tres citas, no como frase |
| G1 | las dos sondas, 0 errores | control 0/0; sin nsdm y como única toma del pozo: **Magic 1 error (nwell.4)**, KLayout 0; con otra toma normal en el pozo, o sobre sustrato: 0/0 | **no verificada tal como está escrita**; sí con una segunda toma |
| G2 | 1,6–11 pA | sin fuerza imagen 0,24–0,77 pA (factor 7–14 por debajo); con ella (2,3–6,5·10⁵ V/cm) 2–25 pA | verificada solo con rebaje por fuerza imagen |
| G3 | cinco celdas fingercap | las cinco, confirmadas; **y dos más**: `05p9x05p9` y `11p3x11p3_…_shieldl1_wafflecap` | verificada, con recuento corregido a siete |
| G4 | "nsd/psd.5b" y "licon.4" | (n/ psd.5b) "Enclosure of tap by nsdm(psdm), except for butting edge" 0,125; (licon.4) "Licon1 must overlap li1 and (poly or diff or tap)"; (n/ psd.9) "Diff and tap must be enclosed by their corresponding implant layers" | verificada; licon.4 por sí sola no lo prohíbe: la regla directa es n/ psd.9 |

## Lo distinto

1. **G1.** Magic no rechaza el contacto: borra la toma sin implante al leer el GDS. Si era la única toma del pozo, el pozo queda sin toma y salta nwell.4
   (y LU.3 si hay difusión p+). "0 errores" exige otra toma normal en el mismo pozo. Consecuencia añadida: extracción y LVS tampoco verán el contacto.
2. **G3.** Siete celdas del PDK, no cinco. Todas sobre sustrato p, ninguna sobre pozo n: el precedente de la fábrica no es el contacto de XC-63.
3. **G2.** La cifra depende del rebaje por fuerza imagen (×8–30) y del dopado de superficie, que no es público. Sin rebaje queda bajo 1 pA.
4. **A2.** El coeficiente 0,85 corresponde a n ≈ 1,23; con n = 1,4 es 0,97. Mi modelo da 0,90–0,91 de kT/C en el nodo mínimo, igual que su Monte Carlo (0,88–0,92)
   y no respalda el 0,68 de ngspice.
5. **B2.** El enfriamiento neto ideal es (S·T)²/(8·k·t·(R_n + R_p)): lo fija la pata más resistiva, no el ancho ni el óxido.
6. **D2.** 125 y 240 V/cm son los pulsos aplicados en ese experimento con 5·10¹³; no se trasladan a un pozo de 5·10¹⁷.
7. **F2.** El umbral baja al alargar el canal (canal corto inverso); por debajo de 0,15 µm el modelo no tiene datos.
8. Montar `local_flow` en solo lectura en Docker lo deja vacío; lo monté en lectura-escritura con `PYTHONDONTWRITEBYTECODE=1` y comprobé con `find -newer`
   que no cambió ningún archivo de `tt-support-tools` ni de `pdk_precheck`.

## Archivos
`v3_PLAN.md`, `v3_NUMEROS.md`, `v3_VEREDICTO.md`, `v3_calc.py` → `v3_salida.txt`, `v3_f2.spice` → `v3_f2_salida.txt`, `v3_g1.py` → `v3_g1_out/`
(`v3_g1_tabla.txt`, `gds/`, `reports/`), `v3_g1.log`, `v3_g1_b.log`, `v3_g3.py` → `v3_g3_salida.txt`, `v3_post.py` → `v3_post.txt`.
