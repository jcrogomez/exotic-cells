# MISFIT-15 · XC-20: qué tensión ve la unión en su puesto y si la selección aísla · resultados

Prerregistro: [`MISFIT-15`](../../cells/preregistros/MISFIT-15_2026-11-26_xc20_tension_y_seleccion.md) y sus enmiendas
[1](../../cells/preregistros/MISFIT-15_2026-11-26_xc20_tension_y_seleccion_enmienda1.md),
[2](../../cells/preregistros/MISFIT-15_2026-11-26_xc20_tension_y_seleccion_enmienda2.md) y
[3](../../cells/preregistros/MISFIT-15_2026-11-26_xc20_tension_y_seleccion_enmienda3.md), todos sellados y subidos antes de
su pasada. Tabla completa: `m15.txt`. Todo es modelo (ngspice, PDK sky130A); nada es silicio.

## Lo aburrido primero

- **Hicieron falta cuatro pasadas y tres fueron inválidas.** La 1 y la 2 no convergieron (islas flotantes atadas por fugas
  de fA); la 3 falló el testigo. Solo la cuarta se juzga. Las tres primeras están en `pasada1/`, `pasada2/`, `pasada3/`.
- **El modelo no tiene túnel.** La corriente "de túnel" la inyecto yo con dos formas, I0·(V/1,8) y I0·(V/1,8)³. Los
  resultados acotan el circuito, no la unión.
- **Las direcciones se deducían de lo ya sabido** (un nfet de paso pierde un umbral; un interruptor abierto fuga más que un
  diodo pequeño). Lo nuevo son los tamaños en 4 esquinas, y un hallazgo de herramienta que no esperaba (abajo).
- **Dos predicciones dejaron de ser a ciegas en una esquina:** vi los V_j de ff −40 de la pasada 3 antes de la 4 (enmienda 3).
- **El equilibrio es una interpolación** sobre una malla de 2 mV, no una solución del resolvedor. Ningún veredicto queda a
  menos de 5 mV de su borde (el más justo: K2 a ss 85, 0,996 V contra 0,85).
- **Los buses de 7 puestos son aritmética** sobre puestos sueltos, no el subcircuito extraído. El pozo de la topología B es
  un supuesto (112 µm², 64 µm); no está dibujado.
- **El interruptor es el de esquemático,** sin cableado ni desajuste.

## Hallazgo de herramienta: el área del diodo extraído entra sin escalar

El testigo de la pasada 3 leyó 21,7 µA con 100 nA inyectados. Causa (corrida, `diag/`): la extracción escribe el diodo como
`area=1.4e+12 perim=4.8e+06`, y ngspice 44.2 con el `spinit` del PDK usa ese número tal cual: 3,85 mA de corriente inversa y
1,09 mF a 30 °C. Con `area=1.4 pj=4.8` da 6,73 fA y 1,26 fF. Por qué no se aplica el escalado: `[?]`.

- **Regla desde hoy:** un netlist extraído con diodos no se simula sin reescribir el área (µm² como número) y comprobar la
  capacidad. El LVS no se ve afectado.
- **Revisado en el repo** (`git grep`): `lab/macros/photon` y `xc52_dciv/fondo` usan µm² como número, bien.
  `experiments/verify_r4_nodo/v4n_dickson.py` usa `area=100e-12`, que para este modelo son 10⁻¹⁰ µm²: su diodo de pozo
  **no pesaba nada**. Esa verificación queda pendiente de repetir; lo que concluía no se toca hasta entonces `[?]`.

## Resultado (pasada 4, válida: testigo 99,995 nA, mutante 2,5 fA, capacidad del diodo 1,05–1,47 fF)

Topología **A** (la dibujada en MISFIT-14): X – interruptor – isla n+, ánodo a sustrato. Topología **B** (pozo n, sin
dibujar): pozo en X, isla p+ – interruptor – GND.

| # | Predicción | Veredicto |
|---|---|---|
| K1 | Diodo del PDK < 100 pA a 1,8 V en las 4 esquinas | **cumplida**: 4,7 fA (tt 27), 2,0 aA (ff −40), 2,5 pA (85 °C). El p+/pozo n: 2,5 fA, 1,8 aA, 4,4 pA |
| K2 | A, 1 µA óhmico: V_j entre 0,85 y 1,30 V | **cumplida**: 1,035 / 1,067 / 0,996 / 1,148 V |
| K3 | A, 10 nA óhmico: V_j < 1,45 V | **cumplida**: 1,17 a 1,32 V |
| K4 | B: V_j ≥ 1,75 V hasta 1 µA y ≥ 1,60 V a 10 µA | **cumplida**: 1,799 V hasta 1 µA; 1,786 V como poco a 10 µA |
| K5 | Sin aislamiento para celdas ordinarias: no sel./sel. ≥ 0,5 en todo | **falsa**: A da 0,92 / 0,46 / 0,26 / 0,90 y B da 1,00 / 1,00 / 0,22 / 1,00 (tt 27, ff −40, ss 85, ff 85) |
| K6 | Con aislamiento para 1 µA: ≤ 10⁻³ en frío y ≤ 3·10⁻² a 85 °C | **cumplida** con mucho margen: 5·10⁻⁹ a 4·10⁻⁵ |
| K7 | Testigo 97–103 nA; mutante < 1 nA | **cumplida** |
| K8 | A, 1 µA con forma cúbica: I_X/I0 entre 0,12 y 0,35 | **cumplida**: 0,19 a 0,28 |

**Qué dice:**

1. **En el puesto dibujado la unión no ve 1,8 V.** Ve entre 0,88 y 1,65 V según la esquina **y según su propia corriente**:
   a tt 27, 1,44 V con 1 pA, 1,19 V con 10 nA, 1,04 V con 1 µA y 0,93 V con 10 µA. El lector recibe del 55 al 64 % de la
   corriente nominal si la unión es óhmica y del 19 al 28 % si es cúbica. Una polarización que depende de lo que se mide
   no sirve para identificar el mecanismo.
2. **Con el interruptor abajo (B) la unión ve la tensión de X** dentro de 1 mV hasta 1 µA y de 14 mV a 10 µA, y el lector
   recibe del 97,7 al 100 % de la corriente.
3. **Una celda que conduce se aísla bien.** Abierta, deja pasar la fuga del interruptor: 87 fA (tt 27), 3 fA (ff −40),
   1,0 pA (ss 85), 28 pA (ff 85). Con 63 vecinas abiertas en ff 85 serían 1,8 nA de fondo (aritmética): pesa en la década
   baja del lector 2.
4. **Una celda ordinaria casi no se selecciona.** K5 es falsa tal como la escribí: a ss 85 el interruptor abierto fuga menos
   que el diodo y la selección cambia la corriente por 4. Pero en ningún caso pasa de un factor 4,5, y a tt 27 y ff 85 es
   de 0 a 10 %. Y la corriente en juego (fA a pA) queda cinco órdenes bajo el rango bajo del lector 2 (100 pA).

## Decisiones (por la regla escrita y por delegación)

- **K2 cumplida → la variante en pozo n con el interruptor abajo pasa a ser la principal** y es lo siguiente que se dibuja.
  La de sustrato (MISFIT-14) se queda como control de polaridad, con su tensión real declarada. *La revertiría* que la
  variante en pozo n no salga legal en matriz o que su pozo cargue X más de lo que el lector admite.
- **K5 falsa → la regla de "muere el bus compartido" no se dispara.** Decisión de diseño, no veredicto: las celdas de
  d ≥ 0,27 µm y la celda sin unión **no se leen una a una con este puesto**; con el modelo del PDK darían fA. Se quedan en
  el bus como controles de "aquí no hay túnel": si alguna da nA, eso ya es el resultado. Leerlas de verdad (fA) pide el
  lector sensible, y es otra pieza. *La revertiría* un lector de fA con nodo propio que quepa.

## Qué explicación aburrida no descarté

- Que el `nfet_01v8` del modelo no describa bien la fuga de subumbral y de unión a fA: todo el punto 3 y 4 cuelga de eso.
- Que la forma real de la corriente de la unión con la tensión no esté entre lineal y cúbica.
- Que las pasadas 1 y 2 fallaran por algo más que el resolvedor (no diagnostiqué; el barrido forzado lo esquiva).
- Por qué ngspice no escala el área del diodo, y si otras versiones lo hacen (entonces `area=1.4` sería el error contrario).
- La caída en el pozo y en los contactos (el modelo trae 981 Ω·µm² de serie; con 10 µA son milivoltios, aritmética).

## Regenerar

Los barridos crudos (`op_*/f_*.txt` y los de `pasada3/`, 42 MB) no se versionan; no se borran del disco. Se rehacen con
`python gen.py && bash corre.sh && python equilibrio.py && python analiza.py > m15.txt` (unos 7 minutos). Los equilibrios
(`op_*/k.txt`), los decks y los logs sí están en el repo.
