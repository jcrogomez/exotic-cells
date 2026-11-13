# Mapa del precheck: qué rupturas de regla rechaza y cuáles deja pasar (tarea E0.2, prueba L2)

Escrito el 2026-11-12 12:35 EST (hora de `date`), antes de correr `map.py`. Sin commit previo: exploratorio con predicción escrita.

**Qué es.** Celdas sonda sueltas, una por tipo de ruptura, pasadas por las mismas funciones que usa el precheck oficial de Tiny
Tapeout (`tt-support-tools` 01d5d28, PDK `0536d02d`, Magic 8.3.568, KLayout 0.30.8): DRC de Magic con `drc(full)`, y el deck
`sky130A_mr.drc` de KLayout en sus tres pasadas (FEOL, BEOL, fuera de rejilla). No se corren las comprobaciones de pines y
frontera, que una sonda suelta no puede cumplir. Una sonda "pasa" si las cuatro dan cero.

**Predicciones.**
1. Controles (cuello de met1 a 0,14; cuello de li a 0,17; p+/n+ pegados; pozo con toma; transistor con metal pequeño): pasan.
2. Cuello de met1 a 0,10 y a 0,07; puntas de met1 a 0,05 y a 0,10; cuello de li a 0,10: rechazados por Magic y por KLayout BEOL.
3. p+/n+ solapados 0,10 y separados 0,13: rechazados por Magic y por KLayout FEOL.
4. Pozo n sin toma: lo rechaza Magic; KLayout lo deja pasar.
5. Transistor con una placa de met1 de 60 × 60 µm colgada de la puerta (antena): pasa las cuatro.
6. Placa de met1 con hoyos de 0,14 µm: rechazada por al menos una herramienta (regla de área mínima de hueco). Con hoyos de
   0,40 µm: pasa.

**Para qué.** Cada ruptura que pase las cuatro es geometría enviable tal cual. Cada una que rechace una sola herramienta marca
un borde entre decks. No hay criterio de abandono: es una medida de la herramienta.
