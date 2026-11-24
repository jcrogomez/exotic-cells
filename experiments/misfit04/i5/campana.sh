#!/bin/sh
# MISFIT-04 I5: chequeos estandar (DRC del GDS releido, LVS contra referencias fijas, precheck de Tiny Tapeout) por sabotaje.
# Uso: campana.sh V [V ...]   (V en ok S1..S10). Cada uno en build_V/; precheck en local_flow/misfit04_tile_V/. Resumen: estandar.tsv
set -e
I5=$(cd "$(dirname "$0")" && pwd); EC=$(cd "$I5/../../.." && pwd); LF=$(cd "$EC/../local_flow" && pwd)
export SKY130A=$LF/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A
export TTDEF=$LF/tt-support-tools/tech/sky130A/def/tt_block_1x2_pg.def
for V in "$@"; do
  B=$I5/build_$V; rm -rf "$B"; mkdir -p "$B"
  case $V in S9|S10) F=$LF/misfit04_core_$V/runs/core/final ;; *) F=$LF/misfit04_core/runs/core/final ;; esac
  cp $F/gds/misfit04_core.gds $F/lef/misfit04_core.lef $F/pnl/misfit04_core.pnl.v "$B/"
  case $V in S3|S4) export WRAPGDS=$I5/wrap_$V/xc19_slot_w.gds ;; *) unset WRAPGDS ;; esac
  AV=$V; case $V in S3|S4|S9|S10) AV=ok ;; esac
  r=$("$EC/instrument/misfit04/tile/lvs.sh" "$B" "$AV" 2>&1 | tail -1)
  drc=$(grep -o 'violations=[0-9]*' "$B/extract.txt" | head -1 | cut -d= -f2)
  lvs=$(grep -q "Circuits match uniquely" "$B/lvs.rpt" && echo match || echo MISMATCH)
  D=$LF/misfit04_tile_$V; rm -rf "$D"; mkdir -p "$D/tt_submission"
  cp "$LF/misfit04_tile/info.yaml" "$D/"; cp "$B/tt_um_misfit04.gds" "$B/tt_um_misfit04.lef" "$D/tt_submission/"
  cp "$EC/instrument/misfit04/tile/top_ref.v" "$D/tt_submission/tt_um_misfit04.v"
  docker run --rm -v tt_nixstore:/nix -v $LF:$LF -w $LF/tt-support-tools/precheck -e PDK_ROOT=$LF/pdk_precheck -e PDK=sky130A \
    -e PATH=/nix/store/vh04crlv3qbvpb9bfp4z9rx3pzki8bpk-klayout-0.30.8/bin:/nix/store/6l3292h1mpwmjcqrjmlmrk6mby92hy28-magic-vlsi-8.3.568/bin:/usr/local/bin:/usr/bin:/bin \
    tt-precheck-local:ttsky26d python precheck.py --gds $D/tt_submission/tt_um_misfit04.gds --tech sky130A > $D/precheck.log 2>&1 && pc=pasa || pc=FALLA
  cp "$LF/tt-support-tools/precheck/reports/results.md" "$B/precheck_results.md" 2>/dev/null || true
  fails=$(grep "❌" "$B/precheck_results.md" 2>/dev/null | cut -d'|' -f2 | tr -s ' ' | paste -sd, -)
  printf "%s\t%s\t%s\t%s\t%s\t%s\n" "$V" "$drc" "$lvs" "$pc" "$fails" "$(date +%H:%M:%S)" | tee -a "$I5/estandar.tsv"
done
