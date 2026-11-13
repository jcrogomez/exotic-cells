# Revisión externa del commit 3967d9c (2026-11-13)

Una auditoría externa del repositorio público llegó como texto pegado. Aquí está cada punto, lo que comprobamos y qué se hizo.
Comprobado y aplicado 11:23–11:40 (hora de `date`). Lo que depende de decisiones de Juan queda abierto, sin aplicar.

| # | Punto de la revisión | Comprobación | Veredicto | Acción |
|---|---|---|---|---|
| 1 | `docs/MOTIVATION.md` exigía "basada en un comportamiento normalmente indeseado", lo que contradice la tercera región | Leído: criterio 1 lo decía | **cierto** | Criterio reescrito: comportamiento físico usable y no convencional, venga de un defecto, una geometría legal, una interfaz o un régimen de operación |
| 2 | XC-30 (coherencia mesoscópica) no es XC-54 (superconductividad) | Física: coherencia de fase sin pares de Cooper; solo comparten criostato | **cierto** | XC-30 reabierta 🟡 con su ID; nota en su plan y en la fila de XC-54 |
| 3 | XC-29 cancelada por no estar definida; XC-28 por necesitar posproceso | Filas del catálogo: razones "never defined" y "needs post-processing" | **cierto**: ninguna es refutación física; el vehículo clasifica, no rechaza | Las dos reabiertas 🟡, vehículo especializado. Las otras seis 🔴 tienen razón física (territorio de celdas estándar, tasa de eventos, no son celdas) y siguen así |
| 4a | `fits()` en `residual/lod_annotate.py` acepta coincidencias parciales con `zip()` | Reproducido: un `.ext` sin un terminal se anotaba sin error | **cierto** | Exige dos terminales a cada lado; prueba negativa añadida |
| 4b | `annotate()` duplica `sa=`/`sb=` en una segunda pasada | Reproducido: salía `sa=0.3 sb=1 sa=0.3 sb=1` | **cierto** | Rechaza una red ya anotada; prueba negativa añadida. 8 geometrías y 12 rechazos pasan |
| 5 | XC-20: Dutta 2017 bloqueó el siliciuro sobre la región activa; el modelo de túnel depende de que la unión exista | El artículo no se pudo abrir (IEEE vacío, UTwente 403): **sin leer por nosotros**. El plan ya tenía el siliciuro como `[?]` | plausible; ya era pregunta abierta | El siliciuro pasa a primera compuerta de XC-20, antes de refinar el túnel; se pide corte transversal de máscaras y materiales |
| 6 | XC-26 usa parámetros de transporte inverso del PNP fuera del dominio del PDK | Código: `d26_budget.py` usa la beta directa (bf, ikf); la frontera de saturación sale del potencial del sustrato. **No usa parámetros inversos** | **parcial**: la afirmación concreta no se reproduce; el fondo sí (la saturación del PNP vertical está fuera del dominio modelado y permitido) | XC-26 marcada como predicción condicionada a un modelo de transporte no calibrado |
| 7 | XC-27: demostrar que el instrumento distingue un pequeño porcentaje antes de atribuirlo a los hoyos | Ya estaba: pide ≥5 pA y apareamiento <1 % | ya incorporado | Sin cambio |
| 8 | XC-58: no cerrar el desacuerdo Monte Carlo / ngspice | El plan dice "~0,50, sin explicación" | ya incorporado | `docs/CLAIMS.md` lo lista como desacuerdo abierto |
| 9 | La CI no reproduce la física | Cierto: corre Python, no Magic, KLayout, ngspice ni modelos | **cierto** | README lo dice explícitamente. Pruebas de integración con el PDK: pendiente (ver abajo) |
| 10 | Separar nivel de evidencia de preparación para tapeout | El 🟢 se podía leer como "listo" | **cierto** | Leyenda: el color es evidencia en papel; la preparación para tapeout va en cada plan |
| 11 | `docs/CLAIMS.md` solo cubría LOD y XC-19 | Cierto | **cierto** | Sección nueva con las rondas 1–4, grados, supuestos y límites |
| 12 | No hay RTL, `info.yaml` ni diseño superior de MISFIT | Cierto en este repo | cierto | Decisión de Juan (abajo) |

## Abierto: decisiones de Juan

Estas propuestas de la revisión cambian prioridades o reglas. No se aplican sin que Juan las confirme:

- Cerrar primero un canal físico completo (XC-19 con capacitores, alimentación, calibración y salida digital) antes de añadir
  arreglos o estructuras nuevas al diseño; diseñar MISFIT-M0 con XC-12, XC-58 y XC-19 (y XC-20 si se resuelve el siliciuro).
- Un módulo nuevo de Residual, "motor de hipótesis físicas": comparar mecanismos rivales y elegir el experimento con mayor
  ganancia de información esperada; mapear respuestas cruzadas (∂²y/∂uᵢ∂uⱼ) en fronteras como XC-19×XC-58, XC-52×XC-60 y
  XC-26×XC-27.
- Una matriz de capacidades del PDK (documentado / capas y máscaras / disponible en el shuttle / observable), empezando por
  SONOS, siliciuro, TiN, MiM, alta tensión y fotodiodos.
- Pruebas de integración con el PDK en la CI para algunos experimentos de referencia (necesita una imagen de Docker en la CI).
