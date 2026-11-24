# XC-19 · simulador de discriminación · resultados de la enmienda 4: ninguna fila decide

Escrito el 2026-11-24 (`date`: 10:54 EST). Entradas: [`humo_ea4.txt`](humo_ea4.txt), [`humo_eb2.txt`](humo_eb2.txt),
[`ea4.txt`](ea4.txt) / [`ea4.json`](ea4.json). Enmienda sellada a las 09:50:32 (SHA en `PREREG_SHA256.txt`).

## 1. Veredicto, con las palabras de la enmienda

- **A4.6:** con E_B v2, T2 del humo da **0,719 [0,630, 0,811]** del techo con λ0 desconocido (prior), por debajo de 0,80.
  **Se para.** E_B v2 no corrió la corrida larga, y por la regla de la enmienda no hay más revisiones de estimador en esta sesión.
- **Fila que decide** (|E_A − E_B| ≤ 0,05 bits): **ninguna**, porque no hay E_B v2 fuera de T1 y T2.
- **PD6, PD7, PD8 y M5:** sin veredicto. Lo que sigue en §3 es exploración.

## 2. Lo aburrido primero: un hueco de E_A que no se declaró

- **E_A nunca aplicó el prior de λ0.** El prerregistro (b6) dice que λ0 es log-uniforme entre λ_PDK/10 y 10·λ_PDK. Ni
  `run_ea.py` (v2) ni `run_ea4.py` (v3) pasan `rho_scale` a `sim.simulate`, así que **los dos simulan con λ0 fijo**.
  - El hueco viene de la corrida del 2026-11-23, y entonces tampoco se declaró.
  - Lo encontré al cotejar el informe de E_B v2, que sí separa "prior" y "fijo".
- Consecuencia: el T2 de E_A v3 (0,977 en el humo, 0,980 en la corrida larga) es comparable al T2 **fijo** de E_B v2 (1,000), no
  al T2 prior (0,719). Con λ0 fijo los dos estimadores pasan T2. Con el prior, solo hay número de E_B, y falla.
- **Todo D1, D2 y D4 de abajo está calculado con λ0 fijo.** Es optimista frente a lo que el prerregistro pide.
- **Pendiente de Juan:** con cuál de los dos se juzga T2. Si se cambia, va en una enmienda nueva con semillas nuevas.

## 3. Observado con E_A v3 y λ0 fijo (exploración, no decide)

**Controles.**

| Control | Resultado |
|---|---|
| T1 | detección 1,000; falsos 0,0005; pasa |
| T2 (λ0 fijo) | 0,980 del techo [0,962, 0,994] |
| M1 (amplitudes ×0) | D1 0,0017 bits; D2 0,0001 bits |
| M4 (las mismas trampas en B) | detección 0,003 |
| M5 (umbral ×100) | D1 y D2 = 0,0000 bits (≤ 0,02 como se predijo) |

**D1, tt S, con BT frente a BR.** Los falsos positivos son 0,423 con BT y 0,417 con BR. PD6 pedía que bajaran al menos a la mitad
con BR: con E_A no bajan.
- Explicación aburrida: "falso" aquí es un dispositivo **sin trampa en banda** detectado. Las trampas rápidas, fuera de banda,
  también dan saltos, y esas están en el DUT, no en B. Así que el gemelo no es la fuente principal de falsos de E_A v3. `[?]`
  cuánto pesa cada una: no se separó.

**D1 a ff 85.** Detección 1,0 y falsos 1,0, con y sin cuantización: el detector está saturado a ff 85, y todo dispositivo da
J ≥ 2. Es coherente con que la unidad de esa esquina es menor que una cuenta (paso de trampa ~0,8 cuentas en el contrato a2),
pero `[?]` si es el ruido de cuantización o el de B el que cruza 0,5·u_c. No se miró.

**D2 por clase, tt S.**

| Clase | BT, bits (fracción del techo) | BR, bits (fracción) |
|---|---|---|
| A1 (R = 16) | 0,414 (0,49) | 0,603 (0,71) |
| A2 (R = 8) | 0,181 (0,21) | 0,393 (0,46) |
| A4 (R = 4) | 0,004 | 0,008 |
| A8 (R = 2) | 0,004 | 0,091 |

- Cae de golpe entre A2 y A4 en todas las esquinas. Conjetura sin comprobar: con amplitud media ÷A por trampa, a A ≥ 4 casi
  ningún salto supera 0,5·u_c.
- A8 BR por encima de A4 BR (0,091 frente a 0,008) no es monótono. `[?]`: no se buscó la causa.

**D4, curva de potencia (A1, R = 16, tt S).**

| f | techo | BT, bits (fracción) | BR, bits (fracción) |
|---|---|---|---|
| 1,5 | 0,181 | 0,049 (0,27) | 0,097 (0,54) |
| 2 | 0,477 | 0,168 (0,35) | 0,230 (0,48) |
| 3 | 0,850 | 0,420 (0,49) | 0,652 (0,77) |

- Los bits crecen con f, en BT y en BR.
- PD7 tal como está escrita ("la fracción del techo crece con f") no se cumpliría en BR: 0,54 → 0,48 entre f = 1,5 y 2.
- PD7b (f = 3, BR, ≥ 0,60 del techo): 0,77.
- PD8 (f = 1,5, bits ≤ 0,10): 0,049 en BT; 0,097 en BR, con IC hasta 0,123.
- **Nada de esto es veredicto:** no hay E_B v2 y λ0 está fijo.

**Lectura para C1–C6 (conjetura, con el [anexo](ANEXO_C1_C6_bibliografia.md)).**
- Con λ0 fijo y BR, un factor 3 entre clases daría ~0,65 bits por chip. Un factor 1,5 daría ~0,1.
- C2 (f entre 0,1 y 1 según la literatura) sería visible solo si f_C2 ≲ 1/2, y eso **antes** de pagar el λ0 desconocido, que en
  E_B cuesta ~28 % del techo en T2.

## 4. Qué sigue (sin correr)

1. Decidir prior o fijo para T2 (Juan).
2. Aplicar `rho_scale` con el prior b6 en E_A, en una enmienda 5, y volver a correr con semillas nuevas.
3. E_B v2 con el prior es el único número que mide la pérdida por λ0 desconocido. Una revisión de E_B queda para otra sesión
   (A4.6).

**¿Qué explicación aburrida no descarté?** Que la pérdida de T2 con el prior en E_B sea de su regresión (umbral de una sola
variable) y no del λ0 en sí. E_A con el prior no se ha corrido, así que no hay segundo estimador que lo separe.
