#!/bin/bash
# MISFIT-28, enmienda 2: repite sin cambios, con tope 43200 s, los decks de e1/ que acabaron en 'salida 124' (tope de 14400 s).
# El log cortado se conserva como lec_tope14400.log. Vigila hasta que acabe la tanda principal (e1/corre.out con 'fin').
# El .spiceinit que deja el corte es la copia temporal del spinit del PDK (se comprueba con cmp antes de quitarla).
cd "$(dirname "$0")"; SPI=/Users/juancarlosromero/made-in-TaiJuan/projects/ZTASIC/local_flow/pdk_host/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71/sky130A/libs.tech/ngspice/spinit
una(){ d=$1; [ -e $d/.spiceinit ] && cmp -s $d/.spiceinit $SPI && rm $d/.spiceinit; TOPE=43200 PAR=1 ./corre.sh $d | cut -c1-100; }
while :; do
  for d in e1/*/*/; do
    if [ -e $d/lec.log ] && [ "$(tail -1 $d/lec.log)" = "salida 124" ] && [ ! -e $d/lec_tope14400.log ]; then mv $d/lec.log $d/lec_tope14400.log; touch $d/.lanzado; una $d & fi
    if [ ! -e $d/lec.log ] && [ -e $d/lec_tope14400.log ] && [ ! -e $d/.lanzado ]; then touch $d/.lanzado; una $d & fi
  done
  grep -q "^fin " e1/corre.out && break; sleep 120
done; wait; echo "fin $(date '+%Y-%m-%d %H:%M:%S %Z')"
