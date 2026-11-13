# XC-06 · Isla de Coulomb

Nota de trabajo, exploratoria. Clasificación y estado: fila XC-06 de [catálogo](../../README.md#catalogue) (Coulomb island).
Cómo se rellena este archivo: [`../PLANTILLA.md`](../PLANTILLA.md). Un plan no es un prerregistro: los prerregistros viven en
[`../preregistros/`](../preregistros/README.md), fechados antes de correr.

## 1. Ficha

**XC-06 · Isla de Coulomb.** Bloqueo de Coulomb → isla mínima dibujable → — → escalones en I–V → electrómetro, lógica de un
electrón → — → criogenia. **Expediente:** isla mínima 22–27 aF, 3,5–4,3 K; 300 K exigiría ~22 nm, y sky130 no ofrece barrera túnel
dibujable (ficha 3). Única vía: grano accidental entre dos nanogaps de XC-04.

**Replanteo del 2026-11-12 (cálculo).** Una isla dibujada (22–27 aF según `FRONTERAS`) da 3 meV de energía de carga: no bloquea
ni a 77 K. Un grano de 2 nm de radio dejado por la electromigración en el hueco tendría ~0,9 aF y ~92 meV: catorce veces la
energía térmica a 77 K, 3,5 veces a 300 K. La isla no se dibuja: se busca como pasajero de XC-05, midiendo en nitrógeno líquido
los contactos que quedaron abiertos. Es azar: se cuenta cuántos de N lo muestran.

**[corregido 2026-11-12 13:06] Ronda de ataque 1** ([resumen](../../experiments/RONDA_1_2026-11-12.md)): la cuenta de 92 meV es correcta (un agente), pero la familia viajaba con el contacto atómico de XC-05, que no sobrevive.

## 2. Lectura y piso

No hay instrumento en el chip que pueda verlo a temperatura ambiente, y el cálculo dice que no hay nada que ver. «lab» =
laboratorio de trabajo, sin publicar.

| Cantidad | Valor | De dónde |
|---|---|---|
| Isla mínima de li1, 0,17 × 0,17 µm | 26,5 aF; energía de carga 3,0 meV; 10 k_B·T a 3,5 K | `FRONTERAS_FISICAS_1105.md` ficha 3, **cálculo** (autocapacidad de disco en óxido, cota inferior), lab |
| Isla mínima de met1, 0,14 × 0,14 µm | 21,8 aF; 3,7 meV; 10 k_B·T a 4,3 K | mismo |
| Capacidad que pide 300 K | 3,1 aF → diámetro ≈ 22 nm | mismo |
| Referencia publicada | isla de 20 × 20 nm, capacidad total 6,3 aF, resuelta a 4,2 K | misma ficha (Prati), **leído por agente** |
| Barrera túnel dibujable | ninguna; el dieléctrico más delgado es el óxido de puerta de 4,1 nm, sin corriente medible | misma ficha, cálculo |
| Señal esperada a 300 K | ninguna | — |

Señal/piso: cero a temperatura ambiente. El observable real (escalones en I–V, oscilación con la tensión de una puerta lateral)
pide menos de 4 K y corrientes de pA: otro vehículo.

## 3. Explicación aburrida y controles

| Explicación aburrida | Control que la separa |
|---|---|
| Un escalón en I–V a 300 K es una trampa, un contacto o el óxido | Se atribuye a eso por defecto (ficha 3). La trampa tiene su lector propio en XC-19 |
| Lo que conduce entre electrodos es fuga, no túnel por la isla | La misma estructura sin isla: dos electrodos enfrentados a la misma distancia total |
| El efecto no escala como una capacidad | Islas de varios tamaños: el período en tensión de puerta debe ir como 1/C; si no escala, no es Coulomb |
| Acoplo capacitivo de la puerta lateral a los electrodos | Puerta lateral presente frente a ausente; puerta a dos distancias |

## 4. Referencia convencional (control científico, no filtro)

El transistor como electrómetro. El lector de XC-19 ya responde a una sola carga a temperatura ambiente: 0,305 mV en la puerta,
0,83 % del tiempo de descarga (**corrida** de modelo, [`CLAIMS.md`](../../docs/CLAIMS.md)). Para sentir un electrón, lo
convencional gana en este nodo y a esta temperatura, y el plan lo dice de entrada. La isla solo ofrecería algo distinto
(periodicidad exacta en carga) en frío.

## 5. Plan de pruebas

### 5.1 Sin silicio

1. Hecho (lab): cálculo de capacidad y temperatura para las islas mínimas.
2. Pendiente: extraer con Magic la capacidad de una isla dibujada con sus dos electrodos y su puerta lateral, y compararla con la
   cota de 22 a 27 aF; la real será mayor.
3. Pendiente: buscar el conductor aislado más pequeño que el proceso fabrica aunque no se dibuje como isla: un tapón de contacto
   suelto, un cruce mínimo de poly. Dimensiones: borde legal por buscar.
4. Pendiente: comprobar si una isla flotante de metal pasa DRC y antena (metal sin conexión) en los dos decks.
5. Pendiente: leer nosotros la fuente del transistor de un electrón en silicio (hoy **leído por agente**).
6. No depende de nosotros: la vía accidental (grano entre dos huecos) la decide XC-04.

### 5.2 Configuraciones a dibujar

Estructuras vírgenes, baratas, que se envían para medir en frío si alguna vez hay acceso. Valores: **propuesta**.

| Barrido | Valores | Pregunta |
|---|---|---|
| Lado de la isla | met1 0,14; 0,28; 0,56 µm. li1 0,17; 0,34 µm | La capacidad escala con el tamaño; fija qué temperatura pediría cada una |
| Separación isla–electrodo | 0,140 (met1) y 0,170 (li1), el mínimo; el doble | A estas distancias no hay túnel: mide la fuga que lo imitaría |
| Sin isla | electrodos a la distancia total | Control de fuga |
| Puerta lateral | a 0,14 y a 0,28 µm; ausente | Capacidad de puerta, que fija el período de una oscilación |
| Islas en serie | 1; 2; 4 | Una cadena sube el umbral de tensión; inútil sin barrera, pero es la forma publicada |
| Capa | met1, li1, poly (ancho mínimo: borde legal por buscar) | ¿Cuál da el conductor aislado más pequeño? |
| Tapón de contacto como isla | `mcon` o `licon` sin metal encima (legalidad por buscar) | El volumen conductor más pequeño del proceso `[?]` |
| Línea de XC-01 con dos cuellos (C) | la ya dibujada | Si los dos cuellos se abren, el tramo central es una isla accidental |

Primero: nada propio. El hueco ficticio de XC-04 y la variante C de XC-01 ya cubren lo que el digital puede leer.

### 5.3 En silicio

1. **Virgen:** en el digital solo se comprueba que cada estructura lee como abierto, con la precarga y descarga de XC-04.
2. **Calibrar y caracterizar:** fuga de la estructura sin isla, a dos temperaturas.
3. **Transformar:** no hay, salvo la variante C de XC-01 llevada a doble abierto.
4. **Observar** (vehículo especializado): I–V con fuente de pA y tensión de puerta lateral, a 4 K o menos.
5. **Clasificar:** abierto; fuga; oscilación periódica en tensión de puerta que escala con el tamaño (candidato); fallo de lector.

Vehículo que espera: dado accesible o encapsulado que tolere criostato, y pines analógicos cuya fuga a esa temperatura se conozca
`[?]`. Tiny Tapeout no entrega dados sin encapsular (**leído por agente**, pesca).

### 5.4 Criterio de muerte (borrador)

- **Positivo:** oscilación de corriente periódica en tensión de puerta, en frío, con período que escala con la capacidad entre
  tamaños, ausente en la estructura sin isla.
- **Negativo informativo:** a 4 K, con fuga conocida, ninguna isla conduce: confirma que no hay barrera túnel dibujable.
- **Inconcluso:** corriente sin periodicidad.
- **Fallo instrumental:** la fuga de pines o encapsulado tapa el rango de pA.
- **Sigue como expediente.** Lo movería un conductor aislado de unos 22 nm con dos barreras, o un grano accidental visto en XC-04.

## 6. Documentación para graduarse

- [ ] Prerregistro con predicción numérica y criterio de abandono
- [ ] Generador de layout por script, parametrizado
- [ ] DRC limpio en Magic (reglas completas) y en KLayout (deck completo, comprobaciones de front-end activas)
- [ ] Extracción y LVS dispositivo a dispositivo
- [ ] Netlist anotado con Residual
- [ ] Simulación contra la predicción, con su control
- [ ] Macro: pines en metal, LEF con obstrucciones, alimentación
- [ ] Datos de silicio, crudos y con su control
- [ ] Contrato: modelo, interfaz, límites, variabilidad, retención, modos de fallo, condiciones de formación
- [ ] Referencia convencional, donde ayude a identificar el mecanismo
- [ ] README en inglés

## 7. Compuertas y dependencias

- Vehículo especializado: criogenia y acceso de pA. En el digital solo viajan estructuras vírgenes de coste casi nulo.
- Depende de XC-04 (única vía física) y de XC-01 (variante C).
- Comparación obligada con XC-19, que hace de electrómetro convencional.
- Sin permisos de estrés propios. Comprobar antena y relleno sobre metal flotante.

## 8. Abierto y fuentes

- Si algún conductor aislado del proceso baja de la isla mínima dibujable `[?]`.
- Comportamiento del encapsulado y de los interruptores analógicos a 4 K `[?]`.
- Laboratorio, sin publicar: `FRONTERAS_FISICAS_1105.md` ficha 3 (Prati, Deshpande, Park, con sus enlaces). Cifras de XC-19:
  [`CLAIMS.md`](../../docs/CLAIMS.md).
