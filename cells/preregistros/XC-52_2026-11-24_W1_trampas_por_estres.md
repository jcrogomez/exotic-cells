# XC-52 · W1 · ¿crea el estrés posible en el chip trampas paramagnéticas suficientes? (prerregistro de lectura)

Escrito el 2026-11-24 12:19:29 EST (`date`), antes de leer los textos completos. Frente W1 de
[`CANDIDATURA.md`](../xc52_spin_pair/CANDIDATURA.md). Solo lectura de literatura: no se corre nada.

## Pregunta

Con el estrés que el chip puede aplicarse a sí mismo, ¿cuántas trampas de interfaz paramagnéticas (Pb0/Pb1) se crean en horas, y
alcanza para la respuesta de espín publicada?
- **NBTI en pfet:** puerta a −1,8 V sobre 4,15 nm, es decir ~4,3 MV/cm; de 27 a ~85 °C con el calefactor de XC-57.
- **HCI en nfet:** a 1,8 V.

## Umbral, fijado antes de leer

- **Referencia:** la respuesta de espín (NZFMR/EDMR/SDR) se ha reportado tras dañar el óxido hasta Dit ~1e11–1e12 cm⁻², y no en
  óxido virgen (~1e9–1e10). Valores de `attack2_xc52/b52_INFORME.md`, fila «Trampas»; se verifican en el texto completo.
- **Sigue:** al menos una fuente de texto completo da, a ≤ 4,3 MV/cm (o con una ley de extrapolación publicada desde campos
  mayores), ≤ 85 °C y ≤ 10 h, **ΔNit ≥ 1e11 cm⁻²**, con identificación de Pb por resonancia en estreses comparables.
- **Muere (como "trampas creadas en el chip"):** todas las fuentes aplicables dan **ΔNit < 3e10 cm⁻²** en esas condiciones.
- **Entre 3e10 y 1e11**, o sin fuente en condiciones comparables: `[?]`. Se dice qué medida lo cerraría.
- **Aburridas que hay que descartar en la lectura:**
  - que el ΔVth de NBTI a campo bajo sea carga atrapada en el óxido y no Nit (Pb);
  - que la recuperación al quitar el estrés borre Nit antes de medir;
  - que la sensibilidad de NZFMR publicada (< 1000 defectos) sea para un área o un detector que no tenemos.
- **Regla:** DOI comprobados en Crossref. Cifras solo de textos leídos, con su grado (leído / resumen). Las extrapolaciones son
  mías y se marcan como inferencia.

Estado: **congelado** al guardar su SHA-256 en `experiments/attack2_xc52/PREREG_SHA256.txt`.
