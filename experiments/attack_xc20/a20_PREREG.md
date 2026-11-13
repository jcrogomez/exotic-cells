# a20 · Prerregistro del ataque a XC-20 (unión túnel de silicio)

Hora (`date`): Thu Nov 12 12:36:30 EST 2026

Honestidad sobre el orden: antes de escribir esto ya leí el encargo, el PLAN.md, el LEEME de chispa y UNA salida de grep del
PDK (`sky130A.tech` líneas 5106-5107: hoja de ndiff 120 Ω/□ y pdiff 197 Ω/□). La predicción (a) está contaminada por ese dato.
No he corrido ningún cálculo con código ni he buscado literatura. Las cuentas de abajo son a mano.

## Qué voy a hacer

| # | Qué | Script / salida |
|---|---|---|
| a | grep del PDK (hoja de difusión, licon, reglas difftap, celdas hd con toma pegada) + documentación SkyWater en la web | a20_pdk_grep.sh → a20_pdk.txt |
| b | Unión abrupta simétrica: W, Emax, exponente exp(-B/E) con B de Kane (3e7 V/cm, el del plan) y de Hurkx (1,9e7 V/cm), N = 1e19..3e20 | a20_abrupta.py → a20_abrupta.txt |
| c | Poisson 1D con Fermi-Dirac sobre perfil lateral de dos máscaras (cola de G nm/década, pico Np, separación d con desalineación), túnel por camino no local (WKB dos bandas, prefactor de Hurkx), clasificación | a20_perfil.py → a20_mapa.txt, a20_mapa.png |
| d | cj, pb, mj, bv de los modelos de diodo y MOS del PDK → dopado del lado ligero | dentro de a20_pdk.txt + a20_abrupta.py |
| e | Corriente de pico × área de frontera frente a 150 fA; PVR mínimo para biestable | a20_lectura.py → a20_lectura.txt |
| f | Literatura (web) | sección del informe, con leído / no leído |

## Predicciones (numéricas, antes de correr)

- **P-a.** SKY130 no tiene siliciuro autoalineado sobre la difusión (120/197 Ω/□ son valores de difusión sin siliciuro; con
  siliciuro serían < 15 Ω/□). El siliciuro solo existe bajo el licon. Por tanto d = 0 es unión, no cable, salvo que un licon
  o el li1 monten sobre la frontera. Confianza 80 % (contaminada). Predigo además que el PDK documenta "tap butting diff" como
  construcción normal (reglas difftap.5-7) y que NO habrá celdas hd con toma pegada a fuente (usan celdas tap aparte).
- **P-b.** Abrupta simétrica, Vbi ≈ 1,1-1,2 V: N = 1e20 → W = 5,5 ± 0,5 nm, Emax = 4,2 ± 0,5 MV/cm; N = 1e19 → W = 17,5 ± 1,5 nm,
  Emax = 1,3 ± 0,2 MV/cm. Los números del plan se sostienen. El cociente de exp(-B/Emax): 6-7 órdenes con B = 3e7; solo
  ~4 órdenes con B = 1,9e7 (Hurkx). "Seis o siete órdenes" depende de B: predigo que queda en 4-7.
- **P-c.** (cuenta a mano, unión graduada lineal: a = Np·ln10/(2G), W = (12 ε Vbi/(q a))^(1/3))
  - d = 0, Np = 1e20, G = 5 nm/déc → W ≈ 7 nm; G = 50 nm/déc → W ≈ 15 nm, E ≈ 1 MV/cm. Es decir: en d = 0 la unión NO es un
    diodo ordinario en casi ningún punto del barrido con Np ≥ 5e19; será al menos Zener/backward.
  - Resistencia negativa (pico de túnel en directa sobre la difusión, dos caras degeneradas): solo para Np ≥ 1e20 y G ≤ 10-15
    nm/déc y d entre -30 y +10 nm. Predigo < 15 % de las celdas del mapa.
  - d ≥ +50 nm con pozo 1e17 en medio: diodo ordinario en baja tensión (sin túnel a ±0,3 V), cualquiera que sea G ≤ 20;
    con G = 50 la cola aún puede cerrar el hueco hasta d ≈ 0,1 µm.
  - Solape (d < 0): la unión se desplaza al borde del implante más débil, no se hace más abrupta; el mapa para d = -0,1 se
    parece al de d = 0 si los picos son iguales, y es peor (más graduada) no; predigo W dentro de ±30 % de d = 0.
  - Una desalineación de ±30 nm cambia de región solo cuando G ≤ 10 nm/déc.
  - Corriente inversa de túnel a 1,8 V en d = 0, Np = 1e20, G = 20: > 1 A/cm² (ruptura Zener por debajo de 1,8 V o cerca).
- **P-d.** Del cj de `diode_pd2nw` saldrá un pozo n de 5e16-3e17 cm⁻³; pb entre 0,6 y 1,0 V; rupturas documentadas > 8 V para
  uniones contra pozo. Nada en el PDK modela una unión p+/n+ (ningún Zener de biblioteca).
- **P-e.** Área de frontera = 1,4 µm × xj (0,1 µm, a barrer 0,05-0,2) ≈ 1,4e-9 cm². El piso de 150 fA equivale a ~1e-4 A/cm².
  Si hay pico de túnel, Jp ≥ 1 A/cm² → ≥ 1 nA, 4 órdenes sobre el piso: la lectura no es el cuello. El cuello es la corriente
  de exceso (trampas del implante) que fija el valle: PVR > 1 es condición del biestable; predigo que con uniones implantadas
  la literatura da PVR ≤ 3.
- **P-f.** Sí hay literatura cercana que la primera búsqueda no encontró: Zener laterales p+/n+ en CMOS (recorte "zener zap",
  ESD), Koga y Toriumi (dispositivo túnel lateral en silicio con implantes, años 90), y TFET en flujo CMOS de fundición (grupo
  de Pekín). Predigo que NO aparece ningún Esaki con pico medido hecho solo con los implantes n+/p+ de un CMOS de fundición.

## Qué mata, qué deja viva

- **Mata (física):** siliciuro continuo sobre la difusión confirmado por fuente del proceso (d = 0 es cable y no hay bloqueo
  dibujable); o que en todo el barrido creíble (G ≥ 10 nm/déc) la corriente de túnel a ±1,8 V quede bajo 1e-4 A/cm².
- **Mata solo la resistencia negativa (transforma):** ninguna celda con dos caras degeneradas y pico > difusión para G ≥ 10.
- **Deja viva:** una banda del mapa, alcanzable con d legal (0) dentro de ±30 nm, donde la inversa de túnel a baja tensión
  supera a la directa (backward) o hay pico.
- **Muere por lectura:** corriente de frontera < 150 fA en todas las celdas no ordinarias.

## Tautologías (se deducen sin correr)

1. Si las dos caras son 1e20 abruptas, W ≈ 5 nm: es la fórmula de vaciamiento, no un resultado.
2. Con G fijo, subir Np sube el gradiente a en proporción: el mapa en (Np, G) depende casi solo de Np/G en d = 0.
3. La unión siempre está donde N_A = N_D; un solape no "apila" dopado neto, lo compensa.
4. Un modelo sin trampas no puede dar el valle: cualquier PVR que salga de mi código es cota superior, no predicción.
5. El prefactor de túnel indirecto es incierto en ≥ 1 orden; las fronteras del mapa se mueven con él menos que con G
   (el exponente manda), pero las corrientes absolutas llevan esa incertidumbre.

## Criterio de abandono

Si Poisson no converge o el túnel no local no reproduce el límite de campo uniforme (Hurkx) dentro de un factor 2, vuelvo al
modelo de unión graduada analítico y lo digo.
