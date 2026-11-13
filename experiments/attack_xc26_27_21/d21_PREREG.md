# d21 — Prerregistro del ataque a XC-21 (emisores de avalancha; absorbe XC-22 SPAD)

Escrito el 2026-11-12 22:35 EST (misma marca de `date` que `d26_PREREG.md`), antes de buscar literatura y antes de correr.
Predicciones **DE MEMORIA** salvo cita.

Lo ya sabido que uso: `bv` del PDK 11,7–12,8 V (parámetro de modelo, `PESCA_OPTO_1104.md`); Dutta 2017: 2–9 V con hueco 0–280 nm
en 65 nm, de sus figuras ~21 µA/µm a ≈ 2 V y 0,04 V/nm entre 0 y 100 nm (`RONDA_2`); separaciones enviables aquí: 0 o ≥ 0,27 µm
(`precheck_map`); R13: túnel inverso en la unión pegada a 1,8 V entre 57 nA y 50 µA por 1,4 µm (intervalo, sin calibrar).

## Qué voy a calcular/leer y qué predigo

| # | Cosa | Cómo | Predicción |
|---|---|---|---|
| A1 | Ruptura de p+/pozo n en 130–180 nm publicada (SPAD y diodos) | Literatura leída | 9–14 V; en SKY130, si hay SPAD publicado, 10–13 V. Coherente con `bv` ≈ 12,7 V |
| A2 | Ruptura frente a separación p+/n+ en un pozo de dopado barrido (10¹⁶–10¹⁸) | Cálculo propio: campo crítico / perforación (reach-through) de una unión p+-n-n+ con hueco 0,27; 0,54; 1,08 µm | Con hueco 0,27 µm la ruptura ya es casi la de la unión plana (≥ 8 V) salvo pozo ≤ 3·10¹⁶, donde el hueco se vacía entero y V ≈ E_crit × hueco ≈ 8–13 V. **Ninguna geometría con hueco ≥ 0,27 µm rompe a 1,8 V ni a 3,3 V.** Solo la pegada conduce a esas tensiones (túnel/Zener) |
| A3 | ¿Emite la unión pegada en inversa a 1,8 V y a 3,3 V? | Energía disponible q(V + V_bi) frente al umbral de ionización (~1,5 eV·k) y eficiencias publicadas en régimen de túnel/Zener | A 1,8 V: fotones por electrón 10⁻⁹–10⁻⁷ (portadores calientes sin multiplicación); con 50 µA → < 0,1 fA en el fotodiodo: no se lee. A 3,3 V: multiplicación parcial, 10⁻⁷–10⁻⁶ |
| A4 | Fotocorriente en el fotodiodo con un emisor en avalancha de eficiencia interna 6·10⁻⁶ (Dutta) y luz visible (se absorbe en micras) | Presupuesto con la geometría de `d26`, α(620 nm) ≈ 3·10³–4·10³ cm⁻¹ | El visible se absorbe en ~3 µm: no llega a 5 µm de distancia por el silicio (transmisión e^(−5/3) ≈ 0,2 a 5 µm, ≈ 10⁻³ a 20 µm) y se absorbe sobre todo junto al emisor; la cola roja/infrarroja sí viaja. A 100 µA, 5 µm: 0,1–10 pA. **Sobre el piso**, a diferencia de la directa |
| A5 | Bomba a ~10–13 V | Aritmética de una Dickson con `capm` | 100 µA a 12 V desde 1,8 V pide ≥ 8 etapas y ≥ 0,8 mA de entrada; área de condensadores del orden de 10⁴ µm² a 10 MHz. Cabe; el problema es qué dispositivo aguanta 12 V (nfet_g5v0d10v5: 11 V drenador; pozos profundos aislados) |
| A6 | SPAD en SKY130: ruptura, guarda, tasa oscura | Literatura leída | Si existe publicado: ruptura 10–13 V, tasa oscura 10²–10⁵ Hz por dispositivo de ~10 µm; necesita guarda (pozo p ausente / anillo de pozo n de bajo dopado) que en SKY130 hay que construir con capas disponibles `[?]` |

## Qué mataría la idea

- XC-21 a 1,8/3,3 V sin bomba: muere si ninguna geometría enviable rompe por debajo de 3,3 V con emisión ≥ 10⁻⁷ fotones/electrón
  y corriente ≥ 10 µA. (Predigo que esta sub-afirmación muere salvo la pegada a 3,3 V, que queda abierta.)
- XC-21 con bomba: muere solo si la tensión necesaria supera lo que aguanta cualquier dispositivo del PDK para conmutarla, o si la
  fotocorriente esperada queda bajo el piso en todos los escenarios.
- XC-22: muere por lectura si la tasa oscura esperada satura cualquier contador (> 10⁷ Hz) o si no hay guarda construible.

## Qué la dejaría viva

- Un par emisor en avalancha–fotodiodo con ≥ 1 pA esperado en el escenario central y una bomba que quepa: vive como vehículo H.
- La pegada a 3,3 V con emisión medible: sería la variante sin bomba.

## Tautologías

- T1. Sin campo suficiente para ionizar no hay avalancha: a 1,8 V + V_bi ≈ 2,9 eV de energía máxima por portador hay como mucho
  una o dos ionizaciones; la multiplicación no diverge. A 1,8 V no hay "ruptura por avalancha" en ninguna geometría; lo que haya
  es túnel.
- T2. El hueco legal salta de 0 a 0,27 µm: la curva de Dutta (0–280 nm en pasos de 20 nm) solo tiene aquí sus dos extremos.
- T3. La luz visible de avalancha se absorbe en micras: el detector tiene que estar pegado o la señal viaja como portadores
  generados junto al emisor (otra vez T3 de `d26`).

## Criterio de abandono

Si la literatura leída no da ruptura para p+/n+ con hueco en 130–180 nm, no extrapolo Dutta más allá de 100 nm: doy el cálculo
propio de A2 como intervalo y marco `[?]`.
