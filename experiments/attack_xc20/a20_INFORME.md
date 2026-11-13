# a20 · Informe del ataque a XC-20 (unión túnel de silicio)

Hora (`date`): Thu Nov 12 12:59:41 EST 2026. Prerregistro: `a20_PREREG.md` (12:36). Todo número lleva grado: **PDK** (ruta en `a20_pdk.txt`),
**corrida** (script), **leída** / **no leída** (fuente), **memoria**, **cálculo**.

Aviso de modelo: las corrientes salen de Poisson 1D con Fermi-Dirac más túnel por camino no local (WKB de dos bandas) con el
prefactor y el campo característico de Hurkx (A = 4e14, F0 = 1,9e7 V/cm: **memoria**, artículo no abierto). Validado contra el
límite de campo uniforme (cociente 1,00–1,05, `a20_abrupta.txt` §1). Sin trampas, sin estrechamiento de banda, sin 2D. Las
corrientes absolutas llevan ≥ 1 orden de incertidumbre (con F0 = 3e7 bajan 1–2 órdenes, `a20_mapa_F03e7.txt`); las fronteras
del mapa se mueven menos. Área de frontera supuesta: 1,4 µm × 0,12 µm = 1,68e-9 cm² (0,12 µm es `sd_impl_depth` del script
de sección de KLayout, ilustrativo; la documentación da XJ = 0,1 µm, leída por el subagente).

## 1. Veredicto por sub-afirmación

| | Sub-afirmación | Veredicto |
|---|---|---|
| a | "d = 0 puede ser un cable (siliciuro)" | **No muere, no cerrada.** Toda la evidencia indirecta dice unión y no cable; no hay cita textual del proceso |
| b | Aritmética del plan (5 nm / 4 MV/cm; 17 nm / 1,3 MV/cm; 6–7 órdenes) | **SOBREVIVE** con matiz: los órdenes son 4,5 a 8,5 según modelo y tensión; y el umbral es doble (exponente y degeneración) |
| c | "p+ y n+ pegados forman una unión túnel" | **SOBREVIVE** como túnel inverso (Zener blando / backward) en d = 0. **Resistencia negativa: TRANSFORMADA** en apuesta estrecha: pide G ≤ 10 nm/década y pico ≥ 1e20, y solape, no hueco |
| d | El PDK acota los dopados | Acota el pozo (4–6e16) y nada más: `nsd = 1e20` y `xj = 1,5e-7` son valores por defecto de BSIM4 |
| e | "dos en serie dan un biestable legible en digital" | **TRANSFORMADA.** La corriente sobra; el biestable existe con PVR > ~1,3; pero la excursión es 0,1–0,4 V alrededor de 0,1–0,3 V: un inversor de 1,8 V no la lee, hace falta comparador o seguidor |
| f | "nadie lo ha hecho" | **Falso a medias.** Koga y Toriumi lo hicieron con implantes (no en fundición). En fundición con implantes S/D: sigue sin encontrarse |

## 2. (a) ¿Unión o cable?

- Hoja de difusión n+ 120 Ω/□ (108–132 en esquinas), p+ 197 Ω/□ (166–228), poly 48,2 Ω/□: **PDK**, `sky130A.tech` líneas
  5106, 5107, 5119, 5154–5155, 5202–5203. Con siliciuro autoalineado serían < ~15 Ω/□ (**memoria**). Son valores de silicio
  sin siliciuro.
- `silicide` solo aparece en el tech como estilo de dibujo de las resistencias de poly (líneas 493, 494, 563): **PDK**.
- La sección `connect` (líneas 668–682) une `nsd` con el pozo n y `psd` con el pozo p, pero **no** une `pdiff` con
  `nsd`: Magic extrae la unión pegada como dos nodos. **PDK**.
- `licon.5b` (líneas 4505, 4507): el contacto de la toma debe quedar a ≥ 0,06 µm de la difusión pegada: el licon no puede
  montar sobre la frontera. `diff/tap.4`, `psd.5a/b`, `nsd.5a/b`, `diff/tap.5` regulan la unión pegada como construcción
  normal. **PDK**.
- Las celdas hd y hvl no tienen ninguna toma pegada a difusión contraria (0 de 446 y 0 de 71); en `sky130_fd_pr` sí: 81
  celdas, entre ellas los `rf_nfet_01v8_b*` (fuente y cuerpo pegados). **Corrida** `a20_butting_hd.py`. La fundición usa
  la unión pegada, siempre con los dos lados al mismo potencial.
- Documentación de SkyWater (subagente, **leída** vía resumidor): ninguna página dice "silicide" ni "salicide"; no hay
  máscara de bloqueo de siliciuro. Regla difftap.12 (sin comprobación): "ESD_nwell_tap is considered shorted to the abutting
  diff": ambigua (convención de LVS o corto físico). Tim Edwards, **no leída** (fragmento): no hay capa de bloqueo y el poly a
  ~50 Ω/□ no es de siliciuro.
- **Lo que falta:** una frase del proceso. El siliciuro bajo el licon (Ti del licon) existe `[?]` y no llega a la frontera por
  `licon.5b`. Queda como explicación aburrida viva con probabilidad baja; el control del plan (temperatura y d = 0,27) la
  separa.

## 3. (b) Aritmética (`a20_abrupta.py` → `a20_abrupta.txt`)

| N (cm⁻³) | W fórmula (nm) | Emax fórmula (MV/cm) | Emax Poisson | Fermi dentro de banda p / n (meV) | J inversa 0,1 V | J inversa 1,8 V | J pico directa (A/cm²) |
|---|---|---|---|---|---|---|---|
| 1e19 | 16,6 | 1,29 | 1,25 | −45 / −43 (no degenerado) | 2,2e-7 | 4,5 | 0 |
| 3e19 | 9,9 | 2,30 | 2,22 | −12 / −9 | 5,3e-2 | 9,9e2 | 0 |
| 5e19 | 7,8 | 3,02 | 2,91 | +6 / +8 | 2,0 | 6,1e3 | 1,8e-2 |
| 1e20 | 5,7 | 4,38 | 4,20 | +34 / +38 | 75 | 4,4e4 | 4,6 |
| 3e20 | 3,5 | 8,07 | 7,57 | +104 / +110 | 3,7e3 | 4,7e5 | 1,2e3 |

Todo **corrida**. Los números del plan se sostienen (plan: 5 nm / 4 MV/cm y 17 nm / 1,3 MV/cm). El cociente del factor
exponencial 1e20/1e19 es 10^4,5 con F0 de Hurkx y 10^7,2 con el 3e7 del plan (que equivale a masa reducida 0,40 m0; Hurkx,
0,16 m0). La corriente completa cambia 10^8,5 a 0,1 V y solo 10^4 a 1,8 V. El umbral que no está en el plan: por debajo de
~4e19 las bandas no se solapan en equilibrio y el pico en directa es exactamente cero, sea cual sea el exponente.

## 4. (c) Mapa de regiones (`a20_perfil.py` → `a20_mapa_base.txt`, `a20_mapa.png`; 352 celdas)

Perfil de cada borde de máscara: pico/(1 + 10^(x/G)); p+ a la izquierda, n+ a la derecha, pozo n de 6e16 de fondo.
r = Nn/Np. Clases: **O** ordinario (túnel bajo el piso de 150 fA hasta 1,8 V), **Z** túnel inverso legible solo a 1,8 V,
**B** backward (inversa a 0,1 V > 10 × directa a 0,1 V), **N** pico de túnel en directa sobre piso y difusión (sin contar
exceso), **N+** pico ≥ 1 A/cm². Recuento: O 198, Z 97, B 31, N 20, N+ 6. Ninguna celda cuasi-óhmica.

r = 2 (n+ más fuerte que p+, el caso creíble):

| Np / G | −100 | −50 | −30 | **0** | +30 | +50 | +100 | +200 | 240 | **270** | 300 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1e19 / 5–20 | Z | Z | Z | Z | O–Z | O | O | O | O | O | O |
| 1e19 / 50 | O | O | Z | Z | Z | O | O | O | O | O | O |
| 3e19 / 5 | B | B | B | B | Z | O | O | O | O | O | O |
| 3e19 / 10 | Z | Z | Z | B | Z | O | O | O | O | O | O |
| 3e19 / 20–50 | Z | Z | Z | Z | Z | Z | O–Z | O | O | O | O |
| 1e20 / 5–10 | N | N | N | N | Z | O–Z | O | O | O | O | O |
| 1e20 / 20 | B | B | B | B | B | Z | O | O | O | O | O |
| 1e20 / 50 | Z | Z | Z | Z | Z | Z | Z | O | O | O | O |
| 3e20 / 5 | N+ | N+ | N+ | N+ | Z | O | O | O | O | O | O |
| 3e20 / 10 | N | N | N | N+ | B | Z | O | O | O | O | O |
| 3e20 / 20 | N | N | N | N | N | B | Z | O | O | O | O |
| 3e20 / 50 | B | B | B | B | B | B | Z | Z | O | O | O |

Fronteras (parámetro: gradiente neto en la unión, que en d ≤ 0 va como Np/G):
- **Ordinario → túnel inverso:** en d ≤ 0 se cruza con Np ≥ 3e19 para cualquier G ≤ 50. En d, la frontera cae entre +30 y
  +100 nm (+200 solo con 3e20 y G = 50): **dentro de la banda ilegal 0 < d < 0,27 µm**. En d = 0,27 todo es ordinario
  (J ≤ 4e-9 A/cm² a 1,8 V en todas las celdas).
- **Túnel inverso → backward:** camino de túnel en equilibrio ≲ 12 nm (Np/G ≳ 5e18 por nm/década).
- **Backward → pico en directa:** camino ≲ 9 nm y las dos caras degeneradas ≥ ~20 meV: 1e20 con G ≤ 10, o 3e20 con G ≤ 20.
- **Corto:** no aparece por túnel; solo por siliciuro (§2).

Números de la celda legal d = 0, r = 2 (**corrida**): 

| Np / G | camino (nm) | Emax (MV/cm) | I inversa 0,1 V | I inversa 1,8 V | I pico directa |
|---|---|---|---|---|---|
| 3e19 / 50 | 54 | 0,74 | 2e-19 A | 0,29 nA | — |
| 3e19 / 20 | 22 | 1,02 | 3e-15 A | 16 nA | — |
| 1e20 / 50 | 17 | 1,14 | 47 fA | 56 nA | — |
| 1e20 / 20 | 10 | 1,58 | 22 pA | 1,0 µA | 0,13 pA |
| 1e20 / 10 | 7,6 | 2,02 | 0,69 nA | 5,6 µA | 14 pA |
| 1e20 / 5 | 5,8 | 2,56 | 9,3 nA | 21 µA | 0,48 nA |
| 3e20 / 10 | 4,7 | 3,04 | 54 nA | 58 µA | 5,7 nA |

Sensibilidades: a 358 K la inversa a 1,8 V sube 5–9 % (601 → 636 A/cm² en 1e20/20) mientras la difusión del PDK sube
~10^2,5 (**cálculo**, Eg/kT): la firma térmica del plan es válida. Con F0 = 3e7 la inversa a 1,8 V baja 1–2 órdenes (1e20/20:
601 → 13 A/cm²) y el pico solo sobrevive en G = 5. El pozo a 2e17 no cambia nada en d ≤ +30.

Lo que el mapa dice del solape y de la alineación:
- Con picos distintos el solape (d < 0) da lo mismo que d = 0 hasta −100 nm: la unión se va al borde del implante débil.
  Con picos **iguales** el solape compensa y deja una zona casi intrínseca: es un artefacto de la simetría exacta, pero
  avisa de que el solape no "apila" dopado.
- Un hueco de +30 nm tira la celda de N a Z cuando G ≤ 10, y de N+ a B en 3e20/10. Un solape de 30 nm no cambia nada.
  La desalineación de ±30 nm es por tanto **asimétrica**: de dos réplicas en espejo, una queda en solape y la otra en hueco.

## 5. (d) Lo que dice el PDK (`a20_pdk.txt` §8–10, `a20_abrupta.txt` §4)

- `diode_pd2nw_05v5`: cj = 0,741 fF/µm², pb = 0,659 V, mj = 0,346, bv = 12,69 V → pozo n ≈ 4–6e16 cm⁻³ (**cálculo**, unión
  de un lado). `diode_pw2nd_05v5`: cj = 1,346 fF/µm², pb = 0,729, mj = 0,44, bv = 11,7 V → ≈ 1,6–2,1e17.
- BSIM4 de `nfet_01v8`/`pfet_01v8`: nsd = 1e20, xj = 1,5e-7 m, ndep = 1,7e17: los dos primeros coinciden con los valores por
  defecto de BSIM4 (**memoria**): no informan del proceso. jss = 2,15e-5 A/m², njs = 1,363 (p+/pozo n): la fuga "ordinaria"
  en el área de frontera es ~4e-18 A, cinco órdenes bajo el piso del lector.
- No hay ningún Zener ni ningún modelo de unión p+/n+ en el PDK. El dopado de pico y el gradiente lateral no salen de ahí:
  por eso se barren. Hoja de 120 Ω/□ con xj ≈ 0,1 µm da resistividad media ~1,2e-3 Ω·cm → n+ medio ~6e19 (**cálculo**
  con curva de Irvin **de memoria**; el pico es mayor); p+: ~2e-3 Ω·cm → ~5e19.

## 6. (e) Lectura (`a20_lectura.py` → `a20_lectura.txt`, `a20_lectura_3e20_G10.txt`)

- Piso de 150 fA = 8,9e-5 A/cm² en la frontera. Toda celda Z, B o N a d = 0 lo supera a 1,8 V por 3 a 8 órdenes: el problema
  del lector no es el piso sino el **rango** (0,3 nA descarga 12,4 fF en ~50 µs; 20 µA, en ~1 ns).
- Par en serie con corriente de exceso paramétrica: es biestable siempre que quede pico local. PVR 1,3 → excursión del nodo
  medio 0,11–0,13 V; PVR 2–2,5 → 0,19–0,23 V; PVR 5 → 0,28 V. Con PVR 1,05 un desajuste de 30 % entre los dos picos lo mata.
  Alimentación del par: 0,1–0,3 V. La corriente de pico (0,5–6 nA en las celdas probadas) conmuta el nodo en 1–10 µs.
- Un inversor de 1,8 V no ve 0,2 V de excursión cerca de masa: lectura por pin analógico, comparador, o un pfet de umbral
  bajo como seguidor. "Legible en digital" no se sostiene tal cual.
- Referencia leída (tesis de Zhao, vía subagente): Koga y Toriumi, Esaki lateral implantado, ~10 A/cm², PVR ≈ 2. Mis celdas N
  dan 1e-3 a 0,3 A/cm²: con el exceso de una unión implantada es dudoso que quede pico salvo en N+.
- **Firma más barata sin resistencia negativa:** (1) I(−1,8 V) en d = 0 frente a d = 0,27: contraste predicho ≥ 10^9;
  (2) I(−0,1 V)/I(+0,1 V) > 10 (backward); (3) I(−1,8 V) casi plana entre 27 y 85 °C (+5–9 %) frente a ×300 de la difusión.

## 7. (f) Literatura (subagente; grados suyos)

- **Leída entera:** tesis de J. Zhao (Notre Dame, 2007): Koga y Toriumi (implantes de 25–30 keV, 1000 °C 30 s, ~10 A/cm²,
  PVR ≈ 2); para 1 mA/µm² hacen falta ~1,6e20 efectivos y ~4 nm/década; implante + RTP da 3,5–5 nm/década solo a
  0,2–1,5 keV. Wang, Huang et al., arXiv 2410.12390: TFET en base de 0,13 µm limitado por "the ion implantation limitation
  in improving junction abruptness". Tesis ESD de Idaho: dos difusiones opuestas muy dopadas pegadas dan "a zener diode with a
  very low breakdown voltage" (sin cifras).
- **Leída vía resumidor:** patente US6268639 (Zener lateral de 5,5–7 V en 0,18 µm; necesitaba bloqueo de siliciuro para no
  cortocircuitarse); páginas de reglas de SkyWater.
- **No leídas (fragmento):** Koga y Toriumi originales (APL 1996/97, EDL 1999); Solomon et al., JAP 95, 5800 (2004), túnel en
  diodos implantados tipo CMOS; Huang, IEDM 2015; Schmid, Nano Lett. 2012; hilos de Tim Edwards.
- **No encontrado:** I-V inversa a 1–2 V de una unión p+/n+ pegada sin siliciuro; ninguna medida en SKY130; ningún Esaki
  con implantes S/D de fundición.
- Por qué no hay Esaki en CMOS estándar: (1) casi todos los CMOS desde 0,25 µm llevan siliciuro autoalineado, que convierte
  la unión pegada en cable (SKY130 es la excepción aparente); (2) los implantes S/D de 130 nm no dan ≤ 5 nm/década;
  (3) la corriente de exceso del implante. El Zener blando, en cambio, es lo que la literatura de ESD da por hecho.

## 8. Predicciones contra resultados

| Predicción | Resultado |
|---|---|
| P-a sin siliciuro sobre difusión; butting documentado; hd sin tomas pegadas | Cumplida en lo comprobable; sin cita textual. Contaminada (vi 120/197 Ω/□ antes) |
| P-b W, Emax dentro de tolerancia; órdenes 4–7 | Cumplida (5,67 nm; 4,38 MV/cm; 16,6 nm; 1,29 MV/cm; 4,5 y 7,2). No predije el 10^8,5 a 0,1 V |
| P-c d = 0, 1e20: W ≈ 7 nm (G = 5) y ≈ 15 nm, 1 MV/cm (G = 50) | Cumplida (7,9–8,5 nm; 15,6–17,0 nm; 1,03–1,14 MV/cm) |
| P-c d = 0 nunca ordinario con Np ≥ 5e19 | Cumplida |
| P-c resistencia negativa < 15 % del mapa | Cumplida (7,4 %) |
| P-c pico solo con d entre −30 y +10 nm | **Fallada**: con r = 2 llega a −100 nm; con 3e20/20 aguanta +30 |
| P-c solape: W dentro de ±30 % de d = 0 | Cumplida con r = 2; **fallada** con r = 1 (compensación) |
| P-c ±30 nm solo cambia de región si G ≤ 10 | **Fallada**: también en G = 20, y solo hacia el hueco |
| P-c inversa a 1,8 V > 1 A/cm² en 1e20/20 | Cumplida (255–601) |
| P-d pozo 5e16–3e17, pb 0,6–1,0, bv > 8 V, sin Zener | Cumplida |
| P-e si hay pico, Jp ≥ 1 A/cm² | **Fallada**: 20 de 26 celdas con pico dan 1e-3–0,9 A/cm² |
| P-e PVR de literatura ≤ 3 con implantes | Cumplida (≈ 2) |
| P-f hay Koga-Toriumi, Zener laterales y TFET de fundición; ningún Esaki S/D de fundición | Cumplida |

## 9. Lo nuevo

1. La predicción fuerte no es la resistencia negativa sino la **fuga**: una unión pegada legal con 1,8 V en inversa conduciría
   de 0,3 nA a decenas de µA por 1,4 µm de frontera (0,1 pA en el peor caso con F0 = 3e7). El PDK no lo modela y Magic la
   extrae como dos nodos sin diodo: hueco de modelo utilizable.
2. La transición ordinario → túnel ocurre en 0 < d < 0,1 µm, justo la banda que el DRC prohíbe. Lo único que la muestrea
   legalmente es la desalineación de máscaras.
3. Par en espejo como sensor de alineación NSDM/PSDM: el cociente de corrientes entre las dos réplicas mide signo y tamaño
   del desplazamiento.

## 10. Configuraciones que más informan

1. **d = 0 en cuatro réplicas (espejo × 0°/90°) + d = 0,27 + celda sin unión**, leyendo I(V) en las dos polaridades entre
   ±0,3 V y a −1,8 V, a dos temperaturas. Decide O/Z/B/N y el signo de la desalineación. El lector de precarga a 1,8 V solo
   da un punto: hace falta salida a pin analógico o un lector de rango nA–µA.
2. **Escalera por la banda ilegal:** d = −0,10; −0,05; +0,03; +0,05; +0,10 µm (rejilla de 5 nm). Sitúa la frontera O/Z y da
   G. Si el precheck acepta alguna y si las máscaras NSDM/PSDM pueden solaparse sobre difusión: `[?]`, hay que medirlo.
3. **Frontera larga (serpentín de 14–56 µm) a d = 0 y el par en serie con el nodo medio a un pin**: escala la corriente con
   el largo (separa frontera de área) y prueba el biestable sin depender del inversor.

## 11. Límites de este ataque

- Perfil lateral 1D con forma supuesta; la forma real (dispersión lateral del implante, borde de resina, difusión del
  recocido, compensación) es lo que el silicio contesta. El rango G = 5–50 nm/década no se acotó con datos de SKY130.
- Prefactor y F0 de memoria. Sin ancla experimental: la patente da Zener laterales de 5,5–7 V; no calculé la tensión de
  ruptura de mis celdas para compararla. Es la comprobación siguiente.
- `a20_butting.py` (todas las bibliotecas) no había terminado al cerrar; vale `a20_butting_hd.txt`.
- La primera versión de `a20_lectura.txt` tenía un fallo en el buscador de pico/valle (daba PVR = 1 con pico local presente);
  lo corregí y **sobrescribí** las dos salidas.
