# Filosofía de MISFIT y Exotic Cells

## Propuesta v2 (2026-11-12 11:39 EST, hora de `date`) — pendiente de que Juan la confirme

Redactada por el agente a partir de frases de Juan, que van citadas. La frase es suya; la redacción de la regla, no. Lo que no
esté aquí no es regla del proyecto.

1. **Otro camino.** MISFIT no es convencional y no se mide contra lo convencional ni se justifica ante ello.
   *"es otro camino no convencional"; "en lugar de mosfet, MISFIT es el chip".*
2. **Romper las reglas con estilo.** El espacio de configuraciones de SKY130 tiene tres regiones: lo que se puede hacer con
   celdas estándar, lo que falla, y una tercera que no es ni lo uno ni lo otro: un comportamiento físico usable y no
   convencional. Esa tercera región es el objetivo. Definición de Juan (2026-11-12): *"tienes todo el espacio de configuraciones
   de Sky130, dentro de ese tienes todo lo que sí se puede hacer con standard cells, todo lo que falla, y otro que no son ni
   standard cells y no es que falle sino que hace un comportamiento físico usable no convencional, puede ser cuántico, puede ser
   magnético, óptico, spin, cargas únicas, frecuencias o algo aleatorio que aporte a lo convencional o un puente entre clásico
   cuántico, no lo sé, pero algo interesante de fabricar".*
3. **Lo indeseable es la materia prima.** Errores, fugas, defectos, huecos de modelo, rarezas documentadas del proceso y de sus
   materiales. *"errores o comportamientos indeseables de sky130 documentados que nos puedan servir, uso de materiales".*
4. **El silicio real manda.** Cada idea se dibuja en muchas configuraciones para ver qué hace de verdad.
   *"ver el comportamiento físico del silicio real a diferentes dimensiones, relaciones de aspecto".*
5. **Llenar el chip.** *"la idea de este chip es hacer la mayoría de test que valgan la pena y quepan".*
6. **Primero se añade; se filtra al final.** Las familias nuevas siempre entran. Nada se descarta hasta agotar pruebas,
   simulaciones e ideas. *"vale la pena meter familias nuevas, es toda la idea del chip"; "ahorita estamos añadiendo al
   catálogo, después filtramos".*
7. **Simular la física, no solo el circuito.** Fabricación, litografía, calor, campos, luz. Los modelos del PDK describen lo
   normal. *"simulaciones pero más físicas, aunque sea del proceso de fabricación".*
8. **Cada celda, su carpeta, su plan de pruebas y su documentación.** *"estructuremos bien cada una en una carpeta, hagamos todo
   su plan de testing y de documentación".*
9. **Abierto.** *"que sea open".*
10. **No asumir: preguntar.** Una restricción existe solo si Juan la dijo. *"no asumas, pregunta".*
11. **No inventar.** `[?]` gana a una respuesta fluida y falsa. Lo latente juzga, lo determinista demuestra. Elimina primero la
    explicación más aburrida. Un hecho vive en un solo lugar. Predicción antes de correr, y siempre contra un control.
    (Reglas de Juan en su `CLAUDE.md`.)

### Añadido 2026-11-12 13:34 EST (hora de `date`) — de un texto externo pegado por Juan; pendiente de que lo confirme con sus palabras

12. **Control científico sí; comparación comercial no.** Un control demuestra que la señal no es calor, parásitos ni ruido del
    instrumento: es indispensable. Exigir que una celda supere a una NAND, un oscilador o una resistencia antes de explorarla es un
    filtro artificial: no se pide.
13. **La tercera región no nace solo de fallos.** También hay comportamientos útiles en configuraciones legales y reproducibles que
    la biblioteca nunca contempló.
14. **El espacio es G × M × P × U × E**: geometría, materiales e interfaces, historia de fabricación y formación, excitación, y
    entorno. La misma estructura puede ser convencional bajo una polarización, fallar bajo otra y ser usable en una tercera. Se
    buscan fronteras, transiciones de régimen y cambios de estabilidad, no una lista de dispositivos posibles o imposibles.
15. **El catálogo queda abierto sin límite.** Cada candidato nuevo recibe identificador, mecanismo, hipótesis y pruebas
    discriminantes. Nada se borra ni se renumera.
16. **Formar es investigar.** Electromigración, estrés, ruptura y sobretensión son rutas legítimas. Lo que un vehículo no permita
    queda como candidato para otro.

**Actualización 2026-11-12 13:57:** Juan pegó un segundo texto externo que dice «adopto» las reglas 12–16 y las tres condiciones de abajo.
Quedan aplicadas como **adoptadas vía texto pegado en respuesta a la pregunta del agente**; Juan no las ha escrito con sus palabras.
La distinción que ese texto fija: investigar fuera de los modelos, litografía submínima, defectos, ruptura y precursores inciertos,
sí; tratar un precheck incompleto como permiso, o enviar lo que incumple reglas obligatorias del vehículo sin autorización de la
fundición, no; formar, estresar y sobretensionar, sí, en un vehículo y con un procedimiento adecuados. Tiny Tapeout es el primer
vehículo, no el límite del catálogo.

Las tres frases en cuestión (se parecen a la regla 8 que Juan retiró): "no confundir explorar con enviar
geometrías que incumplan requisitos obligatorios de fabricación", "un precheck incompleto no concede autorización" y "en hardware
real, solo con permisos aplicables".

## Reglas anteriores (v1, redactadas por el agente el 2026-11-04)

Se conservan como historia. **Retiradas por Juan:** la 8 ("yo nunca dije eso"), la 11 ("una abominación... un atentado contra mi
filosofía") y la 13 (el sombrero es otro proyecto y no tiene que ver con MISFIT). Las demás no rigen salvo que Juan las recupere.

**Aviso (2026-11-12): estas reglas las redactó el agente.** Solo tres coinciden con reglas que Juan tiene en su `CLAUDE.md` (5, 6 y
14). Las demás salieron de textos externos pegados o del propio agente, y varias no tienen origen pese a lo que decía este
párrafo. Ninguna es de Juan hasta que él la confirme con sus palabras. La 8 fue retirada por él.

1. **El GDS dibuja un precursor; el dispositivo lo termina la física.** En la fundición (ruta A: litografía, dopado, grabado, plasma,
   metalización, pasivación, que no controlamos pero sí provocamos) o en la mesa (ruta B). Se diseñan trayectorias de transformación, no
   solo formas. Origen: la tesis de Exotic Cells reinterpretada (texto externo, 4-nov); corrección de la noche: la formación no es solo de mesa.
2. **Una celda es exótica si usa lo que la biblioteca no ofrece como primitiva.** Fugas, degradación, defectos, parásitos. No se exige
   novedad absoluta antes; se evalúa después contra la literatura. Se gradúa a biblioteca cuando tiene contrato funcional (modelo, interfaz,
   límites, variabilidad, retención, fallos, condiciones de formación).
3. **Observabilidad antes que sorpresa.** Ningún precursor entra sin saber cómo se lee, con qué piso y a qué régimen. Lo que no supere
   el 1 % de su observable no entra. Origen: el error de los 20 ps que eran 1,8.
4. **El control no acompaña al experimento: lo constituye.** Virgen gemelo, Fantasma vecino, ficticio que disipa igual, guarda conmutable.
   Sin control, el resultado no se interpreta después de fabricar.
5. **Elimina primero la explicación aburrida.** Difusión de portadores antes que fotones; contacto antes que cuello; driver antes que
   dispositivo; gradiente del dado antes que geometría. Origen: regla del brain, confirmada cuatro veces hoy.
6. **Lo latente juzga, lo determinista demuestra.** Un número existe si sale del PDK, de una corrida reproducible o de una fuente leída;
   si no, `[?]`. Un DRC limpio no es un dispositivo; una frecuencia no es un mecanismo. Origen: Magic, KLayout y ngspice de hoy.
7. **Cuatro estados de resultado**, no dos: positivo, negativo informativo, inconcluso, fallo instrumental. Los no transformados son datos
   censurados, no se descartan. Un negativo solo informa si se conoce la sensibilidad.
8. **(Retirada el 2026-11-12 por Juan: "quita esa regla, yo nunca dije eso".)** Decía que todo lo enviado pasa DRC y LVS y que lo
   exótico ocurre solo en la mesa. La escribió el agente sin origen. El número no se reutiliza.
9. **Un canal completo antes que una matriz.** Herramienta antes que carga. La cantidad de estructuras la fija el área real de un canal con
   drivers, retorno, lectura, protección y separación. Origen: EFLD-00.
10. **La ruta de formación no es la ruta de lectura.** Un driver estresado no es referencia metrológica.
11. **(Retirada el 2026-11-12 por Juan.)** Decía que el chip debe poder concluir que lo convencional gana.
12. **Escalera de vehículos alineada con lo que se sabe hacer.** El flujo digital con macros pasivos ensaya la plataforma y forma; el chip
    híbrido con pines analógicos identifica (I–V, temperatura, ruido). Nada espera a dominar lo que aún no se domina.
13. **(Retirada el 2026-11-12 por Juan.)** Hablaba del sombrero, que es otro proyecto.
14. **Un hecho vive en un solo lugar.** Pesca con fuente, decisiones fechadas con lo que las revertiría, errores propios registrados para no
    repetirlos.
15. **No explorar solo lo que el proceso permite fabricar: explorar lo que el proceso provoca.** Antena en el grabado por plasma,
    proximidad, orientación, esfuerzos, interfaces de contactos y vías. La Fragua crea defectos después; esta regla aprovecha los que la
    fabricación ya dejó. Origen: síntesis externa del 4-nov (noche), que recuperó el primer texto.

**Errores de este documento ya corregidos:** "banda de decap como separación térmica" (v0.2 del layout) era falso: el decap ayuda con la
alimentación y almacena energía; no es barrera térmica. La separación térmica se decide con análisis, no con rectángulos.
