# Preregistro · XC-19 · ruido explícito y detección de eventos (solo modelo)

Escrito el 2026-11-11 22:27 EST (hora de `date`), antes de correr. Lo motiva una revisión externa del mismo día: con un nodo de 2 fF el ruido
de disparo por conversión (≈ 0,9 %) es del tamaño del salto buscado (≈ 0,86 %), así que contar ciclos de reloj de 20 ns no
equivale a resolver una trampa con esa resolución. La aritmética es correcta y ya estaba implícita en la parte 1 (la relación
señal/ruido depende de I·τ, no de C), pero la parte 2 no la aplicó al punto de trabajo elegido.

Sigue sin ser una demostración de una trampa: el salto y sus tiempos se inyectan.

## N8a · ruido de disparo en transitorio (ngspice, `trnoise`)

Celda extraída (`cells/xc19_read`), polarización de 4 en serie. Fuente de corriente de ruido blanco en el nodo X con densidad 2qI.
200 conversiones.

- Predicción: dispersión del tiempo σ_t/t entre 0,6 % y 1,1 % (1/√N con N = C·ΔV/q ≈ 14 800 electrones → 0,82 %).
- Criterio: fuera de 0,4–1,6 %, la aproximación de disparo o la inyección están mal, y N8b no se interpreta.

## N8b · detección de eventos (simulación de comportamiento, Python, semilla fija)

Señal telegráfica de dos niveles con salto de 0,83 %, tiempos de residencia exponenciales de media τ en cada nivel, ruido
gaussiano por conversión. Detector: media móvil de M conversiones y disparador con histéresis a ±1/4 de salto alrededor del punto
medio. M se fija antes de mirar resultados como el menor entero con salto ≥ 5σ/√M. Dos lecturas: contra una referencia sin ruido
y contra un gemelo igual de ruidoso (σ·√2).

- Predicción (punto de trabajo actual: 30 µs por conversión, σ = 0,82 %): M ≈ 25 con referencia y ≈ 49 con gemelo. Con τ de 100
  conversiones (3 ms) se detecta menos del 60 % de las transiciones; hace falta τ ≥ 10·M conversiones (≈ 7 ms con referencia,
  ≈ 15 ms con gemelo) para detectar el 90 % con menos de un evento falso por segundo.
- Criterio de abandono del punto de trabajo actual: si ni con τ = 100 ms se alcanza 90 % de detección con menos de un evento
  falso por segundo.

## N8c · alternativa: más corriente y más capacidad

Tres en serie (5,5 nA) con un condensador añadido para que la conversión siga durando unos 25 µs (≈ 135 fF en total): unas 60
veces más electrones por conversión.

- Predicción: σ por conversión entre 0,08 % y 0,16 %; salto de 0,80 %; separación en una sola conversión mayor que 5σ con
  referencia y mayor que 4σ con gemelo. Con M = 1 se detecta el 90 % de las transiciones desde τ de 10 conversiones (0,25 ms).
- Lo que este bloque no cubre: ruido de la polarización (≈ 0,1 mV eficaces, común a DUT y gemelo), ruido del umbral del inversor,
  alimentación, y que la dinámica de una trampa real depende de la polarización y de la tensión de drenaje, que aquí cambia
  durante la descarga.
