# c61 — Prerregistro del ataque a XC-61 (oscilador por congelación)

Hora: Thu Nov 12 19:04:20 EST 2026 (de `date`). Escrito ANTES de literatura y corridas. Todo **de memoria** / cálculo a mano.

## Qué voy a hacer
(h) Leer ruptura por ionización por impacto de impurezas en silicio y CMOS criogénico de 130–180 nm; buscar el dopado del
sustrato de SKY130 (PDK, documentación). Calcular la fracción ionizada frente a T para 1e14–1e18 (estadística con degeneración
del nivel, sin y con compensación). (i) Estructura y lectura.

## Tautologías
- T1. El campo no es el problema: 1,8 V sobre 2–50 µm son 360–9000 V/cm. Lo que decide es la temperatura y el dopado.
- T2. Dopantes de Si (B, P: ~45 meV) son 4–5× más profundos que los del Ge (~10 meV): campos umbral y temperaturas mayores que
  los "pocos V/cm" del plan (esa cifra es de germanio).
- T3. Regiones sobre la transición de Mott (~3–4e18) no se congelan: difusiones n+/p+ y poly quedan metálicas.

## Predicciones
| # | Cosa | Predicción |
|---|---|---|
| P1 | Campo umbral de ruptura en Si a 4–10 K, 1e15–1e16 | 100–1000 V/cm (no "pocos V/cm") |
| P2 | Dopado del sustrato de SKY130 | No público con precisión; tipo p, 1e14–1e16 [?]. Pozos 5e16–5e17 en superficie |
| P3 | T de 50 % de ionización | 1e15 (B): 45–60 K. 1e17 (P): 90–130 K |
| P4 | T de congelación fuerte (n/N < 1e-3) | 1e15: 18–25 K. 1e17: 25–35 K |
| P5 | A 77 K | Pozo 1e17 ionizado 10–40 %; sustrato 1e15 > 60 %. **Sin** característica en S ni oscilación por impurezas; sí cambios de R(T) no monótonos |
| P6 | Precedente de oscilación/pulsos en Si a 4 K | Existe: diodos p+-n-n+ de silicio que pulsan a 4,2 K (Coon y Perera, ~1989), y kink/histéresis en CMOS a 4 K |
| P7 | Estructura SKY130 | La ya presente es p+ (fuente pfet) / pozo n / toma n+ = p+-n-n+; y toma p+ / sustrato / toma p+. Si el pozo p es general, la de sustrato pasa por 1e17 |
| P8 | Lectura a 4 K | La lógica de 130 nm funciona a 4 K (Vt +0,1…0,2 V); hay medidas publicadas de SKY130 en frío |
| P9 | Frecuencia | Relajación RC: kHz–MHz con las capacidades de pozo (pF) y R congelada (MΩ–GΩ) |

## Qué la mata / qué la deja viva
- Muere (física) si a 4 K el pozo/sustrato de SKY130 resulta demasiado dopado para congelarse (> ~3e18) en todo el camino de
  corriente. Vive como "vehículo criogénico" si hay camino por silicio ≤ 1e17.
- A 77 K: muere la versión "S + oscilación"; puede quedar un observable de congelación parcial.
- No hay simulación de dispositivo decisiva aquí sin el perfil de dopado: doy escenarios por dopado.
