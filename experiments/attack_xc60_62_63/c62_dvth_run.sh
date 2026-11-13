#!/bin/bash
HERE="$(cd "$(dirname "$0")" && pwd)"
docker run --rm -v "$HERE":/work hpretl/iic-osic-tools:2025.07 --skip bash -c 'cd /work; cp /foss/pdks/sky130A/libs.tech/ngspice/spinit .spiceinit 2>/dev/null; ngspice -b c62_dvth.sp > c62_dvth.log 2>&1; rm -f .spiceinit' 2>&1 | grep -v "^\[INFO\]"
date
