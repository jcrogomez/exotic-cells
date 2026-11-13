# Auditoría LOD/STI · ¿llega la geometría al modelo? (BORRADOR, 2026-11-11, sin commit)

Escrita por un agente (chat de Claude) a petición de la revisión externa del 2026-11-11. Parte estática hecha; la corrida está
pendiente porque no hay ngspice ni Magic en la sesión (ni en el contenedor ni en la VM del escritorio).

## Verificado (lectura de archivos del PDK local, `local_flow/pdk_host/.../8afc8346.../sky130A`)

1. `libs.ref/sky130_fd_pr/spice/sky130_fd_pr__nfet_01v8.pm3.spice`, línea 39: el subcircuito declara por defecto
   `sa = 0 sb = 0 sd = 0` y los pasa a la instancia.
2. `libs.tech/magic/sky130A.tech`, línea 5948: la extracción de `nfet_01v8` emite `l w as ps ad pd`. **No emite `sa`, `sb` ni `sd`.**
3. `libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice`: 0 instancias con `sa=`. Las celdas estándar se simulan sin esos parámetros.
4. Tarjeta `nfet_01v8__tt.pm3.spice` (180 bins): `kvth0 = 9.8e-9`, `ku0 = -2.7e-8`, `wkvth0 = 2.0e-7`, `wlodvth = 1.0`, `kvsat = 0.2`;
   `lkvth0 = pkvth0 = lku0 = wku0 = pku0 = wlod = stk2 = steta0 = tku0 = 0`; `saref = sbref = 1.04e-6` en los bins de L 0,15–0,18 µm
   y W 0,36–0,52 µm. No aparecen `wpemod`, `kvth0we` ni `stimod`.

**Conclusión estática:** los coeficientes de estrés están poblados, pero con este archivo de tecnología un netlist extraído por Magic
llega al simulador con `sa = sb = 0`. Según la revisión externa (manual BSIM4, no releído por este agente), eso apaga el modelo de
estrés. Falta confirmarlo con una extracción real.

## Predicción escrita antes de correr (cálculo a mano; ecuaciones BSIM4 de memoria, `[?]` hasta cotejar con el manual)

ΔVth = kvth0 / K · (1/(SA+L/2) + 1/(SB+L/2) − 1/(saref+L/2) − 1/(sbref+L/2)), con K = 1 + wkvth0 / W.
Movilidad: u0 · (1 + ku0·(1/(SA+L/2)+1/(SB+L/2))) / (1 + ku0·(1/(saref+L/2)+1/(sbref+L/2))).

| W / L (µm) | SA = SB (µm) | ΔVth predicho | Δ movilidad predicho |
|---|---|---|---|
| 0,42 / 0,15 | 0,30 | +23,5 mV | −10 % |
| 0,42 / 0,15 | 3,0 | −7,6 mV | +3,2 % |

Rango entre ambos: ~31 mV y ~13 % de movilidad. Con W grande K → 1 y el rango de umbral sube hacia ~46 mV, mientras el desajuste
baja: **la matriz G-LOD debería usar transistores anchos.** Desajuste de sky130 (A_VT): `[?]`, sale de los archivos `mismatch` del PDK.

## Corrida pendiente (cuatro pasos, con criterio)

1. ngspice, esquemático: `nfet_01v8` W/L fijo, `sa=sb` ∈ {0; 0,3; 1,04; 3,0} µm. Medir Vth e Id. **Criterio:** si `sa=sb=0` da lo mismo
   que `sa=sb=1,04` (referencia), el modelo está apagado por defecto; si los valores no siguen la tabla ±20 %, la fórmula de arriba
   está mal y se corrige antes de seguir.
2. Magic: dos layouts legales con la misma W/L y distinta longitud de difusión. Extraer. **Criterio:** si los dos netlists son
   idénticos salvo `as/ad/ps/pd`, el flujo pierde la información (brecha confirmada).
3. Anotar `sa/sb` a mano en el netlist extraído y repetir el paso 1: esa diferencia es lo que hoy se pierde.
4. Monte Carlo de desajuste (`mc_mm_switch`) para el mismo W/L: fija cuántas réplicas hacen falta para ver el efecto.

Si el paso 2 confirma la brecha, el primer módulo de `tools/` queda definido: leer el layout, calcular `sa/sb/sd` por instancia y
anotarlos en el netlist.

## Corrida hecha (2026-11-11 20:44–20:47 EST, hora de `date`)

Pasos 1, 2 y 4 ejecutados; el 3 se deduce de 1 y 2. Predicción cumplida al 0,1 mV y brecha confirmada. Resultados, archivos y
reproducción: `macros/grabado_lod/LEEME.md` (único lugar de esos números).
