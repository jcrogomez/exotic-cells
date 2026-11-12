#!/bin/bash
# SPDX-License-Identifier: Apache-2.0
# Writes the environment of a run as JSON: repository commit, tools image digest, PDK commit, tool versions.
#   tools/manifest.sh <path to sky130A> > experiments/manifest_<date>.json
IMG=hpretl/iic-osic-tools:2025.07
PDK=$1
V=$(docker run --rm $IMG --skip bash -c 'echo "ngspice=$(ngspice --version | grep -o "ngspice-[0-9.]*" | head -1)"; echo "magic=$(magic --version)"; echo "klayout=$(klayout -v)"' 2>/dev/null | grep -E "^(ngspice|magic|klayout)=")
cat <<JSON
{
  "written": "$(date "+%Y-%m-%d %H:%M %Z")",
  "repository_commit": "$(git rev-parse HEAD)",
  "tools_image": "$IMG",
  "tools_image_id": "$(docker image inspect $IMG --format '{{.Id}}')",
  "tools_image_digest": "$(docker image inspect $IMG --format '{{index .RepoDigests 0}}' 2>/dev/null)",
  "pdk": "sky130A",
  "pdk_commit": "$(basename $(dirname $PDK))",
  "ngspice": "$(echo "$V" | grep "^ngspice=" | cut -d= -f2)",
  "magic": "$(echo "$V" | grep "^magic=" | cut -d= -f2)",
  "klayout": "$(echo "$V" | grep "^klayout=" | cut -d= -f2)",
  "host": "$(uname -sm)",
  "seeds": "ngspice rndseed=20261111 where a deck sets it; Python random.Random(20261111 + offset) in detect.py",
  "temperature_and_tolerances": "stated in each deck (.temp, .options)"
}
JSON
