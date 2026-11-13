# Protocolo de las rondas de ataque

Escrito el 2026-11-12 20:29 (hora de `date`), tras dos incidentes de la ronda 3. Nota de trabajo.

1. **Un agente, una carpeta, un prefijo.** Predicción escrita antes de correr (`*_PREREG.md`), con hora de `date`.
2. **El verificador trabaja sobre una copia de solo lectura.** Antes de lanzarlo se crea un árbol de trabajo de git aparte
   (`git worktree add`) o una copia con permisos de escritura retirados; su única carpeta escribible es la suya. No abre los
   informes de los agentes hasta fijar sus números con hora.
3. **Herramientas compartidas, en solo lectura.** El precheck local se monta en el contenedor en solo lectura salvo la carpeta de
   salida del propio agente. Si una herramienta no funciona así, el agente para y lo dice; no cambia el modo de montaje.
4. **Nadie borra nada**, ni lo suyo.
5. **Huellas antes de consolidar.** Se escribe `SHA256SUMS_<fecha>.txt` con las huellas de todos los archivos versionados de
   `experiments/`, y solo después se actualizan planes, catálogo y tabla de experimentos.
6. **Se consolida solo lo verificado.** Lo de un solo agente entra rotulado así.

## Incidentes del 2026-11-12

- **El verificador de la ronda 3 montó `local_flow` en lectura-escritura** para correr el precheck y borró un marcador temporal de su
  carpeta. Comprobado después: el repositorio `tt-support-tools` está limpio y sus informes conservan fecha del 17 de octubre. No hay
  indicio de cambio, pero el montaje iba contra su encargo.
- **`attack_xc57_59_61/c59_INFORME.md` «cambió en disco»** según su agente. Auditoría: su fecha de modificación es 19:18:18, la
  misma al segundo que `c57_INFORME.md` y `c_COMPARACION.md`, que el agente escribió al cerrar (informó el cierre a las 19:18). Lo más
  probable es que el aviso lo disparara su propia tanda final de escrituras. No hay una versión anterior con la que comparar (la
  carpeta entró en git a las 19:54), así que no se puede demostrar; el contenido es coherente de principio a fin y no hay ganchos
  configurados que editen archivos. Queda como **sin indicio de modificación ajena, no demostrado**.
