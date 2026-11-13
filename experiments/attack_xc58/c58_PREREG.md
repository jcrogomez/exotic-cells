# c58 · Prerregistro del ataque a XC-58 (celda kT/C)

Hora de `date`: Thu Nov 12 19:04:45 EST 2026. Escrito antes de correr nada (solo se han leído el plan, el presupuesto, los README de XC-19 y el netlist
extraído). Familia nueva: no hay ronda 1.

## Qué voy a calcular o simular

| # | Qué | Cómo | Predicción (escrita antes) |
|---|---|---|---|
| A1 | Capacidad total del nodo de puerta flotante: lector 0,42/0,15 + interruptor nfet mínimo + hilo extraído (0,22 fF de VB a GND en `xc19_read.pex.spice`) | ngspice, modelo del PDK: escalón de carga conocido sobre el nodo aislado | 0,8–1,5 fF con interruptor mínimo; no se baja de 0,6 fF. Incertidumbre de proceso ±10–20 % (óxido, solape, unión): cálculo, no dato |
| A2 | Ganancia del lector con la puerta flotante (el drenaje baja 0,9 V y acopla por Cgd) | ngspice: tiempo de descarga para dos tensiones iniciales de puerta | La ganancia relativa se mantiene en 2,5–2,9 %/mV (=1/(n·kT/q)); el tiempo se alarga ×2–×20 a 1 fF porque la puerta cae 50–120 mV con el drenaje |
| A3 | Ganancia frente a temperatura | ngspice a 27 y 85 °C | La ganancia cae como 1/T (−0,3 %/K). Entonces la varianza RELATIVA DEL TIEMPO va como 1/T, no como T: la frase "proporcional a T" es falsa para el observable (cierta solo para la tensión) |
| B1 | Pedestal del interruptor (inyección + acoplo del reloj) | ngspice, transitorio, flanco de 50 ps a 5 ns, C = 1, 3, 10 fF | nfet mínimo sobre 1 fF: −60 a −250 mV (varias veces n·kT/q: saca al lector de su punto si no se compensa). Escala ~1/C. Sensibilidad a VDD del pedestal < 0,1 mV/mV con flanco lento |
| B2 | Fuga del nodo aislado | ngspice (.op/transitorio largo) a 27 y 85 °C. El modelo no tiene túnel de puerta ni GIDL en nfet (DATOS_PROCESO): lo que falte se barre 0,01–10 fA | Modelo: < 1 fA a 27 °C. Deriva < 0,03 mV en 30 µs y < 1 mV en 1 ms con 1 fF. A 85 °C, ×30–×300 |
| C1 | Varianza congelada frente a kT/C con flanco finito | Monte Carlo propio (Langevin, interruptor EKV calibrado a ngspice, ruido 2q(If+Ir), acoplo del reloj), C = 1, 3, 10 fF, flancos 10 ps–10 ns | Entre 0,5 y 1,0 de kT/C. Con flanco más lento que RC: 0,85–1,0 a 1 fF y → 1,0 a 10 fF, casi independiente del flanco (depende de n·Cov/C). Nunca > 1,05 |
| C2 | Si es viable: ruido transitorio en ngspice sobre el extraído con interruptor | fuente trnoise equivalente | Si corre: dispersión del tiempo dentro de ±30 % de σV/(n·kT/q) (pocas muestras) |
| D1 | Correlación entre muestras sucesivas | cálculo + MC: ruido lento del nodo de polarización (Cf = 10 pF), memoria por reparto de carga Cg/Cf, alimentación | ρ(1) < 1e-3 a 1 fF; crece ~C: ~1e-2 a 100 fF. Alimentación sin gemelo: 1 mV eficaz de rizado → ~1 % de la varianza, correlado |
| D2 | Entropía mínima por muestra | cálculo: gaussiana cuantizada por el contador | 5–8 bits ideales por muestra a 1 fF con reloj de 50 MHz [?]; tras descontar lo determinista/atacable, declarar ≤ 1–3 bits |
| E1 | Termómetro | cálculo | Sensibilidad de la varianza relativa del tiempo: −0,33 %/K (no +0,33). 1 K pide ~1,8e5 conversiones. Sin calibrar C: error ±10–20 % ≈ ±30–60 K. El cociente entre dos capacidades cancela ganancia Y temperatura: da C2/C1, no T |
| F1 | Mapa de regímenes | cálculo con lo anterior | kT/C manda de ~1 a ~30 fF con periodo < 1 ms; lector por encima de ~100 fF; fuga por encima de 1–100 ms; por debajo de ~0,6 fF no se llega |

## Qué mataría la idea
- Varianza congelada que no escale como 1/C por un término mayor que kT/C (ruido del interruptor ∝1/C² dominante en todo el rango alcanzable).
- Pedestal cuya variación de muestra a muestra (por alimentación o trampas) supere σ(kT/C) en todo el rango de C.
- Fuga del nodo tal que la deriva en una conversión supere la señal a 27 °C.
- Ganancia del lector que no se mantenga con la puerta flotante.

## Qué la dejaría viva
Varianza en 0,5–1,05 de kT/C con ley 1/C en 1–30 fF, pedestal determinista compensable, fuga despreciable en 30 µs.

## Qué se deduce ya sin correr (tautologías)
- kT/C = 4,14e-21 J / C: 2,03 mV a 1 fF, 0,64 mV a 10 fF (300 K). En electrones: √(kTC)/q = 12,7 e a 1 fF, 40 e a 10 fF.
- Un electrón sobre 1 fF son 0,16 mV: una trampa del interruptor que suelte un electrón tras abrir mueve 0,08 σ.
- τ = RC del interruptor cerrado (kΩ × fF) ≈ 10 ps: cualquier flanco real de reloj es más lento; el caso "apertura instantánea" no existe en el chip.
- El cociente de varianzas entre dos nodos a igual T es C2/C1 por construcción: no contiene T.
- Varianza al 1 % → N = 2/0,01² = 20 000 muestras (gaussiana), con independencia de todo lo demás.
