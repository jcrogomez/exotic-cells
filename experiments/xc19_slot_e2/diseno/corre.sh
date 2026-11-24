#!/bin/sh
# MISFIT-03 enmienda 2, diseno: el contrato de la etapa a sobre el macro v_hm (inversor hvt + unidad MOS), de dos en dos
cd "$(dirname "$0")"
run(){ mkdir -p corridas/$1; cp $1.sp corridas/$1/; docker run --rm -v $PWD/corridas/$1:/w -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/06_exotic_cells/tools:/t:ro -v /Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A:/pdk:ro hpretl/iic-osic-tools:2025.07 --skip bash -c "cd /w && sh /t/ngspice_pdk.sh $1.sp > $1.log 2>&1" >/dev/null 2>&1; }
echo "inicio $(date +%H:%M:%S)"
run contrato_tt_27 & run contrato_ff_-40 & wait
run contrato_ss_85 & run contrato_ff_85 & wait
run largo_tt_27 & run largo_ff_-40 & wait
run largo_ss_85 & run largo_ff_85 & wait
echo "fin $(date +%H:%M:%S)"
grep -h "^RES" corridas/*/*.log > contrato.txt; wc -l < contrato.txt
