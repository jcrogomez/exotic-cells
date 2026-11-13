# c60 — Prerregistro del ataque a XC-60 (magnetodiodo)
Hora (`date`): Thu Nov 12 19:03:34 EST 2026. Escrito antes de correr o buscar. Predicciones DE MEMORIA.

## Qué se va a hacer
(h) Literatura de magnetodiodos (SOS, CMOS). (i) Modelo propio: difusión ambipolar 2D en la sección transversal con deriva transversal por Lorentz y velocidades de recombinación distintas en las dos caras, barriendo s, vida media, espesor y largo; campo de una línea de met1 (tira finita, Biot–Savart) con la pila real; comparación con Hall (0,017–0,66 mV/mA) y con el paso del lector (0,305 mV). (j) Geometrías legales.

## Predicciones
- P60.1 Literatura (de memoria): magnetodiodos SOS ~1–10 V/T a corrientes de mA; el de CMOS (Popović/Baltes 1984, de memoria) usa como "cara recombinante" la unión pozo-sustrato en inversa, no la interfaz con el óxido; ~ V/T a mA. Condición: largo ≳ 2–3 longitudes de difusión ambipolar e inyección alta.
- P60.2 Campo de una línea de met1 sobre silicio: cota de lámina infinita µ0·K/2 con K = 2,8 mA/µm ⇒ 1,76 mT máximo sea cual sea el ancho; con ancho 2–5 µm y d ≈ 1,56 µm al centro del metal: 0,6–1,2 mT. Los "2 mT" NO se alcanzan con una sola línea de met1 en continua.
- P60.3 Modelo: cambio relativo de corriente o tensión a 1 mT entre 1·10⁻⁴ y 3·10⁻³ (amplificación geométrica 1–10 sobre µB); en tensión: 3 µV–0,1 mV. Es decir, por debajo de un paso del lector (0,305 mV) en la mayor parte del barrido, y del mismo orden que la Hall, no "mucho mayor".
- P60.4 En un pozo n, los huecos inyectados los recoge el sustrato (pnp vertical): el "diodo largo" es un transistor lateral/vertical; con largo >> profundidad del pozo casi ningún hueco llega al otro extremo ⇒ no hay doble inyección a lo largo de todo el diodo salvo L ≲ unas pocas profundidades de pozo.

## Tautologías
- Con corriente a lo largo de x y campo en el plano (y), la fuerza es VERTICAL (z): empuja hacia la superficie (óxido) o hacia el fondo (unión pozo–sustrato). La geometría del plan ("un lado pegado al borde del aislamiento y el otro lejos", caras laterales) pide campo VERTICAL, que es el de la bobina de XC-56, no el de una línea. Hay dos dispositivos distintos según la orientación.
- La respuesta impar es ∝ (s1−s2): centrado/simétrico ⇒ 0 por simetría; no hace falta simular el control.
- Deflexión ∝ (µn+µp)·B ≈ 0,18 m²/Vs × 1 mT ≈ 2·10⁻⁴: toda sensibilidad mayor es geometría (L/d) y no puede superar ~ (L/d)·µB·O(1).

## Mata / deja viva
- Mata (en este vehículo, con este lector): señal < 0,03 mV (un décimo de paso) en todo el barrido de s y vida media con el campo alcanzable. Viva: > 0,3 mV en alguna región creíble. Transformada: del orden de la Hall ⇒ es otro sensor de mT comparable, o un magnetotransistor (reparto de corriente pozo/sustrato) leído en corriente.
