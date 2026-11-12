#!/usr/bin/env python3
# SPDX-License-Identifier: Apache-2.0
"""Writes cells/catalogue.json from the table in cells/CATALOGUE.md, so that the catalogue can be read by programs.
The Markdown table stays the single source; run this after editing it. Exits non-zero if the JSON on disk is stale (--check)."""
import json, os, sys
root = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..")
rows = []
for line in open(os.path.join(root, "cells", "CATALOGUE.md")):
    c = [x.strip() for x in line.strip().strip("|").split("|")]
    if len(c) == 8 and c[0].startswith("XC-"):
        rows.append(dict(id=c[0], family=c[1], mechanism=c[2], engine=c[3], vehicle=c[4],
                         usefulness=c[5] or None, information=c[6] or None, state=c[7]))
ids = [r["id"] for r in rows]
assert ids == [f"XC-{i:02d}" for i in range(1, len(ids) + 1)], "identifiers must be consecutive and never reused"
text = json.dumps(rows, indent=1, ensure_ascii=False) + "\n"
path = os.path.join(root, "cells", "catalogue.json")
if "--check" in sys.argv:
    sys.exit(0 if os.path.exists(path) and open(path).read() == text else "cells/catalogue.json is stale: run tools/catalogue_json.py")
open(path, "w").write(text)
print(f"{len(rows)} families written")
