# v4o — números propios del verificador, fijados ANTES de leer nada del agente (salvo los d*_PREREG.md)

Hora de `date` al escribir este archivo (mismo comando): **Fri Nov 13 08:15:07 EST 2026**.
Leído hasta aquí: encargo, d21/d26/d27_PREREG.md, cells/notas/DATOS_PROCESO.md, cells/xc26_optical_link/PLAN.md, cells/xc27_hole_arrays/PLAN.md (grep),
05_exotic_lab/macros/photon/{LEEME.md, comun.tcl, emisor.tcl}, modelos del PDK local (pnp_05v5, diode_ps2nw, ps2dn, pd2nw_05v5).
Externo: tabla α de Green & Keevers 1995 en pveducation.org (WebFetch); búsqueda web de Nguyen 2014 (no confirmó el valor de B).
NO leído: d*.py, d*.txt, d*.json, d*_INFORME.md del agente.

Código: v4o_grid.py (VF 3D, control contra semiesfera: P y R con error ≤ 7–12 %, v4o_test_grid.txt), v4o_alpha.py, v4o_coleccion.py,
v4o_sustrato.py, v4o_eta.py, v4o_presupuesto.py, v4o_tapa.py, v4o_ruptura.py. Salidas: *.txt / *.json homónimos.

## 1. F (XC-26), geometría de macros/photon, profundidades [?] barridas
- ⟨α⟩ por número de fotones (Planck generalizado con α de Green-Keevers): **16,2 cm⁻¹** (pico 1130 nm; mediana 3,1). Si la emisión sale
  del p+ con estrechamiento de banda 0,03/0,06/0,10 eV: 9,1 / 4,9 / 2,0 cm⁻¹.
- F base (L=100 µm, fondo sumidero a 250 µm, DNW 2,5 µm, pozo 1 µm, anillo DNW del marco): **2,45e-3 / 1,70e-3 / 9,7e-4** a d=5/10/20; control
  (44,4 µm) 4,4e-4 → control/F(5) = 0,18.
- Intervalo de escenarios (L 30–1000 µm, fondo a 10 µm [epi sobre p+, hipótesis] o 250–600 µm, DNW 1,5–3,5 µm):
  d=5: 1,4e-3 … 2,7e-3; d=10: 7,2e-4 … 2,0e-3; d=20: 2,1e-4 … 1,25e-3; control/F(5): 0,03 … 0,25.
- Factores escondidos: espejo de la superficie (reflexión total) ×1,87; emisión desplazada por BGN 0,06 eV ×0,31; sin anillo DNW ×2,5.
- Comprobación independiente por rayos (v4o_tapa.py): F(5) = 2,44e-3 (frente a 2,45e-3 por volumen).

## 2. Sustrato (huecos del PNP vertical → taps), ρ = 10 Ω·cm homogéneo, solo el anillo p+ del photo como tap
- R (equipotencial … media bajo el pozo): d=5 **12,6 … 15,6 kΩ**; d=10 14,3 … 17,3; d=20 15,7 … 18,6. Lineal en ρ: ρ=1 → 1,3–1,6 kΩ; ρ=20 → 25–31 kΩ.
- Con guarda (e05g): 3,0 … 8,0 kΩ; con taps lejanos a masa: 6,3 … 9,4 kΩ.
- Con capa p de 1 µm a 0,2 Ω·cm en superficie [?]: 0,50…0,91 / 0,80…5,7 / 0,85…10,9 kΩ (ρ = 1/10/20) — no lineal en ρ.
- Umbral de corriente (mi criterio: electrones inyectados por el pozo y recogidos, P_e=0,13, igualan la señal óptica con η=1e-6; I_inj de dos
  lecturas del PDK que difieren ~4 órdenes): con pozo a 0 V, ρ=10, d=5: **0,02–0,06 mA**; ρ=1: 0,25–0,6 mA; ρ=20: 0,010–0,027 mA.
  Con el pozo a +1,0 V (limitador en el lado bajo): ×4–5.

## 3. η
- Base (PDK: TF 0,615 ns): TF·B·N_D = 1,4e-7 … 1,8e-6 (N_D 5e16–3e17, B 4,7–9,5e-15 de memoria); ×(2,7–4,6) a 0,17 mA y ×(11–22) a 1 mA por alta inyección (IKF escalado 47–100 µA).
- Emisor p+: 2e-7 … 1,6e-5 (fotones desplazados al rojo). Total: **~1e-7 … ~2e-5**, centro ~1e-6.

## 4. Fotocorriente (η=1e-6, F base; lineal en η)
- ρ=10, d=5: **0,05–0,13 pA** con pozo a 0 V; 0,22–0,35 pA con pozo a +1 V; con guarda 0,10–0,59 / 0,44–1,5 pA.
- ρ=1, d=5: 0,6–1,5 pA (0 V) … 2,3–3,6 pA (+1 V); con guarda hasta 6,5 / 15 pA; capa p: 1,1–3,9 / 4–9 pA.
- ρ=20, d=5: 0,02–0,07 pA (0 V) … 0,11–0,17 pA (+1 V).

## 5. Tapa (XC-27), espejo infinito a 1,376 µm
- Cono de escape: 3,4 % de los fotones salen (con Fresnel); su parte de lo recogido si volvieran: **3,0 %**.
- Tapa lisa: **+1,2 % (Rm 0,5) … +2,3 % (Rm 0,95)**. Redes: no calculado (sin RCWA) — acotado por el cono, ≲ 3 %.

## 6. Ruptura (XC-21), integral de ionización local (vOdM), control plana: 55 V a 1e16, 14,8 V a 1e17
- Plana con n+ a 0,27 µm: −78 % (1e16), −56 % (3e16), −41 % (5e16), **−17 % (1e17)**, 0 % (≥2e17); valor absoluto ≥ 10,7 V siempre.
- Esquinas r_j 0,1–0,2 µm, N 1e17–5e17: cilíndrica 7,0–11,5 V; esférica **6,6–9,6 V**. Calibrado a bv PDK 12,69 V (N=1,4e17): 8,0–10,4 V.

## 7. Control y anillo
- Control 44,4 µm / emisor 5 µm: 0,18 base (0,03–0,25).
- Quitar el anillo DNW del marco: luz ×2,5 (anillo → **×0,40**); electrones inyectados bajo el emisor P_e 0,236 → 0,130 (anillo → **×0,55**).
