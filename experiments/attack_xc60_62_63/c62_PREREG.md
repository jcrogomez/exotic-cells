# c62 — Prerregistro del ataque a XC-62 (transistor impreso por proximidad)
Hora (`date`): Thu Nov 12 19:03:34 EST 2026. Escrito antes de correr. Predicciones DE MEMORIA.

## Qué se va a hacer
(d) Reglas de poly del tech de Magic con línea. (e) Imagen aérea (litho.py copiado y ampliado, misma óptica supuesta: 248 nm, NA 0,60/0,70, σ 0,5/0,8, umbral constante calibrado a línea aislada de 0,15) para: aislada; vecinos a 0,21 por uno y dos lados (y 0,42, 1,0); punta con extensión 0,13; codo a distancia mínima de la difusión; U. Largo impreso en centro y borde de la difusión. dVth/dL del modelo del PDK a L=0,15 por ngspice (o por los bins del modelo). (f) Búsqueda sobre OPC en SKY130. (g) Mapa del precheck de las variantes.

## Predicciones
- P62.1 Reglas: ancho 0,15; separación 0,21; extensión de poly sobre diff (endcap) 0,13; diff más allá de poly 0,25; poly a diff 0,075; no hay regla específica de "codo a difusión" distinta de poly.4 (0,075) salvo la prohibición de doblar poly sobre diff.
- P62.2 Vecinos a 0,21 (paso 0,36): el largo impreso cambia entre −30 y +30 nm respecto a la aislada, y el SIGNO depende del ajuste óptico (al menos un ajuste con signo contrario a otro).
- P62.3 Punta con extensión 0,13: retroceso de 40–110 nm; en ningún ajuste la punta deja de cubrir la difusión (retroceso < 0,13), pero el largo en el borde de la difusión cae 15–60 nm.
- P62.4 Codo a 0,075 de la difusión: el redondeo alarga el canal en el borde 10–50 nm, decayendo en ~0,1–0,15 µm hacia dentro.
- P62.5 Puerta en U (dos dedos a 0,21 unidos): como "vecino por un lado" ±10 nm.
- P62.6 dVth/dL a L=0,15 (nfet_01v8): |dVth/dL| entre 0,3 y 2 mV/nm; por tanto 10 nm ↔ 3–20 mV, comparable al desajuste de 17,3 mV; corriente en inversión débil ×1,1–1,7 (n=1,41).
- P62.7 OPC: no habrá declaración pública inequívoca para poly; quedará en dos escenarios (70 %).
- P62.8 Todas las variantes pasan Magic y KLayout salvo, quizá, el codo (si existe regla de codo que no recuerdo).

## Tautologías
- Umbral constante calibrado en la línea aislada ⇒ la aislada imprime 0,15 por construcción: no es resultado.
- Para una W de 0,42 µm, un efecto de borde que decae en ~0,1 µm afecta a ~la mitad del ancho: en inversión débil la corriente la domina el tramo de MENOR largo (exponencial), así que acortar el borde pesa más que alargarlo.
- Si la fábrica aplica OPC por reglas/modelo, lo que queda es el residuo de su corrección (menor, signo desconocido): la simulación sin OPC es COTA SUPERIOR del efecto sistemático, no predicción.
- El modelo no tiene resina ni grabado: sesgos iso-denso de grabado (micro-carga) son del mismo orden y no se simulan.

## Mata / deja viva
- Mata: en los cuatro ajustes, todas las variantes legales dan |ΔL| < 2 nm (ΔVth << desajuste/√réplicas razonable) . Viva: alguna variante con |ΔL| ≥ 5 nm en los cuatro ajustes con el mismo signo. Transformada: signo dependiente del ajuste ⇒ la celda mide la óptica/OPC de la fábrica, no es un "ajuste de umbral por diseño".
