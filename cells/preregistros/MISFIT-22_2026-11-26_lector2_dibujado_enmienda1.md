# MISFIT-22 · enmienda 1 · dos reglas de contacto

Escrita el 2026-11-26 (hora en `experiments/misfit22/PREREG_SHA256.txt`), después de la pasada 1 y antes de la 2.

**Pasada 1** (`experiments/misfit22/pasada1/`, se queda): LVS casa a la primera. Magic 2 reglas, KLayout 7 en cada deck:

- `li.5`: el interconectado local sobresale 0,02 µm del contacto por un extremo; hacen falta 0,08 en los dos. Error mío al
  copiar el patrón de los puestos (allí el li pasa 0,02 del borde de la difusión, que son 0,08 del contacto).
- `licon.9 + psdm.5a`: el contacto de la barra de puerta queda a 0,21 µm de la difusión p; hacen falta 0,235.

**Cambio:** los tramos de li se alargan 0,06 µm por el extremo corto; la barra de puerta pasa de 0,33 a 0,36 µm de alto y
su contacto sube 0,03. Nada más. Predicciones L1–L5 sin tocar. Cuenta de enmiendas: 1 de 3.
