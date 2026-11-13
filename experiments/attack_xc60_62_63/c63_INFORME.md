# c63 — Informe del ataque a XC-63 (contacto sin implante)
Cerrado: Thu Nov 12 19:16:33 EST 2026 (hora de `date`). Prerregistro: `c63_PREREG.md`. Todo es modelo, lectura del PDK y DRC: nada medido en silicio.

## Resultado contra predicción
| # | Predicción | Resultado | |
|---|---|---|---|
| P63.1 | licon sobre pozo desnudo: lo rechaza alguna herramienta | Pasa Magic y KLayout (0/0). Magic lo ignora: el `.mag` leído no contiene el contacto | **fallada** |
| P63.2 | diff/tap sin implante: Magic lo rechaza o no lo reconoce | Pasa las dos. Magic lee la `diff` sin implante como **pdiff** (tech l. 2691–2696) y la `tap` sin implante lejana **no la lee** | fallada en "rechaza"; cumplida en "no lo reconoce" |
| P63.3 | licon a caballo: rechazado por Magic | licon.1 (Magic parte el contacto por el borde del implante); KLayout 0 | cumplida |
| P63.4 | control: 0 y 0 | 0 y 0 | cumplida |
| P63.5 | ninguna variante pasa limpia | **Cinco pasan**: licon desnudo, tap sin implante (pozo n y sustrato), diff sin implante en pozo n, y tap medio implantada con el licon 0,3 µm fuera del implante (pozo n y sustrato) | **fallada** |
| P63.6 | barreras de memoria | TiSi2/n 0,57 (resumen leído); TiN/n 0,49 (resumen leído); W/n 0,65 (resumen leído); Ti/n sin confirmar | cumplida en lo leído |
| P63.7 | 0,60 eV → 0,5–3 pA a 1,8 V | 1,6–3,4 pA (5e16–2e17) | cumplida |
| P63.8 | Vf 0,15–0,25 V a 1 nA; 0,35–0,45 a 1 µA; R 2–20 kΩ | 0,18–0,19; 0,37–0,38; dispersión 1,3–3,3 kΩ + pozo 1–5 kΩ | cumplida |
| P63.9 | el PDK no ofrece nada parecido | No hay Schottky documentado; pero 5 celdas del propio PDK llevan licon sobre tap sin implante (lado p) | cumplida a medias |

## (a) Mapa del precheck (`c6x_drc_out/map.txt`, corrida propia; mismas funciones que `precheck_map`)
| Sonda | Magic | KLayout MR | Qué cree Magic que hay (`c63_magic_read/*.mag`) |
|---|---|---|---|
| tap n+ normal (control) | 0 | 0 | nsubdiff + contacto |
| licon + li sobre pozo n, sin diff ni tap | 0 | 0 | nada: el contacto desaparece |
| tap sin implante, lejos de otra toma (pozo n / sustrato) | 0 | 0 | nada: tap y contacto desaparecen |
| tap sin implante a 0,27 de la toma implantada | nsd.10b | 0 | la adopta como nsd por cercanía (l. 3019–3024, `nsdexpand` = 0,5 µm) |
| diff sin implante en pozo n | 0 | 0 | **pdiff** sin contacto |
| diff sin implante en sustrato | LU.3 ×8 | 0 | pdiff (y entonces pide toma n) |
| licon a caballo del borde de nsdm | licon.1 | 0 | medio contacto |
| tap medio implantada, licon fuera (0,3 µm) y otro dentro | licon.7 | 0 | (error por mi li, no por el implante) |
| tap medio implantada, **solo** el licon de fuera (pozo n / sustrato) | 0 | 0 | **nsubdiff + nsubdiffcont**: para Magic es una toma normal |

Por qué pasan: el deck `sky130A_mr.drc` solo comprueba anchos y separaciones de difftap/nsdm/psdm/licon (l. 399–447, 555–635); no tiene licon.4 ni el cierre del implante. Magic deriva el tipo de la capa activa del implante (`ndiff = DIFF and NSDM`, l. 2432–2447; `nsd = TAP|DIFF and NSDM and NWELL`, l. 2796–2805) y lo que no encaja lo reinterpreta o lo descarta sin error. El deck completo `sky130A.lydrc` sí tiene n/psdm.5a/5b y licon.4 (l. 350–351, 368), pero el precheck no lo usa; no lo corrí sobre estas sondas `[?]`. La documentación de SkyWater sí lo prohíbe (licon.4; n/psd.5b: tap encerrada por su implante — leído por subagente).

**Dos avisos físicos que no estaban en el prerregistro.** (1) Sin `diff`/`tap` no hay silicio expuesto: es óxido de aislamiento. El "licon sobre pozo desnudo" es un contacto sobre óxido, o sea nada. La estructura con sentido es **zona activa sin implante**. (2) "Pasa el precheck" aquí es "precheck incompleto": la regla escrita lo prohíbe. Por la propuesta v2 (un precheck incompleto no concede autorización) es borde no comprobado, no geometría legal. Decide Juan/la fundición, no el DRC.

## (b) Qué interfaz sería (`c63_barrera.py` → `c63_barrera.txt`; fuentes en `c63_lit_barreras.txt`)
| Dato del PDK | Evidencia publicada leída | Parámetro supuesto | Resultado de simulación | Conclusión física |
|---|---|---|---|---|
| licon 0,17×0,17 (l. 4447); contacto a difusión 185 Ω; pozo 950–1700 Ω/□ | TiSi2/n-Si 0,57 eV; TiN/n 0,49; W/n 0,65; al formar el siliciuro la barrera del Ti cambia <0,1 eV (resúmenes, por subagente) | Interfaz = TiSi2 (inferencia de DATOS_PROCESO); barrera barrida 0,45–0,70; dopado 5e16–2e17; A* 112 (fragmento) | Inversa a 1,8 V y 27 °C: **0,03 pA (0,70 eV) – 1 nA (0,45 eV)**; con 0,57–0,60: 1,6–11 pA = 10–70× el piso de 150 fA. A 85 °C ×40. Directa: 0,15–0,19 V a 1 nA, 0,33–0,38 V a 1 µA; serie 2,3–8 kΩ manda sobre ~30 µA | Rectifica si la barrera está en 0,5–0,65. 60 mV de barrera = una década: sin saber el metal no hay número |

- **Lector de precarga (150 fA):** lee la inversa en todo el rango salvo barrera ≥ 0,67 eV (W directo sobre silicio, que no es lo inferido). Con 9 contactos en paralelo gana ×9.
- **Lector de umbral:** la caída directa a corriente fija (cientos de mV, ~0,25–0,35 V menos que un p+/pozo n) es enorme frente a 0,305 mV: se lee sobrada. La barrera sale de la pendiente con la temperatura.
- No modelado: túnel (E00 = 2,4–4,7 meV ≪ kT: pequeño), concentración de campo en el borde del contacto (sube la inversa), dopado de superficie del pozo distinto del de volumen, y si la zona sin nsdm recibe algún otro implante (LDD/ajuste de umbral) `[?]`.

## (c) ¿El PDK ya ofrece algo parecido? (`c63_pdk_scan.py` → `c63_pdk_scan_pr.txt`)
- Diodo Schottky: **no**. `grep -i schottky` en el tech de Magic y en los modelos: 0 resultados; los diodos de `sky130_fd_pr` son todos p-n (pd2nw, pw2nd, ESD, parásitos de los de 20 V).
- Pero de las 290 celdas de `sky130_fd_pr.gds`, **5 llevan licon sobre `tap` sin nsdm ni psdm**: los condensadores `cap_vpp_02p7x{06,11,21,41}p1_m1m2m3m4_shieldl1_fingercap` y `cap_vpp_02p9x06p1_…fingercap2` (28–202 contactos cada una, fuera de pozo n, celda sin ninguna capa de implante). Es metal sobre sustrato p sin implante dibujado por la fábrica. No demuestra que sea una barrera (puede que la máscara de implante se genere aparte, o que a la fábrica le dé igual en un blindaje) — pero **sí es una estructura de la fábrica con esa geometría**, y es instanciable tal cual. Un solo agente, sin verificar.
- Transistor de drenaje extendido / 20 V: el drenaje se contacta con n+ sobre el pozo; no encontré contacto a pozo sin implante.

## Veredicto por sub-afirmación y por escenario
| Sub-afirmación | Veredicto |
|---|---|
| "Un contacto sobre pozo sin n+ rectifica" | **SOBREVIVE como hipótesis** si la interfaz es TiSi2/Ti/TiN (0,49–0,60 eV): 10–700× el piso. **No legible en inversa** si fuera W directo o barrera ≥0,67. Dato que decide: qué metal toca el silicio y el dopado de superficie |
| "La biblioteca siempre pone el implante" | **FALSA en 5 celdas** del PDK (lado p) |
| "Probablemente lo rechaza una regla" (plan 5.1) | Regla escrita sí; **el precheck no**. TRANSFORMADA: no es "enviable/no enviable" sino "pasa el precheck violando una regla que nadie comprueba" |
| Fallo: "contacto abierto" | Solo en la variante sin zona activa (contacto sobre óxido) |

**Mapa de tres regiones.** Parámetro 1: distancia del licon al borde del implante dentro de una misma toma (−0,125 normal → 0 → +0,3 µm fuera). Convencional: licon dentro del implante. Tercera: licon fuera, sobre activa sin implante, con la parte implantada como retorno óhmico a ≥0,3 µm. Fallo: sin activa (óxido) o barrera tan baja/dopado tan alto que es óhmico. La frontera real la pone la difusión lateral del implante (~0,1 µm, unión 0,1 µm leída) `[?]`. Parámetro 2: altura de barrera (no dibujable).

## Configuraciones que más información darían
1. **Toma n+ medio implantada con licon a 0,3 / 0,15 / 0 / −0,125 µm del borde del nsdm** (la última es el gemelo óhmico), en pozo n; mismo barrido en sustrato con psdm. Cruza la frontera con una sola dimensión. Estado: pasa el precheck, viola n/psd.5b: necesita decisión de Juan.
2. **La celda `cap_vpp_…_shieldl1_fingercap` del PDK** usada como dispositivo: medir I-V entre su blindaje (li sobre tap sin implante) y una toma p+ vecina. Es celda de la fábrica: la variante menos discutible.
3. 1 y 9 contactos, para separar área de perímetro (el borde del contacto concentra campo).
