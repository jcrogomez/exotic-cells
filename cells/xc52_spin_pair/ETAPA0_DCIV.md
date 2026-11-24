# XC-52 · etapa 0 · DCIV en el chip: medir las trampas que el estrés crea

Abierto el 2026-11-24 a pedido de Juan («mete la medida DCIV como etapa previa en el chip»), tras
[W1](../../experiments/attack2_xc52/W1_RESULTADO.md), que quedó en `[?]`, inclinado a muerte. **Nota de diseño, no prerregistro.**
Los números de abajo son cálculo de diseño (`experiments/xc52_dciv/`). La predicción y los criterios irán en un prerregistro antes
de dibujar.

## Para qué

Decidir W1 con silicio. ¿El estrés que el chip puede darse (pfet con la puerta a −1,8 V, de 27 a ~85 °C, horas) crea
ΔNit ≥ 1e11 cm⁻²?
- **Si sí,** XC-52 tiene trampas.
- **Si no,** XC-52 muere en su forma de "trampas creadas en el chip".

Con un resultado o con el otro, es un dato de SKY130 que no está publicado: la generación de trampas de interfaz por NBTI a 1,8 V,
medida sin pasar por ΔVth.

## Cómo (DCIV, diodo con puerta)

| Modo | Puerta | S y D | Pozo n propio | Qué se lee |
|---|---|---|---|---|
| Lectura | barrido 0–1,8 V | VDD | VDD − VF (VF 0,2–0,4 V, polarización directa S/D–pozo) | corriente del pozo frente a la puerta: un pico sobre un fondo plano |
| Estrés | 0 V (Vgs = −1,8 V) | VDD | VDD | nada; calefactor de XC-57 encendido |
| Fijado | 0 V | VDD | VDD | se apaga el calefactor manteniendo el estrés ("locking-in" de Ryan 2009) |

- **Pareado:** el mismo dispositivo antes y después, más un gemelo sin estrés con el mismo lector. El gemelo cancela la deriva de VF,
  de la temperatura y del lector.
- **Qué se reporta:** la altura del pico sobre el fondo, después frente a antes, en el DUT y en el gemelo. ΔNit absoluto necesita
  σ, que no se conoce (1,5e-17–1e-15 cm²). Lo que no depende de σ es el cociente Nit_después/Nit_antes. Con Nit virgen ~1e10
  (literatura, b52), un cociente ≥ 10 corresponde a ΔNit ~1e11. Es inferencia: depende de que el Nit virgen de SKY130 sea ese `[?]`.

## Lo que ya salió (diseño, sin veredicto)

**Señal**, de `calc_dciv.py` → `calc_dciv.txt`, con la fórmula de Fitzgerald-Grove. A 27 °C, puerta de 100 µm² y VF = 0,30 V:

| Nit (cm⁻²) | Pico |
|---|---|
| 1e9 | 0,04–2,6 pA |
| 1e10 | 0,4–26 pA |
| 1e11 | 3,9–260 pA |

El intervalo de cada fila sale de σ. Cada +0,1 V de VF multiplica la señal ×6,9.

**Fondo**, de `fondo/` (ngspice, v2): corriente del pozo con S = D = VDD y pozo = VDD − VF, más el diodo pozo-sustrato aparte.
`resumen_fondo.txt`.
- La v1 de este cálculo estaba mal: `wrdata -i(a) -i(b)` lo lee ngspice como **una resta**, y su "228 pA" era la suma de los dos
  dispositivos.

| Dispositivo | Esquina | VF = 0,30 V | VF = 0,40 V | VF = 0,50 V | Pozo-sustrato |
|---|---|---|---|---|---|
| 10×10 µm (100 µm²) | tt 27 | 58,5 pA | 997 pA | 17,0 nA | 0,6 fA |
| 30×33 µm (1000 µm²) | tt 27 | 169 pA | 2,88 nA | 49,2 nA | 3,5 fA |
| 10×10 µm | tt 85 | 7,17 nA | 77,3 nA | 832 nA | 1,5 pA |

- El fondo es **plano en la puerta** (variación 0 en el barrido), porque el modelo no tiene trampas de interfaz. Lo que dependa de la
  puerta es lo que se busca.
- Viene de las uniones S/D–pozo: escala con W (el perímetro de S/D), no con el área de la puerta. Crece ×17 por cada +0,1 V de VF
  (idealidad efectiva ~1,36), frente a ×6,9 de la señal.
- Por tanto conviene **VF bajo y una puerta grande con L larga**. A tt 27 y VF = 0,30 V, Nit = 1e10 es:
  - un 0,7–44 % del fondo en 100 µm²;
  - un 2–150 % en 1000 µm².
- ΔNit = 1e11 multiplica esos porcentajes por diez. **El lector tiene que resolver ~1e-3 relativo entre puntos del barrido.**
- **La lectura se hace a temperatura ambiente:** a 85 °C el fondo sube ×120.
- La unión pozo-sustrato (en inversa, ~1,4 V) es despreciable: de fA a pA.

## Bloques que necesita y de dónde salen

| Bloque | Estado |
|---|---|
| Barrido de puerta 0–1,8 V sin pines analógicos (DAC en el chip) | lo mismo que el paso 4 del plan (polarización de la etapa b sin pines analógicos); sin diseñar |
| VF estable (pozo a VDD − VF) | sin diseñar. Una deriva de 10 mV mueve el fondo ~33 % (×17 por 0,1 V); lo cancela el gemelo si comparten el generador |
| Lector que **mantenga** el potencial del pozo mientras integra (cascodo y luego un integrador; la descarga de 0,9 V de XC-19 no sirve aquí) | sin diseñar. El rango de pA–nA es el de XC-20 (`experiments/xc20_lector/diseno`, en marcha) |
| Calefactor | XC-57 (`attack_xc57_59_61`) |
| Pozo n aislado por dispositivo, con su toma | dibujo |

## Lo aburrido que el prerregistro tendrá que cubrir

1. **Que el pico venga de otra cosa que dependa de la puerta:** GIDL, corriente de la unión de borde, fuga de puerta. Hacen falta
   dos controles: puerta a 0 V fija (sin barrido), y un dispositivo con el S/D sin polarizar.
2. **Que el estrés mueva VF o el lector y no Nit:** lo cubre el gemelo sin estrés.
3. **La recuperación:** leer con y sin enfriar bajo estrés.
4. **Que el corrimiento se deba a carga atrapada en el óxido y no a Nit:** DCIV no la ve como pico de recombinación, porque la
   carga solo desplaza el pico en la puerta, no cambia su altura. Por eso se mide altura, no posición.

## Siguiente

1. Hecho: el fondo pozo-sustrato y el dispositivo de 1000 µm². Falta: la dependencia en la puerta de GIDL y fugas de puerta en el modelo, con la puerta por encima de VDD − VF.
2. Prerregistro con el umbral de W1 traducido al cociente medible.
3. Pedir área en el tile: compite con el slot 2 o el 3 del 1×2 `[?]`. **Lo decide Juan.**
