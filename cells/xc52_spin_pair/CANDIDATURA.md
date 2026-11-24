# XC-52 · candidatura a un slot del 1×2

Abierto el 2026-11-23 (`date`: 17:38 EST) a pedido de Juan: "hagamos el esfuerzo para que sea candidato". **Nota de trabajo,
no prerregistro.** Cada frente que produzca un número se prerregistra aparte antes de correr. Grados: **PDK**, **leído** (texto
abierto), **resumen** (solo abstract), **corrida**, **memoria**, `[?]`.

## Por qué vale el esfuerzo

Es la tercera región de Juan en su forma más pura: un efecto de espín a temperatura ambiente en silicio digital, sin material
magnético, leído con pines digitales. El ataque 2 ([`b52_INFORME.md`](../../experiments/attack2_xc52/b52_INFORME.md)) dejó vivas
T2 (se distingue de lo clásico, salvo lo par en B: decide la forma frente al campo), T3 (devanado cruzado met3/met4) y T6 (cabe:
~8 100 µm², 5 700-16 200 `[?]`).

## Frentes, en el orden en que pueden matarlo

| # | Frente | Qué lo mata | Estado |
|---|---|---|---|
| W1 | **Trampas que respondan.** Si el óxido virgen no responde (Harmon: "ni NZFMR ni EDMR antes de dañar", leído en a52/b52), crearlas en el chip con el estrés de XC-10 a 1,8 V: NBTI en pfet (puerta a −1,8 V, con el calefactor de XC-57 para +10-60 K) y HCI en nfet. Diseño pareado: el mismo dispositivo antes y después del estrés, con un gemelo sin estrés. Así un nulo deja de ser mudo: si la señal no crece con las trampas creadas, el efecto no está, no "faltaban trampas" | que el estrés posible a 1,8 V (4,3 MV/cm en 4,15 nm) no cree centros paramagnéticos en número suficiente en horas | **resumen:** los defectos de NBTI en pMOSFET de SiO₂ son Pb0/Pb1 (enlaces colgantes de interfaz, paramagnéticos), observados por SDR (Lenahan, Campbell y col.). Sensibilidad de NZFMR < 1000 defectos en arreglos (Allridge y Lenahan 2023). Falta: campo y temperatura de sus estreses frente a los nuestros, y ΔDit a 4,3 MV/cm `[?]` |
| W2 | **Corriente de la bobina.** 5,4 mA para ±2 mT (0,373 mT/mA, verificado en a52) | caída de alimentación que imite la señal | **aritmética:** un 1×2 recibe el interruptor `ll_2` ([`tt_power_gate`](../../experiments/tt_power_gate/README.md)): 0,89 Ω en tt → 4,8 mV a 5,4 mA, solo el transistor. Con el puente a potencia constante de los cuatro estados (T1/T3) la corriente es la misma en los cuatro, así que la caída se cancela a primer orden; queda la asimetría del puente `[?]`. Electromigración: tope 10,2 mA en la pista de 1,5 µm (a52). Falta: drivers, vías y retorno extraídos |
| W3 | **Lector integrador.** ΔV ≥ 0,5 V y comparador ≤ 0,3 mV, a 1,1-1,3 veces el ruido de disparo (T5) | que con el ruido 1/f real no converja el promedio a 1e-5-1e-4 | sin diseñar. El de XC-19 no sirve tal cual (su nodo es de 133 fF y su señal un cociente de tiempos, no una corriente de pA-nA) `[?]`: comprobarlo antes de diseñar otro |
| W4 | **Protocolo de cuatro estados en el núcleo.** Secuencia a potencia constante, 5 Hz-5 kHz | que no quepa en el RTL o en los pines | sin diseñar; el núcleo hoy no conmuta bobinas |
| W5 | **Discriminación.** Espín (satura, anchura 0,15-0,5 mT) frente a clásico par en B (cuadrático) y calor, con el lector y el protocolo reales | que la forma no se separe en un tiempo de medida razonable con la anchura real | el simulador de discriminación (prerregistro pedido por Juan el 2026-11-23) se escribe genérico: XC-19 con RTN primero, XC-52 segundo |

## Qué no se reclama

- Que SKY130 tenga trampas paramagnéticas: es `[?]` hasta el silicio.
- Que el estrés a 1,8 V cree Pb en horas: los estreses publicados que leí solo en resumen no dicen campo ni temperatura.
- El tamaño de la señal, 1e-4 a 1e-3, sigue siendo de memoria (P6 del ranking).

Fuentes de W1 (resumen, no texto completo): [NBTI, an atomic-scale defect perspective](https://pure.psu.edu/en/publications/nbti-an-atomic-scale-defect-perspective/),
[SDR y flúor en NBTI](https://pure.psu.edu/en/publications/spin-dependent-recombination-study-of-the-atomic-scale-effects-of/),
[sensibilidad absoluta de NZFMR](https://pure.psu.edu/en/publications/on-the-absolute-sensitivity-of-near-zero-field-magnetoresistance-/).
Por la regla del repo, verificar DOI en Crossref antes de citarlas en público.

## Estado de W1 (2026-11-24)

- Lectura prerregistrada: **`[?]`, inclinado a muerte** ([`W1_RESULTADO.md`](../../experiments/attack2_xc52/W1_RESULTADO.md)).
- A ~3–4,3 MV/cm, las medidas directas, extrapoladas, dan ΔNit ~1e9, y el modelo ~5–7e10. Ninguna llega al 1e11 donde se ha visto
  la respuesta de espín.
- La medida que lo decide (ΔNit por DCIV antes y después del estrés en el propio chip) cabe como etapa previa de XC-52.
